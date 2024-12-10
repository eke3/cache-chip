-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Sat Dec  7 12:12:43 2024


architecture Structural of shift_register_7bit is

    component dff_negedge
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component;

    component buffer_8bit
        port (
            input  : in  STD_LOGIC_VECTOR(7 downto 0);
            output : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    for all: buffer_8bit use entity work.buffer_8bit(Structural);
    for all: dff_negedge use entity work.dff_negedge(Structural);

    -- Signal declarations for the flip-flops
    signal count_1, count_2, count_3, count_4, count_5, count_6, count_7 : std_logic;
    signal count : std_logic_vector(7 downto 0);

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

    count <= (count_7, count_6, count_5, count_4, count_3, count_2, count_1, input);

    -- Assign the byte to the full_output signal

    buff: buffer_8bit 
    port map (
        input => count,
        output => full_output
    );
    -- full_output(7) <= count_7;
    -- full_output(6) <= count_6;
    -- full_output(5) <= count_5;
    -- full_output(4) <= count_4;
    -- full_output(3) <= count_3;
    -- full_output(2) <= count_2;
    -- full_output(1) <= count_1;
    -- full_output(0) <= input;

end Structural;
