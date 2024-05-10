#create_clock -name sys_clk -period 20.0 [get_ports sys_clk]
create_clock -period 20 -waveform {0 10} -name sys_clk [get_ports sys_clk]
set_clock_uncertainty  -setup -rise_from sys_clk -rise_to sys_clk 0.150
set_clock_uncertainty  -hold -rise_from sys_clk -rise_to sys_clk 0.150

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

