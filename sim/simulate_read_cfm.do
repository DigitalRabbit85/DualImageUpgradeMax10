vsim -novopt work.tb_read_cfm

#########################################################
add wave -noupdate -divider {tb_read_cfm}
add wave -noupdate -group {tb_read_cfm} -radix hexadecimal -format Logic /tb_read_cfm/*
add wave -noupdate -group {StateMachine All} -radix hexadecimal -format Logic /tb_read_cfm/StateMachine/*

#########################################################
add wave -noupdate -divider {StateMachine}

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label clk \
	/tb_read_cfm/StateMachine/clk

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label start_rx \
	/tb_read_cfm/StateMachine/start_rx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label cmd_rx \
	/tb_read_cfm/StateMachine/cmd_rx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label len_rx \
	/tb_read_cfm/StateMachine/len_rx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label start_tx \
	/tb_read_cfm/StateMachine/start_tx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic\
	-color Cyan -itemcolor Cyan -label cmd_tx \
	/tb_read_cfm/StateMachine/cmd_tx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label len_tx \
	/tb_read_cfm/StateMachine/len_tx	

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label fl_rx \
	/tb_read_cfm/StateMachine/fl_rx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label fl_tx \
	/tb_read_cfm/StateMachine/fl_tx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label clr_fl \
	/tb_read_cfm/StateMachine/clr_fl

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label state \
	/tb_read_cfm/StateMachine/state

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label start_addr \
	/tb_read_cfm/StateMachine/start_addr

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label start_rddata \
	/tb_read_cfm/StateMachine/start_rddata

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label done_data \
	/tb_read_cfm/StateMachine/done_data

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label set_fl_tx \
	/tb_read_cfm/StateMachine/set_fl_tx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label start_rd_ram \
	/tb_read_cfm/StateMachine/start_rd_ram

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label start_rd_addr \
	/tb_read_cfm/StateMachine/start_rd_addr

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label rd_word \
	/tb_read_cfm/StateMachine/rd_word

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label done_rd_ram \
	/tb_read_cfm/StateMachine/done_rd_ram

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label start_wr_ram \
	/tb_read_cfm/StateMachine/start_wr_ram

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label start_wr_addr \
	/tb_read_cfm/StateMachine/start_wr_addr

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label wr_word \
	/tb_read_cfm/StateMachine/wr_word

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label done_wr_ram \
	/tb_read_cfm/StateMachine/done_wr_ram	

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label rd_data_data \
	/tb_read_cfm/StateMachine/rd_data_data

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label addr_data \
	/tb_read_cfm/StateMachine/addr_data

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label num_byte \
	/tb_read_cfm/StateMachine/num_byte

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label num_word \
	/tb_read_cfm/StateMachine/num_word

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label cnt_word \
	/tb_read_cfm/StateMachine/cnt_word

