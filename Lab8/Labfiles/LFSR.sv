module LFSR (Q, clk, reset);
	output logic [15:0] Q;
	input logic clk, reset;
	logic xnorQ;
	
	assign xnorQ = ~(Q[0] ^ Q[1] ^ Q[3] ^ Q[12]);
	
	always_ff @(posedge clk) begin
		if (reset)
			Q<= 16'b0000000000000000;
		else
			Q <= {xnorQ, Q[15:1]};
	end
endmodule


module LFSR_testbench();
	logic [9:0] Q;
	logic CLOCK_50, reset;
	
	LFSR dut(.Q, .clk(CLOCK_50), .reset);
	
	parameter CLOCK_PERIOD = 20;
	initial begin 
		 CLOCK_50 = 0; 
		 forever #(CLOCK_PERIOD/2) CLOCK_50 = ~CLOCK_50; 
	end
	
	initial begin
		reset<= 1; repeat(10)@(posedge CLOCK_50);
		reset<= 0; repeat(100)@(posedge CLOCK_50);
		$stop;
		
		
	end
endmodule
