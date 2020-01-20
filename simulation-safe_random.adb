separate(Simulation)
protected body Safe_Random is
		
	procedure Get_Random(I,J: out Coordinate) is
	begin
		if not Is_Initialised then
			Initialise;
		end if;
		I := Coordinate_Random.Random(G);
		J := Coordinate_Random.Random(G);
	end Get_Random;
	
	procedure Initialise is 
	begin 
		Coordinate_Random.Reset(G); 
		Is_Initialised := True; 
	end Initialise;
	
end Safe_Random;