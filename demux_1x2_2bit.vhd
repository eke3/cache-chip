-- Entity: demux_1x2_2bit
-- Architecture: Structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x2_2bit is
    port (
        data_in    : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit input data
        sel        : in  STD_LOGIC; -- 1-bit selector
        data_out_1 : out STD_LOGIC_VECTOR(1 downto 0); -- Output for selection "0"
        data_out_2 : out STD_LOGIC_VECTOR(1 downto 0) -- Output for selection "1"
    );
end entity demux_1x2_2bit;

architecture Structural of demux_1x2_2bit is
    -- Declare the components for the 1-bit demux and 2-input AND gate
    component demux_1x2 is
        port (
            data_in    : in  STD_LOGIC; -- 1-bit input data
            sel        : in  STD_LOGIC; -- 1-bit selector
            data_out_1 : out STD_LOGIC; -- Output for selection "0"
            data_out_2 : out STD_LOGIC  -- Output for selection "1"
        );
    end component demux_1x2;

    -- Internal signals for the demux outputs
    signal demux_out_0 : STD_LOGIC_vector(1 downto 0);
    signal demux_out_1 : STD_LOGIC_vector(1 downto 0);

begin
    -- Instantiate demux_1x2 for each bit of data_in
    demux_bit_0: component demux_1x2
    port map (
        data_in    => data_in(0),       -- 1st bit of the 2-bit data_in
        sel        => sel,              -- 1-bit selector
        data_out_1 => demux_out_0(0),   -- Output for selection "0"
        data_out_2 => demux_out_1(0)    -- Output for selection "1"
    );

    demux_bit_1: component demux_1x2
    port map (
        data_in    => data_in(1),       -- 2nd bit of the 2-bit data_in
        sel        => sel,              -- 1-bit selector
        data_out_1 => demux_out_0(1),   -- Output for selection "0"
        data_out_2 => demux_out_1(1)    -- Output for selection "1"
    );

    -- Combine the outputs from both bits for data_out_1 and data_out_2
    data_out_1 <= demux_out_0;          -- Combine bit 0 and bit 1 for output 1
    data_out_2 <= demux_out_1;          -- Combine bit 0 and bit 1 for output 2

end architecture Structural;
