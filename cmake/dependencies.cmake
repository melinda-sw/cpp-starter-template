include(${PROJECT_SOURCE_DIR}/cmake/conan.cmake)

# Conan and dependencies configuration

conan_cmake_configure(
    REQUIRES
        catch2/2.13.8
    GENERATORS
        cmake_find_package
)

conan_cmake_autodetect(settings)

conan_cmake_install(PATH_OR_REFERENCE .
                    BUILD missing
                    SETTINGS ${settings})

find_package(Catch2 REQUIRED)
