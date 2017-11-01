----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Trent Andraka
-- 
-- Create Date: 10/30/2017 01:53:26 PM
-- Design Name: 
-- Module Name: lab3 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab3 is
  Port (clk         : IN STD_LOGIC ;
        reset_l     : IN STD_LOGIC ;
        sw          : IN STD_LOGIC_VECTOR(15 DOWNTO 0) ;
        ld          : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
end lab3;

architecture mealy of lab3 is
    
    --s0 as initial off state, s1 as off state triggered after out of order
    TYPE states IS (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17);
    SIGNAL state: states := s0;
    SIGNAL nxt_state : states := s0;
    SIGNAL reset_l_tmp : STD_LOGIC ;
    SIGNAL reset_l_sync : STD_LOGIC ;
    SIGNAL sw_tmp : STD_LOGIC_VECTOR (15 DOWNTO 0) ;
    SIGNAL sw_sync : STD_LOGIC_VECTOR (15 DOWNTO 0) ;

begin

---process to synchronize the asynchronous reset input
    
    mysync: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk='1') THEN
            reset_l_tmp <= reset_l ;
            reset_l_sync <= reset_l_tmp ;
        END IF;
    END PROCESS mysync;
    
    mysync2: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk='1') THEN
            sw_tmp <= sw ;
            sw_sync <= sw_tmp ;
        END IF;
    END PROCESS mysync2;


-- process to implement the state register
    clkd: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk='1') THEN
            IF (reset_l = '0') THEN
                state <= s0;
            ELSE
                state <= nxt_state;
            END IF;
        END IF;
    END PROCESS clkd;

