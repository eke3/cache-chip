-- Entity: byte_selector_tb
-- Architecture: Test

library IEEE;
use IEEE.std_logic_1164.all;

entity byte_selector_tb is
end entity byte_selector_tb;

architecture Test of byte_selector_tb is
    component byte_selector
        port (
            vdd : in std_logic;
            gnd : in std_logic;
            shift_register_data : in std_logic_vector(7 downto 0);
            cpu_byte : in std_logic_vector(1 downto 0);
            mem_data_read_enable : in std_logic;
            byte_offset : out std_logic_vector(1 downto 0)
        );
    end component byte_selector;
    
    signal vdd : std_logic := '1';
    signal gnd : std_logic := '0';
    signal shift_register_data : std_logic_vector(7 downto 0);
    signal cpu_byte : std_logic_vector(1 downto 0);
    signal mem_data_read_enable : std_logic;
    signal byte_offset : std_logic_vector(1 downto 0);
begin
    -- Instantiate the byte_selector component
    byte_selector_inst : entity work.byte_selector(Structural)
        port map (
            vdd => vdd,
            gnd => gnd,
            shift_register_data => shift_register_data,
            cpu_byte => cpu_byte,
            mem_data_read_enable => mem_data_read_enable,
            byte_offset => byte_offset
        );


    -- Stimulus process
    stim: process
    begin
        wait for 10 ns;
        shift_register_data <= "00000001";
        cpu_byte <= "11";
        mem_data_read_enable <= '1';
        wait for 10 ns;
        assert (byte_offset = "00") report "didnt work" severity error;
        
        wait for 10 ns;
        shift_register_data <= "10000000";
        cpu_byte <= "10";
        wait for 10 ns;
        assert (byte_offset = "11") report "didnt work" severity error;
        
        wait for 10 ns;
        mem_data_read_enable <= '0';
        wait for 10 ns;
        assert (byte_offset = "10") report "didnt work" severity error;

        wait;
    end process stim;
    
end architecture Test;