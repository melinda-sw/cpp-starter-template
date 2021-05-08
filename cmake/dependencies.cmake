include(${PROJECT_SOURCE_DIR}/cmake/conan.cmake)

# Conan and dependencies configuration
conan_cmake_run(
    REQUIRES
        catch2/2.13.6
    BASIC_SETUP
        CMAKE_TARGETS
    BUILD
        missing
)

