library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ============================================================
-- Vending Machine Controller (FSM)
-- ============================================================
entity vending_machine_ctrl is
    port(
        clk               : in  std_logic;
        rst               : in  std_logic;
        lock              : in  std_logic;
        soda_reserved     : in  std_logic;
        soda_price        : in  std_logic_vector(11 downto 0);
        soda_req          : in  std_logic;
        soda_drop         : out std_logic;
        deposit_amt       : in  std_logic_vector(11 downto 0);
        deposit_incr      : out std_logic;
        deposit_decr      : out std_logic;
        coin_push         : in  std_logic;
        coin_amt          : in  std_logic_vector(11 downto 0);
        coin_reject       : out std_logic;
        error_amt         : out std_logic;
        error_reserved    : out std_logic
    );
end vending_machine_ctrl;

architecture behavioral of vending_machine_ctrl is

    -- FSM states
    type state_type is (
        IDLE,
        COIN_CHECK,
        COIN_ACCEPT,
        COIN_DECLINE,
        SODA_CHECK,
        SODA_ACCEPT,
        SODA_ACCEPT_WAIT,
        SODA_DECLINE_AMT,
        SODA_DECLINE_RESERVED
    );

    signal state      : state_type;
    signal next_state : state_type;

    -- $10.00 limit in cents
    constant MAX_DEPOSIT : unsigned(11 downto 0) := to_unsigned(1000, 12);

begin

    -- ── State register ────────────────────────────────────────────────────────
    STATE_REG : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' then
                state <= IDLE;
            else
                state <= next_state;
            end if;
        end if;
    end process;

    -- ── Next state logic ──────────────────────────────────────────────────────
    NEXT_STATE_LOGIC : process(state, coin_push, soda_req, lock,
                                coin_amt, deposit_amt, soda_reserved, soda_price)
        variable total : unsigned(11 downto 0);
    begin
        total := unsigned(coin_amt) + unsigned(deposit_amt);
        next_state <= state; -- default: stay

        case state is

            when IDLE =>
                if coin_push = '1' then
                    next_state <= COIN_CHECK;
                elsif soda_req = '1' then
                    next_state <= SODA_CHECK;
                end if;

            when COIN_CHECK =>
                if total > MAX_DEPOSIT then
                    next_state <= COIN_DECLINE;
                else
                    next_state <= COIN_ACCEPT;
                end if;

            when COIN_ACCEPT =>
                next_state <= IDLE;

            when COIN_DECLINE =>
                if lock = '0' then
                    next_state <= IDLE;
                end if;

            when SODA_CHECK =>
                if soda_reserved = '1' then
                    next_state <= SODA_DECLINE_RESERVED;
                elsif unsigned(deposit_amt) >= unsigned(soda_price) then
                    next_state <= SODA_ACCEPT;
                else
                    next_state <= SODA_DECLINE_AMT;
                end if;

            when SODA_ACCEPT =>
                next_state <= SODA_ACCEPT_WAIT;

            when SODA_ACCEPT_WAIT =>
                if lock = '0' then
                    next_state <= IDLE;
                end if;

            when SODA_DECLINE_AMT =>
                if lock = '0' then
                    next_state <= IDLE;
                end if;

            when SODA_DECLINE_RESERVED =>
                if lock = '0' then
                    next_state <= IDLE;
                end if;

        end case;
    end process;

    -- ── Output logic ──────────────────────────────────────────────────────────
    OUTPUT_LOGIC : process(state)
    begin
        -- default all outputs low
        soda_drop      <= '0';
        deposit_incr   <= '0';
        deposit_decr   <= '0';
        coin_reject    <= '0';
        error_amt      <= '0';
        error_reserved <= '0';

        case state is
            when COIN_ACCEPT =>
                deposit_incr <= '1';

            when COIN_DECLINE =>
                coin_reject  <= '1';

            when SODA_ACCEPT =>
                deposit_decr <= '1';

            when SODA_ACCEPT_WAIT =>
                soda_drop    <= '1';

            when SODA_DECLINE_AMT =>
                error_amt    <= '1';

            when SODA_DECLINE_RESERVED =>
                error_reserved <= '1';

            when others =>
                null;
        end case;
    end process;

end behavioral;


-- ============================================================
-- Soda List
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soda_list is
    port(
        sel         : in  std_logic_vector(3 downto 0);
        reserved    : out std_logic;
        price       : out std_logic_vector(11 downto 0)
    );
end soda_list;

architecture data_flow of soda_list is
begin
    with sel select price <=
        x"037" when "0000",  -- 55 cents
        x"055" when "0001",  -- 85 cents
        x"05F" when "0010",  -- 95 cents
        x"07D" when "0011",  -- 125 cents
        x"087" when "0100",  -- 135 cents
        x"096" when "0101",  -- 150 cents
        x"0E1" when "0110",  -- 225 cents
        x"0FA" when "0111",  -- 250 cents
        x"12C" when "1000",  -- 300 cents
        x"000" when others;  -- reserved

    reserved <= '1' when unsigned(sel) > 8 else '0';
end data_flow;


-- ============================================================
-- Coin List
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;

entity coin_list is
    port(
        sel         : in  std_logic_vector(1 downto 0);
        amt         : out std_logic_vector(11 downto 0)
    );
