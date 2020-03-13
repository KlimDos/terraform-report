#!/bin/bash -xe

cd in
for file in *.report
do
 pwd
 cat "$file" | ../tools/ansi2html.sh > ../out/"$file".html
done