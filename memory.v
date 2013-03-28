`include "global_def.h"

module Memory(
  I_CLOCK,
  I_LOCK,
  I_ALUOut,
  I_Opcode,
  I_DestRegIdx,
  I_DestValue,
  I_FetchStall,
  I_DepStall,
  O_LOCK,
  O_ALUOut,
  O_Opcode,
  O_MemOut,
  O_DestRegIdx,
  O_BranchPC,
  O_BranchAddrSelect,
  O_FetchStall,
  O_DepStall,
  O_LEDR,
  O_LEDG,
  O_HEX0,
  O_HEX1,
  O_HEX2,
  O_HEX3
);

/////////////////////////////////////////
// IN/OUT DEFINITION GOES HERE
/////////////////////////////////////////
//
// Inputs from the execute stage
input I_CLOCK;
input I_LOCK;
input [`REG_WIDTH-1:0] I_ALUOut;
input [`OPCODE_WIDTH-1:0] I_Opcode;
input [3:0] I_DestRegIdx;
input [`REG_WIDTH-1:0] I_DestValue;
input I_FetchStall;
input I_DepStall;

// Outputs to the writeback stage
output reg O_LOCK;
output reg [`REG_WIDTH-1:0] O_ALUOut;
output reg [`OPCODE_WIDTH-1:0] O_Opcode;
output reg [3:0] O_DestRegIdx;
output reg [`REG_WIDTH-1:0] O_MemOut;
output reg O_FetchStall;
output reg O_DepStall;

// Outputs to the fetch stage
output reg [`PC_WIDTH-1:0] O_BranchPC;
output reg O_BranchAddrSelect;

// Outputs for debugging
output [9:0] O_LEDR;
output [7:0] O_LEDG;
output [6:0] O_HEX0, O_HEX1, O_HEX2, O_HEX3;

/////////////////////////////////////////
// WIRE/REGISTER DECLARATION GOES HERE
/////////////////////////////////////////
//
reg[`DATA_WIDTH-1:0] DataMem[0:`DATA_MEM_SIZE-1];

/////////////////////////////////////////
// INITIAL STATEMENT GOES HERE
/////////////////////////////////////////
//
initial 
begin
  $readmemh("data.hex", DataMem);
end

/////////////////////////////////////////
// ALWAYS STATEMENT GOES HERE
/////////////////////////////////////////
//

