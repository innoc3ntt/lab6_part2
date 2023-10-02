LIBRARY ieee;
USE ieee.std_logic_1164.all;
-- RAM module
-- inputs: 
--    Clock
--    Address
--    Write: asserted to perform a write
--    DataIn: data to be written
--
-- outputs:
--    DataOut: data read
ENTITY Part2 IS 
   PORT ( Clock, Write : IN  STD_LOGIC;
          DataIn       : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
          Address      : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
			 HEX0, HEX2, HEX4, HEX5 	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
          DataOut     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END Part2;

ARCHITECTURE Behavior OF Part2 IS
	ATTRIBUTE chip_pin : STRING;
	ATTRIBUTE chip_pin of DataIn : SIGNAL is "C12,D12,C11,C10"; --SW3-0
	ATTRIBUTE chip_pin of Address : SIGNAL is "B14,A14,A13,B12,A12"; --SW8-4
	ATTRIBUTE chip_pin of Clock : SIGNAL is "B8"; --KEY0
	ATTRIBUTE chip_pin of Write : SIGNAL is "F15"; --SW9
	
	ATTRIBUTE chip_pin of HEX0 : SIGNAL is "C14,E15,C15,C16,E16,D17,C17";
	ATTRIBUTE chip_pin of HEX2 : SIGNAL is "B20,A20,B19,A21,B21,C22,B22";
	ATTRIBUTE chip_pin of HEX4 : SIGNAL is "F18,E20,E19,J18,H19,F19,F20";
	ATTRIBUTE chip_pin of HEX5 : SIGNAL is "J20,K20,L18,N18,M20,N19,N20";
	
	SIGNAL DataTMP : STD_LOGIC_VECTOR(3 DOWNTO 0);

	COMPONENT Wk3_7segment_decoder IS
	PORT (
		SW : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		LEDR : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		HEX0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
	END COMPONENT;

   COMPONENT ram32x4 
      PORT ( address : IN  STD_LOGIC_VECTOR (4 DOWNTO 0);
             clock   : IN  STD_LOGIC ;
             data    : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
             wren    : IN  STD_LOGIC  := '1';
             q       : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
   END COMPONENT;
BEGIN
   -- instantiate LPM module
   -- entity ram32x4 (address, clock, data, wren, q)
	DataOut <= DataTMP;
	
   U1: ram32x4 PORT MAP (Address, Clock, DataIn, Write, DataTMP);
	H0 : Wk3_7segment_decoder PORT MAP (SW => DataTMP, HEX0 => HEX0); --data read out of memory
	H2 : Wk3_7segment_decoder PORT MAP (SW => DataIn, HEX0 => HEX2 ); --data input to memory
	H4 : Wk3_7segment_decoder PORT MAP (SW => Address(3 DOWNTO 0),  HEX0 => HEX4); --address value
	H5 : Wk3_7segment_decoder PORT MAP (SW => "000" & Address(4), 	 HEX0 => HEX5); --address value	
END Behavior;
