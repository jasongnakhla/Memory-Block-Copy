----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2019 11:54:31 PM
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           counter: out STD_LOGIC_VECTOR(9 DOWNTO 0);
           re_1, re_2: out STD_LOGIC;
           we : out STD_LOGIC_VECTOR(0 DOWNTO 0));
end counter;

architecture Behavioral of counter is
type StateType is (idle, add1, add3);
-- Three states that add from 0-1-4-7-8-11-12
signal CurrentState, NextState: StateType;
signal temp: UNSIGNED(9 DOWNTO 0):= (others => '0');


begin

Memory: process(CurrentState)
begin
    case CurrentState is
        when idle =>
            NextState <= add3;
-- From 0 we want to go to 3
--            counter <= counter + 3;
        when add3 =>
            NextState <= add1;
-- From 3 we want to go to 4
--            counter <= counter + 1;            
        when add1 =>
            NextState <= add3;
-- From 4 we want to go to 7
-- go in 
--            counter <= counter + 3;
    end case;
end process;

State: process (clk,rst, NextState)
begin
    if(rst = '1') then
        CurrentState <= idle;
        temp <= (others => '0');
        re_1 <= '0';
        re_2 <= '0';
        we(0) <= '0';
    elsif (rising_edge(clk)) then
        CurrentState <= NextState;
        if (Currentstate = add1) then
-- add by 1
            temp <= temp + 1;
            re_1 <= '1';
            re_2 <= '1';
            we(0) <= '0'; 
        elsif (Currentstate = add3) then
            temp <= temp + 3;
            re_1 <= '0';
            re_2 <= '0';
            we(0) <= '1';
-- add by 3
        else
            temp <= (others => '0');
            re_1 <= '1';
            re_2 <= '1';
            we(0) <= '0';
        end if;
    end if;
end process;

counter <= std_logic_vector(temp);

end Behavioral;

