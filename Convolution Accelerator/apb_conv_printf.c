#include <stdint.h>
#include <stdio.h>
#include <string.h>

// --------------------- 硬件固定参数定义 ---------------------
#define CONV_ACCEL_BASE  ((uint32_t *)0x1A103000)

// 控制与状态寄存器
#define CTRL_REG         (*(volatile uint8_t *)((uint32_t)CONV_ACCEL_BASE))
#define STATUS_REG       (*(volatile uint32_t *)((uint32_t)CONV_ACCEL_BASE + 0x004))
#define START_CONV       (1 << 0)
#define CONV_DONE        (1 << 0)

// 数据缓冲区地址
#define IFM_ADDR         ((volatile uint8_t *)((uint32_t)CONV_ACCEL_BASE + 0x100))
#define OFM_ADDR         ((volatile uint32_t *)((uint32_t)CONV_ACCEL_BASE + 0x008))

// --------------------- 函数实现 -----------------------------

void load_ifm(const uint8_t *ifm_data) {
    //printf("Loading ifm...\n");
    for (int i = 0; i < 28 * 28; ++i) {
        IFM_ADDR[i] = ifm_data[i];
    }
}

void start_conv() {
    CTRL_REG = START_CONV;
    //printf("CONV starts\n");
}

void wait_for_done() {
    while (STATUS_REG != 1) {
        //printf("Processing...\n");
    }
}

void read_ofm(uint32_t *output_buffer) {
    //printf("Reading ofm...\n");
    for (int i = 0; i < 24 * 24; ++i) {
        output_buffer[i] = OFM_ADDR[i];
    }
}

void print_ofm(const uint32_t ofm[24][24]) {
    //printf("OFM(Center 8x8):\n");
    for (int i = 0; i < 24; i++) {
        for (int j = 0; j < 24; j++) {
            //printf("%10u ", ofm[i][j]);
        }
        //printf("\n");
    }
}

int main() {
    uint8_t ifm[28][28] = {0};
    uint32_t output[24][24] = {0};

    for (int i = 4; i < 24; i++) {
        for (int j = 4; j < 24; j++) {
            ifm[i][j] = 1;
        }
    }

    start_conv();
    load_ifm((uint8_t *)ifm);
    wait_for_done();
    read_ofm((uint32_t *)output);
    print_ofm(output);

    return 0;
}

