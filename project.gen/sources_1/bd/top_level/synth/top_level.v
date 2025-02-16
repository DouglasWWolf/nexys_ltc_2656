//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
//Date        : Sun Feb 16 01:19:08 2025
//Host        : simtool-5 running 64-bit Ubuntu 20.04.6 LTS
//Command     : generate_target top_level.bd
//Design      : top_level
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module source_100mhz_imp_MSWE0P
   (clk_in,
    resetn_in,
    sys_clk,
    sys_resetn);
  input clk_in;
  input resetn_in;
  output sys_clk;
  output [0:0]sys_resetn;

  wire clk_in1_0_1;
  wire ext_reset_in_0_1;
  wire system_clock_clk_100mhz;
  wire [0:0]system_reset_peripheral_aresetn;

  assign clk_in1_0_1 = clk_in;
  assign ext_reset_in_0_1 = resetn_in;
  assign sys_clk = system_clock_clk_100mhz;
  assign sys_resetn[0] = system_reset_peripheral_aresetn;
  top_level_clk_wiz_0_0 system_clock
       (.clk_100mhz(system_clock_clk_100mhz),
        .clk_in1(clk_in1_0_1));
  top_level_proc_sys_reset_0_0 system_reset
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(ext_reset_in_0_1),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(system_reset_peripheral_aresetn),
        .slowest_sync_clk(system_clock_clk_100mhz));
endmodule

