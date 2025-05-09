#include <stdio.h>
#include "my_first_function.h"

#define ROW_X 4
#define COL_X 8
#define ROW_A 8
#define COL_A 4

void performMatrixMultiplication(void) {
    int X[ROW_X][COL_X];
    int A[ROW_A][COL_A];
    int P[ROW_X][COL_A];

    // Initialize X and A
    for (int i = 0; i < ROW_X; i++) {
        for (int j = 0; j < COL_X; j++) {
            X[i][j] = i + j;
        }
    }

    for (int i = 0; i < ROW_A; i++) {
        for (int j = 0; j < COL_A; j++) {
            A[i][j] = i - j;
        }
    }


    //P = X × A
    for (int i = 0; i < ROW_X; i++) {
        for (int j = 0; j < COL_A; j++) {
            for (int k = 0; k < COL_X; k++) {
                P[i][j] += X[i][k] * A[k][j];
            }
        }
    }

    // Display P
    printf("Resulting Matrix P (4x4):\n");
    for (int i = 0; i < ROW_X; i++) {
        for (int j = 0; j < COL_A; j++) {
            printf("%5d ", P[i][j]);
        }
        printf("\n");
    }

}
