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
unit wcr_hintdatas;

interface
uses StrUtils,SysUtils, Classes, wcr_Parser_Events, wcr_utils, wcr_const, wcr_stats;

type
rStringHint= array[0..20] of string;
tHtmlParse = function (p:pointer;tagref,value1:integer):string;

function fillHintData(StartTimeStamp:ttimestamp;startTime:integer;p:pEvent;l:tlist):string;
function fillHintDataStat(basetemplate:string;ul:tUnitData;statlvl:integer):string;
function  fillHintDataDetailledStat(basetemplate:string; p,ptot:pointer; tag:integer):string;
function fillHintChat(strtmp:string):string;
function gethinttemplate(path,filename:string):string;
procedure parseHint(s:rStringHint;const ParsedTagList: array of string ;var h:string);
function parseHtml(const getParse: tHtmlParse; p:pointer; value1:integer; basestring:string):string;
function getHtmlTemplate(path,filename:string):tstringlist;
procedure cleanAllHtmlTemplate;

//html
procedure parsehtmlStats(template:tstringlist;ts:tstringlist; Rotationlines:rrotationlines; menustats:integer);
procedure parsehtmlblockContent(ts,sourcets:tstringlist; totalStat:trotationline; l:tlist);

function fillDataStats(p:pointer;tagref,value1:integer):string;
function fillDataStatsTT(p,ptot:pointer;tagref,value1:integer):string;
function fillDataStatsNum(p:pointer;tagref,value1:integer):int64;
function fillHtmlDataIndex(p:pointer;tagref,value1:integer):string;

function getStatSpellOptions(Rotationline:tRotationline;opt:byte):string;
function getformattedstatsvalue(value,total:integer):string;overload;
function getformattedstatsvalue(value,total:int64):string; overload;
function getformattedstatsvalue(value:integer):string;overload;
function getformattedstatsvalue(value:int64):string;overload;

var Hinttemplate, HintStatstemplate, HintStatsDtemplate, HintChattemplate:string;
    HtmlStatsTemplate:string;
    htmlTemplateIndex:tstringlist;
    htmlTemplateMenu:tstringlist;
    TTString: tstringlist;

implementation

function gethinttemplate(path,filename:string):string;
var f:tstringlist;
    i:integer;
begin
  result:='';
  f:=tstringlist.Create;
  try
    if fileexists(path+filename) then f.LoadFromFile(path+filename);
  for i:=0 to f.Count-1 do
    if pos('#',f.strings[i])<>1 then result:=result+f.strings[i];
  finally
    f.free;
  end;
end;

function HtmlreplaceTag(p:pointer;tagref,value1:integer):string;
begin
  result:=format('%%%.2d%%',[tagref]);
end;


function getHtmlTemplate(path,filename:string):tstringlist;
var i:integer;
    f:tstringlist;
    opentag:boolean;
    strtmp:string;
begin
  result:=tstringlist.Create;
  if not fileexists(path+filename) then exit;
  f:=tstringlist.Create;

  strtmp:='';
  try
    f.LoadFromFile(path+filename);
    opentag:=false;
    for i:=0 to f.count-1 do
    begin
      if pos('#',f.Strings[i])=1 then continue;
      //parser tag html ->fasttagaccess
      f.Strings[i]:=parsehtml(HtmlreplaceTag,nil,0,f.Strings[i]);

      if pos('[[',f.strings[i])=1 then
      begin
        opentag:=true;
        strtmp:='%00#'+copy(f.strings[i],3,4)+'%';//dmg,hea,buf,deb
        continue;
      end;
      if f.strings[i]=']]' then
      begin
        if strtmp<>'' then result.add(strtmp);
        opentag:=false;
        continue;
      end;
      if opentag then
        strtmp:=strtmp+f.strings[i]
      else
        result.add(f.strings[i]);
    end;
    //on finit en cas de block non fermé (security)
    if opentag then result.add(strtmp);
  finally
    f.free;
  end;
end;

procedure cleanAllHtmlTemplate;
begin
  htmlTemplateIndex.free;
  htmlTemplateMenu.free;
end;

procedure parseHint(s:rStringHint;const ParsedTagList: array of string ;var h:string);
var i,j,parsedTag:integer;
    tmptag:string;
const TagChr='%';
begin
    i:=length(h);
    j:=0;
    while i>0 do
    begin
      if h[i]=TagChr then
      begin
          //si on n'est pas en train d'enregistrer un tag, on commence
          if j=0 then
          begin
            j:=i;
            tmptag:=h[i]+tmptag;
          end
          //sinon on check le resultat du tag
          else
          begin
            tmptag:=h[i]+tmptag;
            parsedTag:=AnsiIndextext(tmptag,ParsedTagList);
            if parsedTag<>-1 then
            begin
              delete(h,i,j-i+1);
              insert(s[parsedTag],h,i);
              j:=0;
              tmptag:='';
            end
            else
            begin
              //sinon on retourne au point de depart-1
              tmptag:='';
              i:=j-1;
              j:=0;
            end
          end;
      end
      else if j>0 then tmptag:=h[i]+tmptag;
      dec(i);
    end;
