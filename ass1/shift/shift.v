module dflip(
    input din,
    input clk,
    input res,
    output reg dout
);

always @(res == 1) begin
    dout <=0;
end

always @(negedge clk) begin
    dout = din;
end

endmodule

module shiftreg (
  input din,
  input clk,
  input res,
  output [3:0] dout
);
  genvar i;
  
  generate
    dflip fa (
        .din(din),
        .clk(clk),
        .res(res),
        .dout(dout[0])
      );
    for (i = 1; i < 3; i = i + 1) begin
      dflip fa (
        .din(dout[i]),
        .clk(clk),
        .res(res),
        .dout(dout[i + 1])
      );
    end
  endgenerate

endmodule
