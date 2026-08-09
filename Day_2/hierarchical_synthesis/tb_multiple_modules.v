module tb_multiple_modules;

reg a, b, c;
wire y;

multiple_modules uut (
    .a(a),
    .b(b),
    .c(c),
    .y(y)
);

initial begin
    $dumpfile("multiple_modules.vcd");
    $dumpvars(0, tb_multiple_modules);

    a=0; b=0; c=0;
    #10 a=0; b=0; c=1;
    #10 a=0; b=1; c=0;
    #10 a=0; b=1; c=1;
    #10 a=1; b=0; c=0;
    #10 a=1; b=0; c=1;
    #10 a=1; b=1; c=0;
    #10 a=1; b=1; c=1;

    #10 $finish;
end

endmodule
