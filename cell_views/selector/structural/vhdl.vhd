-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:58:21 2024


architecture Structural of selector is
    component and_2x1 
        port (
            A      : in  std_logic;
            B      : in  std_logic;
            output : out std_logic
        );
    end component;

    component inverter 
        port (
            input  : in  std_logic;
            output : out std_logic
        );
    end component;

    for all: and_2x1 use entity work.and_2x1(Structural);
    for all: inverter use entity work.inverter(Structural);

    signal write_inv : std_logic;

begin
    and_1: and_2x1
    port map (
        A      => chip_enable,
        B      => RW,
        output => read_enable
    );

    inverter_1: inverter
    port map (
        input  => RW,
        output => write_inv
    );

    and_2: and_2x1
    port map (
        A      => chip_enable,
        B      => write_inv,
        output => write_enable
    );

end Structural;
