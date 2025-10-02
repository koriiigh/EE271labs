onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate {/DE1_SoC_testbench/SW[9]}
add wave -noupdate /DE1_SoC_testbench/KEY
add wave -noupdate /DE1_SoC_testbench/HEX0
add wave -noupdate /DE1_SoC_testbench/dut/upPulse
add wave -noupdate /DE1_SoC_testbench/dut/downPulse
add wave -noupdate /DE1_SoC_testbench/dut/leftPulse
add wave -noupdate /DE1_SoC_testbench/dut/rightPulse
add wave -noupdate -expand /DE1_SoC_testbench/dut/RedPixels
add wave -noupdate /DE1_SoC_testbench/dut/GrnPixels
add wave -noupdate /DE1_SoC_testbench/dut/game_inst/frogAtBottom
add wave -noupdate -radix unsigned /DE1_SoC_testbench/dut/game_inst/frogRow
add wave -noupdate -radix unsigned /DE1_SoC_testbench/dut/game_inst/frogCol
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1662 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 207
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
WaveRestoreZoom {860 ps} {1734 ps}
