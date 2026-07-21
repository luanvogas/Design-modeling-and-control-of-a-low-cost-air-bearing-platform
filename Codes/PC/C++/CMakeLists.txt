# --parallel [<jobs>] feature was introduced at 3.12
# https://cmake.org/cmake/help/latest/release/3.12.html#command-line
cmake_minimum_required(VERSION 3.12)

####################
# Project settings #
####################
include(ExternalProject)
project(DoutoradoLuan C CXX)

################################
# Folder with the dependencies #
################################
set(DEPENDENCIES_DIR ${CMAKE_SOURCE_DIR}/ThirdParty)
set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)

#######################
# Select dependencies #
#######################
option(BUILD_MATIO       "Build MATIO      - used to load matlab files"                            OFF)
option(BUILD_EIGEN_MATIO "Build EigenMatio - used to load matlab file into eigen matrices"         OFF)
#option(BUILD_NRFUSB      "Build NRFUSB"                                                            ON)

###################
# Quanser HIL SDK #
###################
set(QUANSER_PATH "C:/Program Files/Quanser/Quanser SDK")
set(QUANSER_LIBS hil quanser_common quanser_communications quanser_devices quanser_media quanser_runtime)

if(EXISTS ${DEPENDENCIES_DIR}/share/eigen3/cmake/UseEigen3.cmake)
	set(Eigen3_DIR ${DEPENDENCIES_DIR}/share/eigen3/cmake)
	find_package(Eigen3 3.4 REQUIRED)
endif()

if(EXISTS ${DEPENDENCIES_DIR}/OpenCVConfig.cmake)
	set(BUILD_SHARED_LIBS OFF)
	include(${DEPENDENCIES_DIR}/OpenCVConfig.cmake)
	include_directories( ${OpenCV_INCLUDE_DIRS} )
	link_directories("${DEPENDENCIES_DIR}/x64/vc17/lib")
	link_libraries(${OpenCV_LIBS})
endif()

if(EXISTS ${DEPENDENCIES_DIR}/lib/libnrfusb.lib)
	include_directories( ${DEPENDENCIES_DIR}/include )
	link_directories("${DEPENDENCIES_DIR}/lib")
	add_library(libnrfusb STATIC IMPORTED)
	set_property(TARGET libnrfusb PROPERTY IMPORTED_LOCATION "${DEPENDENCIES_DIR}/lib/libnrfusb.lib")
	link_libraries(libnrfusb)
	# The ntdll library is required at Microsoft Windows
	if(WIN32)
		link_libraries(ntdll)
	endif()
endif()


set(MY_SOURCES
	src/main.cpp
	src/data_structures.h
	src/vision.cpp
	src/vision.h
	src/message.cpp
	src/message.h
	src/radio.cpp
	src/radio.h
	src/timer.cpp	
	src/timer.h
	src/data_storage.h
	src/data_storage.cpp
	src/control.h
	src/control.cpp
	src/extra.cpp
	src/extra.h
	src/hardware.cpp
	src/hardware.h
)

include_directories(${DEPENDENCIES_DIR}/build/opencvContrib-prefix/src/opencvContrib/modules/aruco/samples)

add_executable(vision ${MY_SOURCES})

add_executable(camera_parameters utils/camera_parameters.cpp)

add_executable(create_board utils/create_board.cpp)

add_executable(camera_latency utils/camera_latency.cpp src/vision.cpp src/timer.cpp)
target_include_directories(camera_latency PRIVATE ${QUANSER_PATH}/include ${CMAKE_SOURCE_DIR}/src)
target_link_directories(camera_latency PRIVATE ${QUANSER_PATH}/lib/win64)
target_link_libraries(camera_latency PRIVATE ${QUANSER_LIBS} libnrfusb)

add_executable(gyroscope_calibration utils/gyroscope_calibration.cpp src/vision.cpp src/timer.cpp src/hardware.cpp src/message.cpp src/radio.cpp)
target_include_directories(gyroscope_calibration PRIVATE ${QUANSER_PATH}/include ${CMAKE_SOURCE_DIR}/src)
target_link_directories(gyroscope_calibration PRIVATE ${QUANSER_PATH}/lib/win64)
target_link_libraries(gyroscope_calibration PRIVATE ${QUANSER_LIBS} libnrfusb)
