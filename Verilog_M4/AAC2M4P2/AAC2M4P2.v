module RAM128x32
#(
  parameter Data_width = 32,  // Number of bits in each word
            Addr_width = 7    // Number of address bits
)
(
  input  wire                   clk,
  input  wire                   we,
  input  wire [Addr_width-1:0]  address,
  input  wire [Data_width-1:0]  d,
  output wire [Data_width-1:0]  q
);

  reg [Data_width-1:0] memory [0:(1 << Addr_width)-1];

  // Writes occur on the rising clock edge when write enable is asserted.
  always @(posedge clk) begin
    if (we)
      memory[address] <= d;
  end

  // Combinational read: q reflects the word at the current address.
  assign q = memory[address];

endmodule