# ================= LIBRARY SETUP =================
set_attribute init_lib_search_path ./library
set_attribute library fast.lib

# ================= READ RTL =================
read_hdl {./verilog/spi_master_top.v}

# ================= ELABORATE =================
elaborate spi_master_top

# ================= READ CONSTRAINTS =================
read_sdc ./spi_master_top.sdc

# ================= SYNTHESIS SETTINGS =================
set_attribute syn_generic_effort medium
set_attribute syn_map_effort medium
set_attribute syn_opt_effort medium

# ================= SYNTHESIS FLOW =================
syn_generic
syn_map
syn_opt

# ================= WRITE OUTPUTS =================
write_hdl > spi_master_top_netlist.v
write_sdc > spi_master_top_out.sdc

# ================= REPORTS =================
report timing > spi_master_timing.rpt
report area > spi_master_area.rpt
report gates > spi_master_gates.rpt

# ================= GUI =================
gui_show

