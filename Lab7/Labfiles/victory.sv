module victory (Midreset, Rwinner, Lwinner, clk ,reset ,LEDR9, LEDR1, L, R);
	input logic L,R, LEDR9, LEDR1;
	input logic clk,reset;
	output logic [6:0] Rwinner, Lwinner;
	logic [2:0]Rwin ;
	logic [2:0]Lwin ;
	output logic Midreset;
	enum{off, PL, PR} ps,ns;
	
	always_comb begin
		case(ps)
			off: begin
				if (LEDR9 & L & ~R)
				ns = PL;
				
				else if (LEDR1 & ~L & R)
					ns = PR;
				else
					ns = off;
				end
				default: ns = ps;
			
		endcase
	end

		seg7 winR(.bcd(Rwin), .pattern(Rwinner));
		seg7 winL(.bcd(Lwin), .pattern(Lwinner));
				
		
		always_ff @(posedge clk) begin 

		if(ps == off && ns == PR) begin 
			Rwin <= Rwin + 1'b1; 
		end 
			else if(ps == off && ns == PL) begin 
			Lwin <= Lwin + 1'b1; 
		end 
		else begin 
			Rwin <= Rwin; 
			Lwin <= Lwin; 
		end 
		if(reset) begin 
			Lwin <= 3'b000; 
			Rwin <= 3'b000; 
			ps <= off; 
			Midreset <= 0; 
		end 

		else if(Midreset) begin 
			ps <= off; 
			Midreset <= 0; 
		end 

		else 

			ps <= ns; 
		if(ps == PR | ps == PL) 
			Midreset <= 1; 
		else 
			Midreset <= 0; 

	end 
endmodule


module victory_testbench();
  // Declare testbench signals
  logic CLOCK_50;
  logic reset;
  logic LEDR9, LEDR1;
  logic L, R;
  logic [6:0] Rwinner, Lwinner;
  logic Midreset;
  
  victory dut(.Midreset, .Rwinner, .Lwinner, .clk(CLOCK_50) ,.reset ,.LEDR9, .LEDR1, .L, .R);
  parameter CLOCK_PERIOD = 20;
	initial begin 
		 CLOCK_50 = 0; 
		 forever #(CLOCK_PERIOD/2) CLOCK_50 = ~CLOCK_50; 
	end
	
	
	
  initial begin
    
    @(posedge CLOCK_50);
    reset = 1; 
    LEDR9 = 0; LEDR1 = 0; L = 0; R = 0;
    repeat(4) @(posedge CLOCK_50);
    reset = 0;
    @(posedge CLOCK_50);
    LEDR9 = 0; LEDR1 = 0; L = 0; R = 0;
    repeat(4) @(posedge CLOCK_50);

    LEDR9 = 1; L = 1; R = 0; LEDR1 = 0;
    @(posedge CLOCK_50);

    LEDR9 = 0; L = 0;
    repeat(4) @(posedge CLOCK_50);
    LEDR1 = 1; R = 1; L = 0; LEDR9 = 0;
    @(posedge CLOCK_50);
    LEDR1 = 0; R = 0;
    repeat(4) @(posedge CLOCK_50);
    LEDR9 = 1; LEDR1 = 1; L = 1; R = 1;
    @(posedge CLOCK_50);
    LEDR9 = 0; LEDR1 = 0; L = 0; R = 0;
    repeat(4) @(posedge CLOCK_50);
    
    LEDR9 = 1; L = 1; R = 0; LEDR1 = 0; 
    @(posedge CLOCK_50);
    LEDR9 = 0; L = 0;
    repeat(4) @(posedge CLOCK_50);
    LEDR9 = 1; L = 1; R = 0; LEDR1 = 0; 
    repeat(15) @(posedge CLOCK_50);
    LEDR9 = 0; L = 0;
    repeat(4) @(posedge CLOCK_50);

    LEDR1 = 1; R = 1; L = 0; LEDR9 = 0; 
    @(posedge CLOCK_50);
    LEDR1 = 0; R = 0;
    repeat(4) @(posedge CLOCK_50);
    LEDR1 = 1; R = 1; L = 0; LEDR9 = 0; 
    @(posedge CLOCK_50);
    LEDR1 = 0; R = 0;
    repeat(4) @(posedge CLOCK_50);
    
    reset = 1;
    repeat(4) @(posedge CLOCK_50);
    reset = 0;
    repeat(4) @(posedge CLOCK_50);
    
    $stop;
  end
endmodule

	
	
	