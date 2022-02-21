vsim -novopt work.tb_write_bytes

#########################################################
add wave -noupdate -divider {tb_write_bytes}
add wave -noupdate -group {tb_write_bytes} -radix hexadecimal -format Logic /tb_write_bytes/*

	add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label clk /tb_write_bytes/WriteBytes/clk
	add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label start /tb_write_bytes/WriteBytes/start
	add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label cnt /tb_write_bytes/WriteBytes/cnt
	add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label word_buf /tb_write_bytes/WriteBytes/word_buf
	add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label wr_data /tb_write_bytes/WriteBytes/wr_data
	add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label wr_addr /tb_write_bytes/WriteBytes/wr_addr
	add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label wr_clock /tb_write_bytes/WriteBytes/wr_clock
	add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label we /tb_write_bytes/WriteBytes/we
	add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label done /tb_write_bytes/WriteBytes/done
	add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label word /tb_write_bytes/WriteBytes/word
    	add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label addr /tb_write_bytes/WriteBytes/addr

#########################################################
#add wave -noupdate -divider {WriteBytes}
#add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic /tb_write_bytes/WriteBytes/*

#########################################################

