onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate {/DE1_SoC_testbench/SW[9]}
add wave -noupdate {/DE1_SoC_testbench/KEY[0]}
add wave -noupdate -expand /DE1_SoC_testbench/LEDR
add wave -noupdate /DE1_SoC_testbench/HEX0
add wave -noupdate -radix unsigned /DE1_SoC_testbench/dut/lfsr1/Q
add wave -noupdate -radix unsigned /DE1_SoC_testbench/dut/cy/SW
add wave -noupdate /DE1_SoC_testbench/HEX5
add wave -noupdate /DE1_SoC_testbench/dut/cy/outC
add wave -noupdate /DE1_SoC_testbench/dut/input3/out
add wave -noupdate /DE1_SoC_testbench/dut/lfsr1/Q
add wave -noupdate /DE1_SoC_testbench/dut/lfsr1/clk
add wave -noupdate /DE1_SoC_testbench/dut/lfsr1/reset
add wave -noupdate /DE1_SoC_testbench/dut/lfsr1/xnorQ
add wave -noupdate /DE1_SoC_testbench/dut/cy/cyb/A
add wave -noupdate /DE1_SoC_testbench/dut/cy/cyb/B
add wave -noupdate /DE1_SoC_testbench/dut/cy/cyb/out
add wave -noupdate /DE1_SoC_testbench/dut/cy/cyb/holdout
add wave -noupdate /DE1_SoC_testbench/dut/input3/button
add wave -noupdate /DE1_SoC_testbench/dut/input3/button0
add wave -noupdate /DE1_SoC_testbench/dut/input3/buttonF
add wave -noupdate /DE1_SoC_testbench/dut/input3/clk
add wave -noupdate /DE1_SoC_testbench/dut/input3/reset
add wave -noupdate /DE1_SoC_testbench/dut/input3/out
add wave -noupdate /DE1_SoC_testbench/dut/input3/ps
add wave -noupdate /DE1_SoC_testbench/dut/input3/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {70 ps}
