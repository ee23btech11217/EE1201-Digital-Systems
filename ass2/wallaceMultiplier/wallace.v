module wallace(input [3:0] x, input [3:0] y, output [7:0] result);

    wire sum11, sum12, sum13, sum14, sum15, sum22, sum23, sum24, sum25, sum26, sum32, sum33, sum34, sum35, sum36, sum37;
    wire carry11, carry12, carry13, carry14, carry15, carry22, carry23, carry24, carry25, carry26, carry32, carry33, carry34, carry35, carry36, carry37;
    wire [6:0] prod0, prod1, prod2, prod3;

    assign  prod3 = x & {4{y[3]}};
    assign  prod2 = x & {4{y[2]}};
    assign  prod1 = x & {4{y[1]}};
    assign  prod0 = x & {4{y[0]}};
    assign result[0] = prod0[0];
    assign result[1] = sum11;
    assign result[2] = sum22;
    assign result[3] = sum32;
    assign result[4] = sum34;
    assign result[5] = sum35;
    assign result[6] = sum36;
    assign result[7] = sum37;

    FA ha11 (prod0[1], prod1[0], 1'b0 ,  sum11, carry11);
    FA fa12 (prod0[2], prod1[1], prod2[0], sum12, carry12);
    FA fa13 (prod0[3], prod1[2], prod2[1], sum13, carry13);
    FA fa14 (prod1[3], prod2[2], prod3[1], sum14, carry14);
    HA ha15 (prod2[3], prod3[2], sum15, carry15);
    FA ha22 (1'b0, carry11, sum12, sum22, carry22);
    FA fa23 (prod3[0], carry12, sum13, sum23, carry23);
    FA fa24 (carry13, carry32, sum14, sum24, carry24);
    FA fa25 (carry14, carry24, sum15, sum25, carry25);
    FA fa26 (carry15, carry25, prod3[3], sum26, carry26);
    HA ha32(carry22, sum23, sum32, carry32);
    HA ha34(carry23, sum24, sum34, carry34);
    HA ha35(carry34, sum25, sum35, carry35);
    HA ha36(carry35, sum26, sum36, carry36);
    HA ha37(carry36, carry26, sum37, carry37);
endmodule

module HA(input x,  input y,  output sum,  output carry);
    assign sum = x ^ y;
    assign carry = x & y;
endmodule

module FA(input x,  input y,  input cin,  output sum,  output carry);
    assign sum = x ^ y ^ cin;
    assign carry = (x & y) | (x & cin) | (y & cin);
endmodule
