--Logic Unit Simulation Bench
library ieee;
use ieee.std_logic_1164.all;

entity logic_unit_sim is
end logic_unit_sim;

architecture logic_unit_tb of logic_unit_sim is
    component logic_unit is
        generic(n: integer := 6);
        port(sel: in std_logic_vector(1 downto 0);
             a,b: in std_logic_vector(n-1 downto 0);
               r: out std_logic_vector(n-1 downto 0));
    end component logic_unit;
    constant n : integer := 6;
    constant period : time := 10 ns;
    signal sel_tb : std_logic_vector(1 downto 0);
    signal a_tb, b_tb, r_tb : std_logic_vector(n-1 downto 0);

begin
    --sel = 00 then r = not(a)
    --sel = 01 then r = a and b
    --sel = 10 then r = a or b
    --sel = 11 then r = a xor b
    uut: logic_unit
        generic map(n => n)
        port    map(sel => sel_tb,
                      a => a_tb,
                      b => b_tb,
                      r => r_tb);

   tb: process begin
        a_tb <= "010101"; b_tb <= "111111";
        sel_tb <= "00"; wait for period;
        sel_tb <= "01"; wait for period;
        sel_tb <= "10"; wait for period;
        sel_tb <= "11"; wait for period;
   end process tb;
end logic_unit_tb;
