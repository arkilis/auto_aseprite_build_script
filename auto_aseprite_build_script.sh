!/usr/bin/bash

# install Ninja
brew install ninja


# install cmake
brew install cmake

# install Skia
cd $HOME
mkdir $HOME/deps
cd $HOME/deps
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
git clone https://github.com/aseprite/skia.git
export PATH="${PWD}/depot_tools:${PATH}"
cd skia
git checkout aseprite-m62
python tools/git-sync-deps
gn gen out/Release --args="is_official_build=true skia_use_system_expat=false skia_use_system_icu=false skia_use_system_libjpeg_turbo=false skia_use_system_libpng=false skia_use_system_libwebp=false skia_use_system_zlib=false"
ninja -C out/Release


# install aseprite
cd aseprite
mkdir build
cd build
cmake \
  -DCMAKE_OSX_ARCHITECTURES=x86_64 \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=10.7 \
  -DCMAKE_OSX_SYSROOT=`xcrun --sdk macosx --show-sdk-path` \
  -DUSE_ALLEG4_BACKEND=OFF \
  -DUSE_SKIA_BACKEND=ON \
  -DSKIA_DIR=$HOME/deps/skia \
  -DWITH_HarfBuzz=OFF \
  -G Ninja \
  ..

# run aseprite
ninja aseprite
