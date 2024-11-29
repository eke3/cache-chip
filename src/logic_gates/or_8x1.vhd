-- or_8x1.vhd

library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.all;

entity or_8x1 is
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        C      : in  STD_LOGIC;
        D      : in  STD_LOGIC;
        E      : in  STD_LOGIC;
        F      : in  STD_LOGIC;
        G      : in  STD_LOGIC;
        H      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end entity or_8x1;

architecture Structural of or_8x1 is

    component or_4x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            D      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_4x1;

    component or_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_2x1;

    signal or_4x1_out1, or_4x1_out2, or_8x1_out : STD_LOGIC; -- Intermediate signal for OR operation

begin

    or_1: entity work.or_4x1(Structural)
    port map (
        A      => A,
        B      => B,
        C      => C,
        D      => D,
        output => or_4x1_out1
    );

    or_2: entity work.or_4x1(Structural)
    port map (
        A      => E,
        B      => F,
        C      => G,
        D      => H,
        output => or_4x1_out2
    );

    or_3: entity work.or_2x1(Structural)
    port map (
        A      => or_4x1_out1,
        B      => or_4x1_out2,
        output => or_8x1_out
    );

    output <= or_8x1_out;

end architecture Structural;
