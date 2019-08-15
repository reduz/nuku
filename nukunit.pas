{topimp}
Unit Nukunit;
interface
Uses nukusupl,fastkeys,nuku_screen,nuku_keyboard,SDL_Timer,nuku_music,sdl_keyboard;


const {amax=15;}
      FAST=$965C;
      NORMAL=$FFFF;
      levelmax=33;
      initpl:byte=1;
      nukurunning:Boolean=False;
       tipos = 43;
       

const passlist:array[1..13] of word=(4351,8362,9983,1932,3814,6593,9481,7629,9824,2171,7543,6732,9189);
passtab:array[1..levelmax-5] of byte= (1,2,2,2,3,3,4,4,4,5,5,6,6,6,7,7,8,8,8,9,10,10,10,11,11,12,12,12);
nrgbad:array[1..15] of byte =(0,13,10,0,17,0,7,0,15,0,0,20,0,0,27);
quien:array [1..tipos] of string =
('programacion planeamiento','sonido fx  graficos','animacion y mapas',' ','juan sebastian linietsky','pablo andres selener',
' ',' ',' ',
'musica',' ','juan sebastian linietsky',' ',' ',' ','ayuda adicional',' ','claudio pacheli','Martin Gomez',' ',' ',
' ',' ',' ',' ','primeros testeadores',' ',
'ariel manzur','franco santinelli','claudio pacheli','viviana malamud','gustavo malamud',
'Gustavo carball','javier cichelli','luis linietsky',' ',' ',' ','ultimos testeadores',' ',
'Fernando maldonado','sera llenado','sera llenado');

      IrBLock:array[1..7,1..2] of byte = ((13,13),(0,23),(0,12),(13,23),
                                          (23,13),(12,0),(23,0));
      BadDim:array[1..45,1..4] of shortint =((0,30,5,35),(11,39,0,36),(0,40,0,35),
                                          (5,45,0,45),(0,33,0,15),
                                          (0,50,0,45),(0,15,0,15),
                                          (0,25,0,25),(5,45,0,45),
                                          (0,25,0,30),(0,48,0,30),
                                           (0,50,0,45),
                                          (0,25,30,45),(0,25,0,25),
                                          (25,50,30,45),(0,50,0,45),
                                         (0,50,0,40),(0,50,0,45),(0,25,0,25),
                                         (12,37,0,25),(-10,15,0,5),(0,50,-45,45),
                                         (0,50,4,45),(0,127,5,35),(0,50,0,45),(-5,20,-5,20),
                                         (10,40,0,40),(5,45,6,40),(25,100,15,45),
                                         (0,50,0,45),(0,50,0,45),
                                         (10,40,20,40),(5,45,30,40),
                                         (1,1,1,1),(1,1,1,1),
    (25,80,10,40),(0,14,0,14),(0,0,0,0),(0,0,0,0),(5,45,15,80),(0,50,0,45),(0,50,0,95),(0,50,0,45),(0,50,0,45),(0,50,-14,45));

     muslev:array[1..15] of byte =(4,7,5,8,11,15,3,6,9,2,12,13,14,4,10);
     mkill:array[1..45] of byte=(1,1,0,1,0,1,0,1,1,1,1,1,0,0,0,1,0,1,0,1,0,0,1,0,1,0,1,1,3,1,0,0,1,3,3,3,0,3,3,1,1,1,1,1,1);
     levInv:array[1..15] of boolean =(false,true,false,false,true,false,false,false,true,false,false,true,true,true,false);
        flakes=150;
        fastest=500;
        levelname:array [1..levelmax] of string[8] =
('lev10','lev7','lev7b','lev7f','lev2','lev2b','lev3','lev3b','lev3f',
'lev8','lev8b','lev5','lev5b','lev5f','lev4','lev4b','lev9',
'lev9b','lev9f','lev6','lev1','lev1b','lev1f','lev11','lev11b','lev12','lev12b','lev15f',
'race1','race2','race3','race4','race5');
musicfile:array [1..levelmax] of PCHAR =
('ESCAPE.IT','TAR-ZAN.IT','TAR-ZAN.IT','FLAGRU.IT','CHOCOMON.IT','CHOCOMON.IT','NEPAL.IT','NEPAL.IT','FLAGRU.IT',
'RUINS.IT','RUINS.IT','INCAN.IT','INCAN.IT','FLAGRU.IT','VP.IT','VP.IT','PB.IT',
'PB.IT','FLAGRU.IT','NUKUNIT.IT','TAL.IT','TAL.IT','FLAGRU.IT','TOONSTRT.IT','TOONSTRT.IT','ALEFLOAT.IT','ALEFLOAT.IT','FLAGRU',
'SSHAKE.IT','CHOCOMON.IT','TAR-ZAN.IT','TAL.IT','ESCAPE.IT');




        vocnames:array[1..7] of string[8]=('s1','s2','s3','s4','s5','s6','s7');

        coordlod:array [1..levelmax-5,0..1] of word = ((81,174),{escape}
                                                     (113,156),(141,141),{pradera}
                                                     (1,1),
                                                     (158,125),(143,99),{estepa}
                                                     (125,82),(127,69),{nieve}
                                                     (1,1),
                                                     (140,51),(159,45),{cueva}
                                                     (192,57),(216,76),{griego}
                                                     (1,1),
                                                     (249,71),(286,75),{agua}
                                                     {hay mas!}
                                                     (51,97),(75,90),{Fabrica quimica}
                                                     (1,1),
                                                     (103,84), {tren}
                                                     (154,72),(177,72),{Fabr MEq}
                                                     (1,1),
                                                     (210,72),(241,80),{Citiudad}
                                                     (243,85),(245,85), {nave espacial}
                                                     (1,1));





       levnames:array[1..levelmax] of string[8] = ('escape','prado 1','prado 2','NA','puna 1','puna 2',
                                                'nieve 1','nieve 2','NA','cueva 1','cueva 2','griego 1',
                                                'griego 2','NA','muelle 1','muelle 2','fabrq 1','fabrq 2','NA',
                                                'tren','fabrm 1','fabrm 2','NA','ciudad 1','ciudad 2','nave 1','nave 2','NA'
                                                ,'Volcan','maraton','campito','tecno','la ruta');
Type
     wordi=array[0..1]of byte;
     FlakeyRec = Record x,y:Byte;p:Word; end;
      Data=Array[0..45000] of byte;
      DataV=Array[0..22499] of byte;
     Malos = array [1..27000] of byte;
     letra_rec=array [0..1959] of byte;
     soniditos=array [0..16000] of byte;
     ardi = array [0..29601] of byte;
     Sce=Array[0..523,0..124] of byte;
     rtable=array[0..255] of byte;
     Scen=^Sce;
     d2Page=Array[0..500,0..319] of byte;

      SCD=record
      USED,LEVType,Bgused:byte;
        StartX,STARTY,endx:Word;

        end;
      SCD_r=record
      USED,LEVType,Bgused:byte;
        StartX,STARTY,endx:Wordi;

        end;


     BAD=RECORD
      X,y:word;
       classb,Estado,dir:byte;
      end;
    
     BAD_r=BAD;
     Rec_Vec = record
        x,y:word;
          t:byte;
          end;
     Rec_Vec_r = rec_vec;
       FX_REc = record
          where:pointer;
          size:word;
          end;
       Race_Rec = Record
         MIN,SEC,FRAC,maxcoins,Tleft,Boxhit:BYTE;

              end;





             sets = record
          sound:boolean;
          music:boolean;
          musicacd:boolean;
          IRQ,DMA:byte;
           Port:Word;
           P1LEFT,P1RIGHT,P1A,P1B:Byte;
           P2LEFT,P2RIGHT,P2A,P2B,JOyuse:Byte;
           end;

     ard_rec =  Object
        X,Y:word;
        nrg,ACX,ACY:shortint;
        cont,carrito,wait,jump,lives,Coins,hframe,titil,Frame,Walk,mode,q:byte;
        Red,Itag,diamonds,spin,invis:byte;
        agua,wf,kb1left,kb2left,oldir,finished,niveled,Dir,Kup,Kdn,Krt,Klt,KB1,KB2:Boolean;
        XAMAX,Amax:smallint;
          racestatus:race_Rec;
        rock:array [1..4] of record
             x,y:smallint;
             spd,acy:byte;

             dir,used:boolean;
             end;
        Procedure RockProc;
        Procedure drawrock(xu,yu:smallint);
        Procedure ArdProc(numard:byte);
        Procedure PUTSQ(Xu,Yu:smallint; t:byte);
        end;

        joyst = Object
         X,Y,X2,Y2:Word;
         JOyCx,JoyCy:Word;
         Function Left : Boolean;
         Function right : Boolean;
         end;




var tiles:^Data;
     tilesV:^DataV;
     badS:^malos;
     SOUND:^soniditos;
     letras:^letra_rec;
    fil:file;{ of byte}
      fi:file;
    {fil2:file of rec_Vec_r;}
    fil2:file;
     {fil3:file of SCD_r;}
      fil3:file;
    {fil4:file of BAD_r;}
    fil4:file;
     fs:file;
     vsc:File of Scen;
     settings:sets;
    datos:scd;
    bguys:array[0..150] of BAD;
    rayosi,Vmode,BGUSED:byte;
    VARTIME,timeCD,lengthcd:WORD;
    VECTOBJ:ARRAY [0..150] of REC_VEC;
    flp,ftime,playlevel,players,used,Zero:byte;
    Scene:^Sce;
    Pag2,Bak,Secp,pvid:^d2Page;
    SaleDeX,SaleDeY,OLDX,OLDY,WX,WY,X2,Y2,oldx2,oldy2:smallint;
    ard:^ardi;
    ardilla:array [1..2] of ard_rec;

    rayo,JoyCX,JoyCY,clk2,curflake,r,s,re:Word;
    names,TeStFlag,inside,racemode:Boolean;
    Flake,flake2:Array[0..flakes] of flakeyrec;
    voces:array[1..7] of fx_rec;
    inmo,resor,clk:byte;
    RAYOS,vr,quito,canplay2,music,sfx:boolean;
    reds,BLus:^rtable;
    joys:Joyst;
    temprec:rec_vec;
    raceres:array [1..5] of boolean; {true si gana el player 1}
    races:array[1..5] of byte;
{*****************************dwm variables!!!!********************}
{*****************************dwm variables!!!!********************}
{*****************************dwm variables!!!!********************}
{*****************************dwm variables!!!!********************}

{*****************************dwm variables!!!!********************}
{*****************************dwm variables!!!!********************}
{*****************************dwm variables!!!!********************}
        soundvar:word;
        timerc:procedure;
        oldint:pointer;
{***}
        nivel_de_malo:boolean;
        energia_de_malo:byte;
        malo_Titil:byte;
        Malo_status1:byte;
        Malo_status2:byte;
        Malo_status3:byte;
        Malo_status4:shortint;
        old_stat:byte;

Procedure STOPMUSIC;
Procedure PLAYMUSIC(X:string);
Procedure PutB;{ assembler;}
Procedure CopyScr2;
Procedure copiabak2; {assembler;}
Procedure PutThingV(xu,yu:smallint; t:byte);
Procedure MSG(x,y:Word; MsA:string);
Procedure PLAYFX(cual:byte);
Procedure init;
Procedure done;
Procedure GaMeMain;
{Procedure quited;}
Procedure MSGV(x,y:Word; MsA:string);
Procedure continiu(Cual:byte);

Procedure initlev(MAPN:string);

procedure read_keys_from_input;

implementation
uses nukumain;

procedure read_keys_from_input;
begin

	poll_keyboard();

end;

Procedure GenerateTC;
var i,j:word;
Begin

For i:=0 to 199 do for j:=0 to 319 do Begin

//    Vircol[i,j*3]:=VPalette[VirvidBuff^[320*i+j],2]*4;
//    Vircol[i,j*3+1]:=VPalette[VirvidBuff^[320*i+j],1]*4;
//    Vircol[i,j*3+2]:=VPalette[VirvidBuff^[320*i+j],0]*4;

    end;

end;

Procedure VidDisplay;
var i,j,y:word;

Begin

fill_screen_with_buffer(virvidbuff^);

end;


Procedure INT8PROC;
Begin
asm
inc timervar
inc soundvar
inc timecd
{pushf}
end;
TIMERC;
end;


Procedure GETrED;
var i,r,g,b:byte;
Begin
For i:=0 to 255 do Begin
                   {GetRgb(i,r,g,b);}
                   case ((r+g+b) div 3) of

                       0..8:reds^[i]:=32;
                       9..17:reds^[i]:=26;
                       18..26:reds^[i]:=60;
                       27..35:reds^[i]:=34;
                       36..44:reds^[i]:=62;
                       45..54:reds^[i]:=74;
                       55..63:reds^[i]:=77;
                       end;
                   end;
end;
Procedure GETBlu;
var i,r,g,b:byte;
const Blues:array [0..7] of byte = (1,2,6,8,11,50,63,119);
Begin
For i:=0 to 255 do Begin
                   {GetRgb(i,r,g,b);}
                    r:=Vpalette^[i,0];
                    g:=Vpalette^[i,1];
                    b:=Vpalette^[i,2];

                    blus^[i]:=blues[((r+g+b) div 3) shr 3];
                   end;
