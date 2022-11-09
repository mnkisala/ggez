#!/bin/sh

# build meshoptimizer (just gltfpack tho)
cd ./Tools

curl http://archive.ubuntu.com/ubuntu/pool/universe/m/meshoptimizer/meshoptimizer_0.17+dfsg.orig.tar.xz > meshoptimizer-0.17.tar.xz
tar -xvf ./meshoptimizer-0.17.tar.xz

cd meshoptimizer-0.17
make gltfpack
cd ..

# build smolinator
cd ./smolinator
cargo build --release
cd ../../

# cleanup
rm -rf .import
find . -name "*.material" -type f -delete

# smolnify assets
for ass in `find . -name "*.glb" -type f`; do
  prev=$(du -h $ass | cut -f 1)
  ./Tools/smolinator/target/release/smolinator --input $ass --max-texture-dimensions 512 --texture-quality 80 --output /tmp/smol.gltf && ./Tools/meshoptimizer-0.17/gltfpack -i /tmp/smol.gltf -o $ass
  rm -f /tmp/smol.gltf
  echo optimized \'$ass\' from $prev to $(du -h $ass | cut -f 1)
done

for ass in `find . -name "*.gltf" -type f`; do
  prev=$(du -h $ass | cut -f 1)
  ./Tools/smolinator/target/release/smolinator --input $ass --max-texture-dimensions 512 --texture-quality 80 --output /tmp/smol.gltf && ./Tools/meshoptimizer-0.17/gltfpack -i /tmp/smol.gltf -o $ass
  rm -f /tmp/smol.gltf
  echo optimized \'$ass\' from $prev to $(du -h $ass | cut -f 1)
done
