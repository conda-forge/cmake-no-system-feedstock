
if "%ARCH%"=="32" (set CPU_ARCH=x86) else (set CPU_ARCH=x64)
curl https://cmake.org/files/v%PKG_VERSION:~0,4%/cmake-%PKG_VERSION%-win%ARCH%-%CPU_ARCH%.zip -o cmake-win.zip
7z x cmake-win.zip > nil
set PATH=%CD%\cmake-%PKG_VERSION%-win%ARCH%-%CPU_ARCH%\bin;%PATH%
cmake --version

mkdir build && cd build

cmake -LAH -G Ninja                                          ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"                   ^
    -DCMAKE_CXX_STANDARD:STRING=17                           ^
    -DCMake_HAVE_CXX_MAKE_UNIQUE:INTERNAL=TRUE               ^
    -DCURL_USE_SCHANNEL:BOOL=ON                              ^
    -DCURL_WINDOWS_SSPI:BOOL=ON                              ^
    -DBUILD_CursesDialog:BOOL=ON                             ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ..
if errorlevel 1 exit 1

cmake --build . --target install --parallel %CPU_COUNT%
if errorlevel 1 exit 1
