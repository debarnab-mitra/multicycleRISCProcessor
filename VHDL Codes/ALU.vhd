library ieee;
use ieee.std_logic_1164.all;
entity ALU is
   port(X: in std_logic_vector(15 downto 0);
        Y: in std_logic_vector(15 downto 0);
	clk : in std_logic;
		  alu_enable: in std_logic;
        op_code: in std_logic_vector(1 downto 0); 
	     C: out std_logic;
	     Z: out std_logic;
        R: out std_logic_vector(15 downto 0);
		  alu_done: out std_logic
		  );
end entity ALU;

architecture Behave of ALU is
begin
	process(X,Y,alu_enable,op_code, clk)
		variable tmp, Y_neg, Y2: std_logic_vector(15 downto 0) := (others => '0');
		variable C_in, C_out, C_in1, C_out1: std_logic := '0';
		variable one: std_logic_vector(15 downto 0) := "0000000000000001";
		variable equal_count: integer := 0; 
	begin
		alu_done <= '0';
		if(clk'event and (clk='0')) then
		if(alu_enable = '1') then
			if(op_code(0) = '0' and op_code(1) = '0') then
				C_in := '0';
				for I in 0 to 15 loop
					tmp(I) := (X(I) xor Y(I)) xor C_in;
					C_out := ((X(I) and Y(I)) or (C_in and (X(I) xor Y(I))));
					C_in := C_out;
				end loop;
			end if;			
			if(op_code(0) = '0' and op_code(1) = '1') then
				equal_count := 0;
				for I in 0 to 15 loop
					if(X(I) = Y(I)) then
						equal_count := equal_count + 1;				
					end if;
					if(equal_count = 16) then
						tmp := "0000000000000000";
					end if;
				end loop;
			end if;	
			if(op_code(0) = '1' and op_code(1) = '0') then
				tmp := not (X and Y);
			end if;
			if(op_code(0) = '1' and op_code(1) = '1') then
				tmp := X and Y;
			end if;
		end if;
		end if;

	   	R <= tmp;
		C <= C_out;

		if(tmp = "0000000000000000") then
		Z <= '1';
		else 
		Z <= '0';
		end if;

		alu_done <= '1';

	end process;
end Behave;
				

