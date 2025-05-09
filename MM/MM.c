#include <stdio.h>

#define ROW_X 4
#define COL_X 8
#define ROW_A 8
#define COL_A 4

int main(void) {
    // Input matrix X (4x8)
    int X[ROW_X][COL_X] = {
        { 0, 1, 2, 3, 4, 5, 6, 7 },
        { 1, 2, 3, 4, 5, 6, 7, 8 },
        { 2, 3, 4, 5, 6, 7, 8, 9 },
        { 3, 4, 5, 6, 7, 8, 9, 10 }
    };

    // Coefficient matrix A (8x4)
    int A[ROW_A][COL_A] = {
        { 3, 8, 18, 1 },
        { 22, 15, 40, 10 },
        { 11, 2, 3, 4 },
        { 1, 4, 2, 0 },
        { 8, 12, 16, 2 },
        { 3, 6, 9, 12 },
        { 1, 1, 1, 1 },
        { 2, 2, 2, 2 }
    };

    // Result matrix P (4x4), initialized to zero
    int P[ROW_X][COL_A] = {{0}};

    // Perform matrix multiplication with detailed debugging
    for (int i = 0; i < ROW_X; i++) {
        for (int j = 0; j < COL_A; j++) {
            P[i][j] = 0; // Ensure initialization
            for (int k = 0; k < COL_X; k++) {
                int product = X[i][k] * A[k][j];
                P[i][j] += product;
		if (k == 7)
	        	printf("P[%d][%d] = %d\n", i, j, P[i][j]);
            }
        }
    }
/*

	printf("Resulting Matrix P (4x4):\n");
	for (int i = 0; i < 4; ++i) {
	    for (int j = 0; j < 4; ++j)
	        printf("%4d ", P[i][j]);
		    printf("\n");       
	}
*/
    return 0;
}

