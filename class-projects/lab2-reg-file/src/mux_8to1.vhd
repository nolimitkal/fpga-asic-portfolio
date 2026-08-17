library ieee;
use ieee.std_logic_1164.all;

-- 8-to-1 multiplexer
-- All inputs and output are n bits wide
-- sel chooses which of the 8 inputs is forwarded to the output
entity mux_8to1 is
    generic (
        n : integer := 4          -- data width in bits
    );
    port (
        sel  : in  std_logic_vector(2 downto 0);
        in0  : in  std_logic_vector(n-1 downto 0);
        in1  : in  std_logic_vector(n-1 downto 0);
        in2  : in  std_logic_vector(n-1 downto 0);
        in3  : in  std_logic_vector(n-1 downto 0);
        in4  : in  std_logic_vector(n-1 downto 0);
        in5  : in  std_logic_vector(n-1 downto 0);
        in6  : in  std_logic_vector(n-1 downto 0);
        in7  : in  std_logic_vector(n-1 downto 0);
        dout : out std_logic_vector(n-1 downto 0)
    );
end mux_8to1;

architecture dataflow of mux_8to1 is
begin
    with sel select
        dout <= in0 when "000",
                in1 when "001",
                in2 when "010",
                in3 when "011",
                in4 when "100",
                in5 when "101",
                in6 when "110",
                in7 when others;  -- "111"
end dataflow;
