#include <stdint.h>
#include <stdio.h>
 
#define H   28
#define W   28
#define FH   5
#define FW   5
#define OH  (H - FH + 1)
#define OW  (W - FW + 1)
 
static uint8_t  ifm[H][W];
static uint8_t  filter[FH][FW];
static uint32_t ofm[OH][OW];
 
int main(void) {
    for (int y = 0; y < H; y++)
        for (int x = 0; x < W; x++)
            ifm[y][x] = 0;

    for (int fy = 0; fy < FH; fy++)
        for (int fx = 0; fx < FW; fx++)
            filter[fy][fx] = 0;
 
    static uint8_t filter[FH][FW] = {
    {255, 255, 255, 255, 255},
    {255, 255, 255, 255, 255},
    {255, 255, 255, 255, 255},
    {255, 255, 255, 255, 255},
    {255, 255, 255, 255, 255}
    };
 
    for (int y = 4; y < 24; y++)
        for (int x = 4; x < 24; x++)
            ifm[y][x] = 1;
 
    for (int out_y = 0; out_y < OH; out_y++) {
        for (int out_x = 0; out_x < OW; out_x++) {
            int32_t sum = 0;
            for (int fy = 0; fy < FH; fy++) {
                for (int fx = 0; fx < FW; fx++) {
                    sum += (int32_t)ifm[out_y + fy][out_x + fx]
                         * (int32_t)filter[fy][fx];
                }
            }
            ofm[out_y][out_x] = (uint32_t)sum;
            //printf("OFM[%d][%d] = %10u\n", out_y, out_x, ofm[out_y][out_x]);
        }
    }
 
    return 0;
}
