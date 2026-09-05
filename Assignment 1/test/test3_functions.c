#include <stdarg.h>

// Variable arguments
void printMany(int count, ...) {
    va_list args;
    va_start(args, count);
    va_end(args);
}

// Recursive function
int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int main() {
    printMany(3, 10, 20, 30);
    int f = factorial(5);

    // Lambda function (C++ style)
    auto add = [](int a, int b) { return a + b; };
    add(2, 3);

    return 0;
}