module LED_TOP (
    input CLK_50M,
    input RESET_N,
    output [7:0] LED
);
wire wTick1ms, wLedBlink;

tick_gen tick_gen_inst (
    .clk            (CLK_50M),
    .rstN           (RESET_N),

    .oTick1ms       (wTick1ms)
);

LED_Blink LED_Blink_inst (
    .clk            (CLK_50M),
    .rstN           (RESET_N),

    .iTick1ms       (wTick1ms),
    .oLedBlink      (wLedBlink)
);
assign LED = ~{8{wLedBlink}};


endmodule