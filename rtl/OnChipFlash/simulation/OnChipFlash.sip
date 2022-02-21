set_global_assignment -entity "OnChipFlash" -library "lib_OnChipFlash" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "OnChipFlash" -library "lib_OnChipFlash" -name IP_TOOL_VERSION "15.1"
set_global_assignment -entity "OnChipFlash" -library "lib_OnChipFlash" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_OnChipFlash" -name SPD_FILE [file join $::quartus(sip_path) "../OnChipFlash.spd"]
set_global_assignment -library "lib_OnChipFlash" -name MISC_FILE [file join $::quartus(sip_path) "../../OnChipFlash.qsys"]

set_global_assignment -library "lib_OnChipFlash" -name MISC_FILE [file join $::quartus(sip_path) "OnChipFlash.v"]
set_global_assignment -library "lib_OnChipFlash" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_onchip_flash_util.v"]
set_global_assignment -library "lib_OnChipFlash" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_onchip_flash.v"]
set_global_assignment -library "lib_OnChipFlash" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_onchip_flash_avmm_data_controller.v"]
set_global_assignment -library "lib_OnChipFlash" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_onchip_flash_avmm_csr_controller.v"]
