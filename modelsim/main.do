#Directory
set dir_prj {D:/Sources/Altera/Max10Kit/DualImageUpgradeMax10}

#Include Directory
set dir_rtl $dir_prj/rtl
set dir_sim $dir_prj/sim
set dir_tb $dir_prj/testbench

#Compilation
puts "What do you for compilation project:"
puts "input 0 - no compilation"
puts "input 1 - simple test"
puts "input 2 - ImageSwitcher test"
puts "input 3 - Transmitter test"
puts "input 4 - Img Switchers test"
puts "input 5 - SingleTxUART test"
puts "input 6 - ReadBytes test"
puts "input 7 - WriteBytes test"
puts "input 8 - ImageControl test"
puts "input 9 - Status and Control Registers"
puts "input 10 - Read Data"
puts "input 11 - Write Data"
puts "input 12 - FlashControl"
puts "input 13 - Read/Write Status and Control Registers"
puts "input 14 - Read CFM"
puts "input 15 - Write CFM"
set compilation [gets stdin]
if {$compilation == 1} {do $dir_sim/compile_simple.do}
if {$compilation == 2} {do $dir_sim/compile_swimage.do}
if {$compilation == 3} {do $dir_sim/compile_transmitter.do}
if {$compilation == 4} {do $dir_sim/compile_img_switchers.do}
if {$compilation == 5} {do $dir_sim/compile_singletxuart.do}
if {$compilation == 6} {do $dir_sim/compile_readbytes.do}
if {$compilation == 7} {do $dir_sim/compile_writebytes.do}
if {$compilation == 8} {do $dir_sim/compile_imagecontrol.do}
if {$compilation == 9} {do $dir_sim/compile_srcr.do}
if {$compilation == 10} {do $dir_sim/compile_readdata.do}
if {$compilation == 11} {do $dir_sim/compile_writedata.do}
if {$compilation == 12} {do $dir_sim/compile_flashcontrol.do}
if {$compilation == 13} {do $dir_sim/compile_readwrite_status_and_control.do}
if {$compilation == 14} {do $dir_sim/compile_read_cfm.do}
if {$compilation == 15} {do $dir_sim/compile_write_cfm.do}

#Simulation
puts "Do you want simulation? (1 - yes, 0 - no)"
set simulation [gets stdin]
if {$simulation == 1} {
    if {$compilation == 1} {do $dir_sim/simulate_simple.do}
    if {$compilation == 2} {do $dir_sim/simulate_swimage.do}
	if {$compilation == 3} {do $dir_sim/simulate_transmitter.do}
	if {$compilation == 4} {do $dir_sim/simulate_img_switchers.do}
	if {$compilation == 5} {do $dir_sim/simulate_singletxuart.do}
	if {$compilation == 6} {do $dir_sim/simulate_readbytes.do}
	if {$compilation == 7} {do $dir_sim/simulate_writebytes.do}
	if {$compilation == 8} {do $dir_sim/simulate_imagecontrol.do}	
	if {$compilation == 9} {do $dir_sim/simulate_srcr.do}
	if {$compilation == 10} {do $dir_sim/simulate_readdata.do}
    if {$compilation == 11} {do $dir_sim/simulate_writedata.do}
    if {$compilation == 12} {do $dir_sim/simulate_flashcontrol.do}
    if {$compilation == 13} {do $dir_sim/simulate_readwrite_status_and_control.do}
    if {$compilation == 14} {do $dir_sim/simulate_read_cfm.do}
    if {$compilation == 15} {do $dir_sim/simulate_write_cfm.do}
    puts "You may input RUN-command now, for example <run 1 ms>"}