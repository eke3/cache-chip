-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 14:04:44 2024


architecture Structural of sr_latch is

    -- Declare the nor_2x1 component
    component nor_2x1
        port (
            A      : in  std_logic; -- Input A
            B      : in  std_logic; -- Input B
            output : out std_logic  -- NOR output
        );
    end component;

    for nor1, nor2: nor_2x1 use entity work.nor_2x1(Structural);

begin
    -- First NOR gate for Q
    nor1: nor_2x1
    port map (
        A      => R,
        B      => Qn,
        output => Q
    );

    -- Second NOR gate for Qn
    nor2: nor_2x1
    port map (
        A      => S,
        B      => Q,
        output => Qn
    );

end Structural;
