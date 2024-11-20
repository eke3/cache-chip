-- Entity: byte_shift_tb
-- Architecture: Test

library IEEE;
use IEEE.std_logic_1164.all;

entity byte_shift_tb is
end byte_shift_tb;

architecture Test of byte_shift_tb is
    component shift_register_4bit is
        port (
            d : in  std_logic;
            clk : in  std_logic;
            reset : in std_logic;
            q : out std_logic_vector(3 downto 0)
        );
    end component shift_register_4bit;

    component mux_4x1_one_hot_2bit is
        port (
            A : in  std_logic_vector(1 downto 0);
            B : in  std_logic_vector(1 downto 0);
            C : in  std_logic_vector(1 downto 0);
            D : in  std_logic_vector(1 downto 0);
            sel : in  std_logic_vector(3 downto 0);
            F : out std_logic_vector(1 downto 0)
        );
    end component mux_4x1_one_hot_2bit;

    component mux_2x1 is 
        port (
            A      : in  STD_LOGIC; -- Input 0
            B      : in  STD_LOGIC; -- Input 1
            sel    : in  STD_LOGIC; -- sel signal
            output : out STD_LOGIC -- Output of the multiplexer
        );
    end component mux_2x1;

    component nand_2x1 is
        port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component nand_2x1;

    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    -- inputs
    signal load_shifter, shifter_enable, clk, reset : std_logic;
    
    -- intermediate signals
    signal mux_out : std_logic;
    signal nand_out, not_clk : std_logic;
    signal shifter_out : std_logic_vector(3 downto 0);
    signal high_wire : std_logic := '1';
    signal low_wire : std_logic := '0';
    signal byte1 : std_logic_vector(1 downto 0) := "00";
    signal byte2 : std_logic_vector(1 downto 0) := "01";
    signal byte3 : std_logic_vector(1 downto 0) := "10";
    signal byte4 : std_logic_vector(1 downto 0) := "11";

    -- output
    signal new_byte : std_logic_vector(1 downto 0);

    begin
        clk_inverter : inverter port map(input => clk, output => not_clk);
        nand_inst: nand_2x1 port map(A => not_clk, B => shifter_enable, output => nand_out);
        data_select : mux_2x1 port map(A => low_wire, B => high_wire, sel => load_shifter, output => mux_out);
        shifter : shift_register_4bit port map(d => mux_out, clk => nand_out, reset => reset, q => shifter_out);
        mux : mux_4x1_one_hot_2bit port map(A => byte1, B => byte2, C => byte3, D => byte4, sel => shifter_out, F => new_byte);

        process
        begin
            load_shifter <= '0';
            shifter_enable <= '0';
            clk <= '1';
            reset <= '1';
            wait for 10 ns;

            clk <= '0';
            shifter_enable <= '1';
            wait for 10 ns;
            
            clk <= '1';
            wait for 10 ns;
            
            clk <= '0';
            reset <= '0';
            load_shifter <= '1';
--            shifter_enable <= '1';
            wait for 10 ns;
            
            clk <= '1';
            wait for 10 ns;
            
            load_shifter <= '0';
            shifter_enable <= '1'; -- first negedge of shifter_enable
            clk <= '0';
            wait for 10 ns;

            load_shifter <= '0';
            clk <= '1';
            wait for 10 ns;

            clk <= '0'; -- second negedge of shifter_enable
            wait for 10 ns;

            clk <= '1';
            wait for 10 ns;

            clk <= '0'; -- third negedge of shifter_enable
            wait for 10 ns;

            clk <= '1';
            wait for 10 ns;

            clk <= '0'; -- fourth negedge of shifter_enable
            wait for 10 ns;

            clk <= '1';
            wait for 10 ns;

            clk <= '0';
            shifter_enable <= '0';
            wait for 10 ns;

            clk <= '1';
            wait for 10 ns;

            wait;
        end process;
end architecture Test;