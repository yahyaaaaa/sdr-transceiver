----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2022 15:41:37
-- Design Name: 
-- Module Name: mod_demux - behav
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

entity mod_demux is
    Port ( I_in : in STD_LOGIC_VECTOR (15 downto 0);
           Q_in : in STD_LOGIC_VECTOR (15 downto 0);
           mode : in STD_LOGIC_VECTOR (1 downto 0);
           I_bpsk : out STD_LOGIC_VECTOR (15 downto 0);
           Q_bpsk : out STD_LOGIC_VECTOR (15 downto 0);
           I_4qam : out STD_LOGIC_VECTOR (15 downto 0);
           Q_4qam : out STD_LOGIC_VECTOR (15 downto 0);
           I_16qam : out STD_LOGIC_VECTOR (15 downto 0);
           Q_16qam : out STD_LOGIC_VECTOR (15 downto 0));
end mod_demux;

architecture behav of mod_demux is

begin

    demux : process(mode, I_in, Q_in)
    begin
        case mode is
            when "00" => -- bpsk
                I_bpsk <= I_in;
                Q_bpsk <= Q_in;
                I_4qam <= (others => '0');
                Q_4qam <= (others => '0');
                I_16qam <= (others => '0');
                Q_16qam <= (others => '0');
            when "01" => -- qpsk/4qam
                I_bpsk <= (others => '0');
                Q_bpsk <= (others => '0');
                I_4qam <= I_in;
                Q_4qam <= Q_in;
                I_16qam <= (others => '0');
                Q_16qam <= (others => '0');
            when "11" => -- 16qam
                I_bpsk <= (others => '0');
                Q_bpsk <= (others => '0');
                I_4qam <= (others => '0');
                Q_4qam <= (others => '0');
                I_16qam <= I_in;
                Q_16qam <= Q_in;
            when others => -- defaults to 4qam
                I_bpsk <= (others => '0');
                Q_bpsk <= (others => '0');
                I_4qam <= I_in;
                Q_4qam <= Q_in;
                I_16qam <= (others => '0');
                Q_16qam <= (others => '0');
        end case;
    end process;

end behav;
