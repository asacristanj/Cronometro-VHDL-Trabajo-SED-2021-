library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity MaquinaEstados is
    Port ( 
        clk : in std_logic;
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
        Enable_C : out std_logic :='0';
        Enable_S : out std_logic :='1'
    );
end MaquinaEstados;

architecture Behavioral of MaquinaEstados is
 type estados is (as,bs,cs,af,bf,cf);
 signal estadoActual,estadoSiguiente:estados;
    
signal clk_10khz : std_logic;
    COMPONENT clk10khz
       PORT (
              CLK: in  STD_LOGIC;
              clk_1hz : out STD_LOGIC
            );
     END COMPONENT;
    
begin
Inst_clk10khz: clk10khz 
    PORT MAP (
        CLK => CLK,
        CLK_1hz => clk_10khz
    );
    state_reg:process(clk,reset)
    begin
        if reset='1' then 
        estadoActual<=as;
        elsif rising_edge(clk)then
        estadoActual<=estadoSiguiente;
        end if;
    end process;
    
    gestionmaquinaestados:process(estadoActual,B1,B2,B5)
    begin
        estadoSiguiente<=estadoActual;
        case (estadoActual)is     
        when as=>
            if B1='1' then
            estadoSiguiente<=bs;
            elsif B2='1' then
            estadosiguiente<=cs;
            elsif B5='1' then
            estadoSiguiente<=af;
            end if;
        when bs=>
            if B1='1' then
            estadoSiguiente<=cs;
            elsif B2='1' then
            estadosiguiente<=as;
            elsif B5='1' then
            estadoSiguiente<=bf;
            end if;
        when cs=>
            if B1='1' then
            estadoSiguiente<=as;
            elsif B2='1' then
            estadosiguiente<=bs;
            elsif B5='1' then
            estadoSiguiente<=cf;
            end if;
        when others => estadoSiguiente<=estadoActual;
        end case;
  end process;
    
    SalidasSelModo : process (estadoActual)
    begin
        case(estadoActual) is
        when as=>
                code1<="1111";
                code2<="1111";
                code3<="1111";
                code4<="1111";
                code5<="1111";
                code6<="1111";
                code7<="1011";
                code8<="1010";
                Enable_A<='0';
                Enable_B<='0';
                Enable_C<='0';
                Enable_S<='1';
        when bs=>
                code1<="1111";
                code2<="1111";
                code3<="1111";
                code4<="1111";
                code5<="1111";
                code6<="1111";
                code7<="1100";
                code8<="1101";
                Enable_A<='0';
                Enable_B<='0';
                Enable_C<='0';
                Enable_S<='1';
         when cs=>
                code1<="1111";
                code2<="1111";
                code3<="1111";
                code4<="1111";
                code5<="1111";
                code6<="1111";
                code7<="1111";
                code8<="1110";
                Enable_A<='0';
                Enable_B<='0';
                Enable_C<='0';
                Enable_S<='1';
         when af=>
                Enable_A<='1';
                Enable_B<='0';
                Enable_C<='0';
                Enable_S<='0';
         when bf=>
                Enable_A<='0';
                Enable_B<='1';
                Enable_C<='0';
                Enable_S<='0';
         when cf=>
                Enable_A<='0';
                Enable_B<='0';
                Enable_C<='1';
                Enable_S<='0';
        end case;                  
    end process;
    
end Behavioral;
