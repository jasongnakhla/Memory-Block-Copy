----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2019 06:33:55 PM
-- Design Name: 
-- Module Name: ca6_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ca6_tb is
--  Port ( );
end ca6_tb;

architecture Behavioral of ca6_tb is
component ca6 is
  Port ( clk: in STD_LOGIC;
         rst: in STD_LOGIC;
         cen: in STD_LOGIC);
end component;

signal clk_int, rst_int, cen_int: STD_LOGIC;
constant cp: time:= 10ns;

begin

uut: ca6 port map(clk => clk_int, rst => rst_int, cen => cen_int);

process
begin
clk_int <= '0';
wait for cp/2;
clk_int <= '1';
wait for cp/2;
end process;

process
begin
rst_int <= '1';
wait for cp;
rst_int <= '0';
wait;
end process;

process
begin
cen_int <= '0';
wait for 2.5*cp;
cen_int <= '1';
wait;
end process;

end Behavioral;
