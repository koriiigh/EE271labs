module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, KEY, SW, GPIO_1); 
	input logic CLOCK_50;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	output logic [35:0] GPIO_1;


    logic reset;
    assign reset = SW[9];

    assign HEX1 = 7'b111_1111;
    assign HEX2 = 7'b111_1111;
    assign HEX3 = 7'b111_1111;
    assign HEX4 = 7'b111_1111;
    assign HEX5 = 7'b111_1111;


    logic [31:0] div_clocks;
    logic system_clk;

    clock_divider cdiv(
        .clock         (CLOCK_50),
        .divided_clocks(div_clocks)
    );

    assign system_clk = div_clocks[13];
	 logic [1:0] difficulty;
    assign difficulty = SW[1:0];
	 
	 
	 
	 
	 logic upPulse, downPulse, leftPulse, rightPulse;

    User_Input up_in (.clk(system_clk), .reset(reset), .button(~KEY[1]), .out(upPulse));
    User_Input down_in (.clk(system_clk), .reset(reset), .button(~KEY[2]), .out(downPulse));
    User_Input left_in (.clk(system_clk), .reset(reset), .button(~KEY[0]), .out(leftPulse));
    User_Input right_in (.clk(system_clk), .reset(reset), .button(~KEY[3]), .out(rightPulse));


    logic [15:0][15:0] RedPixels, GrnPixels;

    FroggerGame game_inst (
        .clk         (system_clk),
        .reset       (reset),
        .moveUp      (upPulse),
        .moveDown    (downPulse),
        .moveLeft    (leftPulse),
        .moveRight   (rightPulse),
		  .difficulty  (difficulty),
        .RedPixels   (RedPixels),
        .GrnPixels   (GrnPixels),
        .HEX0        (HEX0)
    );



	 LEDDriver #(.FREQDIV(0)) driver_inst (
        .CLK         (system_clk),
        .RST         (reset),
        .EnableCount (1'b1),
        .RedPixels   (RedPixels),
        .GrnPixels   (GrnPixels),
        .GPIO_1      (GPIO_1)
    );

endmodule




module DE1_SoC_testbench(); 
	logic CLOCK_50; 
	logic [3:0] KEY; 
	logic [9:0] SW; 
	logic [9:0] LEDR; 
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [35:0] GPIO_1;

	DE1_SoC dut ( 
		 .CLOCK_50 (CLOCK_50), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .LEDR, .KEY, .SW, .GPIO_1); 
	 
	parameter CLOCK_PERIOD = 20;
	initial begin 
		 CLOCK_50 = 0; 
		 forever #(CLOCK_PERIOD/2) CLOCK_50 = ~CLOCK_50; 
	end 
	 
	  initial begin
        SW[9] = 1; @(posedge CLOCK_50);
        repeat(10) @(posedge CLOCK_50);
		  SW[9] = 0; @(posedge CLOCK_50);
        repeat(10) @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 1; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 1; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 1; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 1; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 1;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 1;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 1;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 1;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 1; KEY[3] = 0;
		  @(posedge CLOCK_50);
		  KEY[0] = 0; KEY[1] = 0; KEY[2] = 0; KEY[3] = 0;
		  repeat(10)@(posedge CLOCK_50);
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  SW[9] = 0; @(posedge CLOCK_50);
        repeat(10) @(posedge CLOCK_50);
        
		  

		$stop;
    end
endmodule















