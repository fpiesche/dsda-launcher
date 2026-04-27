# Intructions for compiling dsda-launcher for Linux


## Qt - https://www.qt.io/download
```
All commits tested using qt6.2.0 on the latest ubuntu

You could also install qt using your prefered package manager
```

## Compiling

```bash
# clone the repository
git clone https://github.com/Pedro-Beirao/dsda-launcher.git  
# enter your local copy
cd dsda-launcher
# configure the build to find dependencies etc.
cmake -B build -G Ninja .
# compile dsda-launcher
cmake --build build
```

This will configure the build to run using the Ninja build system for
automatic use of multiple CPU cores etc. If you don't have Ninja available,
simply run `cmake -B build .` instead to configure without it.


## Installing or packaging

To install a build made using the above instructions, simply run
`cmake --install build`. You can customize the installation directory
by using the `-DCMAKE_PREFIX` variable when configuring; e.g. to
configure, build and install dsda-launcher to your local user directory
in `~/.local/bin/dsda-launcher`:

```bash
git clone https://github.com/Pedro-Beirao/dsda-launcher.git
cd dsda-launcher
cmake -B build -G Ninja -DCMAKE_PREFIX=~/.local
cmake --build build
cmake --install build
```


## Distributing

To make creating distributions easier, CPack is also configured by the
CMake setup. By default, this will create a `.zip` and a `.tar.gz` archive
of the compiled build, an `AppImage` and a system package for Ubuntu/Debian
or Fedora if the build is run on one of these systems.

After compiling:

```bash
cd build
cpack
```

This will generate all default options and copy them to `build/dist/`.
You can customize which packages to create by running `cpack -G [generators]`
instead, e.g. `cpack -G External` to build only the AppImage or
`cpack -G DEB` to only create a Debian/Ubuntu package.
