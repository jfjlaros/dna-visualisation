#!/bin/sh

output="DNAvis.hx"

cp $output.1 $output
cat $1 >> $output
cat $output.2 >> $output
