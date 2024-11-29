-- Entity: demux_1x4_8bit
-- Architecture: Structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x4_8bit is
    port (
        data_in    : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input data
        sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector
        data_out_0 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "00"
        data_out_1 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "01"
        data_out_2 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "10"
        data_out_3 : out STD_LOGIC_VECTOR(7 downto 0) -- 8-bit output for selection "11"
    );
end entity demux_1x4_8bit;

architecture Structural of demux_1x4_8bit is
    -- Declare the demux_1x4 component
    component demux_1x4 is
        port (
            data_in    : in  STD_LOGIC;                    -- 1-bit input data
            sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector
            data_out_0 : out STD_LOGIC;                    -- Output for selection "00"
            data_out_1 : out STD_LOGIC;                    -- Output for selection "01"
            data_out_2 : out STD_LOGIC;                    -- Output for selection "10"
            data_out_3 : out STD_LOGIC                     -- Output for selection "11"
        );
    end component demux_1x4;

begin
    -- Generate loop to instantiate eight instances of demux_1x4 for each bit of the 8-bit input
    gen_demux: for i in 0 to 7 generate
        demux: entity work.demux_1x4(Structural)
        port map (
            data_in    => data_in(i),                      -- Connect each bit of data_in to a demux_1x4
            sel        => sel,                             -- Shared 2-bit selector
            data_out_0 => data_out_0(i),                   -- Each demux_1x4 outputs to respective bit position in data_out_x
            data_out_1 => data_out_1(i),
            data_out_2 => data_out_2(i),
            data_out_3 => data_out_3(i)
        );
    end generate;

end architecture Structural;
