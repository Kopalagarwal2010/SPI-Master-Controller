module bit_counter(
    input clk,
    input rst,
    input enable,
    output reg [2:0] count,
    output reg done
);

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        count <= 0;
        done  <= 0;
    end
    else if(enable)
    begin
        if(count == 3'd7)
        begin
            count <= 0;
            done  <= 1;
        end
        else
        begin
            count <= count + 1;
            done  <= 0;
        end
    end
    else
        done <= 0;
end

endmodule