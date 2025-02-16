 
module sim_ltc_2656
(
    // Clock and reset
    input   clk, resetn,

    // The SCK and SDI inputs of the SPI interface.  Should be synchronous to clk.
    input   sck, sdi,

    // When this goes low, 24 bits are clocked in from SDI/SCK
    input csld,

    // When this goes low, all DAC outputs are turned on
    input ldac,

    // The 8 DAC outputs
    output[15:0] dac_a, dac_b, dac_c, dac_d,
    output[15:0] dac_e, dac_f, dac_g, dac_h,

    output[15:0] inp_a, inp_b, inp_c, inp_d,
    output[15:0] inp_e, inp_f, inp_g, inp_h,

    // For a given bit position: 0 = DAC channel is powered down, 1 = DAC channel is powered up
    output reg[7:0] powered,

    // When a command/channel/value is received via SPI, it gets output here
    output reg[23:0] spi_dataword_out
);

genvar i;

// Our DAC has 8 output channels
localparam DAC_CHANNELS = 8;

// This is "DAC_CHANNELS" 1 bits in a row.
localparam ALL_DAC_CHANNELS = (1 << DAC_CHANNELS) - 1;

// When a DAC channel is unpowered, this is what it outputs
localparam UNPOWERED = 16'hDEAD;

// This is the dataword that was clocked in on the sck and sdi pins
reg[23:0] spi_dataword;

// Break out the "spi_dataword" into fields
wire[ 3:0] dac_cmd     = spi_dataword[23:20];
wire[ 3:0] dac_channel = spi_dataword[19:16];
wire[15:0] dac_value   = spi_dataword[15:00];

// The input register that feeds each DAC channel
reg[15:0] dac_input[0:DAC_CHANNELS-1];

// The DAC outputs are driven from the dac_input registers
assign dac_a = powered[0] ? dac_input[0] : UNPOWERED;
assign dac_b = powered[1] ? dac_input[1] : UNPOWERED;
assign dac_c = powered[2] ? dac_input[2] : UNPOWERED;
assign dac_d = powered[3] ? dac_input[3] : UNPOWERED;
assign dac_e = powered[4] ? dac_input[4] : UNPOWERED;
assign dac_f = powered[5] ? dac_input[5] : UNPOWERED;
assign dac_g = powered[6] ? dac_input[6] : UNPOWERED;
assign dac_h = powered[7] ? dac_input[7] : UNPOWERED;


// Copy the DAC input registers to ports for debugging or display
assign inp_a = dac_input[0];
assign inp_b = dac_input[1];
assign inp_c = dac_input[2];
assign inp_d = dac_input[3];
assign inp_e = dac_input[4];
assign inp_f = dac_input[5];
assign inp_g = dac_input[6];
assign inp_h = dac_input[7];



//=============================================================================
// This block drives ldac_edge high on every clock cycle where a low-going
// edge is detected in the ldac input
//=============================================================================
reg prior_ldac;
wire ldac_edge = (prior_ldac == 1) & (ldac == 0);
always @(posedge clk) begin
    if (resetn == 0) 
        prior_ldac <= 0;
    else
        prior_ldac <= ldac;
end
//=============================================================================


//=============================================================================
// This block writes new values to the bits of the "powered" register
//
// Inputs: powered_update_mask : A 1 in each channel we're going to update
//
//         powered_update_state: We will write this 1 or 0 to the selected
//                               "powered" bits
//
//         powered_latch       : A 1 causes "powered_update_state" to latch
//                               into the "powered" bits selected by the 
//                               "powered_update_mask"
//=============================================================================
reg[DAC_CHANNELS-1:0] powered_update_mask;
reg                   powered_update_state;
reg                   powered_latch;
//-----------------------------------------------------------------------------
for (i=0; i<DAC_CHANNELS; i=i+1) begin
    always @(posedge clk) begin

        if (powered_latch & powered_update_mask[i])
            powered[i] <= powered_update_state;

        if (ldac_edge)
            powered[i] <= 1;

        if (resetn == 0)
            powered[i] <= 0;

    end
end
//=============================================================================


//=============================================================================
// This blocks fills the dac_input registers from "dac_value" whenever
// "latch_dac_input" is high
//=============================================================================
reg latch_dac_input;
//-----------------------------------------------------------------------------
for (i=0; i<DAC_CHANNELS; i=i+1) begin
    always @(posedge clk) begin

        if (latch_dac_input) begin
            if ((dac_channel == i) || (dac_channel == 4'b1111)) begin
                dac_input[i] <= dac_value;
            end
        end

        if (resetn == 0) dac_input[i] <= 0;
    end
end
//=============================================================================



//=============================================================================
// This block clocks in a dataword on the high-going edges of sck
//=============================================================================
reg prior_sck;

always @(posedge clk) begin
    prior_sck <= sck;

    if (resetn == 0) begin
        spi_dataword <= 0;
        prior_sck    <= 0;
    end
    
    else if (csld == 0 && prior_sck == 0 && sck == 1)
        spi_dataword <= (spi_dataword << 1) | sdi;
end
//=============================================================================



//=============================================================================
// This state machine waits for a high-going edge on the csld signal.  When
// it sees one, it carries out the command specified by the "command" register
//=============================================================================
reg prior_csld;
always @(posedge clk) begin
    
    // These are only high for 1 cycle at a time
    latch_dac_input <= 0;
    powered_latch   <= 0;

    // Keep track of csld so we can detect edges
    prior_csld <= csld;

    // If we're in reset...
    if (resetn == 0)
        prior_csld <= 0;

    // Otherwise, on the high-going edge of csld...
    else if (prior_csld == 0 && csld == 1) begin

        // Place the spi_dataword where it can be seen by a debugger
        spi_dataword_out <= spi_dataword;

        case(dac_cmd) 

            // Copy dac_value into the selected dac_input[] register(s)
            4'b0000:
                begin
                    latch_dac_input <= 1;
                end

            // Powered up selected (1 or all) DAC channels
            4'b0001:
                begin
                    powered_update_state <= 1;
                    if (dac_channel == 4'b1111)
                        powered_update_mask <= ALL_DAC_CHANNELS;
                    else
                        powered_update_mask <= (1 << dac_channel);
                    powered_latch <= 1;
                end
                
            // Copy dac_value into the selected dac_input[] register(s)
            // Power up all DAC channels
            4'b0010:
                begin
                    latch_dac_input      <= 1;
                    powered_update_state <= 1;
                    powered_update_mask  <= ALL_DAC_CHANNELS;
                    powered_latch        <= 1;
                end

            // Copy dac_value into the selected dac_input[] register(s)
            // Power up selected (1 or all) DAC channels
            4'b0011:
                begin
                    latch_dac_input <= 1;
                    powered_update_state <= 1;
                    if (dac_channel == 4'b1111)
                        powered_update_mask <= ALL_DAC_CHANNELS;
                    else
                        powered_update_mask <= (1 << dac_channel);
                    powered_latch <= 1;
                end
            
            // Power down selected (1 or all) DAC channels
            4'b0100:
                begin
                    powered_update_state <= 0;
                    if (dac_channel == 4'b1111)
                        powered_update_mask <= ALL_DAC_CHANNELS;
                    else
                        powered_update_mask <= (1 << dac_channel);
                    powered_latch <= 1;
                end

            // Power down all DAC channels
            4'b0101:
                begin
                    powered_update_state <= 0;
                    powered_update_mask  <= ALL_DAC_CHANNELS;
                    powered_latch        <= 1;
                end

            // In all other cases, do nothing
            default:
                begin
                end
            
        endcase

    end 
end
//=============================================================================




endmodule
