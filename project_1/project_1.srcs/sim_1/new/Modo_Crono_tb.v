library ieee;
use ieee.std_logic_1164.all;

entity tb_Modo_Crono is
end tb_Modo_Crono;

architecture tb of tb_Modo_Crono is

    component Modo_Crono
        port (CLK      : in std_logic;
              code1    : out std_logic_vector (3 downto 0);
              code2    : out std_logic_vector (3 downto 0);
              code3    : out std_logic_vector (3 downto 0);
              code4    : out std_logic_vector (3 downto 0);
              code5    : out std_logic_vector (3 downto 0);
              code6    : out std_logic_vector (3 downto 0);
              code7    : out std_logic_vector (3 downto 0);
              code8    : out std_logic_vector (3 downto 0);
              Enable_A : in std_logic;
              Start    : in std_logic;
              Pause    : in std_logic;
              Reset    : in std_logic);
    end component;

    signal CLK      : std_logic;
    signal code1    : std_logic_vector (3 downto 0);
    signal code2    : std_logic_vector (3 downto 0);
    signal code3    : std_logic_vector (3 downto 0);
    signal code4    : std_logic_vector (3 downto 0);
    signal code5    : std_logic_vector (3 downto 0);
    signal code6    : std_logic_vector (3 downto 0);
    signal code7    : std_logic_vector (3 downto 0);
    signal code8    : std_logic_vector (3 downto 0);
    signal Enable_A : std_logic;
    signal Start    : std_logic;
    signal Pause    : std_logic;
    signal Reset    : std_logic;

    constant TbPeriod : time := 1000 ns; //EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Modo_Crono
    port map (CLK      => CLK,
              code1    => code1,
              code2    => code2,
              code3    => code3,
              code4    => code4,
              code5    => code5,
              code6    => code6,
              code7    => code7,
              code8    => code8,
              Enable_A => Enable_A,
              Start    => Start,
              Pause    => Pause,
              Reset    => Reset);

    //Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    // EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        // EDIT Adapt initialization as needed
        Enable_A <= '0';
        Start <= '0';
        Pause <= '0';

        // Reset generation
        // EDIT: Check that Reset is really your reset signal
        Reset <= '1';
        wait for 100 ns;
        Reset <= '0';
        wait for 100 ns;

        // EDIT Add stimuli here
        wait for 100 * TbPeriod;

        // Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

// Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Modo_Crono of tb_Modo_Crono is
    for tb
    end for;
end cfg_tb_Modo_Crono;