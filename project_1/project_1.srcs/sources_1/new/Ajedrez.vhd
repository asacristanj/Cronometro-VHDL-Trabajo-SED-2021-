library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Ajedrez is
    Port (
        CLK : in std_logic;
        B1 : in std_logic;
        B2 : in std_logic;
        B3 : in std_logic;
        B4 : in std_logic;
        B5 : in std_logic;
        code1 : out std_logic_vector(3 downto 0);
        code2 : out std_logic_vector(3 downto 0);
        code3 : out std_logic_vector(3 downto 0);
        code4 : out std_logic_vector(3 downto 0);
        code5 : out std_logic_vector(3 downto 0);
        code6 : out std_logic_vector(3 downto 0);
        code7 : out std_logic_vector(3 downto 0);
        code8 : out std_logic_vector(3 downto 0);
        Enable_C : in std_logic;
        led : out std_logic
    );
end Ajedrez;

architecture Behavioral of Ajedrez is

    signal Reset_aux_A : std_logic:='0';
    signal Reset_aux_B : std_logic:='0';
    
    signal Enable_count_A : std_logic:='0';
    signal Enable_count_B : std_logic:='0';
    
    signal ledA : std_logic:='0';
    signal ledB : std_logic:='0';
    


    COMPONENT Cuenta_atras
       PORT (
        CLK : in std_logic;
        Enable_count : in std_logic;
        Reset : in std_logic;
        code1_in : in std_logic_vector(3 downto 0);
        code2_in : in std_logic_vector(3 downto 0);
        code3_in : in std_logic_vector(3 downto 0);
        code4_in : in std_logic_vector(3 downto 0);
        code1_out : out std_logic_vector(3 downto 0);--unidades de segundo
        code2_out : out std_logic_vector(3 downto 0);--decenas de segundo
        code3_out : out std_logic_vector(3 downto 0);--unidades de minuto
        code4_out : out std_logic_vector(3 downto 0);--decenas de minuto
        led : out std_logic
       );
    END COMPONENT;
    
begin

    JugadorA : Cuenta_atras PORT MAP(
        CLK => CLK,
        Enable_count => Enable_count_A,
        Reset => Reset_aux_A,
        code1_in =>"0000",
        code2_in =>"0000",
        code3_in =>"0000",
        code4_in =>"0001",
        code1_out => code1,--unidades de segundo
        code2_out => code2,--decenas de segundo
        code3_out => code3,--unidades de minuto
        code4_out => code4,--decenas de minuto
        led => ledA
    );

    JugadorB : Cuenta_atras PORT MAP(
        CLK => CLK,
        Enable_count => Enable_count_B,
        Reset => Reset_aux_B,
        code1_in =>"0000",
        code2_in =>"0000",
        code3_in =>"0000",
        code4_in =>"0001",
        code1_out => code5,--unidades de segundo
        code2_out => code6,--decenas de segundo
        code3_out => code7,--unidades de minuto
        code4_out => code8,--decenas de minuto
        led => ledB
    );


    maquinaestados : process(B1,B3,B4,Enable_C)
    begin
        if Enable_C='0' or B1='1' then
            Reset_aux_A<='1';
            Reset_aux_B<='1';
            Enable_count_A<='0';
            Enable_count_B<='0';
        elsif Enable_C='1' and B4='1' then
            Enable_count_A<='1';
            Enable_count_B<='0';
        elsif Enable_C='1' and B3='1' then
            Enable_count_A<='0';
            Enable_count_B<='1';
        end if;
        
    end process;
    
    
end Behavioral;
