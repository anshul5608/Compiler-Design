#include <stdio.h>

int multiply(int a, int b) { return a * b; }

int main(int argc, char *argv[]) {
    static int runCount = 0; 

    int (*op)(int, int) = &multiply;

    switch (argc) {
        case 1: break;
        default: break;
    }

    FILE *fp = fopen("output.txt", "w");
    if (fp != NULL) {
        fclose(fp);
    }

    return 0;
}
