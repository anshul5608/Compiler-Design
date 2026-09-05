#include <stdio.h>

int multiply(int a, int b) { return a * b; }

// Command line input
int main(int argc, char *argv[]) {
    static int runCount = 0; // Static keyword

    // Function pointer
    int (*op)(int, int) = &multiply;

    switch (argc) { // Switch cases
        case 1: break;
        default: break;
    }

    // File manipulation
    FILE *fp = fopen("output.txt", "w");
    if (fp != NULL) {
        fclose(fp);
    }

    return 0;
}