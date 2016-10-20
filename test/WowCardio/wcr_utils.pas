{
  WowCardioRaid by Tixu
  tixu.scribe[arobase]gmail.com

  The contents of this file are subject to the Mozilla Public License
  Version 1.1 (the "License"); you may not use this file except in
  compliance with the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/

  Software distributed under the License is distributed on an "AS IS"
  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
  License for the specific language governing rights and limitations
  under the License.


  Note on extra Components used by this Tool:

  VirtualStringTree: written by Mike Lischke (public@soft-gems.net, www.soft-gems.net).
  G32: http://graphics32.org/wiki/
  ZLibex: 1.2.3 www.dellapasqua.com
  NideSideBar: http://www.priyatna.org/nicesidebar.php
  HtmlViewer: http://code.google.com/p/thtmlviewer/
}
unit wcr_utils;

interface
uses SysUtils, Classes, wcr_const, zlibex, GR32;

type
timeopt = (toshowFilename,toShowNormal, toShowNormalnoMs,toShowFullTime, toShowOnlyDate, toShowDateAndMn);
stringArray = array of string;

TPParse = procedure(parsedline:stringArray);


bossopt = (
  bossisHM,
  bossis25
);
sbossopts= set of bossopt;

bossopt2 = (
  bossisdown
);
sbossopt2s= set of bossopt2;


rWcrBossInfo = record
  bossid:integer;
  bosstry:smallint;
  bossopts :sbossopts;
  bossopt2s :sbossopt2s;
end;

rWcrContent= record
    startTime:ttimestamp;
    reserved1:string[12];
    bosslist:array[0..30] of rWcrBossInfo;
    playerList: array[0..30] of string[16];
    newlogArrayIndex:word;
    utf8Tag:byte;
    reserved2:Byte;
    comment: string[92];
end;

rWcrFileContent= record
  modifiedtime:tdatetime;//time of the file (not time of the log)
  name:string[255];
  content:rWcrContent;
  wcrheader:cardinal;
end;

tWcrFile = class
    public
      path:string;
      content:rWcrFileContent;
      flag: boolean;
      constructor create(n,p:string;c:rWcrContent;w:cardinal;t:tdatetime);
end;

function AddLocalTimeToBaseTime(tmpTimeStamp:ttimestamp;t:integer):ttimestamp;
function GetRealTimeFromTimeEvent(tmpTimeStamp:ttimestamp;t,startTime:integer; opt:timeopt = toShowNormal):string;
function GetFormattedLocalTime(t:integer;drawsign:boolean):string;
function getfilesize(filename:string): longint;

function divide(x,y:integer):Double; overload;
function divide(x:integer;y:double):Double; overload;
function divide(x:double;y:double):Double; overload;
function divide(x,y:int64):Double; overload;
function divide(x:int64;y:double):Double;overload;

function is_comment(t:string):boolean;
procedure init_tStringlist(var t:tstringlist; path,filename:string);
procedure ParseBaseFile(filename:string; separator:char; arraysize:integer; const func: TPParse);
function AnalyseString(t:string;arraysize:integer; separator:char):stringArray ;

function compresse_zlib(InputStream:tmemorystream;OutputFileName:string;WcrContent:rWcrContent):boolean;
function decompresse_zlib(f:tmemorystream;inputStream:TFileStream;oldformat:boolean):boolean;

function append_legit_string (t,appendstr:string):string;
function parenthese_string (t:string):string;
function bracket_string(t:string):string;

function header_string (t:string):string;
function NoZeroValue(value:integer):integer;
procedure saveIndexCache(l:tlist;dir:string);
function generateDirList(l:tlist;dir:string; useCache:boolean):integer;
function getlogcontent(filename:string; var wcrheader:cardinal) :rWcrContent;
function htmlInsecable(str:string):string;


//--------from unit SjrdStrUtils; --->
function GetfirstToken(S : string; Token : Char) : string;
function GetLastToken(S : string; Token : Char) : string;
//<--------------
function get_icon32(tmp:tbitmap32;tai,id:integer):tbitmap32;
function getauracolor (predefid:integer):tcolor32;
function DateTimeInfo(const path : string;flag:integer): TDateTime;

function CleanString(s:string):string;
function Utf8conditional(s:shortstring;b:boolean):string;

implementation

function Utf8conditional(s:shortstring;b:boolean):string;
begin
  if b then result:=utf8tostring(s) else result:=string(s);
