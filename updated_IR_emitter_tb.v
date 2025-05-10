`timescale 1ns / 1ps

`include "IR_emitter\\updated_Emitter.v"
`include "IR_emitter\\updated_top_emitter.v"

module tb_top_emitter;

    // Testbench signals
    reg clk;
    wire signalOut;

    // Instantiate the top_emitter module
    top_emitter uut (
        .clk(clk),
        .signalOut(signalOut)
    );

    // Clock generation: 100MHz => period = 10ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle every 5ns -> 10ns period
    end

    // Simulation runtime control
    initial begin
        // VCD generation setup
        $dumpfile("top_emitter.vcd");       // Name of the VCD file
        $dumpvars(0, tb_top_emitter);       // Dump all variables in the testbench hierarchy

        // Monitor output changes
        $display("Time\t\tSignalOut");
        $monitor("%0dns\t%b", $time, signalOut);

        // Run the simulation
        #400000; // Run for 400us (enough to see a few 3kHz cycles)
        $finish;
    end

endmodule