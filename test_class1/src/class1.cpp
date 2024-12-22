
#include "class1.hpp"

int Calculator::add(int a, int b)
{
    return(a+b);
}

std::string Calculator::greet(const std::string &name)
{
    return("Hello, " + name + "!");
}