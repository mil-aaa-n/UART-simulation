library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_top is
Port(
clk      : in STD_LOGIC;
reset    : in STD_LOGIC;
start    : in STD_LOGIC;
data_in  : in STD_LOGIC_VECTOR(7 downto 0);
rx       : in STD_LOGIC;
tx       : out STD_LOGIC;
data_out : out STD_LOGIC_VECTOR(7 downto 0);
ready    : out STD_LOGIC
);
end uart_top;

architecture Behavioral of uart_top is

signal tick : STD_LOGIC;

component baud_gen
Port(
clk   : in STD_LOGIC;
reset : in STD_LOGIC;
tick  : out STD_LOGIC
);
end component;

component uart_tx
Port(
clk     : in STD_LOGIC;
reset   : in STD_LOGIC;
tick    : in STD_LOGIC;
start   : in STD_LOGIC;
data_in : in STD_LOGIC_VECTOR(7 downto 0);
tx      : out STD_LOGIC;
busy    : out STD_LOGIC
);
end component;

component uart_rx
Port(
clk        : in STD_LOGIC;
reset      : in STD_LOGIC;
tick       : in STD_LOGIC;
rx         : in STD_LOGIC;
data_out   : out STD_LOGIC_VECTOR(7 downto 0);
data_ready : out STD_LOGIC
);
end component;

signal busy : STD_LOGIC;

begin

baud: baud_gen
port map(
clk => clk,
reset => reset,
tick => tick
);

transmitter: uart_tx
port map(
clk => clk,
reset => reset,
tick => tick,
start => start,
data_in => data_in,
tx => tx,
busy => busy
);

receiver: uart_rx
port map(
clk => clk,
reset => reset,
tick => tick,
rx => rx,
data_out => data_out,
data_ready => ready
);

end Behavioral;
