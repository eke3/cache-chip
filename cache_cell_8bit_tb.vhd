library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_cache_cell_8bit is
    -- Test bench has no ports
end entity tb_cache_cell_8bit;

architecture Test of tb_cache_cell_8bit is
    -- Component declaration for the Unit Under Test (UUT)
    component cache_cell_8bit is
        port (
            write_data  : in  std_logic_vector(7 downto 0);
            chip_enable : in  std_logic;
            RW          : in  std_logic;
            read_data   : out std_logic_vector(7 downto 0)
        );
    end component cache_cell_8bit;

    -- Signals to connect to UUT
    signal tb_write_data  : std_logic_vector(7 downto 0) := (others => '0');
    signal tb_chip_enable : std_logic                    := '0';
    signal tb_RW          : std_logic                    := '0'; -- 0 for read, 1 for write
    signal tb_read_data   : std_logic_vector(7 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: component cache_cell_8bit
    port map (
        write_data  => tb_write_data,
        chip_enable => tb_chip_enable,
        RW          => tb_RW,
        read_data   => tb_read_data
    );

    -- Test Process
    process
    begin
        -- Test 1: Write operation (write_data = "10101010")
        tb_chip_enable <= '1';                                   -- Enable chip
        tb_RW          <= '1';                                   -- Set to write mode
        tb_write_data  <= "10101010";
        wait for 10 ns;

        -- Test 2: Read operation
        tb_RW          <= '0';                                   -- Set to read mode
        wait for 10 ns;

        -- Test 3: Disable chip (chip_enable = '0')
        tb_chip_enable <= '0';                                   -- Disable chip
        wait for 10 ns;

        -- Test 4: Write operation with new data (write_data = "11001100")
        tb_chip_enable <= '1';                                   -- Enable chip
        tb_RW          <= '1';                                   -- Set to write mode
        tb_write_data  <= "11001100";
        wait for 10 ns;

        -- Test 5: Read operation
        tb_RW          <= '0';                                   -- Set to read mode
        wait for 10 ns;

        -- Test 6: Write while chip is disabled
        tb_chip_enable <= '0';                                   -- Disable chip
        tb_RW          <= '1';
        tb_write_data  <= "11110000";
        wait for 10 ns;

        -- End of Test
        wait;
    end process;

end architecture Test;
