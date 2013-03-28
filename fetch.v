`include "global_def.h"

module Fetch(
  I_CLOCK,
  I_LOCK,
  I_BranchPC,
  I_BranchAddrSelect,
  I_BranchStallSignal,
  I_DepStallSignal,
  O_LOCK,
  O_PC,
  O_IR,
  O_FetchStall
);

/////////////////////////////////////////
// IN/OUT DEFINITION GOES HERE
/////////////////////////////////////////
//
// Inputs from high-level module (lg_highlevel)
input I_CLOCK;
input I_LOCK;

// Inputs from the memory stage 
input [`PC_WIDTH-1:0] I_BranchPC; // Branch Target Address
input I_BranchAddrSelect; // Asserted only when Branch Target Address resolves

// Inputs from the decode stage
input I_BranchStallSignal; // Asserted from when branch instruction is decode to when Branch Target Address resolves 
input I_DepStallSignal; // Asserted when register dependency is detected

// Outputs to the decode stage
output reg O_LOCK;
output reg [`PC_WIDTH-1:0] O_PC;
output reg [`IR_WIDTH-1:0] O_IR;

/////////////////////////////////////////
// ## Note ##
// O_FetchStall: Asserted when fetch stage is not updating FE/DE latch. 
// - The instruction with O_FetchStall == 1 will be treated as NOP in the following stages
/////////////////////////////////////////
output reg O_FetchStall; 
 
/////////////////////////////////////////
// WIRE/REGISTER DECLARATION GOES HERE
/////////////////////////////////////////
//
reg[`INST_WIDTH-1:0] InstMem[0:`INST_MEM_SIZE-1];
reg[`PC_WIDTH-1:0] PC;  

/////////////////////////////////////////
// INITIAL/ASSIGN STATEMENT GOES HERE
/////////////////////////////////////////
//
initial 
begin
  // $readmemh("test0.hex", InstMem);
  $readmemh("grading_asm.hex", InstMem);
  PC = 16'h0;

  O_LOCK = 1'b0;
  O_PC = 16'h4;
  O_IR = 32'hFF000000;
end

/////////////////////////////////////////
// ALWAYS STATEMENT GOES HERE
/////////////////////////////////////////
//

/////////////////////////////////////////
// ## Note ##
// 1. Update output values (O_FetchStall, O_PC, O_IR) and PC.
// 2. You should be careful about STALL signals.
/////////////////////////////////////////
always @(negedge I_CLOCK)
begin      
  O_LOCK <= I_LOCK;

  if (I_LOCK == 1'b0)
  begin
    PC <= 0;
    O_IR <= InstMem[PC[`PC_WIDTH-1:2]];
    O_PC <= 16'h4;
	 // O_LOCK <= 1'b1;
	 O_FetchStall <= 1'b0;
  end 
  else
  begin
    /////////////////////////////////////////////
    // TODO: Complete here
    /////////////////////////////////////////////
	 
	 // stall if branch stall or dep stall asserted
	 
	 // I_BranchAddrSelect == 1 interpreted as 

	 /*
	 if (I_BranchStallSignal==1'b1 && I_BranchAddrSelect==1'b0) 
	 begin
		O_FetchStall <= 1'b1;
	 end
	 else if (I_DepStallSignal==1'b1) 
	 begin
		O_FetchStall <= 1'b1;
	 end
	 else // when neither signals is set 
	 begin
		
		if (I_BranchAddrSelect==1'b1) PC <= I_BranchPC;
		else PC <= PC +  16'h4;
		O_FetchStall <= 1'b0;
		O_IR <= InstMem[PC[`PC_WIDTH-1:2]];
		O_PC <= PC + 16'h4;
		
	 end
	 */
	 /*
	 if (I_BranchAddrSelect==1'b1) 
	 begin

		O_FetchStall <= 1'b0;
		PC <= I_BranchPC;
		O_IR <= InstMem[PC[`PC_WIDTH-1:2]];
		O_PC <= PC + 16'h4;

	 end
	 else if ( (I_BranchStallSignal==1'b1) || (I_DepStallSignal==1'b1) ) 
	 begin
		O_FetchStall <= 1'b1;
	 end
	 else // when neither signals is set 
	 begin
		PC <= PC +  16'h4;
		O_FetchStall <= 1'b0;
		O_IR <= InstMem[PC[`PC_WIDTH-1:2]];
		O_PC <= PC + 16'h4;
		
	 end
	 */
	 
	 // in case of branch instructions, I_DepStallSignal indicates that 
	 if (I_BranchAddrSelect==1'b1) // ((I_BranchStallSignal==1'b1) && (I_BranchAddrSelect==1'b1))
		begin
			PC <= I_BranchPC;
			O_FetchStall <= 1'b0;
			O_IR <= InstMem[PC[`PC_WIDTH-1:2]];
			O_PC <= PC + 16'h4;
		end
	 else if ((I_DepStallSignal==1'b1) || (I_BranchStallSignal==1'b1)) O_FetchStall <= 1'b1;
	 else
	 begin	 
		PC <= PC +  16'h4;
		O_FetchStall <= 1'b0;
		O_IR <= InstMem[PC[`PC_WIDTH-1:2]];
		O_PC <= PC + 16'h4;
	 end
		
	 
	 end // end else
	 /*
	 else if (I_DepStallSignal==1'b0)
	 begin
		O_FetchStall <= 1'b0;
		if (I_BranchAddrSelect==1'b1) PC <= I_BranchPC;
		else PC <= PC +  16'h4;
		O_IR <= InstMem[PC[`PC_WIDTH-1:2]];
		O_PC <= PC + 16'h4;
	 end
	 else O_FetchStall <= 1'b1;
	 */
	 
	// end // if I_LOCK == 1

end // always @(negedge I_CLOCK)

endmodule // module Fetch