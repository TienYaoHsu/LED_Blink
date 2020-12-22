module tick_gen (
    input clk,
    input rstN,

    output oTick1ms
);

reg [19:0] rvBaseCnt_d, rvBaseCnt_q;
wire AddBaseCnt, EndBaseCnt;

assign AddBaseCnt = 1'b1; 
assign EndBaseCnt = AddBaseCnt && (rvBaseCnt_q == 50_000 - 1); //generate 1m second
//assign EndBaseCnt = AddBaseCnt && (rvBaseCnt_q == 10_000 - 1); //sim
always @(posedge clk or negedge rstN) begin
    if(!rstN)
        rvBaseCnt_q <= 19'h0;
    else
        rvBaseCnt_q <= rvBaseCnt_d;
end

always @(*) begin
    if(EndBaseCnt)
        rvBaseCnt_d = 19'h0;
    else if(AddBaseCnt)
        rvBaseCnt_d = rvBaseCnt_q + 1'b1;
    else
        rvBaseCnt_d = rvBaseCnt_q;
end
assign oTick1ms = EndBaseCnt;


endmodule