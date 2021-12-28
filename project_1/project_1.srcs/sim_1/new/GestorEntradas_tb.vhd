library ieee;
use ieee.std_logic_1164.all;

entity GestorEntradas_tb is
end GestorEntradas_tb;

architecture tb of GestorEntradas_tb is

    component GestorEntradas
        port (CLK       : in std_logic;
              B_L       : in std_logic;
              B_R       : in std_logic;
              B_U       : in std_logic;
              B_D       : in std_logic;
              B_C       : in std_logic;
              reset     : in std_logic;
              B_L_out   : out std_logic;
              B_R_out   : out std_logic;
              B_U_out   : out std_logic;
              B_D_out   : out std_logic;
              B_C_out   : out std_logic;
              reset_out : out std_logic);
    end component;

    signal CLK       : std_logic;
    signal B_L       : std_logic;
    signal B_R       : std_logic;
    signal B_U       : std_logic;
    signal B_D       : std_logic;
    signal B_C       : std_logic;
    signal reset     : std_logic;
    signal B_L_out   : std_logic;
    signal B_R_out   : std_logic;
    signal B_U_out   : std_logic;
    signal B_D_out   : std_logic;
    signal B_C_out   : std_logic;
    signal reset_out : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : GestorEntradas
    port map (CLK       => CLK,
              B_L       => B_L,
              B_R       => B_R,
              B_U       => B_U,
              B_D       => B_D,
              B_C       => B_C,
              reset     => reset,
              B_L_out   => B_L_out,
              B_R_out   => B_R_out,
              B_U_out   => B_U_out,
              B_D_out   => B_D_out,
              B_C_out   => B_C_out,
              reset_out => reset_out);

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
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;