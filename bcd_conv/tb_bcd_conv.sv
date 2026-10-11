`timescale 1ns/1ps
module tb;
    reg [3:0] ten, one;
    wire [6:0] bin;
    wire valid;
    bcd_conv dut(one, ten, bin, valid);
    integer t, o;
    // 파형 저장 (GTKWave로 확인) - 원본 TB에 추가한 부분
    initial begin $dumpfile("bcd_conv.vcd"); $dumpvars(0, tb); end
    initial begin
        for(t=0;t<16;t=t+1)
            for(o=0;o<16;o=o+1) begin
                ten=t; one=o; #1;
                if(valid !== ((t<10)&&(o<10))) $fatal(1,"BCD valid");
                if(t<10 && o<10 && bin !== t*10+o) $fatal(1,"BCD value");
            end
        $display("PASS BCD: 100 valid and 156 invalid inputs"); $finish;
    end
    initial begin #1000; $fatal(1,"timeout"); end
endmodule
