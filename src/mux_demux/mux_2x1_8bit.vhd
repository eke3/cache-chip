-- Entity: mux_2x1_8bit
-- Architecture: Structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_2x1_8bit is
    port (
        A      : in  STD_LOGIC_VECTOR(7 downto 0); -- Input 0 (8 bits)
        B      : in  STD_LOGIC_VECTOR(7 downto 0); -- Input 1 (8 bits)
        sel    : in  STD_LOGIC; -- sel signal
        output : out STD_LOGIC_VECTOR(7 downto 0) -- Output of the multiplexer (8 bits)
    );
end mux_2x1_8bit;

architecture Structural of mux_2x1_8bit is
    -- Declare the mux_2x1 component
    component mux_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            sel    : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for mux_2x1_inst: mux_2x1 use entity work.mux_2x1(Structural);

    signal mux_out : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Instantiate the mux_2x1 for each bit
    gen_mux_2x1: for i in 0 to 7 generate
        mux_2x1_inst: mux_2x1
        port map (
            A      => A(i),
            B      => B(i),
            sel    => sel,
            output => mux_out(i)
        );
    end generate;

    output <= mux_out;

end Structural;

