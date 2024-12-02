-- and_2x1.vhd

library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.all;

entity and_2x1 is
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end and_2x1;

architecture Structural of and_2x1 is

    component inverter
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component nand_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for all: inverter use entity work.inverter(Structural);
    for all: nand_2x1 use entity work.nand_2x1(Structural);

    signal nand_out : STD_LOGIC;

begin

    nand_gate : nand_2x1
        port map (A => A, B => B, output => nand_out);

    inverter_gate : inverter
        port map (input => nand_out, output => output);

end Structural;
