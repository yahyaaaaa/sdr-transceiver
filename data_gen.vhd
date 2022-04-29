----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2022 18:05:20
-- Design Name: 
-- Module Name: data_gen - Behavioral
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

entity data_gen is

    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ready0 : in std_logic;
           ready1 : in std_logic;
           data : out STD_LOGIC_VECTOR (3 downto 0);
           valid : out std_logic := '0';
           mode : in std_logic_vector(1 downto 0));
           --clk_out : out std_logic);
end data_gen;

architecture behav of data_gen is

    signal counter : integer := -1;
    signal BITS : integer;
    signal ready : std_logic;
    signal seed : unsigned(31 downto 0) := x"17C5D0D4"; -- randomly chosen

begin
    
    ready <= ready0 or ready1;
    
    mode_select : process(mode)
    begin
        case mode is
            when "00" => BITS <= 1; -- bpsk
            when "01" => BITS <= 2; -- 4qam/qpsk
            when "11" => BITS <= 4; -- 16qam
            when others => BITS <= 2; -- defaults to 4qam
        end case;
    end process;
    
    
    data_gen : process(clk, reset) -- https://vhdlwhiz.com/random-numbers/
        variable data_temp : std_logic_vector(3 downto 0);
    begin
        if reset = '1' then
            data_temp := (others => '0');
        elsif clk'event and clk = '1' then
            counter <= (counter + 1) mod 64;
            if counter = 63 and ready = '1' then
                if BITS = 1 then
                    data_temp := (0 => seed(0),
                                  others => '0');
                    seed <= shift_right(seed, 1);
                    seed(31) <= seed(31) xor seed(29) xor seed(25) xor seed(24);
                elsif BITS = 2 then
                    data_temp := (0 => seed(0),
                                  1 => seed(1),
                                  others => '0');
                    for i in 0 to 1 loop -- https://web.archive.org/web/20161007061934/http://courses.cse.tamu.edu/csce680/walker/lfsr_table.pdf
                        seed <= shift_right(seed, 1);
                        seed(31) <= seed(31) xor seed(29) xor seed(25) xor seed(24);
                    end loop;
                elsif BITS = 4 then
                    data_temp := std_logic_vector(seed(3 downto 0));
                    for i in 0 to 3 loop -- https://web.archive.org/web/20161007061934/http://courses.cse.tamu.edu/csce680/walker/lfsr_table.pdf
                        seed <= shift_right(seed, 1);
                        seed(31) <= seed(31) xor seed(29) xor seed(25) xor seed(24);
                end loop;
                end if;
                valid <= '1';
            else
                valid <= '0';
            end if;
        end if;
        data <= data_temp;
    end process;
    
    --clk_out <= clk;
    
end behav;
