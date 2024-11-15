-- Entity: mux_16x1_8bit
-- Architecture: structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1_8bit is
    port (
        inputs : in  STD_LOGIC_VECTOR(127 downto 0);  -- 16 inputs, each 8-bit wide
        sel    : in  STD_LOGIC_VECTOR(15 downto 0);   -- 16-bit 1-hot select signal
        output : out STD_LOGIC_VECTOR(7 downto 0)     -- 8-bit output
    );
end entity mux_16x1_8bit;

architecture Structural of mux_16x1_8bit is

    -- Declare the and_2x1 component for individual bit selection
    component and_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_2x1;

    -- Declare the or_2x1 component to combine AND gates' outputs
    component or_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_2x1;

    -- Intermediate signals for the outputs of AND gates
    signal and_out : STD_LOGIC_VECTOR(15 downto 0);  -- For each AND gate's output
    signal selected_input : STD_LOGIC_VECTOR(7 downto 0);  -- Selected 8-bit input

begin

    -- Generate the AND gates for each input selection using 1-hot select signal
    gen_and: for i in 0 to 15 generate
        and_gate: component and_2x1
        port map (
            A      => inputs(7 + (i * 8)),  -- Selecting the 1st bit of the i-th input
            B      => sel(i),               -- Controlled by the 1-hot select signal (sel(i))
            output => and_out(i)
        );
    end generate;

    -- Combine the selected bits using OR gates
    or_gate: component or_2x1
        port map (
            A      => and_out(0),
            B      => and_out(1),
            output => selected_input(0)
        );

    -- Output the selected input
    output <= selected_input;

end architecture Structural;