add_executable(cst)

target_sources(cst
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src/cst.m.cpp
)

target_link_libraries(cst
    PRIVATE
        fmt::fmt
        project-options
)

if (CST_BUILD_TESTS)
    add_executable(cst_test)

    target_sources(cst_test
        PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/test/cst.t.cpp
    )

    target_link_libraries(cst_test
        PRIVATE
            Catch2::Catch2WithMain
            project-options
    )

    if (NOT CMAKE_CROSSCOMPILING)
        include(Catch)
        catch_discover_tests(cst_test)
    endif()
endif()
