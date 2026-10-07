library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port (In1: in std_logic;
   RST: in std_logic;
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

architecture behavioral of FSM is
   type state_type is (A, B, C);
   signal state, next_state : state_type := A;
begin

   -- State register (RST is active high, asynchronous)
   process (CLK, RST)
   begin
      if RST = '1' then
         state <= A;
      elsif rising_edge(CLK) then
         state <= next_state;
      end if;
   end process;

   -- Next-state logic
   process (state, In1)
   begin
      case state is
         when A =>
            if In1 = '1' then
               next_state <= B;
            else
               next_state <= A;
            end if;
         when B =>
            if In1 = '0' then
               next_state <= C;
            else
               next_state <= B;
            end if;
         when C =>
            if In1 = '1' then
               next_state <= A;
            else
               next_state <= C;
            end if;
      end case;
   end process;

   -- Moore output: depends only on the current state
   Out1 <= '1' when state = C else '0';

end behavioral;
