[![Build Status](https://travis-ci.org/bobrofon/build-universe.svg?branch=master)](https://travis-ci.org/bobrofon/build-universe) [![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/bobrofon/build-universe/blob/master/LICENSE)
# build-universe
Build environement for standalone elf binaries.
# Supported architectures
* arm
* i686

# How to use
## Build docker container for build environment
```
$ ./build.sh arm
```
## Activate environment
```
$ . activate.sh arm
```
Now you can run commands in build environment using 'run'.
```
$ gcc --version
gcc (GCC) 6.2.1 20160916 (Red Hat 6.2.1-2)

$ run gcc --version
gcc (crosstool-NG crosstool-ng-1.22.0) 5.2.0
```
# Dependencies
* [Docker](https://www.docker.com)
