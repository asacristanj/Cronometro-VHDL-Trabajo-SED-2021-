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
        salida_disp : out std_logic_vector(6 downto 0) --salida de los displays
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

    signal code1 : std_logic_vector(3 downto 0);
    signal code2 : std_logic_vector(3 downto 0);
    signal code3 : std_logic_vector(3 downto 0);
    signal code4 : std_logic_vector(3 downto 0);
    signal code5 : std_logic_vector(3 downto 0);
    signal code6 : std_logic_vector(3 downto 0);
    signal code7 : std_logic_vector(3 downto 0);
    signal code8 : std_logic_vector(3 downto 0);

COMPONENT SYNCHRNZR
       PORT (
              async_in : IN std_logic;
              clk: IN std_logic;
              sync_out : OUT std_logic
       );
END COMPONENT;

COMPONENT EDGEDTCTR
       PORT (
              sync_in : IN std_logic;
              clk: IN std_logic;
              edge : OUT std_logic
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
Sincronizador: SYNCHRNZR PORT MAP(
ASYNC_IN=>B_L,
CLK=>clk,
SYNC_OUT=>sync_auxL
);

DetectorFlanco: EDGEDTCTR PORT MAP(
clk=>clk,
SYNC_IN=>sync_auxL,
EDGE=>B_L_aux
);

Sincronizador2: SYNCHRNZR PORT MAP(
ASYNC_IN=>B_R,
CLK=>clk,
SYNC_OUT=>sync_auxR
);

DetectorFlanco2: EDGEDTCTR PORT MAP(
clk=>clk,
SYNC_IN=>sync_auxR,
EDGE=>B_R_aux
);

Sincronizador3: SYNCHRNZR PORT MAP(
ASYNC_IN=>B_U,
CLK=>clk,
SYNC_OUT=>sync_auxU
);

DetectorFlanco3: EDGEDTCTR PORT MAP(
clk=>clk,
SYNC_IN=>sync_auxU,
EDGE=>B_U_aux
);

Sincronizador4: SYNCHRNZR PORT MAP(
ASYNC_IN=>B_D,
CLK=>clk,
SYNC_OUT=>sync_auxD
);

DetectorFlanco4: EDGEDTCTR PORT MAP(
clk=>clk,
SYNC_IN=>sync_auxD,
EDGE=>B_D_aux
);

Sincronizador5: SYNCHRNZR PORT MAP(
ASYNC_IN=>B_C,
CLK=>clk,
SYNC_OUT=>sync_auxC
);

DetectorFlanco5: EDGEDTCTR PORT MAP(
clk=>clk,
SYNC_IN=>sync_auxC,
EDGE=>B_C_aux
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
Enable_A=>'1',
Start=>B_C_aux,
Pause=>B_D_aux,
Reset=>B_L_aux
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

