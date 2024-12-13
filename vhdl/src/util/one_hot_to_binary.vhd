-- Entity: one_hot_to_binary
-- Architecture: Structural

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Entity declaration for One-Hot to 2-Bit Converter
entity one_hot_to_binary is
    port (
        one_hot : in  STD_LOGIC_VECTOR(2 downto 0); -- One-hot encoded input
        binary  : out STD_LOGIC_VECTOR(1 downto 0) -- 2-bit binary output
    );
end one_hot_to_binary;

-- Architecture: Structural
architecture Structural of one_hot_to_binary is

    -- Component declarations for OR gates
    component or_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for all: or_2x1 use entity work.or_2x1(Structural);

begin
    -- Convert one-hot input to binary output

    -- Binary bit 1 (MSB): '1' if one_hot(2) or one_hot(3) is active
    or_gate_msb: or_2x1
    port map (
        A      => one_hot(1),
        B      => one_hot(2),
        output => binary(1)
    );

    -- Binary bit 0 (LSB): '1' if one_hot(1) or one_hot(3) is active
    or_gate_lsb: or_2x1
    port map (
        A      => one_hot(0),
        B      => one_hot(2),
        output => binary(0)
    );

end Structural;
