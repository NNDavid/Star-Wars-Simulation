separate(Simulation)

task body Base is
	Ship_Count : Integer := 0;
begin
	accept Send_Out_Ships(N: Integer) do
		Ship_Count := N;
	end Send_Out_Ships;
	
	Printer.Print(Side'Image(S) & " sent out" & Natural'Image(Ship_Count) & " ships");
	
	while Ship_Count > 0 loop
		select
			accept Ship_Lost do
				Ship_Count := Ship_Count - 1;
			end Ship_Lost;
		or
			accept Destroy;
			Ship_Count := 0;
		end select;
	end loop;
	Map.Base_Message(S);
	Map.End_Fight;
	
end Base;