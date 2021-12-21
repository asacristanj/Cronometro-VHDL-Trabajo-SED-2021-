library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP is
    Port ( 
        CLK : in std_logic;
        B_L : in std_logic;
        B_R : in std_logic;
        B_U : in std_logic;
        B_D : in std_logic;
        B_C : in std_logic;
        reset : in std_logic;
        refrescar_anodo : out std_logic_vector(7 downto 0); --vector que pone a 1 el ánodo correspondiente para actualizar
        salida_disp : out std_logic_vector(6 downto 0); --salida de los displays
        led : out std_logic
    );
end TOP;

architecture Behavioral of TOP is

    signal sync_auxL: std_logic;
    signal sync_auxR: std_logic;
    signal sync_auxU: std_logic;
    signal sync_auxD: std_logic;
    signal sync_auxC: std_logic;
    
    signal B_L_aux: std_logic;
    signal B_R_aux: std_logic;
    signal B_U_aux: std_logic;
    signal B_D_aux: std_logic;
    signal B_C_aux: std_logic;
    signal Reset_aux: std_logic;
    
    signal Enable_A: std_logic;
    signal Enable_B: std_logic;
    signal Enable_C: std_logic;

    signal code1 : std_logic_vector(3 downto 0);
    signal code2 : std_logic_vector(3 downto 0);
    signal code3 : std_logic_vector(3 downto 0);
    signal code4 : std_logic_vector(3 downto 0);
    signal code5 : std_logic_vector(3 downto 0);
    signal code6 : std_logic_vector(3 downto 0);
    signal code7 : std_logic_vector(3 downto 0);
    signal code8 : std_logic_vector(3 downto 0);

    COMPONENT GestorEntradas
       PORT (
            CLK : in std_logic;
            B_L : in std_logic;
            B_R : in std_logic;
            B_U : in std_logic;
            B_D : in std_logic;
            B_C : in std_logic;
            reset : in std_logic;
            B_L_out : out std_logic;
            B_R_out : out std_logic;
            B_U_out : out std_logic;
            B_D_out : out std_logic;
            B_C_out : out std_logic;
            reset_out : out std_logic
       );
    END COMPONENT;
    
    COMPONENT MaquinaEstados
       PORT (
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
            Reset : in std_logic;
            Enable_A : out std_logic :='0';
            Enable_B : out std_logic :='0';
            Enable_C : out std_logic :='0'
       );
    END COMPONENT;

    COMPONENT Modo_Crono
       PORT (
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
            Start : in std_logic;
            Pause : in std_logic;
            Reset : in std_logic
       );
    END COMPONENT;
    
    COMPONENT Modo_Temp
       PORT (
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
    END COMPONENT;
    
    COMPONENT Ajedrez
       PORT (
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
    END COMPONENT;
    

    COMPONENT Control_anodo
       PORT (
        CLK : in std_logic;
        code1 : in std_logic_vector(3 downto 0);
        code2 : in std_logic_vector(3 downto 0);
        code3 : in std_logic_vector(3 downto 0);
        code4 : in std_logic_vector(3 downto 0);
        code5 : in std_logic_vector(3 downto 0);
        code6 : in std_logic_vector(3 downto 0);
        code7 : in std_logic_vector(3 downto 0);
        code8 : in std_logic_vector(3 downto 0);
        refrescar_anodo : out std_logic_vector(7 downto 0);
        salida_disp : out std_logic_vector(6 downto 0)
       );
    END COMPONENT;      
       
begin

    GestorEntradas1 : GestorEntradas PORT MAP(
        CLK => CLK,
        B_L => B_L,
        B_R => B_R,
        B_U => B_U,
        B_D => B_D,
        B_C => B_C,
        reset => reset,
        B_L_out => B_L_aux,
        B_R_out => B_R_aux,
        B_U_out => B_U_aux,
        B_D_out => B_D_aux,
        B_C_out => B_C_aux,
        reset_out => Reset_aux
    );
    
    MaquinaEstados1 : MaquinaEstados PORT MAP(
        B1=>B_U_aux,
        B2=>B_D_aux,
        B3=>B_R_aux,
        B4=>B_L_aux,
        B5=>B_C_aux,
        code1=>code1,
        code2=>code2,
        code3=>code3,
        code4=>code4,
        code5=>code5,
        code6=>code6,
        code7=>code7,
        code8=>code8,
        Reset=>Reset,
        Enable_A=>Enable_A,
        Enable_B=>Enable_B,
        Enable_C=>Enable_C
    );
    
    Modo_Crono1 : Modo_Crono PORT MAP(
        CLK=>clk,
        code1=>code1,
        code2=>code2,
        code3=>code3,
        code4=>code4,
        code5=>code5,
        code6=>code6,
        code7=>code7,
        code8=>code8,
        Enable_A=>Enable_A,
        Start=>B_C_aux,
        Pause=>B_D_aux,
        Reset=>B_L_aux
    );
    
    Modo_Temp1 : Modo_Temp PORT MAP(
        CLK=>clk,
        code1=>code1,
        code2=>code2,
        code3=>code3,
        code4=>code4,
        code5=>code5,
        code6=>code6,
        code7=>code7,
        code8=>code8,
        Enable_B=>Enable_B,
        led=>led,
        B1=>B_U_aux,
        B2=>B_D_aux,
        B3=>B_R_aux,
        B4=>B_L_aux,
        B5=>B_C_aux
    );
    
    Ajedrez1 : Ajedrez PORT MAP(
        CLK=>clk,
        code1=>code1,
        code2=>code2,
        code3=>code3,
        code4=>code4,
        code5=>code5,
        code6=>code6,
        code7=>code7,
        code8=>code8,
        Enable_C=>Enable_C,
        led=>led,
        B1=>B_U_aux,
        B2=>B_D_aux,
        B3=>B_R_aux,
        B4=>B_L_aux,
        B5=>B_C_aux
    );
    
    
    Control_Anodo1 : Control_anodo PORT MAP(
        CLK=>clk,
        code1=>code1,
        code2=>code2,
        code3=>code3,
        code4=>code4,
        code5=>code5,
        code6=>code6,
        code7=>code7,
        code8=>code8,
        refrescar_anodo=>refrescar_anodo,
        salida_disp=>salida_disp
     );




end Behavioral;

