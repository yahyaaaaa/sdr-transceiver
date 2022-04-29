----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2022 20:37:28
-- Design Name: 
-- Module Name: bpsk_demod - behav
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

entity bpsk_demod is
    generic(
        constant MSB : integer := 15
    );
    Port ( I_in : in STD_LOGIC_VECTOR (MSB downto 0);
           Q_in : in STD_LOGIC_VECTOR (MSB downto 0);
           d_out : out STD_LOGIC_VECTOR(3 downto 0));
end bpsk_demod;

architecture behav of bpsk_demod is

    signal d_temp : std_logic;

begin

    I_demodulation : process(I_in)
    begin
        if I_in(MSB) = '0' then d_temp <= '1'; -- if signed value is positive
        elsif I_in(MSB) = '1' then d_temp <= '0'; -- if signed value is negative
        else d_temp <= 'X';
        end if;
    end process;

    d_out <= "000" & d_temp;

end behav;
