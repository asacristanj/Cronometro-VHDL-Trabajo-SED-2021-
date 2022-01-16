library ieee;
use ieee.std_logic_1164.all;

entity Sel_Cuenta_tb is
end Sel_Cuenta_tb;

architecture tb of Sel_Cuenta_tb is

    component Sel_Cuenta
        port (clk       : in std_logic;
              B1        : in std_logic;
              B2        : in std_logic;
              B3        : in std_logic;
              B4        : in std_logic;
              Enable    : in std_logic;
              code1_Sel : out std_logic_vector (3 downto 0);
              code2_Sel : out std_logic_vector (3 downto 0);
              code3_Sel : out std_logic_vector (3 downto 0);
              code4_Sel : out std_logic_vector (3 downto 0));
    end component;

    signal clk       : std_logic;
    signal B1        : std_logic;
    signal B2        : std_logic;
    signal B3        : std_logic;
    signal B4        : std_logic;
    signal Enable    : std_logic;
    signal code1_Sel : std_logic_vector (3 downto 0);
    signal code2_Sel : std_logic_vector (3 downto 0);
    signal code3_Sel : std_logic_vector (3 downto 0);
    signal code4_Sel : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Sel_Cuenta
    port map (clk       => clk,
              B1        => B1,
              B2        => B2,
              B3        => B3,
              B4        => B4,
              Enable    => Enable,
              code1_Sel => code1_Sel,
              code2_Sel => code2_Sel,
              code3_Sel => code3_Sel,
              code4_Sel => code4_Sel);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        B1 <= '0';
        B2 <= '0';
        B3 <= '0';
        B4 <= '0';
        Enable <= '0';

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        --YOURRESETSIGNAL <= '1';
        --wait for 100 ns;
        --YOURRESETSIGNAL <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
         Enable<='1';
        wait for 100 ns;
        B1<='1';
        wait for 100 ns;
        B1<='0';
        wait for 100 ns;
        B2<='1';
        wait for 100 ns;
        B2<='0';
        wait for 100 ns;
        B3<='1';
        wait for 100 ns;
        B3<='0';
        wait for 100 ns;
        B4<='1';
        wait for 100 ns;
        B4<='0';        
        wait for 100 ns;
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
