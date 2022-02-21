#set SHOW_RECEIVER  1
#set SHOW_SINGLE_RX_UART  2
#set SHOW_RX_UART_LOGIC  2
#set SHOW_RX_UART_TIMEOUT  2

vsim -novopt work.tb_writedata

#########################################################
add wave -noupdate -divider {tb_writedata}
add wave -noupdate -group {tb_writedata} -radix hexadecimal -format Logic /tb_writedata/*

#########################################################
add wave -noupdate -divider {tb_OnChipFlash}
add wave -noupdate -group {tb_OnChipFlash} -radix hexadecimal -format Logic /tb_writedata/Top/tb_OnChipFlash/*

#########################################################
add wave -noupdate -divider {Top}
add wave -noupdate -group {Top} -radix hexadecimal -format Logic /tb_writedata/Top/*

#########################################################
add wave -noupdate -divider {Receiver}
add wave -noupdate -group {Receiver} -radix hexadecimal -format Logic /tb_writedata/Top/Receiver/*
add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic /tb_writedata/Top/Receiver/RxUART_logic/*
add wave -noupdate -group {SingleRxUART} -radix hexadecimal -format Logic /tb_writedata/Top/Receiver/SingleRxUART/*
	
#########################################################
add wave -noupdate -divider {Transmitter}
add wave -noupdate -group {Transmitter} -radix hexadecimal -format Logic /tb_writedata/Top/Transmitter/*
add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic /tb_writedata/Top/Transmitter/TxUART_logic/*
add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic /tb_writedata/Top/Transmitter/SingleTxUART/*

#########################################################
add wave -noupdate -divider {Memory}
add wave -noupdate -group {Memory} -radix hexadecimal -format Logic /tb_writedata/Top/Memory/*
add wave -noupdate -group {RxRAM} -radix hexadecimal -format Logic /tb_writedata/Top/Memory/RxRAM/*
#add wave -noupdate -group {TxRAM} -radix hexadecimal -format Logic /tb_writedata/Top/Memory/TxRAM/*

#########################################################
add wave -noupdate -divider {MainControl}
add wave -noupdate -group {MainControl} -radix hexadecimal -format Logic /tb_writedata/Top/MainControl/*
add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic /tb_writedata/Top/MainControl/StateMachine/*
add wave -noupdate -group {ReadBytes} -radix hexadecimal -format Logic /tb_writedata/Top/MainControl/ReadBytes/*
add wave -noupdate -group {WriteBytes} -radix hexadecimal -format Logic /tb_writedata/Top/MainControl/WriteBytes/*

#########################################################
add wave -noupdate -divider {FlashControl}
add wave -noupdate -group {FlashControl} -radix hexadecimal -format Logic /tb_writedata/Top/FlashControl/*
add wave -noupdate -group {ControlInterface} -radix hexadecimal -format Logic /tb_writedata/Top/FlashControl/ControlInterface/*
add wave -noupdate -group {DataInterface} -radix hexadecimal -format Logic /tb_writedata/Top/FlashControl/DataInterface/*

