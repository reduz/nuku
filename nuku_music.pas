unit nuku_music;
interface
uses mikmod,cmem;

procedure music_poll();
procedure music_play_song(fname:PCHAR);
procedure music_play_sndfx(p_which:integer);


implementation

       var
		module:PMODULE;
                idx:word;
                samples:array[1..7] of PSAMPLE;
        const
                samplenames:array[1..7] of PCHAR = ('s1.wav','s2.wav','s3.wav','s4.wav','s5.wav','s6.wav','s7.wav');

procedure music_poll();
begin

	if (module<>nil) then MikMod_Update();
end;

procedure music_play_song(fname:PCHAR);
begin

        if (module<>nil) then
        begin
        	Player_Stop();
	        Player_Free(module);
        end;


	module := Player_Load(fname, 64, False);
       	Player_Start(module);

end;


procedure music_play_sndfx(p_which:integer);
begin

        if (p_which in [1..7]) then
        begin
		 Sample_Play(samples[p_which], 0, 0);
        end;

end;
initialization


begin

        module:=nil;

	{ load shared library }
	if (mikmod.LoadMikMod() = False) then
		writeln('Can''t init mikmod library, missing libmikmod.so.3?');

	{ register all the drivers }
	mikmod.MikMod_RegisterAllDrivers();

	{ register all the module loaders }
	mikmod.MikMod_RegisterAllLoaders();

	{ initialize the library }
	md_mode^ := md_mode^ or DMODE_SOFT_MUSIC or DMODE_SOFT_SNDFX;
	if (mikmod.MikMod_Init('') <> 0) then begin
	
		writeln('Cant init!');

	end;


        for idx:=1 to 7 do
        begin
                samples[idx]:=Sample_Load(samplenames[idx]);
        end;

	MikMod_SetNumVoices(-1, 2);


	MikMod_EnableOutput();



end;

end.
