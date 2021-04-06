`include "16bitSklanskyAdder.v"

module top;

reg [15:0] A, B;
reg cin;
wire [15:0] sum;
wire cout;

SixteenbitSklanskyAdder SlkAdd(A, B, cin, sum, cout);

initial
begin
	cin = 1'b0;
	A = 16'b1101011101010101;
	B = 16'b1010101011101010;
	
	#5;
	A = 16'b0101010101010101;
	B = 16'b1010101010101010;

	#5;
	A = 16'b0001111001010100;
	B = 16'b1000101110001101;

	#5;
	A = 16'b1011010011011101;
	B = 16'b1010101110100011;
end


initial
begin
	$monitor($time, "\t A = %b, B = %b, cin = %b, cout = %b, sum = %b",A, B, cin, cout, sum);
	$dumpfile("16bitSklanskyAdder.vcd");
	$dumpvars;
end

endmodule
