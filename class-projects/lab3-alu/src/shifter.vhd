library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter is
    generic(
        n : integer := 6;
        m : integer := 3
    );
    port(
        sel : in  std_logic_vector(1 downto 0);
        a   : in  std_logic_vector(n-1 downto 0);
        b   : in  std_logic_vector(m-1 downto 0);
        r   : out std_logic_vector(n-1 downto 0)
    );
end shifter;

architecture dataflow of shifter is

    signal shift_amt : integer range 0 to 2**m - 1;

begin

    shift_amt <= to_integer(unsigned(b));

    -- sel=00 or 01: shift left logical (zeros shifted in)
    -- sel=10:       shift right logical (zeros shifted in)
    -- sel=11:       shift right arithmetic (MSB shifted in)
    with sel select
        r <= std_logic_vector(shift_left (unsigned(a),          shift_amt)) when "00",
             std_logic_vector(shift_left (unsigned(a),          shift_amt)) when "01",
             std_logic_vector(shift_right(unsigned(a),          shift_amt)) when "10",
             std_logic_vector(shift_right(signed(a),            shift_amt)) when others;

end dataflow;
