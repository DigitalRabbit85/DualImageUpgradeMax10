set SHOW_RECEIVER  1
set SHOW_SINGLE_RX_UART  2
set SHOW_RX_UART_LOGIC  2
set SHOW_RX_UART_TIMEOUT  2

vsim -novopt work.tb_swimage

#########################################################
add wave -noupdate -divider {tb_swimage}
add wave -noupdate -group {tb_swimage} -radix hexadecimal -format Logic /tb_swimage/*

#########################################################
add wave -noupdate -divider {tb_RSU_Block}
add wave -noupdate -group {tb_RSU_Block} -radix hexadecimal -format Logic /tb_swimage/Top/tb_RSU_Block/*

#########################################################
add wave -noupdate -divider {Top}
add wave -noupdate -group {Top} -radix hexadecimal -format Logic /tb_swimage/Top/*

#########################################################

if {$SHOW_RECEIVER != 0} {
	add wave -noupdate -divider {Receiver} 
	}
if {$SHOW_RECEIVER == 1}	{
	add wave -noupdate -group {Receiver} -radix hexadecimal \
		-format Logic /tb_swimage/Top/Receiver/*
	}

#########################################################	

if {$SHOW_SINGLE_RX_UART == 1} {
	add wave -noupdate -group {SingleRxUART} -radix hexadecimal \
		-format Logic /tb_swimage/Top/Receiver/SingleRxUART/*
	}
if {$SHOW_SINGLE_RX_UART == 2} {	
	add wave -noupdate -group {SingleRxUART} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label clk /tb_swimage/Top/Receiver/SingleRxUART/clk
	add wave -noupdate -group {SingleRxUART} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label rxd /tb_swimage/Top/Receiver/SingleRxUART/rxd	
	add wave -noupdate -group {SingleRxUART} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label rxd_ /tb_swimage/Top/Receiver/SingleRxUART/rxd_	
	add wave -noupdate -group {SingleRxUART} -radix unsigned -format Logic \
		-color Cyan -itemcolor Cyan \
		-label len_bit /tb_swimage/Top/Receiver/SingleRxUART/len_bit
	add wave -noupdate -group {SingleRxUART} -radix unsigned -format Logic \
		-color Yellow -itemcolor Yellow \
		-label cnt_bit /tb_swimage/Top/Receiver/SingleRxUART/cnt_bit	
	add wave -noupdate -group {SingleRxUART} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label bit_mid /tb_swimage/Top/Receiver/SingleRxUART/bit_mid
	add wave -noupdate -group {SingleRxUART} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label bit_full /tb_swimage/Top/Receiver/SingleRxUART/bit_full
	add wave -noupdate -group {SingleRxUART} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label busy /tb_swimage/Top/Receiver/SingleRxUART/busy	
	add wave -noupdate -group {SingleRxUART} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label data_buf /tb_swimage/Top/Receiver/SingleRxUART/data_buf	
	add wave -noupdate -group {SingleRxUART} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label rx_data /tb_swimage/Top/Receiver/SingleRxUART/rx_data
	add wave -noupdate -group {SingleRxUART} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label done /tb_swimage/Top/Receiver/SingleRxUART/done	
	}

#########################################################
	
if {$SHOW_RX_UART_LOGIC == 1} {
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal \
		-format Logic /tb_swimage/Top/Receiver/RxUART_logic/*
	}
if {$SHOW_RX_UART_LOGIC == 2} {		
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label clk /tb_swimage/Top/Receiver/RxUART_logic/clk
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label rx_data /tb_swimage/Top/Receiver/RxUART_logic/rx_data
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label rx_done /tb_swimage/Top/Receiver/RxUART_logic/rx_done
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label cnt_byte /tb_swimage/Top/Receiver/RxUART_logic/cnt_byte
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label cmd_rx /tb_swimage/Top/Receiver/RxUART_logic/cmd_rx
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label len_rx /tb_swimage/Top/Receiver/RxUART_logic/len_rx
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label crc_calc /tb_swimage/Top/Receiver/RxUART_logic/crc_calc	
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label wr_data /tb_swimage/Top/Receiver/RxUART_logic/wr_data
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label wr_addr /tb_swimage/Top/Receiver/RxUART_logic/wr_addr
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label wr_clock /tb_swimage/Top/Receiver/RxUART_logic/wr_clock
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label we /tb_swimage/Top/Receiver/RxUART_logic/we
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label clr_addr /tb_swimage/Top/Receiver/RxUART_logic/clr_addr
	add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label pck_done /tb_swimage/Top/Receiver/RxUART_logic/pck_done
	}

if {$SHOW_RX_UART_TIMEOUT == 1} {
	add wave -noupdate -group {RxUART_timeout} -radix hexadecimal \
		-format Logic /tb_swimage/Top/Receiver/RxUART_timeout/*
	}
if {$SHOW_RX_UART_TIMEOUT == 2} {
	add wave -noupdate -group {RxUART_timeout} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label clk /tb_swimage/Top/Receiver/RxUART_timeout/clk
	add wave -noupdate -group {RxUART_timeout} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label rx_done /tb_swimage/Top/Receiver/RxUART_timeout/rx_done
	add wave -noupdate -group {RxUART_timeout} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label rx_busy /tb_swimage/Top/Receiver/RxUART_timeout/rx_busy
	add wave -noupdate -group {RxUART_timeout} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label start_timeout /tb_swimage/Top/Receiver/RxUART_timeout/start_timeout
	add wave -noupdate -group {RxUART_timeout} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label len_bit /tb_swimage/Top/Receiver/RxUART_timeout/len_bit
	add wave -noupdate -group {RxUART_timeout} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label clr_len_bit /tb_swimage/Top/Receiver/RxUART_timeout/clr_len_bit
	add wave -noupdate -group {RxUART_timeout} -radix hexadecimal -format Logic \
		-color Green -itemcolor Green \
		-label len_byte /tb_swimage/Top/Receiver/RxUART_timeout/len_byte
	add wave -noupdate -group {RxUART_timeout} -radix hexadecimal -format Logic \
		-color Cyan -itemcolor Cyan \
		-label clr_len_byte /tb_swimage/Top/Receiver/RxUART_timeout/clr_len_byte
	add wave -noupdate -group {RxUART_timeout} -radix hexadecimal -format Logic \
		-color Yellow -itemcolor Yellow \
		-label cnt_byte /tb_swimage/Top/Receiver/RxUART_timeout/cnt_byte
	add wave -noupdate -group {RxUART_timeout} -radix hexadecimal -format Logic \
		-color Red -itemcolor Red \
		-label timeout /tb_swimage/Top/Receiver/RxUART_timeout/timeout
	}
	
#########################################################
add wave -noupdate -divider {Transmitter}
add wave -noupdate -group {Transmitter} -radix hexadecimal -format Logic /tb_swimage/Top/Transmitter/*
add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic /tb_swimage/Top/Transmitter/TxUART_logic/*
add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic /tb_swimage/Top/Transmitter/SingleTxUART/*

#########################################################
add wave -noupdate -divider {Memory}
add wave -noupdate -group {Memory} -radix hexadecimal -format Logic /tb_swimage/Top/Memory/*
add wave -noupdate -group {RxRAM} -radix hexadecimal -format Logic /tb_swimage/Top/Memory/RxRAM/*
add wave -noupdate -group {TxRAM} -radix hexadecimal -format Logic /tb_swimage/Top/Memory/TxRAM/*

#########################################################
add wave -noupdate -divider {MainControl}
add wave -noupdate -group {MainControl} -radix hexadecimal -format Logic /tb_swimage/Top/MainControl/*
add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic /tb_swimage/Top/MainControl/StateMachine/*
add wave -noupdate -group {ReadBytes} -radix hexadecimal -format Logic /tb_swimage/Top/MainControl/ReadBytes/*
add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic /tb_swimage/Top/MainControl/WriteBytes/*

#########################################################
add wave -noupdate -divider {ImageControl}
add wave -noupdate -group {ImageControl} -radix hexadecimal -format Logic /tb_swimage/Top/ImageControl/*

