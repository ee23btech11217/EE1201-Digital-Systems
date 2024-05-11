module submodule(input x0, input x1, input L, input clk, output reg Q);
    always @(posedge clk) begin
        if(L == 0)
            Q = x0;
        else
            Q = x1;
    end
endmodule

module top_module(input r0, input r1, input r2, input L, input clk, output reg Q0, output reg Q1, output reg Q2);

    submodule submodule0 (.x0(Q2_wire), .x1(r0), .L(L), .clk(clk), .Q(Q0));
    submodule submodule1 (.x0(Q0), .x1(r1), .L(L), .clk(clk), .Q(Q1));
    submodule submodule2 (.x0(Q1 ^ Q2_wire), .x1(r2), .L(L), .clk(clk), .Q(Q2));
endmodule
