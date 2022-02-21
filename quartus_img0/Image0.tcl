# Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, the Altera Quartus Prime License Agreement,
# the Altera MegaCore Function License Agreement, or other 
# applicable license agreement, including, without limitation, 
# that your use is for the sole purpose of programming logic 
# devices manufactured by Altera and sold by Altera or its 
# authorized distributors.  Please refer to the applicable 
# agreement for further details.

# Quartus Prime: Generate Tcl File for Project
# File: Image0.tcl
# Generated on: Thu May 20 23:09:54 2021

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "Image0"]} {
		puts "Project Image0 is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists Image0]} {
		project_open -revision Image0 Image0
	} else {
		project_new -revision Image0 Image0
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "MAX 10"
	set_global_assignment -name DEVICE 10M08SAE144C8GES
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 15.1.2
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "22:54:52  MAY 20, 2021"
	set_global_assignment -name LAST_QUARTUS_VERSION 15.1.2
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/WriteBytes.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/TxUART_logic.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/Transmitter.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/Top.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/StateMachine.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/SingleTxUART.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/SingleRxUART.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/RxUART_timeout.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/RxUART_logic.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/Reset.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/Receiver.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/ReadBytes.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/Memory.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/MainControl.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/ImageControl.sv
	set_global_assignment -name SYSTEMVERILOG_FILE ../rtl/DualPortDualClock_ram.sv
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name DEVICE_FILTER_PACKAGE EQFP
	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 144
	set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 8
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
