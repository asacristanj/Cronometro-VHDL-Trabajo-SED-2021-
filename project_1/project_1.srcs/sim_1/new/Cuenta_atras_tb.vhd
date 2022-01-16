library ieee;
use ieee.std_logic_1164.all;

entity Cuenta_atras_tb is
end Cuenta_atras_tb;

architecture tb of Cuenta_atras_tb is

    component Cuenta_atras
        port (CLK          : in std_logic;
              Enable_count : in std_logic;
              Reset        : in std_logic;
              code1_in     : in std_logic_vector (3 downto 0);
              code2_in     : in std_logic_vector (3 downto 0);
              code3_in     : in std_logic_vector (3 downto 0);
              code4_in     : in std_logic_vector (3 downto 0);
              code1_out    : out std_logic_vector (3 downto 0);
              code2_out    : out std_logic_vector (3 downto 0);
              code3_out    : out std_logic_vector (3 downto 0);
              code4_out    : out std_logic_vector (3 downto 0);
              led          : out std_logic);
    end component;

    signal CLK          : std_logic;
    signal Enable_count : std_logic;
    signal Reset        : std_logic;
    signal code1_in     : std_logic_vector (3 downto 0);
    signal code2_in     : std_logic_vector (3 downto 0);
    signal code3_in     : std_logic_vector (3 downto 0);
    signal code4_in     : std_logic_vector (3 downto 0);
    signal code1_out    : std_logic_vector (3 downto 0);
    signal code2_out    : std_logic_vector (3 downto 0);
    signal code3_out    : std_logic_vector (3 downto 0);
    signal code4_out    : std_logic_vector (3 downto 0);
    signal led          : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Cuenta_atras
    port map (CLK          => CLK,
              Enable_count => Enable_count,
              Reset        => Reset,
              code1_in     => code1_in,
              code2_in     => code2_in,
              code3_in     => code3_in,
              code4_in     => code4_in,
              code1_out    => code1_out,
              code2_out    => code2_out,
              code3_out    => code3_out,
              code4_out    => code4_out,
              led          => led);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Enable_count <= '0';
        code1_in <= "0001";
        code2_in <= "0001";
        code3_in <= "0001";
        code4_in <= "0001";

        -- Reset generation
        -- EDIT: Check that Reset is really your reset signal
        Reset <= '1';
        wait for 100 ns;
        Reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        Enable_count <= '1';
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;