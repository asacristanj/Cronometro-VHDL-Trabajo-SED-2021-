library ieee;
use ieee.std_logic_1164.all;

entity TOP_tb is
end TOP_tb;

architecture tb of TOP_tb is

    component TOP
        port (CLK             : in std_logic;
              B_L             : in std_logic;
              B_R             : in std_logic;
              B_U             : in std_logic;
              B_D             : in std_logic;
              B_C             : in std_logic;
              reset           : in std_logic;
              refrescar_anodo : out std_logic_vector (7 downto 0);
              salida_disp     : out std_logic_vector (6 downto 0);
              led             : out std_logic);
    end component;

    signal CLK             : std_logic;
    signal B_L             : std_logic;
    signal B_R             : std_logic;
    signal B_U             : std_logic;
    signal B_D             : std_logic;
    signal B_C             : std_logic;
    signal reset           : std_logic;
    signal refrescar_anodo : std_logic_vector (7 downto 0);
    signal salida_disp     : std_logic_vector (6 downto 0);
    signal led             : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : TOP
    port map (CLK             => CLK,
              B_L             => B_L,
              B_R             => B_R,
              B_U             => B_U,
              B_D             => B_D,
              B_C             => B_C,
              reset           => reset,
              refrescar_anodo => refrescar_anodo,
              salida_disp     => salida_disp,
              led             => led);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        B_L <= '0';
        B_R <= '0';
        B_U <= '0';
        B_D <= '0';
        B_C <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        B_U <= '1';
        wait for 100 ns;
        B_U <= '0';
        wait for 100 ns;
        B_U <= '1';
        wait for 100 ns;
        B_U <= '0';
        wait for 100 ns;
        B_D <= '1';
        wait for 100 ns;
        B_D <= '0';
        wait for 100 ns;
        B_D <= '1';
        wait for 100 ns;
        B_D <= '0';
        wait for 100 ns;
        B_C <= '1';
        wait for 100 ns;
        B_C <= '0';
        wait for 100 ns;
        Reset <= '1';
        wait for 100 ns;
        Reset <= '0';
        wait for 100 ns;
        B_U <= '1';
        wait for 100 ns;
        B_U <= '0';
        wait for 100 ns;
        B_C<='1';
        wait for 100 ns;
        B_C<='0';
        wait for 100 ns;
        Reset <= '1';
        wait for 100 ns;
        Reset <= '0';
        wait for 1000 ns;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;