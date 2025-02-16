
module display_shim
(
    input   clk,

    input[15:0] dac_a, dac_b, dac_c, dac_d,
    input[15:0] dac_e, dac_f, dac_g, dac_h,

    input[15:0] inp_a, inp_b, inp_c, inp_d,
    input[15:0] inp_e, inp_f, inp_g, inp_h,

    input[ 2:0] ch_select,

    output reg[31:0] display,
    output    [ 7:0] digit_enable

);

// Map the inp_X registers into an array
wire[15:0] dac_input[0:7];
assign dac_input[0] = inp_a;
assign dac_input[1] = inp_b;
assign dac_input[2] = inp_c;
assign dac_input[3] = inp_d;
assign dac_input[4] = inp_e;
assign dac_input[5] = inp_f;
assign dac_input[6] = inp_g;
assign dac_input[7] = inp_h;


// Map the dac_X registers into an array
wire[15:0] dac_output[0:7];
assign dac_output[0] = dac_a;
assign dac_output[1] = dac_b;
assign dac_output[2] = dac_c;
assign dac_output[3] = dac_d;
assign dac_output[4] = dac_e;
assign dac_output[5] = dac_f;
assign dac_output[6] = dac_g;
assign dac_output[7] = dac_h;

// We drive out either dac_input or dac_output for the selected channel
always @(posedge clk) begin
    display <= {dac_input[ch_select], dac_output[ch_select]};
end

// Enable all digits of the display
assign digit_enable = 8'hFF;

endmodule