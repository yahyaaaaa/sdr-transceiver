----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2022 14:24:44
-- Design Name: 
-- Module Name: downsampler - Behavioral
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

entity downsampler is
    Port ( d_in : in STD_LOGIC_VECTOR (15 downto 0);
           valid_in : in STD_LOGIC;
           clk : in std_logic;
           d_out : out STD_LOGIC_VECTOR (15 downto 0));
end downsampler;

architecture Behavioral of downsampler is

    signal valid_count : integer := 2;

begin

    process(clk)
    begin
        if clk'event and clk = '1' then
            if valid_in = '1' then
                valid_count <= valid_count + 1;
                if valid_count = 7 then
                    d_out <= d_in;
                    valid_count <= 0;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
