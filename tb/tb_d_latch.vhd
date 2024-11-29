library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
use IEEE.numeric_std.all;

entity tb_d_latch is
end entity tb_d_latch;

architecture Test of tb_d_latch is

    signal d, clk, q, qbar : std_logic;
    signal create_input    : std_logic := '0';

    -- procedure to print output to stdout
    procedure print_output is
        variable out_line : line;
    begin
        -- print inputs
        write(out_line, string'(" CLK: "));
        write(out_line, std_logic'image(clk));  -- Fixed type conversion
        write(out_line, string'(" D: "));
        write(out_line, std_logic'image(d));    -- Fixed type conversion
        writeline(output, out_line);

        -- print outputs
        write(out_line, string'(" Q: "));
        write(out_line, std_logic'image(q));    -- Fixed type conversion
        write(out_line, string'(" Qbar: "));
        write(out_line, std_logic'image(qbar)); -- Fixed type conversion

        writeline(output, out_line);
    end procedure print_output;

begin

    latch: entity work.d_latch
    port map (
        d    => d,
        clk  => clk,
        q    => q,
        qbar => qbar
    );

    -- Clock generation process
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 20 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process clk_process;

    -- Stimulus generation process
    stimulus_process: process
        variable out_line  : line;
    begin
        -- Initial message to the user
        write(out_line, string'("Testing D Latch"));
        writeline(output, out_line);

        -- 1. Change d to 0 and clk to 1 (already done by clk_process)
        d       <= '0';
        print_output;                           -- 2. Print the output

        wait for 60 ns;                         -- 3. Wait for 5 ns

        print_output;                           -- 4. Print the output again after waiting

        -- 5. Change d to 1
        d       <= '1';
        --wait for 1 ns;                          -- Add a small wait to allow the process to execute
        print_output;                           -- 6. Print the output after changing d

        wait for 60 ns;                         -- 7. Wait for 5 ns

        print_output;                           -- 8. Print the output again after waiting
        d       <= '0';
        --wait for 1 ns;                          -- Add a small wait to allow the process to execute
        print_output;                           -- 6. Print the output after changing d
        wait for 60 ns;
        print_output;
        wait;                                   -- End the process (or keep waiting for further input)
    end process stimulus_process;

end architecture Test;