end;
(*Procedure ReadPcx(Name:string);
Var       FilePcx:File;
           PalReg:array[0..2] of byte;
                i:byte;
            count: smallint;
              BPL: smallint;
             line:array[0..512] of byte;
 b1,data,indic,loop:Byte;
           Posv,k:Word;
              Pos:Longint;
              vs:Word;

{No hace mucha falta explicar que es un proc que setea la paleta en ASM}

Procedure SetRGB(Color,Red,Green,Blue:byte); Assembler;
  asm
mov     DX,$03C8
mov	AL,[Color]
out	DX,AL
inc	DX
mov	AL,[Red]
out	DX,AL
mov	AL,[Green]
out	DX,AL
mov	AL,[Blue]
out	DX,AL
end;

Function SacaVal:byte;
var bqs:byte;
Begin
if vs=513 then Begin
               BLockRead(Filepcx,line[0],513);
               vs:=0;
               end;
Sacaval:=line[vs];
inc(vs);
end;

Begin
     Assign(FilePcx,name);
     Reset(FilePcx,1);
     {Primero leemos la paleta, que al ser un PCX 256c esta anexada al final del archivo}
{ponemos la pos. en el archivo a 128 , los 128 de arriba son el Header.. cosa que
 NO nos interesa, ya sabemos ke es 320x200x256}
     seek (FilePcx, 128);
     Pos:=128;
     PosV:=0;
     vs:=0;
     BLockRead(Filepcx,line[0],513);
     Repeat
     {leemo un byte del archivo}
     data:=Sacaval;
     {nos fijamos si hay compresion}
     if data and $C0 = $C0 Then Begin
                                   {si hay..}
                                   loop:=data and $3F; {cuantos se repite?}
                                   b1:=SacaVal; {CUAL se repite?}
                                   inc (pos,1);
                                   For k:=1 to loop do Begin {Bueh ponemos la cadena de bytes}
                                   Pag2^[0,PosV]:=b1;
                                   inc (PosV); {incrementa el punto donde tamos en video}
                                   end;
                                   end

                                   else Begin
                                   {no.. no hay compresion :(}
                                   Pag2^[0,PosV]:=data;{pone en pantalla el byte ke leiste}
                                   inc(posV); {incrementa el punto donde tamos en video}
                                   end;
     until PosV>63999; {ya terminamos? (320*200=64000}
     Close(FilePcx); {cerramo el archivo..}
end; *)


Procedure boxblue(line:word);
begin
asm
push edi
push esi
mov esi, blus
mov edi, pag2
xor eax,eax
xor ebx,ebx
xor ecx,ecx
Mov ax,line
mov bx,320
mul bx
add edi,eax
Mov cx,64000
sub cx,ax
shr cx,1
xor ax,ax
@repe:
 mov bx, [edi]
 push esi
 mov al,bl
 add esi,eax
 mov dl,[esi]
 pop esi
 push esi
 mov al,bh
 add esi,eax
 mov dh,[esi]
 pop esi
 mov [edi],dx
 add edi,2
loop @repe
pop esi
pop edi
end;

end;

Procedure copyCACA2;
Begin
MOve(PAg2^[0],VirVidBuff^[0],64000);
{asm
push edi
push esi
mov [edi],Pag2
mov [esi],virvidbuff
mov ecx,64000
@kabum:
Cmp Si,8000
JB @nada
Cmp si,30720
JA @nada
xor dx,dx
mov ax,si
mov bx,320
DIV bx
Cmp dx,25
JB @nada
cmp dx,125
JA @Nada
jmp @Menos_todavia
@nada:
mov al,ds:[di]
mov es:[si],al
@Menos_todavia:
inc di
inc si
loop @kabum
pop ds
end;}
end;



Procedure UpdAteVid;
Begin
VidDisplay;
updatepal;
end;


Procedure CopyScr2;
var li,lj:word;
begin
MOve(PAg2^[0],VirVidBuff^[0],64000);

updatevid;
end;


Procedure PutB;

Begin

MOve(bak^[0],Pag2^[0],64000);
end;



Procedure REDSCR;
Begin

end;


Procedure PutBAD(xu,yu:smallint; t,dir:byte);
var i:smallint;
    cond:byte;
    tils:Word;
    sour,des,bye,byt,ye:smallint;
    co:boolean;
begin

if not ((yu+44<0) or (yu>199) or (xu+49<0) or (xu>319)) then begin
if (yu>=0) and (yu+(44)<200) then begin
                             sour:=yu;
                             des:=yu+44;
                             end;
if yu<0 then begin
             {sour:=May[t]-1+yu;}
             sour:=0;
             des:=yu+44;
             end;
if yu+(44)>199 then begin
             sour:=yu;
             des:=199;
             end;

if xu<0 then begin
             bye:=abs(xu);
             byt:=50-bye;
             ye:=0;
             end;
if xu+(49)>319 then begin
             bye:=0;
             byt:=320-xu;
             ye:=xu;
             end;
if (xu>=0) and (xu+(49)<320) then begin
             bye:=0;
             byt:=50;
             ye:=xu;
             end;                                    



if dir=0 then
     for i:=sour to des do MoveN(@bads^[(t*2250+(i-yu)*50+bye+1)],@pag2^[i] [ye],byt)
else   for i:=sour to des do MovesI(@bads^[(t*2250+(i-yu)*50+50-bye)],@pag2^[i] [ye],byt);

end;
end;


Procedure PLacE_ScRolL(Wx,Wy:smallint);
var Dva,i,j:smallint;
    despy:smallint;
    largo:smallint;
Begin

case datos.levtype of
1:Begin
      DVA:=319-(WX  div 2  mod 320);

        wy:=((datos.startX-wy+600) div 8)+58-116;
        if wy>0 then wy:=0;
        if wy<-116 then wy:=-116;
        {max is 116, min is 0}

        despy:=0+wy;
    For I:=0 to 24 do if (despy+i>=0) and (despy+i<200) then
                      begin
                       MOVE(bak^[i,0],Pag2^[despy+i,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[despy+i,0],DVA);
                       end;
    Despy:=74+wy;



    For i:=despy-50 to despy do if (i>=0) and (i<200) then fillchar(pag2^[i,0],320,242);
      DVA:=319-(WX  div 4 mod 320);
    For I:=25 to 56 do if (despy+i-25>=0) and (despy+i-25<200) then Begin
                       MOVE(bak^[i,0],Pag2^[despy+i-25,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[despy+i-25,0],DVA);
                       end;
    despy:=156+wy;
    For i:=despy-50 to despy do if (i>=0) and (i<200) then  fillchar(pag2^[i,0],320,242);


      DVA:=319-(WX  div 6 mod 320);
    For I:=57 to 70 do if (despy+i-57>=0) and (despy+i-57<200) then Begin
                       MOVE(bak^[i,0],Pag2^[despy+i-57,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[despy+i-57,0],DVA);
                       end;
    despy:=221+wy;
      DVA:=319-(WX  div 10 mod 320);

        For i:=despy-51 to despy do if i in [0..199] then  fillchar(pag2^[i,0],320,242);

        For I:=71 to 126 do if (despy+i-91>=0) and (despy+i-91<200) then Begin
                       MOVE(bak^[i,0],Pag2^[despy+i-91,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[despy+i-91,0],DVA);
                       end;
    despy:=245+wy;
      DVA:=319-(WX  div 7 mod 320);

        For I:=127 to 164 do if (despy+i-127>=0) and (despy+i-127<200) then Begin
                       MOVEN(@bak^[i,0],@Pag2^[despy+i-127,DVA],320-DVA);
                       MOVEN(@bak^[i,320-dva],@Pag2^[despy+i-127,0],DVA);
                       end;

      DVA:=319-(WX  div 6 mod 320);
          despy:=282+wy;

        For I:=165 to 171 do if (despy+i-165>=0) and (despy+i-165<200) then Begin
                       MOVE(bak^[i,0],Pag2^[despy+i-165,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[despy+i-165,0],DVA);
                       end;
      DVA:=319-(WX  div 4 mod 320);
          despy:=289+wy;

        For I:=172 to 182 do if (despy+i-172>=0) and (despy+i-172<200) then Begin
                       MOVE(bak^[i,0],Pag2^[despy+i-172,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[despy+i-172,0],DVA);
                       end;
      DVA:=319-(WX  div 2 mod 320);
          despy:=300+wy;

        For I:=183 to 199 do if (despy+i-183>=0) and (despy+i-183<200) then Begin
                       MOVE(bak^[i,0],Pag2^[despy+i-183,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[despy+i-183,0],DVA);
                       end;

    end;

2:begin    For I:=0 to 115 do MOVE(bak^[i,0],Pag2^[i,0],320);
  despy:=80+((datos.startX-wy) div 20);
  if despy<0 then despy:=0;
  if despy>0 then Fillchar(pag2^[0,0],320*despy,bak^[0,3]);
  DVA:=320-(WX div 8 mod 320);
  For i:=0 to 124 do if i+despy<200 then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;
  For i:=125 to 199 do if i+despy<200 then Begin
                       DVA:=319-(round(WX/(2+((74-(i-125))*4/74))) mod 320);
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;
  end;


3:begin
{  For I:=0 to 100 do MOVE(bak^[i,0],Pag2^[i,0],320);}
{ilia}
  despy:=((datos.startY-wy) div 10)-80;

DVA:=320-((WX+clk2) div 4 mod 320);

if (despy>0) then Fillchar(pag2^[0,0],(despy)*320,111);

  For I:=0 to 53 do if (i+despy<200) and (I+despy>=0) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;
  For I:=54 to 154 do if (i+despy<200) and (I+despy>=0) then Begin
                       Fillchar(pag2^[i+despy,0],320,128);
                       end;
  inc(despy,100);
  For I:=54 to 108 do if (i+despy<200) and (i+despy>=0) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;
  For I:=108 to 138 do if (i+despy<200) and (I+despy>=0) then Begin
                       Fillchar(pag2^[i+despy,0],320,111);
                       end;
  inc(despy,30);

   DVA:=320-(WX div 6 mod 320);
  For I:=109 to 199 do if (i+despy<200) and (I+despy>=0) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;
  end;

4:Begin
  For I:=0 to 100 do MOVE(bak^[i,0],Pag2^[i,0],320);
  DVA:=320-(WX div 8 mod 320);
  despy:=23+((1356-wy) div 20);
  if despy in [0..180] then Fillchar(pag2^[0,0],320*(despy+20),119);
  if (Despy+84) in [0..199] then Fillchar(Pag2^[Despy+84,0],(199-(Despy+84))*320,1);

  DVA:=320-(WX div 16 mod 320);
  For I:=20 to 73 do if ((i+despy)<200) and ((i+despy)>0) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;
  DVA:=320-(WX div 8 mod 320);
  For I:=168 to 199 do if ((i+despy-94)<200) and ((i+despy-94)>0) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy-94,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy-94,0],DVA);
                       end;
  DVA:=320-(WX div 10 mod 320);
  For I:=0 to 19 do if ((i+despy+54)<200) and ((i+despy+54)>0) then Begin
                       MOVEN(@bak^[i,0],@Pag2^[i+despy+54,DVA],320-DVA);
                       MOVEN(@bak^[i,320-dva],@Pag2^[i+despy+54,0],DVA);
                       end;
  Largo:=1365-(WY+74+Despy);
  If Largo>94 then largo:=94;
  If largo<-94 then Largo:=-94;
  If Largo>0 Then For i:=1 to Largo Do
                if ((i+despy+72)<200) and ((i+despy+72)>0) then begin
                                 J:=ROund(i*94/Largo);
                                 DVA:=320-(WX Div 10+Round(J*(Wx-Wx/10)/94) ) mod 320;

                       MOVE(bak^[j+72,0],Pag2^[72+i+despy,DVA],320-DVA);
                       MOVE(bak^[j+72,320-dva],Pag2^[72+i+despy,0],DVA);
                       end;
  If Largo<0 Then For i:=-1 downto largo Do
                if ((i+despy+72)<200) and ((i+despy+72)>0) then begin
                                 J:=ROund(i*94/Largo);
                                 DVA:=320-(WX Div 10+Round(J*(Wx-Wx/10)/94)) mod 320;

                       MOVE(bak^[j+72,0],Pag2^[72+i+despy,DVA],320-DVA);
                       MOVE(bak^[j+72,320-dva],Pag2^[72+i+despy,0],DVA);
                       end;






end;

6:Begin
    DVA:=319-(clk2 mod 640 div 2);
    For I:=0 to 135 do Begin
                       MOVE(bak^[i,0],Pag2^[i,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i,0],DVA);
                       end;
     fillchar(pag2^[136,0],64*320,128);

    DVA:=319-(clk2 mod 20 *16);

    despy:=1102-WY;
    if despy<0 then despy:=0;
    For I:=136 to 163 do if despy+(i-136)<200 then Begin
                       MOVEN(@bak^[i,0],@Pag2^[despy+(i-136),DVA],320-DVA);
                       MOVEN(@bak^[i,320-dva],@Pag2^[despy+(i-136),0],DVA);
                       end;

   for j:=0 to 5 do
    For I:=163 to 187 do if despy+(i-163)+j*24+27<200 then Begin
                       MOVEN(@bak^[i,0],@Pag2^[despy+(i-163)+j*24+27,DVA],320-DVA);
                       MOVEN(@bak^[i,320-dva],@Pag2^[despy+(i-163)+j*24+27,0],DVA);
                       end;
    For I:=188 to 199 do if despy+(i-188)+147<200 then  Begin
                       MOVEN(@bak^[i,0],@Pag2^[despy+(i-188)+147,DVA],320-DVA);
                       MOVEN(@bak^[i,320-dva],@Pag2^[despy+(i-188)+147,0],DVA);
                       end;

  end;
7:begin
  For I:=0 to 100 do MOVE(bak^[i,0],Pag2^[i,0],320);
  DVA:=320-(WX div 8 mod 320);
  despy:=80+((datos.startX-wy) div 20);
  if despy<0 then despy:=0;
  if despy>0 then Fillchar(pag2^[101,0],320*despy,242);
  For I:=101 to 150 do if (i+despy<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;
   DVA:=320-(WX div 6 mod 320);
  For I:=151 to 161 do if (i+despy<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;

   DVA:=320-(WX div 4 mod 320);
  For I:=162 to 173 do if (i+despy<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;

   DVA:=320-(WX div 2 mod 320);
  For I:=174 to 199 do if (i+despy<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;

  end;
8,9,5,12,14:Begin
    DVA:=319-(WX div 6 mod 320);
    despy:=199-(Wy div 6 mod 200);
  For I:=0 to despy do  Begin
                       MOVE(bak^[200-despy+i,0],Pag2^[i,DVA],320-DVA);
                       MOVE(bak^[200-despy+i,320-dva],Pag2^[i,0],DVA);
                       end;
  For I:=despy to 199 do  Begin

                       MOVE(bak^[i-despy,0],Pag2^[i,DVA],320-DVA);
                       MOVE(bak^[i-despy,320-dva],Pag2^[i,0],DVA);
                       end;
  end;
15:;
10:begin
{  For I:=0 to 150 do MOVE(bak^[i,0],Pag2^[i,0],320);}
{  DVA:=320-(WX div 8 mod 320);}
  For I:=0 to 150 do  Begin
                       DVA:=320-(WX div (I div 7+3) mod 320);
                       MOVE(bak^[i,0],Pag2^[i,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i,0],DVA);
                       end;
   despy:=0;
   DVA:=320-(WX div 6 mod 320);
  For I:=151 to 161 do if (i+despy<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;

   DVA:=320-(WX div 4 mod 320);
  For I:=162 to 173 do if (i+despy<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;

   DVA:=320-(WX div 2 mod 320);
  For I:=174 to 199 do if (i+despy<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i+despy,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i+despy,0],DVA);
                       end;

  end;
11:Begin
   DVA:=320-(WX div 4 mod 320);
  For I:=0 to 23 do if (i<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i,0],DVA);
                       end;
   DVA:=320-(WX div 5 mod 320);
  For I:=24 to 50 do if (i<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i,0],DVA);
                       end;
   DVA:=320-(WX div 8 mod 320);
  For I:=51 to 67 do if (i<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i,0],DVA);
                       end;
   DVA:=320-(WX div 6 mod 320);
  For I:=68 to 138 do if (i<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i,0],DVA);
                       end;
   DVA:=320-(WX div 5 mod 320);
  For I:=139 to 199 do if (i<200) then Begin
                       MOVE(bak^[i,0],Pag2^[i,DVA],320-DVA);
                       MOVE(bak^[i,320-dva],Pag2^[i,0],DVA);
                       end;

end;
13:Begin
   putb;
  wx:=wx+2500;
  wy:=wy+2500;

    for i:=9 downto 1 do Begin
wx:=wx+muslev[i]*20;
wy:=wy-muslev[i]*20;
if i<7 then j:=i else j:=i+1;
          {320-(WX Div 10+Round(J*(Wx-Wx/10)/94) ) mod 320;}
putbad(320-(WX Div 13+(Round((10-i)*(Wx-Wx/20)/9)) div 2) mod 420
      ,200-(Wy Div 13+(Round((10-i)*(Wy-Wy/20)/9)) div 3) mod 250,j-1,0);
if i=6 then putbad(370-(WX Div 13+(Round((10-i)*(Wx-Wx/20)/9)) div 2) mod 420
      ,200-(Wy Div 13+(Round((10-i)*(Wy-Wy/20)/9)) div 3) mod 250,6,0);

wx:=wx-muslev[i]*20;
wy:=wy+muslev[i]*20;

   end;
   end;
else putb;
end;
end;

Procedure PUTLETRA(Xi,Yi:word; N:byte);
var i:byte;
BEGIN
For I:=0 to 6 do MoveN(@letras^[56*N+I*8],@PAG2^[Yi+I,Xi],7);
end;

Procedure PUTLETRAV(Xi,Yi:word; N:byte);
var i:byte;
    vidptr:Pointer;
BEGIN

For I:=0 to 6 do Begin
                 MoveN(@letras^[56*N+I*8],@VirVidBuff^[(320*(Yi+i))+xi],7);
                 end;
end;

Procedure MSG(x,y:Word; MsA:string);
var i:byte;
Begin
For i:=1 to length (msa) do case ord(upcase(mSa[i])) of
                              65..90:Putletra(X+(i*8),y,ord(upcase(mSa[i]))-65+10);
                              48..58:Putletra(X+(i*8),y,ord(upcase(mSa[i]))-48);
                              end;
end;
Procedure MSGV(x,y:Word; MsA:string);
var i:byte;
Begin
For i:=1 to length (msa) do case ord(upcase(mSa[i])) of
                              65..90:Putletrav(X+(i*8),y,ord(upcase(mSa[i]))-65+10);
                              48..58:Putletrav(X+(i*8),y,ord(upcase(mSa[i]))-48);
                              end;
end;


Function Joyst.right : Boolean;
Begin

end;

Function Joyst.left : Boolean;
Begin

end;


Procedure LLuvia;
var I,J:word;
Begin
For I:=1 to 50 do begin
j:=Random(63679);
case clk2 mod 1200 of
0..299:Begin
            pag2^[0,j]:=100;
            Pag2^[0,j+319]:=100;
       end;
300..599,900..1199:Begin
         pag2^[0,j]:=100;
         Pag2^[0,j+320]:=100;
         end;
600..899:Begin
         pag2^[0,j]:=100;
         Pag2^[0,j+321]:=100;
         end;
end;


end;
end;


Procedure Nieve;
var segm,des:word;
     col:byte;
     num,num2:shortint;
Begin
          num:=(OldX-WX);
          num2:=(OldY-wY);
    for CurFlake:= 1 to flakes do with flake[curflake] do
    begin
      Perturb(r);
      If x>=lo(r) then Inc(p);
      If y>=Hi(r) then Inc(p,320);
      if num>0 then inc (p,round(num*(y/255)));
      if num<0 then dec (p,round(abs(num)*(y/255)));
      if num2>0 then inc (p,320*round(num2*(y/255)));
      if num2<0 then dec (p,320*round(abs(num2)*(y/255)));
      col:=y shr 5;
      case col of
       2..3:col:=184;
       4..5:col:=186;
       6:col:=252;
       7:col:=248;
       end;

      if (y SHR 5>1) and (p<64000) then Pag2^[0,p]:=col;
    end;

end;
Procedure Nieve2;
var segm,des:word;
     col:byte;
     num,num2:shortint;
Begin
          num:=(OldX2-X2);
          num2:=(OldY2-Y2);
    for CurFlake:= 1 to flakes do with flake2[curflake] do
    begin
      Perturb(r);
      If x>=lo(r) then Inc(p);
      If y>=Hi(r) then Inc(p,320);
      if num>0 then inc (p,round(num*(y/255)));
      if num<0 then dec (p,round(abs(num)*(y/255)));
      if num2>0 then inc (p,320*round(num2*(y/255)));
      if num2<0 then dec (p,320*round(abs(num2)*(y/255)));
      col:=y shr 5;
      case col of
       2..3:col:=184;
       4..5:col:=186;
       6:col:=252;
       7:col:=248;
       end;

      if (y SHR 5>1) and (p<64000) then PAg2^[0,p]:=col;
    end;

end;


{Procedure PutThing(xu,yu:smallint; t:byte);}


Procedure PutThing(xu,yu:smallint; t:byte);
var i:smallint;
    cond:byte;
    tils:Word;
    sour,des,bye,byt,ye:smallint;
    co:boolean;
begin

case datos.levtype of
 1:Begin
   case t of
   31,32:t:=31+clk mod 4 div 2;
   end;
   end;
 4:Case t of
   45,44:t:=44+clk mod 6 div 3;
   end;
 5:Begin
   case t of
   51: if clk mod 4 >1 then inc(t);
   44: case clk mod 16 of
       1:t:=45;
       2:t:=46;
       3:t:=47;
       end;
   end;
   end;
 6:begin
   if not inside then
    case t of
    13:t:=12;
    26..28,33,36,51:t:=7;
    29,34,31:t:=6;
    30,35,32:t:=8;
    end;
   if t=21 then if clk mod 4>1 then t:=22;
   end;

 7:begin
    if (t=36) or (t=38) then if clk mod 4>1 then inc(t);
    end;
  8:if t in[35,36] then t:=35+clk mod 4 div 2;

 9:if clk mod 4 <2 then begin
   if (t in [22..30]) or (t in [34..39]) or (t=50) or (t=58) then inc(t);
   if t=60 then t:=62;
   end;

11:if t in [44,45] then t:=44+clk mod 4 div 2;
12:case t of
   27..29:T:=27+clk mod 6 div 2;
   43..45:T:=43+clk mod 6 div 2;
   55..58:T:=55+clk mod 8 div 2;
   59..62:T:=59+clk mod 8 div 2;
   end;
13:case t of
   55..63:T:=55+clk mod 16 div 2;
   43..47:T:=43+clk mod 10 div 2;
   end;


 end;


if not ((yu+24<0) or (yu>199) or (xu+24<0) or (xu>319)) then begin
if (yu>=0) and (yu+(24)<200) then begin
                             sour:=yu;
                             des:=yu+24;
                             end;
{if (t=48) and (resor>0) and (clk mod 4>1) then inc(t);}
if yu<0 then begin


             {sour:=May[t]-1+yu;}
             sour:=0;
             des:=yu+24;
             end;
if yu+(24)>199 then begin
             sour:=yu;
             des:=199;
             end;

if xu<0 then begin
             bye:=abs(xu);
             byt:=25-bye;
             ye:=0;
             end;
if xu+(24)>319 then begin
             bye:=0;
             byt:=320-xu;
             ye:=xu;
             end;
if (xu>=0) and (xu+(24)<320) then begin
             bye:=0;
             byt:=25;
             ye:=xu;
             end;

asm
push edi
push esi
mov esi,tiles
xor eax,eax
xor ebx,ebx
xor ecx,ecx
xor edx,edx
mov bx,sour {bx va a hacer de I en el for}
{start}
mov al,t
mov dx,625
mul dx
add ax,bye
add esi,eax
{pone SI en el inicio del tile a copiar+ en ke byte lo copio}
mov edi,pag2
xor eax,eax
mov ax,320
mul sour
add ax,ye
add edi,eax
{pone DI al inicio de donde lo pongo en video}
@Loop1:
xor eax,eax
mov cx,byt {Cx=Cuantos copio}
mov ax,bx
sub ax,yu
mov dx,25
mul dx
push edi
push esi
and eax,1111111111111111b
add esi,eax
{le agrego una linea si paso de linea..}
@loop2:
mov al,[esi]
cmp al,0
je @nocopy
mov [edi],al
@nocopy:
inc esi
inc edi
loop @loop2                 
pop esi
pop edi
add edi,320
inc bx
cmp bx,des
jle @loop1
pop esi
pop edi
end;

{for i:=sour to des do MoveN(@tiles^[(t*625+(i-yu)*25+bye)],@pag2^[i] [ye],byt);}

end;
end;

Procedure ard_rec.PUTSQ(xu,yu:smallint; t:byte);
var i:smallint;
    cond:byte;
    tils:Word;
    sour,des,bye,byt,ye:smallint;
    co:boolean;
    rd1:pointer;
    ez:byte;
begin
if ftime=0 then Begin
yu:=yu+1;
if not ((yu+37<0) or (yu>199) or (xu+40<0) or (xu>319)) then begin
ez:=red;
if (yu>=0) and (yu+(37)<200) then begin
                             sour:=yu;
                             des:=yu+37;
                             end;
if yu<0 then begin
             {sour:=May[t]-1+yu;}
             sour:=0;
             des:=yu+37;
             end;
if yu+(37)>199 then begin
             sour:=yu;
             des:=199;
             end;

if xu<0 then begin
             bye:=abs(xu);
             byt:=41-bye;
             ye:=0;
             end;
if xu+(40)>319 then begin
             bye:=0;
             byt:=320-xu;
             ye:=xu;
             end;
if (xu>=0) and (xu+(40)<320) then begin
             bye:=0;
             byt:=41;
             ye:=xu;
             end;


if dir then for i:=sour to des do MoveN(@ard^[(t*1558+(i-yu)*41+bye)],@pag2^[i] [ye],byt)
        else for i:=sour to des do MovesI(@ard^[(t*1558+(i-yu)*41+40-bye)],@pag2^[i] [ye],byt);
(*asm
push edi
push esi
mov esi,reds
mov rd1,esi
mov esi,ard
xor eax,eax
xor ebx,ebx
xor ecx,ecx
xor edx,edx
mov bx,sour {bx va a hacer de I en el for}
{start}
xor ah,ah
mov al,t
mov dx,1558
mul dx
add ax,bye
add esi,eax

{pone SI en el inicio del tile a copiar+ en ke byte lo copio}
mov edi,pag2
mov ax,320
mul sour
add ax,ye
add edi,eax
{pone DI al inicio de donde lo pongo en video}
@Loop1:
xor eax,eax
xor ebx,ebx
mov cx,byt {Cx=Cuantos copio}
mov ax,bx
sub ax,yu
mov dx,41
mul dx
push edi
push esi
add esi,eax
{le agrego una linea si paso de linea..}
@loop2:
mov al,[esi]
cmp al,0
je @nocopy
{uh}
push esi
mov esi,rd1
xor eax,eax
add esi,eax
mov al,[esi]
mov [edi],al
pop esi
mov dl,ez
cmp dl,0
je @nr
push esi
mov al,[edi]
mov esi,rd1
xor eax,eax
add esi,eax
mov al,[esi]
mov [edi],al
pop esi
jmp @nocopy
@nr:
mov [edi],al
@nocopy:
inc esi
inc edi
loop @loop2
pop esi
pop edi
add edi,320
inc bx
cmp bx,des
jle @loop1
pop esi
pop edi
end*) {else for i:=sour to des do MoveI(@ard^[(t*1558+(i-yu)*41+bye)],@pag2^[i] [ye],byt);}
(*
asm
push ds
les si,reds
mov rd1,es
mov rd2,si
les si,ard
mov bx,sour {bx va a hacer de I en el for}
{start}
xor ah,ah
mov al,t
mov dx,1558
mul dx
add ax,41
sub ax,bye
add si,ax
dec si
{pone SI en el inicio del tile a copiar+ en ke byte lo copio}
lds di,pag2
mov ax,320
mul sour
add ax,ye
add di,ax
{pone DI al inicio de donde lo pongo en video}
@Loop1:
mov cx,byt {Cx=Cuantos copio}
mov ax,bx
sub ax,yu
mov dx,41
mul dx
push di
push si
add si,ax
{le agrego una linea si paso de linea..}
@loop2:
mov al,es:[si]
cmp al,0
je @nocopy
{uh}
push es
push si
mov es,rd1
mov si,rd2
xor ah,ah
add si,ax
mov al,es:[si]
mov ds:[di],al
pop si
pop es  para que sea roja}
mov dl,ez
cmp dl,0
je @nr
push es
push si
mov al,ds:[di]
mov es,rd1
mov si,rd2
xor ah,ah
add si,ax
mov al,es:[si]
mov ds:[di],al
pop si
pop es
jmp @nocopy
@nr:
mov ds:[di],al
@nocopy:
dec si
inc di
loop @loop2
pop si
pop di
add di,320
inc bx
cmp bx,des
jle @loop1
pop ds
end; *)
end;
end;
end;
(*Procedure ard_rec.PUTSQ(xu,yu:smallint; t:byte);
var i:smallint;
    cond:byte;
    tils:Word;
    sour,des,bye,byt,ye:smallint;
    co:boolean;
begin
yu:=yu+1;
if not ((yu+37<0) or (yu>199) or (xu+40<0) or (xu>319)) then begin
if (yu>=0) and (yu+(37)<200) then begin
                             sour:=yu;
                             des:=yu+37;
                             end;
if yu<0 then begin
             {sour:=May[t]-1+yu;}
             sour:=0;
             des:=yu+37;
             end;
if yu+(37)>199 then begin
             sour:=yu;
             des:=199;
             end;

if xu<0 then begin
             bye:=abs(xu);
             byt:=41-bye;
             ye:=0;
             end;
if xu+(40)>319 then begin
             bye:=0;
             byt:=320-xu;
             ye:=xu;
             end;
if (xu>=0) and (xu+(40)<320) then begin
             bye:=0;
             byt:=41;
             ye:=xu;
             end;


{if (xu>=0) and (xu+(max[t]-1)<320) {and (yu>=0) and (yu+(may[t]-1)<200)then co:=true
                                                                       else co:=false;

                                                                                                }

if dir then
asm
push ds
les si,ard

mov bx,sour {bx va a hacer de I en el for}
{start}
xor ah,ah
mov al,t
mov dx,1558
mul dx
add ax,bye
add si,ax

{pone SI en el inicio del tile a copiar+ en ke byte lo copio}
lds di,pag2
mov ax,320
mul sour
add ax,ye
add di,ax
{pone DI al inicio de donde lo pongo en video}
@Loop1:
mov cx,byt {Cx=Cuantos copio}
mov ax,bx
sub ax,yu
mov dx,41
mul dx
push di
push si
add si,ax
{le agrego una linea si paso de linea..}
@loop2:
mov al,es:[si]
cmp al,0
je @nocopy
mov ds:[di],al
@nocopy:
inc si
inc di
loop @loop2
pop si
pop di
add di,320
inc bx
cmp bx,des
jle @loop1
pop ds
end else
asm
push ds
les si,ard

mov bx,sour {bx va a hacer de I en el for}
{start}
xor ah,ah
mov al,t
mov dx,1558
mul dx
add ax,41
sub ax,bye
add si,ax
dec si
{pone SI en el inicio del tile a copiar+ en ke byte lo copio}
lds di,pag2
mov ax,320
mul sour
add ax,ye
add di,ax
{pone DI al inicio de donde lo pongo en video}
@Loop1:
mov cx,byt {Cx=Cuantos copio}
mov ax,bx
sub ax,yu
mov dx,41
mul dx
push di
push si
add si,ax
{le agrego una linea si paso de linea..}
@loop2:
mov al,es:[si]
cmp al,0
je @nocopy
mov ds:[di],al
@nocopy:
dec si
inc di
loop @loop2
pop si
pop di
add di,320
inc bx
cmp bx,des
jle @loop1
pop ds
end;
end;
end; *)

Procedure PutThingV(xu,yu:smallint; t:byte);
var i:smallint;
    cond:byte;
    tils:Word;
    sour,des,bye,byt,ye:smallint;
    co:boolean;
begin
if not ((yu+24<0) or (yu>199) or (xu+24<0) or (xu>319)) then begin
dec(t);
if t=0 then if Random(20)=1 then t:=1;
if t=22 then case clk mod 8 div 2 of
             0:t:=21;
             1,3:t:=22;
             2:t:=23;
             end;



if (yu>=0) and (yu+(24)<200) then begin
                             sour:=yu;
                             des:=yu+24;
                             end;
if yu<0 then begin
             {sour:=May[t]-1+yu;}
             sour:=0;
             des:=yu+24;
             end;
if yu+(24)>199 then begin
             sour:=yu;
             des:=199;
             end;

if xu<0 then begin
             bye:=abs(xu);
             byt:=25-bye;
             ye:=0;
             end;
if xu+(24)>319 then begin
             bye:=0;
             byt:=320-xu;
             ye:=xu;
             end;
if (xu>=0) and (xu+(24)<320) then begin
             bye:=0;
             byt:=25;
             ye:=xu;
             end;


for i:=sour to des do MoveN(@tilesv^[(t*625+(i-yu)*25+bye)],@pag2^[i] [ye],byt);

end;
end;


Procedure PLAYFX(cual:byte);
var p:pointer;
    sm,dp:word;
Begin

	music_play_sndfx(cual);
end;


Function FINDZERO : byte;
var i:byte;
    zf:boolean;
Begin
zf:=false;
i:=1;
Repeat
if vectobj[i].t=0 then
    Begin
         zf:=true;
         FINDZERO:=i;
         i:=used;

    end;
inc(i);
until i>used;
if not Zf then Begin
               if used<150 then inc (used);
               vectobj[used].t:=0;
               findzero:=used;
               end;
end;

function NEWV(X,Y:Word; V:byte) :byte;
var Z:byte;
Begin
if v=110 then playfx(7);
z:=findzero;
vectobj[z].t:=v;
vectobj[z].x:=x;
vectobj[z].y:=Y;
newv:=z;
end;

Function FINDZEROB : byte;
var i:byte;
    zf:boolean;
Begin
zf:=false;
i:=1;
Repeat
if bguys[i].classb=0 then
    Begin
         zf:=true;
         FINDZEROB:=i;
         i:=bgused;

    end;
inc(i);
until i>bgused;
if not Zf then Begin
               if bgused<150 then Begin
               inc (bgused);
                bguys[bgused].classb:=0;
               findzeroB:=bgused;
               end else findzerob:=0;
               end;
end;

function NEWB(X,Y:Word; V,dir:byte) : byte;
var Z:byte;
Begin
z:=findzeroB;
if z <> 0 then begin
bguys[z].classb:=v;
bguys[z].estado:=0;
bguys[z].dir:=dir;
bguys[z].x:=x;
bguys[z].y:=Y;
newb:=z;
end else newb:=2;

end;

ProceDure ChEckB;
var i,j,k:Byte;
Begin
For i:=1 to BGuSeD do
with Bguys[i] do Begin
CaSe classb of
1:Begin {Pajarito}
    for j:=1 to players do Begin
    If (estado=0) and (X-400<ardilla[j].X) and (X>ardilla[j].X)
       and (Y-110<ardilla[j].Y) and (Y+110>ardilla[j].Y)  then estado:=1;
    if (X<ardilla[j].X) and (nukunit.wX>X+50) and (estado>0) then classb:=0;
    if (Y-110<ardilla[j].Y) and (Y+110>ardilla[j].Y) and (Abs((X-ardilla[j].X)-(ardilla[j].Y-Y))<20) then estado:=3;
    end;
    if estado>0 then Dec(x,5);
    if estado>1 then inc(y,5);
  end;

2:Begin {Muniekito de nieve}
     if  not at1(Scene^[(X+15) DIV 25,(Y+25) DIV 25]) and (estado in [3..18]) then Begin
                                                          inc(Y,estado-2);
                                                          if estado<18 then inc(estado);
                                                          end;
     if at1(Scene^[(X+15) DIV 25,(Y+25) DIV 25]) then Begin
                                                      Y:=((Y+25) div 25 * 25)-25;
                                                      estado:=0;
                                                      end
                                                      else if estado <3 then estado:=3;

     For j:=1 to players do Begin
     if (Y-100<ardilla[j].Y) and (Y+100>ardilla[j].Y) then begin
     if (estado in [0..2]) and (X-15<ardilla[j].X) and (X+40>ardilla[j].X) then estado:=120;
     if (estado in [0..2]) and (X-100<ardilla[j].X) and (X+135>ardilla[j].X) then if ardilla[j].X<x+15
                                                                                  then estado:=1
                                                                             else estado:=2;
     end;
     end;
     if Estado in [100..120] then Begin Dec(Y,estado-98);
                                        Dec(estado);
                                        if estado=99 then estado:=3;
                                        end;
     if estado = 1 then Begin
                        dir:=0;
                        if at1(Scene^[(X+12) DIV 25,(Y+25) DIV 25]) then Dec(x,3);
                        end;
     if estado = 2 then Begin
                        if at1(Scene^[(X+18) DIV 25,(Y+25) DIV 25]) then inc(x,3);
                       Dir:=1;
                        end;
     end;

3:Begin {Bola De nieve}
             if estado=0 then Begin
                              dir:=Y div 25;
                              estado:=1;
                              end;
             inc(Y,6);
             if Y-dir*25>470  then Begin
                                                             y:=dir*25;
                                                             estado:=0;
                                                             end;
        end;

4:Begin { EsCuPee}
     if  not at1(Scene^[(X+15) DIV 25,(Y+25) DIV 25]) and (estado in [3..18]) then Begin
                                                          inc(Y,estado-2);
                                                          if estado<18 then inc(estado);
                                                          end;
     if at1(Scene^[(X+15) DIV 25,(Y+25) DIV 25]) then Begin
                                                      Y:=((Y+25) div 25 * 25)-25;
                                                      estado:=0;
                                                      end
                                                      else if estado <3 then estado:=3;

     For j:=1 to players do Begin
     if (Y-100<ardilla[j].Y) and (Y+100>ardilla[j].Y) then begin
     if (estado in [0..2,20..21]) and (X-100<ardilla[j].X) and (X+135>ardilla[j].X) then if ardilla[j].X<x+15
                                                                                  then estado:=1
                                                                                  else estado:=2;

     if (estado in [0..2,20..21]) and (X-50<ardilla[j].X) and (X+85>ardilla[j].X) then if ardilla[j].X<x+15
                                                                                  then estado:=20
                                                                                  else estado:=21;
     end;
     end;
     if estado = 1 then Begin
                        dir:=0;
                        if at1(Scene^[(X+12) DIV 25,(Y+25) DIV 25]) then Begin

                                                                         Dec(x,3);
                                                                         end
                        end;
     if estado = 2 then Begin
                        if at1(Scene^[(X+18) DIV 25,(Y+25) DIV 25]) then inc(x,3);
                        Dir:=1;
                        end;

     if estado = 20 then Begin
                        dir:=0;
                        if clk mod 20 = 1 then Begin
                                          newB(X,Y-10,5,dir);
                                                playfx(5);
                                                          end;
                        end;
     if estado = 21 then Begin
                        dir:=1;
                        if clk mod 20 = 1 then Begin
                                      newB(X,Y-10,5,dir);
                                      playfx(5);
                                      end;

                        end;


   end;
5:Begin {escipida}
  if (estado>128) or at1(Scene^[(X+5) DIV 25,(Y+8) DIV 25]) or
  (x<20) or (x>12500) then begin
                     estado:=0;
                     classb:=0;
                     end;
  if dir=0 then dec(X,8)
           else inc(x,8);

    if clk mod 2 =1 then begin
    INc(estado);
    if (estado<18) then  inc(y,estado)
                else inc(y,18);
    end;

  end;

6:Begin {Malvado dios!}
    For j:=1 to players do if (ardilla[j].X<X+250) and (ardilla[j].X>X-250) and
            (ardilla[j].y-20<y+180)  and (ardilla[j].y-20>y-180) then
                                    if (ardilla[j].x>X) then Begin
                                                             inc(X,1);
                                                             dir:=1;
                                                             end
                                                             else if (ardilla[j].x<>X) then begin
                                                                                            dec (x,1);
                                                                                            dir:=0;
                                                                                            end;


       if estado>0 then dec(estado);
       if estado=0 then begin
         For j:=1 to players do if (Abs((X-ardilla[j].X)-(ardilla[j].Y-Y))<20) then Begin
                                                                                    newb(x,y,7,0);
                                                                                    estado:=20;
                                                                                    end;
         For j:=1 to players do if (Abs((ardilla[j].X-x)-(ardilla[j].Y-Y))<20) then Begin
                                                                                    newb(x+25,y,7,1);
                                                                                    estado:=20;
                                                                                    end
        end;
   end;
  7:Begin {Rayito}
           if estado=0 then estado:=1;
           if estado=1 then begin
                            if dir = 0 then DEC(x,8) else inc(x,8);
                            inc(y,8);
                            end;
           if ((estado=1) and at1(Scene^[(X) DIV 25,(Y) DIV 25])) or (X<20) or (x>12500) or (y>3000) then begin
                                                         newv(X,Y,110);
                                                         classb:=0;
                                                         end;
      end;

  9:begin {caminante}
         if not at1(Scene^[(X+25) DIV 25,(Y+45) DIV 25]) then begin
                                                              inc(Y);
                                                              estado:=1
                                                              end else estado:=0;

         if estado=0 then If at1(Scene^[(X+25) DIV 25,(Y+45) DIV 25]) then begin
                   if dir=0 then if at1(Scene^[(X+21) DIV 25,(Y+45) DIV 25]) then Dec(x,4)
                                                                                       else dir:=1;
                   if dir=1 then if at1(Scene^[(X+29) DIV 25,(Y+45) DIV 25]) then inc(x,4)
                                                                                       else dir:=0;
                                                                           end;


                     end;
  10:Begin {pecesitu!}
          if (clk+y+random(10)) mod 10 =1 then if estado=0 then estado:=20;
     {     if clk mod 2=1 then} begin
          if estado>0 then dec(estado);

          if estado in [1..20] then dec(y,estado);
          if estado in [21..40] then inc(y,41-estado);
          end;
          if (estado=19) or (estado=23) then  newv(X,Y+25,211);

          if estado=1 then estado:=40;
          if estado=21 then begin
                            estado:=0;
                            dec(y,19)
                            end;


     end;
  11,28:Begin {bichomoscardon}
     k:=0;
     For j:=1 to players do if (ardilla[j].X<X+200) and (ardilla[j].X>X-200) and
                               (ardilla[j].y-20<y+200)  and (ardilla[j].y-20>y-200) then begin
                   if dista(x,y,ardilla[j].x,ardilla[j].y)>=dista(x,y,ardilla[3-j].x,ardilla[3-j].y) then k:=3-j else k:=j;
                               end;

                               if k>0 then Begin
                               if players=1 then k:=1;
                               if (ardilla[k].X<X+20) then dec(X,4);
                               if (ardilla[k].X>X+20) then inc(X,4);
                               if (ardilla[k].y-50<y) then dec(y,4);
                               if (ardilla[k].y-50>y) then inc(y,4);
                               if (ardilla[k].x>x+20) then dir:=1
                                                      else dir:=0;

                               end;

     end;
  12:Begin { ? ? ? ? ? ? ? ? }
          if estado=0 then For j:=1 to players do if (ardilla[j].y<y+90) and (ardilla[j].y>y-50)
                                                  and (ardilla[j].x<x+90) and (ardilla[j].x>x-50) then estado:=1;
          if estado>0 then inc(Estado);
          if estado=7 then estado:=0;

     end;
  13:Begin {flecha que CAE}
           dir:=0;
           if estado=0 then For j:=1 to players do if (Abs((X-ardilla[j].X)-(ardilla[j].Y-Y))<20) then estado:=1;
           if estado=1 then begin
                            DEC(x,8);
                            inc(y,8);
                            end;
           if ((estado=1) and at1(Scene^[(X) DIV 25,(Y+54) DIV 25])) or (x<20) or  ( y>3000)then begin
                                                          Y:=((Y+54) div 25 * 25)-45;
                                                         estado:=2;
                                                         end;
           if estado>1 then inc(estado);
           if estado=50 then classb:=0;
      end;

  14:Begin  {flechaVUELA!}
          if estado=0 then For j:=1 to players do if (ardilla[j].y<y+90) and (ardilla[j].y>y-90)
                                                  and (ardilla[j].x<x+140) and (ardilla[j].x>x-200) then estado:=1;
          if estado=1 then Dec(x,16);
          IF ((ardilla[1].X+170>X) and (ardilla[2].X+170>X)) or (x<20) then classb:=0;
         end;
  15:Begin    {flechacae pa'lotro lado}
           dir:=0;
           if estado=0 then For j:=1 to players do if (Abs((ardilla[j].X-X)-(ardilla[j].Y-Y))<20) then estado:=1;
           if estado=1 then begin
                            inc(x,8);
                            inc(y,8);
                            end;
           if ((estado=1) and at1(Scene^[(X) DIV 25,(Y+54) DIV 25])) or (x<20) or (y>3000) then begin
                                                          Y:=((Y+54) div 25 * 25)-45;
                                                         estado:=2;
                                                         end;
           if estado>1 then inc(estado);
           if estado=50 then classb:=0;
      end;

     17:begin  { Carritu!}
        if clk mod 1=0 then begin
        if estado>0 then if estado<12 then inc(estado);
        inc(x,estado);

        if (dir<12)  then inc(dir);
         inc(Y,dir);
        if Scene^[(X+25) DIV 25,(Y+25) DIV 25] in [7..12] then Begin
                                           Y:=((Y+25) div 25 * 25)-25;
                                                                dir:=0;
                                                                end;
                                                                end;
        end;



     18:begin {indiecitu!}
         if not at1(Scene^[(X+25) DIV 25,(Y+45) DIV 25]) then begin
                                                              inc(Y);
                                                              estado:=1
                                                              end else estado:=0;

         if estado=0 then If at1(Scene^[(X+25) DIV 25,(Y+45) DIV 25]) then begin
                   if dir=0 then if at1(Scene^[(X+21) DIV 25,(Y+45) DIV 25]) then Dec(x,2)
                                                                                       else dir:=1;
                   if dir=1 then if at1(Scene^[(X+29) DIV 25,(Y+45) DIV 25]) then inc(x,2)
                                                                                       else dir:=0;
                                                                           end;


     For j:=1 to players do if (ardilla[j].X<X+150) and (ardilla[j].X>X-150) and
            (ardilla[j].y-20<y+80)  and (ardilla[j].y-20>y-80) then
                                    if ((dir>0) and (ardilla[j].x>X))
                                       or ((dir=0) and (ardilla[j].x<X)) then if clk mod 40=1 then newB(X,Y+5,19,dir);

                     end;


     19:begin {Ke es estoooooo}
     if dir=0 then dec(x,5);
     if dir>0 then inc(x,5);
       if not((ardilla[1].X<X+200) and (ardilla[1].X>X-200) and
                               (ardilla[1].y-20<y+140)  and (ardilla[1].y-20>y-140))
                               and not((ardilla[2].X<X+200) and (ardilla[2].X>X-200) and
                               (ardilla[2].y-20<y+140)  and (ardilla[2].y-20>y-140)) then classb:=0;


   end;

   20:Begin {zalta zalta zalta, pekenia langosta}
     if  not at1(Scene^[(X+15) DIV 25,(Y+25) DIV 25]) and (estado in [3..18]) then Begin
                                                          inc(Y,estado-2);
                                                          if estado<18 then inc(estado);
                                                          end;
     if at1(Scene^[(X+15) DIV 25,(Y+25) DIV 25]) then Begin
                                                      Y:=((Y+25) div 25 * 25)-25;
                                                      estado:=0;
                                                      end
                                                      else if estado <3 then estado:=3;

     if (dir=0) and (estado>2) then dec(x,3);
     if (dir=1) and (estado>2) then inc(x,3);
     For j:=1 to players do if estado=0 then Begin

     if (Y-100<ardilla[j].Y) and (Y+100>ardilla[j].Y) and
        (X-160<ardilla[j].X) and (X+180>ardilla[j].X)then begin
      if ardilla[j].X<X then dir:=0 else dir:=1;

     if random(10)=1 then estado:=113;
     end;
     end;
     if Estado in [100..120] then Begin Dec(Y,estado-98);
                                        Dec(estado);
                                        if (estado=99) or at2(Scene^[(X+15) DIV 25,(Y+2) DIV 25]) then estado:=3;
                                        end;
     end;
     21:begin {gotita!}
             if estado=0 then Begin
                              dir:=Y div 25;
                              estado:=1;
                              end;
             inc(Y,3);
             if at1(Scene^[(X+15) DIV 25,(Y+5) DIV 25]) then Begin
                                                             y:=dir*25;
                                                             estado:=0;
                                                             end;
        end;

     22:Begin {prENsa}
             if estado=0 then Begin
                              if clk mod 10=1 then Begin
                                                       dir:=1;
                                                     end;
                               end;
     if at1(Scene^[(X+15) DIV 25,(Y+45) DIV 25]) then Begin
                                                      dir:=2;
                                                      end;
              if dir=1 then begin
                            inc(estado,2);
                            inc(Y,2);
                            end;
              if dir=2 then begin
                            dec(estado,2);
                            dec(y,2)
                            end;
              if estado=0 then dir:=0;

       end;
     23:Begin {el robot destructor}
      if  not at1(Scene^[(X+15) DIV 25,(Y+45) DIV 25]) then inc(y);

     if estado<30 then
     For j:=1 to players do Begin
     if (Y-100<ardilla[j].Y) and (Y+100>ardilla[j].Y) then begin
     if (estado in [0..2,20..21]) and (X-170<ardilla[j].X) and (X+205>ardilla[j].X) then if ardilla[j].X<x+15
                                                                                  then estado:=1
                                                                                  else estado:=2;

     if (ardilla[j].Y>Y+10) and (ardilla[j].Y<Y+60) and (estado in [0..2,20..21]) and (X-50<ardilla[j].X) and
     (X+85>ardilla[j].X)
     and (clk mod 20=1) then if ardilla[j].X<x+15
                                                                                  then estado:=20
                                                                                  else estado:=21;
     end;
     end;
     if estado = 1 then Begin
                        dir:=0;
                        if at1(Scene^[(X+12) DIV 25,(Y+45) DIV 25]) then Begin

                                                                         Dec(x,3);
                                                                         end
                        end;
     if estado = 2 then Begin
                        if at1(Scene^[(X+18) DIV 25,(Y+45) DIV 25]) then inc(x,3);
                        Dir:=1;
                        end;

     if (estado in [1..2]) and (clk mod 20=1) then begin
                                                   estado:=50;
                                                   end;
     if estado = 20 then Begin
                        dir:=0;
                                          estado:=30;
                                          newB(X-127,Y-3,24,0);
                        end;
     if estado = 21 then Begin
                        dir:=1;
                                      newB(X+50,Y-3,24,0);
                                      estado:=30;

                        end;

     if estado>=30 then inc(estado);
     if estado=40 then if dir=0 then estado:=1 else estado:=2;
     if estado=52 then   newb(X,Y+20,26,dir);

     if estado=56 then if dir=0 then estado:=1 else estado:=2;


   end;
     24:Begin {electrocushion!? no! tampoco se!! ??}
             inc(estado);
             if estado=10 then classb:=0;
         end;

     25:Begin {ete si! electrocushion!}
        inc(Estado);
        if estado>13 then Begin
                          classb:=0;
                          end;
        x:=ardilla[dir].X-25;
        y:=ardilla[dir].y-40;
        end;

     26:begin {disparo del uachimalo}
     if dir=0 then dec(x,9);
     if dir>0 then inc(x,9);
       if (not((ardilla[1].X<X+200) and (ardilla[1].X>X-200) and
                               (ardilla[1].y-20<y+140)  and (ardilla[1].y-20>y-140))
                               and not((ardilla[2].X<X+200) and (ardilla[2].X>X-200) and
                               (ardilla[2].y-20<y+140)  and (ardilla[2].y-20>y-140))) or (x<20) or (x>12500) then classb:=0;


   end;
      27:Begin {el coso que caaaaae!}

           if estado=0  then For j:=1 to players do if (ardilla[j].X<X+40) and (ardilla[j].X>X+10) and
            (ardilla[j].y<y+150)  and (ardilla[j].y>y) then estado:=1;

           if estado=1 then inc(y,6);

           if at1(Scene^[(X+25) DIV 25,(Y+25) DIV 25]) and (Estado=1) then Begin
                                                       estado:=2;
                                                      end;
           if (estado>1) and (clk mod 2=1) then inc(Estado);
           if estado=5 then classb:=0;
        end;


  29:Begin {je , a este lo hice yo (?) el auto!}
          if estado=0 then For j:=1 to players do if (ardilla[j].y<y+90) and (ardilla[j].y>y-90)
                                                  and (ardilla[j].x<x+140) and (ardilla[j].x>x-200) then estado:=1;
          if estado=1 then Dec(x,9);
          IF (ardilla[1].X-200>X) and (ardilla[2].X-200>X) then classb:=0;
         end;
  30:Begin { The Hunter!}
     if  not at1(Scene^[(X+15) DIV 25,(Y+45) DIV 25]) and (estado in [3..18]) then Begin
                                                          inc(Y,estado-2);
                                                          if estado<18 then inc(estado);
                                                          end;
     if at1(Scene^[(X+15) DIV 25,(Y+45) DIV 25]) and (Estado<20)then Begin
                                                      Y:=((Y+45) div 25 * 25)-45;
                                                      estado:=0;
                                                      end
                                                      else if estado <3 then estado:=3;
    For j:=1 to players do Begin
     if (Y-100<ardilla[j].Y) and (Y+100>ardilla[j].Y) then begin
     if (estado in [0..2]) and (X-100<ardilla[j].X) and (X+135>ardilla[j].X) then if ardilla[j].X<x+15
                                                                                  then estado:=1
                                                                                  else estado:=2;

     if (estado in [0..2]) and (X-50<ardilla[j].X) and (X+85>ardilla[j].X) then estado:=20;
     end;
     end;
     if estado = 1 then Begin
                        dir:=0;
                        if at1(Scene^[(X+12) DIV 25,(Y+45) DIV 25]) then Begin
                                                                         Dec(x,3);
                                                                         end
                        end;
     if estado = 2 then Begin
                        if at1(Scene^[(X+18) DIV 25,(Y+45) DIV 25]) then inc(x,3);
                        Dir:=1;
                        end;

     if estado>19 then inc(estado);
     if estado=50 then estado:=0;

     if estado = 21 then Begin
                         case dir of
                        0:newB(X-50,Y,31,dir);
                        else newB(X+50,Y,31,dir);
                        end;
                        end;


   end;
31:Begin
        inc(Estado);
        if estado=16 then classb:=0;
   end;
32:Begin
   If dir=0 then Dec(x,5) else Inc(x,5);
   if (at2(Scene^[(X+25) DIV 25,(Y+30) DIV 25])) or (x<20) or (x>12500) then if dir=0 then dir:=1 else dir:=0;
   end;
33:Begin {Worm}
     if  not at1(Scene^[(X+15) DIV 25,(Y+25) DIV 25]) and (estado in [3..18]) then Begin
                                                          inc(Y,estado-2);
                                                          if estado<18 then inc(estado);
                                                          end;
     if at1(Scene^[(X+15) DIV 25,(Y+25) DIV 25]) then Begin
                                                      Y:=((Y+25) div 25 * 25)-25;
                                                      estado:=0;
                                                      end
                                                      else if estado <3 then estado:=3;

     For j:=1 to players do Begin
     if (Y-100<ardilla[j].Y) and (Y+100>ardilla[j].Y) then begin
     if (estado in [0..2]) and (X-45<ardilla[j].X) and (X+70>ardilla[j].X) then estado:=111;
{     if (estado in [0..2]) and (X-100<ardilla[j].X) and (X+135>ardilla[j].X) then if ardilla[j].X<x+15
                                                                                  then estado:=1
                                                                             else estado:=2;    }
     end;
     end;
     if Estado in [100..120] then Begin Dec(Y,estado-98);
                                        Dec(estado);
                                        if estado=99 then estado:=3;
                                        end;
     if dir=0 then Dec(x,2);
     if dir>0 then inc(x,2);

     if (estado in [0..2]) and (not at1(Scene^[(X+15) DIV 25,(Y+25) DIV 25])) or (x<20) or (x>12500) then  begin
                                                     if dir=0 then Begin
                                                                   dir:=1;
                                                                   inc(x,2);
                                                                   end else Begin
                                                                   dir:=0;
                                                                   dec(x,2);
                                                                   end;
                                                     end;
     end;


34:Begin
   if ((clk2 mod 300) =0) or (clk2=1) then newb(x,y,35,0);
   end;
35:Begin {el malo que se arma}
   if not (bsa(scene^[(x+12) div 25,(y+25) div 25]) in [37..39]) then Begin
                                                                    if dir<17 then inc(dir);
                                                                    end else Begin
                                                                             dir:=0;
                                                                             y:=((y div 25)*25);
                                                                              end;
  if   (bsa(scene^[(x+12) div 25,(y+12) div 25])=58) and (Estado<8) THEN begin
  if (x>nukunit.wx) and (x+25<nukunit.wx+319) and (y>nukunit.wy) and (y+25<nukunit.wy+199) then
                                                      scene^[(x+12) div 25,(y+12) div 25]:=60;
                                                    INC(ESTADO);
                                                    if estado=4 then newb(X-10,Y-10,11,0);
                                                    estado:=estado*10
                                                    end;
   if estado>7 then inc(estado);
   if estado mod 10 =9 then estado:=estado div 10;
if estado=41 then classb:=0;
   inc(y,dir);
   inc(x,3);
   end;

36:Begin {36}
   if Y<50 then classb:=0;
   if estado=0 then Begin
                   if (ardilla[1].X>X-320) or (ardilla[2].X>X-320) then estado:=1;
                   end else Begin
                            inc(estado);
                            case estado of
                            1..60:Dec(x,7);
                            61..160:Begin
                                    Dec(x,7);
                                    dec(y,(estado-60) div 2);
                                    end;
                            170:classb:=0;
                            end;
  if ((ardilla[1].X>X-50) and (ardilla[1].X<X+50)) or ((ardilla[2].X>X-50) and (ardilla[2].X<X+50)) then if clk mod 8=0 then
                                                      newB(X+50,Y+40,37,dir);
                     end;

end;
37:Begin {misil del avion}
   if estado<24 then inc(Estado);
   inc(y,estado);
   if  at1(Scene^[(X+3) DIV 25,(Y+8) DIV 25]) then Begin
                                                   classb:=0;
                                                   newv(x-5,y-5,110);
                                                   end;
   end;

38:Begin {disparador de chotadas}
   if clk2 mod 30=1 then newB(X,Y,5,dir);
   end;

{next here}
{el 39 no se usa}
40:Begin
        if energia_de_malo>1 then Begin

        if malo_titil>0 then dec(malo_titil);
        if malo_Status3=0 then Begin
                               malo_status1:=0;
                               malo_status3:=30;
                               end;

        dec(malo_Status3);

        case malo_status1 of
        0:Begin
          if malo_status3=0 then Begin
          repeat
          malo_status1:=Random(3)+1;
          malo_status2:=0;
          until malo_status1<>old_stat;
          malo_status3:=255;
          end;
          end;
        1:Begin
          old_stat:=malo_status1;
          if dir=0 then Begin
                        Dec(x,5);
                        if x<27 then dir:=1
                        end else Begin
                        inc(x,5);
                        if x>304 then dir:=0;
                        end;

          end;
        2:Begin
          old_stat:=malo_status1;
          case malo_status3 of
          5..70:inc(y,2);
          71..179:if clk mod 7 =0 then newb(Random(270)+25,425,37,0);
          180..245:dec(y,2);
          end;


          end;
        3:Begin
          old_stat:=malo_status1;
          if (malo_status2=0) and (x<304) then Begin
                                             inc(x,6);
                                             dir:=1;
                                             if x>=304 then malo_Status2:=1;
                                             end else Begin
                                             dir:=0;
                                             case clk mod 60 of
                                             0:newb(x+3,y+17,26,0);
                                             30:newb(x+3,y+67,26,0);
                                             end;
                                             end;;

          end;
        end;
    end
    else Begin
         dec(malo_status3);
         if malo_status3=0 then Begin
                                energia_de_malo:=0;
                                ardilla[1].finished:=true;
                                end;
         Newv(x+random(50)-14,y+random(80)-14,110);

         end;
   end;
41:Begin
        if energia_de_malo>1 then Begin

        if malo_titil>0 then dec(malo_titil);
        if malo_Status3=0 then Begin
                               malo_status1:=0;
                               malo_status3:=30;
                               end;

        dec(malo_Status3);

        case malo_status1 of
        0:Begin
          if malo_status3=0 then Begin
   {       repeat}
          malo_status1:=Random(2)+1;
          malo_status2:=0;
{          until malo_status1<>old_stat;}
          malo_status3:=255;
          end;
          end;
        1:Begin
          old_stat:=malo_status1;
          if players=1 then k:=1 else if abs(ardilla[1].x-(x+25))>=abs(ardilla[2].x-(x+25)) then k:=2 else k:=1;
          if ardilla[k].x+30<x+25 then if not at2(scene^[(x+23) div 25,Y div 25]) then dec(x,2);
          if ardilla[k].x-30>x+25 then if not at2(scene^[(x+27) div 25,Y div 25]) then inc(x,2);
          if x<ardilla[k].x then dir:=1 else dir:=0;
          if clk2 mod 30=1 then newb(X+25,y+5,5,dir);
          end;
        2:Begin
          old_stat:=malo_status1;
          case malo_status3 of
          15:dec(y,200);
          16..239:Begin
                       if clk mod 7 =0 then newb(X+10+random(30),y+random(30)-185,5,random(2));
                       if clk mod 31 =0 then newb(X+10+random(30),y+random(30)-185,11,random(2));

                  end;
          240:inc(y,200);
          end;


          end;
        3:Begin
          old_stat:=malo_status1;
          if (malo_status2=0) and (x<304) then Begin
                                             inc(x,6);
                                             dir:=1;
                                             if x>=304 then malo_Status2:=1;
                                             end else Begin
                                             dir:=0;
                                             case clk mod 60 of
                                             0:newb(x+3,y+17,26,0);
                                             30:newb(x+3,y+67,26,0);
                                             end;
                                             end;;

          end;
        end;
    end
    else Begin
         dec(malo_status3);
         if malo_status3=0 then Begin
                                energia_de_malo:=0;
                                ardilla[1].finished:=true;
                                end;
         Newv(x+random(50)-14,y+random(80)-14,110);

         end;
   end;
42:Begin
        if energia_de_malo>1 then Begin

        if malo_titil>0 then dec(malo_titil);
        if malo_Status3=0 then Begin
                               malo_status1:=0;
                               malo_status3:=15;
                               end;

        dec(malo_Status3);

        case malo_status1 of
        0:Begin
          if malo_status3=0 then Begin
   {       repeat}
          malo_status1:=Random(3)+1;
          malo_status2:=0;
{          until malo_status1<>old_stat;}
          malo_status3:=155;
          end;
          end;
        1:Begin
          old_stat:=malo_status1;
          case clk2 mod 60 of
          1:newb(X+25,y+80,20,dir);
          15,45:Begin
             dir:=0;
             newb(X+25,y+30,26,dir);
             end;
          0,30:Begin
             dir:=1;
             newb(X+25,y+30,26,dir);
             end;
          end;
          end;
        2:Begin
          old_stat:=malo_status1;
          case malo_status3 of
          15,30,45,60,75,90,105,120,135:Begin
                                          x:=247+random(315);
                                          y:=525+random(105);
                                          end;
          5:Begin
                 y:=630;
                 x:=247+random(315);
            end;
          end;


          end;
        3:Begin
          old_stat:=malo_status1;
          for k:=1 to players do Begin
                                 if x+25>ardilla[k].x then inc(ardilla[k].acx,2) else dec(ardilla[k].acx,2);
                                 if ardilla[k].acy<0 then ardilla[k].acy:=0;
                                 end;
          end;
        end;
    end
    else Begin
         dec(malo_status3);
         if malo_status3=0 then Begin
                                energia_de_malo:=0;
                                ardilla[1].finished:=true;
                                end;
         Newv(x+random(50)-14,y+random(80)-14,110);

         end;
   end;
43:Begin
        if energia_de_malo>1 then Begin

        if malo_titil>0 then dec(malo_titil);
        if malo_Status3=0 then Begin
                               malo_status1:=0;
                               malo_status3:=30;
                               end;

        dec(malo_Status3);
        if malo_status4<20 then inc(malo_status4);
        inc(y,malo_Status4);
        if at1(scene^[(X+25) div 25,(Y+45) div 25]) then Begin
                                                        Malo_Status4:=0;
                                                        y:=((y+45) div 25)*25-45;
                                                        end;


        case malo_status1 of
        0:Begin
          if malo_status3=0 then Begin
   {       repeat}
          malo_status1:=Random(2)+1;
          malo_status2:=0;
{          until malo_status1<>old_stat;}
          malo_status3:=155;
          end;
          end;
        1:Begin
          old_stat:=malo_status1;
          case clk mod 60 of
          0:Begin
            dir:=0;
            newb(X+25,y,9,dir);
            end;
          30:Begin
            dir:=1;
            newb(X+25,y,9,dir);
            end;
          end;


          end;
        2:Begin
          old_stat:=malo_status1;
          case malo_status3 of
          154:malo_status4:=-25;
          else Begin
          if players=1 then k:=1 else if abs(ardilla[1].x-(x+25))>=abs(ardilla[2].x-(x+25)) then k:=2 else k:=1;
          if ardilla[k].x>X then inc(x,4) else dec(x,4);

               end;
          end;
          end;
        3:Begin
          old_stat:=malo_status1;
          if (malo_status2=0) and (x<304) then Begin
                                             inc(x,6);
                                             dir:=1;
                                             if x>=304 then malo_Status2:=1;
                                             end else Begin
                                             dir:=0;
                                             case clk mod 60 of
                                             0:newb(x+3,y+17,26,0);
                                             30:newb(x+3,y+67,26,0);
                                             end;
                                             end;;

          end;
        end;
    end
    else Begin
         dec(malo_status3);
         if malo_status3=0 then Begin
                                energia_de_malo:=0;
                                ardilla[1].finished:=true;
                                end;
         Newv(x+random(50)-14,y+random(80)-14,110);

         end;
   end;
44:Begin
        if energia_de_malo>1 then Begin

        if malo_titil>0 then dec(malo_titil);
        if malo_Status3=0 then Begin
                               malo_status1:=0;
                               malo_status3:=30;
                               end;

        dec(malo_Status3);
        if malo_status4<20 then inc(malo_status4);
        inc(y,malo_Status4);
        if at1(scene^[(X+25) div 25,(Y+45) div 25]) then Begin
                                                        Malo_Status4:=0;
                                                        y:=((y+45) div 25)*25-45;
                                                        end;


        case malo_status1 of
        0:Begin
          if malo_status3=0 then Begin
       repeat
          malo_status1:=Random(3)+1;
          malo_status2:=0;
          until malo_status1<>old_stat;
          malo_status3:=190;
          end;
          end;
        1:Begin
          old_stat:=malo_status1;
          if at2(scene^[(X+25+(-10+(dir*20))) div 25,(Y+25) div 25]) then
                                         if dir=0 then dir:=1 else dir:=0;

          if dir=0 then dec(x,10) else inc(x,10);
          end;
        2:Begin
          old_stat:=malo_status1;
          case malo_status3 of
          184,94,44,134:malo_status4:=-15;
          20,40,60,80,100,120,140,160:Begin
                                      dir:=0;
                                      bguys[newb(X+25,Y,13,dir)].estado:=1;
                                      end;
          30,50,70,90,110,130,150,170:Begin
                                      dir:=1;
                                      bguys[newb(X+25,Y,15,dir)].estado:=1;
                                      end;
          end;
          end;
        3:Begin
          old_stat:=malo_status1;
          if players=1 then k:=1 else if abs(ardilla[1].x-(x+25))>=abs(ardilla[2].x-(x+25)) then k:=2 else k:=1;
          if ardilla[k].x>X then Begin
                                 inc(x,4);
                                 dir:=1;
                                 end else Begin
                                 dec(x,4);
                                 dir:=0;
                                 end;
          if (clk mod 7=1) and (abs(ardilla[k].x-(X+25))<80) then newb(x+25,y+5,5,dir);

          end;
        end;
    end
    else Begin
         dec(malo_status3);
         if malo_status3=0 then Begin
                                energia_de_malo:=0;
                                ardilla[1].finished:=true;
                                end;
         Newv(x+random(50)-14,y+random(80)-14,110);

         end;
   end;
45:Begin
        if energia_de_malo>1 then Begin

        if malo_titil>0 then dec(malo_titil);
        if malo_status2>0 then dec(malo_Status2);
        if malo_status4<20 then inc(malo_status4);
        inc(y,malo_Status4);
        if at1(scene^[(X+25) div 25,(Y+45) div 25]) then Begin
                                                        Malo_Status4:=0;
                                                        y:=((y+45) div 25)*25-45;
                                                        end;
 {31}
  for k:=1 to players do  if ((ardilla[k].x>=X-50) and (ardilla[k].x<=X) and (ardilla[k].Y>Y) and (ardilla[k].Y<y+70)
    and (malo_status2=0)) then Begin
                                                       malo_Status2:=11;
                                                       newb(x-50+7,y,31,0);
                                                       end;


 end
    else Begin
         dec(malo_status3);
         Newv(x+random(50)-14,y+random(80)-14,110);
         if malo_status3=0 then Begin
                                energia_de_malo:=0;
                                ardilla[1].finished:=true;
                                end;

         end;
   end;

end;
if Y>3200 then classb:=0;
if X<20 then classb:=0;
end;

end;

PRocedure CHECKT;
var i,j:byte;
Begin
For i:=1 to used do begin
case vectobj[i].t of
 105:vectobj[i].t:=0;
 104:vectobj[i].t:=105;
 103:vectobj[i].t:=104;
 102:vectobj[i].t:=103;
 101:vectobj[i].t:=102;
 100:vectobj[i].t:=101;
 115:vectobj[i].t:=0;
 114:vectobj[i].t:=115;
 113:vectobj[i].t:=114;
 112:vectobj[i].t:=113;
 111:vectobj[i].t:=112;
 110:vectobj[i].t:=111;
 215:vectobj[i].t:=0;
 214:vectobj[i].t:=215;
 213:vectobj[i].t:=214;
 212:vectobj[i].t:=213;
 211:vectobj[i].t:=212;
 210:vectobj[i].t:=211;
 230: Begin
       dec(vectobj[i].Y,2);
       if vectobj[i].Y<1364 then vectobj[i].t:=0;
       end;
 240..247:Begin
     INC(vectobj[i].t);
     case vectobj[i].t of
     241..246:scene^[vectobj[i].x div 25,vectobj[i].y div 25]:=50;
     248:Begin
       scene^[vectobj[i].x div 25,vectobj[i].y div 25]:=49;
       vectobj[i].t:=0;
       end;

     end;
     end; {aca va la mierda del resortin imbecil}
 140..170:Begin
 for j:= 1 to used do if (j<>i) and ((vectobj[i].X div 25) = (vectobj[j].X div 25)) and
                                 ((vectobj[i].y div 25) = (vectobj[j].y div 25)) and (vectobj[j].t>=140) then vectobj[i].t:=0;

     if vectobj[i].t>0 then begin
     if clk2 mod 2=1 then INC(vectobj[i].t);
     case vectobj[i].t of
     140..148:Begin
              scene^[vectobj[i].x div 25,vectobj[i].y div 25]:=40 or 128;
              end;
     149,150,169,170:scene^[vectobj[i].x div 25,vectobj[i].y div 25]:=41;
     151..168:scene^[vectobj[i].x div 25,vectobj[i].y div 25]:=42;
     171:Begin
              scene^[vectobj[i].x div 25,vectobj[i].y div 25]:=40 or 128;
              vectobj[i].t:=0;
       end;
     end;
     end;
     end; {aca va la mierda del resortin imbecil}
 14:vectobj[i].t:=100;
 17:vectobj[i].t:=110;
 48:vectobj[i].t:=100;
 45..47:Begin
    INC(vectobj[i].t);
    DEC(vectobj[i].y,5);
    END;

 21..30,43:if not at1(scene^[(vectobj[i].X+18) div 25,(vectobj[i].Y+20) div 25]) then inc(vectobj[i].Y,3)
 end;
end;
end;


Procedure CHAU;
begin
Writeln ('Se necesitan al rededor de 500k de memoria convencional para jugar');
Writeln ('normalmente y 564k para jugar de a dos jugadores con pantalla dividida.');
Writeln ('Para liberar memoria no hay que cargar muchos TSR o correr un optimizador');
Writeln ('de memoria.');
Halt(1);
end;

Procedure INIT;
var i,j,k,l,count:word;

Procedure INItVocs;
var i:byte;
    f:file;
    c:string[1];
    count:word;

Begin
{new(SOUND);}
count:=0;

for i:=1 to 7 do Begin
                 str(i,c);
		 writeln('readin'' sound effect ',i);
                 assign(f,'s'+c+'.wav');
                 reset(f,1);
                 voces[i].size:=filesize(f);
                 getmem(voces[i].where,voces[i].size);
                 blockread(f,voces[i].where^,voces[i].size);
                 count:=count+voces[i].size;
                 close(f);
                 end;
end;



procedure INITM;
begin
end;

Begin

{Init video here}
{asm
mov ax,3
int 10h
end;}

 if exist('nuku.cfg') then begin
                                  assign(fs,'nuku.cfg');
                                  reset(fs,1);
                                  blockread(fs,settings,16);
                                  close(fs);
                                  end else begin
                                           Writeln('No se encontro nuku.cfg. Correr SETUP.EXE');
                                           halt(1);
                                           end;

{if settings.joyuse>0 then Begin
Writeln('CONFIGURACION DEL JOYSTICK');
Writeln('~~~~~~~~~~~~~~~~~~~~~~~~~~');
Writeln('Pone la palanca del Joystic en el centro, o la cruz del pad suelta');
Writeln('Despues apreta el boton A');
Writeln('SI queres no usar joystick apreta ESC');
Repeat
joys.JoyCX:=JOyX;
until ButA or (port[$60]=1);
if port[$60]=1 then settings.Joyuse:=0;
end;
Writeln('Cargando NuKu.. Espere Por favor');}
    names:=true;
    vr:=false;
    quito:=false;
    VMODE:=1;
  music:=settings.music;
  music:=true;
  sfx:=settings.sound;


new(tiles);
new(tilesV);
new(vircol);
new(ard);



new(Bads);


new(bak);


new(scene);

new(pag2);
new(virvidbuff);
new(Vpalette);
settings.musicaCD:=true;
{if settings.musicacd then begin
                         music:=false;
                         if not initCD then Begin Writeln('No hay audio. seguis adelnate?(S/N):');
                                      Writeln(memavail);
                         if upcase(readkey)<>'Y' then chau
                                                 else settings.musicaCD:=false;
                            end;

                         end;}
{if settings.musicacd then begin
                          Pauseaudio;
                          end;}


if music then initM;

new(letras);
new(reds);
new(Blus);

if sfx then initvocs;
canplay2:=true;

{Writeln('Te quedan ',memavail,' bytes de memoria convencional.. ');}
{readln;}
{asm
mov ax,13h
int 10h
end;}


Assign(fi,'nuku.spr');
reset(fi,1);
Blockread(Fi,ard^,29602);
close(fi);

  for CurFlake:=0 to Flakes do With Flake[curflake] do
  begin
    Perturb(r); Inc(s,r);
    y:=Hi(Hi(r)*fastest)+5;
    x:=Hi(Lo(r)*y)+1;
    p:=s;
  end;
  for CurFlake:=0 to Flakes do With Flake2[curflake] do
  begin
    Perturb(r); Inc(s,r);
    y:=Hi(Hi(r)*fastest)+5;
    x:=Hi(Lo(r)*y)+1;
    p:=s;
  end;
ReadPCX('fontg.pcx',pag2^[0]);
count:=0;
j:=0;
For i:=0 to 35 do
 begin
      For k:=0 to 6 do for l :=0 to  7 do
       begin
       LeTRas^[Count]:= pag2^[(j*7+k),(i*8)+l];
       inc(count);
       end;
  end;
ReadPCX('tilal.pcx',Pag2^[0]);

count:=0;
for J:=0 to 2 do For i:=0 to 11 do
 begin
      For k:=0 to 24 do for l :=0 to  24 do
       begin
       TilesV^[Count]:= pag2^[(((j*26)+k)),(i*26)+l];
       inc(count);
       end;
{         if (j=5) and (i=2) then i:=11;}

  end;
pvid:=pointer($A0000000);
randomize;
        installfastkeys;
{toimp}
settings.p1LEFT:=scleft;
SETTINGS.P1right:=scright;
settings.P1B:=scup;
settings.P1A:=scspace;
end;

Procedure DONE;
label trytokillagain;
Begin
restorekeyboard;
dispose(tiles);
dispose(tilesV);
dispose(ard);
dispose(Bads);
dispose(bak);
dispose(scene);
dispose(pag2);
if music then begin
        end;

{if canplay2 then dispose(sec);}



if music then begin
{	dwt_Kill;

TRYTOKILLAGAIN:

	if (dws_Kill <> 1) then
	begin
		(*
		 . If an error occurs here, it's either dws_Kill_CANTUNHOOKISR
		 . or dws_NOTINITTED.  If it's dws_Kill_CANTUNHOOKISR the user
		 . must remove his tsr, and dws_Kill must be called again.	If it's
		 . dws_NOTINITTED, there's nothing to worry about at this point.
		*)
		err_Display;

		if (dws_ErrNo = dws_Kill_CANTUNHOOKISR) then
		begin
			goto TRYTOKILLAGAIN;
		end;
	end;
    }
end;
end;





Procedure PLAYMUSIC(X:string);
Begin

end;


Procedure STOPMUSIC;
begin

end;

Procedure copiabak;
begin
bak^:=Pag2^;
end;

Procedure copiabak2;
Begin
Move(PAg2^[0],bak^[0],64000);
end;

Procedure initlev(MAPN:string);
var i,j,k,l,count:Word;
    suple:string;
    caca:file of byte;
    provi:byte;

	Procedure load;
	var i,j,k,l:Word;
	    datosprov:scd_r;
	    
	    Badprov:bad_r;
	    vecprov:rec_Vec_r;
	    f:string;
	    fname:string;
	    tmpsht:integer;
	        
	begin
	
	fname:=mapn+'.dat';
	writeln('loading level.. ',fname);
	Assign(Fil3,fname);
	reset(fil3,1);
	{if ioresult<>0 then file_error;}
	blockread(fil3,datosprov,sizeof(datosprov),tmpsht);
	{fucking manual typecast}
	Move(datosprov.USED,Datos.used,3);
	datos.startx:=word(datosprov.startx);
	writeln('x start position:',datos.startx);
	datos.starty:=word(Datosprov.starty);
	writeln('y start position:',datos.starty);
	datos.endx:=word(Datosprov.endx);
	writeln('x level end:',datos.endx);
	{i hate you typecast}
	used:=datos.used;
	bgused:=datos.bgused;
	close(fil3);
	i:=datos.levtype;
	str(i,suple);
	if upcase(mapn[length(mapn)])='F' then Begin
	                                       nivel_de_malo:=true;
	                                       energia_de_malo:=nrgbad[datos.levtype];
                                               malo_titil:=0;
	                                       malo_status1:=0;
	                                       malo_status2:=0;
	                                       malo_status3:=0;
	                                       end else nivel_de_malo:=false;
	
	
	if (NOT racemode) and (not nivel_de_malo) and (datos.levtype<>13) then Begin


		assign(fi,'nukumap.spr');
	
		reset(fi,1);
		{if ioresult<>0 then file_error;}
		Blockread(Fi,ard^,29602);
		close(fi);
		
		if playlevel<17 then READPCXP('jmapa.pcx',pag2^[0])
		                else READPCXP('jmapa2.pcx',pag2^[0]);
		
		copiabak;
		i:=0;
		key[scenter]:=false;
		repeat
			putb;
			ZbitmapM(@Ard^[i*1558],CoordLod[playlevel,0]-20,CoordLod[playlevel,1]-20,25,25,41,38,@pag2^[0]);
			Copyscr2;
			{
		toimp
		timervar:=0;
		
		Repeat until timervar>1;}
			inc(i);
			
			if i=8 then i:=0;
			read_keys_from_input();
		until key[scenter];
		i:=25;
		repeat
			putb;
			ZbitmapM(@Ard^[1558],CoordLod[playlevel,0]-10+(15-i),CoordLod[playlevel,1]-10+(15-i),i,i,41,38,@pag2^[0]);
		    	Copyscr2;
		    	timervar:=0;
		{
	toimp
	Repeat
	repeat until(2=2);
	until timervar>0;}
	
			dec(i);
		until i=1;
		Assign(fi,'nuku.spr');
		reset(fi,1);
	        Blockread(Fi,ard^,29602);
		close(fi);
	end; {egh}

	chekcd;
	READPCXP('ll'+suple+'.pcx',pag2^[0]);
        if nivel_De_malo then Msg(155,40,'Jefe del area');
        copyscr2;
	getred;
	getblu;
	Assign(Fil,MAPN+'.map');
	reset(fil,1);
	BlockRead(Fil,PAg2^[0,0],64000,tmpsht);
	count:=0;
	For i:=0 to 523 do 
	   for j:=0 to 124 do 
		Begin
	        
		    {if count=64000 then }
		    {begin}
	                                       
			{blockRead(Fil,PAg2^[0,0],1500,tmpsht);}
                        {count:=0;}
                    {end;}
                    Scene^[i,j]:=Vsho(PAg2)^[Count];
                    inc(count);
                end;
	close(fil);
        writeln('load items..');
    
        Assign(Fil2,''+MAPN+'.vec');
        reset(fil2,1);
        For i:=0 to 150 do 
	begin
    
	for j:=0 to 124 do
	begin
    	    blockread(fil2,vecprov,5,tmpsht);
	    vectobj[i].t:=vecprov.t;
	    Vectobj[i].x:=vecprov.x;
	    Vectobj[i].y:=vecprov.y;
	end;
	writeln('object ',i,' is ',vectobj[i].x,',',vectobj[i].y);

    end;	
    close(fil2);
    writeln('load enemies...');
    Assign(Fil4,''+MAPN+'.enm');
    reset(fil4,1);
    For I:=1 to 150 do
    Begin

	blockread(fil4,badprov,7,tmpsht);
	
	
	{move(badprov.classb,bguys[i].classb,3);

	Bguys[i].x:=badprov.x[1];
	Bguys[i].x:=(bguys[i].x  shl 8) and badprov.x[2];
	Bguys[i].y:=(badprov.y[0] shl 8) and badprov.y[1];}
	{badprov.x:=(badprov.x shl 8) or (badprov.x shr 8);}
	{badprov.y:=(badprov.y shl 8) or (badprov.y shr 8);}
	bguys[i]:=badprov;
	
   end;
    close(fil4);
    end;

begin


    For i:=0 to 319 do for j:=0 to 199 do pag2^[j,i]:=0;
    For i:=0 to 124 do for j:=0 to 523 do scene^[j,i]:=0;

    music_play_song('LL-NUKTR.IT');
                 
    writeln('level load begin...');
    load;
    writeln('level load end...');

    READPcx('back'+suple+'.pcx',Pag2^[0]);
    copiabak;

    if NOT nivel_de_malo then
             ReadPCX('bgs'+suple+'.pcx',Pag2^[0])
                      else
             ReadPCX('bgs'+suple+'f.pcx',Pag2^[0]);


    count:=1;

    for J:=0 to 1 do For i:=0 to 5 do
     begin
      For k:=0 to 44 do for l :=0 to  49 do
       begin
       bads^[Count]:= Pag2^[(((j*46)+k)),(i*51)+l];
       inc(count);
       end;


  end;


    ReadPCX('tiles'+suple+'.pcx',Pag2^[0]);
    count:=0;
    for J:=0 to 5 do For i:=0 to 11 do
     begin
      For k:=0 to 24 do for l :=0 to  24 do
       begin
       Tiles^[Count]:= pag2^[(((j*26)+k)),(i*26)+l];
       inc(count);
       end;
    end;
    
    READPCXP('ll'+suple+'.pcx',pag2^[0]);

    msg(20,170,'Presione una tecla para continuar');
    copyscr2;

    repeat 
    read_keys_from_input();
    until key[scenter];
    if music then begin

    stopmusic;
    playmusic('ml'+suple+'.mid');
    end;

wX:=0;
wY:=0;
X2:=0;
Y2:=0;
ardilla[1].x:=datos.startX;
SaleDeX:=datos.startX;
ardilla[1].y:=datos.starty;
SaleDeY:=datos.starty;
if not racemode then ardilla[2].x:=datos.startX+40 else ardilla[2].x:=datos.startX;
ardilla[2].y:=datos.starty;
ardilla[1].finished:=false;
ardilla[2].red:=0;
ardilla[1].red:=0;
ardilla[2].finished:=false;
ardilla[1].nrg:=8;
ardilla[2].nrg:=8;
ardilla[1].acx:=0;
ardilla[2].acx:=0;
ardilla[1].acy:=0;
ardilla[2].acy:=0;
ardilla[1].red:=0;
ardilla[2].red:=0;
ardilla[1].dir:=true;
ardilla[2].dir:=true;

        for k:=1 to levelmax do
        begin
                if (levelname[k]=MAPN) then
                begin
                        music_play_song(musicfile[k]);
                end;
        end;

end;


procedure PoneC(xp,yp:smallint);
var i,j,Xv,Yv,k:Word;
    wib:byte;
Begin
{Xv:=(X-(X mod 25)) div 25;}
if Xp<0 then xp:=30;
if yp<0 then yv:=30;
Xv:=Xp div 25;
Yv:=(Yp-(Yp mod 25)) div 25;
For i:=0 to 13 do for j:=0 to 8 do Begin
    wib:=bsa(scene^[Xv+i,Yv+j]);
    if wib>0 then putthing((Xv*25-Xp)+i*25,(Yv*25-Yp)+j*25,wib-1);
    if datos.levtype=2 then
    if wib in [40..42] then
             case clk mod 64 of
               1..2,9..10:scene^[Xv+i,Yv+j]:=41;
               3..8:scene^[Xv+i,Yv+j]:=42;
               else Begin
                    wib:=40;
                    seta1(wib);
                    scene^[Xv+i,Yv+j]:=wib;
                    end;
               end;
     if (datos.levtype=5) and (clk mod 3=0) then if scene^[Xv+i,Yv+j] in [59,60] then dec (scene^[Xv+i,Yv+j]);
     end;
end;
Procedure PoneV(Xp,Yp:smallint);
var i:byte;
begin

for i:=1 to used DO if vectobj[i].t >0 then  BEGIN
  case vectobj[i].t of
       1..12:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,1 );
      13..30:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,vectobj[i].t-10 );
       31,45..48:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,23 );
      32..43:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,vectobj[i].t-7);
      44:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,29);
      60:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,35);
      100..101:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,7);
      102..103:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,8);
      104:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,9);
      105:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,10);
      110..111:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,4);
      112..113:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,5);
      114..115:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,6);
      210:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,29);
      211:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,30);
      212..213:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,31);
      214..215:PutthingV(vectobj[i].x-xp,vectobj[i].y-yp,32);
      230:Putthing(vectobj[i].x-xp,vectobj[i].y-yp,23);

   end;
   end;

