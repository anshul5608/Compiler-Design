#include <stdarg.h>

void printMany(int count, ...) {
    va_list args;
    va_start(args, count);
    va_end(args);
}

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int main() {
    printMany(3, 10, 20, 30);
    int f = factorial(5);

    auto add = [](int a, int b) { return a + b; };
    add(2, 3);

    return 0;
}
