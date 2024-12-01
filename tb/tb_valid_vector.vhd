-- Entity: tb_valid_vector
-- Architecture: Test
-- Note: Run for 100 ns

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_arith.all;
use STD.textio.all;

entity tb_valid_vector is
end entity tb_valid_vector;

architecture Test of tb_valid_vector is
    -- Component declaration for valid_vector entity
    component valid_vector is
        port (
            vdd         : in  STD_LOGIC; -- Power supply
            gnd         : in  STD_LOGIC; -- Ground
            write_data  : in  STD_LOGIC; -- Shared write data for demux
            reset       : in  STD_LOGIC; -- Shared reset signal for all cells
            chip_enable : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit chip enable (1 bit per cell)
            RW          : in  STD_LOGIC; -- Shared Read/Write signal for all cells
            sel         : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector for demux, comes from decoder input
            read_data   : out STD_LOGIC -- Read data output for cell 3
        );
    end component valid_vector;

    signal write_data, reset, RW : std_logic;
    signal chip_enable           : std_logic_vector(3 downto 0);
    signal sel                   : std_logic_vector(1 downto 0);
    signal read_data             : std_logic;

    procedure print_output is
        variable out_line : line;
    begin
        write(out_line, string'(" Reset: "));
        write(out_line, reset);
        write(out_line, string'(" Write Data "));
        write(out_line, write_data);
        write(out_line, string'(" Read/Write: "));
        write(out_line, RW);
        write(out_line, string'(" Chip Enable: "));
        write(out_line, chip_enable);
        write(out_line, string'(" Sel: "));
        write(out_line, sel);
        writeline(output, out_line);

        write(out_line, string'(" Read Data: "));
        write(out_line, read_data);
        writeline(output, out_line);

        write(out_line, string'(" ----------------------------------------------"));
        writeline(output, out_line);
    end procedure print_output;

begin
    DUT: entity work.valid_vector(Structural)
    port map (
        vdd         => '1',
        gnd         => '0',
        write_data  => write_data,
        reset       => reset,
        chip_enable => chip_enable,
        RW          => RW,
        sel         => sel,
        read_data   => read_data
    );

    stim: process
    begin

        -- Initialize inputs
        write_data  <= 'Z';
        reset       <= 'Z';
        chip_enable <= "ZZZZ";
        RW          <= 'Z';
        sel         <= "ZZ";
        wait for 10 ns;

        -- Test Case 1: Apply reset = 1 (Expect read_data = Z)
        reset       <= '1';
        wait for 10 ns;
        assert (read_data = 'X') report "Test Case 1 failed." severity warning;
        print_output;
        reset       <= '0';
        wait for 10 ns;
        assert (read_data = 'X') report "Test Case 1 failed." severity warning;
        print_output;
        -- Read a cell after reset
        RW          <= '1'; 
        chip_enable <= "0001";
        sel         <= "00";
        wait for 10 ns;
        assert (read_data = '0') report "Test Case 1 failed." severity warning;
        print_output;

        -- Test Case 2: Write 1 to a cell
        write_data  <= '1';
        reset       <= '0';
        chip_enable <= "0001";
        RW          <= '0'; -- Write mode
        sel         <= "00";
        wait for 10 ns;
        assert (read_data = 'X') report "Test Case 2 failed." severity warning;
        print_output;
        -- Read cell after writing 1
        write_data <= 'Z';
        reset <= '0';
        chip_enable <= "0001";
        RW <= '1';
        sel <= "00";
        wait for 10 ns;
        assert (read_data = '1') report "Test Case 2 failed." severity warning;
        print_output;

        -- Test Case 3: Read a different cell (read_data = 0 expected)
        write_data <= 'Z';
        reset <= '0';
        chip_enable <= "0010";
        RW <= '1';
        sel <= "01";
        wait for 10 ns;
        assert (read_data = '0') report "Test Case 3 failed." severity warning;
        print_output;

        report "Testbench completed.";
        wait;
    end process stim;

end architecture Test;