end;


function parseHtml(const getParse: tHtmlParse; p:pointer; value1:integer; basestring:string):string;
var i,j,parsedTag:integer;
    tmptag,tmptarget:string;
const TagChr='%';
begin
    result:=basestring;
    i:=length(result);
    j:=0;
    while i>0 do
    begin
      if result[i]=TagChr then
      begin
          //si on n'est pas en train d'enregistrer un tag, on commence
          if j=0 then
          begin
            j:=i;
            tmptag:=result[i]+tmptag;
          end
          //sinon on check le resultat du tag
          else
          begin
            tmptag:=result[i]+tmptag;

            //if p=nil then we are in the preload parsing
            if not assigned(p) then
              parsedTag:=AnsiIndextext(tmptag,htmltagIndex)
            else
              parsedTag:=strtointdef(copy(tmptag,2,2),-1);
            //remplaceTag by tagtarget  
            if parsedTag<>-1 then
            begin
              tmptarget:=getParse(p,parsedTag,value1);
              result:=stuffstring(result,i,j-i+1,tmptarget);
              j:=0;
              tmptag:='';
            end
            else
            begin
              //sinon on retourne au point de depart-1
              tmptag:='';
              i:=j-1;
              j:=0;
            end
          end;
      end
      else if j>0 then tmptag:=result[i]+tmptag;
      dec(i);
    end;
end;

function  fillHintDataDetailledStat(basetemplate:string; p,ptot:pointer; tag:integer):string;
var s:rStringHint;
begin
  if fillDataStatsNum(p,tag,0)>0 then
  begin
    s[0]:=fillDataStats(p,14,0);
    s[1]:=fillDataStatsTT(p, ptot,tag,0);
    result:= basetemplate;
    parseHint(s,ParsedTagDetailledStats,result);
  end
  else result:='';
end;

function fillHintData(StartTimeStamp:ttimestamp;startTime:integer; p:pEvent;l:tlist):string;
var s:rStringHint;
    pStat:rEventStat;
begin
  {
    '%EVENT_SOURCENAME%',
    '%EVENT_DESTNAME%',
    '%EVENT_TYPE%',
    '%SPELL_NAME%',
    '%SPELL_AMOUNT%',
    '%EVENT_TIME%',
    '%EVENT_ID%',
    '%EVENT_SOURCEGUID%',
    '%EVENT_DESTGUID%',
    '%EVENT_SOURCEMOBID%',
    '%EVENT_DESTMOBID%',
    '%EVENT_SPELLID%',
    '%EVENT_SOURCETYPE%'
    '%EVENT_DESTTYPE%',
    '%EVENT_SPECIAL%'
  }
  result:=hinttemplate;
  pStat:=p.eventstat;
  s[0]:= getUnitName(p.sourceUnit,[getaff]);
  s[1]:= getUnitName(p.destUnit,[getaff]);
  if p.event=event_UNKNOWN then s[2]:=unknownEventlist.Strings[p.statsarray[0]]
  else s[2]:=p.name;
  if eventIsFalseDeath in p.params then s[2]:=s[2]+ ' (False Death)';

  s[3]:= GetSpellName(p);
  if pstat.extraspellId>0 then
    s[3]:=s[3]+' -> '+GetSpellName(pstat.extraspellId);
  s[3]:=s[3]+getschooltext(p);
  s[4]:=inttostrEX(pStat.amountGeneric);
  if pstat.amountExtra>0 then s[4]:=s[4]+' ('+ inttostrEX(pStat.amountExtra) +')';

  s[5]:= GetRealTimeFromTimeEvent(StartTimeStamp,p.time,startTime);//+' '+booltostr(eventIsFriendlyVsOther in p.params);
  //s[6]:=inttostr(l.indexof(p));//ex idinlist
  
  s[7]:= format('%.8x',[getUnitGUID(p.sourceUnit).GUID]);
  s[8]:= format('%.8x',[getUnitGUID(p.destUnit).GUID]);
  s[9]:= format('%.5d',[getUnitGUID(p.sourceUnit).MobID]);
  s[10]:= format('%.5d',[getUnitGUID(p.destUnit).MobID]);

  s[11]:= inttoHex(p.spell.id,6);
  s[12]:=guidCharType[ord(getUnittype(p.sourceUnit))];
  s[13]:=guidCharType[ord(getUnittype(p.destUnit))];

  s[14]:=powerTypeparam[pStat.powertype] + getSpecialString(p.specialhit,' ')+ getMissString(pStat.miss,'',(pstat.resist + pstat.block + pstat.absorb=0)) + p.GetAuraString ;
  if pstat.absorb>0 then s[14]:=s[14]+ getMissString(1,': ')+inttostrEX(pstat.absorb)+' ';
  {$IFDEF DEBUG}
    if p.lastabsorb>0 then s[14]:=s[14]+ ' ABS(undef): '+inttostrEX(p.lastabsorb)+' ';;
    if pstat.absorbpool>0 then s[14]:=s[14]+ ' ABS(pool): '+inttostrEX(pstat.absorbpool)+' ';
    if (pstat.guessedAbsorb)>0 then s[14]:=s[14]+ ' ABS(raw): '+inttostrEX(pstat.guessedAbsorb)+' ';
    if (p.fixedabsnotfound)>0 then s[14]:=s[14]+ ' ABS(notfound): '+inttostrEX(p.fixedabsnotfound)+' ';
  {$ENDIF}
  if (pstat.rawAbsorbPool)>0 then s[14]:=s[14]+ ' ABS(lost): '+inttostrEX(pstat.rawAbsorbPool)+' ';
  //if pstat.estimatedAbsorb>0 then s[14]:=s[14]+ ' eABS: '+inttostrEX(pstat.estimatedAbsorb)+' ';

  if pstat.block>0 then s[14]:=s[14]+ getMissString(2,CRITTAG[ord(eventisCriticalBlock in p.params)]+': ')+inttostrEX(pstat.block)+' ';
  if pstat.resist>0 then s[14]:=s[14]+ getMissString(10,': ')+inttostrEX(pstat.resist)+' ';
  if pstat.amountOverHeal>0 then s[14]:=s[14]+' (OH: '+inttostrEX(pstat.amountOverHeal)+') ';
  if pstat.amountOverKill>0 then s[14]:=s[14]+' (OD: '+inttostrEX(pstat.amountOverKill)+') ';


  {$IFDEF DEBUG}
    if p.eventString<>'' then
      s[14] := s[14] +'<br><br>Debug:<br>'+p.eventString;
  {$ENDIF}
  parseHint(s,ParsedTagEvents,result);
