set DESIGN pulpino_padstop

# RTL路径
set RTL "${ROOT}/rtl"
set INCLUDES "${ROOT}/rtl/includes"
set COMPONENTS "${ROOT}/rtl/components"
set CONV "${ROOT}/rtl/CONV"
set IPS "${ROOT}/ips"
set_attribute script_search_path $SYNT_SCRIPT /

set_attribute init_hdl_search_path [list $RTL $INCLUDES $COMPONENTS $IPS ${IPS}/apb/apb_gpio ${IPS}/apb/apb_event_unit/include ${IPS}/apb/apb_event_unit ${IPS}/adv_dbg_if/rtl ${IPS}/axi/axi_slice_dc ${IPS}/fpu/hdl/fpu_fmac ${IPS}/apb/apb2per ${IPS}/apb/apd_fll_if ${IPS}/apb/apd_node ${IPS}/apb/apd_pulpino ${IPS}/apb/apb_timer ${IPS}/riscv/include ${IPS}/axi/axi2apb ${IPS}/axi/axi_mem_if_DP ${IPS}/axi/axi_slice ${IPS}/axi/axi_spi_slave ${IPS}/axi/core2axi ${IPS}/fpu/hdl/fpu_div_sqrt_tp_nlp ${IPS}/fpu/hdl/fpu_v0.1 ${IPS}/fpu/hdl/fpu_utils ${IPS}/riscv ${IPS}/apb/apb_uart_sv ${IPS}/zero-riscy/include ${IPS}/zero-riscy ${IPS}/apb/apb_uart ${IPS}/apb/apb_fll_if ${IPS}/apb/apb_pulpino ${IPS}/apb/apb_node] /

# 库文件路径
set_attribute init_lib_search_path { \
/usr/local-eit/cad2/cmpstm/stm065v536/CORE65LPLVT_5.1/libs \
/usr/local-eit/cad2/cmpstm/stm065v536/CLOCK65LPLVT_3.1/libs \
/usr/local-eit/cad2/cmpstm/oldmems/mem2010/SPHDL100909-40446@1.0/libs \
/usr/local-eit/cad2/cmpstm/dicp18/lu_pads_65nm \
} /

# 库文件名称
set_attribute library { \
CLOCK65LPLVT_nom_1.20V_25C.lib \
CORE65LPLVT_nom_1.20V_25C.lib \
SPHDL100909_nom_1.20V_25C.lib \
Pads_Oct2012.lib} /

# put all your design files here

set DESIGN_FILES_v1	   "${IPS}/adv_dbg_if/rtl/adbg_crc32.v \
						${IPS}/adv_dbg_if/rtl/adbg_tap_top.v \
						${IPS}/axi/axi_slice_dc/dc_data_buffer.v \
						${IPS}/axi/axi_slice_dc/dc_full_detector.v \
						${IPS}/axi/axi_slice_dc/dc_synchronizer.v \
						${IPS}/axi/axi_slice_dc/dc_token_ring.v \
						${IPS}/axi/axi_slice_dc/dc_token_ring_fifo_dout.v \
						${IPS}/axi/axi_slice_dc/dc_token_ring_fifo_din.v"

set DESIGN_FILES_sv1   "${IPS}/axi/axi_slice/axi_buffer.sv \
						${IPS}/axi/axi_slice_dc/axi_slice_dc_slave.sv \
						${IPS}/axi/axi_slice_dc/axi_slice_dc_master.sv \
						${IPS}/adv_dbg_if/rtl/adbg_axi_biu.sv"

set DESIGN_FILES_sv2   "${IPS}/adv_dbg_if/rtl/adbg_axi_module.sv \
						${IPS}/adv_dbg_if/rtl/adbg_lint_biu.sv \
						${IPS}/adv_dbg_if/rtl/adbg_lint_module.sv \
						${IPS}/adv_dbg_if/rtl/adbg_or1k_biu.sv"

set DESIGN_FILES_v2	   "${IPS}/adv_dbg_if/rtl/syncflop.v \
						${IPS}/adv_dbg_if/rtl/syncreg.v \
						${IPS}/adv_dbg_if/rtl/bytefifo.v"

