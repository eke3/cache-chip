-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 12:52:17 2024


architecture Structural of demux_1x16 is
    -- Declare the demux_1x2 and demux_1x8 components
    component demux_1x2
        port (
            data_in    : in  STD_LOGIC;                    -- 1-bit input data
            sel        : in  STD_LOGIC;                    -- 1-bit selector
            data_out_1 : out STD_LOGIC;                    -- Output for selection "0"
            data_out_2 : out STD_LOGIC                     -- Output for selection "1"
        );
    end component;

    component demux_1x8
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
    end component;

    -- Internal signals for the 2 outputs from the 1x2 demux
    signal demux_out_1 : STD_LOGIC;                        -- Output from first demux_1x2
    signal demux_out_2 : STD_LOGIC;                        -- Output from second demux_1x2

    -- Component binding
    for all : demux_1x2 use entity work.demux_1x2(Structural);
    for all : demux_1x8 use entity work.demux_1x8(Structural);

begin
    -- Instantiate the demux_1x2 to split data based on S3
    demux_1x2_inst: demux_1x2
    port map (
        data_in    => data_in,                             -- Input data
        sel        => sel(3),                              -- Select bit S3
        data_out_1 => demux_out_1,                         -- First output
        data_out_2 => demux_out_2                          -- Second output
    );

    -- Instantiate the first demux_1x8 for the lower part (S2, S1, S0 = 000 to 111)
    demux_1x8_inst_1: demux_1x8
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
    demux_1x8_inst_2: demux_1x8
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

end Structural;
