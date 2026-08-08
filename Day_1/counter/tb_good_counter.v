`timescale 1ns/1ps

module tb_good_counter;

reg clk;
reg reset;
wire [1:0] cnt;

good_counter uut (
    .clk(clk),
    .reset(reset),
    .cnt(cnt)
);

initial begin
    $dumpfile("tb_good_counter.vcd");
    $dumpvars(0, tb_good_counter);

    clk = 0;
    reset = 1;

    #20;
    reset = 0;

    #100;
    $finish;
end

always #5 clk = ~clk;

endmodule