end;

function CleanString(s:string):string;
begin
  result:=stringreplace(s,'"','',[rfReplaceAll]);
  result:=stringreplace(result,'\','',[rfReplaceAll]);
end;

function getauracolor(predefid:integer):tcolor32;
begin
  if predefid<=high(AURA_COLOR_PREDEF) then
    result:=AURA_COLOR_PREDEF[predefid]
  else
    result:= Color32(random(200)+50, random(200)+50, random(200)+50,$77);
end;

function get_icon32(tmp:tbitmap32;tai,id:integer):tbitmap32;
var MyRect,MyOther:TRect;
begin
   result:=tbitmap32.Create;
   result.SetSize(tai,tai);
   MyRect :=Rect(id*tai,0,id*tai+tai,tai);
   MyOther :=Rect(0,0,tai,tai);
   tmp.drawto(result,myother,myrect);
   result.DrawMode:=dmTransparent ;
   result.OuterColor:=$FFFFFFFF;
end;

function htmlInsecable(str:string):string;
begin
  result:=stringreplace(str,' ',HTML_NBSP,[rfreplaceall]);
end;

//--------from unit SjrdStrUtils; --->
function GetFirstToken(S : string; Token : Char) : string;
var I : integer;
begin
  I := 1;
  while (I <= Length(S)) and (S[I] <> Token) do inc(I);
  Result := Copy(S, 1, I-1);
end;

function GetLastToken(S : string; Token : Char) : string;
var I : integer;
begin
  I := Length(S);
  while (I > 0) and (S[I] <> Token) do dec(I);
  Result := Copy(S, I+1, Length(S));
end;
//<-----------------------


constructor tWcrFile.create(n,p:string;c:rWcrContent;w:cardinal;t:tdatetime);
begin
  content.name:=ansistring(n);
  path:=p;
  content.content:=c;
  content.wcrheader:=w;
  content.modifiedtime:=t;
  flag:=true;
end;

function DateTimeInfo(const path : string; flag:integer): TDateTime;
var
   sr : TSearchRec;
begin
  //flag: faAnyFile/faDirectory
   result:=-1;
   if sysUtils.FindFirst(path, flag, sr) = 0 then
   try
     result := FileDateToDateTime(sr.Time) ;
   finally
    FindClose(sr) ;
   end
end;

function getIndexCache(dir:string;l:tlist):boolean;
var f:TfileStream;
    fc:rWcrFileContent;
begin
  result:=false;
  if not fileexists(dir+INDEXCHACHEFILE) then exit;
  f := TFileStream.Create(dir+INDEXCHACHEFILE, fmOpenRead);
  try
    try
        while f.Position<f.size do
           if f.read(fc, sizeof(rWcrFileContent))= sizeof(rWcrFileContent) then
                l.add(tWcrFile.create(utf8tostring(fc.name),dir,fc.content,fc.wcrheader,fc.modifiedtime));
        result:=true;
    except
    end;
  finally
    f.free;
  end;
end;

procedure saveIndexCache(l:tlist;dir:string);
var f:TfileStream;
    i:integer;
begin
  if l.count= 0 then exit;
  f:=TfileStream.Create(dir+INDEXCHACHEFILE, fmCreate or fmShareExclusive);
  try
    try
        for i:=0 to l.count-1 do
          if not f.Write(tWcrFile(l.items[i]).content,sizeof(rWcrFileContent)) = sizeof(rWcrFileContent) then break;
    except
    end;
  finally
    f.free;
  end;
end;


function generateDirList(l:tlist;dir:string; useCache:boolean):integer;
var i,j:integer;
    sr : TSearchRec;
    c:rWcrContent;
    wcrheader:cardinal;
    foundincache:boolean;
begin
  result:=0;
  if usecache and (l.Count =0) then getIndexCache(dir,l);
  //reset flag
  for j:=0 to l.count-1 do tWcrFile(l.items[j]).flag:=false;
  //search
  i:=FindFirst(dir+'*.wcr', faAnyFile, sr);
  while i=0 do
  begin
    foundincache:=false;
    for j:=0 to l.count-1 do
    begin
      if (tWcrFile(l.items[j]).content.modifiedtime = sr.time) and (tWcrFile(l.items[j]).content.name= ansistring(sr.name)) then
      begin
        tWcrFile(l.items[j]).flag:=true;
        foundincache:=true;
        break;
      end;
    end;
    if not foundincache then
    begin
      wcrheader:=0;
      c:=getlogcontent(dir+sr.name,wcrheader);
      l.add(tWcrFile.create(sr.Name,dir,c,wcrheader,sr.time));
      inc(result);
    end;
    i:=FindNext(sr);
  end;
  FindClose(sr);
  //reset unflagged item
  for j:=l.count-1 downto 0 do
    if not tWcrFile(l.items[j]).flag then
    begin
      tWcrFile(l.items[j]).free;
      l.Delete(j);
    end
end;

function getlogcontent(filename:string; var wcrheader:cardinal) :rWcrContent;
var InputStream:TfileStream;
begin
  fillchar(result, sizeof(result),0);
  InputStream := TFileStream.Create(FileName, fmOpenRead);
  try
    try
      Inputstream.read(wcrheader, sizeof(wcrheader));
      if wcrheader  >=  WCRFILE_HEADERV2 then Inputstream.read(result, sizeof(result));
    except
    end;
  finally
    InputStream.free;
  end;
end;

function NoZeroValue(value:integer):integer;
begin
  if value < 1 then result:=1 else result:=value;
end;

function append_legit_string (t,appendstr:string):string;
begin
  if t='' then result:='' else result:=appendstr;
end;

function parenthese_string(t:string):string;
begin
  if t='' then result:='' else result:= ' ('+t+') ';
end;

function bracket_string(t:string):string;
begin
  if t='' then result:='' else result:= ' ['+t+'] ';
end;

function header_string(t:string):string;
begin
  if t='' then result:='' else result:= t+'::';
end;

function compresse_zlib(InputStream:tmemorystream;OutputFileName:string;WcrContent:rWcrContent):boolean;
var   OutputStream: TFileStream;
      CompressionStream: TZCompressionStream;
begin
   result:=false;
   OutputStream:=nil;
   CompressionStream:=nil;
   try
     try
       OutputStream := TFileStream.Create(OutputFileName, fmCreate);
       OutputStream.Write(WCRFILE_HEADER,sizeof(WCRFILE_HEADER));
       OutputStream.Write(WcrContent,sizeof(rWcrContent));
       CompressionStream := TZCompressionStream.Create(OutputStream);
       CompressionStream.CopyFrom(InputStream,0);
       result:=true;
     except
     end;
   finally
    CompressionStream.Free;
    OutputStream.Free;
   end;
end;

function decompresse_zlib(f:tmemorystream;inputStream:TFileStream;oldformat:boolean):boolean;
var   DeCompressionStream: TZDecompressionStream;
begin
      result:=false;
      f.Position:=0;
      DecompressionStream:=nil;
      try
        try
            //------ decomp---------

            if oldformat then
              Inputstream.Position:= sizeof(WCRFILE_HEADER)
            else
              Inputstream.Position:= sizeof(rWcrContent)+sizeof(WCRFILE_HEADER);

            DecompressionStream := TZDecompressionStream.Create(InputStream);
            f.SetSize(DecompressionStream.Size);
            f.CopyFrom(DecompressionStream, 0);
            f.Position:=0;
            result:=true;
        except
        end;
      finally
        DecompressionStream.Free;
      end;
end;

function divide(x,y:int64):Double;
begin
  if y=0 then result:=0.0
  else result:= x/y;
end;

function divide(x,y:integer):Double;
begin
  if y=0 then result:=0.0
  else result:= x/y;
end;

function divide(x:integer;y:double):Double;
begin
  if y=0.0 then result:=0.0
  else result:= x/y;
end;

function divide(x:int64;y:double):Double;
begin
  if y=0.0 then result:=0.0
  else result:= x/y;
end;

function divide(x:double;y:double):Double;
begin
  if y=0.0 then result:=0.0
  else result:= x/y;
end;

function getfilesize(filename:string): longint;
var SearchRec:TSearchRec;
    Resultat:integer;
begin
  Result:=0;
  Resultat:=FindFirst(filename, FaAnyFile, SearchRec);
  if Resultat=0 then Result:=SearchRec.Size div APPLICATIONREFRESH;
  FindClose(SearchRec);
end;

function GetFormattedLocalTime(t:integer;drawsign:boolean):string;
var centi,seconds, minutes, hours:integer;
    tag:string;
begin
  if drawsign then
  begin
    if t<0 then
      tag:='-'
    else
      tag:='+';
  end
  else
    tag:='';

  t:=abs(t);
  seconds := t div 100; centi:= t mod 100;
  minutes := seconds div 60; seconds := seconds mod 60;
  hours := minutes div 60; minutes := minutes mod 60;
  if hours>0 then
    result:=format(tag+'%.2d:%.2d.%.2d''%.2d''''',[hours, minutes, seconds, centi])
  else
    result:=format(tag+'%.2d.%.2d''%.2d''''',[minutes, seconds, centi]);
end;

function AddLocalTimeToBaseTime(tmpTimeStamp:ttimestamp;t:integer):ttimestamp;
var tmpTime:integer;
begin
  tmpTime:= (tmptimestamp.Time div 10) + t;
  result.date:=tmpTimeStamp.date;
  //ajustment des changements de jours
  if tmpTime>(MAX_CENTI_SECOND) then
  begin
        result.Date:= result.Date+ integer(tmpTime div (MAX_CENTI_SECOND));
        result.time:= integer(tmpTime mod MAX_CENTI_SECOND) * 10;
  end
  else result.time:= integer(tmpTime) * 10;
end;

function GetRealTimeFromTimeEvent(tmpTimeStamp:ttimestamp;t,startTime:integer; opt:timeopt = toShowNormal):string;
var Year,Month,Day,Hour,Min,Sec,MSec:Word;
    tmpdatetime:tDatetime;
begin
  if starttime>0 then
  begin
    result:=GetFormattedLocalTime(t-starttime,true);
  end
  else
  begin
      tmpdatetime:=TimeStampToDateTime(AddLocalTimeToBaseTime(tmpTimeStamp,t));
      decodetime(tmpdatetime,Hour,Min,Sec,MSec);
      case opt of
       toshowFilename:begin
                        DecodeDate(tmpdatetime,Year,Month,Day);
                        result:=format('%.2d_%.2d__%.2d_%.2d',[Month,day,Hour,Min]);
                      end;
       toShowNormalnoMs:result:=format('%.2d:%.2d:%.2d',[Hour,Min,Sec]);
       toShowFullTime:begin
                    DecodeDate(tmpdatetime,Year,Month,Day);
                    result:=format('%.2d/%.2d  %.2d:%.2d:%.2d.%.2d',[Month,day,Hour,Min,Sec,MSec div 10]);
                  end;
       toShowOnlyDate:begin
                    DecodeDate(tmpdatetime,Year,Month,Day);
                    result:=format('%.2d/%.2d',[Month,day]);
                  end;
       toShowDateAndMn:begin
                    DecodeDate(tmpdatetime,Year,Month,Day);
                    result:=format('%.2d/%.2d  %.2d:%.2d',[Month,day,Hour,Min]);
                  end;
       else result:=format('%.2d:%.2d:%.2d.%.2d',[Hour,Min,Sec,MSec div 10]);
       end;
   end;
end;


procedure init_tStringlist(var t:tstringlist; path,filename:string);
var i:integer;
begin
  t:=tstringlist.Create;
  if fileexists(path+filename) then t.LoadFromFile(path+filename);
  for i:=t.Count-1 downto 0 do
    if is_comment(t.strings[i]) then t.Delete(i);
end;


function is_comment(t:string):boolean;
begin
  result:=(t='') or (t[1] = '#');
end;

procedure ParseBaseFile(filename:string; separator:char; arraysize:integer; const func: TPParse);
var f:textfile;
    strtmp:string;
begin
  if not fileexists(filename) then exit;
  AssignFile(f,filename);
    try
      try
      Reset(f);
      while not eof(f) do
      begin
        readln(f,strtmp);
        func(AnalyseString(strtmp,arraysize,separator)); //
      end
      except
      end;
    finally
       closeFile (f);
    end;
end;


function AnalyseString(t:string;arraysize:integer; separator:char):stringArray ;
var i,j:integer;
    c:char;
begin
  setlength (result,0);
  setlength (result,arraysize);
  t:=trim(t);
  if is_comment(t) then exit;
  i:=0;
  for j:= 1 to length(t) do
  begin
     c:=t[j];
     if (c=SEPARATOR) then
     begin
       inc(i);
       if i> arraysize then exit;
     end
     else result[i]:=result[i]+c;
  end;
end;


end.

