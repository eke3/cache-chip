-- Entity: demux_1x16
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x16 is
    port (
        data_in     : in  STD_LOGIC; -- 1-bit input data
        sel         : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit selector (S3, S2, S1, S0)
        data_out_0  : out STD_LOGIC; -- Output for selection "0000"
        data_out_1  : out STD_LOGIC; -- Output for selection "0001"
        data_out_2  : out STD_LOGIC; -- Output for selection "0010"
        data_out_3  : out STD_LOGIC; -- Output for selection "0011"
        data_out_4  : out STD_LOGIC; -- Output for selection "0100"
        data_out_5  : out STD_LOGIC; -- Output for selection "0101"
        data_out_6  : out STD_LOGIC; -- Output for selection "0110"
        data_out_7  : out STD_LOGIC; -- Output for selection "0111"
        data_out_8  : out STD_LOGIC; -- Output for selection "1000"
        data_out_9  : out STD_LOGIC; -- Output for selection "1001"
        data_out_10 : out STD_LOGIC; -- Output for selection "1010"
        data_out_11 : out STD_LOGIC; -- Output for selection "1011"
        data_out_12 : out STD_LOGIC; -- Output for selection "1100"
        data_out_13 : out STD_LOGIC; -- Output for selection "1101"
        data_out_14 : out STD_LOGIC; -- Output for selection "1110"
        data_out_15 : out STD_LOGIC -- Output for selection "1111"
    );
end entity demux_1x16;

architecture Structural of demux_1x16 is
    -- Declare the demux_1x2 and demux_1x8 components
    component demux_1x2 is
        port (
            data_in    : in  STD_LOGIC;                    -- 1-bit input data
            sel        : in  STD_LOGIC;                    -- 1-bit selector
            data_out_1 : out STD_LOGIC;                    -- Output for selection "0"
            data_out_2 : out STD_LOGIC                     -- Output for selection "1"
        );
    end component demux_1x2;

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

    -- Internal signals for the 2 outputs from the 1x2 demux
    signal demux_out_1 : STD_LOGIC;                        -- Output from first demux_1x2
    signal demux_out_2 : STD_LOGIC;                        -- Output from second demux_1x2

    -- Internal signals for each of the outputs from the two demux_1x8 components
    --signal out_0_1     : STD_LOGIC;                        -- Data routed to output 0 of the first demux_1x8
    --signal out_1_1     : STD_LOGIC;                        -- Data routed to output 1 of the first demux_1x8
    --signal out_2_1     : STD_LOGIC;                        -- Data routed to output 2 of the first demux_1x8
    --signal out_3_1     : STD_LOGIC;                        -- Data routed to output 3 of the first demux_1x8
    --signal out_4_1     : STD_LOGIC;                        -- Data routed to output 4 of the first demux_1x8
    --signal out_5_1     : STD_LOGIC;                        -- Data routed to output 5 of the first demux_1x8
    --signal out_6_1     : STD_LOGIC;                        -- Data routed to output 6 of the first demux_1x8
    --signal out_7_1     : STD_LOGIC;                        -- Data routed to output 7 of the first demux_1x8

    --signal out_0_2     : STD_LOGIC;                        -- Data routed to output 0 of the second demux_1x8
    --signal out_1_2     : STD_LOGIC;                        -- Data routed to output 1 of the second demux_1x8
    --signal out_2_2     : STD_LOGIC;                        -- Data routed to output 2 of the second demux_1x8
    --signal out_3_2     : STD_LOGIC;                        -- Data routed to output 3 of the second demux_1x8
    --signal out_4_2     : STD_LOGIC;                        -- Data routed to output 4 of the second demux_1x8
    --signal out_5_2     : STD_LOGIC;                        -- Data routed to output 5 of the second demux_1x8
    --signal out_6_2     : STD_LOGIC;                        -- Data routed to output 6 of the second demux_1x8
    --signal out_7_2     : STD_LOGIC;                        -- Data routed to output 7 of the second demux_1x8

    for demux_1x2_inst: demux_1x2 use entity work.demux_1x2(Structural);
    for demux_1x8_inst_1, demux_1x8_inst_2: demux_1x8 use entity work.demux_1x8(Structural);

begin
    -- Instantiate the demux_1x2 to split data based on S3
    demux_1x2_inst: component demux_1x2
    port map (
        data_in    => data_in,                             -- Input data
        sel        => sel(3),                              -- Select bit S3
        data_out_1 => demux_out_1,                         -- First output
        data_out_2 => demux_out_2                          -- Second output
    );

    -- Instantiate the first demux_1x8 for the lower part (S2, S1, S0 = 000 to 111)
    demux_1x8_inst_1: component demux_1x8
    port map (
        data_in    => demux_out_1,                         -- Data from first demux_1x2
        sel        => sel(2 downto 0),                     -- Select bits S2, S1, S0
        data_out_0 => data_out_0,                          -- Output for selection "000"
        data_out_1 => data_out_1,                          -- Output for selection "001"
        data_out_2 => data_out_2,                          -- Output for selection "010"
        data_out_3 => data_out_3,                          -- Output for selection "011"
        data_out_4 => data_out_4,                          -- Output for selection "100"
        data_out_5 => data_out_5,                          -- Output for selection "101"
        data_out_6 => data_out_6,                          -- Output for selection "110"
        data_out_7 => data_out_7                           -- Output for selection "111"
    );

    -- Instantiate the second demux_1x8 for the upper part (S2, S1, S0 = 000 to 111)
    demux_1x8_inst_2: component demux_1x8
    port map (
        data_in    => demux_out_2,                         -- Data from second demux_1x2
        sel        => sel(2 downto 0),                     -- Select bits S2, S1, S0
        data_out_0 => data_out_8,                          -- Output for selection "1000"
        data_out_1 => data_out_9,                          -- Output for selection "1001"
        data_out_2 => data_out_10,                         -- Output for selection "1010"
        data_out_3 => data_out_11,                         -- Output for selection "1011"
        data_out_4 => data_out_12,                         -- Output for selection "1100"
        data_out_5 => data_out_13,                         -- Output for selection "1101"
        data_out_6 => data_out_14,                         -- Output for selection "1110"
        data_out_7 => data_out_15                          -- Output for selection "1111"
    );

end architecture Structural;
