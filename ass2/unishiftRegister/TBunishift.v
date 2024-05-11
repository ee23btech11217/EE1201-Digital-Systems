`timescale 1ns / 1ps

module universal_shift_reg_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Signals
  reg clk;
  reg rst_n;
  reg [8:0] select;
  reg [15:0] p_din;
  reg s_left_din;
  reg s_right_din;
  wire [15:0] p_dout;
  wire s_left_dout;
  wire s_right_dout;

  // Instantiate the universal_shift_reg module
  universalShift uut (
    .clk(clk),
    .rst_n(rst_n),
    .select(select),
    .p_din(p_din),
    .s_left_din(s_left_din),
    .s_right_din(s_right_din),
    .p_dout(p_dout),
    .s_left_dout(s_left_dout),
    .s_right_dout(s_right_dout)
  );

  // Clock generation
  always #((CLK_PERIOD / 2)) clk <= ~clk;

  // Test stimulus
  initial begin
    $dumpfile("unishift.vcd");
    $dumpvars(0, universal_shift_reg_tb);
    
    // Initialize inputs
    clk = 0;
    rst_n = 1;
    select = 9'b100000000;
    p_din = 0;
    s_left_din = 0;
    s_right_din = 0;

    #11
    rst_n = 0;
    #19
    select = 9'b000000001; // SISO left shift
    s_right_din = 1;
    #160
    s_right_din = 0;
    #200

    select = 9'b000000010; // SISO right shift
    s_left_din = 0;
    #160
    s_left_din = 1;
    #200

    select = 9'b000000100; // SIPO left shift
    s_right_din = 1;
    #160
    s_right_din = 0;
    #200

    select = 9'b000001000; // SIPO right shift
    s_left_din = 0;
    #160
    s_left_din = 1;
    #200

    select = 9'b000010000; // PIPO left shift
    p_din = 16'b1010101010101010;
    #200

    select = 9'b000100000; // PIPO right shift
    p_din = 16'b1110111010101010;
    #200

    select = 9'b001000000; // PISO left shift
    p_din = 16'b1110110010101110;
    #200

    select = 9'b010000000; // PISO right shift
    p_din = 16'b1110110010101110;
    #200

    select = 9'b100000000; // Do nothing
    p_din = 16'b1110110010101110;
    #200
    // End of simulation
    $finish;
  end

endmodule
