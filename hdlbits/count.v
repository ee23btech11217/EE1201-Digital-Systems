module ripple (
    input clk,
    input rst,
    output Q2,
    output Q1,
    output Q0
);

    // Instantiate dflip modules
    dflip dflip_inst1 (!Q0, clk, rst, Q2);
    dflip dflip_inst2 (Q2, clk, rst, Q1);
    dflip dflip_inst3 (Q1, clk, rst, Q0);

endmodule

module dflip (
    input D,
    input clk,
    input rst,
    output reg Q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 1'b0; // Reset Q to 0 when rst is asserted
        else
            Q <= D;    // Otherwise, update Q based on D at positive edge of clk
    end

endmodule
