-- Entity: demux_1x2_8bit
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x2_8bit is
    port (
        data_in    : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input data
        sel        : in  STD_LOGIC; -- 1-bit selector
        data_out_1 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "0"
        data_out_2 : out STD_LOGIC_VECTOR(7 downto 0) -- 8-bit output for selection "1"
    );
end entity demux_1x2_8bit;

architecture Structural of demux_1x2_8bit is
    -- Declare the demux_1x2 component
    component demux_1x2 is
        port (
            data_in    : in  STD_LOGIC;  -- 1-bit input data
            sel        : in  STD_LOGIC;  -- 1-bit selector
            data_out_1 : out STD_LOGIC;  -- Output for selection "0"
            data_out_2 : out STD_LOGIC   -- Output for selection "1"
        );
    end component demux_1x2;

    -- For demux_1x2 instances, one for each bit of the 8-bit input
    --    for demux_bit: demux_1x2 use entity work.demux_1x2(structural);

begin
    -- Instantiate eight instances of demux_1x2 for each bit of the 8-bit input
    gen_demux: for i in 0 to 7 generate
        demux: entity work.demux_1x2(structural)
        port map (
            data_in    => data_in(i),    -- Connect each bit of data_in to a demux_1x2
            sel        => sel,           -- Shared 1-bit selector
            data_out_1 => data_out_1(i), -- Route output to the corresponding bit in data_out_1
            data_out_2 => data_out_2(i)  -- Route output to the corresponding bit in data_out_2
        );
    end generate;

end architecture Structural;
