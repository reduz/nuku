unit Nukumain;
interface
uses
  nukunit,
  nukusupl,
  fastkeys,
  nuku_keyboard,
  sdl_keyboard,
  sdl_timer,
  nuku_music;

var fivelevs:array [1..5] of byte;
    Ftime:File of timearray;
    hiscore:timearray;
    timercount:integer;

Procedure NukuStart;

implementation


ProcedUre GaMeLoOp;
Begin
playlevel:=initpl;
ardilla[1].cont:=3;
ardilla[2].cont:=3;
ardilla[1].lives:=4;
ardilla[2].lives:=4;
ardilla[1].coins:=0;
ardilla[2].coins:=0;
ardilla[1].mode:=0;
ardilla[2].mode:=0;

quito:=false;

flp:=0;
if playlevel=28 then playlevel:=1;
repeat
racemode:=false;
key[123]:=false;
if (playlevel in [7,12,17,21,26]) and (flp=1) then Begin
                                   case playlevel of
                                   7:initlev('bonus1');
                                   12:initlev('bonus2');
                                   17:initlev('bonus3');
                                   21:initlev('bonus4');
                                   26:initlev('bonus5');
                                   end;
	                        music_play_song('SATTOUR.IT');

                                   Gamemain;
                                   end;
flp:=1;

if not quito then Begin
	writeln('initing level..');
	initlev(LeVelname[Playlevel]);
	writeln('running level..');
        Gamemain;
    end;

if ardilla[1].finished or ardilla[2].finished then inc(PLayLeVel);
if ardilla[1].Lives=0 then CONTINiu(1);
if ardilla[2].Lives=0 then CONTINiu(2);
until (playlevel=Levelmax-4) or quito or ((players=1) and (ardilla[1].cont=0)
                                       or ((players=2) and (ardilla[1].cont=0) and
                                          (ardilla[2].cont=0)));
if playlevel = levelmax+1 then{ Final}
                          else{ perdio};
end;


function enter_password :byte;
var pass,i,j,sli:word;
    tmp:byte;
    op:byte;
    whichk:SDLKey;
Begin
op:=1;
ReadPCXp('gamesel.pcx',pag2^[0]);
bak^:=pag2^;
op:=1;
Repeat
putb;
read_keys_from_input;
SDL_Delay(100);
if key[scup]  then op:=1;
if key[scdown]  then op:=2;
PutthingV(90,81+(op-1)*20,22);
copyscr2;
until key[scenter];
if op=2 then Begin
pass:=0;
ReadPCXP('passmenu.pcx',pag2^[0]);
copyscr2;
sli:=1000;
For i:=1 to 4 do Begin
                 tmp:=10;


                 repeat
                 
		    read_keys_from_input;	 
		    SDL_Delay(100);
                    {BIG TODOODOO!!}
                    for j:=0 to 9 do
                    begin
                        whichk:=SDLK_0+j;
                        if (key[whichk]=true) then
                        begin
                                tmp:=j;
                        end;
                    end;

                 until tmp in [0..9];
                 repeat
		    read_keys_from_input;	 
		    SDL_Delay(100);
                 until not key[whichk];

                 MSG(127+i*8,109,chr(tmp+48));
                 copyscr2;
               pass:=pass+(tmp)*(sli);
                 sli:=sli DIV 10;
                 end;
if pass=passlist[1] then enter_password:=1 else
if pass=passlist[2] then enter_password:=2 else
if pass=passlist[3] then enter_password:=5 else
if pass=passlist[4] then enter_password:=7 else
if pass=passlist[5] then enter_password:=10 else
if pass=passlist[6] then enter_password:=12 else
if pass=passlist[7] then enter_password:=15 else
if pass=passlist[8] then enter_password:=17 else
if pass=passlist[9] then enter_password:=20 else
if pass=passlist[10] then enter_password:=21 else
if pass=passlist[11] then enter_password:=24 else
if pass=passlist[12] then enter_password:=26 else
if pass=passlist[13] then enter_password:=28 else enter_password:=1;
end else enter_password:=1;
end;

