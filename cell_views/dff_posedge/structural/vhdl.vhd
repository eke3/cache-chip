-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Mon Dec  2 15:24:48 2024


architecture Structural of dff_posedge is

begin

    output: process
    begin
        wait until (clk'event and clk = '1');
        q    <= d;
        qbar <= not d;
    end process output;

end Structural;
