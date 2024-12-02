-- Entity: demux_1x16_8bit
-- Architecture: Structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x16_8bit is
    port (
        data_in     : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input data
        sel         : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit selector (S3, S2, S1, S0)
        data_out_0  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0000"
        data_out_1  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0001"
        data_out_2  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0010"
        data_out_3  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0011"
        data_out_4  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0100"
        data_out_5  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0101"
        data_out_6  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0110"
        data_out_7  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0111"
        data_out_8  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1000"
        data_out_9  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1001"
        data_out_10 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1010"
        data_out_11 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1011"
        data_out_12 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1100"
        data_out_13 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1101"
        data_out_14 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1110"
        data_out_15 : out STD_LOGIC_VECTOR(7 downto 0)  -- Output for selection "1111"
    );
end demux_1x16_8bit;

architecture Structural of demux_1x16_8bit is
    -- Declare the demux_1x16 component
    component demux_1x16 
        port (
            data_in     : in  STD_LOGIC;                    -- 1-bit input data
            sel         : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit selector (S3, S2, S1, S0)
            data_out_0  : out STD_LOGIC;                    -- Output for selection "0000"
            data_out_1  : out STD_LOGIC;                    -- Output for selection "0001"
            data_out_2  : out STD_LOGIC;                    -- Output for selection "0010"
            data_out_3  : out STD_LOGIC;                    -- Output for selection "0011"
            data_out_4  : out STD_LOGIC;                    -- Output for selection "0100"
            data_out_5  : out STD_LOGIC;                    -- Output for selection "0101"
            data_out_6  : out STD_LOGIC;                    -- Output for selection "0110"
            data_out_7  : out STD_LOGIC;                    -- Output for selection "0111"
            data_out_8  : out STD_LOGIC;                    -- Output for selection "1000"
            data_out_9  : out STD_LOGIC;                    -- Output for selection "1001"
            data_out_10 : out STD_LOGIC;                    -- Output for selection "1010"
            data_out_11 : out STD_LOGIC;                    -- Output for selection "1011"
            data_out_12 : out STD_LOGIC;                    -- Output for selection "1100"
            data_out_13 : out STD_LOGIC;                    -- Output for selection "1101"
            data_out_14 : out STD_LOGIC;                    -- Output for selection "1110"
            data_out_15 : out STD_LOGIC                     -- Output for selection "1111"
        );
    end component;

    for demux: demux_1x16 use entity work.demux_1x16(Structural);

begin
    -- Generate block to instantiate demux_1x16 for each bit of the 8-bit input data
    gen_demux_1x16: for i in 0 to 7 generate
        -- Instantiate demux_1x16 for each bit of data_in
        demux: demux_1x16
        port map (
            data_in     => data_in(i),                      -- i-th bit of the input data
            sel         => sel,                             -- 4-bit selector
            data_out_0  => data_out_0(i),                   -- Output for selection "0000"
            data_out_1  => data_out_1(i),                   -- Output for selection "0001"
            data_out_2  => data_out_2(i),                   -- Output for selection "0010"
            data_out_3  => data_out_3(i),                   -- Output for selection "0011"
            data_out_4  => data_out_4(i),                   -- Output for selection "0100"
            data_out_5  => data_out_5(i),                   -- Output for selection "0101"
            data_out_6  => data_out_6(i),                   -- Output for selection "0110"
            data_out_7  => data_out_7(i),                   -- Output for selection "0111"
            data_out_8  => data_out_8(i),                   -- Output for selection "1000"
            data_out_9  => data_out_9(i),                   -- Output for selection "1001"
            data_out_10 => data_out_10(i),                  -- Output for selection "1010"
            data_out_11 => data_out_11(i),                  -- Output for selection "1011"
            data_out_12 => data_out_12(i),                  -- Output for selection "1100"
            data_out_13 => data_out_13(i),                  -- Output for selection "1101"
            data_out_14 => data_out_14(i),                  -- Output for selection "1110"
            data_out_15 => data_out_15(i)                   -- Output for selection "1111"
        );
    end generate;

end Structural;

