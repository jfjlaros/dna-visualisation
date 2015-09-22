#!/bin/sh

if ! [ -n "$3" ]; then 
  echo "Usage: $0 <length> <input> <output> <skip>"
  exit 1
fi

rand=/tmp/.dnavis_$RANDOM
t1=${rand}_1
t2=${rand}_2

./dnavis $2 $1 $4 > $t1 2> $t2
cat << EOF | gnuplot
set style data lines
load "$t2"
set terminal postscript
set output "$3"
plot "$t1" notitle
EOF

rm $t1 $t2
