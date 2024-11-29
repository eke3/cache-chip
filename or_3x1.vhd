-- or_3x1.vhd

library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.all;

entity or_3x1 is
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        C      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end entity or_3x1;

architecture Structural of or_3x1 is

    component or_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_2x1;

    signal or_2x1_out, or_3x1_out : STD_LOGIC; -- Intermediate signal for OR operation

begin

    or_1: entity work.or_2x1(Structural)
    port map (
        A      => A,
        B      => B,
        output => or_2x1_out
    );

    or_2: entity work.or_2x1(Structural)
    port map (
        A      => or_2x1_out,
        B      => C,
        output => or_3x1_out
    );

    output <= or_3x1_out;

end architecture Structural;
