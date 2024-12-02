library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_mux_16x1 is
    -- Testbench does not have ports
end tb_mux_16x1;

architecture Test of tb_mux_16x1 is

    -- Component declaration for the Unit Under Test (UUT)
    component mux_16x1
        port (
            inputs      : in  STD_LOGIC_VECTOR(15 downto 0); -- 16-bit input vector
            sel         : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit select signal
            sel_one_hot : in  STD_LOGIC_VECTOR(15 downto 0); -- One-hot select
            output      : out STD_LOGIC                      -- Output of the multiplexer
        );
    end component;

    for all: mux_16x1 use entity work.mux_16x1(Structural);

    -- Test signals
    signal inputs      : STD_LOGIC_VECTOR(15 downto 0);
    signal sel         : STD_LOGIC_VECTOR(3 downto 0);
    signal sel_one_hot : STD_LOGIC_VECTOR(15 downto 0);
    signal output      : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: mux_16x1
    port map (
        inputs      => inputs,
        sel         => sel,
        sel_one_hot => sel_one_hot,
        output      => output
    );

    -- Stimulus process
    process
        variable i     : integer;
    begin
        -- Initialize signals
        inputs      <= "0101010101010101";
        sel         <= "0000";
        sel_one_hot <= (others => '0');
        wait for 10 ns;


        sel_one_hot <= "0000000000000001";
        sel         <= "0001";
        wait for 20 ns;

        sel_one_hot <= "0000000000000010";
        sel         <= "0010";
        wait for 20 ns;

        sel_one_hot <= "0000000000000100";
        sel         <= "0011";
        wait for 20 ns;

        -- End simulation
        assert false report "End Simulation" severity failure;
    end process;

end Test;
