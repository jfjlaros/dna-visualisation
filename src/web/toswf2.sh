#!/bin/sh

mod=$2

read < $1
old=$REPLY
i=0
while read; do
  if [ $i -eq 0 ]; then
    echo "    addLine($old, $REPLY);"
    old=$REPLY
  fi
  i=$(((i + 1) % mod))
done < $1
