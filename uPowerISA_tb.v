
// uPowerISA test bench - To drive and simulate the entire MIPS ALU 
module uPower_testbench();

reg clock;
wire result;

uPower_core(clock);
initial clock = 0;

initial 
 begin
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
#100 clock=~clock; #100 clock=~clock;
 end

endmodule