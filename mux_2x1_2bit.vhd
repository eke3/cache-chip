-- Entity: mux_2x1_2bit
-- Architecture: Structural

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_2x1_2bit is
    port (
        A      : in  STD_LOGIC_VECTOR(1 downto 0); -- Input 0
        B      : in  STD_LOGIC_VECTOR(1 downto 0); -- Input 1
        sel    : in  STD_LOGIC; -- sel signal
        output : out STD_LOGIC_VECTOR(1 downto 0) -- Output of the multiplexer
    );
end entity mux_2x1_2bit;

architecture Structural of mux_2x1_2bit is
    -- Declare the mux_2x1 component
    component mux_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            sel    : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component mux_2x1;

    signal out_wire : STD_LOGIC_VECTOR(1 downto 0);

begin

    -- Instantiate the first mux_2x1 for the lower bit
    mux_2x1_inst0: entity work.mux_2x1(Structural)
    port map (
        A      => A(0),
        B      => B(0),
        sel    => sel,
        output => out_wire(0)
    );

    -- Instantiate the second mux_2x1 for the higher bit
    mux_2x1_inst1: entity work.mux_2x1(Structural)
    port map (
        A      => A(1),
        B      => B(1),
        sel    => sel,
        output => out_wire(1)
    );

    output <= out_wire;

end architecture Structural;