set DESIGN_FILES_sv3   "${IPS}/adv_dbg_if/rtl/adbg_or1k_module.sv \
						${IPS}/adv_dbg_if/rtl/adbg_or1k_status_reg.sv \
						${IPS}/adv_dbg_if/rtl/adbg_top.sv \
						${IPS}/adv_dbg_if/rtl/adv_dbg_if.sv \
						${IPS}/adv_dbg_if/rtl/adbg_axionly_top.sv\
						${IPS}/adv_dbg_if/rtl/adbg_lintonly_top.sv\
						${IPS}/apb/apb2per/apb2per.sv \
				        ${INCLUDES}/config.sv \
					    ${INCLUDES}/apb_bus.sv \
						${IPS}/apb/apb_event_unit/apb_event_unit.sv \
						${IPS}/apb/apb_fll_if/apb_fll_if.sv \
						${IPS}/apb/apb_gpio/apb_gpio.sv \
						${IPS}/apb/apb_node/apb_node.sv \
						${IPS}/apb/apb_node/apb_node_wrap.sv \
						${IPS}/apb/apb_pulpino/apb_pulpino.sv \
						${IPS}/apb/apb_timer/timer.sv \
						${IPS}/apb/apb_timer/apb_timer.sv \
						${IPS}/riscv/include/apu_core_package.sv \
						${IPS}/axi/axi2apb/AXI_2_APB.sv \
						${IPS}/axi/axi2apb/AXI_2_APB_32.sv \
						${IPS}/axi/axi2apb/axi2apb.sv \
						${IPS}/axi/axi2apb/axi2apb32.sv \
					    ${RTL}/axi2apb_wrap.sv \
						${IPS}/axi/axi_node/axi_AR_allocator.sv \
						${IPS}/axi/axi_node/axi_AW_allocator.sv \
						${IPS}/axi/axi_node/axi_FanInPrimitive_Req.sv \
						${IPS}/axi/axi_node/apb_regs_top.sv \
						${IPS}/axi/axi_node/axi_node_wrap.sv \
						${IPS}/axi/axi_node/axi_node_wrap_with_slices.sv \
						${IPS}/axi/axi_node/axi_regs_top.sv \
						${IPS}/axi/axi_node/axi_RR_Flag_Req.sv \
						${IPS}/axi/axi_node/axi_ArbitrationTree.sv"

set DESIGN_FILES_sv4    "${IPS}/fpu/hdl/fpu_fmac/fpu_defs_fmac.sv \
						${IPS}/fpu/hdl/fpu_fmac/preprocess_fmac.sv \
						${IPS}/fpu/hdl/fpu_fmac/booth_encoder.sv \
						${IPS}/fpu/hdl/fpu_fmac/booth_selector.sv \
						${IPS}/fpu/hdl/fpu_fmac/pp_generation.sv \
						${IPS}/fpu/hdl/fpu_fmac/wallace.sv \
						${IPS}/fpu/hdl/fpu_fmac/aligner.sv \
						${IPS}/fpu/hdl/fpu_fmac/CSA.sv \
						${IPS}/fpu/hdl/fpu_fmac/adders.sv \
						${IPS}/fpu/hdl/fpu_fmac/LZA.sv \
						${IPS}/fpu/hdl/fpu_fmac/fpu_norm_fmac.sv \
						${IPS}/fpu/hdl/fpu_fmac/fmac.sv"

set DESIGN_FILES_sv5  "${IPS}/zero-riscy/include/zeroriscy_defines.sv \
						${IPS}/zero-riscy/include/zeroriscy_tracer_defines.sv \
						${IPS}/zero-riscy/include/zeroriscy_config.sv \
						${IPS}/zero-riscy/zeroriscy_alu.sv \
						${IPS}/zero-riscy/zeroriscy_compressed_decoder.sv \
						${IPS}/zero-riscy/zeroriscy_controller.sv \
						${IPS}/zero-riscy/zeroriscy_cs_registers.sv \
						${IPS}/zero-riscy/zeroriscy_debug_unit.sv \
						${IPS}/zero-riscy/zeroriscy_decoder.sv \
						${IPS}/zero-riscy/zeroriscy_int_controller.sv \
						${IPS}/zero-riscy/zeroriscy_ex_block.sv \
						${IPS}/zero-riscy/zeroriscy_id_stage.sv \
						${IPS}/zero-riscy/zeroriscy_if_stage.sv \
						${IPS}/zero-riscy/zeroriscy_load_store_unit.sv \
						${IPS}/zero-riscy/zeroriscy_multdiv_slow.sv \
						${IPS}/zero-riscy/zeroriscy_multdiv_fast.sv \
						${IPS}/zero-riscy/zeroriscy_prefetch_buffer.sv \
						${IPS}/zero-riscy/zeroriscy_fetch_fifo.sv \
						${IPS}/zero-riscy/zeroriscy_core.sv \
						${IPS}/zero-riscy/zeroriscy_register_file.sv "

set DESIGN_FILES_conv  "${CONV}/convolution_accelerator.v \
						${CONV}/mac.v \
						${CONV}/parse_input_row.v \
						${CONV}/ROM.v"	

