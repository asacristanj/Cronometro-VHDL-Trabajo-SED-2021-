library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Control_Anodo is
    port(
        CLK : in std_logic;
        code1 : out std_logic_vector(3 downto 0);
        code2 : out std_logic_vector(3 downto 0);
        code3 : out std_logic_vector(3 downto 0);
        code4 : out std_logic_vector(3 downto 0);
        code5 : out std_logic_vector(3 downto 0);
        code6 : out std_logic_vector(3 downto 0);
        code7 : out std_logic_vector(3 downto 0);
        code8 : out std_logic_vector(3 downto 0);
        refrescar_anodo : out std_logic_vector(7 downto 0); --vector que pone a 1 el ánodo correspondiente para actualizar
        salida_disp : out std_logic_vector(6 downto 0) --salida de los displays
    );
end Control_Anodo;

architecture Behavioral of Control_Anodo is
    
    signal disp1 : std_logic_vector(6 downto 0);
    signal disp2 : std_logic_vector(6 downto 0);
    signal disp3 : std_logic_vector(6 downto 0);
    signal disp4 : std_logic_vector(6 downto 0);
    signal disp5 : std_logic_vector(6 downto 0);
    signal disp6 : std_logic_vector(6 downto 0);
    signal disp7 : std_logic_vector(6 downto 0);
    signal disp8 : std_logic_vector(6 downto 0);
    
    
    signal flag : integer := 1;
    
    COMPONENT deco1
       PORT (
              code : IN std_logic_vector(3 DOWNTO 0);
              led : OUT std_logic_vector(6 DOWNTO 0)
       );
   END COMPONENT;
   
   COMPONENT deco2
       PORT (
              code : IN std_logic_vector(3 DOWNTO 0);
              led : OUT std_logic_vector(6 DOWNTO 0)
       );
   END COMPONENT;
   
   COMPONENT deco3
       PORT (
              code : IN std_logic_vector(3 DOWNTO 0);
              led : OUT std_logic_vector(6 DOWNTO 0)
       );
   END COMPONENT;
   
   COMPONENT deco4
       PORT (
              code : IN std_logic_vector(3 DOWNTO 0);
              led : OUT std_logic_vector(6 DOWNTO 0)
       );
   END COMPONENT;
   
   COMPONENT deco5
       PORT (
              code : IN std_logic_vector(3 DOWNTO 0);
              led : OUT std_logic_vector(6 DOWNTO 0)
       );
   END COMPONENT;
   
   COMPONENT deco6
       PORT (
              code : IN std_logic_vector(3 DOWNTO 0);
              led : OUT std_logic_vector(6 DOWNTO 0)
       );
   END COMPONENT;
   
   COMPONENT deco7
       PORT (
              code : IN std_logic_vector(3 DOWNTO 0);
              led : OUT std_logic_vector(6 DOWNTO 0)
       );
   END COMPONENT;
   
   COMPONENT deco8
       PORT (
              code : IN std_logic_vector(3 DOWNTO 0);
              led : OUT std_logic_vector(6 DOWNTO 0)
       );
   END COMPONENT;
   
begin


Inst_deco1: deco1 PORT MAP (
        code => code1,
        led => disp1
);
Inst_deco2: deco2 PORT MAP (
        code => code2,
        led => disp2
);
Inst_deco3: deco2 PORT MAP (
        code => code3,
        led => disp3
);
Inst_deco4: deco2 PORT MAP (
        code => code4,
        led => disp4
);
Inst_deco5: deco2 PORT MAP (
        code => code5,
        led => disp5
);
Inst_deco6: deco2 PORT MAP (
        code => code6,
        led => disp6
);
Inst_deco7: deco2 PORT MAP (
        code => code7,
        led => disp7
);
Inst_deco8: deco2 PORT MAP (
        code => code8,
        led => disp8
);


    process (CLK)
    begin
        if rising_edge(CLK) then
            if flag=1 then
                refrescar_anodo(0) <=  '1';
                refrescar_anodo(7 downto 1) <=  "0000000";
                salida_disp <= disp1;
                flag<=2;
            end if;
            if flag=2 then
                refrescar_anodo(1) <=  '1';
                refrescar_anodo(0) <=  '0';
                refrescar_anodo(7 downto 2) <=  "000000";
                salida_disp <= disp2;
                flag<=3;
            end if;
            if flag=3 then
                refrescar_anodo(2) <=  '1';
                refrescar_anodo(1 downto 0) <=  "00";
                refrescar_anodo(7 downto 3) <=  "00000";
                salida_disp <= disp3;
                flag<=4;
            end if;
            if flag=4 then
                refrescar_anodo(3) <=  '1';
                refrescar_anodo(2 downto 0) <=  "000";
                refrescar_anodo(7 downto 4) <=  "0000";
                salida_disp <= disp4;
                flag<=5;
            end if;
            if flag=5 then
                refrescar_anodo(4) <=  '1';
                refrescar_anodo(7 downto 5) <=  "000";
                salida_disp <= disp5;
                flag<=6;
            end if;
            if flag=6 then
                refrescar_anodo(5) <=  '1';
                refrescar_anodo(4 downto 0) <=  "00000";
                refrescar_anodo(7 downto 6) <=  "00";
                salida_disp <= disp6;
                flag<=7;
            end if;
            if flag=7 then
                refrescar_anodo(6) <=  '1';
                refrescar_anodo(5 downto 0) <=  "000000";
                refrescar_anodo(7) <=  '0';
                salida_disp <= disp7;
                flag<=8;
            end if;
            if flag=8 then
                refrescar_anodo(7) <=  '1';
                refrescar_anodo(6 downto 0) <=  "0000000";
                salida_disp <= disp8;
                flag<=1;
            end if;
        end if;

    end process;

end Behavioral;