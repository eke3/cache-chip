library IEEE;
use IEEE.std_logic_1164.all;

-- Entity for a simple 1-bit buffer
entity buffer_1bit is
    port (
        in_bit  : in  std_logic; -- Input bit
        out_bit : out std_logic -- Output bit
    );
end entity buffer_1bit;

-- Architecture for the 1-bit buffer
architecture Structural of buffer_1bit is
begin
    -- Simply pass the input to the output
    out_bit <= in_bit;
end architecture Structural;
