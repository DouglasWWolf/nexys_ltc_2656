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

reg[ 4:0] fsm_state;
reg[15:0] fsm_delay;
reg[ 6:0] bit_counter;

// These are the possible states of "fsm_state"
localparam FSM_IDLE          = 0;
localparam FSM_FALLING_SCK   = 1;
localparam FSM_RISING_SCK    = 2;
localparam FSM_END_CLR_LDAC  = 3;
localparam FSM_WAIT_COMPLETE = 4;


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
        fsm_state <= FSM_IDLE;
        csld      <= CSLD_LOAD;
        sck       <= 0;
        ldac_out  <= 1; // Active low
        clr_out   <= 1; // Active low
    end
  
    else case(fsm_state)

        // Here we wait for a new command to arrive
        FSM_IDLE:
            begin

                // Here we setup to drive out data to the SPI
                if (command == COMMAND_XFER) begin
                    spi_dataword <= {dac_cmd, dac_channel, dac_value};
                    csld         <= CSLD_CHIP_SELECT;
                    sck          <= 0;
                    fsm_delay    <= 0;
                    bit_counter  <= 0;
                    fsm_state    <= FSM_FALLING_SCK;
                end

                // Here we drive ldac_out low for a short pulse
                if (command == COMMAND_LDAC) begin
                    ldac_out  <= 0;
                    fsm_delay <= 25 / NS_PER_CLK;
                    fsm_state <= FSM_END_CLR_LDAC;
                end

                // Here we drive clr_out low for a short pulse
                if (command == COMMAND_CLR) begin
                    clr_out   <= 0;
                    fsm_delay <= 40 / NS_PER_CLK;
                    fsm_state <= FSM_END_CLR_LDAC;
                end

            end

        // Drive out the next outgoing bit on sdo, and drive SCK low
        FSM_FALLING_SCK:
            if (fsm_delay == 0) begin
                sck          <= 0;
                sdo          <= spi_dataword[23];
                spi_dataword <= spi_dataword << 1;
                if (bit_counter < 24) begin
                    fsm_delay   <= SPI_SCK_DELAY;
                    fsm_state   <= FSM_RISING_SCK;
                end else begin
                    csld      <= CSLD_LOAD;
                    fsm_state <= FSM_WAIT_COMPLETE;
                end

            end

        // Drive SCK high
        FSM_RISING_SCK:
            if (fsm_delay == 0) begin
                sck          <= 1;
                fsm_delay    <= SPI_SCK_DELAY;
                bit_counter  <= bit_counter + 1;                
                fsm_state    <= FSM_FALLING_SCK;
            end            


        // End either a COMMAND_CLR or COMMAND_LDAC operation     
        FSM_END_CLR_LDAC:
            if (fsm_delay == 0) begin
                ldac_out  <= 1;
                clr_out   <= 1;
                fsm_state <= FSM_WAIT_COMPLETE;
            end

        // Setup a timer to allow for the physical DAC to complete 
        // the operation
        FSM_WAIT_COMPLETE:
            begin
                fsm_delay <= 20/NS_PER_CLK;
                fsm_state <= fsm_state + 1;
            end

        // When the DAC has completed the operation, go back to idle
        FSM_WAIT_COMPLETE + 1:
            if (fsm_delay == 0) fsm_state <= FSM_IDLE;

    endcase

end
//=============================================================================

// The "idle" pin is high when the entire system is idle
assign idle = (command == 0) & (fsm_state == 0);

endmodule
