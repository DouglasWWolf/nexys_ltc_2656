

 
module ltc_2656 #
(
    parameter FREQ_HZ = 100000000,
    parameter SPI_FREQ = 50000000
)
(
    // Clock and reset
    input   clk, resetn,

    // The command that the DAC should carry out
    input[3:0] dac_cmd,

    // Which of the 8 DAC channels the command should affect
    input[3:0] dac_channel,

    // The value to be written to the DAC channel
    input[15:0] dac_value,

    // The SCK and SDO outputs SPI interface.  Synchronous to clk.
    output reg sck, sdo,

    // When this is low, the DAC clocks in data from SDI/SCK
    output reg csld,

    // When this goes high, it generates a low pulse on ldac_out
    input ldac_in,

    // Drives the "(not)LDAC" pin on the DAC
    output reg ldac_out,

    // On a high-going edge the spi_dataword is clocked out
    input   start
);

// Number of nanoseconds per clk
localparam NS_PER_CLK = 1000000000 / FREQ_HZ;

// The number of clk-cycles between state changes of the sck pin
localparam SPI_SCK_DELAY = FREQ_HZ / SPI_FREQ / 4;

// The possible states of the csld pin
localparam CSLD_CHIP_SELECT = 0;
localparam CSLD_LOAD        = 1;

// This is the dataword that will be clocked out on the sck and sdi pins
reg[23:0] spi_dataword;

reg[ 3:0] fsm_state;
reg[15:0] delay;
reg[ 6:0] bit_counter;


//=============================================================================
// This block generates a low-going pulse on ldac_out any time ldac_in is high
//=============================================================================
reg lsm_state;
reg[15:0] ldac_timer;
//-----------------------------------------------------------------------------
always @(posedge clk) begin

    // This is a countdown timer
    if (ldac_timer) ldac_timer <= ldac_timer - 1;

    if (resetn == 0)
        ldac_out <= 1;

    else case(lsm_state)

        0:  if (ldac_in) begin
                ldac_out   <= 0;
                ldac_timer <= 25 / NS_PER_CLK;
                lsm_state  <= 1;
            end

        1:  if (ldac_timer == 0) begin
                ldac_out  <= 1;
                lsm_state <= 0;
            end

    endcase

end
//=============================================================================


//=============================================================================
// This block clocks data out via the SPI bus "sck" and "sdo" pins
//
// "sdo" can only change values when "sck" is low.
//
// When clocking out bits on the SPI bus, the "csld" output should be in 
// CHIP_SELECT mode.
//=============================================================================
always @(posedge clk) begin

    // This is a countdown timer
    if (delay) delay <= delay - 1;

    if (resetn == 0) begin
        fsm_state <= 0;
        csld      <= CSLD_LOAD;
        sck       <= 0;
    end
    
    else case(fsm_state)

        // To start an SPI transmission, drive csld to the "chip-select" state
        0:  if (start) begin
                spi_dataword <= {dac_cmd, dac_channel, dac_value};
                csld         <= CSLD_CHIP_SELECT;
                sck          <= 0;
                sdo          <= dac_cmd[3];
                delay        <= SPI_SCK_DELAY;
                bit_counter  <= 1;
                fsm_state    <= fsm_state + 1;
            end

        1:  if (delay == 0) begin
                sck          <= 1;
                delay        <= SPI_SCK_DELAY;
                spi_dataword <= spi_dataword << 1;
                fsm_state    <= fsm_state + 1;
            end            

        2:  if (delay == 0) begin
                sck <= 0;
                sdo <= spi_dataword[23];
                if (bit_counter == 24) begin
                    csld      <= CSLD_LOAD;
                    delay     <= 10 / NS_PER_CLK;
                    fsm_state <= fsm_state + 1;
                end else begin
                    bit_counter <= bit_counter + 1;
                    delay       <= SPI_SCK_DELAY;
                    fsm_state   <= fsm_state - 1;
                end

            end

        3: if (delay == 0) fsm_state <= 0;

    endcase

end
//=============================================================================


endmodule
