module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, KEY, SW); 
	input logic CLOCK_50;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	logic holdmid;

	//logic [31:0] div_clk; 
 

	logic reset; 
	assign reset = SW[9];
	logic key0,key3;
	logic cyberin;
	
 
	//parameter whichClock = 15;
 
//clock_divider cdiv ( .clock(CLOCK_50),
//							.reset(reset),
//							.divided_clocks(div_clk) 
//); 
 

	logic clkSelect;
	assign clkSelect = CLOCK_50; 
	
	
	User_Input input0(.out(key0), .clk(clkSelect), .reset, .button(~KEY[0]));
	User_Input input3(.out(key3), .clk(clkSelect), .reset, .button(cyberin));
	
	normalLight light1(.clk(clkSelect), .reset, .L(key3), .R(key0), .NL(LEDR[2]), .NR(1'b0), .Midreset(holdmid), .lightOn(LEDR[1]));
	normalLight light2(.clk(clkSelect), .reset, .L(key3), .R(key0), .NL(LEDR[3]), .NR(LEDR[1]), .Midreset(holdmid), .lightOn(LEDR[2]));
	normalLight light3(.clk(clkSelect), .reset, .L(key3), .R(key0), .NL(LEDR[4]), .NR(LEDR[2]), .Midreset(holdmid), .lightOn(LEDR[3]));
	normalLight light4(.clk(clkSelect), .reset, .L(key3), .R(key0), .NL(LEDR[5]), .NR(LEDR[3]), .Midreset(holdmid), .lightOn(LEDR[4]));
	
	centerLight light5(.clk(clkSelect), .reset, .L(key3), .R(key0), .NL(LEDR[6]), .NR(LEDR[4]), .Midreset(holdmid), .lightOn(LEDR[5]));
	
	normalLight light6(.clk(clkSelect), .reset, .L(key3), .R(key0), .NL(LEDR[7]), .NR(LEDR[5]), .Midreset(holdmid), .lightOn(LEDR[6]));
	normalLight light7(.clk(clkSelect), .reset, .L(key3), .R(key0), .NL(LEDR[8]), .NR(LEDR[6]), .Midreset(holdmid), .lightOn(LEDR[7]));
	normalLight light8(.clk(clkSelect), .reset, .L(key3), .R(key0), .NL(LEDR[9]), .NR(LEDR[7]), .Midreset(holdmid), .lightOn(LEDR[8]));
	normalLight light9(.clk(clkSelect), .reset, .L(key3), .R(key0), .NL(1'b0), .NR(LEDR[8]), .Midreset(holdmid), .lightOn(LEDR[9]));
	
	
	CyberPlayer cy(.outC(cyberin), .clk(clkSelect), .reset, .SW(SW[8:0]));
	

	
	victory WinnerWinnerChickenDinner(.Midreset(holdmid),.Rwinner(HEX0),.Lwinner(HEX5), .clk(clkSelect) , .reset , .LEDR9(LEDR[9]), .LEDR1(LEDR[1]), .L(key3), .R(key0));

		

	
	
 

	 


	assign HEX1 = 7'b111_1111; 
	assign HEX2 = 7'b111_1111; 
	assign HEX3 = 7'b111_1111; 
	assign HEX4 = 7'b111_1111; 

  

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
        
        SW = {1'b1, 9'd65};
		  KEY[0] = 0; @(posedge CLOCK_50);
        repeat(10) @(posedge CLOCK_50);
        

        SW = {1'b0, 9'd65}; repeat(4)@(posedge CLOCK_50);
		  SW = {1'b0, 9'b000100000}; repeat(200)@(posedge CLOCK_50);
		  SW = {1'b0, 9'd65}; repeat(200)@(posedge CLOCK_50);
		  SW = {1'b0, 9'd70}; repeat(200)@(posedge CLOCK_50);
		  SW = {1'b0, 9'd75}; repeat(200)@(posedge CLOCK_50);
//		  SW = {1'b0, 9'b000010000}; repeat(50)@(posedge CLOCK_50);
//		  SW = {1'b0, 9'b000011111}; repeat(50)@(posedge CLOCK_50);
//		  SW = {1'b0, 9'b000111111}; repeat(50)@(posedge CLOCK_50);

//        KEY[0] = 0; @(posedge CLOCK_50);
//        KEY[0] = 1; @(posedge CLOCK_50);
//		  KEY[0] = 0; @(posedge CLOCK_50);
//        repeat(4) @(posedge CLOCK_50);
//
//        SW = {1'b0, 9'b010101010};
//        @(posedge CLOCK_50);
//        KEY[0] = 0; @(posedge CLOCK_50);
//        KEY[0] = 1; @(posedge CLOCK_50);
//		  KEY[0] = 0; @(posedge CLOCK_50);
//        repeat(4) @(posedge CLOCK_50);
//		  SW[9] = 1'b1; repeat(4) @(posedge CLOCK_50);
//		  SW[9] = 1'b0; repeat(4) @(posedge CLOCK_50);
//
//        SW = {1'b0, 9'b111111111};  repeat(4)@(posedge CLOCK_50);
//        KEY[0] = 0; @(posedge CLOCK_50);
//        KEY[0] = 1; @(posedge CLOCK_50);
//        repeat(4) @(posedge CLOCK_50);
//
//        SW = {1'b0, 9'b100101100};
//        @(posedge CLOCK_50);
//        KEY[0] = 0; @(posedge CLOCK_50);
//        KEY[0] = 1; @(posedge CLOCK_50);
//        repeat(4) @(posedge CLOCK_50);
        
        $stop;
    end
	endmodule  

 

 