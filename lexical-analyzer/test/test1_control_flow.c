#include <stdio.h>

int main() {
    int numbers[10];
    char name[50];
    int matrix[3][3]; // Multi-dimensional array

    printf("Enter a number: ");
    scanf("%d", &numbers[0]);

    matrix[0][0] = numbers[0];
    
    return 0;
}