# More Wheels for CMake

This repository demonstrates how to use [cibuildwheel](https://github.com/joerick/cibuildwheel) and public CI as continuous deployment pipeline to PyPA.

The currently available binary wheels on [pypi.org/project/cmake](https://pypi.org/project/cmake/#files) are unfortunately limited to mainly x86 builds.
Although [an efforts was made](https://github.com/scikit-build/cmake-python-distributions/issues/96) to provide e.g. ``aarch64`` binaries, it emerges that [the current deployment strategy](https://github.com/scikit-build/cmake-python-distributions) is too complex to address urgently needed wheel platforms, namely:

- macOS for ARM (Apple Silicon aka M1/M2)
- Linux ppc64le binaries for HPC systems
- Linux aarch64 (arm64) binaries for Cloud systems (and HPC systems)

Public cloud infrastructure such as Travis-CI provides resources for natively building Linux binaries for `arm64`, `ppc64le` and `s390x`.
Drone.io also provides native `arm64` resources.

Lucky for us, [cibuildwheel](https://github.com/joerick/cibuildwheel) dramatically simplifies the process to build wheels on public CI and for various platforms, including cross-compiles for macOS on ARM.
