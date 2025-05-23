# cpp-starter-template [![GitHub Build status](https://github.com/melinda-sw/cpp-starter-template/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/melinda-sw/cpp-starter-template/actions/workflows/ci.yml)

Template set up with basic infrastructure for C++ projects

## Building
Necessary build tools are:
* CMake 3.27 or higher
* Conan 2.14 or higher
  * See [installation instructions](https://docs.conan.io/2/installation.html)
* One of supported compilers:
  * Clang-20 (libstdc++ or libc++)
  * GCC-14
  * Visual Studio 2022 (MSVC v194)
* Ninja (if using Clang on Windows)

### Cross compilation
Supported architecture for cross compilation is Linux AArch64 with one of following compilers:
* GCC-14
* Clang-20 (libstdc++ or libc++)

Note that the compilation flags assume ARM Cortex-A76. Which can be changed in corresponding Conan profiles.

### Install dependencies
```
conan install . --profile=conan/clang-20-libstdcxx-amd64-linux --build=missing --settings build_type=Release
```
* Predefined conan profiles for supported compilers are located in `conan` folder
* Conan build types: `Release`, `RelWithDebInfo`, `Debug`

### Configure, build and test
```
cmake --preset release
cmake --build --preset release
```
Disable building of tests by:
* Adding `--conf tools.build:skip_test=True` to `conan install` command
* Adding `-DBUILD_TESTING=OFF` during CMake configure

Building of tests is enabled by default. Execute the tests with the following command:
```
ctest --preset release
```

Use the preset matching the build type used when installing dependencies.
When compiling with `MSVC` or using some other multi configuration generator use
`multi-debug`, `multi-relwithdebinfo` or `multi-release` presets.

## Additional tools
### ClangFormat 
Enable running `clang-format` automatically on all source files during build by
adding `-DCST_ENABLE_CLANG_FORMAT=ON` during CMake configure. This option is
disabled by default.

## Additional compilation options
### Toolchain hardening
Enable toolchain security hardening compiler options, by adding an additional
profile to the `conan install` command, together with `--build=*` to recompile
dependencies with hardening enabled. Also enable CMAKE\_POSITION\_INDEPENDENT\_CODE
variable during CMake configure. Toolchain hardening options should only be used
with `Release` or `RelWithDebInfo` build types. This option is disabled by default.
```
conan install . --profile=conan/clang-20-libstdcxx-amd64-linux --profile=conan/opt/clang-amd64-linux-hardening --profile=conan/opt/gnulike-libstdcxx-hardening --build=* --settings build_type=Release
cmake -DCMAKE_POSITION_INDEPENDENT_CODE=ON --preset release
```
Predefined toolchain hardening profiles are located in `conan/opt`:
* `clang-amd64-linux-hardening`
* `gcc-amd64-linux-hardening`
* `clang-amd64-windows-hardening`
* `msvc-amd64-windows-hardening`
* `gcc-aarch64-linux-hardening`
* `clang-aarch64-linux-hardening`

When compiling with `Clang` or `GCC` on Linux also on select the standard library hardening profile:
* `gnulike-libcxx-hardening`
* `gnulike-libstdcxx-hardening`

Use the predefined hardening profile together with the matching compiler profile from `conan` folder.

### Link time optimization / Whole program optimization
Enable link time optimization compiler options, by adding an additional
profile to the `conan install` command, together with `--build=*` to recompile
dependencies with link time optimization enabled. Also enable CMAKE\_INTERPROCEDURAL\_OPTIMIZATION
variable during CMake configure. Link time optimization should only be used
with `Release` or `RelWithDebInfo` build types. This option is disabled by default.
```
conan install . --profile=conan/clang-20-libstdcxx-amd64-linux --profile=conan/opt/gnulike-lto --build=* --settings build_type=Release
cmake -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON --preset release
```

Predefined link time optimization profiles are located in `conan/opt`:
* `gnulike-lto`
* `msvc-amd64-windows-lto`
* `clang-amd64-windows-lto`

### Sanitizers
Enable sanitizers by adding an additional profile to the `conan install` command,
together with `--build=*` to recompile dependencies with santizers enabled. Sanitizers
should only be used with `Release`or `RelWithDebInfo` build types. These options are disabled by default.
```
conan install . --profile=conan/clang-20-libstdcxx-amd64-linux --profile=conan/opt/gnulike-address-sanitizer --build=* --settings build_type=Release
```
* Conan profiles for `Clang` and `GCC` sanitizers are: `gnulike-address-sanitizer`, `gnulike-leak-sanitizer`, `gnulike-thread-sanitizer`, `gnulike-undefined-sanitizer`
  * Thread sanitizer cannot be used in combination with any other sanitizer
* Conan profile for `MSVC` compiler is: `msvc-amd64-windows-address-sanitizer`
  * Run the compiled executables from the developer command prompt, or execute `call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\VsDevCmd.bat" -arch=amd64 -host_arch=amd64` to correctly set up search paths for runtime libraries

### Static analysis
#### ClangTidy
Enable running `clang-tidy` automatically on all source files during build by
adding `-DCST_ENABLE_CLANG_TIDY=ON` during CMake configure. This option is
disabled by default.

#### Compiler static analysis
Enable compiler flags for static analysis during build by adding `-DCST_ENABLE_COMPILER_STATIC_ANALYSIS=ON`
during CMake configure. This option is disabled by default.
* Compiler static analysis is supported for `GCC` and `MSVC` compilers

#### include-what-you-use
Enable running of `include-what-you-use` automatically on all source files during
build by adding `-DCST_ENABLE_IWYU=ON` during CMake configure. This option is
disabled by default.

#### Cppcheck
Enable running of `cppcheck` automatically on all source files during build by 
adding `-DCST_ENABLE_CPPCHECK=ON` during CMake configure. This option is disabled 
by default.
