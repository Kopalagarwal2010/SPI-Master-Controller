module clock_divider(
    input clk,
    input rst,
    output reg sclk,
    output reg tick   // ? important
);

reg [3:0] count;

parameter DIV = 5;

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        count <= 0;
        sclk <= 0;
        tick <= 0;
    end
    else
    begin
        if (count == DIV)
        begin
            count <= 0;
            sclk <= ~sclk;
            tick <= 1;   // ? pulse
        end
        else
        begin
            count <= count + 1;
            tick <= 0;
        end
    end
end

endmodule