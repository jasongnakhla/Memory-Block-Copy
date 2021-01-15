----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2019 07:42:13 PM
-- Design Name: 
-- Module Name: ca6_dual - Behavioral
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



entity ca6_dual is
  Port ( clk: in STD_LOGIC;
         rst: in STD_LOGIC);
--         cen: in STD_LOGIC);
-- cen is not connecte to anything ignore
end ca6_dual;

architecture Behavioral of ca6_dual is
COMPONENT blk_mem_gen_0
 PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;

component counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           counter: out STD_LOGIC_VECTOR(9 DOWNTO 0);
           re_1, re_2: out STD_LOGIC;
           we : out STD_LOGIC_VECTOR(0 DOWNTO 0));
end component;

signal din1, din2: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal dout1, dout2, dout_reg, add_out: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal re1, re2: STD_LOGIC;
signal we1, we2: STD_LOGIC_VECTOR(0 DOWNTO 0);
signal addr1, addr2, count: STD_LOGIC_VECTOR(9 DOWNTO 0):= (others => '0');
signal count_b: UNSIGNED(9 DOWNTO 0):= (others => '0');


begin
mem_content: blk_mem_gen_0
PORT MAP(
    clka => clk,
    ena => re1,
    wea => we1,
    addra => addr1,
    dina => din1,
    douta => dout1,
    clkb => clk,
    enb => re2,
    web => we2,
    addrb => addr2,
    dinb => din2,
    doutb => dout2
  );
  
counter_module: counter port map(clk=>clk, rst=>rst, counter => count, re_1 => re1, re_2 => re2, we => we1);



din1 <= add_out;
add_out <= std_logic_vector(unsigned(dout1) + unsigned(dout2));
--re1 <= not count(0) and not count(1);
--re2 <= count_b(0) and not count_b(1);
--we1(0) <= count(0) and count(1);
--count <= std_logic_vector(counter);
addr1 <= count;
count_b <= unsigned(addr1) + 1;
addr2 <= std_logic_vector(count_b);
din2 <= (others => '0');
we2 <= "0";

end Behavioral;

























--entity ca6_dual is
--  Port ( clk: in STD_LOGIC;
--         rst: in STD_LOGIC;
--         cen: in STD_LOGIC);
--end ca6_dual;

--architecture Behavioral of ca6_dual is
--COMPONENT blk_mem_gen_0
-- PORT (
--    clka : IN STD_LOGIC;
--    ena : IN STD_LOGIC;
--    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
--    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
--    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
--    clkb : IN STD_LOGIC;
--    enb : IN STD_LOGIC;
--    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
--    dinb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
--    doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
--  );
--END COMPONENT;

--signal din1, din2: STD_LOGIC_VECTOR(15 DOWNTO 0);
--signal dout1, dout2, dout_reg, add_out: STD_LOGIC_VECTOR(15 DOWNTO 0);
--signal re1, re2: STD_LOGIC;
--signal we1, we2: STD_LOGIC_VECTOR(0 DOWNTO 0);
--signal addr1, addr2, count: STD_LOGIC_VECTOR(9 DOWNTO 0):= (others => '0');
--signal counter: UNSIGNED(9 DOWNTO 0):= (others => '0');


--begin
--mem_content: blk_mem_gen_0
--PORT MAP(
--    clka => clk,
--    ena => re1,
--    wea => we1,
--    addra => addr1,
--    dina => din1,
--    douta => dout1,
--    clkb => clk,
--    enb => re2,
--    web => we2,
--    addrb => addr2,
--    dinb => din2,
--    doutb => dout2
--  );
  
--process(clk)
--begin
--    if(rising_edge(clk)) then
--        if rst = '1' then
--            counter <= (others => '0'); 
--        else
--            if cen = '1' then
--                counter <= counter + "0000000001";    
--            else
--            counter <= (others => '0'); 
--            end if;
--        end if;
--    end if;
--end process;

----process(clk)
----begin
----    if(rising_edge(clk)) then
----        if rst = '1' then
----            din1 <= (others => '0');
----        else
--            din1 <= add_out;
----        end if;
----    end if;
----end process;


--add_out <= std_logic_vector(unsigned(dout1) + unsigned(dout2));
--re1 <= not count(0) and not count(1);
--re2 <= count(0) and not count(1);
--we1(0) <= count(0) and count(1);
--count <= std_logic_vector(counter);
--addr1 <= count;
--addr2 <= count;
--din2 <= (others => '0');
--we2 <= "0";

--end Behavioral;

