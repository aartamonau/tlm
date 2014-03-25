SET(CB_GXX_DEBUG "-g")
SET(CB_GXX_WARNINGS "-Wall -Wredundant-decls -fno-strict-aliasing")
SET(CB_GXX_VISIBILITY "-fvisibility=hidden")
SET(CB_GXX_THREAD "-pthread")

IF ("${ENABLE_WERROR}" STREQUAL "YES")
   SET(CB_GXX_WERROR "-Werror")
ENDIF()

MESSAGE(STATUS "C++ compiler version: ${CMAKE_CXX_COMPILER_VERSION}")
if (${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 4.7)
  SET(CB_CXX_LANG_VER "")
ELSE ()
  SET(CB_CXX_LANG_VER "-std=c++11")
ENDIF()

if (${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 4.5)
  SET(CB_CXX_PEDANTIC "")
ELSE ()
  SET(CB_CXX_PEDANTIC "-pedantic")
ENDIF()


SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CB_CXX_LANG_VER} ${CB_GXX_DEBUG} ${CB_GXX_WARNINGS} ${CB_CXX_PEDANTIC} ${CB_GXX_VISIBILITY} ${CB_GXX_THREAD} ${CB_GXX_WERROR}")
