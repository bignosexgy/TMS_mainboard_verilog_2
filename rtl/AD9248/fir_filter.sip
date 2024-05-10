set_global_assignment -entity "fir_filter" -library "lib_fir_filter" -name IP_TOOL_NAME "altera_fir_compiler_ii"
set_global_assignment -entity "fir_filter" -library "lib_fir_filter" -name IP_TOOL_VERSION "15.0"
set_global_assignment -entity "fir_filter" -library "lib_fir_filter" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_fir_filter" -name SPD_FILE [file join $::quartus(sip_path) "fir_filter.spd"]
