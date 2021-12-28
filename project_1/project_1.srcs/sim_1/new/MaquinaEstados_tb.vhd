library ieee;
use ieee.std_logic_1164.all;

entity MaquinaEstados_tb is
end MaquinaEstados_tb;

architecture tb of MaquinaEstados_tb is

    component MaquinaEstados
        port (clk      : in std_logic;
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
              Reset    : in std_logic;
              Enable_A : out std_logic;
              Enable_B : out std_logic;
              Enable_C : out std_logic;
              Enable_S : out std_logic);
    end component;

    signal clk      : std_logic;
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
    signal Reset    : std_logic;
    signal Enable_A : std_logic;
    signal Enable_B : std_logic;
    signal Enable_C : std_logic;
    signal Enable_S : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : MaquinaEstados
    port map (clk      => clk,
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
              Reset    => Reset,
              Enable_A => Enable_A,
              Enable_B => Enable_B,
              Enable_C => Enable_C,
              Enable_S => Enable_S);

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
        B5 <= '0';

        -- Reset generation
        -- EDIT: Check that Reset is really your reset signal
        Reset <= '1';
        wait for 100 ns;
        Reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

