module CarController(clk, reset, difficulty, lane1, lane2, lane3, lane4, lane5, lane6, lane7, lane10, lane11, lane12, lane13, lane14, lane15);
	input  logic clk;
	input  logic reset;
	input  logic [1:0]  difficulty;
	output logic [15:0] lane1, lane2, lane3, lane4, lane5;
	output logic [15:0] lane6, lane7, lane10, lane11, lane12;
	output logic [15:0] lane13, lane14, lane15;

    logic [15:0] lane1_reg,  lane2_reg,  lane3_reg,  lane4_reg;
    logic [15:0] lane5_reg,  lane6_reg,  lane7_reg;
    logic [15:0] lane10_reg, lane11_reg, lane12_reg, lane13_reg, lane14_reg, lane15_reg;
	 
	 
	 logic [15:0] slowCount;
    logic [15:0] SHIFT_INTERVAL;
	 
	 always_comb begin
         case (difficulty)
            2'b00: SHIFT_INTERVAL = 16'd1000;  
            2'b01: SHIFT_INTERVAL = 16'd500;   
            2'b10: SHIFT_INTERVAL = 16'd200;   
            2'b11: SHIFT_INTERVAL = 16'd100;
        endcase
    end


    always_ff @(posedge clk) begin
        if (reset) begin

            lane1_reg  <= 16'b0000_0000_0000_1000;
            lane2_reg  <= 16'b0000_0000_1000_0000;
            lane3_reg  <= 16'b1000_0000_0000_0000;
            lane4_reg  <= 16'b0000_0000_0000_0000;

            lane5_reg  <= 16'b0000_1000_0000_0000;
            lane6_reg  <= 16'b0001_0000_0001_0001;
            lane7_reg  <= 16'b1000_0000_0000_0001;

            lane10_reg <= 16'b0000_0000_0000_0000;
            lane11_reg <= 16'b0000_0000_0000_0001;
            lane12_reg <= 16'b1000_0000_0000_0001;
            lane13_reg <= 16'b1000_0000_0000_0001;
            lane14_reg <= 16'b1000_0000_0000_0001;
				slowCount <= 16'd0;

        end
        else begin
		  
				slowCount <= slowCount + 1'b1;
				if (slowCount >= SHIFT_INTERVAL) begin
					slowCount <= 16'd0;

						lane1_reg  <= {lane1_reg [14:0],  lane1_reg [15]};
						lane2_reg  <= {lane2_reg [14:0],  lane2_reg [15]};
						lane3_reg  <= {lane3_reg [14:0],  lane3_reg [15]};
						lane4_reg  <= {lane4_reg [14:0],  lane4_reg [15]};

						lane5_reg  <= {lane5_reg [14:0],  lane5_reg [15]};
						lane6_reg  <= {lane6_reg [14:0],  lane6_reg [15]};
						lane7_reg  <= {lane7_reg [14:0],  lane7_reg [15]};

						lane10_reg <= {lane10_reg[14:0], lane10_reg[15]};
						lane11_reg <= {lane11_reg[14:0], lane11_reg[15]};
						lane12_reg <= {lane12_reg[14:0], lane12_reg[15]};
						lane13_reg <= {lane13_reg[14:0], lane13_reg[15]};
						lane14_reg <= {lane14_reg[14:0], lane14_reg[15]};
						lane15_reg <= {lane15_reg[14:0], lane15_reg[15]};
				end

        end
    end


    assign lane1  = lane1_reg;
    assign lane2  = lane2_reg;
    assign lane3  = lane3_reg;
    assign lane4  = lane4_reg;
    assign lane5  = lane5_reg;
    assign lane6  = lane6_reg;
    assign lane7  = lane7_reg;
    assign lane10 = lane10_reg;
    assign lane11 = lane11_reg;
    assign lane12 = lane12_reg;
    assign lane13 = lane13_reg;
    assign lane14 = lane14_reg;


endmodule


