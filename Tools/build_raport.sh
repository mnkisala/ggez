#!/bin/sh

./Tools/optimize_assets.sh
rm -rf build
mkdir build
godot -v --no-window --export HTML5 build/index.html
godotpcktool build/index.pck -a e -o build/ex
cd build/ex
python3 ../../Tools/durep.py > /tmp/raport.html
