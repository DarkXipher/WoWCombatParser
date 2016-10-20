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
unit wcr_Html;

interface

uses Windows, SysUtils, Classes, wcr_Parser_Events, wcr_const, Htmlview, wcr_ressource, wcr_utils;

type
  rlogBossInfo = record
    id, donjonId, donjonsort, count, verif: integer;
    name: string;
    HM: boolean;
  end;

  plogBossInfo = ^rlogBossInfo;

function htmlBold(t: string; condition: boolean): string;
function htmlLink(tlink, tlabel: string): string;
function htmlLi(t: string): string;
function htmlDiv(t, id: string; condition: boolean): string;
function htmlSpan(t, span: string; condition: boolean = true): string;
procedure headerHtmFile(s: tstringlist; firstlineOnly: boolean = false);
procedure openHtmFile(filename: string; htmlrender: THTMLViewer);
function sortwcrcontentlist(p1, p2: pointer): integer;
function sortlogbosslist(p1, p2: pointer): integer;
procedure generateLogHTML(RestrictBoss: integer; HMonly, useCache: boolean; htmlrender: THTMLViewer);
procedure clearLogIndexLists;
procedure generateLogBossIndex(logBossList: tlist);

var
  headerString: tstringlist;
  LogList: tlist;

Const

  HTML_OPENTABLE = '<table><tr><td>';
  HTML_CLOSETABLE = '</td></tr></table>';
  HTML_NEWTD = '</td><td>';
  HTML_OPENUL = '<ul>';
  HTML_CLOSEUL = '</ul>';
  HTML_SPANHM = '<span class="HM">HM</span>';
  HTML_SPAN25 = '<span class="25">25</span>';
  HTML_OLDLOGLABEL =
    '<br>Some logs seem to have an old format: do you want to [<a href="#batch">convert</a>] them? <br>(this can take some time. Hit ''Esc'' to interrupt the process)<br>';
  HTML_LOGMENU1 = '<div id="MENU">[<a href="#dirlog">Change log directory</a>]';
  HTML_LOGMENU2: array [0 .. 1] of string = ('', '[<a href="#rebuild">Reset IndexCache</a>] ');
  HTML_LOGMENU3 = '[<a href="#refresh">Refresh Index</a>]</div>';
  HTML_NOLOGLABEL = 'No log found.';
  HTML_CLOSEDIV = '</div>';

implementation

function htmlBold(t: string; condition: boolean): string;
begin

  if condition and (t <> '') then
    result := format('<b>%s</b>', [t])
  else
    result := t;
end;

function htmlLink(tlink, tlabel: string): string;
begin
  result := format('<a href="%s">%s</a>', [tlink, tlabel]);
end;

function htmlSpan(t, span: string; condition: boolean): string;
begin
  if condition and (t <> '') then
    result := format('<span class="%s">%s</span>', [span, t])
  else
    result := t;
end;

function htmlDiv(t, id: string; condition: boolean): string;
begin
  if condition and (t <> '') then
    result := format('<div id="%s">%s</div>', [id, t])
  else
    result := t;
end;

function htmlDivOpen(id: string): string;
begin
  result := format('<div id="%s">', [id])
end;

function htmlLi(t: string): string;
begin
  result := format('<li>%s</li>', [t]);
end;

procedure headerHtmFile(s: tstringlist; firstlineOnly: boolean = false);
var
  i, tmp: integer;
begin
  if firstlineOnly then
    tmp := 0
  else
    tmp := headerString.count - 1;
  for i := tmp downto 0 do
    s.Insert(0, headerString.strings[i]);
  // copyright
  if not firstlineOnly then
    s.Insert(s.count, HTML_BR + HTML_BR + HTML_BR + COPYRIGHT_1 + ' ' + COPYRIGHT_2);
end;

procedure openHtmFile(filename: string; htmlrender: THTMLViewer);
var
  s: tstringlist;
