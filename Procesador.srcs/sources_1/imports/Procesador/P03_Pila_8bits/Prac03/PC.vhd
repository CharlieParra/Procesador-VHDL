----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:33:09 10/02/2023 
-- Design Name: 
-- Module Name:    program_c - Behavioral 
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

entity PC is
    Port ( CLK : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           I : in  STD_LOGIC_VECTOR (15 downto 0);
           O : out  STD_LOGIC_VECTOR (15 downto 0));
end PC;

architecture arqPC of PC is
	signal q_aux : STD_LOGIC_VECTOR (15 downto 0);
begin
	process (CLK, CLR)
	begin
	   if (CLR = '1') then
			q_aux <= (others => '0');
      elsif (CLK'event and CLK = '1')then
			q_aux <= I;
	   end if;
	end process;
	
   O <= q_aux;
	
end arqPC;