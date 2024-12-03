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

    for all: mux_2x1 use entity work.mux_2x1(Structural);

    signal mux_out : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Instantiate the mux_2x1 for each bit
    mux_2x1_inst_0: mux_2x1
    port map (
        A      => A(0),
        B      => B(0),
        sel    => sel,
        output => mux_out(0)
    );

    mux_2x1_inst_1: mux_2x1
    port map (
        A      => A(1),
        B      => B(1),
        sel    => sel,
        output => mux_out(1)
    );

    mux_2x1_inst_2: mux_2x1
    port map (
        A      => A(2),
        B      => B(2),
        sel    => sel,
        output => mux_out(2)
    );

    mux_2x1_inst_3: mux_2x1
    port map (
        A      => A(3),
        B      => B(3),
        sel    => sel,
        output => mux_out(3)
    );

    mux_2x1_inst_4: mux_2x1
    port map (
        A      => A(4),
        B      => B(4),
        sel    => sel,
        output => mux_out(4)
    );

    mux_2x1_inst_5: mux_2x1
    port map (
        A      => A(5),
        B      => B(5),
        sel    => sel,
        output => mux_out(5)
    );

    mux_2x1_inst_6: mux_2x1
    port map (
        A      => A(6),
        B      => B(6),
        sel    => sel,
        output => mux_out(6)
    );

    mux_2x1_inst_7: mux_2x1
    port map (
        A      => A(7),
        B      => B(7),
        sel    => sel,
        output => mux_out(7)
    );

    output <= mux_out;

end Structural;