Procedure quited;
Begin
ReadPCXp('results.pcx',pag2^[0]);
MSG(60,100,'     Descalificado');
copyscr2;
end;

ProcedUre RaceLoop(levelz:byte);
Begin
playlevel:=initpl;
ardilla[1].cont:=3;
ardilla[2].cont:=3;
ardilla[1].lives:=4;
ardilla[2].lives:=4;
quito:=false;
racemode:=true;
initlev(LeVelname[levelz]);
ardilla[1].coins:=0;
ardilla[2].coins:=0;
ardilla[1].invis:=0;
ardilla[2].invis:=0;
ardilla[1].racestatus.maxcoins:=0;
ardilla[2].racestatus.maxcoins:=0;
ardilla[1].racestatus.boxhit:=0;
ardilla[2].racestatus.boxhit:=0;
ardilla[1].mode:=0;
ardilla[2].mode:=0;
ardilla[1].racestatus.min:=0;
ardilla[1].racestatus.sec:=0;
ardilla[1].racestatus.frac:=0;
ardilla[2].racestatus.min:=0;
ardilla[2].racestatus.sec:=0;
ardilla[2].racestatus.frac:=0;
if players=1 then ardilla[2].finished:=true;
ardilla[1].racestatus.tleft:=30;
ardilla[2].racestatus.tleft:=30;
Gamemain;
{if (ardilla[1].Lives=0) or quito then BadRes;
if (ardilla[2].Lives=0) or quito then Badres;}
end;

Procedure Ttrial(nivelz:byte);
var min,sec,fr:string;
begin
players:=1;
quito:=false;
RaceLoop(nivelz);
if quito or (ardilla[1].lives=0) then quited else begin
ReadPCXp('results.pcx',pag2^[0]);
str(ardilla[1].racestatus.min,min);
str(ardilla[1].racestatus.sec,sec);
str(ardilla[1].racestatus.frac,fr);
MSG(20,40,'Tu tiempo fue');
MSG(20,50,min+' mins '+sec+' segs '+fr+' cent');
if (givemeallmili(ardilla[1].racestatus.min,
                  ardilla[1].racestatus.sec,
                  ardilla[1].racestatus.frac)<
   givemeallmili(hiscore[nivelz].min,
                  hiscore[nivelz].sec,
                  hiscore[nivelz].fr)) then Begin
                                           hiscore[nivelz].min:=ardilla[1].racestatus.min;
                                           hiscore[nivelz].sec:=ardilla[1].racestatus.sec;
                                           hiscore[nivelz].fr:=ardilla[1].racestatus.frac;
                                           MSG(20,60,'NUEVO RECORD');
                                           end else Begin
                                                  str(hiscore[nivelz].min,min);
                                                  str(hiscore[nivelz].sec,sec);
                                                  str(hiscore[nivelz].fr,fr);
                                                  MSG(20,60,'el mejor tiempo es');
                                                  MSG(20,70,min+' mins '+sec+' segs '+fr+' cent');
                                                  end;



copyscr2;
end;
repeat
read_keys_from_input;
SDL_Delay(100);
until key[scenter];
end;

Function Singlerace(namlevz:byte) : byte; {devuelve que player gano, 3 si quito}
var min,sec,fr:string;
    pointsp:array [1..4] of byte;
    totp1,totp2:byte;
    i:byte;
begin
players:=2;
quito:=false;
RaceLoop(namlevz);
if quito or ((ardilla[1].lives=0) or (ardilla[2].lives=0))then begin
              quited;
              SingleRace:=4;
              end else begin
ReadPCXp('results.pcx',pag2^[0]);
str(ardilla[1].racestatus.min,min);
str(ardilla[1].racestatus.sec,sec);
str(ardilla[1].racestatus.frac,fr);
MSG(20,40,'            jugador 1');
MSG(20,50,' Tu tiempo fue');
MSG(20,60,min+' mins '+sec+' segs '+fr+' cent');
if Givemeallmili(ardilla[1].racestatus.min,ardilla[1].racestatus.sec,ardilla[1].racestatus.frac)<
   Givemeallmili(ardilla[2].racestatus.min,ardilla[2].racestatus.sec,ardilla[2].racestatus.frac)then
   pointsp[1]:=1 else
