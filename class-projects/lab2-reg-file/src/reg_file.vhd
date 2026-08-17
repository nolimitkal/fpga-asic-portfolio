library ieee;
use ieee.std_logic_1164.all;

-- Register File: 8 registers x 4 bits
-- One-read, one-write format
-- Decoder selects which register to write (via we signals)
-- MUX selects which register output to read
entity reg_file is
    port (
        clk  : in  std_logic;
        rst  : in  std_logic;                    -- async active-low reset
        we   : in  std_logic;                    -- write enable
        addr : in  std_logic_vector(2 downto 0); -- register address (read & write)
        din  : in  std_logic_vector(3 downto 0); -- data input
        dout : out std_logic_vector(3 downto 0)  -- data output
    );
end reg_file;

architecture structural of reg_file is

    -- ── Component declarations ────────────────────────────────────────────────

    component reg_module is
        generic ( n : integer := 4 );
        port (
            clk  : in  std_logic;
            rst  : in  std_logic;
            we   : in  std_logic;
            din  : in  std_logic_vector(n-1 downto 0);
            dout : out std_logic_vector(n-1 downto 0)
        );
    end component;

    component mux_8to1 is
        generic ( n : integer := 4 );
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
    end component;

    component decoder_3to8 is
        port (
            en   : in  std_logic;
            addr : in  std_logic_vector(2 downto 0);
            dout : out std_logic_vector(7 downto 0)
        );
    end component;

    -- ── Internal signals ──────────────────────────────────────────────────────

    -- Decoder output: one-hot write-enable for each register
    signal dec_out : std_logic_vector(7 downto 0);

    -- Register outputs (8 registers x 4 bits)
    signal reg_out0, reg_out1, reg_out2, reg_out3 : std_logic_vector(3 downto 0);
    signal reg_out4, reg_out5, reg_out6, reg_out7 : std_logic_vector(3 downto 0);

begin

    -- ── Decoder: addr + we → one-hot write enable ─────────────────────────────
    DEC : decoder_3to8
        port map (
            en   => we,
            addr => addr,
            dout => dec_out
        );

    -- ── Eight registers ───────────────────────────────────────────────────────
    REG0 : reg_module generic map (n => 4)
        port map (clk => clk, rst => rst, we => dec_out(0), din => din, dout => reg_out0);

    REG1 : reg_module generic map (n => 4)
        port map (clk => clk, rst => rst, we => dec_out(1), din => din, dout => reg_out1);

    REG2 : reg_module generic map (n => 4)
        port map (clk => clk, rst => rst, we => dec_out(2), din => din, dout => reg_out2);

    REG3 : reg_module generic map (n => 4)
        port map (clk => clk, rst => rst, we => dec_out(3), din => din, dout => reg_out3);

    REG4 : reg_module generic map (n => 4)
        port map (clk => clk, rst => rst, we => dec_out(4), din => din, dout => reg_out4);

    REG5 : reg_module generic map (n => 4)
        port map (clk => clk, rst => rst, we => dec_out(5), din => din, dout => reg_out5);

    REG6 : reg_module generic map (n => 4)
        port map (clk => clk, rst => rst, we => dec_out(6), din => din, dout => reg_out6);

    REG7 : reg_module generic map (n => 4)
        port map (clk => clk, rst => rst, we => dec_out(7), din => din, dout => reg_out7);

    -- ── MUX: addr → select which register to read ────────────────────────────
    MUX : mux_8to1 generic map (n => 4)
        port map (
            sel  => addr,
            in0  => reg_out0,
            in1  => reg_out1,
            in2  => reg_out2,
            in3  => reg_out3,
            in4  => reg_out4,
            in5  => reg_out5,
            in6  => reg_out6,
            in7  => reg_out7,
            dout => dout
        );

end structural;
