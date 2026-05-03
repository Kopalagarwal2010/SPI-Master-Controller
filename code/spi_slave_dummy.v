module spi_slave_dummy(
    input sclk,
    input cs,
    output reg miso
);

reg [7:0] data = 8'h3C;
reg cs_d;

// Initialize MISO
initial begin
    miso = 0;
end

// Detect CS falling edge
always @(posedge sclk)
    cs_d <= cs;

wire cs_falling = (cs_d == 1 && cs == 0);

// SPI behavior
always @(posedge sclk)
begin
    if (cs_falling)
        data <= 8'h3C;   // reload for every transaction

    else if (cs == 0)
    begin
        miso <= data[7];
        data <= {data[6:0], 1'b0};
    end
end

endmodule