#include <stdio.h>

#define ROW_X 4
#define COL_X 8
#define ROW_A 8
#define COL_A 4

int main() {
    int X[ROW_X][COL_X] = {
        {1,0,1,0,1,0,1,0},
        {0,1,0,1,0,1,0,1},
        {1,1,1,1,0,0,0,0},
        {0,0,1,1,1,1,0,0}
    };

    int A[ROW_A][COL_A] = {
        {1,0,1,0},
        {0,1,0,1},
        {1,0,1,0},
        {0,1,0,1},
        {1,1,0,0},
        {0,0,1,1},
        {1,1,1,1},
        {0,0,0,0}
    };

    int P[ROW_X][COL_A] = {0}; 

    for (int i = 0; i < ROW_X; i++) {
        for (int j = 0; j < COL_A; j++) {
            for (int k = 0; k < COL_X; k++) {
                P[i][j] += X[i][k] * A[k][j];
            }
        }
    }

    printf("Final Result:");
    printf("P[0][0] = %d\n", P[0][0]);
    printf("P[1][1] = %d\n", P[1][1]);
    printf("P[2][2] = %d\n", P[2][2]);
    printf("P[3][3] = %d\n", P[3][3]);

    return 0;
}

