LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY Wk3_7segment_decoder IS
	PORT (
		SW : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		LEDR : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END ENTITY;

ARCHITECTURE top_arch OF Wk3_7segment_decoder IS
BEGIN
	LEDR <= SW;
	decoder : PROCESS (SW)
	BEGIN
		CASE sw IS
			WHEN "0000" => HEX0 <= "1000000";
			WHEN "0001" => HEX0 <= "1111001";
			WHEN "0010" => HEX0 <= "0100100";
			WHEN "0011" => HEX0 <= "0110000";

			WHEN "0100" => HEX0 <= "0011001";
			WHEN "0101" => HEX0 <= "0010010";
			WHEN "0110" => HEX0 <= "0000010";
			WHEN "0111" => HEX0 <= "1111000";

			WHEN "1000" => HEX0 <= "0000000";
			WHEN "1001" => HEX0 <= "0010000";
			WHEN "1010" => HEX0 <= "0001000";
			WHEN "1011" => HEX0 <= "0000011";

			WHEN "1100" => HEX0 <= "0100111";
			WHEN "1101" => HEX0 <= "0100001";
			WHEN "1110" => HEX0 <= "0000110";
			WHEN "1111" => HEX0 <= "0001110";

			WHEN OTHERS => HEX0 <= "0000000";
		END CASE;
	END PROCESS decoder;
END top_arch;