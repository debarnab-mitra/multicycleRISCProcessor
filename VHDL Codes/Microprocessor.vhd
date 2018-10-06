library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use work.Pack2.all;

package Pack is
	component TopLevel is 
	port(
		clk:in std_logic;
		reset: in std_logic
	);
	end component;
	component Microprocessor is
	port(
		clk:in std_logic;
		reset: in std_logic;
		mem_enable: out std_logic;
   	r_w: out std_logic;
  		addr: out std_logic_vector(15 downto 0);
   	write_data: out std_logic_vector(15 downto 0); 
   	read_data: in std_logic_vector(15 downto 0));
	end component;

	component DataPath is
	port( --Value of done i/p
		 done : out std_logic;
		 --completed instruction indicator
		 complete : in std_logic;
		 --All control signals o/pc
		 M1_0, M1_1, M2_0, M2_1, M4_0, M4_1, M5_0, M5_1, M5_2, M6_0, M6_1, M8_0, M8_1, M9_0, M9_1, M9_2, M10_0, M11_0, M12_0, M14_0, M15_0, M17_0, ALU_en, OP_bit_0, OP_bit_1, C_en, Z_en, PE_en, RF_write, IR_write, M18_0, T1_en, T2_en, T3_en, T4_en, T5_en: in std_logic;
		 --Value of opcode i/p
		 op_code :out std_logic_vector(3 downto 0);
		 --Value of carry and zero flag i/p
		 C :out std_logic;
		 Z :out std_logic;
		 C_Z :out std_logic_vector (1 downto 0);
		 clk :in std_logic;
		 reset :in std_logic;
		Mem_write_data : out std_logic_vector(15 downto 0);
		Mem_data_out : in std_logic_vector(15 downto 0);
		Mem_add_in: out std_logic_vector(15 downto 0));
	end component;
	
	component ControlPath is
	port(
			 --Value of done i/p
			 done : in std_logic;
			 --completed instruction indicator
			 complete : out std_logic;
			 --All control signals o/p
			 M1_0, M1_1, M2_0, M2_1, M4_0, M4_1, M5_0, M5_1, M5_2, M6_0, M6_1, M8_0, M8_1, M9_0, M9_1, M9_2, M10_0, M11_0, M12_0, M14_0, M15_0, M17_0, ALU_en, OP_bit_0, OP_bit_1, C_en, Z_en, Mem_en, Mem_R_W, PE_en, RF_write, IR_write, M18_0, T1_en, T2_en, T3_en, T4_en, T5_en: out std_logic;
			 --Value of opcode i/p
			 op_code :in std_logic_vector(3 downto 0);
			 --Value of carry and zero flag i/p
			 C :in std_logic;
			 Z :in std_logic;
			 C_Z :in std_logic_vector (1 downto 0);
			 clk :in std_logic;
			 reset :in std_logic);
	end component;
		
	component RFComplete is
	port(A1: in std_logic_vector(2 downto 0);
	A2: in std_logic_vector(2 downto 0);
	A3: in std_logic_vector(2 downto 0);
	D1: out std_logic_vector(15 downto 0);
	D2: out std_logic_vector(15 downto 0);
	D3: in std_logic_vector(15 downto 0);
	RF_write: in std_logic;
	clk : in std_logic;
	reset: in std_logic);
	end component;
	
	component priority_encoder is
   port(x: in std_logic_vector(15 downto 0);
	enable: in std_logic;
   a: out std_logic_vector(2 downto 0);
	i: out std_logic_vector(15 downto 0);
	done: out std_logic);
   end component;
	
	component ALU is
   port(X: in std_logic_vector(15 downto 0);
        Y: in std_logic_vector(15 downto 0);
	clk: in std_logic;
		  alu_enable: in std_logic;
        op_code: in std_logic_vector(1 downto 0); 
		  C: out std_logic;
		  Z: out std_logic;
        R: out std_logic_vector(15 downto 0);
		  alu_done : out std_logic);
   end component;
	
	component memory_new is
   port(clk,reset: in std_logic;
	mem_enable: in std_logic;
   r_w: in std_logic;
  	addr: in std_logic_vector(15 downto 0);
   write_data: in std_logic_vector(15 downto 0); 
   read_data: out std_logic_vector(15 downto 0));
   end component;
	
	component Multiplexor1 is
	port(A: in std_logic_vector(15 downto 0);
   		B: in std_logic_vector(15 downto 0);
   		sel: in std_logic;
   		O: out std_logic_vector(15 downto 0));
	end component;
	
	component Multiplexor2_2 is
	port(A: in std_logic_vector(2 downto 0);
   		B: in std_logic_vector(2 downto 0);
			C: in std_logic_vector(2 downto 0);
			D: in std_logic_vector(2 downto 0);
   		sel0: in std_logic;
			sel1: in std_logic;
   		O: out std_logic_vector(2 downto 0));
	end component;
	
	component Multiplexor2_15 is
	port(A: in std_logic_vector(15 downto 0);
   		B: in std_logic_vector(15 downto 0);
			C: in std_logic_vector(15 downto 0);
			D: in std_logic_vector(15 downto 0);
   		sel0: in std_logic;
			sel1: in std_logic;
   		O: out std_logic_vector(15 downto 0));
	end component;
	
	component Multiplexor3 is
	port(A: in std_logic_vector(15 downto 0);
   		B: in std_logic_vector(15 downto 0);
			C: in std_logic_vector(15 downto 0);
			D: in std_logic_vector(15 downto 0);
			E: in std_logic_vector(15 downto 0);
   		sel0: in std_logic;
			sel1: in std_logic;
			sel2: in std_logic;
   		O: out std_logic_vector(15 downto 0));
	end component;

	component Multiplexor31 is
	port(A: in std_logic_vector(15 downto 0);
   		B: in std_logic_vector(15 downto 0);
			C: in std_logic_vector(15 downto 0);
			D: in std_logic_vector(15 downto 0);
			E: in std_logic_vector(15 downto 0);
   		sel0: in std_logic;
			sel1: in std_logic;
			sel2: in std_logic;
   		O: out std_logic_vector(15 downto 0));
	end component;
	
	component S1 is 
	port(A: in std_logic_vector(15 downto 0);
		  B: out std_logic_vector(15 downto 0));
	end component;
	
	component SE7 is 
	port(A: in std_logic_vector(8 downto 0);
		  B: out std_logic_vector(15 downto 0));
	end component;
	
	component SE10 is 
	port(A: in std_logic_vector(5 downto 0);
		  B: out std_logic_vector(15 downto 0));
	end component;
	
	component ZE is 
	port(A: in std_logic_vector(8 downto 0);
		  B: out std_logic_vector(15 downto 0));
	end component;
	
	component DataRegister is
	generic (data_width:integer);
	port (Din: in std_logic_vector(data_width-1 downto 0);
	      Dout: out std_logic_vector(data_width-1 downto 0);
	      clk, enable: in std_logic);
	end component;
	
	component DataRegister1 is
	port (Din: in std_logic;
	      Dout: out std_logic;
	      clk, enable: in std_logic);
	end component;
