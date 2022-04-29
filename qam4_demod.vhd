----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2022 15:43:14
-- Design Name: 
-- Module Name: qam4_demod - Behavioral
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

entity qam4_demod is
    generic(
        constant MSB : integer := 15
    );
    Port ( I_in : in STD_LOGIC_VECTOR (MSB downto 0);
           Q_in : in STD_LOGIC_VECTOR (MSB downto 0);
           d_out : out STD_LOGIC_VECTOR (3 downto 0)
           );
end qam4_demod;

architecture behav of qam4_demod is

    signal d_temp : std_logic_vector(1 downto 0);

begin

    I_demodulation : process(I_in)
    begin
        if I_in(MSB) = '0' then d_temp(1) <= '1'; -- if signed value is positive
        elsif I_in(MSB) = '1' then d_temp(1) <= '0'; -- if signed value is negative
        else d_temp(1) <= 'X';
        end if;
    end process;

    Q_demodulation : process(Q_in)
    begin
        if Q_in(MSB) = '0' then d_temp(0) <= '1';
        elsif Q_in(MSB) = '1' then d_temp(0) <= '0';
        else d_temp(0) <= 'X';
        end if;
    end process;
    
    d_out <= "00" & d_temp;
    
end behav;
