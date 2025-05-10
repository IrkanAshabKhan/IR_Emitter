module Emitter(
    input clk,                  // 100MHz clock
    input [1:0] freq_sel,       // 2-bit frequency selector
    output reg drive            // Output square wave (e.g., JA1)
);

// Frequency division values for 1kHz, 2kHz, 3kHz (half period in clock cycles)
reg [31:0] toggle_count;
reg [31:0] counter;

always @(*) begin
    case (freq_sel)
        2'b00: toggle_count = 50000;   // 100MHz / (2 * 1kHz)
        2'b01: toggle_count = 25000;   // 100MHz / (2 * 2kHz)
        2'b10: toggle_count = 16667;   // 100MHz / (2 * 3kHz)
        default: toggle_count = 50000; // Default to 1kHz
    endcase
end

initial begin
    counter = 0;
    drive = 0;
end

always @(posedge clk) begin
    if (counter >= toggle_count) begin
        counter <= 0;
        drive <= ~drive; // Toggle output
    end else begin
        counter <= counter + 1;
    end
end

endmodule