end Pack;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity Multiplexor1 is
	port(A: in std_logic_vector(15 downto 0);
   		B: in std_logic_vector(15 downto 0);
   		sel: in std_logic;
   		O: out std_logic_vector(15 downto 0));
end entity Multiplexor1;
architecture Behave of Multiplexor1 is
	begin
	process(A, B, sel)
	begin
		for I in 15 downto 0 loop	
			O(I) <= (A(I) and not sel) or (B(I) and (sel));
		end loop;
	end process;
end Behave;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity Multiplexor2_2 is
	port(A: in std_logic_vector(2 downto 0);
   		B: in std_logic_vector(2 downto 0);
			C: in std_logic_vector(2 downto 0);
			D: in std_logic_vector(2 downto 0);
   		sel0: in std_logic;
			sel1: in std_logic;
   		O: out std_logic_vector(2 downto 0));
end entity Multiplexor2_2;
architecture Behave of Multiplexor2_2 is
	begin
	process(A, B, C, D, sel0, sel1)
	begin
		for I in 2 downto 0 loop 
			O(I) <= (B(I) and (not sel0) and sel1) or (A(I) and (not sel0) and (not sel1)) or (C(I) and sel0 and (not sel1)) or (D(I) and sel0 and sel1);
		end loop;
	end process;
