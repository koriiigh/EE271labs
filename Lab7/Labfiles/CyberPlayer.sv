module CyberPlayer(outC, clk, reset, SW);
	input logic [8:0] SW;
	output logic outC;
	input logic clk, reset;
	logic [9:0] lfsrout;
	logic [9:0] CyberSW ;
	assign CyberSW = {1'b0, SW};
	
	
	LFSR lfsr1(.Q(lfsrout), .clk, .reset);
	comparator cyb(.out(outC), .A(CyberSW), .B(lfsrout));
	
	
	
	
	
endmodule

module CyberPlayer_testbench();
	 logic CLOCK_50;
    logic reset;
    logic [8:0] SW;
    logic outC;
	 
	 CyberPlayer dut(.outC, .clk(CLOCK_50), .reset, .SW);
	 
	 parameter CLOCK_PERIOD = 20;
	initial begin 
		 CLOCK_50 = 0; 
		 forever #(CLOCK_PERIOD/2) CLOCK_50 = ~CLOCK_50; 
	end
	
	initial begin
        
        @(posedge CLOCK_50);
        reset = 1;
        SW = 9'd0;
 
        repeat(4) @(posedge CLOCK_50);
        reset = 0;
        @(posedge CLOCK_50);
		  SW = 9'd32;repeat(100) @(posedge CLOCK_50);
        SW = 9'd65;repeat(100) @(posedge CLOCK_50);
		  SW = 9'd70;repeat(100) @(posedge CLOCK_50);
		  SW = 9'd75;repeat(100) @(posedge CLOCK_50);
    
        reset = 1;
        @(posedge CLOCK_50);
        reset = 0;
        repeat(4) @(posedge CLOCK_50);
        
        $stop;
    end
endmodule
	
	