----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:20:50 10/10/2023 
-- Design Name: 
-- Module Name:    Memoria - arqMemoria 
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

entity Memoria is
    Port ( dato_I : in  STD_LOGIC_VECTOR (7 downto 0);
           O_r : out  STD_LOGIC_VECTOR (7 downto 0);
           O_d : out  STD_LOGIC_VECTOR (7 downto 0);
           sel_w : in  STD_LOGIC_VECTOR (4 downto 0);
           en_w : in  STD_LOGIC;
           sel_read_r : in  STD_LOGIC_VECTOR (4 downto 0);
           sel_read_d : in  STD_LOGIC_VECTOR (4 downto 0);
           CLR : in  STD_LOGIC;
           CLK : in  STD_LOGIC);
end Memoria;

architecture arqMemoria of Memoria is
	component mux_32_1 is
		 Port ( sel_read_MUX : in  STD_LOGIC_VECTOR (4 downto 0);
				  I : in  STD_LOGIC_VECTOR (255 downto 0);
				  O : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component decodificador5_32 is
    Port ( en_w : in  STD_LOGIC;
           sel_w : in  STD_LOGIC_VECTOR (4 downto 0);
           O : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	component Registros is
     Port ( CLK, CLR : in STD_LOGIC;
           en : in STD_LOGIC;
			  I : in STD_LOGIC_VECTOR (7 downto 0);
			  Q : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	signal O_aux : STD_LOGIC_VECTOR (31 downto 0);
	signal Q_aux : STD_LOGIC_VECTOR (255 downto 0);

begin
	Registro0 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(0), I => dato_I, Q => Q_aux(7 downto 0));
	Registro1 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(1), I => dato_I, Q => Q_aux(15 downto 8));
	Registro2 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(2), I => dato_I, Q => Q_aux(23 downto 16));
	Registro3 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(3), I => dato_I, Q => Q_aux(31 downto 24));
	Registro4 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(4), I => dato_I, Q => Q_aux(39 downto 32));
	Registro5 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(5), I => dato_I, Q => Q_aux(47 downto 40));
	Registro6 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(6), I => dato_I, Q => Q_aux(55 downto 48));
	Registro7 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(7), I => dato_I, Q => Q_aux(63 downto 56));
	Registro8 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(8), I => dato_I, Q => Q_aux(71 downto 64));
	Registro9 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(9), I => dato_I, Q => Q_aux(79 downto 72));
	Registro10 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(10), I => dato_I, Q => Q_aux(87 downto 80));
	Registro11 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(11), I => dato_I, Q => Q_aux(95 downto 88));
	Registro12 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(12), I => dato_I, Q => Q_aux(103 downto 96));
	Registro13 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(13), I => dato_I, Q => Q_aux(111 downto 104));
	Registro14 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(14), I => dato_I, Q => Q_aux(119 downto 112));
	Registro15 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(15), I => dato_I, Q => Q_aux(127 downto 120));
	Registro16 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(16), I => dato_I, Q => Q_aux(135 downto 128));
	Registro17 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(17), I => dato_I, Q => Q_aux(143 downto 136));
	Registro18 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(18), I => dato_I, Q => Q_aux(151 downto 144));
	Registro19 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(19), I => dato_I, Q => Q_aux(159 downto 152));
	Registro20 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(20), I => dato_I, Q => Q_aux(167 downto 160));
	Registro21 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(21), I => dato_I, Q => Q_aux(175 downto 168));
	Registro22 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(22), I => dato_I, Q => Q_aux(183 downto 176));
	Registro23 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(23), I => dato_I, Q => Q_aux(191 downto 184));
	Registro24 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(24), I => dato_I, Q => Q_aux(199 downto 192));
	Registro25 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(25), I => dato_I, Q => Q_aux(207 downto 200));
	Registro26 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(26), I => dato_I, Q => Q_aux(215 downto 208));
	Registro27 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(27), I => dato_I, Q => Q_aux(223 downto 216));
	Registro28 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(28), I => dato_I, Q => Q_aux(231 downto 224));
	Registro29 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(29), I => dato_I, Q => Q_aux(239 downto 232));
	Registro30 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(30), I => dato_I, Q => Q_aux(247 downto 240));
	Registro31 : Registros port map (CLK => CLK, CLR => CLR, en => O_aux(31), I => dato_I, Q => Q_aux(255 downto 248));
	
	Deco : decodificador5_32 port map (en_w => en_w, sel_w => sel_w, O => O_aux);
	
	MUX_R : mux_32_1 port map (sel_read_MUX => sel_read_r, I => Q_aux, O => O_r);
	MUX_D : mux_32_1 port map (sel_read_MUX => sel_read_d, I => Q_aux, O => O_d);

end arqMemoria;