-- Entity: tb_byte_selector
-- Architecture: Test
-- Note: Run for 100 ns

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use STD.TEXTIO.all;

entity tb_byte_selector is
end entity tb_byte_selector;

architecture Test of tb_byte_selector is
    -- Component declaration for byte_selector
    component byte_selector is
        port (
            vdd                 : in  std_logic;
            gnd                 : in  std_logic;
            shift_register_data : in  std_logic_vector(7 downto 0);
            byte_offset         : out std_logic_vector(1 downto 0)
        );
    end component byte_selector;

    signal shift_register_data : std_logic_vector(7 downto 0);
    signal byte_offset         : std_logic_vector(1 downto 0);

    procedure print_output is
        variable out_line : line;
    begin
        write(out_line, string'(" Input: "));
        write(out_line, shift_register_data);
        write(out_line, string'(" Byte Offset: "));
        write(out_line, byte_offset);
        writeline(output, out_line);

        write(out_line, string'(" ----------------------------------------------"));
        writeline(output, out_line);
    end procedure print_output;

begin
    -- Instantiate the byte_selector component
    byte_selector_inst: entity work.byte_selector(Structural)
    port map (
        vdd                 => '1',
        gnd                 => '0',
        shift_register_data => shift_register_data,
        byte_offset         => byte_offset
    );


    -- Stimulus process
    stim: process
    begin
        -- Initialize inputs
        shift_register_data <= (others => 'Z');
        wait for 10 ns;

        -- Test Case 1: Select first byte 00
        shift_register_data <= "00000001";
        wait for 10 ns;
        assert (byte_offset = "00") report "Test Case 1 failed" severity error;
        print_output;
        shift_register_data <= "00000010";
        wait for 10 ns;
        assert (byte_offset = "00") report "Test Case 1 failed" severity error;
        print_output;

        -- Test Case 2: Select second byte 01
        shift_register_data <= "00000100";
        wait for 10 ns;
        assert (byte_offset = "01") report "Test Case 2 failed" severity error;
        print_output;
        shift_register_data <= "00001000";
        wait for 10 ns;
        assert (byte_offset = "01") report "Test Case 2 failed" severity error;
        print_output;

        -- Test Case 3: Select third byte 10
        shift_register_data <= "00010000";
        wait for 10 ns;
        assert (byte_offset = "10") report "Test Case 3 failed" severity error;
        print_output;
        shift_register_data <= "00100000";
        wait for 10 ns;
        assert (byte_offset = "10") report "Test Case 3 failed" severity error;
        print_output;

        -- Test Case 4: Select last byte 11
        shift_register_data <= "01000000";
        wait for 10 ns;
        assert (byte_offset = "11") report "Test Case 4 failed" severity error;
        print_output;
        shift_register_data <= "10000000";
        wait for 10 ns;
        assert (byte_offset = "11") report "Test Case 4 failed" severity error;
        print_output;

        -- End simulation
        report "Test bench completed.";
        wait;
    end process stim;

end architecture Test;
