LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (
   CP:  in std_logic;                      -- clock
   SR:  in std_logic;                      -- Active low, synchronous reset
   P:   in std_logic_vector(3 downto 0);   -- Parallel input
   PE:  in std_logic;                      -- Parallel Enable (Load), active low
   CEP: in std_logic;                      -- Count enable parallel input
   CET: in std_logic;                      -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);
   TC:  out std_logic                      -- Terminal Count
);
end AAC2M2P1;

architecture behavioral of AAC2M2P1 is
   signal count : unsigned(3 downto 0) := (others => '0');
begin

   -- 74LS163: fully synchronous counter
   -- Priority: synchronous clear > synchronous load > count > hold
   process (CP)
   begin
      if rising_edge(CP) then
         if SR = '0' then
            count <= (others => '0');
         elsif PE = '0' then
            count <= unsigned(P);
         elsif (CEP = '1') and (CET = '1') then
            count <= count + 1;       -- wraps 15 -> 0
         end if;
         -- otherwise hold
      end if;
   end process;

   Q  <= std_logic_vector(count);

   -- Terminal count: high when count = 15 and CET is high
   TC <= '1' when (count = "1111") and (CET = '1') else '0';

end behavioral;