library ieee;
use ieee.std_logic_1164.all;

entity Control_Anodo_tb is
end Control_Anodo_tb;

architecture tb of Control_Anodo_tb is

    component Control_Anodo
        port (CLK             : in std_logic;
              code1           : in std_logic_vector (3 downto 0);
              code2           : in std_logic_vector (3 downto 0);
              code3           : in std_logic_vector (3 downto 0);
              code4           : in std_logic_vector (3 downto 0);
              code5           : in std_logic_vector (3 downto 0);
              code6           : in std_logic_vector (3 downto 0);
              code7           : in std_logic_vector (3 downto 0);
              code8           : in std_logic_vector (3 downto 0);
              refrescar_anodo : out std_logic_vector (7 downto 0);
              salida_disp     : out std_logic_vector (6 downto 0));
    end component;

    signal CLK             : std_logic;
    signal code1           : std_logic_vector (3 downto 0);
    signal code2           : std_logic_vector (3 downto 0);
    signal code3           : std_logic_vector (3 downto 0);
    signal code4           : std_logic_vector (3 downto 0);
    signal code5           : std_logic_vector (3 downto 0);
    signal code6           : std_logic_vector (3 downto 0);
    signal code7           : std_logic_vector (3 downto 0);
    signal code8           : std_logic_vector (3 downto 0);
    signal refrescar_anodo : std_logic_vector (7 downto 0);
    signal salida_disp     : std_logic_vector (6 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Control_Anodo
    port map (CLK             => CLK,
              code1           => code1,
              code2           => code2,
              code3           => code3,
              code4           => code4,
              code5           => code5,
              code6           => code6,
              code7           => code7,
              code8           => code8,
              refrescar_anodo => refrescar_anodo,
              salida_disp     => salida_disp);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        code1 <= (others => '0');
        code2 <= (others => '0');
        code3 <= (others => '0');
        code4 <= (others => '0');
        code5 <= (others => '0');
        code6 <= (others => '0');
        code7 <= (others => '0');
        code8 <= (others => '0');

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        --YOURRESETSIGNAL <= '1';
        wait for 100 ns;
        --YOURRESETSIGNAL <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
