# Note: see Dockerfile in `dev` branch for recipes, too!
# see also https://github.com/matthew-brett/multibuild/blob/devel/library_builders.sh

set -eu -o pipefail

BUILD_PREFIX="${BUILD_PREFIX:-/usr/local}"
CPU_COUNT="${CPU_COUNT:-2}"

function install_buildessentials {
    if [ -e buildessentials-stamp ]; then return; fi

    # static libc, tar tool
    if [ "$(uname -s)" = "Linux" ]
    then
        yum check-update -y || true
        yum -y install    \
            glibc-static  \
            openssl-devel \
            tar

        # CMake 3.6.0+ required
        #CMAKE_FOUND=$(which cmake >/dev/null && { echo 0; } || { echo 1; })
        #if [ $CMAKE_FOUND -ne 0 ]
        #then
            curl -sLo cmake-3.17.5.tar.gz \
                https://github.com/Kitware/CMake/releases/download/v3.17.5/cmake-3.17.5.tar.gz
            tar -xzf cmake-*.gz
            cd cmake-*
            ./bootstrap                                \
                --parallel=${CPU_COUNT}                \
                --                                     \
                -DCMAKE_INSTALL_PREFIX=${BUILD_PREFIX}
            make -j${CPU_COUNT}
            make install
            cd ..
            rm cmake-*.tar.gz
        #fi
    fi

    touch buildessentials-stamp
}

# static libs need relocatable symbols for linking to shared python lib
# export CFLAGS+=" -fPIC"
# export CXXFLAGS+=" -fPIC"

install_buildessentials

python -m pip install -U pip setuptools wheel
python -m pip install -U scikit-build

echo "++++++++++++++++++++"
ls
echo "++++++++++++++++++++"
