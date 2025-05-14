# Set the project name and directory
set proj_name "ETHERNET_WITH_APB"
set proj_dir "./project"

# Create a new Vivado project with force option to overwrite if it exists
create_project $proj_name $proj_dir -part xc7z020clg484-1 -force

# Define a procedure to add files from a specified directory
proc add_files_from_dir {dir fileset file_extension} {
    set file_list [glob -nocomplain -directory $dir *.$file_extension]
    foreach file $file_list {
        add_files -fileset $fileset $file
    }
}

# Add source files (Verilog and VHDL)
add_files_from_dir "./src" "sources_1" "v"
add_files_from_dir "./src" "sources_1" "sv"

# Add testbench files if necessary
add_files_from_dir "./tb" "sim_1" "v"
add_files_from_dir "./tb" "sim_1" "sv"

