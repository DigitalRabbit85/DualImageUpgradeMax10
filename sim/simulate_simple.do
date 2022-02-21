vsim -novopt work.tb_simple

#########################################################
add wave -noupdate -divider {tb_simple}
add wave -noupdate -group {tb_simple} -radix hexadecimal -format Logic /tb_simple/*

#########################################################
add wave -noupdate -divider {Top}
add wave -noupdate -group {Top} -radix hexadecimal -format Logic /tb_simple/Top/*

#########################################################
add wave -noupdate -divider {Receiver}
add wave -noupdate -group {Receiver} -radix hexadecimal -format Logic /tb_simple/Top/Receiver/*
add wave -noupdate -group {SingleRxUART} -radix hexadecimal -format Logic /tb_simple/Top/Receiver/SingleRxUART/*
add wave -noupdate -group {RxUART_timeout} -radix hexadecimal -format Logic /tb_simple/Top/Receiver/RxUART_timeout/*
add wave -noupdate -group {RxUART_logic} -radix hexadecimal -format Logic /tb_simple/Top/Receiver/RxUART_logic/*

#########################################################
add wave -noupdate -divider {Transmitter}
add wave -noupdate -group {Transmitter} -radix hexadecimal -format Logic /tb_simple/Top/Transmitter/*
add wave -noupdate -group {TxUART_logic} -radix hexadecimal -format Logic /tb_simple/Top/Transmitter/TxUART_logic/*
add wave -noupdate -group {SingleTxUART} -radix hexadecimal -format Logic /tb_simple/Top/Transmitter/SingleTxUART/*

#########################################################
#add wave -noupdate -divider {Memory}
#add wave -noupdate -group {Memory} -radix hexadecimal -format Logic /tb_simple/Top/Memory/*
#add wave -noupdate -group {RxRAM} -radix hexadecimal -format Logic /tb_simple/Top/Memory/RxRAM/*

#########################################################
#add wave -noupdate -divider {StateMachine}
#add wave -noupdate -group {StateMachine} -radix hexadecimal -format Logic /tb_simple/Top/StateMachine/*

