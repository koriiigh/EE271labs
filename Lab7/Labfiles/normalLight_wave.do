onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /normalLight_testbench/dut/clk
add wave -noupdate /normalLight_testbench/dut/reset
add wave -noupdate /normalLight_testbench/dut/L
add wave -noupdate /normalLight_testbench/dut/R
add wave -noupdate /normalLight_testbench/dut/NL
add wave -noupdate /normalLight_testbench/dut/NR
add wave -noupdate /normalLight_testbench/dut/lightOn
add wave -noupdate /normalLight_testbench/dut/ps
add wave -noupdate /normalLight_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {156 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {452 ps}
