----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:05:17 11/14/2023 
-- Design Name: 
-- Module Name:    ext_sig_rjmp - arqRJMP 
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

entity ext_sig_rjmp is
    Port ( Irjmp : in  STD_LOGIC_VECTOR (15 downto 0);
           Orjmp : out  STD_LOGIC_VECTOR (15 downto 0));
end ext_sig_rjmp;

architecture arqRJMP of ext_sig_rjmp is
begin

	Orjmp(11 downto 0) <= Irjmp(11 downto 0);
	Orjmp(12) <= Irjmp(11);
	Orjmp(13) <= Irjmp(11);
	Orjmp(14) <= Irjmp(11);
	Orjmp(15) <= Irjmp(11);
	
end arqRJMP;