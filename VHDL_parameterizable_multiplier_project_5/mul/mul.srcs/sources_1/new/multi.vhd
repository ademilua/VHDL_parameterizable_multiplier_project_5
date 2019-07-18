library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity multi is
Generic (data_width_mul:integer:=4); --I used "data_width_rca" because I want to use another "data_width" in the multiplier section
   Port (  A_mul : in STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
           B_mul : in STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
           C_in_mul: in std_logic;
           clk: in std_logic;
           Product : out STD_LOGIC_VECTOR (2*(data_width_mul)-1 downto 0));
end multi;

architecture Behavioral of multi is
component four_bits_RCAA
--Generic (data_width_rca:integer:=data_width_mul); --I used "data_width_rca" because I want to use another "data_width" in the multiplier section
Port (     A : in STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
           B : in STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
           C_in : in STD_LOGIC;
           SUM : out STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
           C_out : out STD_LOGIC);
end component;           

type adder is array (0 to data_width_mul-1) of std_logic_vector(data_width_mul-1 downto 0);
signal addings,Product_sigg: adder;
type CCC is array (0 to data_width_mul-1) of std_logic;
signal my_Cout: CCC;
signal Product_sig : STD_LOGIC_VECTOR (2*(data_width_mul)-1 downto 0);
signal new_B : STD_LOGIC_VECTOR (data_width_mul-1 downto 0);
signal var_new  : STD_LOGIC_VECTOR (data_width_mul downto 0);
constant data_width_rca : integer:=data_width_mul;

begin 
--getting the added values to be used
ands: for j in 0 to data_width_mul-1 generate
   ands2: for k in 0 to data_width_mul-1 generate
    addings(j)(k) <= B_mul(j) and A_mul(k); 
   end generate; 
end generate;

mymul: for i in 0 to data_width_mul-2 generate
    first_index:if i = 0 generate
      four_bits_adder: component four_bits_RCAA port map(
        C_in=>C_in_mul,  --completed
        B=>addings(i),-- Product_sig((data_width_mul+i) downto (i+1)), --completed
        A=>addings(i+1), --completed
        SUM=>Product_sigg(i)--((data_width_mul+i+1) downto (i+1)) --completed --NB:here SUM is 1 bit more than B and A inputs 
        );
    end generate;
    subsequent_index:if i > 0 generate
     var_new <=  Product_sigg(i-1)(data_width_mul)&Product_sigg(i);
     new_B <=var_new(data_width_mul downto 1); 
      four_bits_adder: component four_bits_RCAA port map(
        C_in=>C_in_mul,  --completed
        B=>new_B, --completed
        A=>addings(i+1), --completed
        SUM=>Product_sigg(i),--Product_sig((data_width_mul+i+1) downto (i+1)) --completed --NB:here SUM is 1 bit more than B and A inputs 
        C_out=>Product_sigg(i)(data_width_mul)
        );
    end generate;

end generate;

Product<=Product_sig;
end Behavioral;
