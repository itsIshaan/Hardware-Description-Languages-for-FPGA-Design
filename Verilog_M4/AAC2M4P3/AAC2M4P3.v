module FSM(
  input In1,
  input RST,
  input CLK, 
  output reg Out1
);

  // State encoding
  localparam [1:0] A = 2'b00,
                   B = 2'b01,
                   C = 2'b10;

  reg [1:0] state, next_state;

  // State register with active-low synchronous reset
  always @(posedge CLK) begin
    if (!RST)
      state <= A;
    else
      state <= next_state;
  end

  // Next-state logic
  always @(*) begin
    case (state)
      A: next_state = In1 ? B : A;
      B: next_state = In1 ? B : C;
      C: next_state = In1 ? A : C;
      default: next_state = A;
    endcase
  end

  // Moore output logic: Out1 = 1 only in state C
  always @(*) begin
    case (state)
      C:       Out1 = 1'b1;
      default: Out1 = 1'b0;
    endcase
  end

endmodule
