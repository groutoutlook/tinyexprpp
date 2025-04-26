# TinyExpr++

- More at original [repo](https://github.com/Blake-Madden/tinyexpr-plusplus)

---
Please refer to the [TinyExpr++ Reference Manual](docs/TinyExpr++ReferenceManual.pdf)
for a full list of features.

# Binding

## ... to Custom Functions

*TinyExpr++* can also call custom functions. Here is a short example:

```cpp
double my_sum(double a, double b)
    {
    /* Example function that adds two numbers together. */
    return a + b;
    }

te_parser tep;
tep.set_variables_and_functions(
{
    { "mysum", my_sum } // function pointer
});

const double r = tep.evaluate("mysum(5, 6)");
// will be 11
```

Here is an example of using a lambda:

```cpp
te_parser tep;
tep.set_variables_and_functions({
    { "mysum",
        [](double a, double b) noexcept
            { return a + b; } }
    });

const double r = tep.evaluate("mysum(5, 6)");
// will be 11
```

## ... to Custom Classes

A class derived from `te_expr` can be bound to custom functions. This enables you to
have full access to an object (via these functions) when parsing an expression.

The following demonstrates creating a `te_expr`-derived class which contains an array of values:

```cpp
class te_expr_array : public te_expr
    {
public:
    explicit te_expr_array(const te_variable_flags type) noexcept :
        te_expr(type) {}
    std::array<double, 5> m_data = { 5, 6, 7, 8, 9 };
    };
```

Next, create two functions that can accept this object and perform
actions on it. (Note that proper error handling is not included for brevity.):

```cpp
// Returns the value of a cell from the object's data.
double cell(const te_expr* context, double a)
    {
    auto* c = dynamic_cast<const te_expr_array*>(context);
    return static_cast<double>(c->m_data[static_cast<size_t>(a)]);
    }

// Returns the max value of the object's data.
double cell_max(const te_expr* context)
    {
    auto* c = dynamic_cast<const te_expr_array*>(context);
    return static_cast<double>(
        *std::max_element(c->m_data.cbegin(), c->m_data.cend()));
    }
```

Finally, create an instance of the class and connect the custom functions to it,
while also adding them to the parser:

```cpp
te_expr_array teArray{ TE_DEFAULT };

te_parser tep;
tep.set_variables_and_functions(
    {
        {"cell", cell, TE_DEFAULT, &teArray},
        {"cellmax", cell_max, TE_DEFAULT, &teArray}
    });

// change the object's data and evaluate their summation
// (will be 30)
teArray.m_data = { 6, 7, 8, 5, 4 };
auto result = tep.evaluate("SUM(CELL 0, CELL 1, CELL 2, CELL 3, CELL 4)");

// call the other function, getting the object's max value
// (will be 8)
res = tep.evaluate("CellMax()");
```

