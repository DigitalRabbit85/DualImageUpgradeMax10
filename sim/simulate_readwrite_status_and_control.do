vsim -novopt work.tb_readwrite_status_and_control

#########################################################
add wave -noupdate -divider {tb_readwrite_status_and_control}
add wave -noupdate -group {tb_readwrite_status_and_control} -radix hexadecimal -format Logic /tb_readwrite_status_and_control/*
add wave -noupdate -group {StateMachine All} -radix hexadecimal -format Logic /tb_readwrite_status_and_control/StateMachine/*

#########################################################
add wave -noupdate -divider {StateMachine}

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label clk \
	/tb_readwrite_status_and_control/StateMachine/clk

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label start_rx \
	/tb_readwrite_status_and_control/StateMachine/start_rx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label cmd_rx \
	/tb_readwrite_status_and_control/StateMachine/cmd_rx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label len_rx \
	/tb_readwrite_status_and_control/StateMachine/len_rx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label fl_rx \
	/tb_readwrite_status_and_control/StateMachine/fl_rx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label fl_tx \
	/tb_readwrite_status_and_control/StateMachine/fl_tx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label done_csr \
	/tb_readwrite_status_and_control/StateMachine/done_csr

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label set_fl_tx \
	/tb_readwrite_status_and_control/StateMachine/set_fl_tx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label clr_fl \
	/tb_readwrite_status_and_control/StateMachine/clr_fl

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label state \
	/tb_readwrite_status_and_control/StateMachine/state

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label start_rdsr \
	/tb_readwrite_status_and_control/StateMachine/start_rdsr

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label start_rdcr \
	/tb_readwrite_status_and_control/StateMachine/start_rdcr

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label start_wrcr \
	/tb_readwrite_status_and_control/StateMachine/start_wrcr

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label start_rd_ram \
	/tb_readwrite_status_and_control/StateMachine/start_rd_ram

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label rd_data_csr \
	/tb_readwrite_status_and_control/StateMachine/rd_data_csr

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label wr_data_csr \
	/tb_readwrite_status_and_control/StateMachine/wr_data_csr

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label start_rd_addr \
	/tb_readwrite_status_and_control/StateMachine/start_rd_addr

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label rd_word \
	/tb_readwrite_status_and_control/StateMachine/rd_word

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label done_rd_ram \
	/tb_readwrite_status_and_control/StateMachine/done_rd_ram

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label start_wr_ram \
	/tb_readwrite_status_and_control/StateMachine/start_wr_ram

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label start_wr_addr \
	/tb_readwrite_status_and_control/StateMachine/start_wr_addr

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label wr_word \
	/tb_readwrite_status_and_control/StateMachine/wr_word

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label done_wr_ram \
	/tb_readwrite_status_and_control/StateMachine/done_wr_ram

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label start_tx \
	/tb_readwrite_status_and_control/StateMachine/start_tx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic\
	-color Green -itemcolor Green -label cmd_tx \
	/tb_readwrite_status_and_control/StateMachine/cmd_tx

add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label len_tx \
	/tb_readwrite_status_and_control/StateMachine/len_tx	