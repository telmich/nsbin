#!/bin/sh

if [ $# -lt 1 ]; then
    echo "$0 disk [fullsize]"
    exit 1
fi

set -x

export DEV=$1; shift
export ID=$(ceph osd create)

ceph-disk zap $DEV
ceph-disk prepare --bluestore $DEV --osd-id ${ID} --osd-uuid $(uuidgen) --crush-device-class hdd

mkdir /var/lib/ceph/osd/ceph-${ID}
mount ${DEV}1 /var/lib/ceph/osd/ceph-${ID}
touch /var/lib/ceph/osd/ceph-${ID}/sysvinit
ceph auth get-or-create osd.${ID} osd 'allow *' mon 'allow profile osd' > /var/lib/ceph/osd/ceph-${ID}/keyring
echo ${ID} > /var/lib/ceph/osd/ceph-${ID}/whoami
ceph-osd --cluster ceph -i ${ID} --mkfs
chown -R ceph:ceph /var/lib/ceph/osd/ceph-${ID}

SIZE_REAL=$(fdisk -l | grep ${DEV}2 | cut -d " " -f7 | sed 's/T//')

# Start with small data to get a feeling if disk really works
SIZE_FAKE=0.1

if [ $# -ge 1 ]; then
    SIZE=$SIZE_REAL
else
    SIZE=$SIZE_FAKE
fi


ceph osd crush add osd.${ID} ${SIZE} host=$(hostname)

/etc/init.d/ceph start osd.${ID}
