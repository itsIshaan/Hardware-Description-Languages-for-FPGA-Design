module FIFO8x9(
  input clk, rst,
  input RdPtrClr, WrPtrClr,
  input RdInc, WrInc,
  input [8:0] DataIn,
  output reg [8:0] DataOut,
  input rden, wren
	);
//signal declarations

	reg [8:0] fifo_array[7:0];
	reg [7:0] wrptr, rdptr;
	wire [7:0] wr_cnt, rd_cnt;

	// Pointer values (only the low 3 bits address the 8 registers)
	assign wr_cnt = wrptr;
	assign rd_cnt = rdptr;

	// Write pointer: cleared by rst or WrPtrClr, incremented by WrInc
	always @(posedge clk) begin
		if (rst || WrPtrClr)
			wrptr <= 8'd0;
		else if (WrInc)
			wrptr <= wrptr + 8'd1;
	end

	// Read pointer: cleared by rst or RdPtrClr, incremented by RdInc
	always @(posedge clk) begin
		if (rst || RdPtrClr)
			rdptr <= 8'd0;
		else if (RdInc)
			rdptr <= rdptr + 8'd1;
	end

	// Write to the register selected by the write pointer
	always @(posedge clk) begin
		if (wren)
			fifo_array[wr_cnt[2:0]] <= DataIn;
	end

	// Read: output enabled when rden is asserted, otherwise high impedance
	always @(posedge clk) begin
		if (rden)
			DataOut <= fifo_array[rd_cnt[2:0]];
		else
			DataOut <= 9'bzzzzzzzzz;
	end

endmodule
