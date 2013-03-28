library verilog;
use verilog.vl_types.all;
entity Memory is
    port(
        I_CLOCK         : in     vl_logic;
        I_LOCK          : in     vl_logic;
        I_ALUOut        : in     vl_logic_vector(15 downto 0);
        I_Opcode        : in     vl_logic_vector(7 downto 0);
        I_DestRegIdx    : in     vl_logic_vector(3 downto 0);
        I_DestValue     : in     vl_logic_vector(15 downto 0);
        I_FetchStall    : in     vl_logic;
        I_DepStall      : in     vl_logic;
        O_LOCK          : out    vl_logic;
        O_ALUOut        : out    vl_logic_vector(15 downto 0);
        O_Opcode        : out    vl_logic_vector(7 downto 0);
        O_MemOut        : out    vl_logic_vector(15 downto 0);
        O_DestRegIdx    : out    vl_logic_vector(3 downto 0);
        O_BranchPC      : out    vl_logic_vector(15 downto 0);
        O_BranchAddrSelect: out    vl_logic;
        O_FetchStall    : out    vl_logic;
        O_DepStall      : out    vl_logic;
        O_LEDR          : out    vl_logic_vector(9 downto 0);
        O_LEDG          : out    vl_logic_vector(7 downto 0);
        O_HEX0          : out    vl_logic_vector(6 downto 0);
        O_HEX1          : out    vl_logic_vector(6 downto 0);
        O_HEX2          : out    vl_logic_vector(6 downto 0);
        O_HEX3          : out    vl_logic_vector(6 downto 0)
    );
end Memory;