begin
  SetCurrentDir(docpath);
  filename := extractfilename(filename);
  s := tstringlist.create;
  try
    if fileexists(filename) then
      s.LoadFromFile(filename);
    headerHtmFile(s);
    htmlrender.LoadFromString(s.Text, filename);
  finally
    s.free;
  end;
end;

function sortwcrcontentlist(p1, p2: pointer): integer;
var
  t1, t2: extended;
begin
  if tWcrfile(p1).content.content.startTime.date = 0 then
    t1 := 0
  else
    t1 := TimeStampToDateTime(tWcrfile(p1).content.content.startTime);
  if tWcrfile(p2).content.content.startTime.date = 0 then
    t2 := 0
  else
    t2 := TimeStampToDateTime(tWcrfile(p2).content.content.startTime);
  if t2 < t1 then
    result := -1
  else if t2 > t1 then
    result := 1
  else
    result := 0;
end;

function sortlogbosslist(p1, p2: pointer): integer;
begin
  result := ((plogBossInfo(p1).donjonsort - plogBossInfo(p2).donjonsort) * 1000) + comparetext(plogBossInfo(p1).name,
    plogBossInfo(p2).name);
end;

procedure clearLogIndexLists;
var
  i: integer;
begin
  for i := 0 to LogList.count - 1 do
    tWcrfile(LogList.items[i]).free;
  LogList.clear;

end;

procedure generateLogBossIndex(logBossList: tlist);
var
  i, j, k: integer;
  w: tWcrfile;
  b: plogBossInfo;
  found: boolean;
begin
  for i := 0 to LogList.count - 1 do
  begin
    w := LogList.items[i];
    for j := 0 to high(w.content.content.bosslist) do
    begin
      if w.content.content.bosslist[j].bossId > 0 then
      begin
        found := false;
        for k := 0 to logBossList.count - 1 do
        begin
          b := logBossList.items[k];
          if b.id = w.content.content.bosslist[j].bossId then
          begin
            if b.verif <> i then
              inc(b.count);
            b.verif := i;
            if bossisHM in w.content.content.bosslist[j].bossopts then
              b.HM := true;
            found := true;
            break;
          end;
        end;
        if not found then
        begin
          new(b);
          b.id := w.content.content.bosslist[j].bossId;
          b.count := 1;
          b.verif := i;
          b.HM := bossisHM in w.content.content.bosslist[j].bossopts;
          b.name := getunitname(w.content.content.bosslist[j].bossId, []);
          b.donjonId := getUnitDungeonAff(w.content.content.bosslist[j].bossId);
          b.donjonsort := GetDonjonInfo(b.donjonId, 1);
          logBossList.add(b);
        end;
      end;
    end;
  end;
  logBossList.Sort(sortlogbosslist);
end;

procedure generateLogHTML(RestrictBoss: integer; HMonly, useCache: boolean; htmlrender: THTMLViewer);
var
  s: tstringlist;
  w: tWcrfile;
  i, j, k: integer;
  strtmp: string;
  tagopt, tagdown: string;
  b: plogBossInfo;
  found: boolean;
  olddonjon: integer;
  l: tlist;
  fixutf8: boolean;
