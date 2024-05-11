module universalShift(
  input clk, 
  input rst_n, 
  input [8:0] select, // select operation
  input [15:0] p_din,  // parallel data in 
  input s_left_din,   // serial left data in
  input s_right_din,  // serial right data in
  output reg [15:0] p_dout, //parallel data out
  output reg s_left_dout, // serial left data out
  output reg s_right_dout // serial right data out
);

reg pdoutbuffer;

always @ (posedge clk) begin : select_magic
if(rst_n) begin : reset_logic
    p_dout = 16'b0;
    s_left_dout = 1'b0;     
    s_right_dout = 1'b0; 
end
else begin
 case(select) 
        9'b000000001: begin // SISO left shift
        s_left_dout = p_dout[15];
        p_dout = p_dout << 1;
        p_dout = {p_dout[15:1], s_right_din};
                    end
        9'b000000010: begin // SISO right shift
        s_right_dout = p_dout[0];
        p_dout = p_dout >> 1;
        p_dout = {s_left_din, p_dout[14:0]};
                      end
        9'b000000100: begin // SIPO left shift
        s_left_dout = p_dout[15];
        p_dout = p_dout << 1;
        p_dout = {p_dout[15:1], s_right_din};
                      end
        9'b000001000: begin // SIPO right shift
        s_right_dout = p_dout[0];
        p_dout = p_dout >> 1;
        p_dout = {s_left_din, p_dout[14:0]};
                      end
        9'b000010000: begin // PIPO left shift
        p_dout = p_din;
        p_dout = p_dout << 1;
                      end
        9'b000100000: begin // PIPO right shift
        p_dout = p_din;
        p_dout = p_dout >> 1;
                      end
        9'b001000000: begin // PISO left shift
        p_dout = p_din;
        s_left_dout = p_dout[15];
        p_dout = p_dout << 1;
                      end
        9'b010000000: begin // PISO right shift
        p_dout = p_din;
        s_right_dout = p_dout[0];
        p_dout = p_dout >> 1;    
                      end
        9'b100000000: begin // Do nothing
                      p_dout = p_dout;
                      end
        default: begin
          p_dout = 16'b0;
          s_left_dout =0;
          s_right_dout =0;
        end // Do nothing
      endcase
end
end
endmodule