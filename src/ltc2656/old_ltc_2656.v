//=================================================================================
// This module is a driver for the LTC-2656 DAC
//
// https://www.analog.com/media/en/technical-documentation/data-sheets/2656fa.pdf
//=================================================================================
 
module ltc_2656 #
(
    parameter FREQ_HZ = 100000000,
    parameter SPI_FREQ = 50000000
)
(
    // Clock and reset
    input   clk, resetn,

    // This is high when the entire DAC is idle
    output  idle,

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

    // Drives the "(not)LDAC" pin on the DAC
    output reg ldac_out,

    // Drives the "(not)CLR" pin on the DAC
    output reg clr_out,

    // When non-zero, a command (specified by COMMAND_XXX) is initiated
    input[1:0] command
);

// These are the commands that can be written to the "command" port
localparam COMMAND_NONE = 0;
localparam COMMAND_XFER = 1;
localparam COMMAND_LDAC = 2;
localparam COMMAND_CLR  = 3;

// Number of nanoseconds per clk
localparam NS_PER_CLK = 1000000000 / FREQ_HZ;

// How many clock cycles are there per SCK cycle?
localparam CLK_PER_SCK = FREQ_HZ / SPI_FREQ;

// Round CLK_PER_SCK up to the nearest even number.  This ensures that the frequency of SCK
// will never be higher than the frequency requested via the SPI_FREQ parameter
localparam EVEN_CLK_PER_SCK = (CLK_PER_SCK & 1) ? CLK_PER_SCK + 1 : CLK_PER_SCK;

// Ensure that SPI_SCK_DELAY is 0 or positive
localparam SPI_SCK_DELAY = (EVEN_CLK_PER_SCK > 2) ? (EVEN_CLK_PER_SCK / 2) - 1 : 0;

// The possible states of the csld pin
localparam CSLD_CHIP_SELECT = 0;
localparam CSLD_LOAD        = 1;

// This is the dataword that will be clocked out on the sck and sdi pins
reg[23:0] spi_dataword;

reg[ 3:0] fsm_state;
reg[15:0] fsm_delay;
reg[ 6:0] bit_counter;


//=============================================================================
// This block generates a low-going pulse on ldac_out any time the command
// port = COMMAND_LDAC
//=============================================================================
reg lsm_state;
reg[15:0] ldac_timer;
//-----------------------------------------------------------------------------
always @(posedge clk) begin

    // This is a countdown timer
    if (ldac_timer) ldac_timer <= ldac_timer - 1;

    if (resetn == 0) begin
        lsm_state <= 0;
        ldac_out  <= 1;
    end

    else case(lsm_state)

        0:  if (command == COMMAND_LDAC) begin
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
// This block generates a low-going pulse on clr_out any time the "command"
// port = COMMAND_CLR
//=============================================================================
reg csm_state;
reg[15:0] clr_timer;
//-----------------------------------------------------------------------------
always @(posedge clk) begin

    // This is a countdown timer
    if (clr_timer) clr_timer <= clr_timer - 1;

    if (resetn == 0) begin
        csm_state <= 0;
        clr_out  <= 1;
    end

    else case(csm_state)

        0:  if (command == COMMAND_CLR) begin
                clr_out   <= 0;
                clr_timer <= 40 / NS_PER_CLK;
                csm_state  <= 1;
            end

        1:  if (clr_timer == 0) begin
                clr_out   <= 1;
                csm_state <= 0;
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
    if (fsm_delay) fsm_delay <= fsm_delay - 1;

    if (resetn == 0) begin
        fsm_state <= 0;
        csld      <= CSLD_LOAD;
        sck       <= 0;
    end
    
    else case(fsm_state)

        // To start an SPI transmission, drive csld to the "chip-select" state
        0:  if (command == COMMAND_XFER) begin
                spi_dataword <= {dac_cmd, dac_channel, dac_value};
                csld         <= CSLD_CHIP_SELECT;
                sck          <= 0;
                sdo          <= dac_cmd[3];
                fsm_delay    <= SPI_SCK_DELAY;
                bit_counter  <= 1;
                fsm_state    <= fsm_state + 1;
            end

        1:  if (fsm_delay == 0) begin
                sck          <= 1;
                fsm_delay    <= SPI_SCK_DELAY;
                spi_dataword <= spi_dataword << 1;
                fsm_state    <= fsm_state + 1;
            end            

        2:  if (fsm_delay == 0) begin
                sck <= 0;
                sdo <= spi_dataword[23];
                if (bit_counter == 24) begin
                    csld      <= CSLD_LOAD;
                    fsm_delay <= 10;
                    fsm_state <= fsm_state + 1;
                end else begin
                    bit_counter <= bit_counter + 1;
                    fsm_delay   <= SPI_SCK_DELAY;
                    fsm_state   <= fsm_state - 1;
                end

            end

        // Allow a few clock cycles for the command to be carried out
        3: if (fsm_delay == 0) fsm_state <= 0;

    endcase

end
//=============================================================================


// The "idle" pin is high when the entire system is idle
assign idle = (command == 0) & (csm_state == 0) & (lsm_state == 0) & (fsm_state == 0);

endmodule