begin
  s := tstringlist.create;
  l := tlist.create;
  generateLogBossIndex(l);
  try
    try
      s.add(HTML_OPENTABLE + htmlDivOpen('list'));
      s.add(bracket_String(htmlBold('Last Logs', true)));
      s.add(HTML_OPENUL + htmlLi(bracket_String(htmlLink('#BOSS:$000000', format('Show the %d last logs', [prefs.defaultindexsize])))));

      olddonjon := -1;

      for k := 0 to l.count - 1 do
      begin
        b := l.items[k];
        if olddonjon <> b.donjonId then
        begin
          olddonjon := b.donjonId;
          s.add(HTML_CLOSEUL + bracket_String(htmlBold(GetDonjonInfo(olddonjon, 2), true)) + HTML_OPENUL);
        end;
        if b.HM then
          tagopt := bracket_String(htmlLink('#BOSH:$' + inttohex(b.id, 6), HTML_SPANHM))
        else
          tagopt := '';
        s.add(htmlLi(htmlLink('#BOSS:$' + inttohex(b.id, 6), b.name) + tagopt + bracket_String(inttostr(b.count))));
        dispose(b);
      end;

      s.add(HTML_CLOSEUL + HTML_CLOSEDIV + HTML_NEWTD + htmlDivOpen('logs'));
      for i := 0 to LogList.count - 1 do
      begin
        w := LogList.items[i];
        fixutf8 := w.content.content.utf8Tag = 1;
        found := RestrictBoss = 0;
        if RestrictBoss > 0 then
        begin
          for j := 0 to high(w.content.content.bosslist) do
            if w.content.content.bosslist[j].bossId = RestrictBoss then
              found := found or (not HMonly) or (bossisHM in w.content.content.bosslist[j].bossopts);
        end
        else if i > prefs.defaultindexsize then
          break;
        if not found then
          continue;

        s.add(htmlDiv(bracket_String(GetRealTimeFromTimeEvent(w.content.content.startTime, 0, 0,
                toShowDateAndMn)) + htmlSpan(htmlLink(w.path + w.content.name,
                w.content.name + ORDTAG[ord(w.content.wcrheader < WCRFILE_HEADER)]),
              'MENU') + bracket_String(htmlLink(':del:' + w.path + w.content.name, 'x')), 'head', true));
        if w.content.content.comment <> '' then
          s.add(htmlDiv(Utf8conditional(w.content.content.comment, fixutf8), 'comment', true));
        s.add(htmlDivOpen('content'));
        for j := 0 to high(w.content.content.bosslist) do
        begin
          if w.content.content.bosslist[j].bossId > 0 then
          begin
            // #WCR:FFFFFFName.wcr
            tagopt := '';
            tagdown := '';
            if bossisdown in w.content.content.bosslist[j].bossopt2s then
              tagdown := 'DOWN'
            else
              tagdown := 'WIPE';
            if bossis25 in w.content.content.bosslist[j].bossopts then
              tagopt := HTML_SPAN25;
            if bossisHM in w.content.content.bosslist[j].bossopts then
              tagopt := tagopt + HTML_SPANHM;
            strtmp := htmlSpan(bracket_String(GetDonjonInfo(getUnitDungeonAff(w.content.content.bosslist[j].bossId), 3)), 'RAID');
            strtmp := strtmp + htmlLink('#WCR:' + inttohex(w.content.content.bosslist[j].bossId,
                6) + inttohex(byte(w.content.content.bosslist[j].bossopts), 1) + w.path + w.content.name,
              htmlSpan(htmlSpan(getunitname(w.content.content.bosslist[j].bossId, []), 'HIGH',
                  w.content.content.bosslist[j].bossId = RestrictBoss), tagdown));
            if tagopt <> '' then
              strtmp := strtmp + bracket_String(tagopt);
            strtmp := strtmp + parenthese_string(inttostr(w.content.content.bosslist[j].bosstry));
            s.add(htmlLi(strtmp));
          end;
        end;
        s.add(HTML_CLOSEDIV + htmlDivOpen('players'));
        for j := 0 to high(w.content.content.playerlist) do
        begin
          if w.content.content.playerlist[j] <> '' then
            s.add(Utf8conditional(w.content.content.playerlist[j], fixutf8) + ' ');
        end;
        s.add(HTML_CLOSEDIV);
      end;
      s.add(HTML_CLOSEDIV + HTML_CLOSETABLE);

    except
      s.add('ERROR in LOG GENERATION');
    end;
  finally
    // header
    if s.count = 0 then
      s.Insert(0, HTML_NOLOGLABEL);
    s.Insert(0, HTML_BR + HTML_BR);
    // if oldlog then s.insert(0,HTML_OLDLOGLABEL);
    s.Insert(0, HTML_LOGMENU1 + HTML_LOGMENU2[ord(prefs.useCache)] + HTML_LOGMENU3);
    headerHtmFile(s);
    htmlrender.LoadFromString(s.Text, '#GenerateLog');
    s.free;
    l.free;
  end
end;

end.
