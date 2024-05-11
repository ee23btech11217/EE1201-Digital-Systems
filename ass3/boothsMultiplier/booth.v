module booth (
    input wire clk, 
    input wire rst, 
    input [7:0] x, 
    input [7:0] y, 
    output reg [15:0] s
);

    reg signed [16:0] addend = 0;
    reg signed [16:0] subtra = 0;
    reg signed [16:0] product = 0;

    reg [8:0] state = 0;

    wire signed [15:0] pwire;

    assign pwire = product >>> 1;

    integer i;

    always @ (posedge clk) begin
        if (rst) begin
            state <= 0;
        end
        else if (state == 0) begin
            addend <= { x[7:0], 9'b0 };
            subtra <= {-x[7:0], 9'b0 };
            product <= { 8'b0, y[7:0], 1'b0 };

            state <= state + 1;
        end
        else if (state == 9) begin
            s <= pwire;
            state <= 0;
        end

        for(i = 1; i < 9; i = i + 1) begin
            if (state == i && ~rst) begin
                case(product[1:0])
                    2'b01: product <= (product + addend) >>> 1;
                    2'b10: product <= (product + subtra) >>> 1;
                    default: product <= product >>> 1;
                endcase
                state <= state + 1;
            end
        end
    end

endmodule
