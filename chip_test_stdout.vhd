library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_arith.all;
use STD.textio.all;

entity chip_test is
end chip_test;

architecture test of chip_test is

  component chip
    port (
      cpu_addr    : in  std_logic_vector(5 downto 0);
      cpu_data   : inout  std_logic_vector(7 downto 0);
      cpu_rd_wrn : in  std_logic;
      start      : in  std_logic;
      clk        : in  std_logic;
      reset      : in  std_logic;
      mem_data   : in  std_logic_vector(7 downto 0);
      Vdd        : in  std_logic;
      Gnd        : in  std_logic;
      busy       : out std_logic;
      mem_en     : out std_logic;
      mem_addr    : out std_logic_vector(5 downto 0)
    );
  end component;

  for c1 : chip use entity work.chip(structural);

  signal Vdd, Gnd: std_logic := '1';
  signal cpu_data, mem_data: std_logic_vector(7 downto 0) := (others => 'Z');
  signal cpu_add, mem_add: std_logic_vector(5 downto 0) := (others => 'Z');
  signal cpu_rd_wrn, reset, clk, start, clock, busy, mem_en: std_logic := '0';

  signal clk_count: integer := 0;

  procedure print_output is
    variable out_line: line;
  begin
    write(out_line, string'(" Clock: "));
    write(out_line, clk_count);
    write(out_line, string'(" Start: "));
    write(out_line, start);
    write(out_line, string'(" Cpu Read/Write: "));
    write(out_line, cpu_rd_wrn);
    write(out_line, string'(" Reset: "));
    write(out_line, reset);
    writeline(output, out_line);

    write(out_line, string'(" CPU address: "));
    write(out_line, cpu_add);
    write(out_line, string'(" CPU data: "));
    write(out_line, cpu_data);
    writeline(output, out_line);

    write(out_line, string'(" Memory data: "));
    write(out_line, mem_data);
    writeline(output, out_line);

    write(out_line, string'(" Busy: "));
    write(out_line, busy);
    write(out_line, string'(" Memory Enable: "));
    write(out_line, mem_en);
    writeline(output, out_line);

    write(out_line, string'(" Memory Address: "));
    write(out_line, mem_add);
    writeline(output, out_line);

    write(out_line, string'(" ----------------------------------------------"));
    writeline(output, out_line);
  end print_output;

begin
  Vdd <= '1';
  Gnd <= '0';
  clk <= clock;
  c1 : chip port map (cpu_add, cpu_data, cpu_rd_wrn, start, clk, reset, mem_data, Vdd, Gnd, busy, mem_en, mem_add);

  -- Clock Generation
  clking: process
  begin
    clock <= '1', '0' after 5 ns;
    wait for 10 ns;
  end process clking;

  -- Internal Input Generation and Logging
  io_process: process
  begin
    -- Simulating input values from `chip_in.txt`
    -- Replace each sequence below with patterns derived from the file
    cpu_add <= "ZZZZZZ"; cpu_data <= "00000000"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '1'; mem_data <= "00000000";
    clk_count <= clk_count + 1;
    wait for 20 ns;
    reset <= '0';
    wait for 180 ns;
    print_output;

    

    cpu_add <= "101100"; cpu_data <= "00000000"; cpu_rd_wrn <= '1'; start <= '1'; reset <= '0'; mem_data <= "00000000";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    start <= '0';
    wait for 85 ns;
    mem_data <= "11111010";
    wait for 20 ns;
    print_output;

    cpu_add <= "101100"; cpu_data <= "00000000"; cpu_rd_wrn <= '1'; start <= '0'; reset <= '0'; mem_data <= "00110010";
    clk_count <= clk_count + 1;
    wait for 20 ns;
    print_output;

    cpu_add <= "101100"; cpu_data <= "00000000"; cpu_rd_wrn <= '1'; start <= '0'; reset <= '0'; mem_data <= "10000111";
    clk_count <= clk_count + 1;
    wait for 20 ns;
    print_output;

    cpu_add <= "101100"; cpu_data <= "00000000"; cpu_rd_wrn <= '1'; start <= '0'; reset <= '0'; mem_data <= "01101011";
    clk_count <= clk_count + 1;
    wait for 20 ns;
    print_output;
    mem_data <= "00000000";
    
    wait for 45 ns;

cpu_add <= "101100"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= '1'; start <= '1'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    start<='0';
    wait for 20 ns;
    print_output;
    
    wait for 50 ns;

cpu_add <= "101101"; cpu_data <= "10100000"; cpu_rd_wrn <= '0'; start <= '1'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    start <= '0';
    wait for 30 ns;
    print_output;
    
    wait for 50 ns;
    
cpu_add <= "101101"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= '1'; start <= '1'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    start<='0';
    wait for 20 ns;
    print_output;
    
    wait for 50 ns;

cpu_add <= "100000"; cpu_data <= "10000000"; cpu_rd_wrn <= '0'; start <= '1'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    start<='0';
    wait for 30 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "00000000";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "00000000";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "00000001";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "00000001";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "00000010";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "00000010";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "00000011";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "00000011";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "000011"; cpu_data <= "11111111"; cpu_rd_wrn <= '0'; start <= '1'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "000011"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= '1'; start <= '1'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "111111"; cpu_data <= "10101010"; cpu_rd_wrn <= '0'; start <= '1'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;

cpu_add <= "ZZZZZZ"; cpu_data <= "ZZZZZZZZ"; cpu_rd_wrn <= 'Z'; start <= '0'; reset <= '0'; mem_data <= "ZZZZZZZZ";
    clk_count <= clk_count + 1;
    wait for 10 ns;
    print_output;
  end process io_process;

end test;


