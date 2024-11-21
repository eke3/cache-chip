-- Entity: long_latch_tb
-- Architecture: Test

library IEEE;
use IEEE.std_logic_1164.all;

entity long_latch_tb is
end long_latch_tb;

architecture Test of long_latch_tb is
        component dff_negedge is
            port ( d   : in  STD_LOGIC;
                   clk : in  STD_LOGIC;
                   q   : out STD_LOGIC;
                   qbar: out STD_LOGIC
                 );
        end component dff_negedge;

        component nand_2x1 is
            port (
                A      : in  STD_LOGIC;
                B      : in  STD_LOGIC;
                output : out STD_LOGIC
            );
        end component nand_2x1;

        component inverter is
            port (
                input  : in  STD_LOGIC;
                output : out STD_LOGIC
            );
        end component inverter;

        signal data_to_latch : std_logic;
        signal clock        : std_logic;
        signal not_clock    : std_logic;
        signal load_data    : std_logic;
        signal latched_data : std_logic;
        signal nand_out     : std_logic;

        begin
            -- instantiate inverter
            inverter0: entity work.inverter(structural)
                port map (
                    input  => clock,
                    output => not_clock
                );
            
            -- instantiate nand gate
            nand_gate: entity work.nand_2x1(structural)
                port map (
                    A      => not_clock, 
                    B      => load_data,
                    output => nand_out
                );

            -- instantiate latch
            latch: entity work.dff_negedge(structural)
                port map (
                    d   => data_to_latch,
                    clk => nand_out,
                    q   => latched_data,
                    qbar=> open
                );

            stimulus: process
            begin
                -- initial state
                data_to_latch <= '1';
                clock <= '1';
                load_data <= '0';
                wait for 10 ns;
                
                -- negative clock edge, state machine sets load_data high
                clock <= '0';
                load_data <= '1';
                wait for 10 ns;
                
                -- positive clock edge, state machine sets load_data back low
                -- data should stay latched
                clock <= '1';
                load_data <= '0';
                wait for 10 ns;
                
                -- negative clock edge
                data_to_latch <= '0'; -- should NOT latch
                clock <= '0';
                wait for 10 ns;
                
                clock <= '1';
                wait for 10 ns;
                -- 1 should still be latched                
                
                wait;
            end process;
        end architecture Test;
            