end Behave;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity Multiplexor3 is
	port(A: in std_logic_vector(15 downto 0);
   		B: in std_logic_vector(15 downto 0);
			C: in std_logic_vector(15 downto 0);
			D: in std_logic_vector(15 downto 0);
			E: in std_logic_vector(15 downto 0);
   		sel0: in std_logic;
			sel1: in std_logic;
			sel2: in std_logic;
   		O: out std_logic_vector(15 downto 0));
end entity Multiplexor3;
architecture Behave of Multiplexor3 is
	begin
	process(A, B, C, D, E, sel0, sel1, sel2)
	begin
		for I in 15 downto 0 loop 
			O(I) <= (B(I) and (not sel1) and sel2 and (not sel0)) or (A(I) and (not sel1) and (not sel2) and (not sel0)) or (C(I) and sel1 and (not sel2)and (not sel0)) or (D(I) and sel1 and sel2 and (not sel0)) or (E(I) and (not sel1) and (not sel2) and sel0);
		end loop;
	end process;
end Behave;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity Multiplexor31 is
	port(A: in std_logic_vector(15 downto 0);
   		B: in std_logic_vector(15 downto 0);
			C: in std_logic_vector(15 downto 0);
			D: in std_logic_vector(15 downto 0);
			E: in std_logic_vector(15 downto 0);
   		sel0: in std_logic;
			sel1: in std_logic;
			sel2: in std_logic;
   		O: out std_logic_vector(15 downto 0));
end entity Multiplexor31;
architecture Behave of Multiplexor31 is
	begin
	process(A, B, C, D, E, sel0, sel1, sel2)
	begin
		for I in 15 downto 0 loop 
			O(I) <= (B(I) and (not sel1) and sel2 and (not sel0)) or (A(I) and (not sel1) and (not sel2) and (not sel0)) or (C(I) and sel1 and (not sel2)and (not sel0)) or (D(I) and sel1 and sel2 and (not sel0)) or (E(I) and (not sel1) and (not sel2) and sel0);
		end loop;
	end process;
end Behave;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity Multiplexor2_15 is
	port(A: in std_logic_vector(15 downto 0);
   		B: in std_logic_vector(15 downto 0);
			C: in std_logic_vector(15 downto 0);
			D: in std_logic_vector(15 downto 0);
   		sel0: in std_logic;
			sel1: in std_logic;
   		O: out std_logic_vector(15 downto 0));
end entity Multiplexor2_15;
architecture Behave of Multiplexor2_15 is
	begin
	process(A, B, C, D, sel0, sel1)
	begin
		for I in 15 downto 0 loop 
			O(I) <= (B(I) and (not sel0) and sel1) or (A(I) and (not sel0) and (not sel1)) or (C(I) and sel0 and (not sel1)) or (D(I) and sel0 and sel1);
		end loop;
	end process;
end Behave;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity S1 is 
	port(A: in std_logic_vector(15 downto 0);
		  B: out std_logic_vector(15 downto 0));
end entity S1;
architecture Behave of S1 is
	begin
	process(A)
	begin
		B <= A;
	end process;
end Behave;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity SE10 is 
	port(A: in std_logic_vector(5 downto 0);
		  B: out std_logic_vector(15 downto 0));
end entity SE10;
architecture Behave of SE10 is
	begin
	process(A)
	begin
		for I in 15 downto 0 loop
			if(I < 6) then 
			B(I) <= A(I);
			else
			B(I) <= A(5);
			end if;
		end loop;
	end process;
end Behave;

library std;
use std.standard.all;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity SE7 is 
	port(A: in std_logic_vector(8 downto 0);
		  B: out std_logic_vector(15 downto 0));
end entity SE7;
architecture Behave of SE7 is
	begin
	process(A)
	begin
		for I in 15 downto 0 loop
			if(I < 9) then 
			B(I) <= A(I);
			else
			B(I) <= A(8);
			end if;
		end loop;
	end process;
end Behave;

library std;
use std.standard.all;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity ZE is 
	port(A: in std_logic_vector(8 downto 0);
		  B: out std_logic_vector(15 downto 0));
end entity ZE;
architecture Behave of ZE is
	begin
	process(A)
	begin
		for I in 15 downto 0 loop
			if(I > 6) then 
			B(I) <= A(I-7);
			else
			B(I) <= '0';
			end if;
		end loop;
	end process;
