
#include "class1.hpp"
#include <gtest/gtest.h>


// Add test
TEST(CalculatorTest, AddTest)
{
    Calculator calc;
    EXPECT_EQ(calc.add(2,3),5);
    EXPECT_EQ(calc.add(1,-2),-1);
}

// Greet test

TEST(CalculatorTest, GreetTest)
{
    Calculator calc;
    EXPECT_EQ(calc.greet("Alice"), "Hello, Alice!");
}