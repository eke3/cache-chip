library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nor_2x1 is
    port (
        A      : in  std_logic; -- First input
        B      : in  std_logic; -- Second input
        output : out std_logic -- NOR output
    );
end entity nor_2x1;

architecture Structural of nor_2x1 is

    component inverter is
        port (
            input  : in  std_logic;     -- Input
            output : out std_logic      -- Output
        );
    end component inverter;

    component or_2x1 is
        port (
            A      : in  std_logic;     -- First input
            B      : in  std_logic;     -- Second input
            output : out std_logic      -- OR output
        );
    end component or_2x1;

    signal or_out, nor_out : std_logic; -- Intermediate signal for OR operation
begin

    or_gate: entity work.or_2x1(Structural)
    port map (
        A      => A,
        B      => B,
        output => or_out
    );

    inverter_gate: entity work.inverter(Structural)
    port map (
        input  => or_out,
        output => nor_out
    );

    output <= nor_out;

end architecture Structural;
