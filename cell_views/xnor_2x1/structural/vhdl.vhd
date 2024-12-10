-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:57:48 2024


architecture Structural of xnor_2x1 is

    -- Declare components for XOR and NOT gates
    component xor_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component inverter
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for xor_gate: xor_2x1 use entity work.xor_2x1(Structural);
    for not_gate: inverter use entity work.inverter(Structural);

    -- Intermediate signal to hold the result of XOR operation
    signal xor_out : STD_LOGIC;

begin
    -- Instantiate the XOR gate to calculate A xor B
    xor_gate: xor_2x1
    port map (
        A      => A,
        B      => B,
        output => xor_out
    );

    -- Instantiate the NOT gate to invert the XOR result
    not_gate: inverter
    port map (
        input  => xor_out,
        output => output
    );

end Structural;
