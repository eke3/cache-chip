-- Entity: mux_16x1
-- Architecture: structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1 is
    port (
        inputs : in  STD_LOGIC_VECTOR(15 downto 0);  -- 16-bit input vector
        sel    : in  STD_LOGIC_VECTOR(3 downto 0);   -- 4-bit select signal
        output : out STD_LOGIC                        -- Output of the multiplexer
    );
end entity mux_16x1;

architecture Structural of mux_16x1 is

    -- Declare the and_2x1 component
    component and_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_2x1;

    -- Declare the or_2x1 component
    component or_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_2x1;

    -- Intermediate signals for the outputs of AND gates
    signal and_out : STD_LOGIC_VECTOR(15 downto 0);  -- For each AND gate's output
    signal sel_not : STD_LOGIC_VECTOR(3 downto 0);   -- Inverted select signals
    
begin

    -- Generate the inverted select signals
    sel_not(0) <= not sel(0);
    sel_not(1) <= not sel(1);
    sel_not(2) <= not sel(2);
    sel_not(3) <= not sel(3);

    -- Generate the AND gates for each input based on the select signals
    gen_and: for i in 0 to 15 generate
        and_gate: component and_2x1
        port map (
            A      => inputs(i),
            B      => sel(i),         -- Use select signal bits
            output => and_out(i)
        );
    end generate;

    -- Combine the AND gates' outputs using OR gates to create the final output
    or_gate: component or_2x1
        port map (
            A      => and_out(0),
            B      => and_out(1),
            output => output
        );

end architecture Structural;