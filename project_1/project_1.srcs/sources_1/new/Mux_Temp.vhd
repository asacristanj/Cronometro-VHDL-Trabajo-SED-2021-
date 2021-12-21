library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux_Temp is
    Port (
        Enable_Sel : in std_logic;
        code1_Sel : in std_logic_vector(3 downto 0);
        code2_Sel : in std_logic_vector(3 downto 0);
        code3_Sel : in std_logic_vector(3 downto 0);
        code4_Sel : in std_logic_vector(3 downto 0);
        code1_Count : in std_logic_vector(3 downto 0);
        code2_Count : in std_logic_vector(3 downto 0);
        code3_Count : in std_logic_vector(3 downto 0);
        code4_Count : in std_logic_vector(3 downto 0);
        code1 : out std_logic_vector(3 downto 0);
        code2 : out std_logic_vector(3 downto 0);
        code3 : out std_logic_vector(3 downto 0);
        code4 : out std_logic_vector(3 downto 0)
    );
end Mux_Temp;

architecture Behavioral of Mux_Temp is

begin
    process(Enable_Sel)
    begin
        if Enable_Sel='1' then
            code1<=code1_Sel;
            code2<=code2_Sel;
            code3<=code3_Sel;
            code4<=code4_Sel;
        else
            code1<=code1_Count;
            code2<=code2_Count;
            code3<=code3_Count;
            code4<=code4_Count;
        end if;
    end process;
end Behavioral;
