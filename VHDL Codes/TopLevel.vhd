library std;
use std.standard.all;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use work.Pack.all;

entity TopLevel is
port(
	--Clock_50 : in  std_logic; -- Clock for Signal Tap Analyzer
	clk:in std_logic;
	reset: in std_logic);
end entity;

architecture Struct of TopLevel is

	signal r_w,mem_enable : std_logic;
 
	signal write_data, read_data,addr: std_logic_vector(15 downto 0);
	begin

	uP:Microprocessor
	port map(
		clk=> clk,
		reset => reset,
		mem_enable => mem_enable,
   		r_w => r_w,
  		addr => addr,
   		write_data => write_data, 
   		read_data => read_data);
		  
	mem: memory_new 
	port map(
		clk => clk, 
		reset => reset, 
		mem_enable => mem_enable, 
		r_w => r_w, 
		addr => addr, 
		write_data => write_data, 
		read_data => read_data);
end Struct;
