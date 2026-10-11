module LS161a(
  input [3:0] D,        // Parallel Input
  input CLK,            // Clock
  input CLR_n,          // Active Low Asynchronous Reset
  input LOAD_n,         // Enable Parallel Input
  input ENP,            // Count Enable Parallel
  input ENT,            // Count Enable Trickle
  output [3:0] Q,       // Parallel Output
  output RCO            // Ripple Carry Output (Terminal Count)
);

  reg [3:0] count;

  // Asynchronous active-low clear; all other actions are synchronous
  // to the rising edge of CLK. LOAD_n has priority over counting.
  always @(posedge CLK or negedge CLR_n) begin
    if (!CLR_n)
      count <= 4'b0000;
    else if (!LOAD_n)
      count <= D;
    else if (ENP && ENT)
      count <= count + 4'b0001;
    // else hold
  end

  assign Q = count;

  // Ripple carry: high when ENT is high and count is 15 (terminal count)
  assign RCO = ENT & (count == 4'b1111);

endmodule