if Givemeallmili(ardilla[1].racestatus.min,ardilla[1].racestatus.sec,ardilla[1].racestatus.frac)>
   Givemeallmili(ardilla[2].racestatus.min,ardilla[2].racestatus.sec,ardilla[2].racestatus.frac)then
   pointsp[1]:=2 else pointsp[1]:=3;

str(ardilla[1].racestatus.maxcoins,min);
MSG(20,70,' juntaste '+min+' diamantes');
if ardilla[1].racestatus.maxcoins>ardilla[2].racestatus.maxcoins then
pointsp[2]:=1 else
if ardilla[1].racestatus.maxcoins<ardilla[2].racestatus.maxcoins then
pointsp[2]:=2 else pointsp[2]:=3;

str(ardilla[1].coins,min);
if ardilla[1].coins>ardilla[2].coins then
pointsp[3]:=1 else
if ardilla[1].coins<ardilla[2].coins then
pointsp[3]:=2 else pointsp[3]:=3;
MSG(20,80,' y llegaste con '+min);
str(ardilla[1].racestatus.boxhit,min);
MSG(20,90,' Golpeaste '+min+' Cajas');
str(ardilla[1].coins,min);
if ardilla[1].racestatus.boxhit>ardilla[2].racestatus.boxhit then
pointsp[4]:=1 else
if ardilla[1].racestatus.boxhit<ardilla[2].racestatus.boxhit then
pointsp[4]:=2 else pointsp[4]:=3;


if pointsp[1]=1 then BEGIN
                              MSG(210,60,'GANO');
                              MSG(210,130,'PERDIO');
                              END else
if pointsp[1]=2 then BEGIN
                              MSG(210,60,'PERDIO');
                              MSG(210,130,'gano');
                              END else begin
                              MSG(210,60,'igual');
                              MSG(210,130,'igual');
                              END;
if pointsp[2]=1 then BEGIN
                              MSG(210,70,'GANO');
                              MSG(210,140,'PERDIO');
                              END else
if pointsp[2]=2 then BEGIN
                              MSG(210,70,'PERDIO');
                              MSG(210,140,'gano');
                              END else begin
                              MSG(210,70,'igual');
                              MSG(210,140,'igual');
                              END;
if pointsp[3]=1 then BEGIN
                              MSG(210,80,'GANO');
                              MSG(210,150,'PERDIO');
                              END else
if pointsp[3]=2 then BEGIN
                              MSG(210,80,'PERDIO');
                              MSG(210,150,'gano');
                              END else begin
                              MSG(210,80,'igual');
                              MSG(210,150,'igual');
                              END;

if pointsp[4]=1 then BEGIN
                              MSG(210,90,'GANO');
                              MSG(210,160,'PERDIO');
                              END else
if pointsp[4]=2 then BEGIN
                              MSG(210,90,'PERDIO');
                              MSG(210,160,'gano');
                              END else begin
                              MSG(210,90,'igual');
                              MSG(210,160,'igual');
                              END;



str(ardilla[2].racestatus.min,min);
str(ardilla[2].racestatus.sec,sec);
str(ardilla[2].racestatus.frac,fr);
MSG(20,110,'            jugador 2');
MSG(20,120,' Tu tiempo fue');
MSG(20,130,min+' mins '+sec+' segs '+fr+' cent');
str(ardilla[2].racestatus.maxcoins,min);
MSG(20,140,' juntaste '+min+' diamantes');
str(ardilla[2].coins,min);
MSG(20,150,' y llegaste con '+min);
str(ardilla[2].racestatus.boxhit,min);
MSG(20,160,' Golpeaste '+min+' Cajas');
totp1:=0;
totp2:=0;
for i:=1 to 4 do case pointsp[i] of
                 1:inc(totp1);
                 2:inc(totp2);
                 end;
