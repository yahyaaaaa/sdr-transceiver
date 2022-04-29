library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mod_mux is port(
    I_bpsk  : in std_logic_vector(2 downto 0);
    Q_bpsk  : in std_logic_vector(2 downto 0);
    I_4qam  : in std_logic_vector(2 downto 0);
    Q_4qam  : in std_logic_vector(2 downto 0);
    I_16qam : in std_logic_vector(2 downto 0);
    Q_16qam : in std_logic_vector(2 downto 0);
    I_out   : out std_logic_vector(2 downto 0);
    Q_out   : out std_logic_vector(2 downto 0);
    mode     : in std_logic_vector(1 downto 0)
);
end mod_mux;

architecture behav of mod_mux is

begin

    mux : process(mode, I_bpsk, Q_bpsk, I_4qam, Q_4qam, I_16qam, Q_16qam)
    begin
        case mode is
            when "00" => -- bpsk
                I_out <= I_bpsk;
                Q_out <= Q_bpsk;
            when "01" => -- 4qam/qpsk
                I_out <= I_4qam;
                Q_out <= Q_4qam;
            when "11" => -- 16qam
                I_out <= I_16qam;
                Q_out <= Q_16qam;
            when others => -- defaults to 4qam
                I_out <= I_4qam;
                Q_out <= Q_4qam;
        end case;
    end process;
    
end behav;