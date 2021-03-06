#-*-cmake-*-
# - Find GLFW
#
# Author : Nicholas Yue yue.nicholas@gmail.com
#
# This auxiliary CMake file helps in find the GLFW headers and libraries
#
# GLFW_FOUND            set if GLFW is found.
# GLFW_INCLUDE_DIR      GLFW's include directory
# GLFW_glfw_LIBRARY     GLFW libraries

SET ( GLFW_FOUND FALSE )

FIND_PATH( GLFW_LOCATION include/GL/glfw.h
  "$ENV{GLFW_ROOT}"
  NO_DEFAULT_PATH
  NO_SYSTEM_ENVIRONMENT_PATH
  )

SET( GLFW_INCLUDE_DIR "${GLFW_LOCATION}/include" CACHE STRING "GLFW include path")

SET ( ORIGINAL_CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_FIND_LIBRARY_SUFFIXES})
IF (GLFW_USE_STATIC_LIBS)
  IF (APPLE)
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
    FIND_LIBRARY ( GLFW_LIBRARY_PATH GLFW PATHS ${GLFW_LOCATION}/lib
      NO_DEFAULT_PATH
      NO_SYSTEM_ENVIRONMENT_PATH
	  )
	MESSAGE ( "APPLE STATIC" )
	MESSAGE ( "GLFW_LIBRARY_PATH = " ${GLFW_LIBRARY_PATH} )
  ELSEIF (WIN32)
    # Link library
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".lib")
    FIND_LIBRARY ( GLFW_LIBRARY_PATH GLFW32S PATHS ${GLFW_LOCATION}/lib )
  ELSE (APPLE)
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
    FIND_LIBRARY ( GLFW_LIBRARY_PATH glfw PATHS ${GLFW_LOCATION}/lib ${GLFW_LOCATION}/lib64
      NO_DEFAULT_PATH
      NO_SYSTEM_ENVIRONMENT_PATH
	  )
	MESSAGE ( "LINUX STATIC" )
	MESSAGE ( "GLFW_LIBRARY_PATH = " ${GLFW_LIBRARY_PATH} )
  ENDIF (APPLE)
ELSE ()
  IF (APPLE)
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".dylib")
    FIND_LIBRARY ( GLFW_LIBRARY_PATH GLFW PATHS ${GLFW_LOCATION}/lib )
  ELSEIF (WIN32)
    # Link library
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".lib")
    FIND_LIBRARY ( GLFW_LIBRARY_PATH GLFW32 PATHS ${GLFW_LOCATION}/lib )
    # Load library
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".dll")
    FIND_LIBRARY ( GLFW_DLL_PATH GLFW32 PATHS ${GLFW_LOCATION}/bin
      NO_DEFAULT_PATH
      NO_SYSTEM_ENVIRONMENT_PATH
      )
  ELSE (APPLE)
	# Unices
    FIND_LIBRARY ( GLFW_LIBRARY_PATH glfw PATHS ${GLFW_LOCATION}/lib ${GLFW_LOCATION}/lib64
      NO_DEFAULT_PATH
      NO_SYSTEM_ENVIRONMENT_PATH
	  )
  ENDIF (APPLE)
ENDIF ()
# MUST reset
SET(CMAKE_FIND_LIBRARY_SUFFIXES ${ORIGINAL_CMAKE_FIND_LIBRARY_SUFFIXES})

SET( GLFW_glfw_LIBRARY ${GLFW_LIBRARY_PATH} CACHE STRING "GLFW library")
