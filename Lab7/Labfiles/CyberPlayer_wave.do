onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CyberPlayer_testbench/CLOCK_PERIOD
add wave -noupdate /CyberPlayer_testbench/CLOCK_50
add wave -noupdate /CyberPlayer_testbench/reset
add wave -noupdate /CyberPlayer_testbench/SW
add wave -noupdate /CyberPlayer_testbench/outC
add wave -noupdate /CyberPlayer_testbench/dut/cyb/A
add wave -noupdate /CyberPlayer_testbench/dut/cyb/B
add wave -noupdate /CyberPlayer_testbench/dut/cyb/out
add wave -noupdate /CyberPlayer_testbench/dut/lfsr1/Q
add wave -noupdate /CyberPlayer_testbench/dut/lfsr1/clk
add wave -noupdate /CyberPlayer_testbench/dut/lfsr1/reset
add wave -noupdate /CyberPlayer_testbench/dut/lfsr1/xnorQ
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {94 ps} 0}
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
WaveRestoreZoom {0 ps} {473 ps}