if totp1>totp2 then Begin
                    MSG(80,180,'Gano jugador 1');
                    singlerace:=1;
                    end else
if totp1<totp2 then Begin
                    MSG(80,180,'Gano jugador 2');
                    singlerace:=2;
                    end else
if totp1=totp2 then Begin
                    MSG(80,180,'hubo un empate');
                    singlerace:=3;
                    end;
copyscr2;
end;
repeat
read_keys_from_input;
SDL_Delay(100);
until key[scenter];
end;

Procedure torneo;
var co1,co2:shortint;
    quito:boolean;
    i:word;
    res:array[1..5] of byte;
Begin
quito:=false;
i:=1;
Repeat
                 res[i]:=singlerace(fivelevs[i]);
                 if res[i]=4 then Begin
                                  quito:=true;
                                  i:=5;
                                  end;
inc(i);
until i>5;
co1:=0;
co2:=0;

if not quito then begin
ReadPcxp('results.pcx',pag2^[0]);
{copyscr2;}

   for i:=1 to 5 do begin
       case res[i] of
       1:inc( co1);
       2:inc( co2);
       3:begin
         inc( co1);
         inc( co2);
         end;
       end;
   end;
For i:= 1 to 5 do Begin
                  MSG(20,40+i*13,levnames[fivelevs[i]]);
                  case res[i] of
                  1:MSG(160,40+i*13,'Gano jugador 1');
                  2:MSG(160,40+i*13,'Gano Jugador 2');
                  3:MSG(160,40+i*13,'empate');
                  end;
                  end;

if co1>co2 then MSG(40,180,'EL jugador 1 gano el torneo');
if co1<co2 then MSG(40,180,'El jugador 2 Gano el torneo');
if co1=co2 then Msg (40,180,'Fue un empate');
copyscr2;
repeat
read_keys_from_input;
SDL_Delay(100);
until key[scenter];     
repeat
read_keys_from_input;
SDL_Delay(100);
until not key[scenter];
end;

end;


Procedure waitz(n:byte);
Begin
timervar:=0;
repeat until timervar>=n;
end;

Function selectlevel : byte;
var i,j:smallint;
    cursop:byte;
    eligio:boolean;
    cualva:byte;
    pistas:array[0..28] of byte;
    cantpi:byte;
Begin
pistas[0]:=0;
Readpcxp('levsel1.pcx',pag2^[0]);
copyscr2;
bak^:=pag2^;
eligio:=false;
cursop:=1;
cantpi:=0;
for i:=1 to 33 do if (levnames[i]<>'NA') and ((i<initpl) or (i>27)) then Begin
                                                                            inc(cantpi);
                                                                            pistas[cantpi]:=i;
                                                                            end;




key[scenter]:=false;

Repeat
putb;
read_keys_from_input;
SDL_Delay(100);
cualva:=0;
For j:=1 to 3 do for i:=4 to 18 do begin
                                    inc(cualva);
                                    if cualva<=cantpi then MSG((j-1)*80+40,i*10,levnames[pistas[cualva]]);
                                    if cursop=cualva then PutthingV((j-1)*80+20,i*10-10,22);

                                    end;
copyscr2;
if key[scup] then if cursop>1 then Begin
                                   dec(cursop);
                                   repeat
                                   read_keys_from_input;
				   SDL_Delay(40);    
                                   until not key[scup];
                                   end;
if key[scdown] then if cursop<cantpi then Begin
                                          inc(cursop);
                                          repeat
                                          read_keys_from_input;
					  SDL_Delay(40);
                                          until not key[scup];
                                          end;
if key[scesc] then Begin
                    cursop:=0;
                    eligio:=true;
                    end;
if key[scenter] then Begin
                    eligio:=true;
                    end;
until eligio;
selectlevel:=pistas[cursop];
end;

