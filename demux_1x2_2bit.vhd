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
            data_in    : in  STD_LOGIC;  -- 1-bit input data
            sel        : in  STD_LOGIC;  -- 1-bit selector
            data_out_1 : out STD_LOGIC;  -- Output for selection "0"
            data_out_2 : out STD_LOGIC   -- Output for selection "1"
        );
    end component demux_1x2;

begin
    -- Instantiate demux_1x2 for each bit of data_in
    gen_demux: for i in 0 to 1 generate
        demux_bit: entity work.demux_1x2
        port map (
            data_in    => data_in(i),    -- i-th bit of the 2-bit data_in
            sel        => sel,           -- 1-bit selector
            data_out_1 => data_out_1(i), -- Output for selection "0"
            data_out_2 => data_out_2(i)  -- Output for selection "1"
        );
    end generate;

end architecture Structural;
