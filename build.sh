#!/bin/sh
mkdir -p build

for i in $(seq 0 11); do
  openscad keycap.scad -o "build/key_${i}.stl" -D "range = [${i}]"
done

cp source/Keycap.stl build/keycap.stl
openscad keycap.scad -o "build/all.stl" -D "range = [0 : 11]"