set DESIGN_FILES_sv6   "${IPS}/axi/axi_node/axi_BR_allocator.sv \
						${IPS}/axi/axi_node/axi_BW_allocator.sv \
						${IPS}/axi/axi_node/axi_DW_allocator.sv \
						${IPS}/axi/axi_node/axi_address_decoder_AR.sv \
						${IPS}/axi/axi_node/axi_address_decoder_AW.sv \
						${IPS}/axi/axi_node/axi_address_decoder_BR.sv \
						${IPS}/axi/axi_node/axi_address_decoder_BW.sv \
						${IPS}/axi/axi_node/axi_address_decoder_DW.sv \
						${IPS}/axi/axi_slice/axi_ar_buffer.sv \
						${IPS}/axi/axi_slice/axi_aw_buffer.sv \
						${IPS}/axi/axi_slice/axi_b_buffer.sv \
						${RTL}/includes/axi_bus.sv \
						${IPS}/axi/axi_mem_if_DP/axi_mem_if_SP.sv \
						${RTL}/axi_mem_if_SP_wrap.sv \
						${IPS}/axi/axi_node/axi_multiplexer.sv \
						${IPS}/axi/axi_node/axi_node.sv \
						${RTL}/axi_node_intf_wrap.sv \
						${IPS}/axi/axi_slice/axi_r_buffer.sv \
						${IPS}/axi/axi_mem_if_DP/axi_read_only_ctrl.sv \
						${IPS}/axi/axi_node/axi_request_block.sv \
						${IPS}/axi/axi_node/axi_response_block.sv \
						${IPS}/axi/axi_slice/axi_slice.sv \
						${RTL}/axi_slice_wrap.sv \
						${COMPONENTS}/pulp_clock_mux2.sv \
						${IPS}/axi/axi_slice/axi_w_buffer.sv \
						${IPS}/axi/axi_mem_if_DP/axi_mem_if_MP_Hybrid_multi_bank.sv \
						${IPS}/axi/axi_mem_if_DP/axi_mem_if_multi_bank.sv \
						${IPS}/axi/axi_mem_if_DP/axi_mem_if_DP_hybr.sv \
						${IPS}/axi/axi_mem_if_DP/axi_mem_if_DP.sv \
						${IPS}/axi/axi_mem_if_DP/axi_write_only_ctrl.sv \
						${RTL}/boot_code.sv \
						${RTL}/boot_rom_wrap.sv \
						${RTL}/clk_rst_gen.sv \
						${COMPONENTS}/cluster_clock_gating.sv \
						${COMPONENTS}/cluster_clock_inverter.sv \
						${COMPONENTS}/cluster_clock_mux2.sv \
						${IPS}/axi/core2axi/core2axi.sv\
                        ${RTL}/core2axi_wrap.sv\
                        ${RTL}/core_region.sv \
                        ${RTL}/includes/debug_bus.sv \
						${CONV}/apb_conv.sv \
					    ${IPS}/riscv/include/riscv_defines.sv \
						${IPS}/riscv/include/riscv_tracer_defines.sv\
					    ${IPS}/riscv/include/apu_core_package.sv \
						${IPS}/riscv/riscv_alu_basic.sv \
						${IPS}/riscv/riscv_apu_disp.sv \
						${IPS}/riscv/riscv_L0_buffer.sv \
						${IPS}/riscv/riscv_alu.sv \
						${IPS}/riscv/riscv_alu_div.sv \
						${IPS}/riscv/riscv_compressed_decoder.sv \
						${IPS}/riscv/riscv_controller.sv \
						${IPS}/riscv/riscv_core.sv \
						${IPS}/riscv/riscv_cs_registers.sv \
						${IPS}/riscv/riscv_debug_unit.sv \
						${IPS}/riscv/riscv_decoder.sv \
						${IPS}/riscv/riscv_ex_stage.sv \
						${IPS}/riscv/riscv_fetch_fifo.sv \
						${IPS}/riscv/riscv_hwloop_controller.sv \
						${IPS}/riscv/riscv_hwloop_regs.sv \
						${IPS}/riscv/riscv_register_file.sv \
						${IPS}/riscv/riscv_prefetch_buffer.sv \
						${IPS}/riscv/riscv_prefetch_L0_buffer.sv \
						${IPS}/riscv/riscv_id_stage.sv \
						${IPS}/riscv/riscv_if_stage.sv \
						${IPS}/riscv/riscv_int_controller.sv \
						${IPS}/riscv/riscv_load_store_unit.sv \
						${IPS}/riscv/riscv_mult.sv"