(* CORE_GENERATION_INFO = "top_level,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=top_level,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=14,numReposBlks=12,numNonXlnxBlks=0,numHierBlks=2,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=7,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=1,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "top_level.hwdef" *) 
module top_level
   (AN,
    CLK100MHZ,
    CPU_RESETN,
    LED,
    SEG,
    SW,
    UART_rxd,
    UART_txd);
  output [7:0]AN;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK100MHZ CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK100MHZ, CLK_DOMAIN top_level_CLK100MHZ, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input CLK100MHZ;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.CPU_RESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.CPU_RESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input CPU_RESETN;
  output [7:0]LED;
  output [7:0]SEG;
  input [2:0]SW;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 UART RxD" *) input UART_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 UART TxD" *) output UART_txd;

  wire [3:0]axi_dac_control_dac_channel;
  wire [3:0]axi_dac_control_dac_cmd;
  wire axi_dac_control_dac_ldac;
  wire axi_dac_control_dac_start;
  wire [15:0]axi_dac_control_dac_value;
  wire axi_uartlite_UART_RxD;
  wire axi_uartlite_UART_TxD;
  wire [2:0]ch_select_0_1;
  wire clk_in1_0_1;
  wire [7:0]display_shim_digit_enable;
  wire [31:0]display_shim_display;
  wire ext_reset_in_0_1;
  wire ltc_2656_csld;
  wire ltc_2656_ldac_out;
  wire ltc_2656_sck;
  wire ltc_2656_sdo;
  wire [7:0]sevenseg_driver_ANODE;
  wire [7:0]sevenseg_driver_CATHODE;
  wire [15:0]sim_ltc_2656_dac_a;
  wire [15:0]sim_ltc_2656_dac_b;
  wire [15:0]sim_ltc_2656_dac_c;
  wire [15:0]sim_ltc_2656_dac_d;
  wire [15:0]sim_ltc_2656_dac_e;
  wire [15:0]sim_ltc_2656_dac_f;
  wire [15:0]sim_ltc_2656_dac_g;
  wire [15:0]sim_ltc_2656_dac_h;
  wire [15:0]sim_ltc_2656_inp_a;
  wire [15:0]sim_ltc_2656_inp_b;
  wire [15:0]sim_ltc_2656_inp_c;
  wire [15:0]sim_ltc_2656_inp_d;
  wire [15:0]sim_ltc_2656_inp_e;
  wire [15:0]sim_ltc_2656_inp_f;
  wire [15:0]sim_ltc_2656_inp_g;
  wire [15:0]sim_ltc_2656_inp_h;
  wire [7:0]sim_ltc_2656_powered;
  wire [23:0]sim_ltc_2656_spi_dataword_out;
  wire source_100mhz_sys_clk;
  wire [0:0]source_100mhz_sys_resetn;
  wire [4:0]system_interconnect_M00_AXI_ARADDR;
  wire [2:0]system_interconnect_M00_AXI_ARPROT;
  wire system_interconnect_M00_AXI_ARREADY;
  wire system_interconnect_M00_AXI_ARVALID;
  wire [4:0]system_interconnect_M00_AXI_AWADDR;
  wire [2:0]system_interconnect_M00_AXI_AWPROT;
  wire system_interconnect_M00_AXI_AWREADY;
  wire system_interconnect_M00_AXI_AWVALID;
  wire system_interconnect_M00_AXI_BREADY;
  wire [1:0]system_interconnect_M00_AXI_BRESP;
  wire system_interconnect_M00_AXI_BVALID;
  wire [31:0]system_interconnect_M00_AXI_RDATA;
  wire system_interconnect_M00_AXI_RREADY;
  wire [1:0]system_interconnect_M00_AXI_RRESP;
  wire system_interconnect_M00_AXI_RVALID;
  wire [31:0]system_interconnect_M00_AXI_WDATA;
  wire system_interconnect_M00_AXI_WREADY;
  wire [3:0]system_interconnect_M00_AXI_WSTRB;
  wire system_interconnect_M00_AXI_WVALID;
  wire [7:0]system_interconnect_M01_AXI_ARADDR;
  wire [2:0]system_interconnect_M01_AXI_ARPROT;
  wire system_interconnect_M01_AXI_ARREADY;
  wire system_interconnect_M01_AXI_ARVALID;
  wire [7:0]system_interconnect_M01_AXI_AWADDR;
  wire [2:0]system_interconnect_M01_AXI_AWPROT;
  wire system_interconnect_M01_AXI_AWREADY;
  wire system_interconnect_M01_AXI_AWVALID;
  wire system_interconnect_M01_AXI_BREADY;
  wire [1:0]system_interconnect_M01_AXI_BRESP;
  wire system_interconnect_M01_AXI_BVALID;
  wire [31:0]system_interconnect_M01_AXI_RDATA;
  wire system_interconnect_M01_AXI_RREADY;
  wire [1:0]system_interconnect_M01_AXI_RRESP;
  wire system_interconnect_M01_AXI_RVALID;
  wire [31:0]system_interconnect_M01_AXI_WDATA;
  wire system_interconnect_M01_AXI_WREADY;
  wire [3:0]system_interconnect_M01_AXI_WSTRB;
  wire system_interconnect_M01_AXI_WVALID;
  wire [63:0]uart_axi_bridge_M_AXI_ARADDR;
  wire uart_axi_bridge_M_AXI_ARREADY;
  wire uart_axi_bridge_M_AXI_ARVALID;
  wire [63:0]uart_axi_bridge_M_AXI_AWADDR;
  wire uart_axi_bridge_M_AXI_AWREADY;
  wire uart_axi_bridge_M_AXI_AWVALID;
  wire uart_axi_bridge_M_AXI_BREADY;
  wire [1:0]uart_axi_bridge_M_AXI_BRESP;
  wire uart_axi_bridge_M_AXI_BVALID;
  wire [31:0]uart_axi_bridge_M_AXI_RDATA;
  wire uart_axi_bridge_M_AXI_RREADY;
  wire [1:0]uart_axi_bridge_M_AXI_RRESP;
  wire uart_axi_bridge_M_AXI_RVALID;
  wire [31:0]uart_axi_bridge_M_AXI_WDATA;
  wire uart_axi_bridge_M_AXI_WREADY;
  wire [3:0]uart_axi_bridge_M_AXI_WSTRB;
  wire uart_axi_bridge_M_AXI_WVALID;

  assign AN[7:0] = sevenseg_driver_ANODE;
  assign LED[7:0] = sim_ltc_2656_powered;
  assign SEG[7:0] = sevenseg_driver_CATHODE;
  assign UART_txd = axi_uartlite_UART_TxD;
  assign axi_uartlite_UART_RxD = UART_rxd;
  assign ch_select_0_1 = SW[2:0];
  assign clk_in1_0_1 = CLK100MHZ;
  assign ext_reset_in_0_1 = CPU_RESETN;
  top_level_axi_dac_control_0_0 axi_dac_control
       (.S_AXI_ARADDR(system_interconnect_M01_AXI_ARADDR),
        .S_AXI_ARPROT(system_interconnect_M01_AXI_ARPROT),
        .S_AXI_ARREADY(system_interconnect_M01_AXI_ARREADY),
        .S_AXI_ARVALID(system_interconnect_M01_AXI_ARVALID),
        .S_AXI_AWADDR(system_interconnect_M01_AXI_AWADDR),
        .S_AXI_AWPROT(system_interconnect_M01_AXI_AWPROT),
        .S_AXI_AWREADY(system_interconnect_M01_AXI_AWREADY),
        .S_AXI_AWVALID(system_interconnect_M01_AXI_AWVALID),
        .S_AXI_BREADY(system_interconnect_M01_AXI_BREADY),
        .S_AXI_BRESP(system_interconnect_M01_AXI_BRESP),
        .S_AXI_BVALID(system_interconnect_M01_AXI_BVALID),
        .S_AXI_RDATA(system_interconnect_M01_AXI_RDATA),
        .S_AXI_RREADY(system_interconnect_M01_AXI_RREADY),
        .S_AXI_RRESP(system_interconnect_M01_AXI_RRESP),
        .S_AXI_RVALID(system_interconnect_M01_AXI_RVALID),
        .S_AXI_WDATA(system_interconnect_M01_AXI_WDATA),
        .S_AXI_WREADY(system_interconnect_M01_AXI_WREADY),
        .S_AXI_WSTRB(system_interconnect_M01_AXI_WSTRB),
        .S_AXI_WVALID(system_interconnect_M01_AXI_WVALID),
        .clk(source_100mhz_sys_clk),
        .dac_channel(axi_dac_control_dac_channel),
        .dac_cmd(axi_dac_control_dac_cmd),
        .dac_ldac(axi_dac_control_dac_ldac),
        .dac_start(axi_dac_control_dac_start),
        .dac_value(axi_dac_control_dac_value),
        .resetn(source_100mhz_sys_resetn));
  top_level_axi_revision_0_0 axi_revision
       (.AXI_ACLK(source_100mhz_sys_clk),
        .AXI_ARESETN(source_100mhz_sys_resetn),
        .S_AXI_ARADDR(system_interconnect_M00_AXI_ARADDR),
        .S_AXI_ARPROT(system_interconnect_M00_AXI_ARPROT),
        .S_AXI_ARREADY(system_interconnect_M00_AXI_ARREADY),
        .S_AXI_ARVALID(system_interconnect_M00_AXI_ARVALID),
        .S_AXI_AWADDR(system_interconnect_M00_AXI_AWADDR),
        .S_AXI_AWPROT(system_interconnect_M00_AXI_AWPROT),
        .S_AXI_AWREADY(system_interconnect_M00_AXI_AWREADY),
        .S_AXI_AWVALID(system_interconnect_M00_AXI_AWVALID),
        .S_AXI_BREADY(system_interconnect_M00_AXI_BREADY),
        .S_AXI_BRESP(system_interconnect_M00_AXI_BRESP),
        .S_AXI_BVALID(system_interconnect_M00_AXI_BVALID),
        .S_AXI_RDATA(system_interconnect_M00_AXI_RDATA),
        .S_AXI_RREADY(system_interconnect_M00_AXI_RREADY),
        .S_AXI_RRESP(system_interconnect_M00_AXI_RRESP),
        .S_AXI_RVALID(system_interconnect_M00_AXI_RVALID),
        .S_AXI_WDATA(system_interconnect_M00_AXI_WDATA),
        .S_AXI_WREADY(system_interconnect_M00_AXI_WREADY),
        .S_AXI_WSTRB(system_interconnect_M00_AXI_WSTRB),
        .S_AXI_WVALID(system_interconnect_M00_AXI_WVALID));
  top_level_display_shim_0_0 display_shim
       (.ch_select(ch_select_0_1),
        .clk(source_100mhz_sys_clk),
        .dac_a(sim_ltc_2656_dac_a),
        .dac_b(sim_ltc_2656_dac_b),
        .dac_c(sim_ltc_2656_dac_c),
        .dac_d(sim_ltc_2656_dac_d),
        .dac_e(sim_ltc_2656_dac_e),
        .dac_f(sim_ltc_2656_dac_f),
        .dac_g(sim_ltc_2656_dac_g),
        .dac_h(sim_ltc_2656_dac_h),
        .digit_enable(display_shim_digit_enable),
        .display(display_shim_display),
        .inp_a(sim_ltc_2656_inp_a),
        .inp_b(sim_ltc_2656_inp_b),
        .inp_c(sim_ltc_2656_inp_c),
        .inp_d(sim_ltc_2656_inp_d),
        .inp_e(sim_ltc_2656_inp_e),
        .inp_f(sim_ltc_2656_inp_f),
        .inp_g(sim_ltc_2656_inp_g),
        .inp_h(sim_ltc_2656_inp_h));
  top_level_ltc_2656_0_0 ltc_2656
       (.clk(source_100mhz_sys_clk),
        .csld(ltc_2656_csld),
        .dac_channel(axi_dac_control_dac_channel),
        .dac_cmd(axi_dac_control_dac_cmd),
        .dac_value(axi_dac_control_dac_value),
        .ldac_in(axi_dac_control_dac_ldac),
        .ldac_out(ltc_2656_ldac_out),
        .resetn(source_100mhz_sys_resetn),
        .sck(ltc_2656_sck),
        .sdo(ltc_2656_sdo),
        .start(axi_dac_control_dac_start));
  top_level_sevenseg_driver_0_0 sevenseg_driver
       (.ANODE(sevenseg_driver_ANODE),
        .CATHODE(sevenseg_driver_CATHODE),
        .clk(source_100mhz_sys_clk),
        .digit_enable(display_shim_digit_enable),
        .display(display_shim_display),
        .resetn(source_100mhz_sys_resetn));
  top_level_sim_ltc_2656_0_0 sim_ltc_2656
       (.clk(source_100mhz_sys_clk),
        .csld(ltc_2656_csld),
        .dac_a(sim_ltc_2656_dac_a),
        .dac_b(sim_ltc_2656_dac_b),
        .dac_c(sim_ltc_2656_dac_c),
        .dac_d(sim_ltc_2656_dac_d),
        .dac_e(sim_ltc_2656_dac_e),
        .dac_f(sim_ltc_2656_dac_f),
        .dac_g(sim_ltc_2656_dac_g),
        .dac_h(sim_ltc_2656_dac_h),
        .inp_a(sim_ltc_2656_inp_a),
        .inp_b(sim_ltc_2656_inp_b),
        .inp_c(sim_ltc_2656_inp_c),
        .inp_d(sim_ltc_2656_inp_d),
        .inp_e(sim_ltc_2656_inp_e),
        .inp_f(sim_ltc_2656_inp_f),
        .inp_g(sim_ltc_2656_inp_g),
        .inp_h(sim_ltc_2656_inp_h),
        .ldac(ltc_2656_ldac_out),
        .powered(sim_ltc_2656_powered),
        .resetn(source_100mhz_sys_resetn),
        .sck(ltc_2656_sck),
        .sdi(ltc_2656_sdo),
        .spi_dataword_out(sim_ltc_2656_spi_dataword_out));
  source_100mhz_imp_MSWE0P source_100mhz
       (.clk_in(clk_in1_0_1),
        .resetn_in(ext_reset_in_0_1),
        .sys_clk(source_100mhz_sys_clk),
        .sys_resetn(source_100mhz_sys_resetn));
  top_level_system_ila_0_0 system_ila
       (.clk(source_100mhz_sys_clk),
        .probe0(ltc_2656_csld),
        .probe1(ltc_2656_sck),
        .probe2(ltc_2656_sdo),
        .probe3(sim_ltc_2656_spi_dataword_out));
  top_level_smartconnect_0_0 system_interconnect
       (.M00_AXI_araddr(system_interconnect_M00_AXI_ARADDR),
        .M00_AXI_arprot(system_interconnect_M00_AXI_ARPROT),
        .M00_AXI_arready(system_interconnect_M00_AXI_ARREADY),
        .M00_AXI_arvalid(system_interconnect_M00_AXI_ARVALID),
        .M00_AXI_awaddr(system_interconnect_M00_AXI_AWADDR),
        .M00_AXI_awprot(system_interconnect_M00_AXI_AWPROT),
        .M00_AXI_awready(system_interconnect_M00_AXI_AWREADY),
        .M00_AXI_awvalid(system_interconnect_M00_AXI_AWVALID),
        .M00_AXI_bready(system_interconnect_M00_AXI_BREADY),
        .M00_AXI_bresp(system_interconnect_M00_AXI_BRESP),
        .M00_AXI_bvalid(system_interconnect_M00_AXI_BVALID),
        .M00_AXI_rdata(system_interconnect_M00_AXI_RDATA),
        .M00_AXI_rready(system_interconnect_M00_AXI_RREADY),
        .M00_AXI_rresp(system_interconnect_M00_AXI_RRESP),
        .M00_AXI_rvalid(system_interconnect_M00_AXI_RVALID),
        .M00_AXI_wdata(system_interconnect_M00_AXI_WDATA),
        .M00_AXI_wready(system_interconnect_M00_AXI_WREADY),
        .M00_AXI_wstrb(system_interconnect_M00_AXI_WSTRB),
        .M00_AXI_wvalid(system_interconnect_M00_AXI_WVALID),
        .M01_AXI_araddr(system_interconnect_M01_AXI_ARADDR),
        .M01_AXI_arprot(system_interconnect_M01_AXI_ARPROT),
        .M01_AXI_arready(system_interconnect_M01_AXI_ARREADY),
        .M01_AXI_arvalid(system_interconnect_M01_AXI_ARVALID),
        .M01_AXI_awaddr(system_interconnect_M01_AXI_AWADDR),
        .M01_AXI_awprot(system_interconnect_M01_AXI_AWPROT),
        .M01_AXI_awready(system_interconnect_M01_AXI_AWREADY),
        .M01_AXI_awvalid(system_interconnect_M01_AXI_AWVALID),
        .M01_AXI_bready(system_interconnect_M01_AXI_BREADY),
        .M01_AXI_bresp(system_interconnect_M01_AXI_BRESP),
        .M01_AXI_bvalid(system_interconnect_M01_AXI_BVALID),
        .M01_AXI_rdata(system_interconnect_M01_AXI_RDATA),
        .M01_AXI_rready(system_interconnect_M01_AXI_RREADY),
        .M01_AXI_rresp(system_interconnect_M01_AXI_RRESP),
        .M01_AXI_rvalid(system_interconnect_M01_AXI_RVALID),
        .M01_AXI_wdata(system_interconnect_M01_AXI_WDATA),
        .M01_AXI_wready(system_interconnect_M01_AXI_WREADY),
        .M01_AXI_wstrb(system_interconnect_M01_AXI_WSTRB),
        .M01_AXI_wvalid(system_interconnect_M01_AXI_WVALID),
        .S00_AXI_araddr(uart_axi_bridge_M_AXI_ARADDR),
        .S00_AXI_arprot({1'b0,1'b0,1'b0}),
        .S00_AXI_arready(uart_axi_bridge_M_AXI_ARREADY),
        .S00_AXI_arvalid(uart_axi_bridge_M_AXI_ARVALID),
        .S00_AXI_awaddr(uart_axi_bridge_M_AXI_AWADDR),
        .S00_AXI_awprot({1'b0,1'b0,1'b0}),
        .S00_AXI_awready(uart_axi_bridge_M_AXI_AWREADY),
        .S00_AXI_awvalid(uart_axi_bridge_M_AXI_AWVALID),
        .S00_AXI_bready(uart_axi_bridge_M_AXI_BREADY),
        .S00_AXI_bresp(uart_axi_bridge_M_AXI_BRESP),
        .S00_AXI_bvalid(uart_axi_bridge_M_AXI_BVALID),
        .S00_AXI_rdata(uart_axi_bridge_M_AXI_RDATA),
        .S00_AXI_rready(uart_axi_bridge_M_AXI_RREADY),
        .S00_AXI_rresp(uart_axi_bridge_M_AXI_RRESP),
        .S00_AXI_rvalid(uart_axi_bridge_M_AXI_RVALID),
        .S00_AXI_wdata(uart_axi_bridge_M_AXI_WDATA),
        .S00_AXI_wready(uart_axi_bridge_M_AXI_WREADY),
        .S00_AXI_wstrb(uart_axi_bridge_M_AXI_WSTRB),
        .S00_AXI_wvalid(uart_axi_bridge_M_AXI_WVALID),
        .aclk(source_100mhz_sys_clk),
        .aresetn(source_100mhz_sys_resetn));
  uart_axi_bridge_imp_1TNTD43 uart_axi_bridge
       (.M_AXI_araddr(uart_axi_bridge_M_AXI_ARADDR),
        .M_AXI_arready(uart_axi_bridge_M_AXI_ARREADY),
        .M_AXI_arvalid(uart_axi_bridge_M_AXI_ARVALID),
        .M_AXI_awaddr(uart_axi_bridge_M_AXI_AWADDR),
        .M_AXI_awready(uart_axi_bridge_M_AXI_AWREADY),
        .M_AXI_awvalid(uart_axi_bridge_M_AXI_AWVALID),
        .M_AXI_bready(uart_axi_bridge_M_AXI_BREADY),
        .M_AXI_bresp(uart_axi_bridge_M_AXI_BRESP),
        .M_AXI_bvalid(uart_axi_bridge_M_AXI_BVALID),
        .M_AXI_rdata(uart_axi_bridge_M_AXI_RDATA),
        .M_AXI_rready(uart_axi_bridge_M_AXI_RREADY),
        .M_AXI_rresp(uart_axi_bridge_M_AXI_RRESP),
        .M_AXI_rvalid(uart_axi_bridge_M_AXI_RVALID),
        .M_AXI_wdata(uart_axi_bridge_M_AXI_WDATA),
        .M_AXI_wready(uart_axi_bridge_M_AXI_WREADY),
        .M_AXI_wstrb(uart_axi_bridge_M_AXI_WSTRB),
        .M_AXI_wvalid(uart_axi_bridge_M_AXI_WVALID),
        .UART_rxd(axi_uartlite_UART_RxD),
        .UART_txd(axi_uartlite_UART_TxD),
        .s_axi_aclk(source_100mhz_sys_clk),
        .s_axi_aresetn(source_100mhz_sys_resetn));
endmodule

module uart_axi_bridge_imp_1TNTD43
   (M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    UART_rxd,
    UART_txd,
    s_axi_aclk,
    s_axi_aresetn);
  output [63:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [63:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input UART_rxd;
  output UART_txd;
  input s_axi_aclk;
  input s_axi_aresetn;

  wire [63:0]axi_uart_bridge_M_AXI_ARADDR;
  wire axi_uart_bridge_M_AXI_ARREADY;
  wire axi_uart_bridge_M_AXI_ARVALID;
  wire [63:0]axi_uart_bridge_M_AXI_AWADDR;
  wire axi_uart_bridge_M_AXI_AWREADY;
  wire axi_uart_bridge_M_AXI_AWVALID;
  wire axi_uart_bridge_M_AXI_BREADY;
  wire [1:0]axi_uart_bridge_M_AXI_BRESP;
  wire axi_uart_bridge_M_AXI_BVALID;
  wire [31:0]axi_uart_bridge_M_AXI_RDATA;
  wire axi_uart_bridge_M_AXI_RREADY;
  wire [1:0]axi_uart_bridge_M_AXI_RRESP;
  wire axi_uart_bridge_M_AXI_RVALID;
  wire [31:0]axi_uart_bridge_M_AXI_WDATA;
  wire axi_uart_bridge_M_AXI_WREADY;
  wire [3:0]axi_uart_bridge_M_AXI_WSTRB;
  wire axi_uart_bridge_M_AXI_WVALID;
  wire [31:0]axi_uart_bridge_M_UART_ARADDR;
  wire axi_uart_bridge_M_UART_ARREADY;
  wire axi_uart_bridge_M_UART_ARVALID;
  wire [31:0]axi_uart_bridge_M_UART_AWADDR;
  wire axi_uart_bridge_M_UART_AWREADY;
  wire axi_uart_bridge_M_UART_AWVALID;
  wire axi_uart_bridge_M_UART_BREADY;
  wire [1:0]axi_uart_bridge_M_UART_BRESP;
  wire axi_uart_bridge_M_UART_BVALID;
  wire [31:0]axi_uart_bridge_M_UART_RDATA;
  wire axi_uart_bridge_M_UART_RREADY;
  wire [1:0]axi_uart_bridge_M_UART_RRESP;
  wire axi_uart_bridge_M_UART_RVALID;
  wire [31:0]axi_uart_bridge_M_UART_WDATA;
  wire axi_uart_bridge_M_UART_WREADY;
  wire [3:0]axi_uart_bridge_M_UART_WSTRB;
  wire axi_uart_bridge_M_UART_WVALID;
  wire axi_uartlite_UART_RxD;
  wire axi_uartlite_UART_TxD;
  wire axi_uartlite_interrupt;
  wire source_100mhz_sys_clk;
  wire source_100mhz_sys_resetn;

  assign M_AXI_araddr[63:0] = axi_uart_bridge_M_AXI_ARADDR;
  assign M_AXI_arvalid = axi_uart_bridge_M_AXI_ARVALID;
  assign M_AXI_awaddr[63:0] = axi_uart_bridge_M_AXI_AWADDR;
  assign M_AXI_awvalid = axi_uart_bridge_M_AXI_AWVALID;
  assign M_AXI_bready = axi_uart_bridge_M_AXI_BREADY;
  assign M_AXI_rready = axi_uart_bridge_M_AXI_RREADY;
  assign M_AXI_wdata[31:0] = axi_uart_bridge_M_AXI_WDATA;
  assign M_AXI_wstrb[3:0] = axi_uart_bridge_M_AXI_WSTRB;
  assign M_AXI_wvalid = axi_uart_bridge_M_AXI_WVALID;
  assign UART_txd = axi_uartlite_UART_TxD;
  assign axi_uart_bridge_M_AXI_ARREADY = M_AXI_arready;
  assign axi_uart_bridge_M_AXI_AWREADY = M_AXI_awready;
  assign axi_uart_bridge_M_AXI_BRESP = M_AXI_bresp[1:0];
  assign axi_uart_bridge_M_AXI_BVALID = M_AXI_bvalid;
  assign axi_uart_bridge_M_AXI_RDATA = M_AXI_rdata[31:0];
  assign axi_uart_bridge_M_AXI_RRESP = M_AXI_rresp[1:0];
  assign axi_uart_bridge_M_AXI_RVALID = M_AXI_rvalid;
  assign axi_uart_bridge_M_AXI_WREADY = M_AXI_wready;
  assign axi_uartlite_UART_RxD = UART_rxd;
  assign source_100mhz_sys_clk = s_axi_aclk;
  assign source_100mhz_sys_resetn = s_axi_aresetn;
  top_level_axi_uart_bridge_0_0 axi_uart_bridge
       (.M_AXI_ARADDR(axi_uart_bridge_M_AXI_ARADDR),
        .M_AXI_ARREADY(axi_uart_bridge_M_AXI_ARREADY),
        .M_AXI_ARVALID(axi_uart_bridge_M_AXI_ARVALID),
        .M_AXI_AWADDR(axi_uart_bridge_M_AXI_AWADDR),
        .M_AXI_AWREADY(axi_uart_bridge_M_AXI_AWREADY),
        .M_AXI_AWVALID(axi_uart_bridge_M_AXI_AWVALID),
        .M_AXI_BREADY(axi_uart_bridge_M_AXI_BREADY),
        .M_AXI_BRESP(axi_uart_bridge_M_AXI_BRESP),
        .M_AXI_BVALID(axi_uart_bridge_M_AXI_BVALID),
        .M_AXI_RDATA(axi_uart_bridge_M_AXI_RDATA),
        .M_AXI_RREADY(axi_uart_bridge_M_AXI_RREADY),
        .M_AXI_RRESP(axi_uart_bridge_M_AXI_RRESP),
        .M_AXI_RVALID(axi_uart_bridge_M_AXI_RVALID),
        .M_AXI_WDATA(axi_uart_bridge_M_AXI_WDATA),
        .M_AXI_WREADY(axi_uart_bridge_M_AXI_WREADY),
        .M_AXI_WSTRB(axi_uart_bridge_M_AXI_WSTRB),
        .M_AXI_WVALID(axi_uart_bridge_M_AXI_WVALID),
        .M_UART_ARADDR(axi_uart_bridge_M_UART_ARADDR),
        .M_UART_ARREADY(axi_uart_bridge_M_UART_ARREADY),
        .M_UART_ARVALID(axi_uart_bridge_M_UART_ARVALID),
        .M_UART_AWADDR(axi_uart_bridge_M_UART_AWADDR),
        .M_UART_AWREADY(axi_uart_bridge_M_UART_AWREADY),
        .M_UART_AWVALID(axi_uart_bridge_M_UART_AWVALID),
        .M_UART_BREADY(axi_uart_bridge_M_UART_BREADY),
        .M_UART_BRESP(axi_uart_bridge_M_UART_BRESP),
        .M_UART_BVALID(axi_uart_bridge_M_UART_BVALID),
        .M_UART_RDATA(axi_uart_bridge_M_UART_RDATA),
        .M_UART_RREADY(axi_uart_bridge_M_UART_RREADY),
        .M_UART_RRESP(axi_uart_bridge_M_UART_RRESP),
        .M_UART_RVALID(axi_uart_bridge_M_UART_RVALID),
        .M_UART_WDATA(axi_uart_bridge_M_UART_WDATA),
        .M_UART_WREADY(axi_uart_bridge_M_UART_WREADY),
        .M_UART_WSTRB(axi_uart_bridge_M_UART_WSTRB),
        .M_UART_WVALID(axi_uart_bridge_M_UART_WVALID),
        .UART_INT(axi_uartlite_interrupt),
        .aclk(source_100mhz_sys_clk),
        .aresetn(source_100mhz_sys_resetn));
  top_level_axi_uartlite_0_0 axi_uartlite
       (.interrupt(axi_uartlite_interrupt),
        .rx(axi_uartlite_UART_RxD),
        .s_axi_aclk(source_100mhz_sys_clk),
        .s_axi_araddr(axi_uart_bridge_M_UART_ARADDR[3:0]),
        .s_axi_aresetn(source_100mhz_sys_resetn),
        .s_axi_arready(axi_uart_bridge_M_UART_ARREADY),
        .s_axi_arvalid(axi_uart_bridge_M_UART_ARVALID),
        .s_axi_awaddr(axi_uart_bridge_M_UART_AWADDR[3:0]),
        .s_axi_awready(axi_uart_bridge_M_UART_AWREADY),
        .s_axi_awvalid(axi_uart_bridge_M_UART_AWVALID),
        .s_axi_bready(axi_uart_bridge_M_UART_BREADY),
        .s_axi_bresp(axi_uart_bridge_M_UART_BRESP),
        .s_axi_bvalid(axi_uart_bridge_M_UART_BVALID),
        .s_axi_rdata(axi_uart_bridge_M_UART_RDATA),
        .s_axi_rready(axi_uart_bridge_M_UART_RREADY),
        .s_axi_rresp(axi_uart_bridge_M_UART_RRESP),
        .s_axi_rvalid(axi_uart_bridge_M_UART_RVALID),
        .s_axi_wdata(axi_uart_bridge_M_UART_WDATA),
        .s_axi_wready(axi_uart_bridge_M_UART_WREADY),
        .s_axi_wstrb(axi_uart_bridge_M_UART_WSTRB),
        .s_axi_wvalid(axi_uart_bridge_M_UART_WVALID),
        .tx(axi_uartlite_UART_TxD));
endmodule
