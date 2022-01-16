library ieee;
use ieee.std_logic_1164.all;

entity Modo_Temp_tb is
end Modo_Temp_tb;

architecture tb of Modo_Temp_tb is

    component Modo_Temp
        port (CLK      : in std_logic;
              B1       : in std_logic;
              B2       : in std_logic;
              B3       : in std_logic;
              B4       : in std_logic;
              B5       : in std_logic;
              code1    : out std_logic_vector (3 downto 0);
              code2    : out std_logic_vector (3 downto 0);
              code3    : out std_logic_vector (3 downto 0);
              code4    : out std_logic_vector (3 downto 0);
              code5    : out std_logic_vector (3 downto 0);
              code6    : out std_logic_vector (3 downto 0);
              code7    : out std_logic_vector (3 downto 0);
              code8    : out std_logic_vector (3 downto 0);
              Enable_B : in std_logic;
              led      : out std_logic);
    end component;

    signal CLK      : std_logic;
    signal B1       : std_logic;
    signal B2       : std_logic;
    signal B3       : std_logic;
    signal B4       : std_logic;
    signal B5       : std_logic;
    signal code1    : std_logic_vector (3 downto 0);
    signal code2    : std_logic_vector (3 downto 0);
    signal code3    : std_logic_vector (3 downto 0);
    signal code4    : std_logic_vector (3 downto 0);
    signal code5    : std_logic_vector (3 downto 0);
    signal code6    : std_logic_vector (3 downto 0);
    signal code7    : std_logic_vector (3 downto 0);
    signal code8    : std_logic_vector (3 downto 0);
    signal Enable_B : std_logic;
    signal led      : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Modo_Temp
    port map (CLK      => CLK,
              B1       => B1,
              B2       => B2,
              B3       => B3,
              B4       => B4,
              B5       => B5,
              code1    => code1,
              code2    => code2,
              code3    => code3,
              code4    => code4,
              code5    => code5,
              code6    => code6,
              code7    => code7,
              code8    => code8,
              Enable_B => Enable_B,
              led      => led);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        B1 <= '0';
        B2 <= '0';
        B3 <= '0';
        B4 <= '0';
        B5 <= '0';
        Enable_B <= '0';

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        --YOURRESETSIGNAL <= '1';
        --wait for 100 ns;
        --YOURRESETSIGNAL <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        Enable_B<='1';
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
        B5<='1';
        wait for 100 ns;
        B5<='0';
        wait for 300 ns;
        B2<='1';
        wait for 100 ns;
        B2<='0';
        wait for 100 ns;
        B5<='1';
        wait for 100 ns;
        B5<='0';
        wait for 100 ns;
        B4<='1';
        wait for 100 ns;
        B4<='0';
        wait for 100 ns;
        B5<='1';
        wait for 100 ns;
        B5<='0';
        wait for 2000 ns;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;