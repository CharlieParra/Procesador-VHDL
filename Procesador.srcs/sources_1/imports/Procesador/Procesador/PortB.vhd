----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:18:26 11/14/2023 
-- Design Name: 
-- Module Name:    PortB - arqPort 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PortB is
    Port ( CLK : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           en_port : in  STD_LOGIC;
           I : in  STD_LOGIC_VECTOR (7 downto 0);
           O : out  STD_LOGIC_VECTOR (7 downto 0));
end PortB;

architecture arqPort of PortB is
	signal q_aux : STD_LOGIC_VECTOR (7 downto 0);
begin
	process (CLK, CLR, en_port)
	begin
		if (CLR = '1') then
			q_aux <= "00000000";
		elsif (CLK'event and CLK = '1' and en_port = '1') then
			q_aux <= I;
		end if;
	end process;
		
	O <= q_aux;
		
end arqPort;