#!/bin/sh


GIT_DIR=`git rev-parse --git-common-dir 2> /dev/null`

echo
echo

if [ "$GIT_DIR" == "" ]; then
  echo "This does not appear to be a git repo."
  exit 1
fi

if [ -f "$GIT_DIR/hooks/commit-msg" ]; then
  echo "There is already a commit-msg hook installed. Delete it first."
  echo
  echo "    rm '$GIT_DIR/hooks/commit-msg'"
  echo
  exit 2
fi

FILE=${1:-pre-commit}

echo "Downloading commit-msg hook from https://raw.githubusercontent.com/SharifClick/commit-msg/master/commit-msg"
echo

curl -fL -o "$GIT_DIR/hooks/commit-msg" "https://raw.githubusercontent.com/SharifClick/commit-msg/master/commit-msg"
if [ ! -f "$GIT_DIR/hooks/commit-msg" ]; then
  echo "Error downloading commit-msg script!"
  exit 3
fi

chmod +x "$GIT_DIR/hooks/commit-msg"

echo
echo "You're all set! Happy hacking!"

exit 0
