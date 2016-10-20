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
unit wcr_transcriptor;

interface

uses
  Windows, Messages, SysUtils, Classes,  Graphics, Controls, Forms, shellapi,
  Dialogs, StdCtrls, DateUtils, ComCtrls,math, wcr_Parser_Events, wcr_Const, wcr_utils,
  wcr_ressource,VirtualTrees, wcr_Hash;

procedure AnalyseTranscriptorLine(var openlogstate,numparse,idformat:integer; var authparse, authChatParse:boolean; vttree:TVirtualStringTree ;eventlist:tlist;t:string);
function AnalyseTranscriptorEvent(t:string; idformat,basetime:integer):pEvent;
function AnalyseTranscriptorChatEvent(t:string; idformat,basetime:integer):pChatEvent;
function GettranscriptorHeaderList:boolean;

var transcriptorHeaderList: tstringlist;
    transcriptorLogEvent:string;
    transcriptorMainSection:string;

implementation


function GettranscriptorHeaderList:boolean;
var i:integer;
   tmplist:tstringlist;
   strtmp:string;
begin
  tmplist:=tstringlist.Create;
  transcriptorHeaderList.Clear;
  try
  if fileexists (datapath+ transcriptorHeaderFile) then tmplist.LoadFromFile(datapath+ transcriptorHeaderFile);
  for i:=0 to tmplist.count-1 do
  begin
    strtmp:= trim(tmplist.strings[i]);
    if is_comment(strtmp) then continue;
    if getfirsttoken(strtmp,'=') = 'logevent' then transcriptorLogEvent:=trim(getlasttoken(strtmp,'='))
    else if getfirsttoken(strtmp,'=') = 'mainsection' then transcriptorMainSection:=trim(getlasttoken(strtmp,'='))
    else if getfirsttoken(strtmp,'=') = 'chatsection' then transcriptorHeaderList.Add(trim(getlasttoken(strtmp,'=')));
  end;
  finally
    tmplist.Free;
    result:= (transcriptorLogEvent<>'') and (transcriptorMainSection<>'');
  end;
end;


procedure AnalyseTranscriptorLine(var openlogstate,numparse,idformat:integer; var authparse, authChatParse:boolean; vttree:TVirtualStringTree ;eventlist:tlist;t:string);
var p:pevent;
    c:pChatEvent;
    i:integer;
begin
  t:=trim(t);
  if pos('{', t)>0 then inc(openlogstate);
  if pos('}', t)>0 then dec(openlogstate);
  if openlogstate<3 then begin  authparse:=false; authChatParse:=false; idformat:=-1; end;

  if authparse then
  begin
    if (idformat = -1) and (pos(transcriptorLogEvent, t)>0) then idformat:=ord(pos('#', t)>0);
    p:=AnalyseTranscriptorEvent(t, idformat, numparse * (100*60*60));
    if assigned(p) then
    begin
      getEventlist(p);
      eventlist.Add(p);
    end;
  end;

  if authchatparse then
  begin
    //if idformat = -1 then idformat:=ord(pos('#', t)>0);
    c:=AnalyseTranscriptorChatEvent(t, idformat, numparse * (100*60*60));
    if assigned(c) then vttree.AddChild(nil,TNodeGenericData.create(c));
  end;

  if (not authchatparse) and (not authparse) and (openlogstate=3) then
  begin
        if (pos(transcriptorMainSection, t)> 0)  then
        begin
          authparse :=true;
          inc(numparse,3);
        end
        else
        if transcriptorHeaderList.count>0 then
        begin
          for i:=0 to transcriptorHeaderList.count-1 do
          if pos(transcriptorHeaderList.strings[i], t)> 0 then
          begin
            authchatparse :=true;
            break;
          end;
        end;
  end;
end;

function AnalyseTranscriptorEvent(t:string;idformat,basetime:integer):pEvent;
var
  s:rParsedString;
  c:char;
  i,j,tai:integer;
  eventtime:integer;
const
  SEPARATOR:array[0..1] of array[1..30] of char = (('<','.','>',' ',' ',':',':',':',':',':',':',':',':',':',':',':',':',':',':',':',':',':',':',':',':',':',':',':',':',':'),
                                                  ('<','.','>',' ',' ','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#'));
begin
    result:=nil;
    if (idformat=-1) or (t='') then exit;
    i:=1;
    tai:=length(t);
    for j:= 1 to Tai do
    begin
      c:=t[j];
      //workaround spell/unit with ":" in their name
      if (i> 7) and (idformat = 0) then
      begin
        if (c=SEPARATOR[idformat,i]) and (((j+1)<length(t)-1) and (t[j+1]<>' '))  then inc(i) else s[i+1]:=s[i+1]+c;
      end
      else if (c=SEPARATOR[idformat,i]) then inc(i) else  s[i+1]:=s[i+1]+c;
      if i=6 then if not (s[6]=transcriptorLogEvent) then exit;
    end;
    eventtime:= (strtointdef(s[3],0)*100+strtointdef(s[4],0)*10)+basetime;
    result:=pEvent.initdata(s,eventhash(format(' %s',[s[7]])), eventtime,unknownEventlist, i);
end;


function AnalyseTranscriptorChatEvent(t:string; idformat, basetime:integer):pChatEvent;
var
  s:array[1..6] of string;
  c:char;
  i,j,tai:integer;
  eventtime:integer;
const
  SEPARATOR:array[1..5] of char = ('<','.','>',' ','"');
begin
    fillchar(s,sizeof(s),0);
    result:=nil;
    t:=trim(t);
    if t=''then exit;
    i:=1;
    tai:=length(t);
    for j:= 1 to Tai do
    begin
      c:=t[j];
      if i=6 then break;
      if (i<6) and (c=SEPARATOR[i]) then inc(i) else  s[i]:=s[i]+c;
    end;

    //pas de texte
    s[5]:=trim(s[5]);
    if s[5]='' then exit;

    s[5]:=stringreplace(s[5],'#',':',[rfReplaceall]);
    s[5]:=stringreplace(s[5],'<','',[rfReplaceall]);
    s[5]:=stringreplace(s[5],'>','',[rfReplaceall]);

    eventtime:= (strtointdef(s[2],0)*100+strtointdef(s[3],0)*10)+basetime;
    result:=pChatEvent.initdata(s[5],eventtime);
end;

end.
