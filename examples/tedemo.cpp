#include "tinyexpr.h"
#include <format>
#include <iostream>
#include <print>
#include <regex>

int main(int argc, char *argv[])
{
	te_parser   tep;
	std::string c1 = "sqrt(5^2+7^2+11^2+(8-2)^2)";
	auto        r1 = tep.evaluate(c1);
	std::println("{} eval to {}", c1, r1);

	te_type x{2}, y{5}, sum0{9};
	const std::set<te_variable> lookup{
	    {"x", &x},
	    {"y", &y},
	    {"sum0", sum0}};
	tep.set_variables_and_functions({{"x", &x}, {"y", &y}});

	std::string c2 = "x+y*90";
	auto        r2 = tep.evaluate(c2);
	std::println("{} eval to {}", c2, r2);


	return EXIT_SUCCESS;
}
