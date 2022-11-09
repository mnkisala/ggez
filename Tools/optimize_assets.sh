#!/bin/sh

# build smolinator
cd ./Tools/smolinator
cargo build --release
cd ../../

# cleanup
rm -rf .import
find . -name "*.material" -type f -delete

# smolnify assets
for ass in `find . -name "*.glb" -type f`; do
  prev=$(du -h $ass)
  ./Tools/smolinator/target/release/smolinator --input $ass --max-texture-dimensions 256 --texture-quality 40 --output /tmp/smol.gltf && gltfpack -i /tmp/smol.gltf -o $ass
  echo optimizied \'$ass\' from $prev to $(du -h $ass)
done
