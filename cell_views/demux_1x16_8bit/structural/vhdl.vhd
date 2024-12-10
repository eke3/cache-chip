-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:55:16 2024


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

    for all: demux_1x16 use entity work.demux_1x16(Structural);

begin
    -- Generate block to instantiate demux_1x16 for each bit of the 8-bit input data
    demux_0: demux_1x16
    port map (
        data_in     => data_in(0),
        sel         => sel,
        data_out_0  => data_out_0(0),
        data_out_1  => data_out_1(0),
        data_out_2  => data_out_2(0),
        data_out_3  => data_out_3(0),
        data_out_4  => data_out_4(0),
        data_out_5  => data_out_5(0),
        data_out_6  => data_out_6(0),
        data_out_7  => data_out_7(0),
        data_out_8  => data_out_8(0),
        data_out_9  => data_out_9(0),
        data_out_10 => data_out_10(0),
        data_out_11 => data_out_11(0),
        data_out_12 => data_out_12(0),
        data_out_13 => data_out_13(0),
        data_out_14 => data_out_14(0),
        data_out_15 => data_out_15(0)
    );

    demux_1: demux_1x16
    port map (
        data_in     => data_in(1),
        sel         => sel,
        data_out_0  => data_out_0(1),
        data_out_1  => data_out_1(1),
        data_out_2  => data_out_2(1),
        data_out_3  => data_out_3(1),
        data_out_4  => data_out_4(1),
        data_out_5  => data_out_5(1),
        data_out_6  => data_out_6(1),
        data_out_7  => data_out_7(1),
        data_out_8  => data_out_8(1),
        data_out_9  => data_out_9(1),
        data_out_10 => data_out_10(1),
        data_out_11 => data_out_11(1),
        data_out_12 => data_out_12(1),
        data_out_13 => data_out_13(1),
        data_out_14 => data_out_14(1),
        data_out_15 => data_out_15(1)
    );

    demux_2: demux_1x16
    port map (
        data_in     => data_in(2),
        sel         => sel,
        data_out_0  => data_out_0(2),
        data_out_1  => data_out_1(2),
        data_out_2  => data_out_2(2),
        data_out_3  => data_out_3(2),
        data_out_4  => data_out_4(2),
        data_out_5  => data_out_5(2),
        data_out_6  => data_out_6(2),
        data_out_7  => data_out_7(2),
        data_out_8  => data_out_8(2),
        data_out_9  => data_out_9(2),
        data_out_10 => data_out_10(2),
        data_out_11 => data_out_11(2),
        data_out_12 => data_out_12(2),
        data_out_13 => data_out_13(2),
        data_out_14 => data_out_14(2),
        data_out_15 => data_out_15(2)
    );

    demux_3: demux_1x16
    port map (
        data_in     => data_in(3),
        sel         => sel,
        data_out_0  => data_out_0(3),
        data_out_1  => data_out_1(3),
        data_out_2  => data_out_2(3),
        data_out_3  => data_out_3(3),
        data_out_4  => data_out_4(3),
        data_out_5  => data_out_5(3),
        data_out_6  => data_out_6(3),
        data_out_7  => data_out_7(3),
        data_out_8  => data_out_8(3),
        data_out_9  => data_out_9(3),
        data_out_10 => data_out_10(3),
        data_out_11 => data_out_11(3),
        data_out_12 => data_out_12(3),
        data_out_13 => data_out_13(3),
        data_out_14 => data_out_14(3),
        data_out_15 => data_out_15(3)
    );

    demux_4: demux_1x16
    port map (
        data_in     => data_in(4),
        sel         => sel,
        data_out_0  => data_out_0(4),
        data_out_1  => data_out_1(4),
        data_out_2  => data_out_2(4),
        data_out_3  => data_out_3(4),
        data_out_4  => data_out_4(4),
        data_out_5  => data_out_5(4),
        data_out_6  => data_out_6(4),
        data_out_7  => data_out_7(4),
        data_out_8  => data_out_8(4),
        data_out_9  => data_out_9(4),
        data_out_10 => data_out_10(4),
        data_out_11 => data_out_11(4),
        data_out_12 => data_out_12(4),
        data_out_13 => data_out_13(4),
        data_out_14 => data_out_14(4),
        data_out_15 => data_out_15(4)
    );

    demux_5: demux_1x16
    port map (
        data_in     => data_in(5),
        sel         => sel,
        data_out_0  => data_out_0(5),
        data_out_1  => data_out_1(5),
        data_out_2  => data_out_2(5),
        data_out_3  => data_out_3(5),
        data_out_4  => data_out_4(5),
        data_out_5  => data_out_5(5),
        data_out_6  => data_out_6(5),
        data_out_7  => data_out_7(5),
        data_out_8  => data_out_8(5),
        data_out_9  => data_out_9(5),
        data_out_10 => data_out_10(5),
        data_out_11 => data_out_11(5),
        data_out_12 => data_out_12(5),
        data_out_13 => data_out_13(5),
        data_out_14 => data_out_14(5),
        data_out_15 => data_out_15(5)
    );

    demux_6: demux_1x16
    port map (
        data_in     => data_in(6),
        sel         => sel,
        data_out_0  => data_out_0(6),
        data_out_1  => data_out_1(6),
        data_out_2  => data_out_2(6),
        data_out_3  => data_out_3(6),
        data_out_4  => data_out_4(6),
        data_out_5  => data_out_5(6),
        data_out_6  => data_out_6(6),
        data_out_7  => data_out_7(6),
        data_out_8  => data_out_8(6),
        data_out_9  => data_out_9(6),
        data_out_10 => data_out_10(6),
        data_out_11 => data_out_11(6),
        data_out_12 => data_out_12(6),
        data_out_13 => data_out_13(6),
        data_out_14 => data_out_14(6),
        data_out_15 => data_out_15(6)
    );

    demux_7: demux_1x16
    port map (
        data_in     => data_in(7),
        sel         => sel,
        data_out_0  => data_out_0(7),
        data_out_1  => data_out_1(7),
        data_out_2  => data_out_2(7),
        data_out_3  => data_out_3(7),
        data_out_4  => data_out_4(7),
        data_out_5  => data_out_5(7),
        data_out_6  => data_out_6(7),
        data_out_7  => data_out_7(7),
        data_out_8  => data_out_8(7),
        data_out_9  => data_out_9(7),
        data_out_10 => data_out_10(7),
        data_out_11 => data_out_11(7),
        data_out_12 => data_out_12(7),
        data_out_13 => data_out_13(7),
        data_out_14 => data_out_14(7),
        data_out_15 => data_out_15(7)
    );

end Structural;
