library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
entity memory_new is
   port(clk,reset: in std_logic;
	mem_enable: in std_logic;
     	r_w: in std_logic;
  	addr: in std_logic_vector(15 downto 0);
        write_data: in std_logic_vector(15 downto 0); 
        read_data: out std_logic_vector(15 downto 0));
   
end entity memory_new;

architecture Behave of memory_new is
	type mem_arr is array(0 to 265) of std_logic_vector(15 downto 0);
signal mem: mem_arr := (
								
									0 => "0011001000000010",
									1 => "0011010000000010",
									2 => "0011101000000010",
									3 => "0011011000000010",
									4 => "0100000010000001",
									5 => "0000100000000000",
									6 => "0100100101000010",
									7 => "0100000010000011",
									8 => "0000110100100001",
									9 => "0000011000001001",
									10 =>"0000010000001010",
									11 =>"0101000011000010",
									12 =>"0100010011000010",
									13 =>"0101011010000001",
									14 =>"0110000000111111",
									15=>"0001111000011001",
									16=>"0001111111011001",
									17=>"0100100110000000",
									18=>"0010011110100001",
									19=>"0010101110001000",
									20=>"0000000101000000",
									21=>"0111000000010010",
									22=>"1100001001000010",
									23=>"0001110001011111",
									24=>"1000010000000010",
									25=>"0011001000101011",
									26=>"1000111000000000",	
									257 =>"0000000000000010",
									258 =>"0000000000000110",
									259 =>"0000000100000000",
									260 =>"0000000000000101",
									261 =>"0000000000000110",
									262 =>"0000000100000000",
	
									--0 => "0011001000000010",
									--1 => "0011010000000010",
									--2 => "0011101000000010",
									--3 => "0011011000000010",
									--4 => "0100000010000001",
									--5 => "0000100000000000",
									--6 => "0100100101000010",
									--7 => "0100000010000011",
									--8 => "0000110100100001",
									--9 => "0000011000001001",
									--10 =>"0000010000001010",
									--11 =>"0101000011000010",
									--12 =>"0100010011000010",
									--13 =>"0101011010000001",
									--14 =>"0110000000111111",
									--15=>"0001111000011001",
									--257 =>"0000000000000010",
									--258 =>"0000000000000110",
									--259 =>"0000000100000000",
									--260 =>"0000000000000101",
									--261 =>"0000000000000110",
									--262 =>"0000000100000000",
								others => "0000000000000000");


	type mem_instruction is array(0 to 14) of std_logic_vector(15 downto 0);
			
begin	
	
				
	process(clk,reset,mem_enable,r_w,addr,write_data)
	begin
		if(mem_enable = '1') then
			-- read happens throughout the cycle;
			-- write only at the falling edge;
			if(reset = '0') then 
					-- read case, r_w = 0
					if(r_w = '0') then 
						read_data <= mem(to_integer(unsigned(addr)));
					-- write case, r_w = 1
					else	
					    if(clk'event and (clk  = '1')) then						
						 mem(to_integer(unsigned(addr))) <= write_data;
					    end if;
					  	 -- value at the output is the value that has just been written
						read_data <= write_data;
					end if;	
			else 
				read_data <= (others => '1');
		
			end if;
		else	
		read_data <= (others => '1');	
		end if;
	end process;
		
end Behave;
		