end;

function fillHintDataStat(basetemplate:string;ul:tUnitData;statlvl:integer):string;
var s:rStringHint;
    value:array[1..5] of int64;
    i:integer;
begin
  {'%STATS_UNITNAME%',
  '%STATS_DPS_OUT%',
  '%STATS_DPS_OUT_PERCENT%',
  '%STATS_DPS_IN%',
  '%STATS_DPS_IN_PERCENT%',
  '%STATS_HPS_IN%',
  '%STATS_HPS_IN_PERCENT%',
  '%STATS_HPS_OUT%',
  '%STATS_HPS_OUT_PERCENT%',
  '%STATS_EFFHPS_OUT%',
  '%STATS_EFFHPS_OUT_PERCENT%',
  '%STATS_OH_PERCENT%',
  '%STATS_ACTIVITY%',
  %STATS_ACTIVEDPS%
  %STATS_TOTALDPS%
  %STATS_ACTIVEHPS%
  %STATS_TOTALHPS%
  %STATS_ACTIVEEHPS%
  %STATS_TOTALEHPS% }

  result:=basetemplate;
  s[0]:=getunitname(ul,[getaff]);
  if (statUnitHasAffiliation in ul.stats.params) and (statlvl = 2) then s[0]:=s[0]+' (+pets)';

  //s[0]:=s[0]+parenthese_string(GetFormattedLocalTime(ul.stats.timeperiod,false));

  //compute value
  for i:= 1 to 5 do
    value[i]:=ul.stats.valueseparate[statlvl][i][1];//+ul.stats.valueseparate[STAT_ARRAY_INDEX[Nodelvl]][i][2];

  //damage out
  s[1]:= inttostrEx(value[1]);//format('%.d',[value[1]]);
  //s[1]:= format('%.d',[ul.stats.valueseparate[STAT_ARRAY_INDEX[Nodelvl]][1][1]]);
  if ul.uGUID.unitType<>unitIsPlayer then
    s[2]:= NA_STRING
  else
    s[2]:= format('%.1f%%',[divide(value[1],globalnode[ul.stats.globalnoderef].globalstats[1].total)*100]);
  //damage in
  s[3]:= inttostrEx(value[2]);//format('%.d',[value[2]]);
  //s[3]:= format('%.d',[ul.stats.valueseparate[STAT_ARRAY_INDEX[Nodelvl]][2][1]]);
  if ul.uGUID.unitType<>unitIsPlayer then
    s[4]:= NA_STRING
  else
    s[4]:= format('%.1f%%',[divide(value[2],globalnode[ul.stats.globalnoderef].globalstats[2].total)*100]);
  //heal in
  s[5]:= inttostrEx(value[5]);// format('%.d',[value[5]]);
  //s[5]:= format('%.d',[ul.stats.valueseparate[STAT_ARRAY_INDEX[Nodelvl]][5][1]]);
  if ul.uGUID.unitType<>unitIsPlayer then
    s[6]:= NA_STRING
  else
    s[6]:= format('%.1f%%',[divide(value[5],globalnode[ul.stats.globalnoderef].globalstats[5].total)*100]);
  //tot.heal out
  s[7]:= inttostrEx(value[4]);//format('%.d',[value[4]]);
  //s[7]:= format('%.d',[ul.stats.valueseparate[STAT_ARRAY_INDEX[Nodelvl]][4][1]]);
  if ul.uGUID.unitType<>unitIsPlayer then
    s[8]:= NA_STRING
  else
    s[8]:= format('%.1f%%',[divide(value[4],globalnode[ul.stats.globalnoderef].globalstats[4].total)*100]);
  //eff.heal out
  s[9]:= inttostrEx(value[3]);// format('%.d',[value[3]]);
  //s[9]:= format('%.d',[ul.stats.valueseparate[STAT_ARRAY_INDEX[Nodelvl]][3][1]]);
  if ul.uGUID.unitType<>unitIsPlayer then
    s[10]:= NA_STRING
  else
    s[10]:= format('%.1f%%',[divide(value[3],globalnode[ul.stats.globalnoderef].globalstats[3].total)*100]);
  //overheal
  if ul.uGUID.unitType<>unitIsPlayer then
    s[11]:= NA_STRING
  else
    s[11]:= format('%.1f%%',[divide(value[4]-value[3],value[4]) * 100]);

  //activity
  s[12]:=  format('%.1f%%',[divide(ul.stats.Activity[statlvl],ul.stats.timeperiod)*100]);
  //activeDPS
  s[13]:=  inttostrEx(round(divide(value[1],(ul.stats.Activity[statlvl]/100))));
  s[14]:=  inttostrEx(round(divide(value[1],(ul.stats.timeperiod/100))));
  s[15]:=  inttostrEx(round(divide(value[4],(ul.stats.Activity[statlvl]/100))));
  s[16]:=  inttostrEx(round(divide(value[4],(ul.stats.timeperiod/100))));
  s[17]:=  inttostrEx(round(divide(value[3],(ul.stats.Activity[statlvl]/100))));
  s[18]:=  inttostrEx(round(divide(value[3],(ul.stats.timeperiod/100))));
  parseHint(s,ParsedTagStats,result);
