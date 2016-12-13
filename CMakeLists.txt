cmake_minimum_required(VERSION 2.6 FATAL_ERROR)
cmake_policy(VERSION 2.6)

project(tsDemuxer)
include(GNUInstallDirs)

###############################################################################
# uninstall target
configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
  IMMEDIATE @ONLY)

add_custom_target(uninstall
  COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)

###############################################################################
# set lib version here
set(GENERIC_LIB_VERSION "1.0.0")
set(GENERIC_LIB_SOVERSION "1")

###############################################################################
# add common source
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/.")

###############################################################################
# add definitions
if(MSVC)
  add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif(MSVC)

if(TSDEMUX_DEBUG)
  add_definitions(-DTSDEMUX_DEBUG)
endif(TSDEMUX_DEBUG)

###############################################################################
# add targets
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Set to ON to build shared libraries")

add_library(tsDemuxerStatic STATIC
  src/elementaryStream.cpp
  src/bitstream.cpp
  src/ES_AC3.cpp
  src/ES_MPEGAudio.cpp
  src/ES_Subtitle.cpp
  src/ES_AAC.cpp
  src/ES_h264.cpp
  src/ES_MPEGVideo.cpp
  src/ES_Teletext.cpp
  src/ES_hevc.cpp
  src/debug.cpp
  src/tsDemuxer.cpp)

set_target_properties(tsDemuxerStatic PROPERTIES OUTPUT_NAME tsDemuxer)

if(BUILD_SHARED_LIBS)
  add_library(tsDemuxer SHARED
    src/elementaryStream.cpp
    src/bitstream.cpp
    src/ES_AC3.cpp
    src/ES_MPEGAudio.cpp
    src/ES_Subtitle.cpp
    src/ES_AAC.cpp
    src/ES_h264.cpp
    src/ES_MPEGVideo.cpp
    src/ES_Teletext.cpp
    src/ES_hevc.cpp
    src/debug.cpp
    src/tsDemuxer.cpp)

  set_target_properties(tsDemuxer PROPERTIES
    VERSION "${GENERIC_LIB_VERSION}"
    SOVERSION "${GENERIC_LIB_SOVERSION}")
endif(BUILD_SHARED_LIBS)

add_executable(demux src/test_demux.cpp src/test_demux.h)

set(DEPLIBS tsDemuxerStatic)
if (WIN32)
  list(APPEND DEPLIBS ws2_32)
else()
  list(APPEND DEPLIBS m pthread)
endif()
target_link_libraries(demux ${DEPLIBS})

if(BUILD_SHARED_LIBS)
  install(TARGETS tsDemuxer tsDemuxerStatic
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
else(BUILD_SHARED_LIBS)
  install(TARGETS tsDemuxerStatic
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
endif(BUILD_SHARED_LIBS)

install(FILES
  src/debug.h
  src/mutex.h
  src/tsPacket.h
  src/tsTable.h
  src/tsDemuxer.h
  src/elementaryStream.h
  src/bitstream.h
  src/ES_AC3.h
  src/ES_AAC.h
  src/ES_MPEGAudio.h
  src/ES_MPEGVideo.h
  src/ES_h264.h
  src/ES_hevc.h
  src/ES_Subtitle.h
  src/ES_Teletext.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/tsDemuxer)

foreach(p LIB INCLUDE)
  set(var CMAKE_INSTALL_${p}DIR)
  if(NOT IS_ABSOLUTE "${${var}}")
    set(${var} "${CMAKE_INSTALL_PREFIX}/${${var}}")
  endif()
endforeach()

configure_file(tsDemuxer.pc.in tsDemuxer.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/tsDemuxer.pc DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
