#include <stdint.h>
#include <stdio.h>
#include <string.h>

void conv2d_accelerator(
    const uint8_t ifm[28][28],
    const uint8_t filter[5][5],
    uint32_t ofm[24][24])
{
    const int stride = 1;

    for (int out_y = 0; out_y < 24; out_y++) {
        for (int out_x = 0; out_x < 24; out_x++) {
            int32_t sum = 0;
            
            // Filter window
            for (int fy = 0; fy < 5; fy++) {
                for (int fx = 0; fx < 5; fx++) {
                    // Calculate input position
                    int in_y = out_y * stride + fy;
                    int in_x = out_x * stride + fx;
					uint8_t ifm_val = ifm[in_y][in_x];
                    
                    // Multiply and accumulate
                    sum += (int32_t)ifm_val * (int32_t)filter[fy][fx];
                }
            }
            
            // Store 32-bit result
            ofm[out_y][out_x] = (uint32_t)sum;
        }
    }
}

int main() {
    // 初始化测试数据
    uint8_t ifm[28][28] = {0};
    uint8_t filter[5][5] = {0};
    uint32_t ofm[24][24] = {0};

    // 创建测试模式：中心5x5区域为255的输入
    for (int y = 12; y < 17; y++) {
        for (int x = 12; x < 17; x++) {
            ifm[y][x] = 255;
        }
    }

    // 创建全255滤波器
    for (int fy = 0; fy < 5; fy++) {
        for (int fx = 0; fx < 5; fx++) {
            filter[fy][fx] = 255;
        }
    }

    // 执行卷积运算
    conv2d_accelerator(ifm, filter, ofm);

    // 打印输出特征图关键区域
    printf("OFM(Center 8x8):\n");
    for (int y = 8; y < 16; y++) {
        for (int x = 8; x < 16; x++) {
            printf("%8u", ofm[y][x]);
        }
        printf("\n");
    }

    return 0;
}