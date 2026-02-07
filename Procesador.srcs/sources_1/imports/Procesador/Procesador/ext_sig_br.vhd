----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:36:56 10/26/2023 
-- Design Name: 
-- Module Name:    ext_sig_br - Behavioral 
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

entity ext_sig_br is
    Port ( Ib : in  STD_LOGIC_VECTOR (15 downto 0);
           Ob : out  STD_LOGIC_VECTOR (15 downto 0));
end ext_sig_br;

architecture arqBR of ext_sig_br is
begin
	Ob(6 downto 0)<=Ib(9 downto 3);
	Ob(7)<=Ib(9);
	Ob(8)<=Ib(9);
	Ob(9)<=Ib(9);
	Ob(10)<=Ib(9);
	Ob(11)<=Ib(9);
	Ob(12)<=Ib(9);
	Ob(13)<=Ib(9);
	Ob(14)<=Ib(9);
	Ob(15)<=Ib(9);
end arqBR;