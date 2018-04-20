Aseprite is a famous 2D pixel art tool that allow you to create 2D animations, sprites, and any kind of graphics for games. It is not free, you can get a copy from Steam for USD $14.99. http://store.steampowered.com/app/431730/Aseprite/. However, it is open sourced on github, you can create a build by yourself at anytime. This article will show you how to compile and build a copy by yourself and save $14.99.


`OS`: MacOS 10.12.6. On Aseprite's system recommendation, it says `macOS 10.12.6 Sierra + Xcode 9.0 + macOS 10.13 SDK + Skia`.
Require `Xcode 9` and `Xcode command line tool` installed


#### Step1: Download source code to your mac

```bash
git clone --recursive https://github.com/aseprite/aseprite.git
```

#### Step2: Install dependency: Ninja

Build tool `Ninja` is required, you can have a look at its details at [https://ninja-build.org/](https://ninja-build.org/). On Mac, I would recommend to use the following command line to install it. Open your `Terminal`:

```bash
brew install ninja
```

#### Step3 : Install dependency: Cmake

makefile manage tool that used to create `makefile`
```bash
brew install cmake
```


#### Step 4: Install Skia

Skia is a complete 2D graphic library for drawing Text, Geometries, and Images. [https://skia.org](https://skia.org)

```bash
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
```

#### Final Step: Compile and build

```bash
cd aseprite
mkdir build
cd build
cmake \
  -DCMAKE_OSX_ARCHITECTURES=x86_64 \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=10.7 \
  -DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk \
  -DUSE_ALLEG4_BACKEND=OFF \
  -DUSE_SKIA_BACKEND=ON \
  -DSKIA_DIR=$HOME/deps/skia \
  -DWITH_HarfBuzz=OFF \
  -G Ninja \
  ..

ninja aseprite
```

Be careful about the path for OSX_SYS, everyone's Mac OSX SYS path could be slightly different. So in order to get that:

```bash
xcrun --sdk macosx --show-sdk-path
```

If no errors happen, now you could run `aseprite` by `./aseprite`.



### Reference
[http://www.arkilis.me/?p=1064](http://www.arkilis.me/?p=1064)






