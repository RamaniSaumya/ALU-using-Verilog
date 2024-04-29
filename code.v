module ALU(clk,reset,A,B,ans_ex,flags,opcode);
input clk,reset;
input [15:0]A,B;
input [4:0]opcode;
output [15:0]ans_ex;
output [3:0]flags;
wire carry;
		
assign {carry,ans_ex}=(opcode==5'b00000)?(A+B):
		((opcode==5'b00001)?(A-B):
		((opcode==5'b00010)?(B):
		((opcode==5'b00100)?(A&B):
		((opcode==5'b00101)?(A|B):
		((opcode==5'b00110)?(A^B):
		((opcode==5'b00111)?(~B):
		
		((opcode==5'b10000)?(ans_ex):
		((opcode==5'b10001)?(ans_ex):
		
		((opcode==5'b10100)?(A):
		((opcode==5'b10101)?(A):
		
		((opcode==5'b10111)?(ans_ex):
		((opcode==5'b11000)?(ans_ex):
		
		((opcode==5'b11001)?(A<<B):
		((opcode==5'b11010)?(A>>B):
		
		((opcode==5'b11011)?((B==1)?({A[15],A[15:1]}):
									((B==2)?({A[15],A[15],A[15:2]}):
									((B==3)?({A[15],A[15],A[15],A[15:3]}):
									((B==4)?({A[15],A[15],A[15],A[15],A[15:4]}):
									((B==5)?({A[15],A[15],A[15],A[15],A[15],A[15:5]}):
									((B==6)?({A[15],A[15],A[15],A[15],A[15],A[15],A[15:6]}):
									((B==7)?({A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15:7]}):
									((B==8)?({A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15:8]}):
									((B==9)?({A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15:9]}):
									((B==10)?({A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15:10]}):
									((B==11)?({A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15:11]}):
									((B==12)?({A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15:12]}):
									((B==13)?({A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15:13]}):
									((B==14)?({A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15:14]}):({A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15],A[15]})
									)))))))))))))):
		
		((opcode==5'b11100)?(ans_ex):
		((opcode==5'b11101)?(ans_ex):
		((opcode==5'b11110)?(ans_ex):
		((opcode==5'b11111)?(ans_ex):(ans_ex))
		))))))))))))))))));

assign flags[3]=(^ans_ex);				//Parity
assign flags[2]=(carry^ans_ex[15]);	//Overflow
assign flags[1]=~(|ans_ex);				//Zero
assign flags[0]=carry;						//Carry


assign flags=(opcode==5'b00000)?{&ans_ex,carry^ans_ex[15],~(|ans_ex),carry}:
		((opcode==5'b00001)?{&ans_ex,carry^ans_ex[15],~(|ans_ex),carry}:
		((opcode==5'b00010)?{&ans_ex,1'b0,~(|ans_ex),1'b0}:
		((opcode==5'b00100)?{&ans_ex,1'b0,~(|ans_ex),1'b0}:
		((opcode==5'b00101)?{&ans_ex,1'b0,~(|ans_ex),1'b0}:
		((opcode==5'b00110)?{&ans_ex,1'b0,~(|ans_ex),1'b0}:
		((opcode==5'b00111)?{&ans_ex,1'b0,~(|ans_ex),1'b0}:
		
		((opcode==5'b10000)?0:
		((opcode==5'b10001)?0:
		
		((opcode==5'b10100)?flags:
		((opcode==5'b10101)?flags:
		
		((opcode==5'b10111)?flags:
		((opcode==5'b11000)?flags:
		
		((opcode==5'b11001)?{&ans_ex,1'b0,~(|ans_ex),1'b0}:
		((opcode==5'b11010)?{&ans_ex,1'b0,~(|ans_ex),1'b0}:
		
		((opcode==5'b11011)?{&ans_ex,1'b0,~(|ans_ex),1'b0}:
		
		((opcode==5'b11100)?flags:
		((opcode==5'b11101)?flags:
		((opcode==5'b11110)?flags:
		((opcode==5'b11111)?flags:flags)
		))))))))))))))))));
		
endmodule

module TB();
reg [15:0]a,b;
reg [4:0]opcode;
wire [15:0]out;
wire [3:0]flag;

ALU a1(.A(a), .B(b), .opcode(opcode), .ans_ex(out), .flags(flag));
initial begin
	a=16'b1111111111111111;
	b=16'b0000000000000001;
	opcode=5'b00000;
	
	#100;
	a=16'b1111111111111111;
	b=16'b0000000000000010;
	opcode=5'b00100;
	
	#100;
	a=16'b1111111111111111;
	b=16'b0000000000000010;
	opcode=5'b00000;
	
	#100;
	a=16'b0000000000011111;
	b=16'b0000000000000001;
	opcode=5'b10100;
	
	#100;
	a=16'b1000000000011111;
	b=16'b0000000000000100;
	opcode=5'b11011;
end
endmodule