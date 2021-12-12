library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Cuenta_atras is
    Port (
        CLK : in std_logic;
        Enable_count : in std_logic;
        Pause : in std_logic;
        code1_in : in std_logic_vector(3 downto 0);
        code2_in : in std_logic_vector(3 downto 0);
        code3_in : in std_logic_vector(3 downto 0);
        code4_in : in std_logic_vector(3 downto 0);
        code1_out : out std_logic_vector(3 downto 0);
        code2_out : out std_logic_vector(3 downto 0);
        code3_out : out std_logic_vector(3 downto 0);
        code4_out : out std_logic_vector(3 downto 0);
        led : out std_logic
        
     );
end Cuenta_atras;

architecture Behavioral of Cuenta_atras is

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
    
    
    
    


end Behavioral;
