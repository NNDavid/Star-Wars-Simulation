separate(Simulation)

protected body Printer is
	procedure Print(Str: String) is
	begin
		Put_Line(Str);
	end Print;
	procedure Print_Battlefield is
	begin
		for I in Coordinate'range loop
			for J in Coordinate'range loop
				if Map.Get_Is_Alive(I,J) then
					Put(Side'Image(Map.Get_Ship_Item(I,J).S)& " ");
				else
					Put(".  ");
				end if;
			end loop;
			New_Line;
		end loop;
		New_Line;
	end Print_Battlefield;
	
end Printer;