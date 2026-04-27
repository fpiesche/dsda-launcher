find_program(LSB_RELEASE_EXEC lsb_release)
execute_process(COMMAND ${LSB_RELEASE_EXEC} -is
    OUTPUT_VARIABLE LSB_RELEASE_ID_SHORT
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
message(STATUS "Detected Linux distribution: ${LSB_RELEASE_ID_SHORT}")
list(APPEND LINUX_CPACK_GENERATORS ${CPACK_GENERATOR})

if(LSB_RELEASE_ID_SHORT MATCHES "Debian" OR LSB_RELEASE_ID_SHORT MATCHES "Ubuntu")
    option(BUILD_DEB "CPack: Build a Debian package" ON)
    if(BUILD_DEB)
        message(STATUS "CPack: Building Debian package")
        list(APPEND CPACK_GENERATOR "DEB")
    endif()
elseif(LSB_RELEASE_ID_SHORT MATCHES "Fedora")
    option(BUILD_RPM "CPack: Build a RedHat RPM package" ON)
    if(BUILD_RPM)
        message(STATUS "CPack: Building RPM package")
        list(APPEND CPACK_GENERATOR "RPM")
    endif()
endif()

option(BUILD_APPIMAGE "CPack: Build an AppImage" ON)
if(BUILD_APPIMAGE)
    message(STATUS "CPack: Building AppImage")
    list(APPEND CPACK_GENERATOR "External")
    set(CPACK_EXTERNAL_PACKAGE_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/cmake/packaging-appimage.cmake")
    set(CPACK_EXTERNAL_ENABLE_STAGING TRUE)
endif()
