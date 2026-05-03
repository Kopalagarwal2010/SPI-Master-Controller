# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Fri Apr 24 12:53:35 IST 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design spi_master_top

create_clock -name "clk" -period 6.0 -waveform {0.0 3.0} [get_ports clk]
set_clock_transition 0.8 [get_clocks clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports rst]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports start]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {data_in[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {data_in[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {data_in[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {data_in[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {data_in[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {data_in[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {data_in[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {data_in[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports miso]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports mosi]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports sclk]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports cs]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {rx_data[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {rx_data[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {rx_data[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {rx_data[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {rx_data[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {rx_data[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {rx_data[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {rx_data[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports alert]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports done]
set_wire_load_mode "enclosed"
set_clock_uncertainty -setup 0.01 [get_clocks clk]
set_clock_uncertainty -hold 0.01 [get_clocks clk]
