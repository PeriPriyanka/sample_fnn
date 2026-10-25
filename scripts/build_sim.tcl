
# =====================================================
# 1. Find project directories
# =====================================================

# Directory containing this Tcl script
set script_dir [file dirname [file normalize [info script]]]

# Parent directory of scripts/
set parent_dir [file normalize [file join $script_dir ..]]

# Source directory
set source_dir [file join $parent_dir sources]

# Simulation output directory
set output_dir [file join $parent_dir sim_outputs]

# Create output directory if it does not exist
file mkdir $output_dir

# Change working directory
cd $output_dir


# =====================================================
# 2. Compile Verilog files
# =====================================================

puts "Compiling Verilog design and testbench..."

exec xvlog \
    [file join $source_dir sample_fnn.v] \
    [file join $source_dir sample_fnn_tb.v]


# =====================================================
# 3. Elaborate testbench with debug information
# =====================================================

puts "Elaborating testbench with waveform debug enabled..."

exec xelab \
    sample_fnn_tb \
    -debug typical \
    -s sample_fnn_tb_sim


# =====================================================
# 4. Create waveform Tcl script
# =====================================================

set wave_script [file join $output_dir view_wave.tcl]

set fp [open $wave_script w]

puts $fp {log_wave -r /*}
puts $fp {run all}

close $fp


# =====================================================
# 5. Run simulation and open waveform GUI
# =====================================================

puts "Starting simulation GUI..."

exec xsim sample_fnn_tb_sim \
    -gui \
    -wdb [file join $output_dir sample_fnn.wdb] \
    -tclbatch $wave_script

puts "Simulation completed."