end;


function fillHintChat(strtmp:string):string;
var s:rStringHint;
begin
  if strtmp<>'' then
  begin
    result:=HintChattemplate;
    s[0]:=strtmp;
    parseHint(s,ParsedTagChat,result);
  end
  else result:='';
end;

//-----------------
//html
//--------------procedure fillHtmlDataIndex (var s:rStringHint;Rotationlines:rRotationlines;menustats:integer);---

function fillHtmlDataIndex(p:pointer;tagref,value1:integer):string;
var   Rotationlines:^rRotationlines;
const btagStart:array [0..1] of string = ('','<b>');
      btagEnd:array [0..1] of string = ('','</b>');
      menulabel: array [0..9] of string = ( 'Damage&nbsp;Done','Damage&nbsp;taken','Healing&nbsp;Done','Healing&nbsp;Taken','Buff&nbsp;Casted','Buff&nbsp;Received','DeBuff&nbsp;Casted','DeBuff&nbsp;Received','PowerGains','Others');
      menucommand: array [0..9] of string = ( '#mode0','#mode1','#mode2','#mode3','#mode4','#mode5','#mode6','#mode7','#mode8','#mode9');
begin
  Rotationlines:=p;
  case tagref of
    0:result:=ClasseStat[Rotationlines^.statsunit.classe].htmlcolor;
    1:result:=getunitname(Rotationlines^.statsunit,[getaff]);
    2..11: result:='<a href="'+ menucommand[tagref-2]+'">'+btagStart[ord(value1=(tagref-2))]+menulabel[tagref-2]+btagEnd[ord(value1 = (tagref-2))]+'</a>';
    else result:='';
  end;
end;

procedure parsehtmlStats(template:tstringlist;ts:tstringlist; Rotationlines:rrotationlines; menustats:integer);
var j:integer;
begin
  for j:=0 to Template.count-1 do
  begin
    if Template.Strings[j]='{GLOBAL_STATS}' then
        ts.add (fillHintDataStat(HtmlStatsTemplate,Rotationlines.statsunit,ord(Rotationlines.statlevel)+1))
    else if Template.Strings[j]= '{FILTER}' then
        ts.add(getFilterLabel)
    else
    begin
      if pos('%',Template.Strings[j] )>0 then
        ts.add(parseHtml(fillHtmlDataIndex,@Rotationlines,menustats,Template.Strings[j]))
      else
        ts.add(Template.Strings[j]);
    end;
  end;
end;