set DESIGN_FILES_sv7   "${IPS}/fpu/hdl/fpu_utils/fpu_ff.sv \
						${IPS}/fpu/hdl/fpu_v0.1/fpu_defs.sv \
						${IPS}/fpu/hdl/fpu_v0.1/fpu_core.sv \
						${IPS}/fpu/hdl/fpu_v0.1/fpu_private.sv \
						${IPS}/fpu/hdl/fpu_v0.1/riscv_fpu.sv \
						${IPS}/fpu/hdl/fpu_v0.1/fp_fma_wrapper.sv \
						${IPS}/fpu/hdl/fpu_v0.1/fpexc.sv \
						${IPS}/fpu/hdl/fpu_v0.1/fpu_add.sv \
						${IPS}/fpu/hdl/fpu_v0.1/fpu_ftoi.sv \
						${IPS}/fpu/hdl/fpu_v0.1/fpu_itof.sv \
						${IPS}/fpu/hdl/fpu_v0.1/fpu_mult.sv \
						${IPS}/fpu/hdl/fpu_v0.1/fpu_norm.sv \
						${COMPONENTS}/generic_fifo.sv \
						${IPS}/apb/apb_event_unit/generic_service_unit.sv \
						${RTL}/instr_ram_wrap.sv \
						${IPS}/fpu/hdl/fpu_div_sqrt_tp_nlp/fpu_defs_div_sqrt_tp.sv \
						${IPS}/fpu/hdl/fpu_div_sqrt_tp_nlp/control_tp.sv \
						${IPS}/fpu/hdl/fpu_div_sqrt_tp_nlp/iteration_div_sqrt.sv \
						${IPS}/fpu/hdl/fpu_div_sqrt_tp_nlp/iteration_div_sqrt_first.sv \
						${IPS}/fpu/hdl/fpu_div_sqrt_tp_nlp/fpu_norm_div_sqrt.sv \
						${IPS}/fpu/hdl/fpu_div_sqrt_tp_nlp/nrbd_nrsc_tp.sv \
						${IPS}/fpu/hdl/fpu_div_sqrt_tp_nlp/preprocess.sv \
						${IPS}/fpu/hdl/fpu_div_sqrt_tp_nlp/div_sqrt_top_tp.sv \
                        ${RTL}/periph_bus_wrap.sv \
                        ${RTL}/peripherals.sv \
						${COMPONENTS}/pulp_clock_inverter.sv \
                        ${RTL}/pulpino_top.sv \
                        ${RTL}/ram_mux.sv \
						${COMPONENTS}/rstgen.sv \
						${IPS}/apb/apb_event_unit/sleep_unit.sv \
						${RTL}/sp_ram_wrap.sv \
						${IPS}/axi/axi_spi_slave/spi_slave_axi_plug.sv \
						${IPS}/axi/axi_spi_slave/spi_slave_cmd_parser.sv \
						${IPS}/axi/axi_spi_slave/spi_slave_controller.sv \
						${IPS}/axi/axi_spi_slave/spi_slave_dc_fifo.sv \
						${IPS}/axi/axi_spi_slave/spi_slave_regs.sv \
						${IPS}/axi/axi_spi_slave/spi_slave_rx.sv \
						${IPS}/axi/axi_spi_slave/spi_slave_syncro.sv \
						${IPS}/axi/axi_spi_slave/spi_slave_tx.sv \
						${IPS}/axi/axi_spi_slave/axi_spi_slave.sv \
						${RTL}/axi_spi_slave_wrap.sv \
						${IPS}/apb/apb_uart_sv/apb_uart_sv.sv \
						${IPS}/apb/apb_uart_sv/uart_rx.sv \
						${IPS}/apb/apb_uart_sv/uart_tx.sv \
						${IPS}/apb/apb_uart_sv/io_generic_fifo.sv \
						${IPS}/apb/apb_uart_sv/uart_interrupt.sv"
					 
set DESIGN_FILES_vhd   "${IPS}/apb/apb_uart/apb_uart.vhd \
						${IPS}/apb/apb_uart/slib_clock_div.vhd \
						${IPS}/apb/apb_uart/slib_counter.vhd \
						${IPS}/apb/apb_uart/slib_edge_detect.vhd \
						${IPS}/apb/apb_uart/slib_fifo.vhd \
						${IPS}/apb/apb_uart/slib_input_filter.vhd \
						${IPS}/apb/apb_uart/slib_input_sync.vhd \
						${IPS}/apb/apb_uart/slib_mv_filter.vhd \
						${IPS}/apb/apb_uart/uart_baudgen.vhd \
						${IPS}/apb/apb_uart/uart_interrupt.vhd \
						${IPS}/apb/apb_uart/uart_receiver.vhd \
						${IPS}/apb/apb_uart/uart_transmitter.vhd "

set DESIGN_FILES_v3   "${RTL}/pulpino_padstop.v "

set SYN_EFF medium 
set MAP_EFF medium 
set OPT_EFF medium 

set_attribute syn_generic_effort ${SYN_EFF}
set_attribute syn_map_effort ${MAP_EFF}
set_attribute syn_opt_effort ${OPT_EFF}
set_attribute information_level 5; # Up to maximum 9
