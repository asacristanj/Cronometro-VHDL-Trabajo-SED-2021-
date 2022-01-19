library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Modo_Temp is
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
        Enable_B : in std_logic;
        led : out std_logic
    );
end Modo_Temp;

architecture Behavioral of Modo_Temp is
type estados is (Sel,c,p,r,rp);
signal estadoActual, siguienteEstado:estados;

    signal Enable_sel : std_logic:='0';
    signal Enable_count : std_logic:='0';
    signal Reset_aux : std_logic:='0';
    
    signal code1_Sel : std_logic_vector(3 downto 0);
    signal code2_Sel : std_logic_vector(3 downto 0);
    signal code3_Sel : std_logic_vector(3 downto 0);
    signal code4_Sel : std_logic_vector(3 downto 0);
    
    signal code1_Count : std_logic_vector(3 downto 0);
    signal code2_Count : std_logic_vector(3 downto 0);
    signal code3_Count : std_logic_vector(3 downto 0);
    signal code4_Count : std_logic_vector(3 downto 0);

    COMPONENT Sel_Cuenta
       PORT (
        clk : in std_logic;
        B1 : in std_logic;
        B2 : in std_logic;
        B3 : in std_logic;
        B4 : in std_logic;
        Enable : in std_logic;
        code1_Sel : out std_logic_vector(3 downto 0);
        code2_Sel : out std_logic_vector(3 downto 0);
        code3_Sel : out std_logic_vector(3 downto 0);
        code4_Sel : out std_logic_vector(3 downto 0)
       );
    END COMPONENT;
    
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
    
    COMPONENT Mux_Temp
       PORT (
        clk: in std_logic;
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
    END COMPONENT;

begin

    Sel_Cuenta1: Sel_Cuenta PORT MAP(
        clk=>CLK,
        B1=>B1,
        B2=>B2,
        B3=>B3,
        B4=>B4,
        Enable=>Enable_sel,
        code1_Sel=>code1_Sel,
        code2_Sel=>code2_Sel,
        code3_Sel=>code3_Sel,
        code4_Sel=>code4_Sel
    );


    Cuenta_atras1 : Cuenta_atras PORT MAP(
        CLK => CLK,
        Enable_count => Enable_count,
        Reset => Reset_aux,
        code1_in => code1_Sel,
        code2_in => code2_Sel,
        code3_in => code3_Sel,
        code4_in => code4_Sel,
        code1_out => code1_Count,--unidades de segundo
        code2_out => code2_Count,--decenas de segundo
        code3_out => code3_Count,--unidades de minuto
        code4_out => code4_Count,--decenas de minuto
        led => led
    );
    
    Mux_Temp1 : Mux_Temp PORT MAP(
        Enable_Sel=>Enable_Sel,
        code1_Sel=>code1_Sel,
        code2_Sel=>code2_Sel,
        code3_Sel=>code3_Sel,
        code4_Sel=>code4_Sel,
        code1_Count=>code1_Count,
        code2_Count=>code2_Count,
        code3_Count=>code3_Count,
        code4_Count=>code4_Count,
        code1=>code1,
        code2=>code2,
        code3=>code3,
        code4=>code4,
        clk=>clk
    );

    modoTemp : process (Enable_B)
    begin
        if Enable_B='1' then
            code8<="1100";
            code7<="1101";
            code6<="1111";
            code5<="1111";
        end if;
    end process;

    
 state_reg: process (clk,enable_b)
 begin   
    if enable_b='0' then
        estadoActual<=rp;
    elsif rising_edge(clk) then
        estadoActual<= siguienteEstado;
    end if;
 end process;
maquinaestados : process (Enable_B,estadoActual, B2,B4,B5) 
begin
    siguienteEstado<=estadoActual;
        case estadoActual is
            when Sel=>
                if enable_sel='1' and B5='1' then
                siguienteEstado<=c;
                end if;
            when c=>
                if B2='1' then 
                siguienteEstado<=p;
                elsif B4='1' then
                siguienteEstado<=r;
                end if;
            when p=>
                if B4='1' then
                siguienteEstado<=r;
                elsif B5='1' then
                siguienteEstado<=c;
                end if;
            when r=>
                if B5='1' then
                siguienteEstado<=c;
                end if;
            when rp=>
                if enable_b='1' then
                siguienteEstado<=sel;
                end if;
            end case;
            
end process;
salidas: process(estadoActual)
    begin 
        case estadoActual is
            when Sel=>
                enable_sel<='1';
                enable_count<='0';
                reset_aux<='1';
            when c=>
                enable_sel<='0';
                enable_count<='1';
                reset_aux<='0';
            when p=>
                enable_sel<='0';
                enable_count<='0';
                reset_aux<='0';
            when r=>
                enable_sel<='0';
                enable_count<='0';
                reset_aux<='1';  
            when rp=>
                enable_sel<='0';
                enable_count<='0';
                reset_aux<='0';  
        end case;
    end process;
end Behavioral;
