separate(Simulation)
task body Projectile is
	I,J: Coordinate;
	Current_Ship : Ship_Record;
begin
	Safe_Random.Get_Random(I,J);
	if ID = Luke_ID then
		if I = J then 
			Printer.Print("The Force was with Luke, he destroyed the Death Star!");
			select
				Death_Star.Destroy;
			or
				delay 1.0;
			end select;
		else
			Printer.Print("May the Force be with you next time, Luke!");
		end if;
	else
		if Map.Get_Ship_Item(I,J).S /= S and Map.Get_Is_Alive(I,J) then
			Map.Set_Dead(I,J,ID);
			select 
				Map.Get_Ship_Item(I,J).Hit;
			or
				delay 1.0;
			end select;
		else
			Printer.Print(Side'Image(S) & " Ship " & Integer'Image(ID) & " missed a shot");
		end if;
	end if;
end Projectile;