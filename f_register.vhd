library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_unsigned.all;
-- edited



entity f_register is
  generic (n: integer := 8; -- word length
				m: integer := 7);-- number of registers
  

  port (res : in std_logic;   -- reset signal 
        wd : in std_logic_vector ((n-1) downto 0);-- write data
        waddr : in std_logic_vector ((m-1) downto 0); -- data address
        writ,readA,readB, CLK : in std_logic ; -- clock/ read n write enable
        RA, RB : in std_logic_vector ((m-1) downto 0); -- reading address
        QA, QB : out std_logic_vector ((n-1) downto 0)); -- ouput word
        
end entity f_register;
  
  
architecture structural of f_register is
  type ram is array (((2**m)-1) downto 0 ) of std_logic_vector((n-1) downto 0);
  signal ram1_1 : ram; 
  
  begin 
	
	
  process (clk, res, writ, reada, readb)
    begin
    
    if (res='1') then
      ram1_1 <= (OTHERS => (OTHERS => '0'));
      
    elsif (clk='1') and clk'event then
      
      if ( writ= '1') then 
         ram1_1(conv_integer(waddr)) <= wd;
         
      end if;
      
      if (readA = '1') and (readB = '1') then
        QA <= ram1_1(conv_integer(RA));
        QB <= ram1_1(conv_integer(RB));
      elsif (readA = '1') and (readB = '0') then
        QA <= ram1_1(conv_integer(RA));
        QB <= (others => '0');
      elsif (readA = '0') and (readB = '1') then
        QA <= (others => '0');
        QB <= ram1_1(conv_integer(RB));
      end if;
              
      
    end if;
        
  end process;
      

end structural;


