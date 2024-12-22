
#include "class2.hpp"
#include <gtest/gtest.h>

TEST(CalculatorSubTest,AddTest)
{
    CalculatorSub calc;
    EXPECT_EQ(calc.sub(3,2), 1);
    EXPECT_EQ(calc.sub(5,6), -1);
}

//TEST(CalculatorSub, GreetTest)
//{
//    CalculatorSub calc;
//    EXPECT_EQ(calc.greet("Alice"), "Hello, Alice!");
//}