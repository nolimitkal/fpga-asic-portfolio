---ALU Simulation Bench
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity alu_sim is
end alu_sim;

architecture alu_tb of alu_sim is
    component alu is
    port(sel: in  std_logic_vector(3 downto 0);
         a,b: in  std_logic_vector(5 downto 0);
           r: out std_logic_vector(5 downto 0));
    end component alu;

    constant period : time := 10 ns;
    signal sel_tb : std_logic_vector(3 downto 0);
    signal a_tb, b_tb, r_tb : std_logic_vector(5 downto 0);

begin
    uut: alu port map(sel => sel_tb, a => a_tb, b => b_tb, r => r_tb);
    tb: process begin
    a_tb <= "000100"; b_tb <= "000010"; --a = 4,  b = 2
        for i in 0 to 15 loop
            sel_tb <= conv_std_logic_vector(i,4); wait for period;
        end loop;

    a_tb <= "110001"; b_tb <= "110010"; --a = 49, b = 50
        for i in 0 to 15 loop
            sel_tb <= conv_std_logic_vector(i,4); wait for period;
        end loop;

    a_tb <= "111111"; b_tb <= "111111"; --a = 63, b = 63
         for i in 0 to 15 loop
                sel_tb <= conv_std_logic_vector(i,4); wait for period;
            end loop;
    end process tb;
end alu_tb;
