-- Entity: tb_sr_latch
-- Architecture: Test
-- Note: Run for 200 ns

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_sr_latch is
end entity tb_sr_latch;

architecture Test of tb_sr_latch is
    -- Component declaration for sr_latch
    component sr_latch is
        port (
            S  : in    std_logic;    -- Set input
            R  : in    std_logic;    -- Reset input
            Q  : inout std_logic;    -- Output Q
            Qn : inout std_logic     -- Complement of Q
        );
    end component sr_latch;

    -- Test bench signals
    signal tb_S  : std_logic := '0'; -- Initialize S to 0
    signal tb_R  : std_logic := '0'; -- Initialize R to 0
    signal tb_Q  : std_logic := '0'; -- Initialize Q to 0
    signal tb_Qn : std_logic := '1'; -- Initialize Qn to 1

begin
    -- Instantiate the sr_latch
    uut: entity work.sr_latch(Structural)
    port map (
        S  => tb_S,
        R  => tb_R,
        Q  => tb_Q,
        Qn => tb_Qn
    );

    -- Stimulus process
    stimulus_process: process
    begin

        tb_S <= '1';
        tb_R <= '0';
        wait for 20 ns;

        -- Test case 1: Hold state (S=0, R=0)
        tb_S <= '0';
        tb_R <= '0';
        wait for 20 ns;

        -- Test case 3: Reset state (S=0, R=1)
        tb_S <= '0';
        tb_R <= '1';
        wait for 20 ns;

        -- Test case 4: Invalid state (S=1, R=1)
        tb_S <= '1';
        tb_R <= '1';
        wait for 20 ns;

        -- Return to Hold state (S=0, R=0)
        tb_S <= '0';
        tb_R <= '0';
        wait for 20 ns;

        -- Finish simulation
        assert false report "Simulation completed" severity note;
        wait;
    end process stimulus_process;

end architecture Test;
