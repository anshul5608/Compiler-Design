// Test 1: arithmetic, relational, logical, and assignment operators
int main() {
    int a = 10;
    int b = 3;
    int sum = a + b;
    int diff = a - b;
    int prod = a * b;
    int quot = a / b;
    int rem = a % b;

    if (a > b && b != 0 || !(a == b)) {
        a = a + 1;
    }

    return 0;
}
