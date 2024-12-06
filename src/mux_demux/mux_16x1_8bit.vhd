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
    bits(15 downto 0) <= (
        inputs(120), 
        inputs(112), 
        inputs(104), 
        inputs(96), 
        inputs(88), 
        inputs(80), 
        inputs(72), 
        inputs(64), 
        inputs(56), 
        inputs(48), 
        inputs(40), 
        inputs(32), 
        inputs(24), 
        inputs(16), 
        inputs(8), 
        inputs(0)
    );
    bits(31 downto 16) <= (
        inputs(121), 
        inputs(113), 
        inputs(105), 
        inputs(97), 
        inputs(89), 
        inputs(81), 
        inputs(73), 
        inputs(65), 
        inputs(57), 
        inputs(49), 
        inputs(41), 
        inputs(33), 
        inputs(25), 
        inputs(17), 
        inputs(9), 
        inputs(1)
    );
    bits(47 downto 32) <= (
        inputs(122), 
        inputs(114), 
        inputs(106), 
        inputs(98), 
        inputs(90), 
        inputs(82), 
        inputs(74), 
        inputs(66), 
        inputs(58), 
        inputs(50), 
        inputs(42), 
        inputs(34), 
        inputs(26), 
        inputs(18), 
        inputs(10), 
        inputs(2)
    );
    bits(63 downto 48) <= (
        inputs(123), 
        inputs(115), 
        inputs(107), 
        inputs(99), 
        inputs(91), 
        inputs(83), 
        inputs(75), 
        inputs(67), 
        inputs(59), 
        inputs(51), 
        inputs(43), 
        inputs(35), 
        inputs(27), 
        inputs(19), 
        inputs(11), 
        inputs(3)
    );
    bits(79 downto 64) <= (
        inputs(124), 
        inputs(116), 
        inputs(108), 
        inputs(100), 
        inputs(92), 
        inputs(84), 
        inputs(76), 
        inputs(68), 
        inputs(60), 
        inputs(52), 
        inputs(44), 
        inputs(36), 
        inputs(28), 
        inputs(20), 
        inputs(12), 
        inputs(4)
    );
    bits(95 downto 80) <= (
        inputs(125), 
        inputs(117), 
        inputs(109), 
        inputs(101), 
        inputs(93), 
        inputs(85), 
        inputs(77), 
        inputs(69), 
        inputs(61), 
        inputs(53), 
        inputs(45), 
        inputs(37), 
        inputs(29), 
        inputs(21), 
        inputs(13), 
        inputs(5)
    );
    bits(111 downto 96) <= (
        inputs(126), 
        inputs(118), 
        inputs(110), 
        inputs(102), 
        inputs(94), 
        inputs(86), 
        inputs(78), 
        inputs(70), 
        inputs(62), 
        inputs(54), 
        inputs(46), 
        inputs(38), 
        inputs(30), 
        inputs(22), 
        inputs(14), 
        inputs(6)
    );
    bits(127 downto 112) <= (
        inputs(127), 
        inputs(119), 
        inputs(111), 
        inputs(103), 
        inputs(95), 
        inputs(87), 
        inputs(79), 
        inputs(71), 
        inputs(63), 
        inputs(55), 
        inputs(47), 
        inputs(39), 
        inputs(31), 
        inputs(23), 
        inputs(15), 
        inputs(7)
    );

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