function getStatSpellOptions(Rotationline:tRotationline;opt:byte):string;
const tag:array[0..1] of string = ('+','-');
begin
  result:='';
  if Rotationline.istotalnode then exit;
  if opt=1 then
   result:= tag[ord(getSpellDefaultFilter(Rotationline.spell.id) )]
  else
   if  (IsBuff in Rotationline.rs.state) or (isdebuff in Rotationline.rs.state) then
       result:= tag[0];
end;

function getformattedstatsvalue(value,total:integer):string; overload;
const valuezero='-';
begin
  if (value=0) or (total = 0) then
    result:=valuezero
  else
    result:= format('(%.1f%%)  %s',[divide(value,total)*100, inttostrEX(value)]);
end;

function getformattedstatsvalue(value,total:int64):string; overload;
const valuezero='-';
begin
  if (value=0) or (total = 0) then
    result:=valuezero
  else
    result:= format('(%.1f%%)  %s',[divide(value,total)*100, inttostrEX(value)]);
end;

function getformattedstatsvalue(value:integer):string;overload;
const valuezero='-';
begin
  if (value=0) then
    result:=valuezero
  else
    result:= inttostrEX(value);
end;

function getformattedstatsvalue(value:int64):string;overload;
const valuezero='-';
begin
  if (value=0) then
    result:=valuezero
  else
    result:= inttostrEX(value);
end;

function fillDataStats(p:pointer;tagref,value1:integer):string;
var Rotationline:tRotationline;
begin
  //dmgs
  Rotationline:=p;
  case tagref of
    //spellname
    14: if Rotationline.istotalnode then result:='Total' else result:= rotationline.getfullspellname;
    15:result:=getStatSpellOptions(Rotationline,1);
    16:result:=getStatSpellOptions(Rotationline,0);
    //damages
    19:result:=getformattedstatsvalue(Rotationline.rs.total+Rotationline.rs.ptotal);
    20:result:=getformattedstatsvalue(Rotationline.count);
    21:result:=getformattedstatsvalue(Rotationline.avgHit);
    22:result:=getformattedstatsvalue(Rotationline.rs.hit,Rotationline.count);
    23:result:=getformattedstatsvalue(Rotationline.rs.crit,Rotationline.count);
    24:result:=getformattedstatsvalue(Rotationline.rs.glance,Rotationline.count);
    25:result:=getformattedstatsvalue(Rotationline.rs.crush,Rotationline.count);
    26:result:=getformattedstatsvalue(Rotationline.rs.miss,Rotationline.count);
    27:result:=getformattedstatsvalue(Rotationline.rs.othermiss,Rotationline.count);
    28:result:=getformattedstatsvalue(Rotationline.rs.parry,Rotationline.count);
    29:result:=getformattedstatsvalue(Rotationline.rs.dodge,Rotationline.count);
    30:result:=getformattedstatsvalue(Rotationline.rs.absorb);
    31:result:=getformattedstatsvalue(Rotationline.rs.blocvalue);
    32:result:=getformattedstatsvalue(Rotationline.rs.bloccount,Rotationline.count);
    33:result:=getformattedstatsvalue(Rotationline.rs.resist);
    34:result:=getformattedstatsvalue(Rotationline.rs.phit,Rotationline.pcount);
    35:result:=getformattedstatsvalue(Rotationline.rs.pcrit,Rotationline.pcount);
    36:result:=getformattedstatsvalue(Rotationline.avgpHit);
    37:result:=getformattedstatsvalue(Rotationline.rs.dotmiss,Rotationline.pcount);
    //aura
    41:result:=getformattedstatsvalue(Rotationline.rs.b_count+Rotationline.rs.b_rcount);
    42:result:=getformattedstatsvalue(Rotationline.rs.db_count+Rotationline.rs.db_rcount);
    //heal
    44:result:=getformattedstatsvalue(Rotationline.rs.h_total+Rotationline.rs.h_ptotal);
    45:result:=getformattedstatsvalue(Rotationline.rs.h_rawtotal+Rotationline.rs.h_prawtotal);

    46:result:=getformattedstatsvalue(Rotationline.rs.h_hit,Rotationline.h_count);
    47:result:=getformattedstatsvalue(Rotationline.avgHeal);
    48:result:=getformattedstatsvalue(Rotationline.avgRawHeal);
    49:result:=getformattedstatsvalue(Rotationline.rs.h_crit,Rotationline.h_count);

    50:result:=getformattedstatsvalue(Rotationline.rs.h_phit,Rotationline.h_pcount);
    51:result:=getformattedstatsvalue(round(divide(Rotationline.rs.h_ptotal,Rotationline.h_pcount)));
    52:result:=getformattedstatsvalue(round(divide(Rotationline.rs.h_prawtotal,Rotationline.h_pcount)));
    53:result:=getformattedstatsvalue(Rotationline.rs.h_pcrit,Rotationline.h_pcount);
    54:result:=getformattedstatsvalue(Rotationline.rs.h_absorb);
    55:result:=format('%d%%',[Rotationline.OverHeal]);
    56:result:=getformattedstatsvalue(Rotationline.rs.h_estabsorb);

    //---
    57:result:=getformattedstatsvalue(Rotationline.rs.fftotal);
    58:result:=getformattedstatsvalue(Rotationline.rs.h_enemyheal);
    //--power
    59:result:=getformattedstatsvalue(Rotationline.rs.power_count);
    60..77:result:=getformattedstatsvalue(Rotationline.rs.power_total[tagref-60]);

    //--other
    90:result:=getformattedstatsvalue(Rotationline.rs.other_count);
    91:result:=getformattedstatsvalue(Rotationline.rs.other_cast);
    92:result:=getformattedstatsvalue(Rotationline.rs.other_miss);
    93:result:=getformattedstatsvalue(Rotationline.rs.other_interrupt);
    94:result:=getformattedstatsvalue(Rotationline.rs.other_dispel);
    95:result:=getformattedstatsvalue(Rotationline.rs.other_invoc);

  else result:=''; //
  end;
