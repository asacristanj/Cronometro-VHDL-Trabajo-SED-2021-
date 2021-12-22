library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sel_Cuenta is
    Port ( 
        clk : in std_logic;
        B1 : in std_logic;
        B2 : in std_logic;
        B3 : in std_logic;
        B4 : in std_logic;
        Enable : in std_logic;
        unit_sec : out integer:=0;
        dec_sec : out integer:=0;
        unit_min : out integer:=0;
        dec_min : out integer:=0
        
        
    );
end Sel_Cuenta;

architecture Behavioral of Sel_Cuenta is
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
process(B1,B2,B3,B4,Enable)
    subtype V is integer range 0 to 15;
    variable unit_sec_aux : V :=0;
    variable unit_min_aux : V :=0;
    variable dec_sec_aux : V :=0;
    variable dec_min_aux : V :=0;
    
begin

    if Enable = '0' then
        unit_sec_aux:=0;
        unit_min_aux:=0;
        dec_sec_aux:=0;
        dec_min_aux:=0;
    elsif rising_edge(clk_10khz) then
        if B1='1' then
            unit_sec_aux:=unit_sec_aux+1;
            if unit_sec_aux=10 then
                unit_sec_aux:=0;
            end if;
        end if;
        if B2='1' then
            dec_sec_aux:=dec_sec_aux+1;
            if dec_sec_aux=6 then
                dec_sec_aux:=0;
            end if;
        end if;
        if B3='1' then
            unit_min_aux:=unit_min_aux+1;
            if unit_min_aux=10 then
                unit_min_aux:=0;
            end if;
        end if;
        if B4='1' then
            dec_min_aux:=dec_min_aux+1;
            if dec_min_aux=6 then
                dec_min_aux:=0;
            end if;
        end if;
    
    end if;
    
    unit_sec<=unit_sec_aux;
    dec_sec<=dec_sec_aux;
    unit_min<=unit_min_aux;
    dec_min<=dec_min_aux;
    
end process;


    
end Behavioral;
