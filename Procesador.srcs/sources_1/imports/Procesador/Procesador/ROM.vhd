----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:30:16 11/13/2023 
-- Design Name: 
-- Module Name:    rom - Behavioral 
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

entity rom is
    Port ( Arom : in  STD_LOGIC_VECTOR (15 downto 0);
           Orom : out  STD_LOGIC_VECTOR (15 downto 0));
end rom;

architecture Behavioral of rom is

begin
	Orom <= 	x"e001" when Arom=x"0000" else
				x"e0e0" when Arom=x"0001" else
				x"0fe0" when Arom=x"0002" else
				x"e0f9" when Arom=x"0003" else
				x"1bfe" when Arom=x"0004" else
				x"f3d9" when Arom=x"0005" else
				x"e0f1" when Arom=x"0006" else
				x"1bfe" when Arom=x"0007" else
				x"f0a9" when Arom=x"0008" else
				x"e0f2" when Arom=x"0009" else
				x"1bfe" when Arom=x"000A" else
				x"f0b1" when Arom=x"000B" else
				x"e0f3" when Arom=x"000C" else
				x"1bfe" when Arom=x"000D" else
				x"f0b9" when Arom=x"000E" else
				x"e0f4" when Arom=x"000F" else
				x"1bfe" when Arom=x"0010" else
				x"f0c1" when Arom=x"0011" else
				x"e0f5" when Arom=x"0012" else
				x"1bfe" when Arom=x"0013" else
				x"f0c9" when Arom=x"0014" else
				x"e0f6" when Arom=x"0015" else
				x"1bfe" when Arom=x"0016" else
				x"f0d1" when Arom=x"0017" else
				x"e0f7" when Arom=x"0018" else
				x"1bfe" when Arom=x"0019" else
				x"f0d9" when Arom=x"001A" else
				x"e0f8" when Arom=x"001B" else
				x"1bfe" when Arom=x"001C" else
				--
				x"f0e1" when Arom=x"001D" else
				x"e847" when Arom=x"001E" else
				x"ef5f" when Arom=x"001F" else
				x"ef6f" when Arom=x"0020" else
				x"ef7f" when Arom=x"0021" else
				x"e641" when Arom=x"0022" else
				x"e857" when Arom=x"0023" else
				x"ef6f" when Arom=x"0024" else
				x"ef7f" when Arom=x"0025" else
				x"e143" when Arom=x"0026" else
				x"e651" when Arom=x"0027" else
				x"e867" when Arom=x"0028" else
				x"ef7f" when Arom=x"0029" else
				x"e94f" when Arom=x"002A" else
				x"e153" when Arom=x"002B" else
				x"e661" when Arom=x"002C" else
				x"e877" when Arom=x"002D" else
				x"ef4f" when Arom=x"002E" else
				x"e95f" when Arom=x"002F" else
				x"e163" when Arom=x"0030" else
				x"e671" when Arom=x"0031" else
				x"ef4f" when Arom=x"0032" else
				x"ef5f" when Arom=x"0033" else
				x"e96f" when Arom=x"0034" else
				x"e173" when Arom=x"0035" else
				x"ef4f" when Arom=x"0036" else
				x"ef5f" when Arom=x"0037" else
				x"ef6f" when Arom=x"0038" else
				x"e97f" when Arom=x"0039" else
				x"ef4f" when Arom=x"003A" else
				x"ef5f" when Arom=x"003B" else
				--
				x"ef6f" when Arom=x"003C" else
				x"ef7f" when Arom=x"003D" else
				x"e392" when Arom=x"003E" else
				x"e0d2" when Arom=x"003F" else
				x"2f14" when Arom=x"0040" else
				x"b915" when Arom=x"0041" else
				x"ef3e" when Arom=x"0042" else
				x"b93b" when Arom=x"0043" else
				x"ef8f" when Arom=x"0044" else
				x"ef2f";
end Behavioral;

