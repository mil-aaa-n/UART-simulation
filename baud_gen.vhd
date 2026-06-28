library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity baud_gen is
    Port (
        clk   : in STD_LOGIC;
        reset : in STD_LOGIC;
        tick  : out STD_LOGIC
    );
end baud_gen;

architecture Behavioral of baud_gen is

constant BAUD_DIV : integer := 10416;
signal counter : integer range 0 to BAUD_DIV := 0;

begin

process(clk, reset)
begin
    if reset = '1' then
        counter <= 0;
        tick <= '0';

    elsif rising_edge(clk) then

        if counter = BAUD_DIV then
            counter <= 0;
            tick <= '1';
        else
            counter <= counter + 1;
            tick <= '0';
        end if;

    end if;
end process;

end Behavioral;
