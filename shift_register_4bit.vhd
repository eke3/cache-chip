-- Entity: shift_register_4bit
-- Architecture: Structural

library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_4bit is
    port (
        d : in  std_logic;
        clk : in  std_logic;
        reset : in  std_logic;
        q : out std_logic_vector(3 downto 0)
    );
end entity shift_register_4bit;

architecture structural of shift_register_4bit is
    component dff_negedge is
        port ( d   : in  std_logic;
               clk : in  std_logic;
               q   : out std_logic;
               qbar: out std_logic
             );
    end component dff_negedge;

    component mux_2x1 is
        port (
            A      : in  STD_LOGIC; -- Input 0
            B      : in  STD_LOGIC; -- Input 1
            sel    : in  STD_LOGIC; -- sel signal
            output : out STD_LOGIC -- Output of the multiplexer
        );
    end component mux_2x1;

    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    signal ff1_out, ff2_out, ff3_out, ff4_out : std_logic;
    signal not_reset : std_logic;
    signal low_wire : std_logic := '0';
    signal ff1_mux_in, ff2_mux_in, ff3_mux_in, ff4_mux_in : std_logic;


begin

    mux1 : component mux_2x1
        port map (
            A      => low_wire,
            B      => d,
            sel    => not_reset,
            output => ff1_mux_in
        );
    mux2 : component mux_2x1
        port map (
            A      => low_wire,
            B      => ff1_out,
            sel    => not_reset,
            output => ff2_mux_in
        );
    mux3 : component mux_2x1
        port map (
            A      => low_wire,
            B      => ff2_out,
            sel    => not_reset,
            output => ff3_mux_in
        );
    mux4 : component mux_2x1
        port map (
            A      => low_wire,
            B      => ff3_out,
            sel    => not_reset,
            output => ff4_mux_in
        );
    
    reset_inverter : component inverter
        port map (
            input  => reset,
            output => not_reset
        );

    ff1: component dff_negedge
        port map (
            d    => ff1_mux_in,
            clk  => clk,
            q    => ff1_out,
            qbar => open
        );
    ff2: component dff_negedge
        port map (
            d    => ff2_mux_in,
            clk  => clk,
            q    => ff2_out,
            qbar => open
        );
    ff3: component dff_negedge
        port map (
            d    => ff3_mux_in,
            clk  => clk,
            q    => ff3_out,
            qbar => open
        );
    ff4: component dff_negedge
        port map (
            d    => ff4_mux_in,
            clk  => clk,
            q    => ff4_out,
            qbar => open
        );
        
    q(3) <= ff1_out;
    q(2) <= ff2_out;
    q(1) <= ff3_out;
    q(0) <= ff4_out;

end architecture structural;