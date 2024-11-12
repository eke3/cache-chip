-- Entity: demux_1x8_8bit
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x8_8bit is
    port (
        data_in    : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input data
        sel        : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit selector
        data_out_0 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "000"
        data_out_1 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "001"
        data_out_2 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "010"
        data_out_3 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "011"
        data_out_4 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "100"
        data_out_5 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "101"
        data_out_6 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "110"
        data_out_7 : out STD_LOGIC_VECTOR(7 downto 0) -- 8-bit output for selection "111"
    );
end entity demux_1x8_8bit;

architecture Structural of demux_1x8_8bit is
    -- Declare the demux_1x8 component
    component demux_1x8 is
        port (
            data_in    : in  STD_LOGIC;                    -- 1-bit input data
            sel        : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit selector
            data_out_0 : out STD_LOGIC;                    -- Output for selection "000"
            data_out_1 : out STD_LOGIC;                    -- Output for selection "001"
            data_out_2 : out STD_LOGIC;                    -- Output for selection "010"
            data_out_3 : out STD_LOGIC;                    -- Output for selection "011"
            data_out_4 : out STD_LOGIC;                    -- Output for selection "100"
            data_out_5 : out STD_LOGIC;                    -- Output for selection "101"
            data_out_6 : out STD_LOGIC;                    -- Output for selection "110"
            data_out_7 : out STD_LOGIC                     -- Output for selection "111"
        );
    end component demux_1x8;

    for demux: demux_1x8 use entity work.demux_1x8(structural);

begin
    -- Instantiate eight instances of demux_1x8 for each bit of the 8-bit input
    gen_demux: for i in 0 to 7 generate
        demux: component demux_1x8
        port map (
            data_in    => data_in(i),                      -- Connect each bit of data_in to a demux_1x8
            sel        => sel,                             -- Shared 3-bit selector
            data_out_0 => data_out_0(i),                   -- Each demux_1x8 outputs to respective bit position in data_out_x
            data_out_1 => data_out_1(i),
            data_out_2 => data_out_2(i),
            data_out_3 => data_out_3(i),
            data_out_4 => data_out_4(i),
            data_out_5 => data_out_5(i),
            data_out_6 => data_out_6(i),
            data_out_7 => data_out_7(i)
        );
    end generate;

end architecture Structural;
