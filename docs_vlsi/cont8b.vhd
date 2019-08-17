library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cont8b is
    Port ( mclk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ip : in  STD_LOGIC;
           LEDS : out STD_LOGIC_VECTOR (7 downto 0));
end cont8b;

architecture Behavioral of cont8b is
signal delay: integer range 0 to 64000000:=0; -- Reloj base 64 MHz
signal div: std_logic:='0';
signal cont: STD_LOGIC_VECTOR (7 downto 0):="00000000";

begin

--divisor @1 Hz
divisor: process(mclk) --frec divisor = Reloj base(mclk) / N => N= (64MHz / 1 Hz)/2 -1 = 31999999
begin
		if rising_edge(mclk) then
			if(delay=31999999) then -- el limite de cuenta para el DIVISOR es N
				delay<=0;
				div<=not div;
			else 
			   delay<=delay+1;
			end if;
		end if;
end process;

contador: process(div,cont)
begin
		if rising_edge(div) then
			if(cont="11111111") then 
				cont<="00000000";
			else 
			   cont<=cont+1;
			end if;
		end if;
end process;

LEDS<=not(cont); -- NOT porque los leds estan conectados en lógica negada

end Behavioral;

