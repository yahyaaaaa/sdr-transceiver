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

entity qam16 is
    port(
        d_in : in STD_LOGIC_VECTOR (3 downto 0);
        I_out : out STD_LOGIC_VECTOR (2 downto 0);
        Q_out : out STD_LOGIC_VECTOR (2 downto 0)
        );
end qam16;

architecture behav of qam16 is

    signal d_I : std_logic_vector(1 downto 0);
    signal d_Q : std_logic_vector(1 downto 0);
    
begin

    d_I <= d_in(3 downto 2);
    d_Q <= d_in(1 downto 0);

    I_modulation : process(d_I)
    begin
        case d_I is
            when "00" =>
                I_out <= std_logic_vector(to_signed(-3, 3));
            when "01" =>
                I_out <= std_logic_vector(to_signed(-1, 3));
            when "11" =>
                I_out <= std_logic_vector(to_signed(1, 3));
            when "10" =>
                I_out <= std_logic_vector(to_signed(3, 3));
            when others =>
                I_out <= (others => '0');                      
        end case;
    end process;
    
    Q_modulation : process(d_Q)
    begin
        case d_Q is
            when "00" =>
                Q_out <= std_logic_vector(to_signed(-3, 3));
            when "01" =>
                Q_out <= std_logic_vector(to_signed(-1, 3));
            when "11" =>
                Q_out <= std_logic_vector(to_signed(1, 3));
            when "10" =>
                Q_out <= std_logic_vector(to_signed(3, 3));
            when others =>
                Q_out <= (others => '0');                      
        end case;
    end process;

end behav;
