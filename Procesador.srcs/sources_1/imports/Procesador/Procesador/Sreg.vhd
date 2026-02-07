----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:25:32 11/14/2023 
-- Design Name: 
-- Module Name:    Sreg - arqSreg 
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

entity Sreg is
    Port ( CLK : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
			  enb : in  STD_LOGIC;
           ent : in  STD_LOGIC;
           sal : out  STD_LOGIC);
end Sreg;

architecture arqSreg of Sreg is
	signal q_aux : STD_LOGIC;
begin
	process (CLK, CLR, enb)
	begin
		if (CLR = '1') then
			q_aux <= '0';
		elsif (CLK'event and CLK = '1' and enb = '1') then
			q_aux <= ent;
		end if;
	end process;
	
	sal <= q_aux;

end arqSreg;