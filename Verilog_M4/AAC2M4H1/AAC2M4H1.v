module ALU ( 
  input [2:0] Op_code,
  input [31:0] A, B,
  output reg [31:0] Y
);

  always @(*) begin
    case (Op_code)
      3'b000:  Y = A;          // Pass A
      3'b001:  Y = A + B;      // Add
      3'b010:  Y = A - B;      // Subtract
      3'b011:  Y = A & B;      // AND
      3'b100:  Y = A | B;      // OR
      3'b101:  Y = A + 32'd1;  // Increment A
      3'b110:  Y = A - 32'd1;  // Decrement A
      3'b111:  Y = B;          // Pass B
      default: Y = 32'd0;
    endcase
  end

endmodule
