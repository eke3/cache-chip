-- or_2x1.vhd

library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.all;

entity or_2x1 is
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end or_2x1;

architecture Structural of or_2x1 is

    component inverter
    port (
        input  : in  std_logic;     -- Input
        output : out std_logic      -- Output
    );
    end component;

    component nor_2x1
        port (
            A      : in  std_logic;     -- First input
            B      : in  std_logic;     -- Second input
            output : out std_logic      -- OR output
        );
    end component;

    for all: inverter use entity work.inverter(Structural);
    for all: nor_2x1 use entity work.nor_2x1(Structural);

    signal nor_out : std_logic; -- Intermediate signals

begin
    -- Instantiate the nor_2x1 gate
    nor1: nor_2x1
    port map (
        A      => A,
        B      => B,
        output => nor_out
    );

    -- Instantiate the inverter gate
    inv1: inverter
    port map (
        input  => nor_out,
        output => output
    );

end Structural;
