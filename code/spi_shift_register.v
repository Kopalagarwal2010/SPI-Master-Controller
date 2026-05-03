module spi_shift_register(
    input clk,
    input rst,
    input load,
    input shift,
    input [7:0] data_in,
    input miso,
    output reg mosi,
    output reg [7:0] shift_reg
);

// ================= SHIFT REGISTER =================
always @(posedge clk or posedge rst)
begin
    if (rst)
        shift_reg <= 8'b0;

    else if (load)
        shift_reg <= data_in;

    else if (shift)
        shift_reg <= {shift_reg[6:0], miso};
end

// ================= MOSI =================
always @(posedge clk or posedge rst)
begin
    if (rst)
        mosi <= 0;

    else if (load)
        mosi <= data_in[7];   // ? FIRST BIT READY BEFORE CLOCK

    else if (shift)
        mosi <= shift_reg[6]; // ? NEXT BIT
end

endmodule