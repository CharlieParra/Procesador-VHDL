----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:54:07 10/10/2023 
-- Design Name: 
-- Module Name:    Registro - Behavioral 
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

entity Registros is
     Port ( CLK, CLR : in STD_LOGIC;
				en : in STD_LOGIC;
				I : in STD_LOGIC_VECTOR (7 downto 0);
				Q : out STD_LOGIC_VECTOR (7 downto 0));
end Registros;

architecture ArqRegistros of Registros is
	signal q_aux : STD_LOGIC_VECTOR (7 downto 0);
begin
	Process (CLK, CLR, en)
	begin
		if (CLR = '1') then
			q_aux <= "00000000";
		elsif (CLK'event and CLK = '1' and  en = '1') then
			
			q_aux <= I;
				
		end if;
	end Process;
	
	Q <= q_aux;
	
end ArqRegistros;

