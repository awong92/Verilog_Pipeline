transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/CS\ 3220/Assignment\ 5/homework5_v3 {C:/Users/Chris/Dropbox/CS 3220/Assignment 5/homework5_v3/seven_segment.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/CS\ 3220/Assignment\ 5/homework5_v3 {C:/Users/Chris/Dropbox/CS 3220/Assignment 5/homework5_v3/sign_extension.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/CS\ 3220/Assignment\ 5/homework5_v3 {C:/Users/Chris/Dropbox/CS 3220/Assignment 5/homework5_v3/pll.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/CS\ 3220/Assignment\ 5/homework5_v3 {C:/Users/Chris/Dropbox/CS 3220/Assignment 5/homework5_v3/writeback.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/CS\ 3220/Assignment\ 5/homework5_v3 {C:/Users/Chris/Dropbox/CS 3220/Assignment 5/homework5_v3/memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/CS\ 3220/Assignment\ 5/homework5_v3 {C:/Users/Chris/Dropbox/CS 3220/Assignment 5/homework5_v3/execute.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/CS\ 3220/Assignment\ 5/homework5_v3 {C:/Users/Chris/Dropbox/CS 3220/Assignment 5/homework5_v3/decode.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/CS\ 3220/Assignment\ 5/homework5_v3 {C:/Users/Chris/Dropbox/CS 3220/Assignment 5/homework5_v3/lg_highlevel.v}
vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/CS\ 3220/Assignment\ 5/homework5_v3 {C:/Users/Chris/Dropbox/CS 3220/Assignment 5/homework5_v3/fetch.v}

vlog -vlog01compat -work work +incdir+C:/Users/Chris/Dropbox/CS\ 3220/Assignment\ 5/homework5_v3 {C:/Users/Chris/Dropbox/CS 3220/Assignment 5/homework5_v3/lg_highlevel.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  lg_highlevel

do C:/Users/Chris/Dropbox/CS 3220/Assignment 5/homework5_v3/simulation/modelsim/my_custom_view.do
