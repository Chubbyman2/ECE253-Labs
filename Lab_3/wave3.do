vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.v

#load simulation using mux as the top level simulation module
vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets

# Case 1
force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0
force {B[0]} 1
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0
force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 0
run 10ns

# Case 2
force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0
force {B[0]} 1
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0
force {Function[0]} 1
force {Function[1]} 0
force {Function[2]} 0
run 10ns

# Case 3a
force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0
force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 1
force {Function[0]} 0
force {Function[1]} 1
force {Function[2]} 0
run 10ns

# Case 3b
force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0
force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0
force {Function[0]} 0
force {Function[1]} 1
force {Function[2]} 0
run 10ns

# Case 4a
force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0
force {B[0]} 0
force {B[1]} 0
force {B[2]} 1
force {B[3]} 0
force {Function[0]} 1
force {Function[1]} 1
force {Function[2]} 0
run 10ns

# Case 4b
force {A[0]} 0
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0
force {B[0]} 0
force {B[1]} 0
force {B[2]} 0
force {B[3]} 0
force {Function[0]} 1
force {Function[1]} 1
force {Function[2]} 0
run 10ns

# Case 5a
force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1
force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1
force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 1
run 10ns

# Case 5b
force {A[0]} 1
force {A[1]} 1
force {A[2]} 1
force {A[3]} 1
force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 0
force {Function[0]} 0
force {Function[1]} 0
force {Function[2]} 1

# Case 6
force {A[0]} 1
force {A[1]} 0
force {A[2]} 0
force {A[3]} 0
force {B[0]} 1
force {B[1]} 1
force {B[2]} 1
force {B[3]} 1
force {Function[0]} 1
force {Function[1]} 0
force {Function[2]} 1
run 10ns