procedure selectlevels;
var i,j,k,l:smallint;
    cursop:byte;
    eligio:boolean;
    cualva:byte;
    pistas:array[0..28] of byte;
    cantpi:byte;
    cuantva:byte;
Begin
pistas[0]:=0;
for k:=1 to 5 do Begin
Readpcxp('levsel1.pcx',pag2^[0]);
MSG(160,180,'Elegi la pista '+chr(48+k));
copyscr2;
bak^:=pag2^;
eligio:=false;
cursop:=1;
cantpi:=0;
for i:=1 to 33 do if (levnames[i]<>'NA') and ((i<initpl) or (i>27)) then Begin
                                                                            inc(cantpi);
                                                                            pistas[cantpi]:=i;
                                                                            end;




key[scenter]:=false;
repeat
putb;
read_keys_from_input;
SDL_Delay(50);
cualva:=0;
j:=1;
Repeat
i:=4;
Repeat
                                    inc(cualva);
                                    if cualva<=cantpi then MSG((j-1)*80+40,i*10,levnames[pistas[cualva]]);
                   if k>1 then for l:=1 to k-1 do if pistas[cualva]=fivelevs[l] then
                                        Begin
                                        PutthingV((j-1)*80+20,i*10-10,21);
                                        MSG((j-1)*80+22,i*10,chr(48+l));
                                        end;
                                    if cursop=cualva then Begin
                                                          PutthingV((j-1)*80+20,i*10-10,22);
                                                          MSG((j-1)*80+22,i*10,chr(48+k));
                                                          end;
                                    if cualva>cantpi then Begin
                                                          j:=3;
                                                          i:=18;
                                                          end;
inc(i);
read_keys_from_input;
until i>18;
inc(j);
read_keys_from_input;

until j>3;
copyscr2;
read_keys_from_input;
if key[scup] then if cursop>1 then Begin
                                   dec(cursop);
                                   repeat
                                   read_keys_from_input;
				   SDL_Delay(50);
                                   until not key[scup];
                                   end;
if key[scdown] then if cursop<cantpi then Begin
                                          inc(cursop);
                                   repeat
                                   read_keys_from_input;
				   SDL_Delay(50);
                                   until not key[scdown];

                                          end;
if key[scenter] then Begin
                    eligio:=true;
                    if k>1 then for l:=1 to k do if pistas[cursop]=fivelevs[l] then eligio:=false;
                    end;
read_keys_from_input;
SDL_Delay(40);
until eligio;
fivelevs[k]:=pistas[cursop];
end;
end;





Procedure VerHighs;
var trk:byte;
      tm,ts,tf:string;
Begin
trk:=selectlevel;
while trk<>0 do Begin
ReadPCXp('results.pcx',pag2^[0]);
copyscr2;
MSGv(20,60,'El mejor tiempo en este nivel es');
str(hiscore[trk].min,tm);
str(hiscore[trk].sec,ts);
str(hiscore[trk].fr,tf);
MSGv(50,80,tm+' min '+ts+' segs '+tf+' cent');
MSGv(30,180,'Presione espacio para continuar');
repeat
read_keys_from_input;
SDL_Delay(40);
until key[scspace];
trk:=selectlevel;
end;

end;



Procedure comp;
var op:byte;
    eligio:boolean;
    levsel:byte;
Begin
ReadpcxP('compmenu.pcx',pag2^[0]);
copyscr2;
bak^:=pag2^;
op:=0;
eligio:=false;
key[scenter]:=false;
Repeat
read_keys_from_input;
SDL_Delay(100);
putb;
PutthingV(91,91+(op)*17,22);
copyscr2;
if (op>0) and key[scup] then Begin
                dec(op);
                Repeat
                read_keys_from_input;
		SDL_Delay(100);
                until not key[scup];
                end;
if key[scdown] and (op<4) then Begin
                inc(op);
                repeat
                read_keys_from_input;
		SDL_Delay(100);
                until not key[scdown];
                end;

if key [scenter] then eligio:=true;


