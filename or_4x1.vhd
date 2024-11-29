-- or_4x1.vhd

library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.all;

entity or_4x1 is
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        C      : in  STD_LOGIC;
        D      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end entity or_4x1;

architecture Structural of or_4x1 is

    component or_3x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_3x1;

    component or_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_2x1;

    signal or_3x1_out, or_4x1_out : STD_LOGIC; -- Intermediate signal for OR operation

begin

    or_1: entity work.or_3x1(Structural)
    port map (
        A      => A,
        B      => B,
        C      => C,
        output => or_3x1_out
    );

    or_2: entity work.or_2x1(Structural)
    port map (
        A      => D,
        B      => or_3x1_out,
        output => or_4x1_out
    );

    output <= or_4x1_out;

end architecture Structural;
