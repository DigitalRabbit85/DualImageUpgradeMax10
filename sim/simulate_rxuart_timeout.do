vsim -novopt work.tb_rxuart_timeout

#########################################################
add wave -noupdate -divider {tb_rxuart_timeout}
add wave -noupdate -group {tb_rxuart_timeout} -radix hexadecimal -format Logic /tb_rxuart_timeout/*
add wave -noupdate -group {RxUART_timeout All} -radix hexadecimal -format Logic /tb_rxuart_timeout/RxUART_timeout/*

#########################################################

add wave -noupdate -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label rxd \
	/tb_rxuart_timeout/SingleRxUART/rxd

add wave -noupdate -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label rx_data \
	/tb_rxuart_timeout/SingleRxUART/rx_data

add wave -noupdate -divider {RxUART_timeout}

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label clk \
	/tb_rxuart_timeout/RxUART_timeout/clk

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label reset \
	/tb_rxuart_timeout/RxUART_timeout/reset

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label rx_done \
	/tb_rxuart_timeout/RxUART_timeout/rx_done

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label rx_busy \
	/tb_rxuart_timeout/RxUART_timeout/rx_busy

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label start_timeout \
	/tb_rxuart_timeout/RxUART_timeout/start_timeout

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label len_bit \
	/tb_rxuart_timeout/RxUART_timeout/len_bit	

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label clr_len_bit \
	/tb_rxuart_timeout/RxUART_timeout/clr_len_bit

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label len_byte \
	/tb_rxuart_timeout/RxUART_timeout/len_byte

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label clr_len_byte \
	/tb_rxuart_timeout/RxUART_timeout/clr_len_byte

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Cyan -itemcolor Cyan -label cnt_byte \
	/tb_rxuart_timeout/RxUART_timeout/cnt_byte	

add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
	-color Green -itemcolor Green -label timeout \
	/tb_rxuart_timeout/RxUART_timeout/timeout	