----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2019 12:12:04 AM
-- Design Name: 
-- Module Name: counter_tb - Behavioral
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

entity counter_tb is
--  Port ( );
end counter_tb;

architecture Behavioral of counter_tb is

component counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           counter: out STD_LOGIC_VECTOR(9 DOWNTO 0));
end component;

signal clk_int, rst_int: STD_LOGIC;
signal counter_int: STD_LOGIC_VECTOR(9 DOWNTO 0);
constant cp: time:= 10ns;

begin

uut: counter port map(clk => clk_int, rst => rst_int, counter => counter_int);

process
begin
clk_int <= '1';
wait for cp/2;
clk_int <= '0';
wait for cp/2;
end process;

process
begin
rst_int <= '1';
wait for cp;
rst_int <= '0';
wait;
end process;

end Behavioral;
