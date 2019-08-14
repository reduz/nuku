unit nuku_screen;
interface
uses sdl,sdl_video,nukusupl,copy_and_filter_pas;

const 

      SCREEN_WIDTH  = 640;
      SCREEN_HEIGHT = 400;


var screen:^SDL_Surface;
    color_palette:array[0 .. 255] of word;
    color_palette_sdl:^SDL_ColorArray;

procedure toggle_eagle();

function init_screen : boolean;

function fill_screen_with_buffer(var src:Vpage) : boolean;

procedure set_color_palette(color,r,g,b:byte);

implementation
uses nuku_music;

var
	use_eagle:boolean;

procedure toggle_eagle();
begin

        use_eagle := not use_eagle;
end;

procedure set_color_palette(color,r,g,b:byte);
       var aux:word;
begin

        aux:=(b shr 1);
        aux:= aux or ((g shr 1) shl 5);
        aux:= aux or ((r shr 1) shl 10);
        color_palette[color]:=aux;
        color_palette_sdl^[color].r:=r shl 2;
        color_palette_sdl^[color].g:=g shl 2;
        color_palette_sdl^[color].b:=b shl 2;
end;

function fill_screen_with_buffer(var src:Vpage) : boolean;
var i,j:integer;
    p:pointer;
{    dest:^Vpage }
    dest:^word;
    val:word;
begin

	if ( SDL_MUSTLOCK(screen) ) then
	begin

		if (SDL_LockSurface(screen) < 0) then writeln('PANIC! Cant Lock it! :( ');
	end;			

	dest:=screen^.pixels;


        if (use_eagle=true) then begin
	        copy_to_screen_and_blur(dest,src,@color_palette,320,200);

        end else begin
	        copy_to_screen(dest,src,@color_palette,320,200);
        end;

	if  SDL_MUSTLOCK(screen) then

	begin

		SDL_UnlockSurface(screen);
	end;

	SDL_SetColors(screen,color_palette_sdl^,0,256);
	SDL_Updaterect(screen,0,0,SCREEN_WIDTH,SCREEN_HEIGHT);

        music_poll(); { baad hax0r }
end;


function init_screen : boolean;
var result:boolean;
begin


    screen:=SDL_SetVideoMode(SCREEN_WIDTH,SCREEN_HEIGHT,8,SDL_SWSURFACE);
    if (screen=nil) then 
    begin
    
	writeln('Cant get 320x200');
	result:=true;
    end else
    begin

        result:=false;
    end;

    getmem(color_palette_sdl,256*sizeof(SDL_Color));
    use_eagle:=true;
	

    init_screen:=result;
end;

end.


