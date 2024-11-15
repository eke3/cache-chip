-- Entity: data_input_selector.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity data_input_selector is
    port(
        cpu_data: in std_logic_vector(7 downto 0);
        mem_data: in std_logic_vector(7 downto 0);
        hit_miss: in std_logic;
        R_W:      in std_logic;
        out_data: out std_logic_vector(7 downto 0);
    );
end data_input_selector;

architecture structural of data_input_selector is
    component xnor_2x1
        port (
            A      : in  STD_LOGIC; -- Input 0
            B      : in  STD_LOGIC; -- Input 1
            output : out STD_LOGIC  -- Output of the XNOR gate
        );
    end component;

    component mux_2x1_8bit
        port( 
            A      : in  STD_LOGIC_VECTOR(7 downto 0); -- Input 0 (8 bits)
            B      : in  STD_LOGIC_VECTOR(7 downto 0); -- Input 1 (8 bits)
            sel    : in  STD_LOGIC;                    -- sel signal
            output : out STD_LOGIC_VECTOR(7 downto 0)  -- Output of the multiplexer (8 bits)
        );
    end component;

    component inverter
        port(
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component and_2x1
        port(
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for and_1: and_2x1 use entity work.and_2x1(structural);

    for inv_1: inverter use entity work.inverter(structural);

    for xnor_1: xnor_2x1 use entity work.xnor_2x1(structural);

    for mux: mux_2x1_8bit use entity work.mux_2x1_8bit(structural);

    signal check_valid, check_read, check_write: std_logic;
    signal RW_inv, hit_miss_inv: std_logic;

begin
    and_1: and_2x1 port map (check_valid, R_W, check_read);
    --and_2: and2x1 port map (check_valid, RW_inv, check_write);

    xnor_1: xnor_2x1 port map (hit_miss_inv, R_W, check_valid);

    inv_1: inverter port map (hit_miss, hit_miss_inv);
   -- inv_2: inverter port map (R_W, RW_inv);

    mux: mux_2x1_8bit port map(cpu_data, mem_data, check_read, out_data);

end architecture structural;



