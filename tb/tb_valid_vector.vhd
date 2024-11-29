library ieee;
use ieee.std_logic_1164.all;

entity tb_valid_vector is
end entity tb_valid_vector;

architecture Test of tb_valid_vector is
    component valid_vector is
        port (
            write_data  : in  std_logic;
            reset       : in  std_logic;
            chip_enable : in  std_logic_vector(3 downto 0);
            RW          : in  std_logic;
            sel         : in  std_logic_vector(1 downto 0);
            read_data   : out std_logic
        );
    end component valid_vector;

    signal write_data, reset, RW : std_logic;
    signal chip_enable           : std_logic_vector(3 downto 0);
    signal sel                   : std_logic_vector(1 downto 0);
    signal read_data             : std_logic;

begin
    uut: entity work.valid_vector(Structural)
    port map (
        write_data  => write_data,
        reset       => reset,
        chip_enable => chip_enable,
        RW          => RW,
        sel         => sel,
        read_data   => read_data
    );

    process
    begin

        write_data  <= 'X';
        chip_enable <= "0001";
        sel         <= "00";
        RW          <= '1';
        reset       <= '0';
        wait for 10 ns;

        -- Reset
        reset       <= '1';
        write_data  <= '0';
        chip_enable <= "0000";
        RW          <= '0'; -- RW=0 for reset
        sel         <= "00";
        wait for 10 ns;

        -- Release reset
        reset       <= '0';
        wait for 10 ns;

        RW          <= '1';
        chip_enable <= "0001";
        wait for 10 ns;


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
        report "Read data from cell 0: " & std_logic'image(read_data);


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
        report "Read data from cell 1: " & std_logic'image(read_data);


        -- Read from cell 0
        --sel <= "00";
        chip_enable <= "0001";
        RW          <= '1'; -- RW=0 for read
        wait for 10 ns;
        report "Read data from cell 0: " & std_logic'image(read_data);

        -- ... (similarly for cells 2 and 3)

        --        -- Final reset
        --        reset <= '1';
        --        wait for 20 ns;

        -- Read from cell 1
        chip_enable <= "0010";
        RW          <= '1'; -- RW=0 for read
        wait for 10 ns;
        report "Read data from cell 1: " & std_logic'image(read_data);


        -- Read from cell 0
        --sel <= "00";
        chip_enable <= "0001";
        RW          <= '1'; -- RW=0 for read
        wait for 10 ns;
        report "Read data from cell 0: " & std_logic'image(read_data);

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
        report "Read data from cell 1: " & std_logic'image(read_data);


        -- Read from cell 0
        --sel <= "00";
        chip_enable <= "0001";
        RW          <= '1'; -- RW=0 for read
        wait for 10 ns;
        report "Read data from cell 0: " & std_logic'image(read_data);

        wait;
    end process;

end architecture Test;
