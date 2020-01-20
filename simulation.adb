with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

procedure Simulation is
	type Side is (Re,Im);
	subtype Coordinate is Positive range 1..10;
	Luke_ID : constant Integer := 500;
	
	package Coordinate_Random is new Ada.Numerics.Discrete_Random(Coordinate);
	
	protected Safe_Random is
		procedure Get_Random(I,J: out Coordinate);
		procedure Initialise;
	private
		G: Coordinate_Random.Generator;
		Is_Initialised : Boolean := False;
	end Safe_Random;
	
	protected Printer is
		procedure Print(Str: String);
		procedure Print_Battlefield;
	end Printer;
	
	task type Base(S: Side) is
		entry Send_Out_Ships(N: Integer);
		entry Ship_Lost;
		entry Destroy;
	end Base;
	
	type Base_Access_All is access all Base;
	
	Rebel_Base: aliased Base(Re);
	Death_Star: aliased Base(Im);
	
	task type Ship(ID: Integer; S: Side) is
		entry Hit;
		entry Call_Back;
	end Ship;
	
	
	type Ship_Access is access Ship;
	
	Luke_Skywalker: Ship_Access;
	
	type Ship_Record is record
		Ship_Item: Ship_Access;
		Is_Alive: Boolean := False;
	end record;
	
	type Ship_Record_Array is array(Positive range <>, Positive range <>) of Ship_Record;
	
	
	
	task type Projectile(S: Side;ID: Integer );

	type Projectile_Access is access Projectile;
	
	protected Map is
		procedure Init;
		function Get_Is_Alive (I,J: Coordinate) return Boolean;
		function Get_Ship_Item(I,J: Coordinate) return Ship_Access;
		procedure End_Fight;
		procedure Set_Dead(I,J: Coordinate;ID_Enemy: Integer);
		procedure Base_Message(S: Side);
	private
		Field: Ship_Record_Array(Coordinate,Coordinate);
		Base_Message_Called_Time : Integer := 0;
	end Map;
	
	task type Agent(A: Ship_Access);
	type Agent_Access is access Agent;
	
	protected body Safe_Random is separate;
	protected body Printer is separate;
	task body Base is separate;
	task body Ship is separate;
	task body Projectile is separate;
	protected body Map is separate;
	task body Agent is separate;
	
begin
	Map.Init;
	
	Rebel_Base.Send_Out_Ships(50);
	Death_Star.Send_Out_Ships(50);
end Simulation;