end;

Procedure PoneM(XP,Yp:smallint);
var i,b:Byte;
Begin
If BGused>0 then for I:=1 to bgused do case BGuys[i].classb of
   1:case bguys[i].estado of
      1:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,(clk mod 12 div 4),0);
      2:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,4,0);
      3:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,5,0);
     end;
   2:  case bguys[i].estado of
          0,3..18:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp,6,Bguys[i].dir);
           1..2:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp,7+(clk mod 8 div 4),Bguys[i].dir);
           97..125:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp,9,Bguys[i].dir);
           end;
   3:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,10+(clk mod 4 div 2),0);
   4:  case bguys[i].estado of
          0,3..18:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp-20,0,Bguys[i].dir);
           20..21: if (clk mod 20) in [1..3] then
                     PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp-20,3,Bguys[i].dir)
                     else PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp-20,0,Bguys[i].dir);
           1..2:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp-20,(clk mod 9 div 3),Bguys[i].dir);
           end;

{   3:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,11,0);}
   6:case bguys[i].estado of
          0..10:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,8,bguys[i].dir);
          11..20:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,9,bguys[i].dir);
          end;
   7:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,10,bguys[i].dir);
   5:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,4+(clk mod 8 div 4),Bguys[i].dir);
   9:begin
     if clk mod 12 <9 then PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,clk mod 12 div 3,Bguys[i].dir);
     if clk mod 12 >8 then PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,1,Bguys[i].dir);
     end;
   10:begin
     case bguys[i].estado of
       1..20:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,3+(clk mod 8 div 4),Bguys[i].dir);
       21..40:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,5,Bguys[i].dir);
     end;
     end;
   11:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,6+(clk mod 4 div 2),Bguys[i].dir);
   12: case bguys[i].estado of
      0..1:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,8,0);
      2..3:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,9,0);
      4..6:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,10,0);
      end;

   13:case bguys[i].estado of
      1..30:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,0,0);
      31..50: if clk mod 2 =1 then PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,0,0);
     end;
   15:case bguys[i].estado of
      1..30:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,2,0);
      31..50: if clk mod 2 =1 then PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,2,0);
     end;
   14:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,1,0);
   17:if bguys[i].estado=0 then PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,5,0)
                    else PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,4+(clk mod 2),0);
     18:begin
      b:=clk mod 16 div 2;
        case b of
      0..5:  PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,6+b div 2,Bguys[i].dir);
       6..7:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,7,Bguys[i].dir);
     end;

     end;
     19:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,9+(clk mod 6 div 2),Bguys[i].dir);
     20:
     case bguys[i].estado of
             0:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp-20,6,Bguys[i].dir);
             else PutBAd(Bguys[i].x-xp,Bguys[i].y-yp-20,7,Bguys[i].dir);
        end;
     21:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,9,0);
     22:begin
             PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,10,0);
             PutBAd(Bguys[i].x-xp,Bguys[i].y-45-yp,11,0);
         end;
     23:Case bguys[i].estado  of
        0..2:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,(clk mod 4 div 2),bguys[i].dir);
        20..40:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,2+(clk mod 2),bguys[i].dir);
        50,51,54,55:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,4,bguys[i].dir);
        52,53:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,5,bguys[i].dir);

        end;
     25: PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,8+(clk mod 4 div 2),0);
     26:putthing(Bguys[i].x-xp,Bguys[i].y-yp,16+(clk mod 4 div 2));
     27:case bguys[i].estado of
        0..1:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,3,0);
        2..3:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,4,0);
        4..5:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,5,0);
        end;
     28:PutBAd(Bguys[i].x-xp,Bguys[i].y-yp+(clk mod 4 div 2)*13,8+(clk mod 4 div 2),Bguys[i].dir);
     29:Begin
        PutBAd(Bguys[i].x-xp,Bguys[i].y+5-yp,0,Bguys[i].dir);
        PutBAd(Bguys[i].x-xp+50,Bguys[i].y+5-yp,1,Bguys[i].dir);
        end;
     30: case bguys[i].estado of
          0,3..18:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp,7,Bguys[i].dir);
           20..32:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp,9,Bguys[i].dir);
           33..50:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp,7,Bguys[i].dir);
           1..2:case clk mod 16 div 4 of
            0..2:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp,6+(clk mod 16 div 4),Bguys[i].dir);
               3:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp,7,Bguys[i].dir);
               end;
          end;
      31:case bguys[i].estado of
        1..2:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp,10,Bguys[i].dir);
        3..11:PutBAd(Bguys[i].x-xp-7,Bguys[i].y-yp,11,Bguys[i].dir);
        end;
      32:PutBAd(Bguys[i].x-xp-25,Bguys[i].y-yp,5,Bguys[i].dir);
      33:case bguys[i].estado of
        0..1:case clk mod 12 div 3 of
             0..2 :PutBAd(Bguys[i].x-xp,Bguys[i].y-yp-20,clk mod 12 div 3,Bguys[i].dir);
             3 :PutBAd(Bguys[i].x-xp,Bguys[i].y-yp-20,1,Bguys[i].dir);
             end;

        else PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,3,Bguys[i].dir);

        end;

      35:case bguys[i].estado of
         1..6:PutThing(Bguys[i].x-xp,Bguys[i].y-yp,53+BGUYS[I].EsTADO);
         else PutThing(Bguys[i].x-xp,Bguys[i].y-yp,53+(BGUYS[I].EsTADO DIV 10));
         end;
      36:Begin
              PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,4,bguys[i].dir);
              PutBAd(Bguys[i].x-xp+50,Bguys[i].y-yp,5,bguys[i].dir);
              end;
      37:     PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,3,bguys[i].dir);
      39:Begin
      PutBad(Bguys[i].x-xp,Bguys[i].y-yp,8,0);
      PutBad(Bguys[i].x-xp+50,Bguys[i].y-yp,9,0);
      PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,10,0);
      PutBad(Bguys[i].x-xp+50,Bguys[i].y-yp+45,11,0);
      if random(20)=1 then       PutBad(Bguys[i].x-xp+24,Bguys[i].y-yp,3,0);
      end;
      40:if (malo_titil and 1=0) then
            Begin
            case malo_status1 of
            0:Begin
            PutBad(Bguys[i].x-xp,Bguys[i].y-yp,5,bguys[i].dir);
            if clk2 mod 2 =1 then
                       PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,11,bguys[i].dir)
                             else
                       PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,1,bguys[i].dir);

              end;
            1:Begin
            PutBad(Bguys[i].x-xp,Bguys[i].y-yp,4,bguys[i].dir);
            PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,9+clk2 mod 2,bguys[i].dir);

              end;
            2:Begin
            PutBad(Bguys[i].x-xp,Bguys[i].y-yp,5+clk2 mod 2,bguys[i].dir);
            if clk2 mod 2 =1 then
                       PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,11,bguys[i].dir)
                             else
                       PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,1,bguys[i].dir);
            end;
            3:case malo_status2 of
              0:Begin
            PutBad(Bguys[i].x-xp,Bguys[i].y-yp,4,bguys[i].dir);
            PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,9+clk2 mod 2,bguys[i].dir);
                end;

              1:Begin
            PutBad(Bguys[i].x-xp,Bguys[i].y-yp,2,bguys[i].dir);
            PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,7+clk2 mod 2,bguys[i].dir);

                end;
              end;


            end;

           end;
      41:if (malo_titil and 1=0) then
            case malo_status1 of
            0:PutBad(Bguys[i].x-xp,Bguys[i].y-yp,11,bguys[i].dir);
            1:case clk2 mod 9 of
              0..2:PutBad(Bguys[i].x-xp,Bguys[i].y-yp,9,bguys[i].dir);
              3..5:PutBad(Bguys[i].x-xp,Bguys[i].y-yp,10,bguys[i].dir);
              6..8:PutBad(Bguys[i].x-xp,Bguys[i].y-yp,11,bguys[i].dir);
              end;
            2:case malo_status3 of
            0..14,241..255:PutBad(Bguys[i].x-xp,Bguys[i].y-yp,11,bguys[i].dir);
            15..20,235..240:PutBad(Bguys[i].x-xp,Bguys[i].y-yp-200,2,bguys[i].dir);
            21..234:PutBad(Bguys[i].x-xp,Bguys[i].y-yp-200,3,bguys[i].dir);
            end;
            end;
      42:if (malo_titil and 1=0) then
            case malo_status1 of
            0:Begin
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp,5,bguys[i].dir);
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,11,bguys[i].dir);
            end;
            1:Begin
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp,8+clk mod 2,bguys[i].dir);
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,11,bguys[i].dir);
              end;
            2:case malo_status3 of
          5..7,15..17,30..33,45..47,60..63,75..77,90..93,105..107,120..123,135..137:Begin
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp,4,bguys[i].dir);
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,10,bguys[i].dir);
                                          end;
          else Begin
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp,5,bguys[i].dir);
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,11,bguys[i].dir);
            end;
          end;
          3:Begin
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp,5,bguys[i].dir);
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,clk mod 3,bguys[i].dir);

            end;
            end;
      43:if (malo_titil and 1=0) then
            case malo_status1 of
            0:Begin
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp,5,bguys[i].dir);
             PutBad(Bguys[i].x-xp-50+(bguys[i].dir*100),Bguys[i].y-yp,4,bguys[i].dir);
            end;
            1:Begin
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp,5,bguys[i].dir);
             PutBad(Bguys[i].x-xp-50+(bguys[i].dir*100),Bguys[i].y-yp,4,bguys[i].dir);
              end;
            2:Begin
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp,8+clk mod 4,bguys[i].dir);

              end;
          3:Begin
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp,5,bguys[i].dir);
             PutBad(Bguys[i].x-xp,Bguys[i].y-yp+45,clk mod 3,bguys[i].dir);

            end;
            end;
      44:if (malo_titil and 1=0) then
            case malo_status1 of
            0:Begin

             PutBad(Bguys[i].x-xp,Bguys[i].y-yp,6,bguys[i].dir);
            end;
            1:Begin
            if clk mod 12 <9 then PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,6+clk mod 12 div 3,Bguys[i].dir);
            if clk mod 12 >8 then PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,7,Bguys[i].dir);
              end;
            2:Begin
           PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,9,Bguys[i].dir);
              end;
          3:Begin
            if clk mod 12 <9 then PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,6+clk mod 12 div 3,Bguys[i].dir);
            if clk mod 12 >8 then PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,7,Bguys[i].dir);
            end;
            end;
      45:if (malo_titil and 1=0) then
          case malo_Status2 of
          0:Begin
            PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,9,Bguys[i].dir);
            PutBAd(Bguys[i].x-xp,Bguys[i].y-yp-45,7,Bguys[i].dir);
            end;
          1..16:Begin
            PutBAd(Bguys[i].x-xp,Bguys[i].y-yp,8,Bguys[i].dir);
                  end;
          end;





   end;
