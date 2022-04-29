----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2022 15:41:37
-- Design Name: 
-- Module Name: qam16_demod - behav
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

entity qam16_demod is
    generic(
        constant MSB : integer := 15
    );
    Port ( I_in : in STD_LOGIC_VECTOR (MSB downto 0);
           Q_in : in STD_LOGIC_VECTOR (MSB downto 0);
           d_out : out STD_LOGIC_VECTOR (3 downto 0));
end qam16_demod;

architecture behav of qam16_demod is

begin

    I_demodulation : process(I_in)
    begin
        if I_in(MSB) = '0' then -- if signed value is positive
            if signed(I_in) > to_signed(1500,12) then
                d_out(3 downto 2) <= "10";
            else d_out(3 downto 2) <= "11";
            end if;
        elsif I_in(MSB) = '1' then -- if signed value is negative
            if signed(I_in) < to_signed(-1500,12) then
                d_out(3 downto 2) <= "00";
            else d_out(3 downto 2) <= "01";
            end if;
        end if;
    end process;
    
    Q_demodulation : process(Q_in)
    begin
        if Q_in(MSB) = '0' then -- if signed value is positive
            if signed(Q_in) > to_signed(1500,12) then
                d_out(1 downto 0) <= "10";
            else d_out(1 downto 0) <= "11";
            end if;
        elsif Q_in(MSB) = '1' then -- if signed value is negative
            if signed(Q_in) < to_signed(-1500,12) then
                d_out(1 downto 0) <= "00";
            else d_out(1 downto 0) <= "01";
            end if;
        end if;
    end process;

end behav;
