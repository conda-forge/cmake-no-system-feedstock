
if "%ARCH%"=="32" (set CPU_ARCH=i386) else (set CPU_ARCH=x86_64)
curl https://cmake.org/files/v%PKG_VERSION:~0,4%/cmake-%PKG_VERSION%-windows-%CPU_ARCH%.zip -o cmake-win.zip
7za x cmake-win.zip > nil
set PATH=%CD%\cmake-%PKG_VERSION%-windows-%CPU_ARCH%\bin;%PATH%
cmake --version

cmake -LAH -G Ninja                                          ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%"                   ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"                ^
    -DCMAKE_CXX_STANDARD:STRING=17                           ^
    -DCURL_USE_SCHANNEL:BOOL=ON                              ^
    -DCURL_WINDOWS_SSPI:BOOL=ON                              ^
    -DBUILD_CursesDialog:BOOL=ON                             ^
    .
if errorlevel 1 exit 1

cmake --build . --target install -j%CPU_COUNT%
if errorlevel 1 exit 1
