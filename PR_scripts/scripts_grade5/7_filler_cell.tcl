selectInst PcornerUL
selectInst PGND1
selectInst tck_pad
selectInst trstn_pad
selectInst clk_pad
selectInst PGND3
selectInst rst_pad
selectInst fetch_en_pad
selectInst PGND2
spaceIoInst -fixSide left -space 340
deselectAll


selectInst PcornerLR
selectInst PVDD2
selectInst uart_dtr_pad
selectInst PVDD4
selectInst gpio_out_pad
selectInst PVDD3
selectInst tdo_pad
selectInst uart_rx_pad
selectInst PVDD1
spaceIoInst -fixSide right -space 340
deselectAll


selectInst PcornerUR
selectInst uart_rts_pad
selectInst uart_tx_pad
selectInst spi_sdo3_pad
selectInst spi_sdo2_pad
selectInst spi_sdo1_pad
selectInst spi_sdo0_pad
selectInst spi_mode_pad1
selectInst spi_mode_pad0
spaceIoInst -fixSide top -space 340
deselectAll

selectInst PcornerLL
selectInst tms_pad
selectInst tdi_pad
selectInst spi_clk_pad
selectInst spi_cs_pad
selectInst spi_sdi0_pad
selectInst spi_sdi1_pad
selectInst spi_sdi2_pad
selectInst spi_sdi3_pad
spaceIoInst -fixSide bottom -space 340
deselectAll

# After adjusting dist between io
addIoFiller -cell PADSPACE_74x1u -prefix IO_FILLER -side n
addIoFiller -cell PADSPACE_74x1u -prefix IO_FILLER -side s
addIoFiller -cell PADSPACE_74x1u -prefix IO_FILLER -side w
addIoFiller -cell PADSPACE_74x1u -prefix IO_FILLER -side e

checkPlace
