include(${PROJECT_SOURCE_DIR}/cmake/Catch2.cmake)

add_executable(${TARGET_NAME} src/main.cpp)
add_dependencies(${TARGET_NAME} clang-format)

add_executable(${TARGET_NAME}_test
    test/main.cpp
    test/main.t.cpp
)
target_link_libraries(
    ${TARGET_NAME}_test
    PRIVATE
        Catch2::Catch2
)
add_dependencies(${TARGET_NAME}_test clang-format)

# https://github.com/catchorg/Catch2/blob/master/docs/cmake-integration.md#automatic-test-registration
catch_discover_tests(${TARGET_NAME}_test)

