library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_bit_7 is
    port (
        input       : in  std_logic;
        clk         : in  std_logic;
        output      : out std_logic;
        full_output : out std_logic_vector(7 downto 0)
    );
end shift_register_bit_7;

architecture Structural of shift_register_bit_7 is

    component dff_negedge
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component;

    for all: dff_negedge use entity work.dff_negedge(Structural);

    -- Signal declarations for the flip-flops
    signal count_1, count_2, count_3, count_4, count_5, count_6, count_7 : std_logic;

begin

    -- Instantiate the D flip-flops to form a shift register
    dff_1: dff_negedge
    port map (
        d    => input,
        clk  => clk,
        q    => count_1,
        qbar => open
    );

    dff_2: dff_negedge
    port map (
        d    => count_1,
        clk  => clk,
        q    => count_2,
        qbar => open
    );

    dff_3: dff_negedge
    port map (
        d    => count_2,
        clk  => clk,
        q    => count_3,
        qbar => open
    );

    dff_4: dff_negedge
    port map (
        d    => count_3,
        clk  => clk,
        q    => count_4,
        qbar => open
    );

    dff_5: dff_negedge
    port map (
        d    => count_4,
        clk  => clk,
        q    => count_5,
        qbar => open
    );

    dff_6: dff_negedge
    port map (
        d    => count_5,
        clk  => clk,
        q    => count_6,
        qbar => open
    );

    dff_7: dff_negedge
    port map (
        d    => count_6,
        clk  => clk,
        q    => count_7,
        qbar => open
    );

    dff_8: dff_negedge
    port map (
        d    => count_7,
        clk  => clk,
        q    => output,
        qbar => open
    );

    -- Assign the byte to the full_output signal
    full_output <= (count_7, count_6, count_5, count_4, count_3, count_2, count_1, input);

end Structural;

