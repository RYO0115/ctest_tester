cmake_minimum_required(VERSION 3.10)
project(GTestClass1)

set(CMAKE_CXX_STANDARD 17)


# GTestを使用
find_package(GTest REQUIRED)
include_directories(
    ${GTEST_INCLUDE_DIRS}
	${PROJECT_SOURCE_DIR}/include
)

# ソースファイルを指定
#add_library(class1 src/class1.cpp)
add_executable(test1 test/test1.cpp src/class1.cpp)
target_link_libraries(test1 ${GTEST_LIBRARIES} gtest_main pthread)

# カバレッジオプションを追加
if(CMAKE_BUILD_TYPE STREQUAL "Coverage")
    target_compile_options(test1 PRIVATE --coverage)
    target_link_libraries(test1 --coverage)
endif()

add_test(NAME test1 COMMAND test1)
