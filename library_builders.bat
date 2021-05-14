set CURRENTDIR="%cd%"

:: BUILD_PREFIX="${BUILD_PREFIX:-/usr/local}"
set CPU_COUNT="2"

echo "CFLAGS: %CFLAGS%"
echo "CXXFLAGS: %CXXFLAGS%"
echo "LDFLAGS: %LDFLAGS%"

goto:main

:install_buildessentials
  python -m pip install --upgrade pip setuptools wheel
  python -m pip install --upgrade ninja
  python -m pip install --upgrade scikit-build
  python -m pip install --upgrade "patch==1.*"
exit /b 0

:main
call :install_buildessentials
