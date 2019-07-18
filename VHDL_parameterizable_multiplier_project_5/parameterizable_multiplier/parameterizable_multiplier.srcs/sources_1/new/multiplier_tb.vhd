
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity multiplier_tb is
--  Port ( );
end multiplier_tb;

architecture Behavioral of multiplier_tb is
component multiplier is
Generic (data_width_mul:integer:=4); --I used "data_width_rca" because I want to use another "data_width" in the multiplier section
   Port (  A_mul : in STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
           B_mul : in STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
           C_in_mul: in std_logic;
           Product : out STD_LOGIC_VECTOR ((2*data_width_mul)-1 downto 0));
end component;
signal data_width_mul : integer:=4;  
signal A_mul_tb : STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
signal B_mul_tb : STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
signal Product_tb : STD_LOGIC_VECTOR ((2*data_width_mul)-1 downto 0);
signal C_in_mul_tb:  std_logic:='0';

begin
uut: multiplier port map(
A_mul=>A_mul_tb,
B_mul=>B_mul_tb,
C_in_mul=>C_in_mul_tb,
Product=>Product_tb);

process
begin
for k in 0 to (2**data_width_mul)-1 loop
  A_mul_tb<=std_logic_vector(to_unsigned(k,data_width_mul));
  for h in 0 to (2**data_width_mul)-1 loop
    B_mul_tb<=std_logic_vector(to_unsigned(h,data_width_mul));
    wait for 10 ns;
  end loop;
end loop;
wait;    
end process;
    
end Behavioral;
