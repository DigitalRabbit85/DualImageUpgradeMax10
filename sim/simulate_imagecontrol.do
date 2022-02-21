vsim -novopt work.tb_imagecontrol

#########################################################
add wave -noupdate -divider {tb_imagecontrol}
add wave -noupdate -group {tb_imagecontrol} -radix hexadecimal -format Logic /tb_imagecontrol/*

#	add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic \
#		-color Yellow -itemcolor Yellow \
#		-label clk /tb_imagecontrol/ImageControl/clk
#	add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic \
#		-color Red -itemcolor Red \
#		-label start /tb_imagecontrol/ImageControl/start
#	add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic \
#		-color Green -itemcolor Green \
#		-label cnt /tb_imagecontrol/ImageControl/cnt
#	add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic \
#		-color Cyan -itemcolor Cyan \
#		-label word_buf /tb_imagecontrol/ImageControl/word_buf
#	add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic \
#		-color Yellow -itemcolor Yellow \
#		-label wr_data /tb_imagecontrol/ImageControl/wr_data
#	add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic \
#		-color Red -itemcolor Red \
#		-label wr_addr /tb_imagecontrol/ImageControl/wr_addr
#	add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic \
#		-color Green -itemcolor Green \
#		-label wr_clock /tb_imagecontrol/ImageControl/wr_clock
#	add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic \
#		-color Cyan -itemcolor Cyan \
#		-label we /tb_imagecontrol/ImageControl/we
#	add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic \
#		-color Yellow -itemcolor Yellow \
#		-label done /tb_imagecontrol/ImageControl/done
#	add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic \
#		-color Red -itemcolor Red \
#		-label word /tb_imagecontrol/ImageControl/word
#	add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic \
#		-color Green -itemcolor Green \
#		-label addr /tb_imagecontrol/ImageControl/addr

#########################################################
add wave -noupdate -divider {ImageControl}
add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic /tb_imagecontrol/ImageControl/*

#########################################################

