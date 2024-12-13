-- Entity: tb_selector
-- Architecture: Test
-- Note: Run for 200 ns

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use STD.TEXTIO.all;

entity tb_selector is
end tb_selector;

architecture Test of tb_selector is
    -- Component declaration for selector
    component selector
        port (
            chip_enable  : in  std_logic;
            RW           : in  std_logic;
            read_enable  : out std_logic;
            write_enable : out std_logic
        );
    end component;

    for all: selector use entity work.selector(Structural);

    -- Signals to connect to the selector inputs and outputs
    signal chip_enable    : std_logic;
    signal RW             : std_logic;
    signal read_enable    : std_logic;
    signal write_enable   : std_logic;

    -- Test vector array to hold combinations of chip_enable and RW inputs
    type test_vector_array is array (natural range <>) of std_logic_vector(1 downto 0);
    constant test_vectors : test_vector_array := (
        "00", -- Test with {chip_enable, RW} = {0, 0} (No enable, no read/write)
        "01", -- Test with {chip_enable, RW} = {0, 1} (No enable, read)
        "10", -- Test with {chip_enable, RW} = {1, 0} (Enable, write)
        "11"  -- Test with {chip_enable, RW} = {1, 1} (Enable, read)
    );

    -- Index to iterate over test vectors
    signal test_index     : integer           := 0;

    -- Procedure to print current input and output values
    procedure print_output is
        variable out_line : line;
    begin
        write(out_line, string'("Inputs - Chip Enable: "));
        write(out_line, std_logic'image(chip_enable));
        write(out_line, string'(" RW: "));
        write(out_line, std_logic'image(RW));

        write(out_line, string'(" | Outputs - Read Enable: "));
        write(out_line, std_logic'image(read_enable));
        write(out_line, string'(" Write Enable: "));
        write(out_line, std_logic'image(write_enable));

        writeline(output, out_line);
    end print_output;

begin

    -- Instantiate the selector entity
    DUT: selector
    port map (
        chip_enable  => chip_enable,
        RW           => RW,
        read_enable  => read_enable,
        write_enable => write_enable
    );

    -- Stimulus process to apply test vectors to the DUT
    stimulus_process: process
    begin
        -- Apply each test vector with a delay of 20 ns between each
        for i in 0 to test_vectors'length - 1 loop
            -- Set inputs based on current test vector
            chip_enable <= test_vectors(i)(1);
            RW          <= test_vectors(i)(0);

            -- Wait for changes to propagate
            wait for 10 ns;

            -- Print output for each test vector
            print_output;

            -- Wait 20 ns before moving to the next vector
            wait for 20 ns;
        end loop;

        -- End simulation
        assert false report "Testbench completed" severity failure;
    end process;

end Test;
