include(GNUInstallDirs)

install(TARGETS dsda-launcher
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    PERMISSIONS WORLD_READ WORLD_EXECUTE
            GROUP_READ GROUP_EXECUTE
            OWNER_READ OWNER_WRITE OWNER_EXECUTE
)

if(UNIX AND NOT APPLE)
    install(FILES ${DIST_PATH}/icons/${FREEDESKTOP_APP_ID}.svg
            DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/icons/hicolor/scalable/apps
            PERMISSIONS WORLD_READ
                        GROUP_READ
                        OWNER_READ OWNER_WRITE OWNER_EXECUTE
    )
    install(FILES ${DIST_PATH}/icons/dsda-launcher.256x.png
            DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/icons/hicolor/256x256/apps
            RENAME ${FREEDESKTOP_APP_ID}.png
            PERMISSIONS WORLD_READ
                        GROUP_READ
                        OWNER_READ OWNER_WRITE OWNER_EXECUTE
    )
#     install(FILES ${LINUX_PKG_PATH}/${FREEDESKTOP_APP_ID}.metainfo.xml
#             DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/metainfo/
#             PERMISSIONS WORLD_READ
#                         GROUP_READ
#                         OWNER_READ OWNER_WRITE OWNER_EXECUTE
#     )
    install(FILES ${LINUX_PKG_PATH}/${FREEDESKTOP_APP_ID}.desktop
            DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications/
            PERMISSIONS WORLD_READ WORLD_EXECUTE
                        GROUP_READ GROUP_EXECUTE
                        OWNER_READ OWNER_WRITE OWNER_EXECUTE
    )
elseif(APPLE)
    install(FILES ${DIST_PATH}/icons/dsda-launcher.icns
            DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/Resources/
            PERMISSIONS WORLD_READ WORLD_EXECUTE
                        GROUP_READ GROUP_EXECUTE
                        OWNER_READ OWNER_WRITE OWNER_EXECUTE
    )
endif()