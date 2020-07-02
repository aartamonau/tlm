# Locate Google Glog library
# This module defines
#  GLOG_LIBRARIES, Library path and libs
#  GLOG_INCLUDE_DIR, where to find the headers
include(PlatformIntrospection)
include(SelectLibraryConfigurations)

cb_get_supported_platform(_supported_platform)
if (_supported_platform)
    # Supported platforms should only use the provided hints and pick it up
    # from cbdeps
    set(_glog_no_default_path NO_DEFAULT_PATH)
endif ()

set(_glog_exploded ${CMAKE_BINARY_DIR}/tlm/deps/glog.exploded)

find_path(GLOG_INCLUDE_DIR glog/config.h
          PATH_SUFFIXES include
          PATHS ${_glog_exploded}
          ${_glog_no_default_path})

find_library(GLOG_LIBRARY_RELEASE
             NAMES glog
             HINTS ${_glog_exploded}/lib
             ${_glog_no_default_path})

find_library(GLOG_LIBRARY_DEBUG
             NAMES glogd
             HINTS ${_glog_exploded}/lib
             ${_glog_no_default_path})

# Defines GLOG_LIBRARY / LIBRARIES to the correct Debug / Release
# lib based on the current BUILD_TYPE
select_library_configurations(GLOG)

if(GLOG_INCLUDE_DIR AND GLOG_LIBRARIES)
    MESSAGE(STATUS "Found glog headers: ${GLOG_INCLUDE_DIR}")
    MESSAGE(STATUS "         libraries: ${GLOG_LIBRARIES}")
endif()

# Set GOOGLE_GLOG_DLL_DECL to an empty value to avoid incorrect dllimport
# decoration (we build static versions of GLOG which should have an empty
# DLL declaration).
add_compile_definitions(GOOGLE_GLOG_DLL_DECL=)

mark_as_advanced(GLOG_INCLUDE_DIR GLOG_LIBRARIES)

if (NOT DEFINED GFLAGS_FOUND)
    include(PlatformIntrospection)

    cb_get_supported_platform(_supported_platform)
    if (_supported_platform)
        # Supported platforms should only use the provided hints and pick it up
        # from cbdeps
        set(_gflags_no_default_path NO_DEFAULT_PATH)
    endif ()

    set(_gflags_exploded ${CMAKE_BINARY_DIR}/tlm/deps/gflags.exploded)

    find_path(GFLAGS_INCLUDE_DIR gflags/gflags.h
            PATH_SUFFIXES include
            PATHS ${_gflags_exploded}
            ${_gflags_no_default_path})

    find_library(GFLAGS_LIBRARIES
            NAMES gflags
            HINTS ${_gflags_exploded}/lib
            ${_gflags_no_default_path})

    if(GFLAGS_INCLUDE_DIR AND GFLAGS_LIBRARIES)
        MESSAGE(STATUS "Found gflags headers: ${GFLAGS_INCLUDE_DIR}")
        MESSAGE(STATUS "         libraries: ${GFLAGS_LIBRARIES}")
        set(GFLAGS_FOUND true CACHE BOOL "Found gflags" FORCE)
    else()
        set(GFLAGS_FOUND false CACHE BOOL "Found gflags" FORCE)
    endif()

    mark_as_advanced(GFLAGS_FOUND GFLAGS_INCLUDE_DIR GFLAGS_LIBRARIES)
endif()
