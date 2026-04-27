cmake_minimum_required(VERSION 3.16)

# Build universal binaries on macOS
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
    set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
endif()

project(dsda-launcher VERSION 1.4.0 LANGUAGES C CXX)

# set(DIST_PATH "${CMAKE_SOURCE_DIR}/dist")
# set(LINUX_PKG_PATH "${DIST_PATH}/linux")
# set(FREEDESKTOP_APP_ID eu.pedro_beirao.dsda-launcher)
set(DIST_PATH "${CMAKE_SOURCE_DIR}/src")
set(LINUX_PKG_PATH "${DIST_PATH}/icons")
set(FREEDESKTOP_APP_ID dsda-launcher)
set(CPACK_FREEDESKTOP_APP_ID dsda-launcher)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
find_package(Qt6 REQUIRED COMPONENTS Concurrent Gui Network Svg)
find_package(Qt6 OPTIONAL_COMPONENTS Widgets)

qt_standard_project_setup()

qt_add_executable(dsda-launcher WIN32 MACOSX_BUNDLE
    src/about.cpp src/about.h src/about.ui
    src/console.cpp src/console.h src/console.ui
    src/constants.cpp src/constants.h
    src/demodialog.cpp src/demodialog.h
    src/endoom.cpp src/endoom.h src/endoom.ui
    src/funcs.cpp src/funcs.h
    src/historylist.cpp src/historylist.h src/historylist.ui
    src/main.cpp
    src/mainwindow.cpp src/mainwindow.h src/mainwindow.ui
    src/mainwindow_actions.cpp
    src/mainwindow_bottom.cpp
    src/mainwindow_demos.cpp
    src/mainwindow_options.cpp
    src/mainwindow_styles.cpp
    src/mainwindow_top.cpp
    src/mainwindow_wads.cpp
    src/settings.cpp src/settings.h src/settings.ui
    src/states.cpp src/states.h
    src/styles.h
    src/theme.cpp src/theme.h
    src/updater.cpp src/updater.h
)

if(APPLE)
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/dist/mac")
    target_sources(dsda-launcher PUBLIC
        src/Mac.h src/Mac.mm
        src/icons/dsda-launcher.icns
    )
    set_target_properties(dsda-launcher PROPERTIES
        MACOSX_BUNDLE TRUE
        RESOURCE "${DIST_PATH}/icons/dsda-launcher.icns"
    )
elseif(WIN32)
    target_sources(dsda-launcher PUBLIC src/dsda-launcher.rc)
    set_source_files_properties(dsda-launcher.rc PROPERTIES LANGUAGE RC)
endif()

target_compile_definitions(dsda-launcher PUBLIC
    APP_NAME="${PROJECT_NAME}"
)
target_include_directories(dsda-launcher PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)
target_link_libraries(dsda-launcher PRIVATE
    Qt::Concurrent
    Qt::Core
    Qt::Gui
    Qt::Network
    Qt::Svg
    Qt::Widgets
)

qt_add_resources(dsda-launcher "icons"
    PREFIX
        "/pngs"
    FILES
        "src/pngs/combo_box_arrow.png"
        "src/pngs/up.png"
        "src/pngs/down.png"
        "src/pngs/plus.png"
        "src/pngs/minus.png"
        "src/pngs/reload.png"
        "src/icons/dsda-launcher.svg"
        # "dist/icons/io.github.pedro_beirao.dsda-launcher.svg"
)

include(install)
include(packaging)
