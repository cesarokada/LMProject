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

    printf("----------------- Matrix Resultante --------------------\n");

    extern int **multiply_asm(int**, int**);

    int **matrixResult = multiply_asm(matrixA, matrixC);
    //matrixResult = sumMatrix(matrixResult, matrixB);

    printMatrix(matrixResult);

    int soma = 0;

    for (i = 0; i < L; i++) {
        soma += matrixResult[i][i];
    }

    printf("EIS A PORRA DA SOMA: %3d\n\n", soma);

    return 0;
}

