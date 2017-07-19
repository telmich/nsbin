DIR="$1"
DEST="$2"
hier="/home/server/git/$DIR/"
there="git.schottelius.org:/home/server/git/$DEST"

echo "$hier to $there?"
read bar


rsync -av "$hier" "$there"
   

echo "ok?"
read foo
echo rm -rf "$hier"
