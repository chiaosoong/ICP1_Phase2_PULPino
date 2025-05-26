#include <stdint.h>
#include <stdio.h>
#include <string.h>

// --------------------- 硬件固定参数定义 ---------------------
#define CONV_ACCEL_BASE  ((uint32_t *)0x1A103000)

// 控制与状态寄存器
#define CTRL_REG         (*(volatile uint8_t *)((uint32_t)CONV_ACCEL_BASE))
#define STATUS_REG       (*(volatile uint32_t *)((uint32_t)CONV_ACCEL_BASE + 0x004))
#define START_CONV       (1 << 0)

// 数据缓冲区地址
#define IFM_ADDR         ((volatile uint8_t *)((uint32_t)CONV_ACCEL_BASE + 0x100))

// --------------------- 函数实现 -----------------------------


void start_conv() {
    CTRL_REG = START_CONV;
}

void load_ifm() {
   for (int i = 4; i < 24; i++) {
        for (int j = 4; j < 24; j++) {
            IFM_ADDR[i * 28 + j] = 1;
        }
    }
}

void wait_for_done() {
    while (STATUS_REG != 1) {
    }
}


int main() {

    start_conv();
    load_ifm();
    wait_for_done();

    return 0;
}

