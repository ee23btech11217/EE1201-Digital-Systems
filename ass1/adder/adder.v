module full_adder_8bit (
  input wire [7:0] x,
  input wire [7:0] h,
  output wire [7:0] sum,
  output wire cout
);

  wire [8:0] carry;  // Carry chain
  assign carry[0] = 1'b0;  // No carry-in for the least significant bit

  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin
      full_adder_1bit fa (
        .x(x[i]),
        .h(h[i]),
        .cin(carry[i]),
        .sum(sum[i]),
        .cout(carry[i + 1])
      );
    end
  endgenerate

  assign cout = carry[8]; // Output carry

endmodule

module full_adder_1bit (
  input wire x,
  input wire h,
  input wire cin,
  output wire sum,
  output wire cout
);

  assign sum = x ^ h ^ cin; // Bitwise XOR for sum
  assign cout = (x & h) | (x & cin) | (h & cin); // Generate carry out

endmodule