-- process to determine next state
    state_trans: PROCESS (sw_sync, state)
    BEGIN
        nxt_state <= state ;
        CASE state IS
            WHEN s0 => IF (sw_sync = "0000000000000001") THEN
                            nxt_state <= s2;
                       ELSE
                            nxt_state <= s0;
                       END IF ;
            WHEN s1 => IF (sw_sync = "0000000000000000") THEN
                            nxt_state <= s0;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s2 => IF (sw_sync = "0000000000000011") THEN
                            nxt_state <= s3;
                       ELSIF (sw_sync = "0000000000000001") THEN
                            nxt_state <= s2;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s3 => IF (sw_sync = "0000000000000111") THEN
                            nxt_state <= s4;
                       ELSIF (sw_sync = "0000000000000011") THEN
                            nxt_state <= s3;
					   ELSIF (sw_sync = "0000000000000001") THEN
							nxt_state <= s2;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s4 => IF (sw_sync = "0000000000001111") THEN
                            nxt_state <= s5;
                       ELSIF (sw_sync = "0000000000000111") THEN
                            nxt_state <= s4;
					   ELSIF (sw_sync = "0000000000000011") THEN
							nxt_state <= s3;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s5 => IF (sw_sync = "0000000000011111") THEN
                            nxt_state <= s6;
                       ELSIF (sw_sync = "0000000000001111") THEN
                            nxt_state <= s5;
					   ELSIF (sw_sync = "0000000000000111") THEN
							nxt_state <= s4;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s6 => IF (sw_sync = "0000000000111111") THEN
                            nxt_state <= s7;
                       ELSIF (sw_sync = "0000000000011111") THEN
                            nxt_state <= s6;
					   ELSIF (sw_sync = "0000000000001111") THEN
							nxt_state <= s5;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s7 => IF (sw_sync = "0000000001111111") THEN
                            nxt_state <= s8;
                       ELSIF (sw_sync = "0000000000111111") THEN
                            nxt_state <= s7;
					   ELSIF (sw_sync = "0000000000011111") THEN
							nxt_state <= s6;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s8 => IF (sw_sync = "0000000011111111") THEN
                            nxt_state <= s9;
                       ELSIF (sw_sync = "0000000001111111") THEN
                            nxt_state <= s8;
					   ELSIF (sw_sync = "0000000000111111") THEN
							nxt_state <= s7;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s9 => IF (sw_sync = "0000000111111111") THEN
                            nxt_state <= s10;
                       ELSIF (sw_sync = "0000000011111111") THEN
                            nxt_state <= s9;
				       ELSIF (sw_sync = "0000000001111111") THEN
							nxt_state <= s8;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s10 => IF (sw_sync = "0000001111111111") THEN
                            nxt_state <= s11;
                       ELSIF (sw_sync = "0000000111111111") THEN
                            nxt_state <= s10;
					   ELSIF (sw_sync = "0000000011111111") THEN
							nxt_state <= s9;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s11 => IF (sw_sync = "0000011111111111") THEN
                            nxt_state <= s12;
                       ELSIF (sw_sync = "0000001111111111") THEN
                            nxt_state <= s11;
					   ELSIF (sw_sync = "0000000111111111") THEN
							nxt_state <= s10;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s12 => IF (sw_sync = "0000111111111111") THEN
                            nxt_state <= s13;
                       ELSIF (sw_sync = "0000011111111111") THEN
                            nxt_state <= s12;
					   ELSIF (sw_sync = "0000001111111111") THEN
							nxt_state <= s11;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s13 => IF (sw_sync = "0001111111111111") THEN
                            nxt_state <= s14;
                       ELSIF (sw_sync = "0000111111111111") THEN
                            nxt_state <= s13;
					   ELSIF (sw_sync = "0000011111111111") THEN
							nxt_state <= s12;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s14 => IF (sw_sync = "0011111111111111") THEN
                            nxt_state <= s15;
                       ELSIF (sw_sync = "0001111111111111") THEN
                            nxt_state <= s14;
					   ELSIF (sw_sync = "0000111111111111") THEN
							nxt_state <= s13;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s15 => IF (sw_sync = "0111111111111111") THEN
                            nxt_state <= s16;
                       ELSIF (sw_sync = "0011111111111111") THEN
                            nxt_state <= s15;
					   ELSIF (sw_sync = "0001111111111111") THEN
							nxt_state <= s14;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s16 => IF (sw_sync = "1111111111111111") THEN
                            nxt_state <= s17;
                       ELSIF (sw_sync = "0111111111111111") THEN
                            nxt_state <= s16;
					   ELSIF (sw_sync = "0011111111111111") THEN
							nxt_state <= s15;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            WHEN s17 => IF (sw_sync = "1111111111111111") THEN
                            nxt_state <= s17;
					   ELSIF (sw_sync = "0111111111111111") THEN
							nxt_state <= s16;
                       ELSE
                            nxt_state <= s1;
                       END IF ;
            END CASE;
    END PROCESS state_trans;
 
 --- process to define the output values
    output: PROCESS (sw_sync, state)
    BEGIN
        CASE state IS
            WHEN s0 => ld <= "0000000000000000";
            WHEN s1 => ld <= "0000000000000000";
            WHEN s2 => IF (sw_sync = "0000000000000001") THEN
                            ld <= "0000000000000001" ;
                       ELSE
                            ld <= "0000000000000000" ;
                       END IF ;
            WHEN s3 => IF (sw_sync = "0000000000000011") THEN
                            ld <= "0000000000000011" ;
                       ELSE
                            ld <= "0000000000000000" ;
                       END IF ;
            WHEN s4 => IF (sw_sync = "0000000000000111") THEN
                            ld <= "0000000000000111" ;
                       ELSE
                            ld <= "0000000000000000" ;
                       END IF ;
            WHEN s5 => IF (sw_sync = "0000000000001111") THEN
                            ld <= "0000000000001111" ;
                       ELSE
                            ld <= "0000000000000000" ;
                       END IF ;
             WHEN s6 => IF (sw_sync = "0000000000011111") THEN
                            ld <= "0000000000011111" ;
                        ELSE
                            ld <= "0000000000000000" ;
                        END IF ;
             WHEN s7 => IF (sw_sync = "0000000000111111") THEN
                            ld <= "0000000000111111" ;
                        ELSE
                            ld <= "0000000000000000" ;
                        END IF ;
             WHEN s8 => IF (sw_sync = "0000000001111111") THEN
                            ld <= "0000000001111111" ;
                        ELSE
                            ld <= "0000000000000000" ;
                        END IF ;
             WHEN s9 => IF (sw_sync = "0000000011111111") THEN
                            ld <= "0000000011111111" ;
                        ELSE
                            ld <= "0000000000000000" ;
                        END IF ;
             WHEN s10 => IF (sw_sync = "0000000111111111") THEN
                            ld <= "0000000111111111" ;
                        ELSE
                            ld <= "0000000000000000" ;
                        END IF ;
             WHEN s11 => IF (sw_sync = "0000001111111111") THEN
                            ld <= "0000001111111111" ;
                        ELSE
                            ld <= "0000000000000000" ;
                        END IF ;
             WHEN s12 => IF (sw_sync = "0000011111111111") THEN
                            ld <= "0000011111111111" ;
                        ELSE
                            ld <= "0000000000000000" ;
                        END IF ;
             WHEN s13 => IF (sw_sync = "0000111111111111") THEN
                            ld <= "0000111111111111" ;
                        ELSE
                            ld <= "0000000000000000" ;
                        END IF ;
             WHEN s14 => IF (sw_sync = "0001111111111111") THEN
                            ld <= "0001111111111111" ;
                        ELSE
                            ld <= "0000000000000000" ;
                         END IF ;
             WHEN s15 => IF (sw_sync = "0011111111111111") THEN
                            ld <= "0011111111111111" ;
                         ELSE
                            ld <= "0000000000000000" ;
                         END IF ;
             WHEN s16 => IF (sw_sync = "0111111111111111") THEN
                            ld <= "0111111111111111" ;
                         ELSE
                            ld <= "0000000000000000" ;
                         END IF ;
             WHEN s17 => IF (sw_sync = "1111111111111111") THEN
                            ld <= "1111111111111111" ;
                         ELSE
                            ld <= "0000000000000000" ;
                         END IF ;
            
        END CASE ;
    END PROCESS output ;
    
end mealy;
