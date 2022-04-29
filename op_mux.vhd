----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 15:32:29
-- Design Name: 
-- Module Name: op_mux - Behavioral
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

entity op_mux is
    Port ( bpsk_data : in STD_LOGIC_VECTOR (3 downto 0);
           qpsk_data : in STD_LOGIC_VECTOR (3 downto 0);
           qam16_data : in STD_LOGIC_VECTOR (3 downto 0);
           mode : in STD_LOGIC_VECTOR (1 downto 0);
           d_out : out STD_LOGIC_VECTOR (3 downto 0));
end op_mux;

architecture Behavioral of op_mux is

begin

    mux : process(bpsk_data, qpsk_data, qam16_data)
    begin
        case mode is
            when "00" => d_out <= bpsk_data;
            when "01" => d_out <= qpsk_data;
            when "11" => d_out <= qam16_data;
            when others => d_out <= qpsk_data; -- defaults to qpsk/4qam
        end case;
    end process;

end Behavioral;
