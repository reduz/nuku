Program Nuku;

uses nukumain,sdl,nuku_screen;

begin

	if SDL_Init(SDL_INIT_VIDEO) < 0 then
	begin

		writeln('cannot initialize_sdl');

	end;

	init_screen();

	nukustart;

	SDL_Quit();
end.