end;

function TTStringRef(index:integer):string;
begin
  if index<TTstring.Count then result:=TTstring.strings[index] else result:=ERROR_STRING;
end;

function fillDataStatsTT(p,ptot:pointer;tagref,value1:integer):string;
var Rotationline,RotationlineTot :tRotationline;
begin
  try
  //dmgs
  Rotationline:=p;
  RotationlineTot:=ptot;
  case tagref of
    14:result:=format(TTstringRef(36),[getschooltext(rotationline.spell)]);

    //damages
    19:result:=format(TTstringRef(0),[Rotationline.rs.total+Rotationline.rs.ptotal,
                                      divide(Rotationline.rs.total+Rotationline.rs.ptotal,RotationlineTot.rs.total+RotationlineTot.rs.ptotal)*100,
                                      Rotationline.count+Rotationline.pcount,
                                      RotationLine.rs.ms_dhit,
                                      divide(RotationLine.rs.ms_dhit,Rotationline.count+Rotationline.pcount)*100
                                      ]);




    20:result:=format(TTstringRef(1),[Rotationline.count]);
    21:result:=format(TTstringRef(2),[Rotationline.avgHit, Rotationline.landedHit]);
    22:result:=format(TTstringRef(3),[Rotationline.rs.Hit,Rotationline.count, divide(Rotationline.rs.hit,Rotationline.count)*100, Rotationline.rs.d_hit_min,Rotationline.rs.d_hit_max ]);
    23:result:=format(TTstringRef(4),[Rotationline.rs.crit, Rotationline.count, divide(Rotationline.rs.crit,Rotationline.count)*100, Rotationline.rs.d_crit_min,Rotationline.rs.d_crit_max ]);
    24:result:=format(TTstringRef(5),[Rotationline.rs.glance,Rotationline.count,  divide(Rotationline.rs.glance,Rotationline.count)*100]);
    25:result:=format(TTstringRef(6),[Rotationline.rs.crush, Rotationline.count, divide(Rotationline.rs.crush,Rotationline.count)*100]);
    26:result:=format(TTstringRef(7),[Rotationline.rs.miss, Rotationline.count, divide(Rotationline.rs.miss,Rotationline.count)*100]);
    27:result:=format(TTstringRef(8),[Rotationline.rs.othermiss,Rotationline.count,  divide(Rotationline.rs.othermiss,Rotationline.count)*100]);
    28:result:=format(TTstringRef(9),[Rotationline.rs.parry,Rotationline.count,  divide(Rotationline.rs.parry,Rotationline.count)*100]);
    29:result:=format(TTstringRef(10),[Rotationline.rs.dodge,Rotationline.count,  divide(Rotationline.rs.dodge,Rotationline.count)*100]);
    30:result:=format(TTstringRef(11),[Rotationline.rs.absorb]);
    31:result:=format(TTstringRef(12),[Rotationline.rs.blocvalue,divide(Rotationline.rs.blocvalue,Rotationline.rs.bloccount),Rotationline.rs.d_bloc_min, Rotationline.rs.d_bloc_max , divide(Rotationline.rs.blocvalue,(Rotationline.rs.total+Rotationline.rs.ptotal+Rotationline.rs.blocvalue+Rotationline.rs.absorb+ +Rotationline.rs.resist))*100]);
    32:result:=format(TTstringRef(13),[Rotationline.rs.bloccount,Rotationline.count, divide(Rotationline.rs.bloccount,Rotationline.count)*100,Rotationline.rs.bloccritcount, divide(Rotationline.rs.bloccritcount,Rotationline.rs.bloccount)*100]);
    33:result:=format(TTstringRef(14),[Rotationline.rs.resist, divide(Rotationline.rs.resist,(Rotationline.rs.total+Rotationline.rs.ptotal+Rotationline.rs.resist))*100]);
    34:result:=format(TTstringRef(15),[Rotationline.rs.pHit,Rotationline.pcount, divide(Rotationline.rs.phit,Rotationline.pcount)*100, Rotationline.rs.d_phit_min,Rotationline.rs.d_phit_max ]);
    35:result:=format(TTstringRef(16),[Rotationline.rs.pcrit, Rotationline.pcount, divide(Rotationline.rs.pcrit,Rotationline.pcount)*100, Rotationline.rs.d_pcrit_min,Rotationline.rs.d_pcrit_max ]);
    36:result:=format(TTstringRef(17),[Rotationline.avgpHit, Rotationline.rs.phit+Rotationline.rs.pcrit]);
    37:result:=format(TTstringRef(18),[Rotationline.rs.dotmiss, Rotationline.pcount, divide(Rotationline.rs.dotmiss,Rotationline.pcount)*100]);
    //aura
    41:result:=format(TTstringRef(19),[Rotationline.rs.b_count+Rotationline.rs.b_rcount,Rotationline.rs.b_count,Rotationline.rs.b_rcount]);
    42:result:=format(TTstringRef(20),[Rotationline.rs.db_count+Rotationline.rs.db_rcount,Rotationline.rs.db_count,Rotationline.rs.db_rcount]);
    //heal
    44:result:=format(TTstringRef(21),[Rotationline.rs.h_total+Rotationline.rs.h_ptotal,
                                        divide(Rotationline.rs.h_total+Rotationline.rs.h_ptotal,RotationlineTot.rs.h_total+RotationlineTot.rs.h_ptotal)*100,
                                        Rotationline.h_count+Rotationline.h_pcount,
                                        RotationLine.rs.ms_hhit,
                                        divide(RotationLine.rs.ms_hhit,Rotationline.h_count+Rotationline.h_pcount)*100]
                                        );
    45:result:=format(TTstringRef(22),[Rotationline.rs.h_rawtotal+Rotationline.rs.h_prawtotal,
                                        divide(Rotationline.rs.h_rawtotal+Rotationline.rs.h_prawtotal,RotationlineTot.rs.h_rawtotal+RotationlineTot.rs.h_prawtotal)*100,
                                        Rotationline.h_count+Rotationline.h_pcount,
                                        RotationLine.rs.ms_hhit,
                                        divide(RotationLine.rs.ms_hhit,Rotationline.h_count+Rotationline.h_pcount)*100]
                                        );
    46:result:=format(TTstringRef(23),[Rotationline.rs.h_Hit,Rotationline.h_count, divide(Rotationline.rs.h_hit,Rotationline.h_count)*100, Rotationline.rs.h_hit_min,Rotationline.rs.h_hit_max ]);
    47:result:=format(TTstringRef(24),[Rotationline.avgHeal, Rotationline.h_count]);
    48:result:=format(TTstringRef(25),[Rotationline.avgRawHeal, Rotationline.h_count]);
    49:result:=format(TTstringRef(26),[Rotationline.rs.h_crit,Rotationline.h_count, divide(Rotationline.rs.h_crit,Rotationline.h_count)*100, Rotationline.rs.h_crit_min,Rotationline.rs.h_crit_max ]);
    50:result:=format(TTstringRef(27),[Rotationline.rs.h_pHit,Rotationline.h_pcount, divide(Rotationline.rs.h_phit,Rotationline.h_pcount)*100, Rotationline.rs.h_phit_min,Rotationline.rs.h_phit_max ]);
    51:result:=format(TTstringRef(28),[divide(Rotationline.rs.h_ptotal,Rotationline.h_pcount),Rotationline.h_pcount]);
    52:result:=format(TTstringRef(29),[divide(Rotationline.rs.h_prawtotal,Rotationline.h_pcount),Rotationline.h_pcount]);
    53:result:=format(TTstringRef(30),[Rotationline.rs.h_pcrit,Rotationline.h_pcount, divide(Rotationline.rs.h_pcrit,Rotationline.h_pcount)*100, Rotationline.rs.h_pcrit_min,Rotationline.rs.h_pcrit_max]);
    54:result:=format(TTstringRef(31),[Rotationline.rs.h_absorb]);
    55:result:=format(TTstringRef(32),[Rotationline.OverHeal]);// format('%d%%',[Rotationline.OverHeal]);
    56:result:=format(TTstringRef(33),[Rotationline.rs.h_estabsorb]); //getformattedstatsvalue(Rotationline.rs.h_estabsorb);
    //---
    57:result:=format(TTstringRef(34),[Rotationline.rs.fftotal]); //getformattedstatsvalue(Rotationline.rs.fftotal);
    58:result:=format(TTstringRef(35),[Rotationline.rs.h_enemyheal]); //getformattedstatsvalue(Rotationline.rs.h_enemyheal);

    ////--power
    59:result:=format(TTstringRef(37),[Rotationline.rs.power_count]);
    60..77:result:=format(TTstringRef(38),[Rotationline.rs.power_total[tagref-60],powerTypeparam[tagref-60], divide(Rotationline.rs.power_total[tagref-60], Rotationline.rs.power_count)]);

    90:result:=format(TTstringRef(39),[Rotationline.rs.other_count]);
    91:result:=format(TTstringRef(40),[Rotationline.rs.other_cast]);
    92:result:=format(TTstringRef(41),[Rotationline.rs.other_miss]);
    93:result:=format(TTstringRef(42),[Rotationline.rs.other_interrupt]);
    94:result:=format(TTstringRef(43),[Rotationline.rs.other_dispel]);
    95:result:=format(TTstringRef(44),[Rotationline.rs.other_invoc]);

  else result:=''; //
  end;
  except
    result:=ERROR_STRING;
  end;
