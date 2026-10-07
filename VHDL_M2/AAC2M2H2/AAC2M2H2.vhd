library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIFO8x9 is
   port(
      clk, rst           : in std_logic;
      RdPtrClr, WrPtrClr : in std_logic;    
      RdInc, WrInc       : in std_logic;
      DataIn             : in std_logic_vector(8 downto 0);
      DataOut            : out std_logic_vector(8 downto 0);
      rden, wren         : in std_logic
   );
end entity FIFO8x9;

architecture RTL of FIFO8x9 is
   -- Memory array: 8 locations of 9 bits each
   type fifo_array is array(7 downto 0) of std_logic_vector(8 downto 0);
   signal fifo : fifo_array := (others => (others => '0'));

   -- 3-bit circular pointers
   signal wrptr, rdptr : unsigned(2 downto 0) := (others => '0');
   signal dmuxout      : std_logic_vector(8 downto 0);

begin

   -- Synchronous control: memory write and pointer updates
   process(clk, rst)
   begin
      if rst = '1' then
         wrptr <= (others => '0');
         rdptr <= (others => '0');
      elsif rising_edge(clk) then
         -- Write pointer logic: Clear takes priority over Increment
         if WrPtrClr = '1' then
            wrptr <= (others => '0');
         elsif WrInc = '1' then
            wrptr <= wrptr + 1;
         end if;

         -- Read pointer logic: Clear takes priority over Increment
         if RdPtrClr = '1' then
            rdptr <= (others => '0');
         elsif RdInc = '1' then
            rdptr <= rdptr + 1;
         end if;

         -- Synchronous write into register array
         if wren = '1' then
            fifo(to_integer(wrptr)) <= DataIn;
         end if;
      end if;
   end process;

   -- Combinational read multiplexer
   dmuxout <= fifo(to_integer(rdptr));

   -- Tri-state output buffer: driven when rden = '1', high impedance ('Z') otherwise
   DataOut <= dmuxout when rden = '1' else (others => 'Z');

end architecture RTL;
