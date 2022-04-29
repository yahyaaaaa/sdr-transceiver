----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.03.2022 14:18:56
-- Design Name: 
-- Module Name: qam_mod - behav
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

entity qam4 is
    port(
        d_in : in STD_LOGIC_VECTOR (3 downto 0);
        I_out : out STD_LOGIC_VECTOR (2 downto 0);
        Q_out : out STD_LOGIC_VECTOR (2 downto 0)
        );
end qam4;

architecture behav of qam4 is
    
    signal d_sig : std_logic_vector(1 downto 0);
    
begin

    d_sig <= d_in(1 downto 0);

    modulation : process(d_sig)
    begin
        case d_sig is
            when "00" =>
                I_out <= std_logic_vector(to_signed(-1, 3));
                Q_out <= std_logic_vector(to_signed(-1, 3));
            when "01" =>
                I_out <= std_logic_vector(to_signed(-1, 3));
                Q_out <= std_logic_vector(to_signed(1, 3));
            when "11" =>
                I_out <= std_logic_vector(to_signed(1, 3));
                Q_out <= std_logic_vector(to_signed(1, 3));
            when "10" =>
                I_out <= std_logic_vector(to_signed(1, 3));
                Q_out <= std_logic_vector(to_signed(-1, 3));
            when others =>
                I_out <= (others => '0');
                Q_out <= (others => '0');                                         
        end case;
    end process;

end behav;
