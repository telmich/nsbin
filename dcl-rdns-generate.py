#!/usr/bin/env python3

import ipaddress
import sys

def hexstr2int(string):
    return int(string.replace(':', ''), 16)

FIRST_MAC = hexstr2int('02:00:b3:39:79:4d')
FIRST_V4  = ipaddress.ip_address('185.203.112.2')
FIRST_V6 =  "2a0a:e5c0:0:2:400:b3ff:fe39:794d"

V6_NAT64_BASE = ipaddress.ip_address("2a0a:e5c0:0:1:0:1::")

def v4_from_mac(mac):
    """Calculates the IPv4 address from a MAC address.

    mac: string (the colon-separated representation)
    returns: ipaddress.ip_address object with the v4 address
    """
    return FIRST_V4 + (hexstr2int(mac) - FIRST_MAC)

def v4_from_v6(ipv6ip):
    """Calculates the IPv4 address from the IPv4 address

    ipv6ip: the ip
    returns: ipaddress.ip_address object with the v4 address
    """

    return FIRST_V4 + (hexstr2int(ipv6ip) - (hexstr2int(FIRST_V6)))

def v6_from_v4(ipv4):
    v4addr = ipaddress.ip_address(ipv4)
    return V6_NAT64_BASE + int(v4addr)

if __name__ == "__main__":
    first_addr = ipaddress.ip_address(sys.argv[1])
    last_addr = ipaddress.ip_address(sys.argv[2])

    while True:
        addr = first_addr.reverse_pointer
        name = "{}.place5.ungleich.ch".format(str(first_addr).replace(":",""))
        record = "{}. IN PTR {}.".format(addr, name)

        print(record)

        if first_addr == last_addr:
            break

        first_addr += 1

    sys.exit(0)

    out = []

    try:
        out.append(v4_from_v6(addr))
    except:
        pass

    try:
        out.append(v6_from_v4(addr))
    except:
        pass


    print("{}".format(out))

# test.ch
# 2a0a:e5c0:0:1:0:1:504a:8a8c
# 80.74.138.140
# 1347062412
#
