library ieee;
use ieee.std_logic_1164.all;
package Pack2 is
component encoder1 is
port(X0: in std_logic_vector(15 downto 0);
	X1: in std_logic_vector(15 downto 0);
	X2: in std_logic_vector(15 downto 0);
	X3: in std_logic_vector(15 downto 0);
	X4: in std_logic_vector(15 downto 0);
	X5: in std_logic_vector(15 downto 0);
	X6: in std_logic_vector(15 downto 0);
	X7: in std_logic_vector(15 downto 0);
	Y: in std_logic_vector(2 downto 0);
	enable: in std_logic;
   Z: out std_logic_vector(15 downto 0));
end component;
component decoder is
port(X: in std_logic_vector(15 downto 0);
	enable: in std_logic;
	Y: in std_logic_vector(2 downto 0);
        Z0: out std_logic_vector(16 downto 0);
	Z1: out std_logic_vector(16 downto 0);
	Z2: out std_logic_vector(16 downto 0);
	Z3: out std_logic_vector(16 downto 0);
	Z4: out std_logic_vector(16 downto 0);
	Z5: out std_logic_vector(16 downto 0);
	Z6: out std_logic_vector(16 downto 0);
	Z7: out std_logic_vector(16 downto 0));
end component;
component RF is
port (Din0: in std_logic_vector(16 downto 0);
	 Din1: in std_logic_vector(16 downto 0);
	 Din2: in std_logic_vector(16 downto 0);
	 Din3: in std_logic_vector(16 downto 0);
	 Din4: in std_logic_vector(16 downto 0);
	 Din5: in std_logic_vector(16 downto 0);
	 Din6: in std_logic_vector(16 downto 0);
	 Din7: in std_logic_vector(16 downto 0);
	 Dout0: out std_logic_vector(15 downto 0);
	 Dout1: out std_logic_vector(15 downto 0);
	 Dout2: out std_logic_vector(15 downto 0);
	 Dout3: out std_logic_vector(15 downto 0);
	 Dout4: out std_logic_vector(15 downto 0);
	 Dout5: out std_logic_vector(15 downto 0);
	 Dout6: out std_logic_vector(15 downto 0);
	 Dout7: out std_logic_vector(15 downto 0);
    clk, enable, reset: in std_logic);
end component;
end Pack2;

library ieee;
use ieee.std_logic_1164.all;
use work.Pack2.all;
entity RFComplete is
	port(A1: in std_logic_vector(2 downto 0);
	A2: in std_logic_vector(2 downto 0);
	A3: in std_logic_vector(2 downto 0);
	D1: out std_logic_vector(15 downto 0);
	D2: out std_logic_vector(15 downto 0);
	D3: in std_logic_vector(15 downto 0);
	RF_Write: in std_logic;
	reset: in std_logic;
	clk : in std_logic);
end entity;

architecture Procedural of RFComplete is
	signal Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7: std_logic_vector(16 downto 0);
	signal  X0, X1, X2, X3, X4, X5, X6, X7: std_logic_vector(15 downto 0);
	begin
	d:decoder port map(X => D3, enable => RF_Write, Y => A3, Z0 => Z0, Z1 => Z1, Z2 => Z2, Z3 => Z3, Z4 => Z4, Z5 => Z5, Z6 => Z6, Z7 => Z7);
	rf1:RF port map(Din0 => Z0, Din1 => Z1, Din2 => Z2, Din3 => Z3, Din4 => Z4, Din5 => Z5, Din6 => Z6, Din7 => Z7, Dout0 => X0, Dout1 => X1, Dout2 => X2, Dout3 => X3, Dout4 => X4, Dout5 => X5, Dout6 => X6, Dout7 => X7, clk => clk, enable => RF_Write, reset => reset);
	e1:encoder1 port map(X0 => X0, X1 => X1, X2 => X2, X3 => X3, X4 => X4, X5 => X5, X6 => X6, X7 => X7, Y => A1, enable => '1', Z => D1);
	e2:encoder1 port map(X0 => X0, X1 => X1, X2 => X2, X3 => X3, X4 => X4, X5 => X5, X6 => X6, X7 => X7, Y => A2, enable => '1', Z => D2);
end Procedural;