end;





(*****PROCEDIMIENTO DE LA ARDILLAAAAAAAAAAAAAAAAAAAAAAA********)
(*****PROCEDIMIENTO DE LA ARDILLAAAAAAAAAAAAAAAAAAAAAAA********)
(*****PROCEDIMIENTO DE LA ARDILLAAAAAAAAAAAAAAAAAAAAAAA********)
(*****PROCEDIMIENTO DE LA ARDILLAAAAAAAAAAAAAAAAAAAAAAA********)
(*****PROCEDIMIENTO DE LA ARDILLAAAAAAAAAAAAAAAAAAAAAAA********)


Procedure ard_rec.RockProc;
var i,j:byte;
Begin
for i:=1 to 4 do if rock[i].used then Begin
If rock[i].dir then inc(rock[i].x,rock[i].Spd+12)
               else dec(rock[i].x,rock[i].Spd+12);
inc(rock[i].acy);
Inc(rock[i].y,rock[i].acy);
with rock[i] do
for j:=1 to bgused do if (bguys[j].classb>0) and (mkill[bguys[j].classb]=1) and
                       (bguys[j].X+BadDim[Bguys[j].classb,1]<X+2)
                       and (bguys[j].X+BadDim[Bguys[j].classb,2]>X+2)
                       and (bguys[j].Y+BadDim[Bguys[j].classb,3]<y+2)
                       and (bguys[j].Y+BadDim[Bguys[j].classb,4]>y+2)
                       then begin
                            bguys[j].classb:=0;
                            newv(bguys[j].X+((Baddim[bguys[j].classb,1]+Baddim[bguys[j].classb,2]) div 2),
                                            bguys[j].Y+((Baddim[bguys[j].classb,3]+Baddim[bguys[j].classb,4]) div 2),110);
                            playfx(7);
                            end;

