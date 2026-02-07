library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM is
  Port( CLK : in STD_LOGIC;
        we : in STD_LOGIC;
        WD : in STD_LOGIC_VECTOR (15 downto 0);
        RD : out STD_LOGIC_VECTOR (15 downto 0);
        A : in STD_LOGIC_VECTOR (3 downto 0));
end RAM;

architecture Behavioral of RAM is
	type ram is array (15 downto 0) of STD_LOGIC_VECTOR (15 downto 0);
	signal dato: ram;
begin
	process (CLK, we)
	begin
		if(CLK'event and CLK = '1' and we = '1') then
			dato(conv_integer (A)) <= WD;
		end if;
	end process;

RD <= dato(conv_integer (A));

end architecture;