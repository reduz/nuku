unit nuku_keyboard;
interface
uses sdl,sdl_events,sdl_keyboard;
var key:array [0..SDLK_LAST] of boolean;
const scup = SDLK_UP;
      scdown = SDLK_DOWN;
      scleft = SDLK_LEFT;
      scright = SDLK_RIGHT;
      scenter = SDLK_RETURN;
      scesc = SDLK_ESCAPE;
      scspace = SDLK_SPACE;

procedure poll_keyboard;


implementation
uses nuku_music,nuku_screen;


procedure poll_keyboard;

var event:Sdl_Event;
begin



	while( SDL_PollEvent( @event )<>0 ) do
	begin

		{writeln('pressed key with scancode',event.key.keysym.scancode);}

		case (event.eventtype) of 

			SDL_KEYDOWN:begin

				key[event.key.keysym.sym]:=true;
                                if (event.key.keysym.sym=SDLK_F8) then begin
                                        nuku_screen.toggle_eagle();
                                end;
			end;
			SDL_KEYUP:begin
			
				key[event.key.keysym.sym]:=false;
			end;
			SDL_EVENTQUIT:begin
			
				SDL_Quit();
                                halt(0);
			end;
		end;
	end;
        music_poll();

			
end;

var i:integer;

initialization



begin

	for i:=0 to 255 do key[i]:=false;

end;
end.