if
((rock[i].x>Ardilla[1].X+200)or
(rock[i].x<smallint(ardilla[1].x-200)) or (rock[i].y<ardilla[1].y-200) or (rock[i].y>ardilla[1].y+200))
and
((rock[i].x>Ardilla[2].X+200)or
(rock[i].x<smallint(ardilla[2].x-200)) or (rock[i].y<ardilla[2].y-200) or (rock[i].y>ardilla[2].y+200))
then rock[i].used:=false;
end;
end;



Procedure ard_rec.DrawRock(xu,yu:smallint);
var i:smallint;
Begin
For i:=1 to 4 do if rock [i].used then Putthingv(rock[i].x-xu,rock[i].y-yu,34);
end;

Procedure ard_rec.ardproc(NumArd:byte);
var kea,i:byte;

Function PendF(V2,V1,DesP:byte) :Byte;
Begin
PenDF:=V2+((V1-V2)*DESP DiV 25);
end;

Function IRREGU : boolean;
var CE:Byte;
Begin
CE:=scene^[X div 25,Y div 25];
IRREGU:=(CE in [15..21]) and ((Y mod 25)>=PENDF(Irblock[CE-14,1],Irblock[CE-14,2],X mod 25));
end;
Procedure IRREGUadj;
var CE:Byte;
Begin
CE:=scene^[X div 25,Y div 25];
Y:=(Y Div 25*25)+PENDF(Irblock[CE-14,1],Irblock[CE-14,2],X mod 25)-1;
end;
Procedure CHboxes;
var I:byte;
Begin
For I:=1 to used do
BEGIN

