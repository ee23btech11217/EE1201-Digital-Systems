module FA(input cin, input clk, input a, input b, output sum, output cout);
    
    wire axorb;
    wire cinandaxorb;
    wire aandb;
    cswap swap1(.clk(clk), .Cin(a), .I1(b), .I2(!b), .Cout(), .O1(axorb), .O2());
    cswap swap2(.clk(clk), .Cin(axorb), .I1(cin), .I2(!cin), .Cout(), .O1(sum), .O2());
    cswap swap3(.clk(clk), .Cin(cin), .I1(1'b0), .I2(axorb), .Cout(), .O1(cinandaxorb), .O2());
    cswap swap4(.clk(clk), .Cin(a), .I1(1'b0), .I2(b), .Cout(), .O1(aandb), .O2());
    cswap swap5(.clk(clk), .Cin(aandb), .I1(1'b1), .I2(cinandaxorb), .Cout(), .O1(), .O2(cout));
endmodule

module cswap(
    input clk,
    input Cin,
    input I1,
    input I2,
    output reg Cout,
    output reg O1,
    output reg O2
);

always @ (*) begin
    O1 <= (!Cin & I1) | (Cin & I2);
    O2 <= (Cin & I1) | (!Cin & I2);
    Cout <= Cin; 
end

endmodule
