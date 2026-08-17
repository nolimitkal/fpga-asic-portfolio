library ieee;
use ieee.std_logic_1164.all;

entity logic_unit is
    generic(n : integer := 6);
    port(
        sel : in  std_logic_vector(1 downto 0);
        a   : in  std_logic_vector(n-1 downto 0);
        b   : in  std_logic_vector(n-1 downto 0);
        r   : out std_logic_vector(n-1 downto 0)
    );
end logic_unit;

architecture dataflow of logic_unit is
begin

    -- sel=00: NOT a
    -- sel=01: a AND b
    -- sel=10: a OR b
    -- sel=11: a XOR b
    with sel select
        r <= not a       when "00",
             a and b     when "01",
             a or  b     when "10",
             a xor b     when others;

end dataflow;
