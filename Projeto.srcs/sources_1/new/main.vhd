----------------------------------------------------------------------------------
-- Create Date: 15.10.2014 19:29:30
-- Design Name: Projeto 1 - 7 segmentos
-- Module Name: SS_controller - rtl
-- Project Name: 7 segmentos
-- Target Devices: 
-- Tool Versions: 
-- Description: Utilizar os 8 displays de 7 segmentos da placa
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SS_controller is
generic(
    fclk : natural := 100000000; -- frequencia do clk (Hz)
    f7s : natural := 100 -- frequencia de atualizacao dos displays (Hz)
);

    Port (
        clk : in STD_LOGIC;
        btnCpuReset : in STD_LOGIC;
        led : out STD_LOGIC_VECTOR (15 downto 0);
        seg : out STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
        an : out STD_LOGIC_VECTOR (7 downto 0) := X"00"
    );
end SS_controller;

architecture rtl of SS_controller is
    -- Constantes que definem o valor mostrado no display
    constant SS0_valor : integer range 0 to 9 := 0;
    constant SS1_valor : integer range 0 to 9 := 1;
    constant SS2_valor : integer range 0 to 9 := 2;
    constant SS3_valor : integer range 0 to 9 := 3;
    constant SS4_valor : integer range 0 to 9 := 4;
    constant SS5_valor : integer range 0 to 9 := 5;
    constant SS6_valor : integer range 0 to 9 := 6;
    constant SS7_valor : integer range 0 to 9 := 7;
	
    -- Constantes que definem o valor dos catodos para cada digito
    constant digito0 : std_logic_vector (6 downto 0) := "1000000";
    constant digito1 : std_logic_vector (6 downto 0) := "1111001";
    constant digito2 : std_logic_vector (6 downto 0) := "0100100";
    constant digito3 : std_logic_vector (6 downto 0) := "0110000";
    constant digito4 : std_logic_vector (6 downto 0) := "0011001";
    constant digito5 : std_logic_vector (6 downto 0) := "0010010";
    constant digito6 : std_logic_vector (6 downto 0) := "0000010";
    constant digito7 : std_logic_vector (6 downto 0) := "1111000";
    constant digito8 : std_logic_vector (6 downto 0) := "0000000";
    constant digito9 : std_logic_vector (6 downto 0) := "0010000";
	
    -- Contador do tempo
    signal cnt : integer := 0;
    variable valorAtual : integer range 0 to 9 := 0;
	
    -- Display aceso atual
    signal displayAtual : integer range 0 to 7 := 0;
	
begin

    an  <=  "11111110" when displayAtual = 0 else
            "11111101" when displayAtual = 1 else
            "11111011" when displayAtual = 2 else
            "11110111" when displayAtual = 3 else
            "11101111" when displayAtual = 4 else
            "11011111" when displayAtual = 5 else
            "10111111" when displayAtual = 6 else
            "01111111" when displayAtual = 7;
    
    seg <=  digito0 when valorAtual = 0 else
            digito1 when valorAtual = 1 else
            digito2 when valorAtual = 2 else
            digito3 when valorAtual = 3 else
            digito4 when valorAtual = 4 else
            digito5 when valorAtual = 5 else
            digito6 when valorAtual = 6 else
            digito7 when valorAtual = 7 else
            digito8 when valorAtual = 8 else
            digito9 when valorAtual = 9;
    
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (cnt=((fclk/f7s)/8)) then
                cnt := 0;
                case displayAtual is
                    when 0 => valorAtual := SS0_valor;
                    when 1 => valorAtual := SS1_valor;
                    when 2 => valorAtual := SS2_valor;
                    when 3 => valorAtual := SS3_valor;
                    when 4 => valorAtual := SS4_valor;
                    when 5 => valorAtual := SS5_valor;
                    when 6 => valorAtual := SS6_valor;
                    when 7 => valorAtual := SS7_valor;
                end case;
                displayAtual := displayAtual + 1;
            else
                cnt := cnt + 1;
            end if;
        end if;
    end process;
    
end rtl;