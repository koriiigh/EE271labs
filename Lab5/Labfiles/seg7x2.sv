module seg7x2(SW,HEX0,HEX1);
	input logic [9:0] SW;
	output logic [6:0] HEX0, HEX1;
	

	logic [3:0] down;
	assign down = SW[3:0];
	logic [3:0] up;
	assign up = SW[7:4];
	
	seg7 lower(.bcd(down), .pattern(HEX0));
	seg7 upper(.bcd(up), .pattern(HEX1));
	
endmodule
module seg7x2_testbench();
	logic [9:0] SW;
	logic [6:0] HEX0,HEX1;
	seg7x2 dut(SW, HEX0, HEX1);
	integer i;
	initial begin
	for(i = 0; i <10; i++) begin
		SW[7:4] = i;
		SW[3:0] = i;
		#10;
	end
	end
endmodule