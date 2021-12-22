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

    signal Enable_sel : std_logic:='0';
    signal Enable_count : std_logic:='0';
    signal unit_sec_aux : integer :=0;
    signal dec_sec_aux : integer :=0;
    signal unit_min_aux : integer :=0;
    signal dec_min_aux : integer :=0;
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
        unit_sec : out integer;
        dec_sec : out integer;
        unit_min : out integer;
        dec_min : out integer
       );
    END COMPONENT;
    
    COMPONENT Cuenta_atras
       PORT (
        CLK : in std_logic;
        Enable_count : in std_logic;
        Reset : in std_logic;
        code1_in : in integer;
        code2_in : in integer;
        code3_in : in integer;
        code4_in : in integer;
        code1_out : out std_logic_vector(3 downto 0);--unidades de segundo
        code2_out : out std_logic_vector(3 downto 0);--decenas de segundo
        code3_out : out std_logic_vector(3 downto 0);--unidades de minuto
        code4_out : out std_logic_vector(3 downto 0);--decenas de minuto
        led : out std_logic
       );
    END COMPONENT;
    
    COMPONENT Mux_Temp
       PORT (
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
        unit_sec=>unit_sec_aux,
        dec_sec=>dec_sec_aux,
        unit_min=>unit_min_aux,
        dec_min=>dec_min_aux
    );


    Cuenta_atras1 : Cuenta_atras PORT MAP(
        CLK => CLK,
        Enable_count => Enable_count,
        Reset => Reset_aux,
        code1_in => unit_sec_aux,
        code2_in => dec_sec_aux,
        code3_in =>unit_min_aux,
        code4_in => dec_min_aux,
        code1_out => code1_Count,--unidades de segundo
        code2_out => code2_Count,--decenas de segundo
        code3_out => code3_Count,--unidades de minuto
        code4_out => code4_Count,--decenas de minuto
        led => led
    );
    
    Mux_Temp1 : Mux_Temp PORT MAP(
        Enable_Sel=>Enable_B,
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
        code4=>code4
    );

    modoTemp : process
    begin
        if Enable_B='1' then
            code8<="1100";
            code7<="1101";
            code6<="1111";
            code5<="1111";
        end if;
    end process;

    SeleccionandoCuenta : process(Enable_sel)
    begin
        if Enable_sel='1' then
            code1_Sel<=std_logic_vector(to_unsigned(unit_sec_aux,code1'length));
            code2_Sel<=std_logic_vector(to_unsigned(dec_sec_aux,code1'length));
            code3_Sel<=std_logic_vector(to_unsigned(unit_min_aux,code1'length));
            code4_Sel<=std_logic_vector(to_unsigned(dec_min_aux,code1'length));
        end if;
    end process;
    
    
    
    
    
maquinaestados : process (B5, Enable_B, B2, B4) --Cambia  entre el modo seleccionar cuenta y el de contar 
begin
    if Enable_B='0' then --modo temporizador desconectado
        Reset_aux<='1';
        Enable_sel<='0';
        Enable_count<='0';
    else --modo temporizador conectado
        if Enable_B='1' and Enable_sel='0' and Enable_count='0' then --Si no está ni modosel ni modo cuenta, y si está activdo el modotemp, entra en modo sel
            Enable_sel<='1';
        end if;
        if Enable_B='1' and Enable_sel='1' and B5='1' then--si está en modo sel y se pulsa el start(b5) esq ya se ha seleccioando y se desea contar
            Enable_sel<='0';                              --por lo q se desactiva modo sel y se activa el count para empezar a contar
            Enable_count<='1';
            Reset_aux<='0';
        elsif Enable_B='1' and Enable_sel='0' and Enable_count='1' and B2='1' then--si está contando y nop está en modo sel y se pulsa pausa(B2) se para
            Enable_count<='0';
            Reset_aux<='0';
        elsif Enable_B='1' and Enable_sel='0'and B5='1' then --se retoma la cuenta en cso de q estuviera pusado
            Enable_count<='1';
            Reset_aux<='0';
        elsif Enable_B='1' and Enable_sel='0' and B4='1' then
            Reset_aux<='1';
        end if;
    end if;
    
end process;

end Behavioral;
