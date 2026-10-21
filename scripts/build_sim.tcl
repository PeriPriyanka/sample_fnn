
# Find the script directory
set script_dir [file dirname [file normalize [info script]]]

# parent directory
set parent_dir [file normalize [file join $script_dir ..]]

# Create an output directory
set output_dir [file join $parent_dir  sim_outputs]
file mkdir $output_dir

#source directory
set source_dir [file join $parent_dir  sources]

# Compile the design and testbench, then run simulation
exec xvlog [file join $source_dir sample_fnn.v] \
           [file join $source_dir sample_fnn_tb.v]

exec xelab sample_fnn_tb -s sample_fnn_tb_sim

exec xsim sample_fnn_tb_sim -runall

puts "Simulation completed."
