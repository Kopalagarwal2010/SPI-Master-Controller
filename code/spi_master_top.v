module spi_master_top(
    input clk,
    input rst,
    input start,
    input [7:0] data_in,
    input miso,
    output mosi,
    output sclk,
    output cs,
    output [7:0] rx_data,
    output reg alert,
    output done   // ? NEW OUTPUT
);

// ================= INTERNAL SIGNALS =================
wire load, shift, enable_counter;
wire done_internal;   // ? renamed
wire [7:0] shift_reg;

// ================= CLOCK DIVIDER =================
clock_divider u1 (
    .clk(clk),
    .rst(rst),
    .sclk(sclk)
);

// ================= SCLK EDGE DETECTOR =================
reg sclk_d;

always @(posedge clk)
    sclk_d <= sclk;

wire sclk_rising = (sclk == 1 && sclk_d == 0);

// ================= BIT COUNTER =================
bit_counter u2 (
    .clk(clk),
    .rst(rst),
    .enable(enable_counter & sclk_rising),
    .count(),
    .done(done_internal)   // ? FIXED
);

// ================= SHIFT REGISTER =================
spi_shift_register u3 (
    .clk(clk),
    .rst(rst),
    .load(load),
    .shift(shift & sclk_rising),
    .data_in(data_in),
    .miso(miso),
    .mosi(mosi),
    .shift_reg(shift_reg)
);

// ================= FSM =================
spi_fsm u4 (
    .clk(clk),
    .rst(rst),
    .start(start),
    .done(done_internal),   // ? FIXED
    .load(load),
    .shift(shift),
    .enable_counter(enable_counter),
    .cs(cs)
);

// ================= RX DATA =================
reg [7:0] rx_reg;

always @(posedge clk)
begin
    if (done_internal)
        rx_reg <= shift_reg;
end

assign rx_data = rx_reg;

// ================= ALERT LOGIC =================
reg [7:0] threshold = 8'd50;

always @(posedge clk or posedge rst)
begin
    if (rst)
        alert <= 0;

    else if (done_internal)
    begin
        if (shift_reg > threshold)   // ? FIX
            alert <= 1;
        else
            alert <= 0;
    end
end

// ================= OUTPUT DONE =================
assign done = done_internal;

endmodule