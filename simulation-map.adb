separate(Simulation)

protected body Map is
	
	procedure Init is
	begin
		for I in Coordinate'range loop
			for J in 1..5 loop
				Field(I,J).Ship_Item := new Ship(10 * (I - 1) + J, Re);
				Field(I,J).Is_Alive := True;
			end loop;
			for J in 6..10 loop
				Field(I,J).Ship_Item := new Ship(10 * (I - 1) + (J - 5), Im);
				Field(I,J).Is_Alive := True;
			end loop;
		end loop;
		Luke_Skywalker := new Ship(Luke_ID, Re);
		Printer.Print_Battlefield;
	end Init;
	
	function Get_Is_Alive (I,J: Coordinate) return Boolean is
	begin
		return Field(I,J).Is_Alive;
	end Get_Is_Alive;
	
	function Get_Ship_Item(I,J: Coordinate) return Ship_Access is
	begin
		return Field(I,J).Ship_Item;
	end Get_Ship_Item;
	
	procedure End_Fight is
	begin
		for I in 1..10 loop
			for J in 1..10 loop
				declare
					A: Agent_Access;
				begin
					A := new Agent(Field(I,J).Ship_Item);
				end;
			end loop;
		end loop;
		declare
			A: Agent_Access;
		begin
			A := new Agent(Luke_Skywalker);
		end;
	end End_Fight;
	
	procedure Set_Dead(I,J: Coordinate;ID_Enemy: Integer) is
	begin
		Field(I,J).Is_Alive := False;
		if Field(I,J).Ship_Item.S = Re then
			Printer.Print("Imperial Ship" & Integer'Image(ID_Enemy) & " destroyed Rebel Ship" & Integer'Image(Field(I,J).Ship_Item.ID));
		else
			Printer.Print("Rebel Ship" & Integer'Image(ID_Enemy) & " destroyed Imperial Ship" & Integer'Image(Field(I,J).Ship_Item.ID));
		end if;
		Printer.Print_Battlefield;
	end Set_Dead;
	
	procedure Base_Message(S: Side) is
	begin
		
		Base_Message_Called_Time := Base_Message_Called_Time + 1;
		if Base_Message_Called_Time mod 2 = 0 then
			if S = Re then
			Printer.Print("The Rebels have won!");
			else
			Printer.Print("The Imperials have won!");
			end if;
		else
			if S = Re then
			Printer.Print("The Rebels have lost!");
			else
			Printer.Print("The Imperials have lost!");
			end if;
		end if;
	end Base_Message;
end Map;