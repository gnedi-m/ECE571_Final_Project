module IOMEM(Intel8088Pins.Peripheral i, input logic CS, input logic [19:0] Address, input logic [7:0] Data);	//IOM is in top module generating CS
parameter SIZE = 4;	//default is a size note present in any memory or IO device. IF this case occurs, something is wrong with passing parameters in top
parameter string FILENAME = "NOTPRESENT.txt";	//default is a file not included, thus if passing the parameter fails, and error should occur
//input logic i.CLK, i.RESET, i.ALE, CS, i.RD, i.WR;

/******************/
/*Internal signals*/
/******************/

/*FSM Outputs*/
bit OE;
bit LoadAddress;
bit Write;

/*Address Register (IN-line)*/
/*Contains appropriate address size to access memory location/IO port*/
logic [SIZE-1:0] addr;
always_ff @(posedge i.CLK)
begin
if (LoadAddress)
	addr <= Address;
else
	addr <= addr;
end	


/*Size of memory or IO*/
logic [7:0] M[2**SIZE];

/*initialize contents of the memory or IO*/
initial
begin
$readmemh(FILENAME, M);
end

assign Data = OE? M[addr] : 'z;
always_ff @(posedge i.CLK)
begin
if (Write)
	M[addr] <= Data;
end


/*****/
/*FSM*/
/*****/
enum {	IDLEbit			= 0,
		GETADDRESSbit	= 1,
		READbit			= 2,
		WRITEbit		= 3,
		PREPNEXTbit		= 4} statebit;
/*Shift a 1 to the bit that represents each state*/
enum logic [4:0] {	IDLE 		= 5'b00001<<IDLEbit, 
					GETADDRESS 	= 5'b00001<<GETADDRESSbit, 
					READ		= 5'b00001<<READbit, 
					WRITE		= 5'b00001<<WRITEbit, 
					PREPNEXT	= 5'b00001<<PREPNEXTbit} State, NextState;

/*Sequential State Logic*/
always_ff @(posedge i.CLK)
begin
if (i.RESET)
	State <= IDLE;
else
	State <= NextState;
end

/*Next State Combinational Logic*/
always_comb
begin
NextState = State;	//default to avoid latch
unique case (1'b1)
	State[IDLEbit]:
		if (CS && i.ALE)
			NextState = GETADDRESS;
	State[GETADDRESSbit]:
		if (!i.RD)
			NextState = READ;
		else if (!i.WR)
			NextState = WRITE;
	State[READbit]:
		NextState = PREPNEXT;
	State[WRITEbit]:
		NextState = PREPNEXT;
	State[PREPNEXTbit]:
		NextState = IDLE;
endcase
end

/*State Output Combinational Logic*/
always_comb
begin
{OE, LoadAddress, Write} = 3'b000;
unique case(1'b1)
	State[IDLEbit]:
		begin
		//no output change
		end
	State[GETADDRESSbit]:
		LoadAddress = '1;
	State[READbit]:
		OE = '1;
	State[WRITEbit]:
		Write = '1;
	State[PREPNEXTbit]:
		begin
		//no output change
		end
endcase
end 




endmodule