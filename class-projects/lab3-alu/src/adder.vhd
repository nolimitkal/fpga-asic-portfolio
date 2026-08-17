library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    generic(n : integer := 6);
    port(
        sel : in  std_logic_vector(1 downto 0);
        a   : in  std_logic_vector(n-1 downto 0);
        b   : in  std_logic_vector(n-1 downto 0);
        r   : out std_logic_vector(n-1 downto 0)
    );
end adder;

architecture dataflow of adder is

    signal carry_sel  : std_logic;
    signal sub        : std_logic;
    signal a_long     : unsigned(n downto 0);
    signal b_long     : unsigned(n downto 0);
    signal op1_long   : unsigned(n downto 0);
    signal op2_long   : unsigned(n downto 0);
    signal sum_long   : unsigned(n downto 0);
    signal carry_long : unsigned(n downto 0);
    signal sum        : std_logic_vector(n-1 downto 0);
    signal carry      : std_logic_vector(n-1 downto 0);

begin

    -- decode sel
    sub       <= sel(1);   -- MSB: 0=add, 1=subtract
    carry_sel <= sel(0);   -- LSB: 0=result, 1=carry/borrow

    -- extend inputs (7-bit)
    a_long <= '0' & unsigned(a);
    b_long <= ('0' & unsigned(not b)) when sub = '1' else ('0' & unsigned(b));

    -- op1 = a + b (or a + ~b)
    op1_long <= a_long + b_long;

    -- op2 = a + ~b + 1 = two's complement subtraction
    op2_long <= op1_long + to_unsigned(1, n+1);

    -- select result based on sub
    sum_long  <= op2_long when sub = '1' else op1_long;

    -- lower n bits = result
    sum <= std_logic_vector(sum_long(n-1 downto 0));

    -- carry/borrow bit extended to n bits
    carry_long <= "000000" & sum_long(n);
    carry      <= std_logic_vector(carry_long(n-1 downto 0));

    -- output mux
    r <= carry when carry_sel = '1' else sum;

end dataflow;
