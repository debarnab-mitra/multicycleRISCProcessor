library ieee;
use ieee.std_logic_1164.all;
entity priority_encoder is
   port(x: in std_logic_vector(15 downto 0);
	enable: in std_logic;
   a: out std_logic_vector(2 downto 0);
	i: out std_logic_vector(15 downto 0);
	done: out std_logic);
end entity;

architecture Behave of priority_encoder is
   begin
   	process(x,enable)
		variable pos1: integer := 0;
		variable tmp: std_logic_vector(15 downto 0) := (others => '1');
   	begin
		if(enable = '1') then 
			if(x = "0000000000000000") then
				done <= '0';
				i <= "1111111111111111";
				a <= "000";
				tmp:= (others => '1');
			else
				for J in 0 to 7	loop 
					if (x(J) = '1') then
						pos1 := J;
						tmp:= (others => '1');
						tmp(J) := '0';
						exit;
					else
						pos1 := J;
						tmp:= (others => '1');
						tmp(J) := '1';
					end if;
				end loop;
				
				i <= tmp;				

				if(pos1 = 0) then
					a <= "000";
				elsif(pos1 = 1) then
					a <= "001";
				elsif(pos1 = 2) then
					a <= "010";
				elsif(pos1 = 3) then
					a <= "011";
				elsif(pos1 = 4) then
					a <= "100";
				elsif(pos1 = 5) then
					a <= "101";		
				elsif(pos1 = 6) then
					a <= "110";
				else
					a <= "111";
				end if;
				
				done <= '1';
			end if;
		else
				--done <= '1';
				--i <= "1111111111111111";
				--a <= "000";
				--tmp:= (others => '1');
		end if;
	end process;
end Behave;
  

