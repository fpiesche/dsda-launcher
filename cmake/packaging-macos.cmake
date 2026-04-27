set(APPS "\${CMAKE_INSTALL_PREFIX}/dsda-launcher.app")
set(DIRS ${CMAKE_BINARY_DIR}
        $ENV{QT_ROOT_DIR}/lib
)

install(CODE "include(BundleUtilities)
    fixup_bundle(\"${APPS}\" \"\" \"${DIRS}\")
    verify_app(\"${APPS}\")"
)
list(APPEND CPACK_GENERATOR "DragNDrop")

# Override icon to icns
set(CPACK_PACKAGE_ICON ${DIST_PATH}/icons/${FREEDESKTOP_APP_ID}.icns)

message(STATUS "CPack: Building macOS DMG")
