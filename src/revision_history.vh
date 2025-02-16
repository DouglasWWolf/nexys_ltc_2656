
//================================================================================================
//    Date      Vers   Who  Changes
// -----------------------------------------------------------------------------------------------
// 14-Aug-2024  1.0.0  DWW  Initial creation
//================================================================================================
localparam VERSION_MAJOR = 1;
localparam VERSION_MINOR = 0;
localparam VERSION_BUILD = 0;
localparam VERSION_RCAND = 0;

localparam VERSION_DAY   = 14;
localparam VERSION_MONTH = 8;
localparam VERSION_YEAR  = 2024;

localparam RTL_TYPE      = 81424;
localparam RTL_SUBTYPE   = 0;


/*  

TTD:
   Check the timing from the final SCK (out) to the rising edge of CSLD (out)
   Add an "idle" to the DAC driver
   Comment the hell out of the DAC driver
   Find another solution for specifying SPI clock delay


*/