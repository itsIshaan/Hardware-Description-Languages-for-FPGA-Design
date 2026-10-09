////////////////////////////////////////////////////////////////////////////////
//               Application Assignment Problem 1 Module 3 Course 2           //
////////////////////////////////////////////////////////////////////////////////
//
// @file AAC2M3P1.v
// @brief Application Assignment 2-007 2-bit comparator
// @version: 1.0
// Target FPGA: [Intel Altera MAX10]
//
//  Functional Description:  Verilog description of a 2-bit comparator.
//             The inputs are 2-bit vectors A and B.
//             The output is a scalar Equals that is a 1 iff A and B are equal.
//
//  Hierarchy:  There is only one level in this simple design.
//
//      Copyright (c) 2019 by Tim Scherr
//
//////////////////////////////////////////////////////////////////////////////

module Comparator2(
   input [1:0] A, B,
   output reg Equals
);

// Combinational logic: re-evaluate whenever A or B changes
always @(A or B)
begin
   if (A == B)
      Equals = 1'b1;
   else
      Equals = 1'b0;
end

endmodule // Comparator2