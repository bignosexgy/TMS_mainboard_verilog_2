transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/uart_232 {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/uart_232/uart_IGBT.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/pcf8591 {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/pcf8591/seg_led_pcf8591.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/pcf8591 {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/pcf8591/pcf8591.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/pcf8591 {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/pcf8591/i2c_dri_pcf8591.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/AD9248 {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/AD9248/PLL.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/AD9248 {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/AD9248/FIFO.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/AD9248 {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/AD9248/DDIO.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/IGBT&SCR {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/IGBT&SCR/Pulse_logic_gen.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/rtc_seg_led {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/rtc_seg_led/pcf8563_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/rtc_seg_led {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/rtc_seg_led/key_sw_disp.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/rtc_seg_led {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/rtc_seg_led/key_debounce.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/rtc_seg_led {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/rtc_seg_led/i2c_dri.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/uart_232 {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/uart_232/uart_recv.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/uart_232 {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/uart_232/uart_send.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/key_led {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/key_led/key_led_association.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/key_led {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/key_led/led_key.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl/key_led {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/key_led/key_scan.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/rtl {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/rtl/dev_board_top.v}
vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/par/db {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/par/db/pll_altpll.v}

vlog -vlog01compat -work work +incdir+D:/work/SynologyDrive/Projects\ in\ progress/TMS(Transcranial\ magnetic\ stimulate)/verilog/Development_Board/par/simulation/modelsim {D:/work/SynologyDrive/Projects in progress/TMS(Transcranial magnetic stimulate)/verilog/Development_Board/par/simulation/modelsim/dev_board_top_tb.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  dev_board_top_tb

add wave *
view structure
view signals
run -all
