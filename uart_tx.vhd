library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
Port(
clk      : in STD_LOGIC;
reset    : in STD_LOGIC;
tick     : in STD_LOGIC;
start    : in STD_LOGIC;
data_in  : in STD_LOGIC_VECTOR(7 downto 0);
tx       : out STD_LOGIC;
busy     : out STD_LOGIC
);
end uart_tx;

architecture Behavioral of uart_tx is

type state_type is (IDLE, START_BIT, DATA_BITS, STOP_BIT);
signal state : state_type := IDLE;

signal bit_index : integer range 0 to 7 := 0;
signal data_reg  : STD_LOGIC_VECTOR(7 downto 0);

begin

process(clk, reset)
begin
if reset = '1' then
    state <= IDLE;
    tx <= '1';
    busy <= '0';

elsif rising_edge(clk) then

case state is

when IDLE =>
    tx <= '1';
    busy <= '0';

    if start = '1' then
        data_reg <= data_in;
        state <= START_BIT;
        busy <= '1';
    end if;

when START_BIT =>
    if tick = '1' then
        tx <= '0';
        bit_index <= 0;
        state <= DATA_BITS;
    end if;

when DATA_BITS =>
    if tick = '1' then
        tx <= data_reg(bit_index);

        if bit_index = 7 then
            state <= STOP_BIT;
        else
            bit_index <= bit_index + 1;
        end if;
    end if;

when STOP_BIT =>
    if tick = '1' then
        tx <= '1';
        state <= IDLE;
    end if;

end case;

end if;
end process;

end Behavioral;
