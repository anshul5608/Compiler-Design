int main() {
    int val = 100;
    int *ptr = &val;         
    int **multiPtr = &ptr;
    int &ref = val;  

    int *dynamicArr = new int[5];
    delete[] dynamicArr;

    return 0;
}
