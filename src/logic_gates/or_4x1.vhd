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
end or_4x1;

architecture Structural of or_4x1 is

    component or_3x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component or_2x1 
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for all: or_3x1 use entity work.or_3x1(Structural);
    for all: or_2x1 use entity work.or_2x1(Structural);

    signal or_3x1_out, or_4x1_out : STD_LOGIC; -- Intermediate signal for OR operation

begin

    or_1: or_3x1
    port map (
        A      => A,
        B      => B,
        C      => C,
        output => or_3x1_out
    );

    or_2: or_2x1
    port map (
        A      => D,
        B      => or_3x1_out,
        output => or_4x1_out
    );

    output <= or_4x1_out;

end Structural;
