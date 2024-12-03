library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1_8bit is
    port (
        inputs   : in  STD_LOGIC_VECTOR(127 downto 0); -- 16 inputs, each 8-bit wide
        sel      : in  STD_LOGIC_VECTOR(15 downto 0); -- 16-bit 1-hot select signal
        sel_4bit : in  std_logic_vector(3 downto 0);
        output   : out STD_LOGIC_VECTOR(7 downto 0) -- 8-bit output
    );
end mux_16x1_8bit;

architecture Structural of mux_16x1_8bit is

    -- Declare the 16x1 multiplexer and concatenator components
    component mux_16x1
        port (
            inputs      : in  STD_LOGIC_VECTOR(15 downto 0);        -- 16-bit input vector
            sel         : in  STD_LOGIC_VECTOR(3 downto 0);         -- 4-bit select signal
            sel_one_hot : in  std_logic_vector(15 downto 0);        -- 1-hot select signal
            output      : out STD_LOGIC                             -- Output of the multiplexer
        );
    end component;

    signal bits : std_logic_vector(127 downto 0);

    -- Bind components
    for all : mux_16x1 use entity work.mux_16x1(Structural);

begin

    -- Generate block for routing wires directly
    gen_1: for i in 0 to 7 generate
        -- Route wires directly to output
        bits((16 * (i + 1) - 1) downto (16 * i)) <= (
            inputs(i + 120), 
            inputs(i + 112), 
            inputs(i + 104), 
            inputs(i + 96), 
            inputs(i + 88), 
            inputs(i + 80), 
            inputs(i + 72), 
            inputs(i + 64), 
            inputs(i + 56), 
            inputs(i + 48), 
            inputs(i + 40), 
            inputs(i + 32), 
            inputs(i + 24), 
            inputs(i + 16), 
            inputs(i + 8), 
            inputs(i)
        );
    end generate;

    -- Generate block for multiplexers
    select_out0: mux_16x1
    port map (
        inputs      => bits(127 downto 112),
        sel         => sel_4bit,
        sel_one_hot => sel,
        output      => output(7)
    );

    select_out1: mux_16x1
    port map (
        inputs      => bits(111 downto 96),
        sel         => sel_4bit,
        sel_one_hot => sel,
        output      => output(6)
    );

    select_out2: mux_16x1
    port map (
        inputs      => bits(95 downto 80),
        sel         => sel_4bit,
        sel_one_hot => sel,
        output      => output(5)
    );

    select_out3: mux_16x1
    port map (
        inputs      => bits(79 downto 64),
        sel         => sel_4bit,
        sel_one_hot => sel,
        output      => output(4)
    );

    select_out4: mux_16x1
    port map (
        inputs      => bits(63 downto 48),
        sel         => sel_4bit,
        sel_one_hot => sel,
        output      => output(3)
    );

    select_out5: mux_16x1
    port map (
        inputs      => bits(47 downto 32),
        sel         => sel_4bit,
        sel_one_hot => sel,
        output      => output(2)
    );

    select_out6: mux_16x1
    port map (
        inputs      => bits(31 downto 16),
        sel         => sel_4bit,
        sel_one_hot => sel,
        output      => output(1)
    );

    select_out7: mux_16x1
    port map (
        inputs      => bits(15 downto 0),
        sel         => sel_4bit,
        sel_one_hot => sel,
        output      => output(0)
    );

end Structural;

