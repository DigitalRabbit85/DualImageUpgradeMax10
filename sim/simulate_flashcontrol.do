vsim -novopt work.tb_flashcontrol

#########################################################
add wave -noupdate -divider {tb_flashcontrol}
add wave -noupdate -group {tb_flashcontrol} -radix hexadecimal -format Logic /tb_flashcontrol/*

#########################################################
add wave -noupdate -divider {tb_OnChipFlash}
add wave -noupdate -group {tb_OnChipFlash} -radix hexadecimal -format Logic /tb_flashcontrol/tb_OnChipFlash/*

#########################################################
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label clk /tb_flashcontrol/ControlInterface/clk
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label start_rdsr /tb_flashcontrol/ControlInterface/start_rdsr
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label start_rdcr /tb_flashcontrol/ControlInterface/start_rdcr
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label start_wrcr /tb_flashcontrol/ControlInterface/start_wrcr
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label rd_data /tb_flashcontrol/ControlInterface/rd_data
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label wr_data /tb_flashcontrol/ControlInterface/wr_data
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label Addr /tb_flashcontrol/ControlInterface/Addr
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label Read /tb_flashcontrol/ControlInterface/Read
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label latch_read /tb_flashcontrol/ControlInterface/latch_read
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label ReadData /tb_flashcontrol/ControlInterface/ReadData
    	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label Write /tb_flashcontrol/ControlInterface/Write
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label WriteData /tb_flashcontrol/ControlInterface/WriteData
	add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label done /tb_flashcontrol/ControlInterface/done

#########################################################
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label clk /tb_flashcontrol/DataInterface/clk
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label start_addr /tb_flashcontrol/DataInterface/start_addr
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label start_rddata /tb_flashcontrol/DataInterface/start_rddata
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label rw_addr /tb_flashcontrol/DataInterface/rw_addr
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label rd_data /tb_flashcontrol/DataInterface/rd_data
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label Addr /tb_flashcontrol/DataInterface/Addr
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label Read /tb_flashcontrol/DataInterface/Read
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label ReadData /tb_flashcontrol/DataInterface/ReadData
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label ReadDataValid /tb_flashcontrol/DataInterface/ReadDataValid
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label BurstCount /tb_flashcontrol/DataInterface/BurstCount
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label incr_addr /tb_flashcontrol/DataInterface/incr_addr
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label done_read /tb_flashcontrol/DataInterface/done_read
	add wave -noupdate -group {DataInterface - Read} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label done /tb_flashcontrol/DataInterface/done

#########################################################
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label clk /tb_flashcontrol/DataInterface/clk
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label start_addr /tb_flashcontrol/DataInterface/start_addr
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label start_wrdata /tb_flashcontrol/DataInterface/start_wrdata
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label rw_addr /tb_flashcontrol/DataInterface/rw_addr
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label wr_data /tb_flashcontrol/DataInterface/wr_data
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label Addr /tb_flashcontrol/DataInterface/Addr
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label Write /tb_flashcontrol/DataInterface/Write
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label WriteData /tb_flashcontrol/DataInterface/WriteData
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label WaitRequest /tb_flashcontrol/DataInterface/WaitRequest
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label BurstCount /tb_flashcontrol/DataInterface/BurstCount
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label incr_addr /tb_flashcontrol/DataInterface/incr_addr
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label done_write /tb_flashcontrol/DataInterface/done_write
	add wave -noupdate -group {DataInterface - Write} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label done /tb_flashcontrol/DataInterface/done		
		
#########################################################
#add wave -noupdate -divider {ControlInterface}
#add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic /tb_flashcontrol/ControlInterface/*

#########################################################
add wave -noupdate -divider {DataInterface}
add wave -noupdate -group {DataInterface} -radix hexadecimal -format Logic /tb_flashcontrol/DataInterface/*

#########################################################

