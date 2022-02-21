vsim -novopt work.singletxuart


add wave -noupdate -divider {singletxuart}
add wave -noupdate -group {singletxuart} -radix hexadecimal -format Logic /singletxuart/*

	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label clk /singletxuart/SingleTxUART/clk
	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label start /singletxuart/SingleTxUART/start
	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label tx_data /singletxuart/SingleTxUART/tx_data
	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label data_buf /singletxuart/SingleTxUART/data_buf		
	add wave -noupdate -group {SingleTxUART} -radix unsigned -format Logic \
		-color Yellow -itemcolor Yellow \
		-label len_bit /singletxuart/SingleTxUART/len_bit			
	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label clr_len_bit /singletxuart/SingleTxUART/clr_len_bit		
	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label cnt_bit /singletxuart/SingleTxUART/cnt_bit		
	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label width_word /singletxuart/SingleTxUART/width_word		
	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label busy /singletxuart/SingleTxUART/busy			
	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label txd /singletxuart/SingleTxUART/txd



