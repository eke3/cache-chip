library ieee;
use ieee.std_logic_1164.all;

entity valid_vector_tb is
end entity valid_vector_tb;

architecture Test of valid_vector_tb is
    component valid_vector is
        port (
            write_data  : in  std_logic;
            reset       : in  std_logic;
            chip_enable : in  std_logic_vector(3 downto 0);
            RW          : in  std_logic;
            sel         : in  std_logic_vector(1 downto 0);
            read_data_3 : out std_logic;
            read_data_2 : out std_logic;
            read_data_1 : out std_logic;
            read_data_0 : out std_logic
        );
    end component valid_vector;

    signal write_data, reset, RW                              : std_logic;
    signal chip_enable                                        : std_logic_vector(3 downto 0);
    signal sel                                                : std_logic_vector(1 downto 0);
    signal read_data_3, read_data_2, read_data_1, read_data_0 : std_logic;

begin
    uut: component valid_vector
    port map (
        write_data  => write_data,
        reset       => reset,
        chip_enable => chip_enable,
        RW          => RW,
        sel         => sel,
        read_data_3 => read_data_3,
        read_data_2 => read_data_2,
        read_data_1 => read_data_1,
        read_data_0 => read_data_0
    );

    process
    begin
        -- Reset
        reset       <= '1';
        write_data  <= '0';
        chip_enable <= "0000";
        RW          <= '0'; -- RW=0 for reset
        sel         <= "00";
        wait for 10 ns;

        -- Release reset
        reset       <= '0';
        -- Write 1 to cell 0
        write_data  <= '1';
        chip_enable <= "0001";
        RW          <= '0'; -- RW=1 for write
        sel         <= "00";
        wait for 10 ns;


        -- Read from cell 0
        chip_enable <= "0001";
        RW          <= '1'; -- RW=0 for read
        wait for 10 ns;
        report "Read data from cell 0: " & std_logic'image(read_data_0);


        -- Write 1 to cell 1
        write_data  <= '1';
        chip_enable <= "0010";
        RW          <= '0'; -- RW=1 for write
        sel         <= "01";
        wait for 10 ns;

        --        -- Read from cell 0
        --        chip_enable <= "0001";
        --        RW <= '1'; -- RW=0 for read
        --        wait for 10 ns;
        --        report "Read data from cell 0: " & std_logic'image(read_data_0);


        -- Read from cell 1
        chip_enable <= "0010";
        RW          <= '1'; -- RW=0 for read
        wait for 10 ns;
        report "Read data from cell 1: " & std_logic'image(read_data_1);


        -- Read from cell 0
        --sel <= "00";
        chip_enable <= "0001";
        RW          <= '1'; -- RW=0 for read
        wait for 10 ns;
        report "Read data from cell 0: " & std_logic'image(read_data_0);

        -- ... (similarly for cells 2 and 3)

        --        -- Final reset
        --        reset <= '1';
        --        wait for 20 ns;

        -- Read from cell 1
        chip_enable <= "0010";
        RW          <= '1'; -- RW=0 for read
        wait for 10 ns;
        report "Read data from cell 1: " & std_logic'image(read_data_1);


        -- Read from cell 0
        --sel <= "00";
        chip_enable <= "0001";
        RW          <= '1'; -- RW=0 for read
        wait for 10 ns;
        report "Read data from cell 0: " & std_logic'image(read_data_0);

        -- Reset
        reset       <= '1';
        write_data  <= '0';
        chip_enable <= "0000";
        RW          <= '0'; -- RW=0 for reset
        sel         <= "00";
        wait for 10 ns;

        -- Release reset
        reset       <= '0';

        wait for 20 ns;

        -- Read from cell 1
        chip_enable <= "0010";
        RW          <= '1'; -- RW=0 for read
        wait for 10 ns;
        report "Read data from cell 1: " & std_logic'image(read_data_1);


        -- Read from cell 0
        --sel <= "00";
        chip_enable <= "0001";
        RW          <= '1'; -- RW=0 for read
        wait for 10 ns;
        report "Read data from cell 0: " & std_logic'image(read_data_0);

        wait;
    end process;

end architecture Test;
