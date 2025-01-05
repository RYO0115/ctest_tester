cmake_minimum_required(VERSION 3.10)
project(GTestClass2)

set(CMAKE_CXX_STANDARD 17)

# Library 作成

add_library(class2 STATIC src/class2.cpp)
target_include_directories(class2 PUBLIC include)

if(CMAKE_BUILD_TYPE STREQUAL "Coverage")
    target_compile_options(class2 PRIVATE --coverage)
    target_link_libraries(class2 --coverage)
endif()


# GTestを使用
find_package(GTest REQUIRED)
include_directories(
    ${GTEST_INCLUDE_DIRS}
	${PROJECT_SOURCE_DIR}/include
)

# ソースファイルを指定
#add_executable(test2 test/test2.cpp src/class2.cpp)
add_executable(test2 test/test2.cpp)
target_link_libraries(test2 ${GTEST_LIBRARIES} gtest_main pthread class2)

# カバレッジオプションを追加
if(CMAKE_BUILD_TYPE STREQUAL "Coverage")
    target_compile_options(test2 PRIVATE --coverage)
    target_link_libraries(test2 --coverage)
endif()

add_test(NAME test2 COMMAND test2)