//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
//Date        : Tue Feb 18 01:38:26 2025
//Host        : simtool-5 running 64-bit Ubuntu 20.04.6 LTS
//Command     : generate_target top_level_wrapper.bd
//Design      : top_level_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module top_level_wrapper
   (AN,
    CLK100MHZ,
    CPU_RESETN,
    LED,
    LED16_B,
    SEG,
    SW,
    UART_rxd,
    UART_txd);
  output [7:0]AN;
  input CLK100MHZ;
  input CPU_RESETN;
  output [7:0]LED;
  output LED16_B;
  output [7:0]SEG;
  input [2:0]SW;
  input UART_rxd;
  output UART_txd;

  wire [7:0]AN;
  wire CLK100MHZ;
  wire CPU_RESETN;
  wire [7:0]LED;
  wire LED16_B;
  wire [7:0]SEG;
  wire [2:0]SW;
  wire UART_rxd;
  wire UART_txd;

  top_level top_level_i
       (.AN(AN),
        .CLK100MHZ(CLK100MHZ),
        .CPU_RESETN(CPU_RESETN),
        .LED(LED),
        .LED16_B(LED16_B),
        .SEG(SEG),
        .SW(SW),
        .UART_rxd(UART_rxd),
        .UART_txd(UART_txd));
endmodule
