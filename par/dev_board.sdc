## Generated SDC file "dev_board.sdc"

## Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, the Altera Quartus II License Agreement,
## the Altera MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Altera and sold by Altera or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 15.0.0 Build 145 04/22/2015 SJ Full Version"

## DATE    "Tue May 07 17:15:21 2024"

##
## DEVICE  "EP4CE10F17C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {sys_clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {sys_clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {PLL_CLK|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {PLL_CLK|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 55.000 -multiply_by 13 -divide_by 10 -phase 4.500 -master_clock {sys_clk} [get_pins {PLL_CLK|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {PLL_CLK|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {PLL_CLK|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 55.000 -multiply_by 13 -divide_by 10 -phase 4.500 -master_clock {sys_clk} [get_pins {PLL_CLK|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {PLL_CLK|altpll_component|auto_generated|pll1|clk[2]} -source [get_pins {PLL_CLK|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50.000 -multiply_by 2 -master_clock {sys_clk} [get_pins {PLL_CLK|altpll_component|auto_generated|pll1|clk[2]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

