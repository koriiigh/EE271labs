module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, KEY, SW); 
	input logic CLOCK_50;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	logic [31:0] div_clk; 
 

	logic reset; 
	assign reset = SW[9];
	logic key0,key3;
 
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
	
	User_Input input0(.out(key0), .clk(CLOCK_50), .reset, .button(~KEY[0]));
	User_Input input3(.out(key3), .clk(CLOCK_50), .reset, .button(~KEY[3]));
	
	normalLight light1(.clk(CLOCK_50), .reset, .L(key3), .R(key0), .NL(LEDR[2]), .NR(1'b0), .lightOn(LEDR[1]));
	normalLight light2(.clk(CLOCK_50), .reset, .L(key3), .R(key0), .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]));
	normalLight light3(.clk(CLOCK_50), .reset, .L(key3), .R(key0), .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]));
	normalLight light4(.clk(CLOCK_50), .reset, .L(key3), .R(key0), .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]));
	
	centerLight light5(.clk(CLOCK_50), .reset, .L(key3), .R(key0), .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5]));
	
	normalLight light6(.clk(CLOCK_50), .reset, .L(key3), .R(key0), .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]));
	normalLight light7(.clk(CLOCK_50), .reset, .L(key3), .R(key0), .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]));
	normalLight light8(.clk(CLOCK_50), .reset, .L(key3), .R(key0), .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]));
	normalLight light9(.clk(CLOCK_50), .reset, .L(key3), .R(key0), .NL(1'b0), .NR(LEDR[8]), .lightOn(LEDR[9]));
	
	victory WinnerWinnerChickenDinner(.winner(HEX0), .clk(CLOCK_50) , .reset , .LEDR9(LEDR[9]), .LEDR1(LEDR[1]), .L(key3), .R(key0));

		

	
	
 

	 


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
		@(posedge CLOCK_50); 

	SW[9] <= 1; repeat(4)@(posedge CLOCK_50);  
	SW[9] <= 0; @(posedge CLOCK_50);
	 
	KEY[0] <= 0; @(posedge CLOCK_50); 
	KEY[0] <= 1; @(posedge CLOCK_50); 
	KEY[0] <= 0; @(posedge CLOCK_50); 
	KEY[0] <= 1; @(posedge CLOCK_50);
	KEY[0] <= 0; @(posedge CLOCK_50); 
	 

	KEY[3] <= 0; @(posedge CLOCK_50); 
	KEY[3] <= 1; @(posedge CLOCK_50); 
	KEY[3] <= 0; @(posedge CLOCK_50); 
	KEY[3] <= 1; @(posedge CLOCK_50);
	KEY[3] <= 0; @(posedge CLOCK_50); 
	 
	KEY[0] <= 1; @(posedge CLOCK_50); 
	KEY[0] <= 0; @(posedge CLOCK_50); 
	 
	KEY[0] <= 1; @(posedge CLOCK_50); 
	KEY[0] <= 0; @(posedge CLOCK_50); 
	KEY[0] <= 1; @(posedge CLOCK_50); 
	KEY[0] <= 0; @(posedge CLOCK_50);
	KEY[0] <= 1; @(posedge CLOCK_50); 
	KEY[0] <= 0; @(posedge CLOCK_50); 
	KEY[0] <= 1; @(posedge CLOCK_50); 
	KEY[0] <= 0; @(posedge CLOCK_50); 
	repeat (4) @(posedge CLOCK_50); 
	SW[9] <= 1; repeat(4)@(posedge CLOCK_50);
	SW[9] <= 0; @(posedge CLOCK_50);
	KEY[3] <= 0; @(posedge CLOCK_50); 
	KEY[3] <= 1; @(posedge CLOCK_50); 
	KEY[3] <= 0; @(posedge CLOCK_50); 
	KEY[3] <= 1; @(posedge CLOCK_50);
	KEY[3] <= 0; @(posedge CLOCK_50); 
	 

	KEY[0] <= 0; @(posedge CLOCK_50); 
	KEY[0] <= 1; @(posedge CLOCK_50); 
	KEY[0] <= 0; @(posedge CLOCK_50); 
	KEY[0] <= 1; @(posedge CLOCK_50);
	KEY[0] <= 0; @(posedge CLOCK_50); 
	 
	KEY[3] <= 1; @(posedge CLOCK_50); 
	KEY[3] <= 0; @(posedge CLOCK_50); 
	 
	KEY[3] <= 1; @(posedge CLOCK_50); 
	KEY[3] <= 0; @(posedge CLOCK_50); 
	KEY[3] <= 1; @(posedge CLOCK_50); 
	KEY[3] <= 0; @(posedge CLOCK_50);
	KEY[3] <= 1; @(posedge CLOCK_50); 
	KEY[3] <= 0; @(posedge CLOCK_50); 
	KEY[3] <= 1; @(posedge CLOCK_50); 
	KEY[3] <= 0; @(posedge CLOCK_50); 
	repeat (4) @(posedge CLOCK_50);
	SW[9] <= 1; repeat(4)@(posedge CLOCK_50);
	SW[9] <= 0; @(posedge CLOCK_50);
	KEY[3] <= 1; KEY[0] <= 1; @(posedge CLOCK_50);
	KEY[3] <= 0; KEY[0] <= 0; repeat(4)@(posedge CLOCK_50); 
	
	 
	@(posedge CLOCK_50); 
	$stop; 
	  

	end 
	endmodule  

 

 