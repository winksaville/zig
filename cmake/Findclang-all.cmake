# Copyright (c) 2016 Andrew Kelley
# This file is MIT licensed.
# See http://opensource.org/licenses/MIT

# CLANG_FOUND
# CLANG_INCLUDE_DIRS
# CLANG_LIBRARIES
# CLANG_LIBDIRS

#set(CLANG_LIBDIRS "/home/wink/local/lib")

if(MSVC)
  set(CLANG clang)
  find_package(${CLANG} REQUIRED CONFIG)

  set(CLANG_LIBRARIES
      clangFrontendTool
      clangCodeGen
      clangFrontend
      clangDriver
      clangSerialization
      clangSema
      clangStaticAnalyzerFrontend
      clangStaticAnalyzerCheckers
      clangStaticAnalyzerCore
      clangAnalysis
      clangASTMatchers
      clangAST
      clangParse
      clangSema
      clangBasic
      clangEdit
      clangLex
      clangARCMigrate
      clangRewriteFrontend
      clangRewrite
      clangCrossTU
      clangIndex
  )
else()
  find_path(CLANG_INCLUDE_DIRS NAMES clang/Frontend/ASTUnit.h
      PATHS
          /usr/lib/llvm/8/include
          /usr/lib/llvm-8/include
          /usr/lib/llvm-8.0/include
          /usr/local/llvm80/include
          /mingw64/include)

  macro(FIND_AND_ADD_CLANG_LIB _libname_)
      string(TOUPPER ${_libname_} _prettylibname_)
      find_library(CLANG_${_prettylibname_}_LIB NAMES ${_libname_}
          PATHS
              ${CLANG_LIBDIRS}
              /usr/lib/llvm/8/lib
              /usr/lib/llvm-8/lib
              /usr/lib/llvm-8.0/lib
              /usr/local/llvm80/lib
              /mingw64/lib
              /c/msys64/mingw64/lib
              c:\\msys64\\mingw64\\lib)
      if(CLANG_${_prettylibname_}_LIB)
          set(CLANG_LIBRARIES ${CLANG_LIBRARIES} ${CLANG_${_prettylibname_}_LIB})
      endif()
  endmacro(FIND_AND_ADD_CLANG_LIB)

  if(ZIG_STATIC OR LLVM_STATIC)
    FIND_AND_ADD_CLANG_LIB(clangFrontendTool)
    FIND_AND_ADD_CLANG_LIB(clangCodeGen)
    FIND_AND_ADD_CLANG_LIB(clangFrontend)
    FIND_AND_ADD_CLANG_LIB(clangDriver)
    FIND_AND_ADD_CLANG_LIB(clangSerialization)
    FIND_AND_ADD_CLANG_LIB(clangSema)
    FIND_AND_ADD_CLANG_LIB(clangStaticAnalyzerFrontend)
    FIND_AND_ADD_CLANG_LIB(clangStaticAnalyzerCheckers)
    FIND_AND_ADD_CLANG_LIB(clangStaticAnalyzerCore)
    FIND_AND_ADD_CLANG_LIB(clangAnalysis)
    FIND_AND_ADD_CLANG_LIB(clangASTMatchers)
    FIND_AND_ADD_CLANG_LIB(clangAST)
    FIND_AND_ADD_CLANG_LIB(clangParse)
    FIND_AND_ADD_CLANG_LIB(clangSema)
    FIND_AND_ADD_CLANG_LIB(clangBasic)
    FIND_AND_ADD_CLANG_LIB(clangEdit)
    FIND_AND_ADD_CLANG_LIB(clangLex)
    FIND_AND_ADD_CLANG_LIB(clangARCMigrate)
    FIND_AND_ADD_CLANG_LIB(clangRewriteFrontend)
    FIND_AND_ADD_CLANG_LIB(clangRewrite)
    FIND_AND_ADD_CLANG_LIB(clangCrossTU)
    FIND_AND_ADD_CLANG_LIB(clangIndex)
  else()
    set(CLANG clang-all)
    FIND_AND_ADD_CLANG_LIB(${CLANG})
    if(NOT CLANG_LIBRARIES)
      message(FATAL_ERROR "NO ${CLANG}")
    endif()
  endif()
endif()

link_directories("${CMAKE_PREFIX_PATH}/lib")
link_directories("${CLANG_LIBDIRS}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(${CLANG} DEFAULT_MSG CLANG_LIBRARIES CLANG_INCLUDE_DIRS)

message(STATUS "clang-all: CLANG=\"${CLANG}\"")
message(STATUS "clang-all: CLANG_INCLUDE_DIRS=\"${CLANG_INCLUDE_DIRS}\"")
message(STATUS "clang-all: CLANG_LIBRARIES=\"${CLANG_LIBRARIES}\"")
message(STATUS "clang-all: CLANG_LIBDIRS=\"${CLANG_LIBDIRS}\"")

mark_as_advanced(CLANG_INCLUDE_DIRS CLANG_LIBRARIES CLANG_LIBDIRS)
