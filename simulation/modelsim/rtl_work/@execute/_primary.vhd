library verilog;
use verilog.vl_types.all;
entity Execute is
    port(
        I_CLOCK         : in     vl_logic;
        I_LOCK          : in     vl_logic;
        I_PC            : in     vl_logic_vector(15 downto 0);
        I_Opcode        : in     vl_logic_vector(7 downto 0);
        I_Src1Value     : in     vl_logic_vector(15 downto 0);
        I_Src2Value     : in     vl_logic_vector(15 downto 0);
        I_DestRegIdx    : in     vl_logic_vector(3 downto 0);
        I_Imm           : in     vl_logic_vector(15 downto 0);
        I_DestValue     : in     vl_logic_vector(15 downto 0);
        I_FetchStall    : in     vl_logic;
        I_DepStall      : in     vl_logic;
        O_LOCK          : out    vl_logic;
        O_ALUOut        : out    vl_logic_vector(15 downto 0);
        O_Opcode        : out    vl_logic_vector(7 downto 0);
        O_DestRegIdx    : out    vl_logic_vector(3 downto 0);
        O_DestValue     : out    vl_logic_vector(15 downto 0);
        O_FetchStall    : out    vl_logic;
        O_DepStall      : out    vl_logic
    );
end Execute;
