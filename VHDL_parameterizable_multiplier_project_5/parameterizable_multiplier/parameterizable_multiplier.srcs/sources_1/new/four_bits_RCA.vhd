
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity four_bits_RCA is
Generic (data_width_rca:integer:=4); --I used "data_width_rca" because I want to use another "data_width" in the multiplier section
   Port ( A : in STD_LOGIC_VECTOR (data_width_rca-1 downto 0);
           B : in STD_LOGIC_VECTOR (data_width_rca-1 downto 0);
           C_in : in STD_LOGIC;
           SUM : out STD_LOGIC_VECTOR (data_width_rca downto 0);
           C_out : out STD_LOGIC);
end four_bits_RCA;

architecture Behavioral of four_bits_RCA is
signal C_out_temp:STD_LOGIC_VECTOR (data_width_rca-1 downto 0);
signal Sum_temp:STD_LOGIC_VECTOR (data_width_rca-1 downto 0);

begin

C_out_temp(0) <= (A(0) and B(0)) or (B(0) and C_in) or (A(0) and C_in);--the user shoould specify the initial carry in, although always zero 
Sum_temp(0) <= A(0) xor B(0) xor C_in; ---sum

four_b_RCA:for i in 1 to data_width_rca-1 generate
   Sum_temp(i) <= A(i) xor B(i) xor C_out_temp(i-1); ---sum
   C_out_temp(i) <= (A(i) and B(i)) or (B(i) and C_out_temp(i-1)) or (A(i) and C_out_temp(i-1)); --Carry out
end generate;

C_out <= C_out_temp(data_width_rca-1);
SUM(data_width_rca-1 downto 0) <= Sum_temp;
SUM(data_width_rca)<= C_out_temp(data_width_rca-1);

end Behavioral;

--one bit adder description is shown below
--Sum <= A xor B xor C_in; ---sum
--C_out <= (A and B) or (B and C_in) or (A and C_in); --Carry out
