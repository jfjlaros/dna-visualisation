#!/bin/sh

read < $1
old=$REPLY
while read; do
  echo "    addLine($old, $REPLY);"
  old=$REPLY
done < $1
