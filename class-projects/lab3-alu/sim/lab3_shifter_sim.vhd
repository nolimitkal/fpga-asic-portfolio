---Shifter Simulation Bench
library ieee;
use ieee.std_logic_1164.all;

entity shifter_sim is
end shifter_sim;

architecture shifter_tb of shifter_sim is

    constant n : integer := 6;
    constant m : integer := 3;
    constant period: time := 10ns;

    component shifter is
    generic(n : integer:= 6;
            m : integer:= 3);
    port(sel:in std_logic_vector(1 downto 0);
         a  :in std_logic_vector(n-1 downto 0);
         b  :in std_logic_vector(m-1 downto 0);
         r  :out std_logic_vector(n-1 downto 0));
    end component;

    signal sel_tb     : std_logic_vector(1 downto 0);
    signal a_tb, r_tb : std_logic_vector(n-1 downto 0);
    signal b_tb       : std_logic_vector(m-1 downto 0);

begin
    uut: shifter
        generic map(n => n, m => m)
        port map(sel => sel_tb, a => a_tb, b => b_tb, r => r_tb);
    process begin
    sel_tb <= "00";
        a_tb <= "000001"; b_tb <= "000"; wait for period;
        a_tb <= "000001"; b_tb <= "001"; wait for period;
        a_tb <= "000001"; b_tb <= "010"; wait for period;
        a_tb <= "000001"; b_tb <= "011"; wait for period;
        a_tb <= "000001"; b_tb <= "100"; wait for period;
        a_tb <= "000001"; b_tb <= "101"; wait for period;
        a_tb <= "000001"; b_tb <= "110"; wait for period;
        a_tb <= "000001"; b_tb <= "111"; wait for period;
    sel_tb <= "10";
        a_tb <= "100000"; b_tb <= "000"; wait for period;
        a_tb <= "100000"; b_tb <= "001"; wait for period;
        a_tb <= "100000"; b_tb <= "010"; wait for period;
        a_tb <= "100000"; b_tb <= "011"; wait for period;
        a_tb <= "100000"; b_tb <= "100"; wait for period;
        a_tb <= "100000"; b_tb <= "101"; wait for period;
        a_tb <= "100000"; b_tb <= "110"; wait for period;
        a_tb <= "100000"; b_tb <= "111"; wait for period;
    sel_tb <= "11";
        a_tb <= "100000"; b_tb <= "000"; wait for period;
        a_tb <= "100000"; b_tb <= "001"; wait for period;
        a_tb <= "100000"; b_tb <= "010"; wait for period;
        a_tb <= "100000"; b_tb <= "011"; wait for period;
        a_tb <= "100000"; b_tb <= "100"; wait for period;
        a_tb <= "100000"; b_tb <= "101"; wait for period;
        a_tb <= "100000"; b_tb <= "110"; wait for period;
        a_tb <= "100000"; b_tb <= "111"; wait for period;
     sel_tb <= "11";
        a_tb <= "010000"; b_tb <= "000"; wait for period;
        a_tb <= "010000"; b_tb <= "001"; wait for period;
        a_tb <= "010000"; b_tb <= "010"; wait for period;
        a_tb <= "010000"; b_tb <= "011"; wait for period;
        a_tb <= "010000"; b_tb <= "100"; wait for period;
        a_tb <= "010000"; b_tb <= "101"; wait for period;
        a_tb <= "010000"; b_tb <= "110"; wait for period;
        a_tb <= "010000"; b_tb <= "111"; wait for period;
   end process;


end shifter_tb;
