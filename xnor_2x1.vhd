library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Entity declaration
entity xnor_2x1 is
    port (
        A      : in  STD_LOGIC; -- Input 0
        B      : in  STD_LOGIC; -- Input 1
        output : out STD_LOGIC  -- Output of the XNOR gate
    );
end entity xnor_2x1;

-- Architecture: structural
architecture structural of xnor_2x1 is

    -- Declare components for XOR and NOT gates
    component xor_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    -- Intermediate signal to hold the result of XOR operation
    signal xor_out : STD_LOGIC;

begin

    -- Instantiate the XOR gate to calculate A xor B
    xor_gate: xor_2x1
        port map (
            A      => A,
            B      => B,
            output => xor_out
        );

    -- Instantiate the NOT gate to invert the XOR result
    not_gate: inverter
        port map (
            input  => xor_out,
            output => output
        );

end architecture structural;