#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define L 4

void buildMatrix(int** matrix){
    int i, j;

    srand(time(NULL));

    for(i = 0; i < L; i++)
        for(j = 0; j < L; j++)
            matrix[i][j] = rand() % 100;
}

void printMatrix(int** matrix){
    int i,j;

    for(i = 0; i < L; i++){
        for(j = 0; j < L; j++){
           printf("%d   ",matrix[i][j]);
        }
        printf("\n");
    }
}

int main()
{
    int i;
    
    int **matrixA, **matrixB, **matrixC;
    
    matrixA = (int **) malloc (L * sizeof(int *));
    matrixB = (int **) malloc (L * sizeof(int *));
    matrixC = (int **) malloc (L * sizeof(int *));
    
    for(i = 0; i < L; i ++){
        matrixA [i] = (int *) malloc (L * sizeof (int));
        matrixB [i] = (int *) malloc (L * sizeof (int));
        matrixC [i] = (int *) malloc (L * sizeof (int));
    }

/*
    printf("-----------------Matrix A --------------------\n");
    
    buildMatrix(matrixA);
    printMatrix(matrixA);

    printf("-----------------Matrix B --------------------\n");
    
    buildMatrix(matrixB);
    printMatrix(matrixB);

    printf("-----------------Matrix C --------------------\n");
    
    buildMatrix(matrixC);
    printMatrix(matrixC);
*/
    
    return 0;
}

