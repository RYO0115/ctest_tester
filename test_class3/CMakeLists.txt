cmake_minimum_required(VERSION 3.5)
project(GTestClass3)

set(CMAKE_CXX_STANDARD 17)


# GTestを使用
find_package(GTest REQUIRED)
include_directories(
    ${GTEST_INCLUDE_DIRS}
	${PROJECT_SOURCE_DIR}/include
)

# ソースファイルを指定
add_library(testclass3 STATIC src/class3.cpp)
target_include_directories(testclass3 PUBLIC include)

# ダミーの空testを作成
add_executable(test3 test/test3.cpp src/class3.cpp)
target_link_libraries(test3 ${GTEST_LIBRARIES} gtest_main pthread)


# カバレッジ用のオプションを追加
if(CMAKE_BUILD_TYPE STREQUAL "Coverage")
    target_compile_options(test3 PRIVATE --coverage)
    target_link_libraries(test3 --coverage)

    #target_compile_options()
endif()

#add_test(NAME test3 COMMAND test3)