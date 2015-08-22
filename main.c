#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define L 3

int **initMatrix() {
    int **matrix = (int**) malloc(sizeof(int*) * L);
    int i;
    for (i = 0; i < L; i++) {
        matrix[i] = (int*) malloc(sizeof(int) * L);
    }

    return matrix;
}

int **multiplyMatrix(int **m1, int **m2) {
    int total = 0.0;

    int **resultantMatrix = initMatrix();

    int i, j, k;

    for (i = 0; i < L; i++) {
        for (j = 0; j < L; j++) {
            for (k = 0; k < L; k++)
                total += m1[i][k] * m2[k][j];

            resultantMatrix[i][j] = total;
            total = 0.0;
        }
    }

    return resultantMatrix;
}

int **sumMatrix(int **m1, int **m2) {

    int **resultantMatrix = initMatrix();

    int i, j;

    for (i = 0; i < L; i++) {
        for (j = 0; j < L; j++) {
            resultantMatrix[i][j] = m1[i][j] + m2[i][j];
        }
    }

    return resultantMatrix;
}

int diagonal(int **m) {
    int sum = 0, i, j;

    for (i = 0; i < L; i++)
        for (j = 0; j < L; j++)
            if (i == j)
                sum += m[i][j];

    return sum;
}

void buildMatrix(int** matrix) {
    int i, j;

    for (i = 0; i < L; i++)
        for (j = 0; j < L; j++)
            matrix[i][j] = rand() % 10;
}

void printMatrix(int** matrix) {
    int i, j;

    for (i = 0; i < L; i++) {
        for (j = 0; j < L; j++) {
           printf("%d   ",matrix[i][j]);
        }
        printf("\n");
    }
}

int main() {
    srand(time(NULL));

    int i;

    int **matrixA, **matrixB, **matrixC;

    matrixA = (int **) malloc (L * sizeof(int *));
    matrixB = (int **) malloc (L * sizeof(int *));
    matrixC = (int **) malloc (L * sizeof(int *));

    for (i = 0; i < L; i ++) {
        matrixA [i] = (int *) malloc (L * sizeof (int));
        matrixB [i] = (int *) malloc (L * sizeof (int));
        matrixC [i] = (int *) malloc (L * sizeof (int));
    }

    printf("----------------- Matrix A --------------------\n");

    buildMatrix(matrixA);
    printMatrix(matrixA);

    printf("----------------- Matrix B --------------------\n");

    buildMatrix(matrixB);
    printMatrix(matrixB);

    printf("----------------- Matrix C --------------------\n");

    buildMatrix(matrixC);
    printMatrix(matrixC);

    printf("----------------- Codigo C --------------------\n");

    //init tempo
    int **cResult = sumMatrix(multiplyMatrix(matrixA, matrixC), matrixB);
    int cDiagonal = diagonal(cResult);
    //end tempo

    printMatrix(cResult);

    printf("Soma da diagonal: %d\n", cDiagonal);

    printf("----------------- Matrix Codigo ASM --------------------\n");

    int asmDiagonal = 0;
    int **asmResult = initMatrix();

    extern int **multiply_asm(int**, int**, int**, int**, int*, int);

    //init tempo
    asmResult = multiply_asm(matrixA, matrixC, matrixB, asmResult, &asmDiagonal, L);
    //end tempo

    printMatrix(asmResult);

    printf("Soma da diagonal: %d\n", asmDiagonal);

    return 0;
}