end Behave;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity DataRegister is
	generic (data_width:integer);
	port (Din: in std_logic_vector(data_width-1 downto 0);
	      Dout: out std_logic_vector(data_width-1 downto 0);
	      clk, enable: in std_logic);
end entity;
architecture Behave of DataRegister is
begin
    process(clk)
    begin
       if(clk'event and (clk  = '1')) then
           if(enable = '1') then
               Dout <= Din;
           end if;
       end if;
    end process;
end Behave;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity DataRegister1 is
	port (Din: in std_logic;
	      Dout: out std_logic;
	      clk, enable: in std_logic);
end entity;
architecture Behave of DataRegister1 is
begin
    process(clk)
    begin
       if(clk'event and (clk  = '1')) then
           if(enable = '1') then
               Dout <= Din;
           end if;
       end if;
    end process;
end Behave;
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-- ------------------------------- CONTROL PATH -----------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------
--=================================NOTE=========================================================
------------------------------------------------------------------------------------------------
--1.complete is used in place of done as done is the output of PE . So if an instruction is completed complete will be set to 1.
--2.C_Z is corresponds to the last 2 bits of the instruction which is "down to" format. 0 bit of C_Z is the 0 bit of instruction.
--3.C and Z are the carry and the zero flags coming from the datapath.
--4.done is the signal coming from the Priority Encoder of the data path 
--5.op_code is the 4 msbs of the instruction

library std;
use std.standard.all;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use work.Pack.all;
use work.Pack2.all;

entity ControlPath is
port(
		 --Value of done i/p
		 done : in std_logic;
		 --completed instruction indicator
		 complete : out std_logic;
		 --All control signals o/p
		 M1_0, M1_1, M2_0, M2_1, M4_0, M4_1, M5_0, M5_1, M5_2, M6_0, M6_1, M8_0, M8_1, M9_0, M9_1, M9_2, M10_0, M11_0, M12_0, M14_0, M15_0, M17_0, ALU_en, OP_bit_0, OP_bit_1, C_en, Z_en, Mem_en, Mem_R_W, PE_en, RF_write, IR_write, M18_0, T1_en, T2_en, T3_en, T4_en, T5_en: out std_logic;
		 --Value of opcode i/p
		 op_code :in std_logic_vector(3 downto 0);
		 --Value of carry and zero flag i/p
		 C :in std_logic;
		 Z :in std_logic;
		 C_Z :in std_logic_vector(1 downto 0);
		 clk :in std_logic;
		 reset :in std_logic);
end entity;
architecture Behave of ControlPath is
	type FsmState is (rst,s0,s1,s1_1,s2,s3,s4,s5,s6,s7,s9,s10,s10_1,s11,s12,s13,s14,s15,s16,s17,s18,s20,s21,s22,s23,s24,s25,s26,s27);
	signal fsm_state : FsmState;
begin
	process(fsm_state,clk,reset,done,op_code,C,Z,C_Z)
		variable next_state : FsmState;
		variable Tvar : std_logic_vector(0 to 37);
		variable complete_var : std_logic;
		begin
		Tvar := (others => '0');
		complete_var := '0';
		next_state := fsm_state;
		
		case fsm_state is 
			when rst =>
					Tvar(26) := '1';
					--Tvar(29) := '1';
					next_state := s1;
			when s0 =>
					Tvar := "00000000000000000000000000000100000001";	
					next_state := s1;

			when s1 =>
				
					Tvar := "00001000000000000000010000100010001000";
					next_state := s1_1;

			when s1_1 =>
					if (op_code(3) = '0') then 
						next_state := s2;
					elsif (op_code = "1100") then 
						next_state := s9;
					elsif (op_code = "1000") then
						next_state := s11;
					elsif (op_code = "1001") then 
						next_state := s13;
					end if;
			when s2 =>

					Tvar := "00000000000001000000000000000000000010";
					if( (op_code = "0000") or (op_code = "0010")) then 
						next_state := s3;
					elsif (op_code = "0001") then 
						next_state := s6;
					elsif (op_code = "0011") then 
						next_state := s14;
					elsif((op_code = "0100") or (op_code = "0101")) then   
						next_state := s15; 
					elsif( (op_code = "0110") or (op_code = "0111")) then
						next_state := s21;
					end if;

			when s3 =>

					Tvar := "10000000000000000000000000000000110000";
					if((((not C_Z(1)) and (not C_Z(0))) = '1') or ((C_Z(1) and (not C_Z(0)) and C) = '1') or (((not C_Z(1)) and C_Z(0) and Z) = '1')) then 
						next_state := s4;
					else
						next_state := s0;
						complete_var := '1';
					end if;

			when s4 =>

					Tvar := "00000000100000000000010001000001001000";
					Tvar(24) := not op_code(1); --not(I_13);
					Tvar(22) := op_code(1);
					next_state := s5;
										

			when s5 =>

					Tvar := "00010000000001000000000000000100000000";
					next_state := s0;
					complete_var := '1';
					

			when s6 =>

					Tvar := "10000000000000000000000000000000100000";
					next_state := s7;
					

			when s7 =>

					Tvar := "00000001000000000000010011000000001000";
					next_state := s5;
					

			when s9 =>

					Tvar := "00001001000000000000010000000000000100";
					next_state := s10;
					

			when s10 =>

					Tvar := "01001000100110000000010101000000000000";
					next_state := s10_1;

			when s10_1 =>
					Tvar(29) := '1';
					Tvar(13) := not Z; --not(zero flag)
					next_state := s1;
					complete_var := '1';
					
			when s11 =>

					Tvar := "00011001000001000010010000000100000100";
					next_state := s12;
					

			when s12 =>

					Tvar := "00000000000000000000000000000100000000";
					next_state := s1;
					complete_var := '1';
					

			when s13 =>

					Tvar := "10011010000001000000010000000100000100";
					next_state := s12;
					

			when s14 =>

				 	Tvar := "00010000000000100000000000000100000000";
					next_state := s0;
				 	complete_var := '1';
				 	
			when s15 =>

					Tvar := "10000000000010000000000000000000110000";
					next_state := s16;
 					
 		 	when s16 =>

 		 			Tvar := "00000001000000000000010000000000001000";
 		 				
 		 			if (op_code = "0100") then 
 		 				next_state := s17;
 		 			elsif (op_code = "0101") then
 		 				next_state := s20;
 		 			end if;

 		 	when s17 =>

 		 			Tvar := "00000000010000000000100000100000000100";
					next_state := s18;
 		 			

 		 	when s18 =>

 		 			Tvar := "00010000000000000000000000000100000000";
					next_state := s0;
 		 			complete_var := '1';
 		 			

 		 	when s20 =>

 		 			Tvar := "00000000010000000000000000110001000000";
 		 			next_state := s0;
 		 			complete_var :='1';
 		 			
 		 	when s21 =>

 		 			Tvar := "01000000000000010000000000000000101000";
					next_state := s22;
 		 			

 		 	when s22 =>

 		 			Tvar := "00000000001000000000100000101000000100";
 
 		 			if( done = '1') then
 		 				if(op_code = "0110") then  
 		 					next_state := s23;
 		 				elsif (op_code ="0111") then
 		 					next_state := s26;
 		 				end if;
 		 			else
						next_state := s0;
						complete_var :='1';
 		 			end if;
 		 			

 		 	when s23 =>

 		 			Tvar := "00100000000000000000000000000100000000";
					next_state := s24;
 		 			

 		 	when s24 =>

 		 			Tvar := "00000101100000000000011100000000001000";
					next_state := s25;
 		 			

 		 	when s25 =>

 		 			Tvar := "00000000000000000001010000000000100000";
 		 			next_state := s22;
 		 			

 			when s26 =>

 					Tvar := "00000000000100000000000000000000010000";
 					next_state := s27;
 					

 			when s27 =>

 					Tvar := "00000000001000000000000000110001000000";
					next_state := s24;
 					

 		end case;

 		M1_0  <=Tvar(0); 
		M1_1	<=Tvar(1);
		M2_0	<=Tvar(2);
		M2_1	<=Tvar(3);
		M4_0	<=Tvar(4);
		M4_1	<=Tvar(5);
		M5_0	<=Tvar(6);
		M5_1	<=Tvar(7);
		M5_2	<=Tvar(8);
		M6_0  <=Tvar(9);
		M6_1	<=Tvar(10);
		M8_0	<=Tvar(11);
		M8_1	<=Tvar(12);
		M9_0	<=Tvar(13);
		M9_1	<=Tvar(14);
		M10_0	<=Tvar(15);
		M11_0	<=Tvar(16);
		M12_0	<=Tvar(17);
		M14_0	<=Tvar(18);
		M15_0	<=Tvar(19);
		M17_0	<=Tvar(20);
		ALU_en	<=Tvar(21);
		OP_bit_0	<=Tvar(22);
		OP_bit_1	<=Tvar(23);
		C_en	<=Tvar(24);
		Z_en	<=Tvar(25);
		Mem_en	<=Tvar(26);
		Mem_R_W	<=Tvar(27);
		PE_en	<=Tvar(28);
		RF_write	<=Tvar(29);
		IR_write	<=Tvar(30);
		M18_0   <=Tvar(31);
		T1_en <= Tvar(32);
		T2_en <= Tvar(33);
		T3_en <= Tvar(34);
		T4_en <= Tvar(35);
		M9_2 <= Tvar(37);
		T5_en <= Tvar(36);
 		complete <= complete_var;

		if(clk'event and (clk = '1')) then
		  if(reset = '1') then
             fsm_state <= rst;
        else
             fsm_state <= next_state;
        end if;
		end if;
   end process;

end Behave;

--==================================================================================================
--=============================CONRTOL PATH ENDS====================================================
--==================================================================================================

library std;
use std.standard.all;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use work.Pack.all;
use work.Pack2.all;

entity DataPath is
	port( --Value of done o/p
		 done : out std_logic;
		 --completed instruction indicator
		 complete : in std_logic;
		 --All control signals i/p
		 --M1_0, M1_1, M2_0, M2_1, M4_0, M4_1, M5_0, M5_1, M5_2, M6_0, M6_1, M8_0, M8_1, M9_0, M9_1, M10_0, M11_0, M12_0, M14_0, M15_0, M17_0, ALU_en, OP_bit_0, OP_bit_1, C_en, Z_en, Mem_en, Mem_R_W, PE_en, RF_write, IR_write, M18_0: in std_logic;
		 M1_0, M1_1, M2_0, M2_1, M4_0, M4_1, M5_0, M5_1, M5_2, M6_0, M6_1, M8_0, M8_1, M9_0, M9_1, M9_2, M10_0, M11_0, M12_0, M14_0, M15_0, M17_0, ALU_en, OP_bit_0, OP_bit_1, C_en, Z_en, PE_en, RF_write, IR_write, M18_0, T1_en, T2_en, T3_en, T4_en, T5_en: in std_logic;
		 --Value of opcode o/p
		 op_code :out std_logic_vector(3 downto 0);
		 --Value of carry and zero flag o/p
		 C :out std_logic;
		 Z :out std_logic;
		 C_Z :out std_logic_vector (1 downto 0);
		 clk :in std_logic;
		 reset :in std_logic;
		-- memory related input/output
		Mem_write_data : out std_logic_vector(15 downto 0);
		Mem_data_out : in std_logic_vector(15 downto 0);
		Mem_add_in: out std_logic_vector(15 downto 0));
end entity;
architecture Struct of DataPath is
	--write all intermediate control signals here
	signal addr,A1_in, A2_in, A3_in: std_logic_vector(2 downto 0) := (others => '0');
	signal I, index: std_logic_vector(15 downto 0)  := (others => '0');
	signal D3_in, SE10_out, SE7_out, ZE_out, M14_out, S1_out, M11_out, M18_out, D1_out, D2_out:  std_logic_vector(15 downto 0) := (others => '0');
	signal T4_out, T3_out, T3_in, T4_in, T1_in, T1_out, T2_out, T5_in, T5_out: std_logic_vector(15 downto 0)  := (others => '0');
	--signal Mem_write_data, Mem_data_out,Mem_add_in: std_logic_vector(15 downto 0);
	signal ALU_out,Alu_in_a, Alu_in_b: std_logic_vector(15 downto 0) := (others => '0');
	signal C_1, Z_1, alu_done: std_logic := '0';
	signal C10: std_logic_vector(1 downto 0) := (others => '0');
	
	begin
	IR: DataRegister generic map(data_width => 16) port map (Din => Mem_data_out, Dout => I, enable => IR_write, clk => clk);
	
	--predicate
	op_code <= I(15 downto 12);
	C_Z <= I(1 downto 0);
	C10(1) <= OP_bit_1;
	C10(0) <= OP_bit_0;
	
	m8: Multiplexor2_2 port map(A => I(5 downto 3), B => I(11 downto 9), C => addr, D => I(8 downto 6) ,sel0 => M8_0,sel1 => M8_1,O => A2_in);
	m1: Multiplexor2_2 port map(A => "111", B => I(11 downto 9), C => I(8 downto 6) ,D => "000", sel0 => M1_0,sel1 => M1_1,O => A1_in);
	m2: Multiplexor2_2 port map(A => "111", B => I(11 downto 9), C => addr, D => "000" ,sel0 => M2_0,sel1 => M2_1,O => A3_in);
	rf1: RFComplete port map(A1 => A1_in, A2 => A2_in, A3 => A3_in, D1 => D1_out, D2 => D2_out, D3 => D3_in, RF_Write => RF_write, clk => clk, reset => reset);
	se10_1: SE10 port map(A => I(5 downto 0), B => SE10_out);
	se7_1: SE7 port map(A => I(8 downto 0), B => SE7_out);
	ze_1: ZE port map(A => I(8 downto 0), B => ZE_out);
	m14: Multiplexor1 port map(A => SE10_out, B => SE7_out, sel => M14_0, O => M14_out);
	s1_1: S1 port map(A => M14_out, B => S1_out);
	m11: Multiplexor1 port map(A => S1_out, B => M14_out, sel => M11_0, O => M11_out);
	m9: Multiplexor31 port map(A => T4_out, B => T5_out , C => ZE_out , D => T1_in,E =>T3_out, sel0 => M9_0,sel1 => M9_1,sel2 => M9_2,O => D3_in);
	m12: Multiplexor1 port map(A => M18_out, B => T4_out, sel => M12_0, O => Mem_write_data);
	m17: Multiplexor1 port map(A => ALU_out, B => Mem_data_out, sel => M17_0, O => T4_in);
	t4: DataRegister generic map(data_width => 16) port map(Din => T4_in, Dout => T4_out, enable => T4_en, clk => clk);
	m6: Multiplexor2_15 port map(A => T1_in, B =>T1_out, C => T3_out, D => (others => '0') ,sel0 => M6_0,sel1 => M6_1,O => Mem_add_in);
	t1: DataRegister generic map(data_width => 16) port map(Din => T1_in, Dout => T1_out, enable => T1_en, clk => clk);
	t2: DataRegister generic map(data_width => 16) port map(Din => D2_out, Dout => T2_out, enable => T2_en, clk => clk);
	m15: Multiplexor1 port map(A => D1_out, B => ALU_out, sel => M15_0, O => T1_in);
	m18: Multiplexor1 port map(A => D2_out, B => T2_out, sel => M18_0, O => M18_out);
	m4: Multiplexor2_15 port map(A => T1_out, B => T3_out, C => T1_in, D => (others => '0') ,sel0 => M4_0,sel1 => M4_1,O => Alu_in_a);
	m5: Multiplexor3 port map(A => (0 => '1', others => '0'), B => M18_out, C => M11_out, D => index, E => (others => '0'), sel0 => M5_0, sel1 => M5_1, sel2 => M5_2, O => Alu_in_b);
	alu1: ALU port map(X => Alu_in_a, Y => Alu_in_b, clk => clk, alu_enable => ALU_en, op_code => C10, C => C_1, Z => Z_1, R => ALU_out, alu_done => alu_done);
	
	--setting c and z registers
	c1: DataRegister1 port map(Din => C_1, Dout => C, enable => C_en, clk => clk);
	z1: DataRegister1 port map(Din => Z_1, Dout => Z, enable => Z_en, clk => clk);
	
	m10: Multiplexor1 port map(A => ALU_out, B => SE7_out, sel => M10_0, O => T3_in);
	t3: DataRegister generic map(data_width => 16) port map(Din => T3_in, Dout => T3_out, enable => T3_en, clk => clk);
	t5: DataRegister generic map(data_width => 16) port map(Din => T3_in, Dout => T5_out, enable => T5_en, clk => clk);
	pe: priority_encoder port map(x => T3_out, enable => PE_en, a => addr, i => index, done => done);

end Struct;

library std;
use std.standard.all;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use work.Pack.all;
use work.Pack2.all;

entity Microprocessor is
port(
	clk:in std_logic;
	reset: in std_logic;
	mem_enable: out std_logic;
   	r_w: out std_logic;
  	addr: out std_logic_vector(15 downto 0);
  	write_data: out std_logic_vector(15 downto 0); 
   	read_data: in std_logic_vector(15 downto 0));
end entity;
---------------------------------------------------------------------
----------------JUST PUT COMMA HERE----------------------------------
---------------------------------------------------------------------
architecture Struct of Microprocessor is
	signal M1_0, M1_1, M2_0, M2_1, M4_0, M4_1, M5_0, M5_1, M5_2, M6_0, M6_1, M8_0, M8_1, M9_0, M9_1, M9_2, M10_0, M11_0, M12_0, M14_0, M15_0, M17_0, ALU_en, OP_bit_0, OP_bit_1, C_en, Z_en: std_logic;
	signal Mem_en, Mem_R_W, PE_en, RF_write, IR_write, M18_0,T1_en,T2_en,T3_en,T4_en, T5_en: std_logic;
   signal op_code: std_logic_vector(	3 downto 0);
	signal done, complete: std_logic;
	signal C, Z: std_logic;
	signal C_Z: std_logic_vector(1 downto 0);
	begin

	CP:ControlPath
	port map(
		M1_0 => M1_0, --All control signals o/p
		M1_1 => M1_1,
		M2_0 => M2_0,
		M2_1 => M2_1,
		M4_0 => M4_0,
		M4_1 => M4_1,
		M5_0 => M5_0,
		M5_1 => M5_1,
		M5_2 => M5_2,
		M6_0 => M6_0,
		M6_1 => M6_1,
		M8_0 => M8_0,
		M8_1 => M8_1,
		M9_0 => M9_0,
		M9_1 => M9_1,
		M9_2 => M9_2,
		M10_0 => M10_0,
		M11_0 => M11_0,
		M12_0 => M12_0,
		M14_0 => M14_0,
		M15_0 => M15_0,
		M17_0 => M17_0,
		ALU_en => ALU_en,
		OP_bit_0 => OP_bit_0,
		OP_bit_1 => OP_bit_1,
		C_en => C_en,
		Z_en => Z_en,
		Mem_en => mem_enable,
		Mem_R_W => r_w,
		PE_en => PE_en,
		RF_write => RF_write,
		IR_write => IR_write,
		M18_0 => M18_0,
		T1_en => T1_en,
		T2_en => T2_en,
		T3_en => T3_en,
		T4_en => T4_en,
		T5_en => T5_en,
		done => done,
      complete => complete, --Value of done i/p
		op_code => op_code, --Value of opcode i/p
		C => C, --Value of carry and zero flag i/p
		Z => Z, 
		C_Z => C_Z, 
		clk => clk,
		reset => reset);
		  
	DP:DataPath
	port map(
		  	M1_0 => M1_0, --All control signals i/p
			M1_1 => M1_1,
			M2_0 => M2_0,
			M2_1 => M2_1,
			M4_0 => M4_0,
			M4_1 => M4_1,
			M5_0 => M5_0,
			M5_1 => M5_1,
			M5_2 => M5_2,
			M6_0 => M6_0,
			M6_1 => M6_1,
			M8_0 => M8_0,
			M8_1 => M8_1,
			M9_0 => M9_0,
			M9_1 => M9_1,
			M9_2 => M9_2,
			M10_0 => M10_0,
			M11_0 => M11_0,
			M12_0 => M12_0,
			M14_0 => M14_0,
			M15_0 => M15_0,
			M17_0 => M17_0,
			ALU_en => ALU_en,
			OP_bit_0 => OP_bit_0,
			OP_bit_1 => OP_bit_1,
			C_en => C_en,
			Z_en => Z_en,
			PE_en => PE_en,
			RF_write => RF_write,
			IR_write => IR_write,
			M18_0 => M18_0,
			T1_en => T1_en,
		T2_en => T2_en,
		T3_en => T3_en,
		T4_en => T4_en,
		T5_en => T5_en,
			done => done,
			complete => complete, --Value of done o/p
		   op_code =>op_code, --Value of opcode o/p
		   C => C, --Value of carry and zero flag o/p
		   Z => Z,
		   C_Z => C_Z, 
		   clk => clk,
		   reset => reset,
		Mem_write_data => write_data, 
		Mem_data_out => read_data,
		Mem_add_in => addr
	);

end Struct;
