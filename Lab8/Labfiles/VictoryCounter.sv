module VictoryCounter(clk, reset, frogAtBottom, Midreset, scoreSeg);

	input  logic clk;
	input  logic reset;
	input  logic frogAtBottom;
	output logic Midreset;
	output logic [6:0] scoreSeg;
   enum { ST_OFF, ST_WIN } ps, ns;

    logic [3:0] score;

    seg7 winR(.bcd(score), .pattern(scoreSeg));

    always_comb begin
        ns = ps;

        case (ps)
            ST_OFF: begin
                if (frogAtBottom)
                    ns = ST_WIN;
            end

            ST_WIN: begin
                ns = ST_OFF;
            end
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            ps <= ST_OFF;
            score <= 3'd0;
            Midreset <= 1'b0;
        end
        else if (Midreset) begin
            ps <= ST_OFF;
            Midreset <= 1'b0;
				score <= score;
        end
        else begin
            ps <= ns;
        end

        if (ps == ST_OFF && ns == ST_WIN) begin
            score <= score + 1;
        end

        if (ps == ST_WIN)
            Midreset <= 1'b1;
        else
            Midreset <= 1'b0;
    end

endmodule


module VictoryCounter_testbench();
  logic CLOCK_50;
  logic reset;
  logic frogAtBottom;
  logic [6:0] scoreSeg;
  logic Midreset;
   
  VictoryCounter dut(.clk(CLOCK_50), .reset, .frogAtBottom, .Midreset, .scoreSeg);
  parameter CLOCK_PERIOD = 20;
	initial begin 
		 CLOCK_50 = 0; 
		 forever #(CLOCK_PERIOD/2) CLOCK_50 = ~CLOCK_50; 
	end
	
	
	
  initial begin
    
    @(posedge CLOCK_50);
    reset = 1; 
    repeat(4) @(posedge CLOCK_50);
    reset = 0;
    repeat(4) @(posedge CLOCK_50);
    frogAtBottom = 0;
    repeat(7) @(posedge CLOCK_50);

    frogAtBottom = 1;
    @(posedge CLOCK_50);

    frogAtBottom = 0;
    repeat(4) @(posedge CLOCK_50);
    
    reset = 1;
    repeat(4) @(posedge CLOCK_50);
    reset = 0;
    repeat(4) @(posedge CLOCK_50);
    
    $stop;
  end
endmodule
