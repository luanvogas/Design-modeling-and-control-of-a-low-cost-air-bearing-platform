cmake_minimum_required(VERSION 3.12)

include(ExternalProject)
project(ThirdParty C CXX)

########################
# Precompiled binaries #
########################
#
# Some dependencies are available pre-compiled. This is useful because
# it saves a lot of time compiling. The available options are:
#
##### Intel MKL
#
# Fast library for matrices, it provied basic BLAS and LAPACK.
#
# Microsoft Windows - download and install from
# https://www.intel.com/content/www/us/en/developer/tools/oneapi/onemkl.html
#
# At linuxes you should be required to run something like:
# sudo apt install intel-mkl
# emerge -av sci-libs/mkl
#
##### Boost
#
# v1.82
# https://sourceforge.net/projects/boost/files/boost-binaries/1.82.0/boost_1_82_0-msvc-14.3-64.exe/download
#
##### HDF5
#
# v1.14.1
# https://www.hdfgroup.org/downloads/hdf5
#

####################################
# Select your project dependencies #
####################################
option(BUILD_EIGEN       "Build eigen      - high level matrix manipulation"                       ON)
option(BUILD_OPENCV      "Build OpenCV     - image processing (requires at least 20GB free disk)"  OFF)
option(BUILD_ZLIB        "Build ZLIB       - dependecy, you should not be required to set it"      OFF)
option(BUILD_MATIO       "Build MATIO      - used to load matlab files"                            OFF)
option(BUILD_EIGEN_MATIO "Build EigenMatio - used to load matlab file into eigen matrices"         OFF)
option(BUILD_NRFUSB      "Include NRFUSB"                                                          OFF)
option(WITH_BOOST        "Include Boost"                                                           OFF)
option(WITH_HDF5         "Include HDF5"                                                            OFF)

####################################
# Dependency graph do not touch it #
####################################
# OPENCV
#   ├── EIGEN
#   └── MKL
if(${BUILD_OPENCV})
	set(BUILD_EIGEN ON)
endif()

# MATIO
#   ├── ZLIB
#   └── HDF5
if(${BUILD_MATIO})
	set(BUILD_ZLIB ON)
endif()

# EIGEN_MATIO
#   ├── MATIO
#   └── EIGEN
if(${BUILD_EIGEN_MATIO})
	set(BUILD_MATIO ON)
	set(BUILD_EIGEN ON)
endif()

###############################
# All binary will be put here #
###############################
# Documentation:
# CMAKE_SOURCE_DIR - https://cmake.org/cmake/help/latest/variable/CMAKE_SOURCE_DIR.html
# CMAKE_BINARY_DIR - https://cmake.org/cmake/help/latest/variable/CMAKE_BINARY_DIR.html
set(INSTALL_DIR ${CMAKE_SOURCE_DIR})
message(STATUS "INSTALL_DIR = ${INSTALL_DIR}")

########################
# eigen matrix library #
########################
if(${BUILD_EIGEN})
	ExternalProject_Add(eigen
		URL							https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.zip
		DOWNLOAD_EXTRACT_TIMESTAMP	TRUE
		CMAKE_ARGS					-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}
	)
	#include_directories(${INSTALL_DIR}/include/eigen3)
endif()

##################################################################
# OpenCV                                                         #
##################################################################
# We only need a copy of this project locally, that's the reason #
# why the CONFIGURE, INSTALL and TEST commands are empty         #
##################################################################
if(${BUILD_OPENCV})
	ExternalProject_Add (opencvContrib
		URL							https://github.com/opencv/opencv_contrib/archive/refs/tags/4.8.0.zip
		DOWNLOAD_EXTRACT_TIMESTAMP	TRUE
		CONFIGURE_COMMAND			""
		BUILD_COMMAND				""
		INSTALL_COMMAND				""
		TEST_COMMAND				""
		CMAKE_ARGS					-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}
	)
	ExternalProject_Get_Property(opencvContrib SOURCE_DIR)
	set(OPENCV_CONTRIB_PATH ${SOURCE_DIR}/modules)

	set(BUILD_SHARED_LIBS OFF CACHE INTERNAL "")  # Forces to use static libraries
	set(WITH_GSTREAMER OFF CACHE INTERNAL "")     # Disables gstreamer
	ExternalProject_Add (opencv
		URL							https://github.com/opencv/opencv/archive/refs/tags/4.8.0.zip
		DOWNLOAD_EXTRACT_TIMESTAMP	TRUE
		CMAKE_ARGS					-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} -DOPENCV_EXTRA_MODULES_PATH=${OPENCV_CONTRIB_PATH}
	)
	add_dependencies(opencv eigen opencvContrib)
endif()

#########
# Boost #
#########
if(${WITH_BOOST})
	if(WIN32)
		set(Boost_USE_STATIC_LIBS OFF)
		set(Boost_USE_MULTITHREADED ON)
		set(Boost_USE_STATIC_RUNTIME OFF)
	else() # Linux
	endif()
	find_package(Boost REQUIRED)
	include_directories(${Boost_INCLUDE_DIRS})
endif()

################
# HDF5 library #
################
if(${WITH_HDF5})
	set(HDF5_USE_STATIC_LIBRARIES ON)
	find_package(HDF5 REQUIRED COMPONENTS C HL)
endif()

################
# zlib library #
################
if(${BUILD_ZLIB})
	ExternalProject_Add (zlibProject
		URL               https://github.com/madler/zlib/releases/download/v1.2.13/zlib1213.zip
		CMAKE_ARGS        -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}
	)
	set(ZLIB_INCLUDE_DIR ${INSTALL_DIR}/include)
	set(ZLIB_LIBRARY     ${INSTALL_DIR}/lib)
endif()

#################
# matio library #
#################
if(${BUILD_MATIO})
	set(MATIO_SHARED OFF CACHE INTERNAL "")  # Forces to use static library
	FetchContent_Declare(
		matioProject
		URL               https://github.com/tbeu/matio/archive/refs/tags/v1.5.23.zip
	)
	FetchContent_MakeAvailable(matioProject)
	target_include_directories(matio PUBLIC ${INSTALL_DIR}/include)
	add_dependencies(matio zlibProject)
	link_libraries(matio)
endif()

#######################
# eigen-matio library #
#######################
if(${BUILD_EIGEN_MATIO})
	set(EIGEN_MATIO_URL  https://raw.githubusercontent.com/tesch1/eigen-matio/master/MATio)
	set(EIGEN_MATIO_DIR ${INSTALL_DIR}/include)
	set(EIGEN_MATIO_DEST ${EIGEN_MATIO_DIR}/MATio)
	if(NOT EXISTS EIGEN_MATIO_DEST)
		file(DOWNLOAD ${EIGEN_MATIO_URL} ${EIGEN_MATIO_DEST})
	endif()
	include_directories(${EIGEN_MATIO_DIR})
endif()

##################
# nrfusb-driver  #
##################
if(${BUILD_NRFUSB})
ExternalProject_Add (nrfusb-driver
	PREFIX            nrfusb-driver
	GIT_REPOSITORY    https://gitlab.com/opendac/nrfusb/nrfusb-driver.git
	GIT_TAG           main
	CMAKE_ARGS        -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}
    UPDATE_DISCONNECTED True
)
endif()

