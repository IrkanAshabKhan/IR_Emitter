module top_emitter(
    input clk,                  // 100MHz clock
    output signalOut            // Square wave to JA1
);

// Select frequency: 1kHz = 00, 2kHz = 01, 3kHz = 10
wire [1:0] freq_sel = 2'b10;   // Test with 3kHz

// Connect output
wire drive;

assign signalOut = drive;

Emitter emit(
    .clk(clk),
    .freq_sel(freq_sel),
    .drive(drive)
);

endmodule



