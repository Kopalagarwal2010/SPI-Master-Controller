`timescale 1ns / 1ps

module spi_master_tb;

reg clk;
reg rst;
reg start;
reg [7:0] data_in;

wire mosi;
wire sclk;
wire cs;
wire miso;
wire [7:0] rx_data;
wire alert;
wire done;   // ? NEW

// ================= DUT =================
spi_master_top uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .miso(miso),
    .mosi(mosi),
    .sclk(sclk),
    .cs(cs),
    .rx_data(rx_data),
    .alert(alert),
    .done(done)   // ? CONNECTED
);

// ================= DUMMY SENSOR =================
spi_slave_dummy slave (
    .sclk(sclk),
    .cs(cs),
    .miso(miso)
);

// ================= CLOCK =================
always #5 clk = ~clk;

// ================= STIMULUS =================
initial begin
    clk = 0;
    rst = 1;
    start = 0;
    data_in = 8'h00;

    #20 rst = 0;

    // ================= TRANSFER 1 =================
    #20;
    data_in = 8'hAA;
    start = 1;
    #10 start = 0;

    wait(done);   // ? wait for completion

    // ================= TRANSFER 2 =================
    #20;
    data_in = 8'h55;
    start = 1;
    #10 start = 0;

    wait(done);

    // ================= TRANSFER 3 =================
    #20;
    data_in = 8'hF0;
    start = 1;
    #10 start = 0;

    wait(done);

    #100 $finish;
end

// ================= MONITOR =================
initial begin
    $monitor("Time=%0t | RX=%h | ALERT=%b | CS=%b",
              $time, rx_data, alert, cs);
end

endmodule