/////////////////////////////////////////
// ## Note ##
// 1. Do the appropriate memory operations.
// 2. Provide Branch Target Address and Selection Signal to the fetch stage.
/////////////////////////////////////////
always @(negedge I_CLOCK)
begin
  O_LOCK <= I_LOCK;
  O_FetchStall <= I_FetchStall;

  if (I_LOCK == 1'b1)
  begin
    /////////////////////////////////////////////
    // TODO: Complete here 
    /////////////////////////////////////////////
	 
	 // pass them to WB
	 O_DestRegIdx <= I_DestRegIdx;
	 O_DepStall <= I_DepStall;
	 O_ALUOut <= I_ALUOut;
	 O_Opcode <= I_Opcode;
	 
	 // pass it to FETCH
	 // if bracnh address select not asserted, then it's treated as "don't care"
	 O_BranchPC <= I_ALUOut;
	 
	 if ( (I_FetchStall==1'b0) && (I_DepStall==1'b0) )
	 begin
		// load and store
		// set BranchPC
		case (I_Opcode)
			`OP_LDW: // double check later
			begin
				O_MemOut <= DataMem[I_ALUOut]; // I_ALUOut = base + offset
				O_BranchAddrSelect <= 1'b0;
			end
			`OP_STW:
			begin
				DataMem[I_ALUOut] <= I_DestValue;  // I_DestValue = base + offset
				O_BranchAddrSelect <= 1'b0;
			end
			`OP_BRN:   O_BranchAddrSelect <= 1'b1;
			`OP_BRZ:   O_BranchAddrSelect <= 1'b1;
			`OP_BRP:   O_BranchAddrSelect <= 1'b1;
			`OP_BRNZ:  O_BranchAddrSelect <= 1'b1;
			`OP_BRZP:  O_BranchAddrSelect <= 1'b1;
			`OP_BRNP:  O_BranchAddrSelect <= 1'b1;
			`OP_BRNZP: O_BranchAddrSelect <= 1'b1;
			`OP_JSR:   O_BranchAddrSelect <= 1'b1;
			`OP_JSRR:  O_BranchAddrSelect <= 1'b1;
			`OP_JMP:   O_BranchAddrSelect <= 1'b1;
			default:   O_BranchAddrSelect <= 1'b0;
		endcase
		
	 end // if ( (I_FetchStall==1'b0) && (I_DepStall==1'b0) )
	 
	 /*
	// O_BranchAddrSelect <= 1'b0;
	// if ( (I_FetchStall==1'b0) && (I_DepStall==1'b0) )
	if (I_DepStall==1'b0)
	begin
	case (I_Opcode)
		`OP_LDW: // double check later
		begin
			O_MemOut <= DataMem[I_ALUOut]; // I_ALUOut = base + offset
			O_BranchAddrSelect <= 1'b0;
		end
		`OP_STW:
		begin
			DataMem[I_ALUOut] <= I_DestValue;  // I_DestValue = base + offset
			O_BranchAddrSelect <= 1'b0;
		end
	`OP_BRN:
	begin
		O_BranchPC <= I_ALUOut;
		O_BranchAddrSelect <= 1'b1;
	end
	`OP_BRZ:
	begin
		O_BranchPC <= I_ALUOut;
		O_BranchAddrSelect <= 1'b1;
	end
	`OP_BRP:
	begin
		O_BranchPC <= I_ALUOut;
		O_BranchAddrSelect <= 1'b1;
	end
	`OP_BRNZ:
	begin
		O_BranchPC <= I_ALUOut;
		O_BranchAddrSelect <= 1'b1;
	end
	`OP_BRZP:
	begin
		O_BranchPC <= I_ALUOut;
		O_BranchAddrSelect <= 1'b1;	
	end
	`OP_BRNP:
	begin
		O_BranchPC <= I_ALUOut;
		O_BranchAddrSelect <= 1'b1;
	end
	`OP_BRNZP:
	begin
		O_BranchPC <= I_ALUOut;
		O_BranchAddrSelect <= 1'b1;
	end
	`OP_JSR:
	begin
		O_BranchPC <= I_ALUOut;
		O_BranchAddrSelect <= 1'b1;
	end
	`OP_JSRR:
	begin
	O_BranchPC <= I_ALUOut;
	O_BranchAddrSelect <= 1'b1;
	end
	`OP_JMP:
	begin
		O_BranchPC <= I_ALUOut;
		O_BranchAddrSelect <= 1'b1;
	end
	default: O_BranchAddrSelect <= 1'b0;
	endcase
	end
	*/
  end // if (I_LOCK == 1'b1)
  else
  begin
    O_BranchAddrSelect <= 1'b0;
  end // if (I_LOCK != 1'b1)
end // always @(negedge I_CLOCK)

/////////////////////////////////////////
// ## Note ##
// Simple implementation of Memory-mapped I/O
// - The value stored at dedicated location will be expressed 
//   by the corresponding H/W.
//   - LEDR: Address 1020 (0x3FC)
//   - LEDG: Address 1021 (0x3FD)
//   - HEX : Address 1022 (0x3FE)
/////////////////////////////////////////
// Create and connect HEX register 
reg [15:0] HexOut;
SevenSeg sseg0(.OUT(O_HEX3), .IN(HexOut[15:12]));
SevenSeg sseg1(.OUT(O_HEX2), .IN(HexOut[11:8]));
SevenSeg sseg2(.OUT(O_HEX1), .IN(HexOut[7:4]));
SevenSeg sseg3(.OUT(O_HEX0), .IN(HexOut[3:0]));

// Create and connect LEDR, LEDG registers 
reg [9:0] LedROut;
reg [7:0] LedGOut;

always @(negedge I_CLOCK)
begin
  if (I_LOCK == 0) begin
    HexOut <= 16'hDEAD;
    LedGOut <= 8'b11111111;
    LedROut <= 10'b1111111111;
  end else begin // if (I_LOCK == 0) begin
    if ((I_FetchStall == 1'b0) && (I_DepStall == 1'b0)) begin
      if (I_Opcode == `OP_STW) begin
        if (I_ALUOut[9:0] == `ADDRHEX)
          HexOut <= I_DestValue;
        else if (I_ALUOut[9:0] == `ADDRLEDR)
          LedROut <= I_DestValue;
        else if (I_ALUOut[9:0] == `ADDRLEDG)
          LedGOut <= I_DestValue;
      end // if (I_Opcode == `OP_STW) begin
    end // if ((I_FetchStall == 1'b0) && (I_DepStall == 1'b0)) begin
  end // if (I_LOCK == 0) begin
end // always @(negedge I_CLOCK)

assign O_LEDR = LedROut;
assign O_LEDG = LedGOut;

endmodule // module Memory