if vectobj[I].t=31 then if (Y-36<=vectobj[i].Y+24) and (Y>=vectobj[i].Y) and
                (X>=vectobj[i].X) and (X<=vectobj[i].X+24) then begin
                                                                vectobj[i].t:=100;
                                                                inc(coins);
                                                                if racemode then inc(Racestatus.maxcoins);
                                                                playfx(2);
                                                                if coins=50 then begin
                                                                                 coins:=0;
                                                                                 inc(lives);
                                                                                 end;
                                                                end;
if vectobj[I].t=44 then if (Y-36<=vectobj[i].Y+24) and (Y>=vectobj[i].Y) and
                (X>=vectobj[i].X) and (X<=vectobj[i].X+24) then begin
                                                                vectobj[i].t:=60;
                                                                SaleDeX:=Vectobj[i].X;
                                                                SaleDeY:=Vectobj[i].Y-50;
                                                                end;

if vectobj[I].t=22 then if (Y-36<=vectobj[i].Y+24) and (Y>=vectobj[i].Y) and
                (X>=vectobj[i].X) and (X<=vectobj[i].X+24) then Begin
                                                                inc(nrg,4);
                                                                if nrg>8 then nrg:=8;
                                                                vectobj[i].t:=100;
                                                                end;
if vectobj[I].t=21 then if (Y-36<=vectobj[i].Y+24) and (Y>=vectobj[i].Y) and
                (X>=vectobj[i].X) and (X<=vectobj[i].X+24) then Begin
                                                                inc(lives);
                                                               vectobj[i].t:=100;
                                                                end;
