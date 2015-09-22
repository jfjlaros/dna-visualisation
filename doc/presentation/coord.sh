#!/bin/sh

x=0
y=0
for i in `echo $1 | sed 's/\(.\)/ \1/g'`; do
  echo $x $y
  if [ "$i" == "a" ]; then
    x=$((x + 1))
  else
    y=$((y + 1))
  fi
done
