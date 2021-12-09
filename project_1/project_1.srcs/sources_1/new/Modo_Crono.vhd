library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Modo_Crono is
    Port (
        CLK : in std_logic;
        code1 : out std_logic_vector(3 downto 0);
        code2 : out std_logic_vector(3 downto 0);
        code3 : out std_logic_vector(3 downto 0);
        code4 : out std_logic_vector(3 downto 0);
        code5 : out std_logic_vector(3 downto 0);
        code6 : out std_logic_vector(3 downto 0);
        code7 : out std_logic_vector(3 downto 0);
        code8 : out std_logic_vector(3 downto 0);
        Enable_A : in std_logic;
        Buttons : in std_logic_vector(3 downto 0)
     );
end Modo_Crono;

architecture Behavioral of Modo_Crono is
    --signal unit_sec : std_logic_vector(3 downto 0);
    --signal dec_sec : std_logic_vector(3 downto 0);
    --signal unit_min : std_logic_vector(3 downto 0);
    --signal dec_min : std_logic_vector(3 downto 0);
    
    signal clk_1hz : std_logic;
    
    COMPONENT clk1hz
       PORT (
              CLK: in  STD_LOGIC;
              clk_1hz : out STD_LOGIC
            );
       END COMPONENT;
begin
    Inst_clk1hz: clk1hz 
    PORT MAP (
        CLK => CLK,
        CLK_1hz => clk_1hz
    );
    
    process (clk_1hz)
    subtype V is integer range 0 to 15;
    variable unit_sec : V :=0;
    variable unit_min : V :=0;
    variable dec_sec : V :=0;
    variable dec_min : V :=0;
    begin
        if rising_edge(clk_1hz) then
            unit_sec:=unit_sec+1;
            if unit_sec=10 then
            unit_sec:=0;
            end if;
            
        end if;
        code8 <= std_logic_vector(to_unsigned(unit_sec,code8'length));
        code7 <= std_logic_vector(to_unsigned(dec_sec,code7'length));
        code6 <= std_logic_vector(to_unsigned(unit_min,code6'length));
        code5 <= std_logic_vector(to_unsigned(dec_sec,code5'length));
    end process;
    
    process 
    begin
    code1<="1001";
    code2<="1001";
    code3<="1111";
    code4<="1111";
    end process;
    
    
end Behavioral;
