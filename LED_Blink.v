module LED_Blink (
    input clk,
    input rstN,

    input iTick1ms,
    output oLedBlink
);
reg [9:0] rvCnt_d, rvCnt_q;
wire AddCnt, EndCnt;

assign AddCnt = iTick1ms;
assign EndCnt = AddCnt && (rvCnt_q == 1000 - 1);
always @(posedge clk or negedge rstN) begin
    if(!rstN)
        rvCnt_q <= 10'h0;
    else
        rvCnt_q <= rvCnt_d;
end

always @(*) begin
    if(EndCnt)
        rvCnt_d = 10'h0;
    else if(AddCnt)
        rvCnt_d = rvCnt_q + 1'b1;
    else
        rvCnt_d = rvCnt_q;
end

assign oLedBlink = ((rvCnt_q<100-1) || (rvCnt_q>300-1 && rvCnt_q<400-1)) ? 1'b1 : 1'b0;



endmodule