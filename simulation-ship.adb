separate(Simulation)

task body Ship is
	Is_Hit,Is_Called_Back: Boolean := False;
	B: Base_Access_All;
begin
	if ID = Luke_ID then
		delay 5.0;
		Printer.Print("Luke Skywalker has joined the battle!");
	end if;
	
	if S = Re then
		B := Rebel_Base'Access;
	else
		B := Death_Star'Access;
	end if;
	while not Is_Hit and not Is_Called_Back loop
		select
			accept Hit;
			Is_Hit := True;
		or
			accept Call_Back do
			Is_Called_Back := True;
			Printer.Print(Side'Image(S) & " ship#" & Positive'Image(ID) & "got called back!");
			end Call_Back;
		or
			delay 0.5;
			declare
				P:Projectile_Access;
			begin
				P := new Projectile(S,ID);
			end;
		end select;
	end loop;
	if ID /= Luke_ID then
		select
			B.all.Ship_Lost;
		or
			delay 1.0;
		end select;
	end if;
end Ship;