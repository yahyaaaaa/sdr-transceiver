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

entity bpsk is
    port(
        d_in : in std_logic_vector(3 downto 0);
        I_out : out STD_LOGIC_VECTOR (2 downto 0);
        Q_out : out STD_LOGIC_VECTOR (2 downto 0)
        );
end bpsk;

architecture behav of bpsk is

    signal d_sig : std_logic;
    
begin

    d_sig <= d_in(0);

    modulation : process(d_sig)
    begin
        case d_sig is
            when '0' =>
                I_out <= std_logic_vector(to_signed(-1, 3));
            when '1' =>
                I_out <= std_logic_vector(to_signed(1, 3));
            when others =>
                I_out <= (others => '0');                      
        end case;
    end process;
    
    Q_out <= (others => '0');

end behav;
