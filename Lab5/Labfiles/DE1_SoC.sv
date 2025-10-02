module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, KEY, SW); 
	input logic CLOCK_50;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	logic [31:0] div_clk; 
 

	logic reset; 
	assign reset = ~KEY[0];
 
	parameter whichClock = 25;
 
clock_divider cdiv ( .clock(CLOCK_50),
							.reset(reset),
							.divided_clocks(div_clk) 
); 
 

	logic clkSelect; 
	 
	`ifdef ALTERA_RESERVED_QIS 
		 assign clkSelect = div_clk[whichClock]; 
	`else 
		 assign clkSelect = CLOCK_50; 
	`endif 
 

hazard_lights HL (.clk(clkSelect), .reset(reset), .wind(SW[1:0]), .lights(LEDR[2:0])); 
 

	assign LEDR[9] = clkSelect; 
	assign LEDR[8] = reset; 
	assign LEDR[7:3] = 5'b0; 
	 

	assign HEX0 = 7'b111_1111; 
	assign HEX1 = 7'b111_1111; 
	assign HEX2 = 7'b111_1111; 
	assign HEX3 = 7'b111_1111; 
	assign HEX4 = 7'b111_1111; 
	assign HEX5 = 7'b111_1111; 
  

endmodule
module DE1_SoC_testbench(); 
	logic CLOCK_50; 
	logic [3:0] KEY; 
	logic [9:0] SW; 
	logic [9:0] LEDR; 
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 

	DE1_SoC dut ( 
		 .CLOCK_50 (CLOCK_50), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .LEDR, .KEY, .SW); 
	 
	parameter CLOCK_PERIOD = 20;
	initial begin 
		 CLOCK_50 = 0; 
		 forever #(CLOCK_PERIOD/2) CLOCK_50 = ~CLOCK_50; 
	end 
	 
	initial begin 
		 KEY = 4'b1111;    
		 SW  = 10'b0000000000;
	 
		 @(posedge CLOCK_50); 
		 KEY[0] = 0;
		 @(posedge CLOCK_50); 
	 
		 // Release KEY[0] 
		 KEY[0] = 1; // Not pressed => reset=0 inside hazard_lights 
		 @(posedge CLOCK_50); 
	 
		 // Let calm pattern run for a few cycles 
		 repeat (4) @(posedge CLOCK_50); 
	 
		 // Switch wind to 01 => Right->Left 
		 SW[1:0] = 2'b01; 
		 repeat (6) @(posedge CLOCK_50); 
	 
		 // Switch wind to 10 => Left->Right 
		 SW[1:0] = 2'b10; 
		 repeat (6) @(posedge CLOCK_50); 
	 
		 // Press KEY[0] again (reset) in mid-cycle 
		 KEY[0] = 0; 
		 @(posedge CLOCK_50); 
		 KEY[0] = 1; 
		 @(posedge CLOCK_50); 
	 
		 // Finish after a few more cycles 
		 repeat (4) @(posedge CLOCK_50); 
		 $stop; 
	end 
  

endmodule 

 

 