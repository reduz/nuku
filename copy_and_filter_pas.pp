unit copy_and_filter_pas;
interface
type
        erg=integer;
        pword=^word;
        pbyte=^byte;
	
procedure copy_to_screen_and_blur(dest:pword; src:pbyte; pal:pword; p_w,p_h:integer); cdecl; external;
procedure copy_to_screen(dest:pword; src:pbyte; pal:pword; p_w,p_h:integer); cdecl; external;

implementation

{$LINKLIB copy_and_filter}


end.

