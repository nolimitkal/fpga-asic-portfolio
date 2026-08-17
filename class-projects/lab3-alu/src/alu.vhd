library ieee;
use ieee.std_logic_1164.all;

entity alu is
    port(
        sel : in  std_logic_vector(3 downto 0);
        a   : in  std_logic_vector(5 downto 0);
        b   : in  std_logic_vector(5 downto 0);
        r   : out std_logic_vector(5 downto 0)
    );
end alu;

architecture structural of alu is

    constant n : integer := 6;
    constant m : integer := 3;

    -- ── Component declarations ────────────────────────────────────────────────

    component adder is
        generic(n : integer := 6);
        port(
            sel : in  std_logic_vector(1 downto 0);
            a   : in  std_logic_vector(n-1 downto 0);
            b   : in  std_logic_vector(n-1 downto 0);
            r   : out std_logic_vector(n-1 downto 0)
        );
    end component;

    component mult is
        generic(n : integer := 6);
        port(
            sel : in  std_logic;
            a   : in  std_logic_vector(n-1 downto 0);
            b   : in  std_logic_vector(n-1 downto 0);
            r   : out std_logic_vector(n-1 downto 0)
        );
    end component;

    component logic_unit is
        generic(n : integer := 6);
        port(
            sel : in  std_logic_vector(1 downto 0);
            a   : in  std_logic_vector(n-1 downto 0);
            b   : in  std_logic_vector(n-1 downto 0);
            r   : out std_logic_vector(n-1 downto 0)
        );
    end component;

    component shifter is
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
    end component;

    -- ── Internal signals ──────────────────────────────────────────────────────

    signal adder_out  : std_logic_vector(n-1 downto 0);
    signal mult_out   : std_logic_vector(n-1 downto 0);
    signal logic_out  : std_logic_vector(n-1 downto 0);
    signal shifter_out: std_logic_vector(n-1 downto 0);

begin

    -- ── Submodule instantiations ──────────────────────────────────────────────

    -- Adder: sel[3:2]="00", passes sel[1:0] to adder
    ADDER_INST : adder
        generic map(n => n)
        port map(
            sel => sel(1 downto 0),
            a   => a,
            b   => b,
            r   => adder_out
        );

    -- Multiplier: sel[3:2]="01", passes sel[0] to mult
    MULT_INST : mult
        generic map(n => n)
        port map(
            sel => sel(0),
            a   => a,
            b   => b,
            r   => mult_out
        );

    -- Logic Unit: sel[3:2]="10", passes sel[1:0] to logic_unit
    LOGIC_INST : logic_unit
        generic map(n => n)
        port map(
            sel => sel(1 downto 0),
            a   => a,
            b   => b,
            r   => logic_out
        );

    -- Shifter: sel[3:2]="11", passes sel[1:0] and b[2:0]
    SHIFT_INST : shifter
        generic map(n => n, m => m)
        port map(
            sel => sel(1 downto 0),
            a   => a,
            b   => b(m-1 downto 0),
            r   => shifter_out
        );

    -- ── Output MUX: sel[3:2] selects which unit ───────────────────────────────
    with sel(3 downto 2) select
        r <= adder_out   when "00",
             mult_out    when "01",
             logic_out   when "10",
             shifter_out when others;

end structural;