if vectobj[i].t in [23..30,43] then if (Y-36<=vectobj[i].Y+24) and (Y>=vectobj[i].Y) and
                (X>=vectobj[i].X) and (X<=vectobj[i].X+24) then begin
                                                                kea:=mode;
                                                                if vectobj[i].t-22in [0..7,21] then Begin
                                                                mode:=vectobj[i].t-22;
                                                                if mode=3 then inc(diamonds,20);
                                                                if mode=4 then red:=255;
                                                                if mode=6 then Begin
                                                                               mode:=0;
                                                                               coins:=0;
                                                                               dec(nrg);
                                                                               playfx(4);
                                                                               titil:=0;
                                                                               end;
                                                                if mode=7 then mode:=random(4)+1;
                                                                if diamonds>200 then diamonds:=200;
                                                                if mode<>6 then playfx(6);
                                                                if mode=21 then begin
                                                                                invis:=250;
                                                                                mode:=kea;
                                                                                end;
                                                                if mode=5 then begin
                                                                               inmo:=255;
                                                                               mode:=kea;
                                                                               end;

                                                                end else nrg:=8;

                                                              vectobj[i].t:=100;
                                                               end;

end;
end;

ProceDure CheCkBaDs;
var i:byte;
Begin
For i:=1 to bgused do
                      IF ((bguys[i].classb>0) and (mkill[bguys[i].classb]<3)) and
                       (bguys[i].X+BadDim[Bguys[i].classb,1]<X)
                       and (bguys[i].X+BadDim[Bguys[i].classb,2]>X)
                       and (bguys[i].Y-5+BadDim[Bguys[i].classb,3]<y+10)
                       and (bguys[i].Y+20+BadDim[Bguys[i].classb,4]>y)
                       then  if (((Y<bguys[i].Y+BadDim[Bguys[i].classb,3]+20) and (bguys[i].classb<>17))or
                                (spin>1) or (invis>0)) and (mkill[Bguys[i].classb]=1) then Begin
                                                    {reservado pa' malo}
                                                     if (i=1) and Nivel_de_malo then Begin
                                                     if malo_titil=0 then begin
                                                     dec(energia_de_malo);
                                                     if (energia_De_malo=1) then malo_status3:=35;
                                                      malo_titil:=30;
                                                      ACY:=-10;
                                       newv(bguys[i].X+((Baddim[bguys[i].classb,1]+Baddim[bguys[i].classb,2]) div 2),
                                            bguys[i].Y+((Baddim[bguys[i].classb,3]+Baddim[bguys[i].classb,4]) div 2),110);
                                                      end;
                                                     end else begin
                                                     ACY:=-10;
                                       newv(bguys[i].X+((Baddim[bguys[i].classb,1]+Baddim[bguys[i].classb,2]) div 2),
                                            bguys[i].Y+((Baddim[bguys[i].classb,3]+Baddim[bguys[i].classb,4]) div 2),110);
                                                     bguys[i].classb:=0;
                                                     end;
                                                     {reservado pa' malo}
                                                      end else
                              if (bguys[i].classb=17) then Begin
                                                        if (acy>0) and (carrito=0) then begin
                                                                                       carrito:=i;
                                                                                       bguys[i].estado:=1;
                                                                                       end;
                                                        end else
                             if (red=0) and (titil>40) and (invis=0) then Begin

                              playfx(4);
                             titil:=0;
                              dec(nrg);
                              end;
end;


Procedure ThiNgs;
var CE:byte;
Begin
CE:=scene^[X div 25,(Y+1) div 25];
IF Ce=16 then inc (acX,2);
IF Ce in [17..18] then inc (acX,1);
IF Ce in [19..20] then dec (acX,1);
IF Ce=21 then dec (acX,2);
if datos.levtype=7 then IF (Ce=37) and not ((ACY>-2) and (acy<2)) then newv(x-10,((Y+1) DIV 25*25)-13,210);
{if datos.levtype=12 then IF ((ce and 63)=40) then newv((x),(Y+1),140);}
if (datos.Levtype=4) And (Y>1356) and (Y<1373) then newv(x-10,((Y+1) DIV 25*25)-13,210);
agua:=((Datos.Levtype=4) And (Y>1373)) or ((Datos.Levtype=7) And (bsa(scene^[X div 25,(Y-3) div 25]) in [37..40]));

end;


Function Piso :Boolean;
var i:byte;
Begin
if at1(scene^[X div 25,Y div 25]) then Piso:=True
                                 else Piso:=false;
if (datos.levtype=5)  and (bsa(scene^[X div 25,(Y+8) div 25]) in [37..39]) then inc(x);
if (datos.levtype=12) and (bsa(scene^[X div 25,(Y) div 25])=40) and (acy>=0) then newv((x),(Y),140);

For I:=1 to used do if vectobj[i].t in [1..13] then
if (Y>=vectobj[i].Y) and (Y<=vectobj[i].Y+24) and
   (X>=vectobj[i].X) and (X<=vectobj[i].X+24)
   then piso:=true;

end;
Function reso :Boolean;
Begin
reso:=(scene^[X div 25,Y div 25]=49) and (acy>0);
end;
Function pinche :Boolean;
Begin
pinche:= (scene^[X div 25,(Y-4) div 25]=51) or ((datos.levtype=1) and (scene^[X div 25,(Y-4) div 25]=53));
if (datos.levtype=5) and (bsa(scene^[X div 25,(Y+12) div 25])=52) and (titil>40)
   then Begin

        pinche:=true;
        newb(1,1,25,numard);
        end;

end;

Function techo :Boolean;
var i,ce:byte;
Begin
if acY<0 then BEGIN
if at2(scene^[X div 25,(Y-37) div 25]) then techo:=True
                                 else techo:=false;
if (scene^[X div 25,(Y-37) div 25]=52) and (titil>40) and (invis=0) then begin
                                                                               playfx(4);
                                          titil:=0;
                                          dec(nrg);
                                          end;
For I:=1 to used do if vectobj[i].t in [1..13] then
if (Y-36>=vectobj[i].Y) and (Y-36<=vectobj[i].Y+24) and
   (X>=vectobj[i].X) and (X<=vectobj[i].X+24)
   then Begin
        if vectobj[i].t<11 then newv(vectobj[i].x,vectobj[i].y,VECTOBJ[i].t+20);
        if vectobj[i].t=12 then newv(vectobj[i].x,vectobj[i].y,43);
        if vectobj[i].t=11 then Begin
                                newv(vectobj[i].x,vectobj[i].y-15,45);
                                playfx(2);
                                if racemode then inc(Racestatus.maxcoins);
                                inc(coins);
                                                                if coins=50 then begin
                                                                                 coins:=0;
                                                                                 inc(lives);
                                                                                 end;

                                end;

        if vectobj[i].t<>13 then Begin
        vectobj[i].t:=13;
        ce:=newv(vectobj[i].x,vectobj[i].y,110);
        if ce<i then Begin
                     temprec:=vectobj[i];
                     vectobj[i]:=vectobj[ce];
                     vectobj[ce]:=temprec;
                     end;
        inc(racestatus.boxhit);
        end;
        techo:=true;

        end;

     end
     else techo:=false;
end;


Procedure Pisoadj;
Begin
Y:=(Y Div 25)*25-1;
end;

Function Wall

 : Boolean;
var i:byte;
Begin

WALL:=(at2(scene^[(X+acX DIV 4) div 25,(Y-10) div 25])) or
      (at2(scene^[(X+acX DIV 4) div 25,(Y-33) div 25]));
{for i:=1 to used do
if (vectobj[i].t<14) then if (X+acx div 4>=vectobj[i].x) and (x+acx div 4<vectobj[i].x+24)
                        and (
                            ( ((Y-10)>=vectobj[i].y) and ( (y-10)<vectobj[i].y+24) )
                            or
                            ( ((Y-33)>=vectobj[i].y) and ( (y-33)<vectobj[i].y+24)  )
                            )
                            then wall:=true;}


{    ((X+acX DIV 4)>=vectobj[i].X) and ((X+acX DIV 4)<=vectobj[i].X+24) AND
    (Y-33>=vectobj[i].Y) and (Y-5<=vectobj[i].Y+24) then wall:=true;}

end;

Procedure NEWROCK;
var i:byte;
Begin
if diamonds>0 then
i:=1;
Repeat
if not rock[i].used then Begin
                         rock[i].used:=true;
                         rock[i].acy:=0;
                         rock[i].x:=X+13;
                         rock[i].y:=Y-30;
                         rock[i].dir:=dir;
                         rock[i].spd:=abs(acx div 4);
                         i:=4;
                         dec(diamonds);
                         end;
inc(i);
until i>4;
end;



PROCEDURE CARRIT;
Begin
chboxes;
checkbads;
X:=bguys[carrito].X+20;
Y:=bguys[carrito].y+30;
frame:=8;
dir:=true;
if (X>1000) and  (x-80>datos.endX) then Begin
                                        finished:=true;
                                        carrito:=0;
                                        end;
if PISO or kb1 then begin
                         acy:=-13;
                         carrito:=0;
                     end;
end;








Begin
if racemode then Begin
                 inc(racestatus.frac,2);
                 if racestatus.frac=60 then begin

                                            racestatus.frac:=0;
                                            inc(racestatus.sec);
                                         if (numard=1) and (players=2) then if ardilla[2].finished then Dec(racestatus.tleft);
                                            if numard=2 then if ardilla[1].finished then Dec(racestatus.tleft);
                                            if racestatus.tleft=0 then finished:=true;
                                            if racestatus.sec=60 then Begin
                                                                      inc(racestatus.min);
                                                                      racestatus.sec:=0;
                                                                      end;

                                            end;
                 end;

if nrg in [1..8] then BEGIN
if carrito=0 then begin

if krt AND (ACX<XamaX) Then Begin
                            if ACX<0 then inc(ACX,2);
                            inc(ACx,2);
                            dir:=true;
                            end;
if klt AND (ACX>-XAMAX) then begin
                            if ACX>0 then dec(ACX,2);
                             dec(ACx,2);
                             dir:=false;
                             end;
{if acx>xamax then Acx:=Xamax;
if acx<-xamax then Acx:=-Xamax;}
if acx>xamax then Dec(Acx,2);
if acx<-xamax then inc(acx,2);
niveled:=false;
amax:=15;
if agua then amax:=5;
if (oldir) and (acy>0) THEN
   bEGIN if (bsa(scene^[(X) div 25,(Y) div 25]) in [15..21]) THEN INC(Y,25);
   IF (bsa(scene^[(X) div 25,(Y+25) div 25]) in [15..21]) THEN INC(Y,50);
END;
             oldir:=false;

IF (PISO  OR irregu ) and (acy>0) then Begin
             repeat
             if piso then pisoadj;
             if irregu then begin
                                 oldir:=true;
                                 irreguadj;
                            end;
             until not (piso or irregu);
             ACY:=1;
              niveled:=true;
              spin:=0;
             end;
if kb1 and (NIVELED) and (acy>=0) and kb1left then Begin
                                              playfx(1);
                                              acy:=-12;
                                              jump:=1;
                                              end;

if kb1 and (jump>0) and (jump<12) then begin
                                      if not agua then Begin
                                      inc(jump);
                                      if clk mod 2 =1 then inc(acy);
                                      end else begin
                                      if clk mod 2 =1 then inc(jump);
                                      if clk mod 2 =1 then inc(acy);
                                      end;
                                      end
                    else jump:=0;

if KB2 and niveled then XAMAX:=40
                   else XAMAX:=30;
if agua then Begin
             Xamax:=25;
             if (Random(50)=1) and (datos.levtype=4) then newv(x,y-30,230);
             end;

if reso then begin
             acy:=-20;
             resor:=1;
             newv(X,Y,240);
             end;
if resor>0 then inc(Resor);
if resor=9 then resor:=0;
if not krt and not klt then BEGIN
                       IF acx<0 then inc(Acx,1);
                       IF acx>0 then dec(Acx,1);
                       end;


if techo then Begin
        playfx(3);
              acY:=0;
              jump:=0;
              Y:=((Y-37) div 25*25)+61;
              end;


if (jump=0) and (ACY<AMAX) then inc(ACY,1);
if Acy>AMAX then Acy:=amax;



case mode of
1: begin
   if kb2 and (spin=0) and not niveled then spin:=20; {duracion del SPIN}
   if spin>1 then dec(spin);
   end;
2:begin
    if not kb2 or (acy<=0) or niveled then hframe:=0
                           else if hframe<4 then inc(hframe);
    if (acy>2) and (clk mod 2=1) and kb2 then acy:=2;
   end;
3:Begin
       if kb2 and kb2left then begin
                               hframe:=1;
                               newrock;
                               end;
       if hframe>0 then inc(hframe);
      if hframe>7 then hframe:=0;

  end;

end;

IF WALL then Begin
             wf:=true;
             if AcX>0 then X:=(X Div 25*25)+24;
             if AcX<0 then X:=(X Div 25*25);
             acx:=0;
              end else wf:=false;
inc(q);
if Q>=((35-abs(ACX)) DIV 5) then Begin
                                 inc(walk);
                                 q:=0;
                                 end;
if walk>7 then walk:=0;
if  niveled then
            if ((acx<-2) or (Acx>2)) and (not wf) then Begin
                             frame:=walk;
                             wait:=0;
                             end
                        else begin
                             frame:=8;
                             inc(wait);

                             case wait of
                                113..114:frame:=9;
                                115..145:frame:=10;
                                146..149:frame:=9;
                             end;
                             end
            else begin
                 if ACY>=0 then frame:=13
                       else frame:=11;
                 wait:=0;
                 end;

case mode of
 1:if spin>1 then frame:=16+(clk mod 4) div 2;
 2:if hframe>0 then frame:=13+hframe div 2;
 3:if (hframe>0) and (diamonds>0) then frame:=18;
 end;
things;
inc(Y,ACY);
inc(X,ACX DIV 4);
chboxes;

if titil<42 then inc(titil);
CheCkBaDs;
if pinche and (titil>40) and (invis=0) then Begin
                               playfx(4);

                              titil:=0;
                              dec(nrg);
                              end;

if red>0 then Dec(Red);
if invis>0 then begin
                Dec(invis);
                newv(X-26+random(30),Y-45+random(30),100);
                end;

if ((X>1000) and  (x-40>datos.endX)) or (key[SDLK_ESCAPE]) then finished:=true;
if key[$19] then nrg:=8;

end else carrit;
END else begin
         if nrg <=0 then Begin
                        nrg:=127;
                        acy:=-9;
                        end;
         Dec(nrg);
         carrito:=0;
        { newv(X-26+random(30),Y-45+random(30),110);}
         inc(acy);
         inc(y,acy);
         if nrg=80 then begin
         nrg:=8;
         X:=SaleDeX;
         Y:=SaleDeY;
         for i:=1 to 5 do newv(X-20+random(40),y-38+random(38),100);

         diamonds:=0;
         red:=0;
         mode:=0;
         ACX:=0;
         acy:=0;
         dec (lives)
         end;

         end;


kb1left:=not kb1;
kb2left:=not kb2;

end;



Procedure GRAY;
var i,j:word;
Begin
i:=0;
j:=0;

repeat
{line(i,0,i,199);
line(319-i,0,319-i,199);
line(0,j,319,j);
line(0,199-j,319,199-j);}
timervar:=0;
repeat until timervar>0;
inc(i);
inc(j);
until (j=100);
end;

Procedure checkCD;
Begin
if (timecd>lengthCD) and settings.musicacd then Begin
{                        Pauseaudio;
                        playsingle(muslev[Datos.Levtype]);
                        timecd:=0;}
                        end;
end;


Procedure GaMeMain;
var actual:byte;

Procedure CalCules;
var auz,auz2,auz3:byte;
Procedure KEys;
var wmsg:word;
Begin
inc(clk);
inc(clk2);
OLDX:=wX;
OLDY:=wY;
OLDX2:=X2;
OLDY2:=Y2;
IF key[SDLK_F1] Then VMODE:=1;
IF key[SDLK_F2] Then VMODE:=2;
IF key[SDLK_F3] Then VMODE:=3;
if canplay2 then begin
 IF key[SDLK_F4] Then VMODE:=4;
 IF key[SDLK_F5] Then VMODE:=5;
end;
IF key[SDLK_F6] Then VMODE:=6;
IF key[SDLK_F7] Then names:=not names;

(*IF key[120] Then Begin
                wmsg:=timervar;
                MSG(65,65,'VERTICAL RETRACE SI');
                copyscr2;
                repeat
                read_keys_from_input();
                until timervar>=wmsg+30;
                vr:=true;
                timervar:=wmsg;
                end;
IF key[121] Then Begin
                wmsg:=timervar;
                MSG(65,65,'VERTICAL RETRACE NO');
                copyscr2;
                {repeat}
                read_keys_from_input();
{                until timervar>=wmsg+30;}
                vr:=false;
                timervar:=wmsg;
                end;*)
IF key[SDLK_F11] Then Begin
                wmsg:=timervar;
                MSG(115,85,' PAUSA');
                MSG(65,105,'ESC PARA ABANDONAR');
                copyscr2;
                repeat
                read_keys_from_input();
                until not key[SDLK_F11];
                repeat
                if key[SDLK_ESCAPE] then begin
                               quito:=true;
                               repeat
                               read_keys_from_input();
                               until not key[SDLK_ESCAPE];
                               end;

               read_keys_from_input();
               until key[SDLK_F11] or quito;
                repeat
                read_keys_from_input();
                until (not key[SDLK_F11]) or (quito);
                timervar:=wmsg;
                end;



if settings.joyuse=1 then  begin

end else Begin
ardilla[1].Klt:=key[SDLK_LEFT] and (not key[SDLK_RIGHT]);
ardilla[1].Krt:=key[SDLK_RIGHT] and (not key[SDLK_LEFT]);
ardilla[1].Kb1:=key[SDLK_UP];
ardilla[1].Kb2:=key[SDLK_RCTRL];

end;
If settings.joyuse=2 then Begin

end else Begin
ardilla[2].Klt:=key[SDLK_A] and (not key[SDLK_C]);
ardilla[2].Krt:=key[SDLK_C] and (not key[SDLK_A]);
ardilla[2].Kb1:=key[SDLK_S];
ardilla[2].Kb2:=key[SDLK_V];
end;

case datos.levtype of
2: case clk mod 12 div 3 of

3:Begin
  SetRGB(227,0,0,34);
  SetRGB(197,1,1,50);
  SetRGB(196,27,27,56);
  SetRGB(195,38,38,63);
  end;
2:Begin
  SetRGB(195,0,0,34);
  SetRGB(227,1,1,50);
  SetRGB(197,27,27,56);
  SetRGB(196,38,38,63);
  end;
1:Begin
  SetRGB(196,0,0,34);
  SetRGB(195,1,1,50);
  SetRGB(227,27,27,56);
  SetRGB(197,38,38,63);
  end;
0:Begin
  SetRGB(197,0,0,34);
  SetRGB(196,1,1,50);
  SetRGB(195,27,27,56);
  SetRGB(227,38,38,63);
  end;
end;


4: case clk mod 12 div 3 of

0:Begin
  SetRGB(200,45,49,52);
  SetRGB(228,43,47,50);
  SetRGB(127,49,52,54);
  SetRGB(240,56,58,59);
  end;
1:Begin
  SetRGB(240,45,49,52);
  SetRGB(200,43,47,50);
  SetRGB(228,49,52,54);
  SetRGB(127,56,58,59);
  end;
2:Begin
  SetRGB(127,45,49,52);
  SetRGB(240,43,47,50);
  SetRGB(200,49,52,54);
  SetRGB(228,56,58,59);
  end;
3:Begin
  SetRGB(228,45,49,52);
  SetRGB(127,43,47,50);
  SetRGB(240,49,52,54);
  SetRGB(200,56,58,59);
  end;
end;

5:
  case clk mod 12 div 2 of
  4..5:Begin
            SetRGB(188,30,30,30);
            SetRGB(187,40,40,40);
            SetRGB(186,50,50,50);
       end;
  2..3:Begin
            SetRGB(186,30,30,30);
            SetRGB(188,40,40,40);
            SetRGB(187,50,50,50);
       end;
  0..1:Begin
            SetRGB(187,30,30,30);
            SetRGB(186,40,40,40);
            SetRGB(188,50,50,50);
       end;
   end;
6:begin
  auz:=bsa(Scene^[Ardilla[1].x div 25,(ardilla[1].y-10) div 25]);
  auz2:=bsa(Scene^[Ardilla[2].x div 25 ,(ardilla[2].y-10) div 25]);
  inside:=(((auz>26) and (auz<38)) or (auz=52) or (auz=14)) or ((auz2 in [27..37]) or (auz=52) or (auz=14));
  case clk mod 6 of
   0..2:begin
        SETRGB(181,20,4,44);
        SETRGB(221,13,49,60);
        end;
   3..5: begin
        SETRGB(221,20,4,44);
        SETRGB(181,13,49,60);
        end;
  end;
  end;

7:begin
Case Clk mod 6 div 2 of
0:Begin
       SetRGB(244,12,24,32);
       SetRGB(237,44,49,56);
       SetRGB(232,19,36,47);
       end;
1:Begin
       SetRGB(232,12,24,32);
       SetRGB(244,44,49,56);
       SetRGB(237,19,36,47);
       end;
2:Begin
       SetRGB(237,12,24,32);
       SetRGB(232,44,49,56);
       SetRGB(244,19,36,47);
       end;

end;
case rayo of
1: setRGB(165,34,40,42);
2: setRGB(248,34,40,42);
3: setRGB(253,34,40,42);
end;
if rayosi >0 then Begin
                rayos:=true;
                fillchar(pag2^[0,0],64000,110);
                if rayosi=3 then rayosi:=0
                           else inc(rayosi);
                end else rayos:=false;

rayo:=random(500);
case rayo of
1: setRGB(165,63,63,63);
2: setRGB(248,63,63,63);
3: setRGB(253,63,63,63);
end;
if rayo in [1..3] then rayosi:=1;
end;

9: if random(30)=1 then setRGB(186,9,9,9)
                   else setRGB(186,63,63,63);
10: if clk mod 3=1 then setRGB(240,50+random(13),50+random(13),50+random(13));
12:Case clk mod 6 div 2 of
0:Begin
       SetRGB(188,20,20,20);
       SetRGB(193,40,40,40);
       SetRGB(192,60,60,60);
  end;
1:Begin
       SetRGB(192,20,20,20);
       SetRGB(188,40,40,40);
       SetRGB(193,60,60,60);
  end;
2:Begin
       SetRGB(193,20,20,20);
       SetRGB(192,40,40,40);
       SetRGB(188,60,60,60);
  end;
  end;
14:Case clk mod 8 div 2 of
0:Begin
       SetRGB(124,51,0,0);
       SetRGB(125,54,0,0);
       SetRGB(126,57,0,0);
       SetRGB(127,63,0,0);
  end;
1:Begin
       SetRGB(125,51,0,0);
       SetRGB(126,54,0,0);
       SetRGB(127,57,0,0);
       SetRGB(124,63,0,0);
  end;
2:Begin
       SetRGB(126,51,0,0);
       SetRGB(127,54,0,0);
       SetRGB(124,57,0,0);
       SetRGB(125,63,0,0);
  end;
3:Begin
       SetRGB(127,51,0,0);
       SetRGB(124,54,0,0);
       SetRGB(125,57,0,0);
       SetRGB(126,63,0,0);
  end;
end;
end;
end;

Begin
keys;
if inmo>0 then dec(inmo);
if inmo=0 then CHECKB;
if players=1 then BEGIN

ardilla[1].ardproc(1);
ardilla[1].rockproc;
{checkt;}
if ardilla[1].nrg in [1..8] then begin
if ardilla[1].X<wX+140 then wx:=ardilla[1].x-140;
if ardilla[1].x>wx+160 then wx:=ardilla[1].x-160;
if ardilla[1].y<wY+90 then wy:=ardilla[1].Y-90;
if ardilla[1].y>wY+130 then wy:=ardilla[1].Y-130;
end;
IF wX<0 then wX:=0;
IF wY<0 then wY:=0;
if datos.levtype=6 then if wY+200>1270 then wY:=1070;
if wX+320>datos.ENDX then wX:=datos.ENDX-320;
{if key[sco] then newv(ardilla[1].X-26+random(30),ardilla[1].Y-45+random(30),100);
if key[scp] then newv(ardilla[1].X-26+random(30),ardilla[1].Y-45+random(30),210);
if key[sci] then ardilla[1].titil:=0;
if key[sc1] then ardilla[1].mode:=1;
if key[sc2] then ardilla[1].mode:=2;}
END
else BEGIN
if  not ((ardilla[1].lives=0) or (racemode and ardilla[1].finished)) then ardilla[1].ardproc(1);
if not ((ardilla[2].lives=0) or (racemode and ardilla[2].finished)) then ardilla[2].ardproc(2);
ardilla[1].rockproc;
ardilla[2].rockproc;

{checkt;}
if ardilla[1].nrg in [1..8] then begin
if ardilla[1].X<wX+140 then wx:=ardilla[1].x-140;
if ardilla[1].x>wx+160 then wx:=ardilla[1].x-160;
if ardilla[1].y<wY+90 then wy:=ardilla[1].Y-90;
if ardilla[1].y>wY+130 then wy:=ardilla[1].Y-130;
end;
if ardilla[2].nrg in [1..8] then begin
if ardilla[2].X<X2+140 then x2:=ardilla[2].x-140;
if ardilla[2].x>x2+160 then x2:=ardilla[2].x-160;
if ardilla[2].y<Y2+90 then y2:=ardilla[2].Y-90;
if ardilla[2].y>Y2+130 then y2:=ardilla[2].Y-130;
end;

IF wX<0 then wX:=0;
IF wY<0 then wY:=0;

IF X2<0 then X2:=0;
IF Y2<0 then Y2:=0;
if wX+320>datos.ENDX then wX:=datos.ENDX-320;
if X2+320>datos.ENDX then X2:=datos.ENDX-320     ;

{if key[sco] then newv(ardilla[1].X-26+random(30),ardilla[1].Y-45+random(30),100);
if key[sci] then ardilla[1].titil:=0;
if key[sc1] then ardilla[1].mode:=1;
if key[sc2] then ardilla[1].mode:=2;}
END;

CHECKT;
end;

Procedure DraWs;
var i:byte;
    st,ss,sf:string;
    pvid:pointer;

Procedure DP1;
var i:byte;
  go:boolean;
Begin
if datos.levtype<15 then Place_scroll(wX,wy);
if rayos then fillchar(pag2^[0,0],64000,110);
go:=false;
if not levinv[datos.levtype] then PoneC(wx,wy);

if not ((players=2) and (ardilla[1].lives=0)) then begin
for i:=1 to players do if ardilla[i].lives>0 then Begin
if names and (players=2) then PutThingV(ardilla[i].x-wx-10,ardilla[i].y-67-wy,24+i);
if (ardilla[i].titil in [2..40]) and (clk mod 2 =1) then
    ardilla[i].PUTSQ(ardilla[i].x-wX-20,ardilla[i].y-wY-38,ardilla[i].frame);
if (ardilla[i].titil in [0..1]) and (clk mod 2 =1) then ardilla[i].PUTSQ(ardilla[i].x-wX-20,ardilla[i].y-wY-38,12);
if ardilla[i].titil>40 then ardilla[i].PUTSQ(ardilla[i].x-wX-20,ardilla[i].y-wY-38,ardilla[i].frame);
end;
end else go:=true;
PoneM(wx,wy);
if levinv[datos.levtype] then PoneC(wx,wy);
PoneV(wx,wy);
if datos.levtype=15 then Place_scroll(wX,wy);

ardilla[1].drawrock(wx,wy);
ardilla[2].drawrock(x2,y2);

if players=2 then ardilla[2].drawrock(wx,wy);
MSG(70,2,'DIAMANTES');
str(ardilla[1].coins,st);
MSG(100,12,st);
MSG(150,2,'VIDAS');
str(ardilla[1].lives,st);
MSG(165,12,st);
if ardilla[1].mode=3 then begin
MSG(200,2,'ROCAS');
str(ardilla[1].diamonds,st);
MSG(210,12,st);
end;
if nivel_De_malo then begin
MSG(5,185,'jefe');
for i:=2 to energia_De_malo do PutthingV(27+(10*i),175,21);
end;
MSG(1,2,'ENERGIA');
if ardilla [1].nrg in [1..8] then For i:= 0 to ardilla[1].nrg-1 do PutthingV(5+(7*i),1,28);
if go then MSG(90,95,'GAME OVER');
if ardilla[1].finished and racemode then MSG(110,95,'termino');
if datos.levtype=3 then nieve;
if datos.levtype=7 then lluvia;
if datos.levtype=4 then Begin
                            If (wY<1364) and (wY+199>1364) then boxblue(1364-wY);
                            if wY>=1364 then BoxBlue(0);
                            For i:= 0 to 13 Do PutThing(-(Clk mod 25)+i*25,1339-wY,57+((clk+i) mod 6 div 2));
                            end;
if racemode then Begin
str(ardilla[1].racestatus.min,st);
str(ardilla[1].racestatus.sec,ss);
str(ardilla[1].racestatus.frac,sf);
MSG(130,40,'Tiempo '+st+' '+ss+' '+sf);
str(ardilla[1].racestatus.tleft,sf);
if ardilla[1].racestatus.tleft<30 then msg(180,180,sf);
end;
if inmo>0 then redscr;
end;

Procedure DP2;
var i:byte;
    go:boolean;
Begin
if datos.levtype<15 then Place_scroll(X2,y2);

if rayos then fillchar(pag2^[0,0],64000,110);
if not levinv[datos.levtype] then PoneC(x2,y2);
go:=false;
if ardilla[2].lives>0 then begin
for i := 1 to players do if ardilla[i].lives>0 then Begin
if names then PutThingV(ardilla[i].x-x2-10,ardilla[i].y-67-y2,24+i);

if (ardilla[i].titil in [2..40]) and (clk mod 2 =1) then
    ardilla[i].PUTSQ(ardilla[i].x-X2-20,ardilla[i].y-Y2-38,ardilla[i].frame);
if (ardilla[i].titil in [0..1]) and (clk mod 2 =1) then ardilla[i].PUTSQ(ardilla[i].x-X2-20,ardilla[i].y-Y2-38,12);
if ardilla[i].titil>40 then ardilla[i].PUTSQ(ardilla[i].x-X2-20,ardilla[i].y-Y2-38,ardilla[i].frame);
end;
end else go:=true;


PoneM(x2,y2);
if levinv[datos.levtype] then PoneC(x2,y2);
PoneV(x2,y2);
if datos.levtype=15 then Place_scroll(X2,y2);
ardilla[1].drawrock(x2,y2);
ardilla[2].drawrock(x2,y2);
MSG(70,2,'DIAMANTES');
str(ardilla[2].coins,st);
MSG(100,12,st);
MSG(150,2,'VIDAS');
str(ardilla[2].lives,st);
MSG(165,12,st);
MSG(1,2,'ENERGIA');
if ardilla [2].nrg in [1..8] then For i:= 0 to ardilla[2].nrg-1 do PutthingV(5+(15*(i mod 4)),1,28);

if go then MSG(110,95,'GAME OVER');
if ardilla[2].finished and racemode then MSG(110,95,'termino');

if datos.levtype=3 then nieve2;
if datos.levtype=7 then lluvia;
if datos.levtype=4 then Begin
                            If (Y2<1364) and (Y2+199>1364) then boxblue(1364-Y2);
                            if Y2>=1364 then BoxBlue(0);
                            For i:= 0 to 13 Do PutThing(-(Clk mod 25)+i*25,1339-Y2,57+((clk+i) mod 6 div 2));
                            end;
if racemode then begin
str(ardilla[2].racestatus.min,st);
str(ardilla[2].racestatus.sec,ss);
str(ardilla[2].racestatus.frac,sf);
MSG(130,40,'Tiempo '+st+' '+ss+' '+sf);
str(ardilla[2].racestatus.tleft,sf);
if ardilla[2].racestatus.tleft<30 then msg(180,180,sf);
end;
if inmo>0 then redscr;
END;



Begin
if players=1 then Begin
DP1;
copyScr2;
end
else Begin
case VMODE of
1:begin
DP1;
copyScr2;
end;
2: Begin
DP2;
copyScr2;
end;
3:Begin
DP1;
For i:=0 to 99 do Begin
                  MOVE(Pag2^[i*2],VirVidBuff^[i*320],320);
                  end;
DP2;
For i:=0 to 99 do Begin
                  MOVE(Pag2^[i*2,0],VirVidBuff^[i*320+31999],320);
                  end;
updatevid;
end;
4:Begin
DP1;
move(pag2^[0,0],VirvidBuff^[0],64000);
Dp2;
ZBitmap(25,25,100,70,320,200,@pag2^[0]);
updatevid;
end;
5:Begin
DP2;
move(pag2^[0,0],VirvidBuff^[0],64000);
Dp1;
ZBitmap(25,25,100,70,320,200,@pag2^[0]);
updatevid
end;
6:Begin
DP1;
MOVE(Pag2^[50,0],VirVidBuff^[0],32000);
Dp2;
MOVE(Pag2^[50,0],VirVidBuff^[31999],32000);
updatevid;
end;


end;
end;

end;

var i:byte;
    pi,qi:byte;
    TMain:word;
    Li,Lj:word;
    chowa:longint;
    time_delta:longint;
    time_last:longint;
    cuad:longint;
    frame_msecs:longint;
    ttake:longint;
Begin
if settings.musicacd then begin
end;
if racemode then vmode:=3;
ftime:=1;
Calcules;
Calcules;
Calcules;
Calcules;
draws;
move(VirVidBuff^[0],Pag2^[0],64000);
timervar:=0;

ftime:=0;
for pi:=1 to players do for qi:=1 to 5 do newv(ardilla[pi].X-20+random(40),ardilla[pi].y-38+random(38),100);

        frame_msecs:=40;

	cuad:=SDL_GetTicks() div frame_msecs;
      time_delta:=SDL_GetTicks();
      TTake:=time_delta div frame_msecs;
repeat
checkcd;


{      copyscr2;}
{      calcules;} {}
{      timercount:=0;}
      read_keys_from_input();
{      Sleep(15);}
      {SDL_Delay(25);}


      time_delta:=SDL_GetTicks();
      TTake:=time_delta div frame_msecs;
      if TTake>cuad then
      begin
      	for re:=1 to (TTake-cuad) do Calcules;

      end;


	cuad:=TTake;

	 Draws; {}
		time_delta:=SDL_GetTicks();
		TTake:=time_delta div frame_msecs;
		read_keys_from_input();

        while (ttake<=cuad) do
        begin

{        	SDL_Delay(1);}
		time_delta:=SDL_GetTicks();
		TTake:=time_delta div frame_msecs;
		read_keys_from_input();
        end;

       
if key[scesc] then ardilla[1].finished:=true;       
until quito or ((players=1) and (ardilla[1].lives<=0) or
                ((players=2) and (ardilla[1].lives<=0) and (ardilla[2].lives<=0)))
                or ((not RACEMODE) and (ardilla[1].finished or ardilla[2].finished)) or
                (RACEMODE and ardilla[1].finished and ardilla[2].finished) or
                (racemode and (ardilla[1].racestatus.min=255)) or
                (racemode and (ardilla[2].racestatus.min=255))
                or (Racemode and ((ardilla[2].lives=0)) or (ardilla[1].lives=0));





if music then
if ardilla[1].finished or ardilla[2].finished then Begin
                                                   stopmusic;
                                                   playmusic('win.mid');
                                                   end else begin
                                                   stopmusic;
                                                   playmusic('die.mid');
                                                   end;


if (ardilla[1].finished or ardilla[2].finished) then MSGV(81,95,'NIVEL TERMINADO')
                           else MSGV(110,95,' GAME OVER');


{gray;}
end;

Procedure continiu(Cual:byte);
var g:string[4];
Begin
flp:=0;
if ardilla[cual].cont>0 then begin
{fillchar(pag2^[0],64000,0);}
ReadPCXP('ngo.pcx',pag2^[0]);
copyscr2;
str(cual,g);
MSG(50,50,'JUGADOR '+g);
str(ardilla[cual].cont,g);
MSG(70,70,'te quedan '+g+' continues');
MSG(20,90,'presiona y para seguir');     
MSG(90,110,'  o n para abandonar');
str(passlist[passtab[playlevel]],g);
MSG(90,130,'tu password es '+g);

copyscr2;

repeat
read_keys_from_input();
until key[SDLK_y] or key[SDLK_n];
if key[SDLK_y] then begin
               Dec(ardilla[cual].cont);
               ardilla[cual].lives:=4;
               ardilla[cual].coins:=0;

               end
          else ardilla[cual].cont:=0;

repeat
read_keys_from_input();
until (not key[SDLK_y]) or (not key[SDLK_n]);

end;
end;


end.


