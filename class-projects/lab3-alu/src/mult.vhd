library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult is
    generic(n : integer := 6);
    port(
        sel : in  std_logic;
        a   : in  std_logic_vector(n-1 downto 0);
        b   : in  std_logic_vector(n-1 downto 0);
        r   : out std_logic_vector(n-1 downto 0)
    );
end mult;

architecture dataflow of mult is

    -- full 2n-bit product
    signal product : unsigned(2*n-1 downto 0);

begin

    product <= unsigned(a) * unsigned(b);

    -- sel=0: low n bits, sel=1: high n bits
    with sel select
        r <= std_logic_vector(product(n-1 downto 0))   when '0',
             std_logic_vector(product(2*n-1 downto n)) when others;

end dataflow;
