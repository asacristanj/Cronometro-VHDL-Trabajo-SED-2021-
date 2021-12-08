library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
    signal unit_sec : std_logic_vector(3 downto 0);
    signal dec_sec : std_logic_vector(3 downto 0);
    signal unit_min : std_logic_vector(3 downto 0);
    signal dec_min : std_logic_vector(3 downto 0);
    
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
    begin
        if rising_edge(clk_1hz) then
        end if;
    end process;
    
    
    
end Behavioral;
