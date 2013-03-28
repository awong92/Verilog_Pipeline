library verilog;
use verilog.vl_types.all;
entity lg_highlevel is
    port(
        CLOCK_27        : in     vl_logic_vector(1 downto 0);
        CLOCK_50        : in     vl_logic;
        LEDR            : out    vl_logic_vector(9 downto 0);
        LEDG            : out    vl_logic_vector(7 downto 0);
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX3            : out    vl_logic_vector(6 downto 0)
    );
end lg_highlevel;