end coin_list;

architecture data_flow of coin_list is
begin
    with sel select amt <=
        x"001" when "00",   -- 1 cent
        x"005" when "01",   -- 5 cents
        x"00A" when "10",   -- 10 cents
        x"019" when "11",   -- 25 cents
        x"000" when others;
end data_flow;


-- ============================================================
-- Deposit Register
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity deposit_register is
    port(
        clk       : in  std_logic;
        rst       : in  std_logic;
        incr      : in  std_logic;
        incr_amt  : in  std_logic_vector(11 downto 0);
        decr      : in  std_logic;
        decr_amt  : in  std_logic_vector(11 downto 0);
        amt       : out std_logic_vector(11 downto 0)
    );
end deposit_register;

architecture behavioral of deposit_register is
    signal amt_reg : std_logic_vector(11 downto 0);
begin
    DEPOSIT_REG : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' then
                amt_reg <= x"000";
            elsif incr = '1' then
                amt_reg <= std_logic_vector(unsigned(amt_reg) + unsigned(incr_amt));
            elsif decr = '1' then
                amt_reg <= std_logic_vector(unsigned(amt_reg) - unsigned(decr_amt));
            end if;
        end if;
    end process;

    amt <= amt_reg;
end behavioral;


-- ============================================================
-- Vending Machine Subsystem (structural top)
-- ============================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vending_machine_subsystem is
    port(
        clk             : in  std_logic;
        rst             : in  std_logic;
        lock            : in  std_logic;
        soda_sel        : in  std_logic_vector(3 downto 0);
        soda_req        : in  std_logic;
        coin_push       : in  std_logic;
        coin_sel        : in  std_logic_vector(1 downto 0);
        coin_reject     : out std_logic;
        soda_reserved   : out std_logic;
        soda_price      : out std_logic_vector(11 downto 0);
        soda_drop       : out std_logic;
        deposit_amt     : out std_logic_vector(11 downto 0);
        error_amt       : out std_logic;
        error_reserved  : out std_logic
    );
end vending_machine_subsystem;

architecture structural of vending_machine_subsystem is

    component vending_machine_ctrl is
        port(
            clk               : in  std_logic;
            rst               : in  std_logic;
            lock              : in  std_logic;
            soda_reserved     : in  std_logic;
            soda_price        : in  std_logic_vector(11 downto 0);
            soda_req          : in  std_logic;
            soda_drop         : out std_logic;
            deposit_amt       : in  std_logic_vector(11 downto 0);
            deposit_incr      : out std_logic;
            deposit_decr      : out std_logic;
            coin_push         : in  std_logic;
            coin_amt          : in  std_logic_vector(11 downto 0);
            coin_reject       : out std_logic;
            error_amt         : out std_logic;
            error_reserved    : out std_logic
        );
    end component;

    component soda_list is
        port(
            sel         : in  std_logic_vector(3 downto 0);
            reserved    : out std_logic;
            price       : out std_logic_vector(11 downto 0)
        );
    end component;

    component coin_list is
        port(
            sel         : in  std_logic_vector(1 downto 0);
            amt         : out std_logic_vector(11 downto 0)
        );
    end component;

    component deposit_register is
        port(
            clk         : in  std_logic;
            rst         : in  std_logic;
            incr        : in  std_logic;
            incr_amt    : in  std_logic_vector(11 downto 0);
            decr        : in  std_logic;
            decr_amt    : in  std_logic_vector(11 downto 0);
            amt         : out std_logic_vector(11 downto 0)
        );
    end component;

    signal soda_reserved_s : std_logic;
    signal soda_price_s    : std_logic_vector(11 downto 0);
    signal deposit_amt_s   : std_logic_vector(11 downto 0);
    signal deposit_incr_s  : std_logic;
    signal deposit_decr_s  : std_logic;
    signal coin_amt_s      : std_logic_vector(11 downto 0);

begin

    u_vending_machine_ctrl : vending_machine_ctrl
    port map (
        clk            => clk,
        rst            => rst,
        lock           => lock,
        soda_reserved  => soda_reserved_s,
        soda_price     => soda_price_s,
        soda_req       => soda_req,
        soda_drop      => soda_drop,
        deposit_amt    => deposit_amt_s,
        deposit_incr   => deposit_incr_s,
        deposit_decr   => deposit_decr_s,
        coin_push      => coin_push,
        coin_amt       => coin_amt_s,
        coin_reject    => coin_reject,
        error_amt      => error_amt,
        error_reserved => error_reserved
    );

    u_soda_list : soda_list
    port map (
        sel      => soda_sel,
        reserved => soda_reserved_s,
        price    => soda_price_s
    );

    u_coin_list : coin_list
    port map (
        sel => coin_sel,
        amt => coin_amt_s
    );

    u_deposit_register : deposit_register
    port map (
        clk      => clk,
        rst      => rst,
        incr     => deposit_incr_s,
        incr_amt => coin_amt_s,
        decr     => deposit_decr_s,
        decr_amt => soda_price_s,
        amt      => deposit_amt_s
    );

    soda_reserved <= soda_reserved_s;
    soda_price    <= soda_price_s;
    deposit_amt   <= deposit_amt_s;

end structural;
