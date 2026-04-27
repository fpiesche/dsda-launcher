find_program(LINUXDEPLOY_EXECUTABLE
    NAMES linuxdeploy linuxdeploy-${CMAKE_HOST_SYSTEM_PROCESSOR}.AppImage
    PATHS ${CPACK_PACKAGE_DIRECTORY}/linuxdeploy
)

if(NOT LINUXDEPLOY_EXECUTABLE)
    message(STATUS "Downloading linuxdeploy")
    set(LINUXDEPLOY_EXECUTABLE ${CPACK_PACKAGE_DIRECTORY}/linuxdeploy/linuxdeploy)
    file(DOWNLOAD
        https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-${CMAKE_HOST_SYSTEM_PROCESSOR}.AppImage
        ${LINUXDEPLOY_EXECUTABLE}
        INACTIVITY_TIMEOUT 10
    )
    execute_process(COMMAND
        chmod +x ${LINUXDEPLOY_EXECUTABLE} COMMAND_ECHO STDOUT
    )
endif()

find_program(LINUXDEPLOY_QT_PLUGIN
    NAMES linuxdeploy-plugin-qt linuxdeploy-plugin-qt-${CMAKE_HOST_SYSTEM_PROCESSOR}.AppImage
    PATHS ${CPACK_PACKAGE_DIRECTORY}/linuxdeploy
)

if(NOT LINUXDEPLOY_QT_PLUGIN)
    message(STATUS "Downloading linuxdeploy Qt plugin")
    set(LINUXDEPLOY_QT_PLUGIN ${CPACK_PACKAGE_DIRECTORY}/linuxdeploy/linuxdeploy-plugin-qt)
    file(DOWNLOAD
        https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/latest/download/linuxdeploy-plugin-qt-${CMAKE_HOST_SYSTEM_PROCESSOR}.AppImage
        ${LINUXDEPLOY_QT_PLUGIN}
        INACTIVITY_TIMEOUT 10
    )
    execute_process(COMMAND
        chmod +x ${LINUXDEPLOY_QT_PLUGIN} COMMAND_ECHO STDOUT
    )
endif()

execute_process(COMMAND
    ${CMAKE_COMMAND} -E env
        NO_STRIP=true
        EXTRA_QT_PLUGINS=waylandcompositor
        EXTRA_PLATFORM_PLUGINS=libqwayland-egl.so\;libqwayland-generic.so
        OUTPUT=${CPACK_PACKAGE_FILE_NAME}.AppImage
        VERSION=$<IF:$<BOOL:${CPACK_PACKAGE_VERSION}>,${CPACK_PACKAGE_VERSION},${PROJECT_VERSION}>
    ${LINUXDEPLOY_EXECUTABLE}
        --appimage-extract-and-run
        --appdir=${CPACK_TEMPORARY_DIRECTORY}
        --plugin=qt
        --executable=${CPACK_TEMPORARY_DIRECTORY}/bin/dsda-launcher
        --desktop-file=${CPACK_TEMPORARY_DIRECTORY}/share/applications/${CPACK_FREEDESKTOP_APP_ID}.desktop
        --icon-file=${CPACK_TEMPORARY_DIRECTORY}/share/icons/hicolor/scalable/apps/${CPACK_FREEDESKTOP_APP_ID}.svg
        --output=appimage
    WORKING_DIRECTORY "${CPACK_PACKAGE_DIRECTORY}"
    ERROR_VARIABLE APPIMAGE_ERRORS
    OUTPUT_VARIABLE APPIMAGE_OUTPUT
    ECHO_ERROR_VARIABLE
    ECHO_OUTPUT_VARIABLE
    COMMAND_ERROR_IS_FATAL ANY
    COMMAND_ECHO STDOUT
)
