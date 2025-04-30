#include <stdio.h>

#define ROW_X 4
#define COL_X 8
#define ROW_A 8
#define COL_A 4

int main(void) {
    // Input matrix X (4x8).
    int X[ROW_X][COL_X] = {
        { 0,  1,  2,  3,  4,  5,  6,  7 },
        { 1,  2,  3,  4,  5,  6,  7,  8 },
        { 2,  3,  4,  5,  6,  7,  8,  9 },
        { 3,  4,  5,  6,  7,  8,  9, 10 }
    };

    // Coefficient matrix A (8x4).
    int A[ROW_A][COL_A] = {
        {  3, 8, 18, 1 },
        {  22, 15, 40, 10 },
        {  11, 2,  3, 4 },
        {  1,  4,  2,  0 },
        {  8,  12,  16,  2 },
        {  3,  6,  9,  12 },
        {  1,  1,  1,  1 },
        {  2,  2,  2,  2 }
    };


    // Result matrix P (4x4). Initialize to 0 so we can safely accumulate.
    int P[ROW_X][COL_A] = {{0}};

    // Perform the matrix multiplication P = X * A
    for (int i = 0; i < ROW_X; i++) {
        for (int j = 0; j < COL_A; j++) {
            // We already zero-initialized P[i][j], so we can just add:
            for (int k = 0; k < COL_X; k++) {
                P[i][j] += X[i][k] * A[k][j];
            }
        }
    }

    // Display P
	printf("Resulting Matrix P (4x4):\n");
	printf("Resulting Matrix P (4x4):\n");
	/* print result matrix */
	for (int i = 0; i < 4; ++i) {
	    for (int j = 0; j < 4; ++j)
	        printf("%4d ", P[i][j]);
		    printf("\n");              /* <- newline, forces flush */
	}
	uart_wait_tx_done();            /* <- wait for UART to drain */
	return 0;                       /* program may now end       */

}

