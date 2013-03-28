transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline {C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline/seven_segment.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline {C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline/sign_extension.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline {C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline/pll.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline {C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline/writeback.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline {C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline/memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline {C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline/execute.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline {C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline/decode.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline {C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline/lg_highlevel.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline {C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline/fetch.v}

vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline {C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline/lg_highlevel.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  lg_highlevel

do C:/Users/Chris/Dropbox/GitHub/Verilog_Pipeline/simulation/modelsim/my_custom_view.do