until eligio;
case op of
0:Begin
  levsel:=SelectLevel;
  if levsel>0 then Ttrial(levsel);
  end;
1:Begin
  levsel:=SelectLevel;
  if levsel>0 then Singlerace(levsel);
  end;
2:Begin
       Selectlevels;
       Torneo;
  end;
3:Verhighs;
end;
end;

Procedure ayuda;
var cscr:byte;
       bp:string[1];
begin
cscr:=0;
Repeat
str(cscr+1,bp);
ReadPCxP(''+'H'+bp+'.Dta',pag2^[0]);
copyscr2;
Repeat until key[scleft] or key[scright] or key[scesc];
if key[scright] and (cscr<4) then inc(cscr);
if key[scleft] and (cscr>0) then dec(cscr);
until key[scesc];
end;



Procedure Staff;
var i,j:word;

PRocedure ponelin(y:smallint; num:byte);
Begin
if (y>10) and (y<190) then MSG(20,y,quien[num]);
end;

Begin
ReadPCxp('stf.pcx'{,@Pag2^[0]},pag2^[0]);
bak^:=Pag2^;
i:=1;
Repeat
                       fillchar(pag2^[0],64000,0);
                       for j:=0 to 127 do fillchar(pag2^[63+j,0],320,128+j+random(2));
                       for j:=1 to tipos do ponelin(200-i+j*8,j);
                       moven(@bak^[0],@Pag2^[0],64000);
                       copyscr2;
                       copyscr2;
                       if key[scenter] then i:=tipos*8+200;


inc(i);
until (i=tipos*8+200);
end;


Procedure GameMainop;
var op:byte;
    eligio:boolean;
Begin
Repeat
{toimp Setclock(fast);}
if music then playmusic('mi.mid');
ReadpcxP('intro.pcx',pag2^[0]);
copySCR2;
copiabak2;
initpl:=0;
op:=1;
eligio:=false;
key[scenter]:=false;
repeat
putb;
PutthingV(86,89+(op-1)*17,22);
copyscr2;
if key[scup] and (op>1) then begin
                           playfx(1);
                           dec(op);
                           repeat
                           read_keys_from_input;
			   SDL_Delay(100);
                           until not key[scup];
                           end;
if key[scdown] and (op<5) then begin
                           playfx(1);
                           inc(op);
                           repeat
                           read_keys_from_input;
			   SDL_Delay(100);
                           until not key[scdown];
                           end;
if key[scenter] then eligio:=true;
read_keys_from_input;
SDL_Delay(100);
until eligio;
key[scenter]:=false;
read_keys_from_input;
SDL_Delay(100);
timervar:=0;

PutthingV(86,89+(op-1)*17,21);

if op=1 then players:=1;
if op=2 then players:=2;
if op=4 then Begin
{             AYUDA;}
             staff;
             if music then stopmusic;
             end;
if op<3 then Begin
             initpl:=enter_password;
             gameloop;
             end;
if op=3 then Begin
             initpl:=enter_password;
             comp;
             end;


until op=5;

end;


Procedure SaveHighs;
Begin
assign(Ftime,'tiempos.trk');
{$i-}
Rewrite(Ftime);
if ioresult<>0 then File_Error;
write(Ftime,hiscore);
close(ftime);
{$i+}
end;

PRocedure CreateTable;
var i:byte;
BEgin
For i:=1 to 33 do Begin
                  hiscore[i].min:=30;
                  hiscore[i].sec:=30;
                  hiscore[i].fr:=30;
                  end;
savehighs;

end;
Procedure loadHighs;
Begin
if not exist ('tiempos.trk') then createtable;
assign(Ftime,'tiempos.trk');
{$i-}
Reset(Ftime);
if ioresult<>0 then File_Error;
Read(Ftime,hiscore);
close(ftime);
{$i+}
end;








var cdfil:file of char;

Procedure Nukustart;
Begin

randseed:=40;
Loadhighs;
init;
gamemainop;
if music then stopmusic;
done;
Savehighs;
end;
end.
