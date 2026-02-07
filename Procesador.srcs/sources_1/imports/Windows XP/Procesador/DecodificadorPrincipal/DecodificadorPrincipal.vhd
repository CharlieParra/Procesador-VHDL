----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:52:08 11/06/2023 
-- Design Name: 
-- Module Name:    DecodificadorPrincipal - arqDecodificadorPrincipal 
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

entity DecodificadorPrincipal is
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
end DecodificadorPrincipal;

architecture arqDecodificadorPrincipal of DecodificadorPrincipal is
begin
	process (I)
	begin
		case (I(15 downto 12)) is
			when "0000" => -- add, lsl, nop
				if (I(11 downto 10) = "00") then -- nop : No Operation :D
					sel_read_d <= "00000";
					sel_read_r <= "00000";
					sel_wd <= "00000";
					sel_ALU <= "000";
					S <= "00";
					imm <= '0';
					l_d <= '0';
					sel_rel <= '0';
					br <= '0';
					en_w <= '0';
					en_port <= '0';
					en_portC <= '0';
					en_sreg <= '0';
					ld_mov <= '0';
					ret_s <= '0';
					bn <= '0';
					
				elsif (I(11 downto 10) = "11") then -- lsl, add
					if (I(9) & I(3 downto 0) = I(8 downto 4)) then --lsl : Logical Shift Left :D
						sel_read_d <= I(9) & I(7 downto 4);
						sel_read_r <= "00000";
						sel_wd <= I(9) & I(7 downto 4);
						sel_ALU <= "110";
						S <= "00";
						imm <= '0';
						l_d <= '1';
						sel_rel <= '0';
						br <= '0';
						en_w <= '1';
						en_port <= '0';
						en_portC <= '0';
						en_sreg <= '1';
						ld_mov <= '1';
						ret_s <= '0';
						bn <= '0';
					
					else --add : Addition :D
						sel_read_d <= I(8 downto 4);
						sel_read_r <= I(9) & I(3 downto 0);
						sel_wd <= I(8 downto 4);
						sel_ALU <= "000";
						S <= "00";
						imm <= '0';
						l_d <= '0';
						sel_rel <= '0';
						br <= '0';
						en_w <= '1';
						en_port <= '0';
						en_portC <= '0';
						en_sreg <= '1';
						ld_mov <= '1';
						ret_s <= '0';
						bn <= '0';
					end if;
				end if;
				
			when "0001" => -- cp, sub
				if (I(11 downto 10) = "01") then -- cp : Compare :D
					sel_read_d <= I(8 downto 4);
					sel_read_r <= I(9) & I(3 downto 0);
					sel_wd <= I(8 downto 4);
					sel_ALU <= "001";
					S <= "00";
					imm <= '0';
					l_d <= '0';
					sel_rel <= '0';
					br <= '0';
					en_w <= '0';
					en_port <= '0';
					en_portC <= '0';
					en_sreg <= '1';
					ld_mov <= '1';
					ret_s <= '0';
					bn <= '0';
					
				else -- sub : Subtraction :D
					sel_read_d <= I(8 downto 4);
					sel_read_r <= I(9) & I(3 downto 0);
					sel_wd <= I(8 downto 4);
					sel_ALU <= "001";
					S <= "00";
					imm <= '0';
					l_d <= '0';
					sel_rel <= '0';
					br <= '0';
					en_w <= '1';
					en_port <= '0';
					en_portC <= '0';
					en_sreg <= '1';
					ld_mov <= '1';
					ret_s <= '0';
					bn <= '0';
				end if;
			
			when "0011" => -- cpi : Compare Immediate :D
				sel_read_d <= '1' & I(7 downto 4);
				sel_read_r <= "00000";
				sel_wd <= '1' & I(7 downto 4);
				sel_ALU <= "001";
				S <= "00";
				imm <= '1';
				l_d <= '0';
				sel_rel <= '0';
				br <= '0';
				en_w <= '0';
				en_port <= '0';
				en_portC <= '0';
				en_sreg <= '1';
				ld_mov <= '1';
				ret_s <= '0';
				bn <= '0';
				
			when "0010" => -- and, or, eor, mov
				if (I(11 downto 10) = "00") then -- and : AND :D
						sel_read_d <= I(8 downto 4);
						sel_read_r <= I(9) & I(3 downto 0);
						sel_wd <= I(8 downto 4);
						sel_ALU <= "010";
						S <= "00";
						imm <= '0';
						l_d <= '0';
						sel_rel <= '0';
						br <= '0';
						en_w <= '1';
						en_port <= '0';
						en_portC <= '0';
						en_sreg <= '1';
						ld_mov <= '1';
						ret_s <= '0';
						bn <= '0';
						
				elsif (I(11 downto 10) = "10") then -- or : OR :D
						sel_read_d <= I(8 downto 4);
						sel_read_r <= I(9) & I(3 downto 0);
						sel_wd <= I(8 downto 4);
						sel_ALU <= "011";
						S <= "00";
						imm <= '0';
						l_d <= '0';
						sel_rel <= '0';
						br <= '0';
						en_w <= '1';
						en_port <= '0';
						en_portC <= '0';
						en_sreg <= '1';
						ld_mov <= '1';
						ret_s <= '0';
						bn <= '0';
						
				elsif (I(11 downto 10) = "01") then -- eor : Exclusive Or :D
						sel_read_d <= I(8 downto 4);
						sel_read_r <= I(9) & I(3 downto 0);
						sel_wd <= I(8 downto 4);
						sel_ALU <= "100";
						S <= "00";
						imm <= '0';
						l_d <= '0';
						sel_rel <= '0';
						br <= '0';
						en_w <= '1';
						en_port <= '0';
						en_portC <= '0';
						en_sreg <= '1';
						ld_mov <= '1';
						ret_s <= '0';
						bn <= '0';
						
				else -- mov : Move :D
						sel_read_d <= I(8 downto 4);
						sel_read_r <= I(9) & I(3 downto 0);
						sel_wd <= I(8 downto 4);
						sel_ALU <= "000";
						S <= "00";
						imm <= '0';
						l_d <= '1';
						sel_rel <= '0';
						br <= '0';
						en_w <= '1';
						en_port <= '0';
						en_portC <= '0';
						en_sreg <= '0';
						ld_mov <= '0';
						ret_s <= '0';
						bn <= '0';
				end if;
			
			when "1001" => -- com, lsr, ret
				if (I(3 downto 0) = "0000") then -- com : One's Complement :D
					sel_read_d <= I(8 downto 4);
					sel_read_r <= "00000";
					sel_wd <= I(8 downto 4);
					sel_ALU <= "101";
					S <= "00";
					imm <= '0';
					l_d <= '0';
					sel_rel <= '0';
					br <= '0';
					en_w <= '1';
					en_port <= '0';
					en_portC <= '0';
					en_sreg <= '1';
					ld_mov <= '1';
					ret_s <= '0';
					bn <= '0';
				
				elsif (I(3 downto 0) = "0110") then -- lsr : Logical Shift Right :D
					sel_read_d <= I(8 downto 4);
					sel_read_r <= I(9) & I(3 downto 0);
					sel_wd <= I(8 downto 4);
					sel_ALU <= "111";
					S <= "10";
					imm <= '0';
					l_d <= '0';
					sel_rel <= '0';
					br <= '0';
					en_w <= '1';
					en_port <= '0';
					en_portC <= '0';
					en_sreg <= '1';
					ld_mov <= '1';
					ret_s <= '0';
					bn <= '0';
					
				else -- ret : Return from Procedure
					sel_read_d <= "00000";
					sel_read_r <= "00000";
					sel_wd <= "00000";
					sel_ALU <= "000";
					S <= "10";
					imm <= '0';
					l_d <= '0';
					sel_rel <= '0';
					br <= '0';
					en_w <= '0';
					en_port <= '0';
					en_portC <= '0';
					en_sreg <= '0';
					ld_mov <= '0';
					ret_s <= '1';
					bn <= '0';
				end if;
				
			when "1110" => -- ldi : Load Immediate :D
				sel_read_d <= '1' & I(7 downto 4);
				sel_read_r <= "00000";
				sel_wd <= '1' & I(7 downto 4);
				sel_ALU <= "000";
				S <= "00";
				imm <= '0';
				l_d <= '0';
				sel_rel <= '0';
				br <= '0';
				en_w <= '1';
				en_port <= '0';
				en_portC <= '0';
				en_sreg <= '0';
				ld_mov <= '0';
				ret_s <= '0';
				bn <= '0';
			
			when "1111" => -- breq, brne
				if (I(11 downto 10) = "00") then -- breq : Branch if Equal :D
					sel_read_d <= "00000";
					sel_read_r <= "00000";
					sel_wd <= "00000";
					sel_ALU <= "000";
					S <= "00";
					imm <= '0';
					l_d <= '0';
					sel_rel <= '0';
					br <= '1';
					en_w <= '0';
					en_port <= '0';
					en_portC <= '0';
					en_sreg <= '0';
					ld_mov <= '0';
					ret_s <= '0';
					bn <= '0';
					
				else -- brne : Branch if not Equal :D
					sel_read_d <= "00000";
					sel_read_r <= "00000";
					sel_wd <= "00000";
					sel_ALU <= "000";
					S <= "00";
					imm <= '0';
					l_d <= '0';
					sel_rel <= '0';
					br <= '0';
					en_w <= '0';
					en_port <= '0';
					en_portC <= '0';
					en_sreg <= '0';
					ld_mov <= '0';
					ret_s <= '0';
					bn <= '1';
				end if;
			
			when "1101" => -- rcall : Relative Call
				sel_read_d <= "00000";
				sel_read_r <= "00000";
				sel_wd <= "00000";
				sel_ALU <= "000";
				S <= "01";
				imm <= '0';
				l_d <= '0';
				sel_rel <= '1';
				br <= '0';
				en_w <= '0';
				en_port <= '0';
				en_portC <= '0';
				en_sreg <= '0';
				ld_mov <= '0';
				ret_s <= '0';
				bn <= '0';
				
			when "1100" => -- rjmp : Relative Jump :D
				sel_read_d <= "00000";
				sel_read_r <= "00000";
				sel_wd <= "00000";
				sel_ALU <= "000";
				S <= "00";
				imm <= '0';
				l_d <= '0';
				sel_rel <= '1';
				br <= '0';
				en_w <= '0';
				en_port <= '0';
				en_portC <= '0';
				en_sreg <= '0';
				ld_mov <= '0';
				ret_s <= '0';
				bn <= '0';
				
			when others => -- out : Output :D
				if (I(3 downto 0) = "0101") then -- portb :D
					sel_read_d <= "00000";
					sel_read_r <= I(8 downto 4);
					sel_wd <= "00000";
					sel_ALU <= "000";
					S <= "00";
					imm <= '0';
					l_d <= '0';
					sel_rel <= '0';
					br <= '0';
					en_w <= '0';
					en_port <= '1';
					en_portC <= '0';
					en_sreg <= '0';
					ld_mov <= '0';
					ret_s <= '0';
					bn <= '0';
					
				else -- portc :D
					sel_read_d <= "00000";
					sel_read_r <= I(8 downto 4);
					sel_wd <= "00000";
					sel_ALU <= "000";
					S <= "00";
					imm <= '0';
					l_d <= '0';
					sel_rel <= '0';
					br <= '0';
					en_w <= '0';
					en_port <= '0';
					en_portC <= '1';
					en_sreg <= '0';
					ld_mov <= '0';
					ret_s <= '0';
					bn <= '0';
				end if;
		end case;
	end process;
end arqDecodificadorPrincipal;