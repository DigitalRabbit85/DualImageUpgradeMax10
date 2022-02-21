vsim -novopt work.tb_read_bytes

#########################################################
add wave -noupdate -divider {tb_read_bytes}
add wave -noupdate -group {tb_read_bytes} -radix hexadecimal -format Logic /tb_read_bytes/*

#	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
#		-color Yellow -itemcolor Yellow \
#		-label clk /tb_read_bytes/SingleTxUART/clk
#	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
#		-color Red -itemcolor Red \
#		-label start /tb_read_bytes/SingleTxUART/start
#	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
#		-color Green -itemcolor Green \
#		-label tx_data /tb_read_bytes/SingleTxUART/tx_data
#	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
#		-color Cyan -itemcolor Cyan \
#		-label data_buf /tb_read_bytes/SingleTxUART/data_buf		
#	add wave -noupdate -group {SingleTxUART} -radix unsigned -format Logic \
#		-color Yellow -itemcolor Yellow \
#		-label len_bit /tb_read_bytes/SingleTxUART/len_bit			
#	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
#		-color Red -itemcolor Red \
#		-label clr_len_bit /tb_read_bytes/SingleTxUART/clr_len_bit		
#	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
#		-color Green -itemcolor Green \
#		-label cnt_bit /tb_read_bytes/SingleTxUART/cnt_bit		
#	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
#		-color Cyan -itemcolor Cyan \
#		-label width_word /tb_read_bytes/SingleTxUART/width_word		
#	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
#		-color Yellow -itemcolor Yellow \
#		-label busy /tb_read_bytes/SingleTxUART/busy			
#	add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic \
#		-color Red -itemcolor Red \
#		-label txd /tb_read_bytes/SingleTxUART/txd

#########################################################

