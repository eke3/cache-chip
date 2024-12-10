-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:55:16 2024


architecture Structural of demux_1x4_2bit is
    -- Declare the components for demux_1x4
    component demux_1x4
        port (
            data_in    : in  STD_LOGIC;
            sel        : in  STD_LOGIC_VECTOR(1 downto 0);
            data_out_3 : out STD_LOGIC;
            data_out_2 : out STD_LOGIC;
            data_out_1 : out STD_LOGIC;
            data_out_0 : out STD_LOGIC
        );
    end component;

    -- Component binding statements
    for all : demux_1x4 use entity work.demux_1x4(Structural);

begin
    -- Instantiate the demux_1x4 components for both bits of data_in
    demux_0: demux_1x4
    port map (
        data_in    => data_in(0),
        sel        => sel,
        data_out_3 => data_out_3(0),
        data_out_2 => data_out_2(0),
        data_out_1 => data_out_1(0),
        data_out_0 => data_out_0(0)
    );

    demux_1: demux_1x4
    port map (
        data_in    => data_in(1),
        sel        => sel,
        data_out_3 => data_out_3(1),
        data_out_2 => data_out_2(1),
        data_out_1 => data_out_1(1),
        data_out_0 => data_out_0(1)
    );

end Structural;
