----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:28:38 09/11/2023 
-- Design Name: 
-- Module Name:    Multiplexor - ArqMultiplexor 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( D, R : in  STD_LOGIC_VECTOR (7 downto 0);
			  sel_alu : in  STD_LOGIC_VECTOR (2 downto 0);
			  Z : out  STD_LOGIC;
			  F : out STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture arqALU of ALU is	
	signal F_aux : STD_LOGIC_VECTOR (7 downto 0);
begin
	process (D, R, sel_alu)
		begin
			if (sel_alu = "000") then F_aux <= D + R;
         elsif (sel_alu = "001") then F_aux <= D - R;
		   elsif (sel_alu = "010") then F_aux <= D and R;
         elsif (sel_alu = "011") then F_aux <= D or R;
         elsif (sel_alu = "100") then F_aux <= D xor R;
         elsif (sel_alu = "101") then F_aux <= not D;
         elsif (sel_alu = "110") then F_aux (7 downto 1) <= D (6 downto 0);
				  F_aux(0) <= '0';
         else F_aux (6 downto 0) <= D (7 downto 1);
				  F_aux(7) <= '0';
         end if;
	end process;
	
	Z <= not (F_aux(7) or F_aux(6) or F_aux(5) or F_aux(4) or F_aux(3) or F_aux(2) or F_aux(1) or F_aux(0));
	
	F <= F_aux;
	
end arqALU;