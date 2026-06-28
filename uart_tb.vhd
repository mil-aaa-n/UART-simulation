library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_tb is
end uart_tb;

architecture Behavioral of uart_tb is

signal clk : STD_LOGIC := '0';
signal reset : STD_LOGIC := '0';
signal start : STD_LOGIC := '0';
signal data_in : STD_LOGIC_VECTOR(7 downto 0);
signal tx : STD_LOGIC;
signal rx : STD_LOGIC;
signal data_out : STD_LOGIC_VECTOR(7 downto 0);
signal ready : STD_LOGIC;

begin

clk <= not clk after 5 ns;

rx <= tx;

uut: entity work.uart_top
port map(
clk => clk,
reset => reset,
start => start,
data_in => data_in,
rx => rx,
tx => tx,
data_out => data_out,
ready => ready
);

process
begin

reset <= '1';
wait for 20 ns;
reset <= '0';

-- send 'm'
data_in <= "01101101";
start <= '1';
wait for 10 ns;
start <= '0';
wait for 2 ms;

-- send 'i'
data_in <= "01101001";
start <= '1';
wait for 10 ns;
start <= '0';
wait for 2 ms;

-- send 'l'
data_in <= "01101100";
start <= '1';
wait for 10 ns;
start <= '0';
wait for 2 ms;

-- send 'a'
data_in <= "01100001";
start <= '1';
wait for 10 ns;
start <= '0';
wait for 2 ms;

-- send 'n'
data_in <= "01101110";
start <= '1';
wait for 10 ns;
start <= '0';
wait for 2 ms;

wait;

end process;

end Behavioral;
