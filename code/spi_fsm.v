module spi_fsm(
    input clk,
    input rst,
    input start,
    input done,
    output reg load,
    output reg shift,
    output reg enable_counter,
    output reg cs
);

reg [1:0] state;

parameter IDLE     = 2'b00,
          LOAD     = 2'b01,
          TRANSFER = 2'b10,
          FINISH   = 2'b11;

always @(posedge clk or posedge rst)
begin
    if(rst)
        state <= IDLE;
    else
    begin
        case(state)
            IDLE:     if(start) state <= LOAD;
            LOAD:     state <= TRANSFER;
            TRANSFER: if(done) state <= FINISH;
            FINISH:   state <= IDLE;
            default:  state <= IDLE;
        endcase
    end
end

always @(*)
begin
    load = 0;
    shift = 0;
    enable_counter = 0;
    cs = 1;

    case(state)
        LOAD:
        begin
            load = 1;
            cs = 0;
        end

        TRANSFER:
        begin
            shift = 1;
            enable_counter = 1;
            cs = 0;
        end
    endcase
end

endmodule