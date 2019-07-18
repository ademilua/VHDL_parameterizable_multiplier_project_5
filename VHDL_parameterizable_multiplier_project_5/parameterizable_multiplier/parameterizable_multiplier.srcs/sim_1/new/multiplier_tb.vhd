
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier_tb is
--  Port ( );
end multiplier_tb;

architecture Behavioral of multiplier_tb is
component multiplier is
Generic (data_width_mul:integer:=4); --I used "data_width_rca" because I want to use another "data_width" in the multiplier section
   Port ( A : in STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
           C_in : in STD_LOGIC;
           B : in STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
           Product : out STD_LOGIC_VECTOR (2*(data_width_mul)-1 downto 0)
           );
end component;

constant data_width_mul : integer:=4;
signal A_tb : STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
signal B_tb : STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
signal C_in_tb : STD_LOGIC:='0'; -- because the first carry in should be zero normally
signal Product_tb :  STD_LOGIC_VECTOR (2*(data_width_mul)-1 downto 0);

begin


uut: multiplier port map(
          A=>A_tb,
          B=>B_tb,
          C_in=>C_in_tb,
          Product=>Product_tb
         );

input_A:process
begin
for i in 0 to 2**data_width_mul-1 loop
  A_tb <= std_logic_vector(to_unsigned(i,data_width_mul)); 
  wait for 10 ns;
end loop;
end process;

input_B:process
begin
for i in 0 to 2**data_width_mul-1 loop
  B_tb <= std_logic_vector(to_unsigned(i,data_width_mul)); 
  wait for 10 ns;
end loop;
end process;

end Behavioral;