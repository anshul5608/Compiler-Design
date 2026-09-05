int main() {
    int val = 100;
    int *ptr = &val;         // Pointer
    int **multiPtr = &ptr;   // Multi-level pointer
    int &ref = val;          // Reference

    // Dynamic memory allocation (C++ style keywords as example)
    int *dynamicArr = new int[5];
    delete[] dynamicArr;

    return 0;
}