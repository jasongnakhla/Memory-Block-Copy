----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2019 05:23:22 PM
-- Design Name: 
-- Module Name: ca6 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ca6 is
  Port ( clk: in STD_LOGIC;
         rst: in STD_LOGIC;
         cen: in STD_LOGIC);
end ca6;

architecture Behavioral of ca6 is
COMPONENT blk_mem_gen_0
PORT(
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

signal din: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal dout, dout_reg, add_out: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal re: STD_LOGIC;
signal we: STD_LOGIC_VECTOR(0 DOWNTO 0);
signal addr, count: STD_LOGIC_VECTOR(9 DOWNTO 0):= (others => '0');
signal counter: UNSIGNED(9 DOWNTO 0):= (others => '0');

begin
mem_content: blk_mem_gen_0
PORT MAP(
    clka => clk,
    ena => re,
    wea => we,
    addra => addr,
    dina => din,
    douta => dout
  );
  
process(clk)
begin
    if(rising_edge(clk)) then
        if rst = '1' then
--            re <= '0';
--            we(0) <= '0';
            counter <= (others => '0'); 
        else
            if cen = '1' then
                counter <= counter + "0000000001";    
            else
                counter <= (others => '0'); 
            end if;
        end if;
    end if;
end process;

process(clk)
begin
    if(rising_edge(clk)) then
        if rst = '1' then
            dout_reg <= (others => '0');
            din <= (others => '0');
--            counter <= (others => '0');       
        else
            dout_reg <= dout;
            din <= add_out;
--            counter <= counter + "0000000001";
        end if;
    end if;
end process;

--            dout_reg <= dout;
--            din <= add_out;


add_out <= std_logic_vector(unsigned(dout_reg) + unsigned(dout));
re <= not count(1);
we(0) <= count(0) and count(1);
count <= std_logic_vector(counter);
addr <= count;

end Behavioral;
