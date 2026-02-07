----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:32:57 11/09/2023 
-- Design Name: 
-- Module Name:    Procesador - arqProcesador 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:09:45 10/30/2023 
-- Design Name: 
-- Module Name:    Procesador - Behavioral 
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

entity Procesador is
    Port ( CLK : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           O_B : out  STD_LOGIC_VECTOR (7 downto 0);
		   O_C : out  STD_LOGIC_VECTOR (7 downto 0));
end Procesador;

architecture arqProcesador of Procesador is
	component DecodificadorPrincipal is
		 Port ( I : in STD_LOGIC_VECTOR (15 downto 0);					-- Código de entrada
				  sel_read_d : out STD_LOGIC_VECTOR (4 downto 0);		-- Selector de Lectura registro destino
				  sel_read_r : out STD_LOGIC_VECTOR (4 downto 0);		-- Selector de Lectura registro fuente
				  sel_wd : out STD_LOGIC_VECTOR (4 downto 0);			-- Selector de Escritura
				  sel_ALU : out STD_LOGIC_VECTOR (2 downto 0);			-- Selector ALU
				  S : out STD_LOGIC_VECTOR (1 downto 0);					-- Selector de Carga y Retención
				  imm : out STD_LOGIC;											-- Carga de inmediato como operador
				  l_d : out STD_LOGIC;											-- Carga de dato a registro destino (ALU e Inmediato ó Registro fuente)
				  sel_rel : out STD_LOGIC;										-- Carga de salto (Instrucción)
				  br : out STD_LOGIC;											-- Salto condicional (Z = 1)
				  en_w : out STD_LOGIC;											-- Habilitar escritura
				  en_port : out STD_LOGIC;										-- Habilitar puerto B
				  en_portC : out STD_LOGIC;									-- Habilitar puerto C
				  en_sreg : out STD_LOGIC;										-- Habilitar Registros de estado (Banderas)
				  ld_mov : out STD_LOGIC;										-- Selección de Carga de dato a registro destino (Desde ALU ó ROM (Inmediato))
				  ret_s : out STD_LOGIC;										-- Retorno condicional
				  bn : out STD_LOGIC);											-- Bandera Z = 0
	end component;
	
	component Memoria is
		 Port ( dato_I : in  STD_LOGIC_VECTOR (7 downto 0);
				  O_r : out  STD_LOGIC_VECTOR (7 downto 0);
				  O_d : out  STD_LOGIC_VECTOR (7 downto 0);
				  sel_w : in  STD_LOGIC_VECTOR (4 downto 0);
				  en_w : in  STD_LOGIC;
				  sel_read_r : in  STD_LOGIC_VECTOR (4 downto 0);
				  sel_read_d : in  STD_LOGIC_VECTOR (4 downto 0);
				  CLR : in  STD_LOGIC;
				  CLK : in  STD_LOGIC);
	end component;
	
	component PC is
		Port ( CLK : in  STD_LOGIC;
				 CLR : in  STD_LOGIC;
				 I : in  STD_LOGIC_VECTOR (15 downto 0);
				 O : out  STD_LOGIC_VECTOR (15 downto 0));
		end component;

	component PortB is
		Port ( CLK : in  STD_LOGIC;
				 CLR : in  STD_LOGIC;
				 en_port : in  STD_LOGIC;
				 I : in  STD_LOGIC_VECTOR (7 downto 0);
				 O : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component PortC is
		Port ( CLK : in  STD_LOGIC;
				 CLR : in  STD_LOGIC;
				 en_port : in  STD_LOGIC;
				 I : in  STD_LOGIC_VECTOR (7 downto 0);
				 O : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component RAM is
		Port( CLK : in STD_LOGIC;
				we : in STD_LOGIC;
				WD : in STD_LOGIC_VECTOR (15 downto 0);
				RD : out STD_LOGIC_VECTOR (15 downto 0);
				A : in STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component ROM is
		Port ( Arom : in  STD_LOGIC_VECTOR (15 downto 0);
				 Orom : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component SP is
		Port ( CLK : in  STD_LOGIC;
				 CLR : in  STD_LOGIC;
				 I_sp : in  STD_LOGIC_VECTOR (3 downto 0);
				 O_sp : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component Sreg is
		Port ( CLK : in  STD_LOGIC;
				 CLR : in  STD_LOGIC;
				 enb : in  STD_LOGIC;
				 ent : in  STD_LOGIC;
				 sal : out  STD_LOGIC);
	end component;
	
	component ext_sig_br is
		Port ( Ib : in  STD_LOGIC_VECTOR (15 downto 0);
				 Ob : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component ext_sig_rjmp is
    Port ( Irjmp : in  STD_LOGIC_VECTOR (15 downto 0);
           Orjmp : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component ALU is
		Port ( D, R : in  STD_LOGIC_VECTOR (7 downto 0);
				 sel_alu : in  STD_LOGIC_VECTOR (2 downto 0);
				 Z : out  STD_LOGIC;
				 F : out STD_LOGIC_VECTOR (7 downto 0));
	end component;

signal I_aux, PC_aux, br_mux_aux, rd_aux, rd_aux_sum, off_br_aux, off_rjmp_aux, offset_aux, I_PC_aux : STD_LOGIC_VECTOR (15 downto 0);
signal dato_I_aux, O_r_aux, O_d_aux, op_aux, F_aux : STD_LOGIC_VECTOR(7 downto 0);
signal sel_read_r_aux, sel_read_d_aux, sel_w_d : STD_LOGIC_VECTOR(4 downto 0);
signal call_aux, ret_aux, I_sp_aux, O_sp_aux, O_sp_ret_aux : STD_LOGIC_VECTOR(3 downto 0);
signal sel_alu_aux : STD_LOGIC_VECTOR(2 downto 0);
signal S_aux : STD_LOGIC_VECTOR(1 downto 0);
signal imm_aux, en_sreg_aux, branch_aux, ld_aux, sel_rel_aux, br_aux, en_w_aux, en_port_aux, en_portC_aux, ent_sreg_aux, s_sreg_aux, ld_mov_aux, ret_s_aux, Bn_aux : STD_LOGIC;

begin
	offset_aux <= x"0001" when sel_rel_aux = '0' and branch_aux = '0' else
					  off_br_aux + 1 when sel_rel_aux = '0' and branch_aux = '1' else
					  off_rjmp_aux + 1;
					
	I_PC_aux <= offset_aux + PC_aux;

	br_mux_aux <= I_PC_aux when ret_s_aux = '0' else
					  rd_aux_sum;

	dato_I_aux <= I_aux(11 downto 8) & I_aux(3 downto 0) when ld_mov_aux = '0' and ld_aux = '0' else
					  O_r_aux when ld_mov_aux = '0' and ld_aux = '1' else
					  F_aux;
					  
	op_aux <= O_r_aux when imm_aux = '0' else
				 I_aux(11 downto 8) & I_aux(3 downto 0);
						
	branch_aux <= ((not s_sreg_aux) and Bn_aux) or (br_aux and s_sreg_aux);
	
	call_aux <= O_sp_aux - 2;
	
	ret_aux <= O_sp_aux + 2;
	
	I_sp_aux <= O_sp_aux when S_aux(1) = '0' and S_aux(0) = '0' else
					call_aux when S_aux(1) = '0' and S_aux(0) = '1' else
					ret_aux;
					
	O_sp_ret_aux <= O_sp_aux when S_aux(1) = '0' else
						 ret_aux;
	
	rd_aux_sum <= rd_aux + 1;
	
	UnidadControl : DecodificadorPrincipal port map (
		I => I_aux,
		sel_read_d => sel_read_d_aux,
		sel_read_r => sel_read_r_aux,
		sel_wd => sel_w_d,
		sel_ALU => sel_alu_aux,
		S => S_aux,
		imm => imm_aux,
		l_d => ld_aux,
		sel_rel => sel_rel_aux,
		br => br_aux,
		en_w => en_w_aux,
		en_port => en_port_aux,
		en_portC => en_portC_aux,
		en_sreg => en_sreg_aux,
		ld_mov => ld_mov_aux,
		ret_s => ret_s_aux,
		bn => Bn_aux);
					
	Registros : Memoria port map (
		dato_I => dato_I_aux,
		O_r => O_r_aux,
		O_d => O_d_aux,
		sel_w => sel_w_d,
		en_w => en_w_aux,
		sel_read_r => sel_read_r_aux,
		sel_read_d => sel_read_d_aux,
		CLR => CLR,
		CLK => CLK);
		
	ProgramCounter : PC port map (
		CLK => CLK,
		CLR => CLR,
		I => br_mux_aux,
		O => PC_aux);
		
	PuertoB : PortB port map (
		CLK => CLK,
		CLR => CLR,
		en_port => en_port_aux,
		I => O_r_aux,
		O => O_B);
		
	PuertoC : PortC port map (
		CLK => CLK,
		CLR => CLR,
		en_port => en_portC_aux,
		I => O_r_aux,
		O => O_C);
		
	RandomAccessMemory : RAM port map (
		CLK => CLK,
		we => S_aux(0),
		WD => PC_aux,
		RD => rd_aux,
		A => O_sp_ret_aux);
		
	ReadOnlyMemory : ROM port map (
		Arom => PC_aux,
		Orom => I_aux);
		
	StackPointer : SP port map (
		CLK => CLK,
		CLR => CLR,
		I_sp => I_sp_aux, 
		O_sp => O_sp_aux);
	
	RegistroBanderaZ : Sreg port map (
		CLK => CLK,
		CLR => CLR,
		enb => en_sreg_aux,
		ent => ent_sreg_aux,
		sal => s_sreg_aux);
		
	Branch : ext_sig_br port map (
		Ib => I_aux,
		Ob => off_br_aux);
		
	RJMP : ext_sig_rjmp port map (
		Irjmp => I_aux,
      Orjmp => off_rjmp_aux);
	
	ArithmeticLogicUnit : ALU port map (
		D => O_d_aux,
		R => op_aux,
		sel_alu => sel_alu_aux,
		Z => ent_sreg_aux,
		F => F_aux);
		
end arqProcesador;