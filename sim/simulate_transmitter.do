vsim -novopt work.tb_transmitter

#########################################################
add wave -noupdate -divider {tb_transmitter}
add wave -noupdate -group {tb_transmitter} -radix hexadecimal -format Logic /tb_transmitter/*

#########################################################
add wave -noupdate -divider {Transmitter}
add wave -noupdate -group {Transmitter} -radix hexadecimal -format Logic /tb_transmitter/Transmitter/*

#########################################################
add wave -noupdate -divider {SingleTxUART}
add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic /tb_transmitter/Transmitter/SingleTxUART/*

#########################################################
#add wave -noupdate -divider {TxUART_logic}
#add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic /tb_transmitter/Transmitter/TxUART_logic/*

#########################################################
add wave -noupdate -divider {TxUART_logic}

	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label clk /tb_transmitter/Transmitter/TxUART_logic/clk
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label start_pckt /tb_transmitter/Transmitter/TxUART_logic/start_pckt
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label cmd_tx /tb_transmitter/Transmitter/TxUART_logic/cmd_tx
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label len_tx /tb_transmitter/Transmitter/TxUART_logic/len_tx
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label incr_byte /tb_transmitter/Transmitter/TxUART_logic/incr_byte
	add wave -noupdate -group {TxUART_logic} -radix unsigned -format Logic \
		-color Red -itemcolor Red \
		-label cnt_byte /tb_transmitter/Transmitter/TxUART_logic/cnt_byte
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label load_byte /tb_transmitter/Transmitter/TxUART_logic/load_byte
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label start_byte /tb_transmitter/Transmitter/TxUART_logic/start_byte
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label rd_addr /tb_transmitter/Transmitter/TxUART_logic/rd_addr
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label rd_clock /tb_transmitter/Transmitter/TxUART_logic/rd_clock
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label rd_data /tb_transmitter/Transmitter/TxUART_logic/rd_data
	add wave -noupdate -group {TxUART_logic} -radix unsigned -format Logic \
		-color Cyan -itemcolor Cyan \
		-label len_bit /tb_transmitter/Transmitter/TxUART_logic/len_bit
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label cnt_bit_incr /tb_transmitter/Transmitter/TxUART_logic/cnt_bit_incr
	add wave -noupdate -group {TxUART_logic} -radix unsigned -format Logic \
		-color Red -itemcolor Red \
		-label cnt_bit /tb_transmitter/Transmitter/TxUART_logic/cnt_bit
	add wave -noupdate -group {TxUART_logic} -radix unsigned -format Logic \
		-color Green -itemcolor Green \
		-label num_pause /tb_transmitter/Transmitter/TxUART_logic/num_pause
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label next_byte /tb_transmitter/Transmitter/TxUART_logic/next_byte
    add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label sum_calc /tb_transmitter/Transmitter/TxUART_logic/sum_calc
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label tx_start /tb_transmitter/Transmitter/TxUART_logic/tx_start
	add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label tx_data /tb_transmitter/Transmitter/TxUART_logic/tx_data