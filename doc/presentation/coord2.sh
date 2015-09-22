#!/bin/sh

x=0
y=0
z=0
for i in `echo $1 | sed 's/\(.\)/ \1/g'`; do
  echo $x $y $z
  if [ "$i" == "0" ]; then
    x=$((x + 1))
  else
    if [ "$i" == "1" ]; then
      y=$((y + 1))
    else
      z=$((z + 1))
    fi
  fi
done
