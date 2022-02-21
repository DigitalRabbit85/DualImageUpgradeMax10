vsim -novopt work.tb_rxuart_logic

#########################################################
add wave -noupdate -divider {tb_rxuart_logic}
add wave -noupdate -group {tb_rxuart_logic} -radix hexadecimal -format Logic /tb_rxuart_logic/*
add wave -noupdate -group {RxUART_logic All} -radix hexadecimal -format Logic /tb_rxuart_logic/RxUART_logic/*

#########################################################

add wave -noupdate -divider {RxUART_logic}

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label clk \
	/tb_rxuart_logic/RxUART_logic/clk

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label reset \
	/tb_rxuart_logic/RxUART_logic/reset

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label rx_data \
	/tb_rxuart_logic/RxUART_logic/rx_data

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label rx_done \
	/tb_rxuart_logic/RxUART_logic/rx_done

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label cnt_byte \
	/tb_rxuart_logic/RxUART_logic/cnt_byte

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label crc_calc \
	/tb_rxuart_logic/RxUART_logic/crc_calc

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label cmd_rx \
	/tb_rxuart_logic/RxUART_logic/cmd_rx

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label len_rx \
	/tb_rxuart_logic/RxUART_logic/len_rx

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label wr_data \
	/tb_rxuart_logic/RxUART_logic/wr_data

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label wr_addr \
	/tb_rxuart_logic/RxUART_logic/wr_addr

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label wr_clock \
	/tb_rxuart_logic/RxUART_logic/wr_clock

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label we \
	/tb_rxuart_logic/RxUART_logic/we	

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label clr_addr \
	/tb_rxuart_logic/RxUART_logic/clr_addr

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label pck_done \
	/tb_rxuart_logic/RxUART_logic/pck_done