end;

function fillDataStatsNum(p:pointer;tagref,value1:integer):int64;
var Rotationline:tRotationline;
begin
  //dmgs
  Rotationline:=p;
  case tagref of
    //damages
    14:result:=1;
    19:result:=Rotationline.rs.total+Rotationline.rs.ptotal;
    20:result:=Rotationline.count;
    21:result:=Rotationline.avgHit;
    22:result:=Rotationline.rs.hit;
    23:result:=Rotationline.rs.crit;
    24:result:=Rotationline.rs.glance;
    25:result:=Rotationline.rs.crush;
    26:result:=Rotationline.rs.miss;
    27:result:=Rotationline.rs.othermiss;
    28:result:=Rotationline.rs.parry;
    29:result:=Rotationline.rs.dodge;
    30:result:=Rotationline.rs.absorb;
    31:result:=Rotationline.rs.blocvalue;
    32:result:=Rotationline.rs.bloccount;
    33:result:=Rotationline.rs.resist;
    34:result:=Rotationline.rs.phit;
    35:result:=Rotationline.rs.pcrit;
    36:result:=Rotationline.avgpHit;
    37:result:=Rotationline.rs.dotmiss;
    //aura
    41:result:=Rotationline.rs.b_count+Rotationline.rs.b_rcount;
    42:result:=Rotationline.rs.db_count+Rotationline.rs.db_rcount;
    //heal
    44:result:=Rotationline.rs.h_total+Rotationline.rs.h_ptotal;
    45:result:=Rotationline.rs.h_rawtotal+Rotationline.rs.h_prawtotal;
    46:result:=Rotationline.rs.h_hit;
    47:result:=Rotationline.avgHeal;
    48:result:=Rotationline.avgRawHeal;
    49:result:=Rotationline.rs.h_crit;
    50:result:=Rotationline.rs.h_phit;
    51:result:=round(divide(Rotationline.rs.h_ptotal,Rotationline.h_pcount));
    52:result:=round(divide(Rotationline.rs.h_prawtotal,Rotationline.h_pcount));
    53:result:=Rotationline.rs.h_pcrit;
    54:result:=Rotationline.rs.h_absorb;
    55:result:=Rotationline.OverHeal;
    56:result:=Rotationline.rs.h_estabsorb;

    57:result:=Rotationline.rs.fftotal;
    58:result:=Rotationline.rs.h_enemyheal;

    //--power
    59:result:=Rotationline.rs.power_count;
    60..77:result:=Rotationline.rs.power_total[tagref-60];

    //--other
    90:result:=Rotationline.rs.other_count;
    91:result:=Rotationline.rs.other_cast;
    92:result:=Rotationline.rs.other_miss;
    93:result:=Rotationline.rs.other_interrupt;
    94:result:=Rotationline.rs.other_dispel;
    95:result:=Rotationline.rs.other_invoc;

  else result:=0; //
  end;
end;

procedure parsehtmlblockContent(ts,sourcets:tstringlist; totalStat:trotationline; l:tlist);
var i,j,id:integer;
    RotationLine:tRotationline;
    state:rotationstate;
begin
  for j:= 0 to sourcets.count-1 do
  begin
    if pos('%00',sourceTS[j])=1 then
    begin
      if pos('%00#DMGS%',sourceTS[j])=1 then state:=isDamage
      else if pos('%00#HEAL%',sourceTS[j])=1 then state:=isHeal
      else if pos('%00#BUFF%',sourceTS[j])=1 then state:=isBuff
      else state:=isDebuff;
      id:=0;
      for i:=0 to l.count-1 do
        begin
          Rotationline:=l.items[i];
          if state in Rotationline.rs.state then
          begin
            inc(id);
            ts.add(parseHtml(fillDataStats,Rotationline,id,sourceTS[j]));
          end;
        end;
      continue;
    end;
    //optimization: if the line doesnt not contain tag, then we copy it directly
    if pos('%',sourceTS[j])>0 then ts.add(parseHtml(fillDataStats,totalstat,0,sourceTS[j])) else ts.add(sourceTS[j]);
  end;
end;



end.
