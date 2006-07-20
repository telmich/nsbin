PROFIL=$1

[ $# -eq 1 ] || exit 23

ln -fs ~/.ssh/known_hosts.$PROFIL ~/.ssh/known_hosts
