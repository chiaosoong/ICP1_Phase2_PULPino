#include <stdint.h>
#include <stdio.h>
#include <string.h>

// --------------------- 硬件固定参数定义 ---------------------
// 参数固化：
// - IFM: 28x28 (8-bit)
// - Filter: 5x5 (8-bit)
// - OFM: 24x24 (32-bit)
// - Padding=0, Stride=1
// ----------------------------------------------------------

// --------------------- 寄存器映射定义 -----------------------
#define CONV_ACCEL_BASE  ((volatile uint32_t *)0x1A103000)

// 控制与状态寄存器
#define CTRL_REG         (CONV_ACCEL_BASE[0])
#define STATUS_REG       (CONV_ACCEL_BASE[1])
#define START_CONV       (1 << 0)
#define CONV_DONE        (1 << 0)

// 数据缓冲区地址
#define IFM_ADDR         ((volatile uint8_t *)(CONV_ACCEL_BASE + 0x000))  // 8-bit
#define FILTER_ADDR      ((volatile uint8_t *)(CONV_ACCEL_BASE + 0x310))  // 8-bit
#define OFM_ADDR         ((volatile uint32_t *)(CONV_ACCEL_BASE + 0x400)) // 32-bit

// --------------------- 函数实现 -----------------------------

// 加载 IFM
void load_ifm(const uint8_t *ifm_data) {
    for (int i = 0; i < 28 * 28; ++i) {
        IFM_ADDR[i] = ifm_data[i];
    }
}

// 加载 Filter
void load_filter(const uint8_t *filter_weights) {
    for (int i = 0; i < 5 * 5; ++i) {
        FILTER_ADDR[i] = filter_weights[i];
    }
}

// 触发卷积计算
void start_conv() {
    CTRL_REG = START_CONV;
}

// 等待完成
void wait_for_done() {
    while (!(STATUS_REG & CONV_DONE));
}

// 读取 OFM
void read_ofm(uint32_t *output_buffer) {
    for (int i = 0; i < 24 * 24; ++i) {
        output_buffer[i] = OFM_ADDR[i];
    }
}

// 打印 OFM
void print_ofm(const uint32_t ofm[24][24]) {
    printf("OFM(Center 8x8):\n");
    for (int i = 8; i < 16; i++) {
        for (int j = 8; j < 16; j++) {
            printf("%8u ", ofm[i][j]);
        }
        printf("\n");
    }
}

// --------------------- 主程序 -----------------------------
int main() {
    // 定义输入、滤波器和输出缓冲区
    uint8_t ifm[28][28] = {0};
    uint8_t filter[5][5] = {0};
    uint32_t output[24][24] = {0};
	
	// ========== 填充测试数据 ==========
    // 1. 输入特征图：中心5x5区域为255
    for (int i = 12; i < 17; i++) {
        for (int j = 12; j < 17; j++) {
            ifm[i][j] = 255;
        }
    }

    // 2. 滤波器：全255滤波器
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            filter[i][j] = 255;
        }
    }

    // 加载数据
    load_ifm((uint8_t *)ifm);
    load_filter((uint8_t *)filter);

    // 启动计算
    start_conv();
    wait_for_done();

    // 读取结果
    read_ofm((uint32_t *)output); 
	print_ofm(output);

    return 0;
}

