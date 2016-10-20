unit wcr_replay;

interface

uses Classes, Graphics, sysutils, wcr_utils, wcr_Parser_Events, types, wcr_const, Generics.Collections, GR32, GR32_Polygons, Math;

type

tIconArray = array[1..8] of tbitmap32;

tReplaydraw = class
  l: tlist<tpoint>;
  circle : boolean;
  cCenter : tpoint;
  cRayon : integer;
  constructor initdata(shape: boolean; p: tpoint; d: integer);
  destructor Destroy;override;
end;

rReplay = record
    StartID: integer;
    StartTime: integer;
    minx, miny, maxx, maxy : integer;
    Offx, Offy: integer;
    Ratio: double;
    EvaluateRatio,  UseUnitLoc:boolean;
    oldMouseOffsetx: integer;
    oldMouseOffsety: integer;
    imgoffsetx: integer;
    imgoffsety: integer;
    angle: integer;
    //circle
    playerCircle: integer;
    unitOnMouse, SelectedUnit: tunitdata;
    //timemouseown
    timeMousedown: cardinal;
    mouseHasMoved, mouseIsSelecting: boolean;
  end;

type TdrawUnitProc = procedure (Buffer: tbitmap32; ul: tunitdata; iconArray:tIconArray);

function getWowCoords(x,y: integer): tpoint;
function getReplayCoord(wowx,wowy: integer): tpoint;
procedure LimitRatio;
procedure drawDistCircle(Buffer: tbitmap32; conditional: boolean; ul: tUnitData);
procedure drawUnitCircle(Buffer: tbitmap32; ul: tunitdata; iconArray:tIconArray);
procedure drawBarWidget(Buffer: tbitmap32; x, y, w, h, value, max, adjust: integer; c: tcolor32 = 0);
procedure castBarWidget(Buffer: tbitmap32; pu: tUnitData; adjust: integer; currentTime: integer);
procedure drawUnitInfo(Buffer: tbitmap32; ul: tunitdata; iconArray:tIconArray);
procedure drawUnits(buffer: tbitmap32; proc: TdrawUnitProc; iconArray:tIconArray);
procedure replaygetmarkedUnit(Buffer: tbitmap32; ul: tUnitData; t, adjust: integer; iconArray:tIconArray);
procedure ReplayDrawGrid(Buffer: tbitmap32; w,h: integer);
procedure replayDrawArrow(Buffer: tbitmap32; x1, y1, x2, y2: integer; pcolor: tcolor);
procedure ReplayGenerateUnitPos (eventlist, EventDeathlist: tlist; w,h, startTime: integer; autofit: boolean);
function getReplayIdFromTime(Eventlist: tlist; timepos: integer; playforward: integer): integer;

procedure drawHPWidget(Buffer: tbitmap32; pu: tUnitData; adjust: integer);
procedure addreplayHighligh(s:tspellInfo);
procedure drawhighLightlabel(Buffer: tbitmap32; w: integer);
procedure initreplay;
procedure freeReplay;

var replay: rReplay;
    replayCastList: tlist;
    replaylist: tlist;
    replayHighlight: tlist;

implementation

procedure initreplay;
begin
   replaylist:= tlist.create;
   replayCastList:= tlist.create;
   replayHighlight:= tlist.create;
end;

procedure freeReplay;
begin
   replaylist.free;
   replayCastList.free;
   replayHighlight.free;
end;

procedure addreplayHighligh(s:tspellInfo);
var i: integer;
begin
  for i :=0 to replayHighlight.count-1 do
    if s = replayHighlight[i] then exit;
  replayHighlight.add(s);
end;

constructor tReplaydraw.initdata(shape: boolean; p: tpoint; d: integer);
begin
  circle := shape;
  if circle then
  begin
      cCenter := p;
      cRayon := d;
  end
  else
  begin
    l := tlist<tpoint>.create;
    l.add(p);
  end;
end;

destructor tReplaydraw.destroy;
begin
  l.free;
  inherited;
end;

function getReplayIdFromTime(Eventlist: tlist;  timepos: integer; playforward: integer): integer;
begin
  dummypEvent.Time := timepos;
  FastListSearch(Eventlist, compareEventTime, dummypEvent, Result, playforward);
  if result > Eventlist.count - 1 then result := Eventlist.count - 1;
end;

procedure LimitRatio;
begin
  if replay.Ratio<0.03 then replay.Ratio := 0.03;
  if replay.Ratio>3.00 then replay.Ratio := 3.00;
end;

function getReplayCoord(wowx,wowy: integer): tpoint;
begin
  result.x:= round((wowx - replay.Offx) * replay.Ratio)+30+ replay.imgoffsetx;
  result.y:= round((wowy - replay.Offy) * replay.Ratio)+30+ replay.imgoffsety;
end;

function getWowCoords(x,y: integer): tpoint;
begin
   result.x:= round(divide((x - (replay.imgoffsetx+30)) , replay.Ratio)+  replay.Offx);
   result.y:= round(divide((y - (replay.imgoffsety+30)) , replay.Ratio)+  replay.Offy);
end;

procedure drawhighLightlabel(Buffer: tbitmap32; w: integer);
var i, cx: integer;
    s:tspellInfo;
const YOffset = 14;
      Ymargin = 5;
begin
  buffer.font.style :=[fsBold];
  buffer.font.color := clBlack;

  for i :=0 to replayHighlight.count-1 do
  begin
    s := replayHighlight[i];
    cx := buffer.TextExtent(s.name).cx;
    Buffer.textout(w - 25 - cx ,i * YOffset + Ymargin, s.name);
    Buffer.FillRectTS(w - 20  , i * YOffset + Ymargin +2 , w - 5 , i * YOffset + Ymargin + 12, setalpha(color32(s.constantParams.avoidableColor),$77));
    Buffer.FrameRectS(w - 20  , i * YOffset + Ymargin + 2 , w - 5 , i * YOffset + Ymargin  + 12, color32(s.constantParams.avoidableColor));
  end;
end;



procedure replayDrawArrow(Buffer: tbitmap32; x1, y1, x2, y2: integer; pcolor: tcolor);
var
  HeadLength: integer;
  FootLength: integer;
  xbase: integer;
  xLineDelta: integer;
  xLineUnitDelta: double;
  xNormalDelta: integer;
  xNormalUnitDelta: double;
  ybase: integer;
  yLineDelta: integer;
  yLineUnitDelta: double;
  yNormalDelta: integer;
  yNormalUnitDelta: double;
begin
  Buffer.pencolor := color32(pcolor);
  Buffer.MoveTo(x1, y1);
  Buffer.linetos(x2, y2);
  xLineDelta := x2 - x1;
  yLineDelta := y2 - y1;

  if not InRange(xLineDelta, -2500, 2500) or not InRange(yLineDelta, -2500,
    2500) then
    exit;

  xLineUnitDelta := divide(xLineDelta, sqrt(sqr(xLineDelta) + sqr(yLineDelta)));
  yLineUnitDelta := divide(yLineDelta, sqrt(sqr(xLineDelta) + sqr(yLineDelta)));
  HeadLength := 25;
  FootLength := 5;
  xbase := x2 - round(HeadLength * xLineUnitDelta);
  ybase := y2 - round(HeadLength * yLineUnitDelta);
  xNormalDelta := yLineDelta;
  yNormalDelta := -xLineDelta;
  xNormalUnitDelta := divide(xNormalDelta,
    sqrt(sqr(xNormalDelta) + sqr(yNormalDelta)));
  yNormalUnitDelta := divide(yNormalDelta,
    sqrt(sqr(xNormalDelta) + sqr(yNormalDelta)));
  //Buffer.MoveTo(x2, y2);
  Buffer.linetots(xbase + round(FootLength * xNormalUnitDelta),
    ybase + round(FootLength * yNormalUnitDelta));
  Buffer.linetots(xbase - round(FootLength * xNormalUnitDelta),
    ybase - round(FootLength * yNormalUnitDelta));
  Buffer.linetots(x2, y2);
end;

procedure replayDrawGridLine(Buffer: tbitmap32; Size: integer; m: double; w,h: integer);
var
  i: integer;
  maxl: integer;
  startp: TPoint;
begin
  // getting starting point
  startp := getwowcoords(1, 1);
  startp.x := (startp.x div (100 * Size)) * (100 * Size);
  startp.y := (startp.y div (100 * Size)) * (100 * Size);
  startp := getreplaycoord(startp.x, startp.y);
  m := m * Size;

  maxl := round((w) / m) + 2;
  for i := 0 to maxl do
  begin
    Buffer.movetof(m * i + startp.x, 0);
    Buffer.linetofsp(m * i + startp.x, h);
  end;
  maxl := round((h) / m) + 2;
  for i := 0 to maxl do
  begin
    Buffer.movetof(0, m * i + startp.y);
    Buffer.linetofsp(w, m * i + startp.y);
  end;
end;


procedure ReplayDrawGrid(Buffer: tbitmap32; w,h: integer);
var
  m: double;
begin
  if not replay.UseUnitLoc then
    exit;
  // define 1 meter size
  m := 100.0 * replay.ratio;
  // affichage des secondes
  if m > 25.0 then
  begin
    Buffer.SetStipple([$FFAAAAAA, $FFAAAAAA, $FF888888]);
    replayDrawGridLine(Buffer, 1, m, w,h)
  end;
  // affichage 5m
  Buffer.SetStipple([$FFAAAAAA, $FFAAAAAA, $FF555555]);
  replayDrawGridLine(Buffer, 5, m, w,h)
end;

procedure drawUnits(buffer: tbitmap32; proc: TdrawUnitProc; iconArray:tIconArray);
var postponedUnit: tUnitData;
    ul: tUnitData;
    i: integer;
begin
  postponedUnit:= nil;
  for i := 0 to replaylist.count - 1 do
  begin
    ul := replaylist[i];
    if (ul.replaydata.r.isinGfx)  then
    begin
      if (ul=replay.SelectedUnit) then
        postponedUnit := replay.SelectedUnit
      else
       proc(Buffer, ul , iconArray);
    end;
  end;
  if assigned(postponedUnit) then
       proc(Buffer, postponedUnit, iconArray);
end;

procedure drawDistCircle(Buffer: tbitmap32; conditional: boolean; ul: tUnitData);
var
  poly: tPolygon32;
  i: integer;
  angle, dist, arc: double;
  a, b: integer;
  cratio: single;
  filledAlpha: byte;
begin
  if (not conditional)  then exit;
  if ul.replaydata.r.circleSize <MINUNITCIRCLESIZE then ul.replaydata.r.circleSize := MINUNITCIRCLESIZE;
  if not REPLAY_DRAWPLAYERCIRCLE and
     not((ul=replay.SelectedUnit) or assigned(ul.replaydata.r.ishit))and
     (ul.uGUID.unittype= unitisPlayer) then exit;

  if assigned(ul.replaydata.r.ishit)  then
  begin
    poly := tPolygon32.create;
    filledAlpha := $77;
  end
  else if (replay.selectedUnit=ul)  then
  begin
    poly := tPolygon32.create;
    filledAlpha := $44;
  end
  else if ul.replaydata.r.forceCircle then
  begin
    poly := tPolygon32.create;
    filledAlpha := $22;
  end
  else
  begin
    poly := nil;
    filledAlpha := 0;
  end;

  cratio := 0.8;
  dist := ul.replaydata.r.circleSize * replay.ratio;
  arc := (ul.replaydata.r.circleSize * cratio) * replay.ratio;
  angle := DegToRad(divide(360.0, arc));
  for i := 0 to round(arc) do
  begin
    a := round(ul.replaydata.r.x + dist * sin(angle * i));
    b := round(ul.replaydata.r.y + dist * cos(angle * i));
    Buffer.FillRectS(a, b, a + 2, b + 2, ul.replaydata.r.color32);
    if assigned(poly) then
      poly.add(FixedPoint(a, b));
  end;

  if assigned(poly) then
  begin
    //Poly.Outline.Grow(fixed(5),0).DrawFill(buffer,setalpha(ul.replayData.color32, $66));
    poly.DrawFill(Buffer, setalpha(ul.replaydata.r.color32, filledAlpha));
    poly.free;
  end;
end;

procedure drawHPWidget(Buffer: tbitmap32; pu: tUnitData; adjust: integer);
var
  x: integer;
  wposx, wposy, widgetx: integer;
  c: cardinal;
begin
  wposx := pu.replaydata.r.x + (REPLAY_UNITSIZE + adjust + 2);
  wposy := pu.replaydata.r.y - (REPLAY_UNITSIZE + adjust);
  widgetx := WIDGETSIZEX + adjust * 5;
  //hp
  x := round(divide((int64(pu.replaydata.r.hp) * widgetx),  pu.replaydata.r.hpMax));
  if x < widgetx div 3 then
    c := $99FF0000
  else if x < (widgetx div 3) * 2 then
    c := $99FF9900
  else
    c := $9900FF00;
  Buffer.FillRectTS(wposx, wposy, wposx + x, wposy + HPWIDGETSIZEY + adjust, c);
  Buffer.lines(wposx + x, wposy, wposx + x, wposy + HPWIDGETSIZEY + adjust, c);
  Buffer.FrameRectS(wposx, wposy, wposx + widgetx + 1,  wposy + HPWIDGETSIZEY + adjust, c);

  //power
  x := round(divide((int64(pu.replaydata.r.power)  * widgetx), pu.replaydata.r.powerMax));
  c:= eINFOPOWER[pu.getcurrentPower(CURRENTPOWER) + 1].color;
  Buffer.FillRectS(wposx, wposy +HPWIDGETSIZEY + adjust + 1 , wposx + x, wposy +HPWIDGETSIZEY + adjust + 1 + POWERWIDGETSIZEY, c);

end;

procedure drawBarWidget(Buffer: tbitmap32; x, y, w, h, value, max, adjust: integer; c: tcolor32 = 0);
var
  xvalue: integer;
  wposx, wposy, widgetx: integer;

begin
  wposx := x + (REPLAY_UNITSIZE + adjust);
  wposy := y - (REPLAY_UNITSIZE + adjust);
  widgetx := w + adjust * 5;
  xvalue := round(divide((int64(value) * widgetx), max));

  if c= 0 then
    if xvalue < widgetx div 3 then
      c := $99FF0000
    else if xvalue < (widgetx div 3) * 2 then
      c := $99FF9900
    else
      c := $9900FF00;
  Buffer.FillRectTS(wposx, wposy, wposx + xvalue, wposy + h + adjust, c);
  Buffer.lines(wposx + xvalue, wposy, wposx + xvalue, wposy + h + adjust, c);
  Buffer.FrameRectS(wposx, wposy, wposx + widgetx + 1,wposy + h + adjust, c);
end;

procedure drawUnitCircle(Buffer: tbitmap32; ul: tunitdata; iconArray:tIconArray);
begin
  if ul.Classe = 0 then
  begin
    if upIsValidNPC in ul.params then
    begin
      if uoReplayEmphasis in GetUnitOption(ul) then ul.replaydata.r.forceCircle:=true;
      ul.replaydata.r.circleSize := tunitinfo(ul.unitinforef).constantParams.replaySize;
      if not  assigned(ul.replaydata.r.ishit) then
        ul.replaydata.r.color32 := color32(tunitinfo(ul.unitinforef).constantParams.replayColor);
    end;
    if assigned(ul.UnitAffiliation) and (tUnitData(ul.UnitAffiliation).uGUID.unittype = unitisplayer) then
      ul.replaydata.r.circleSize := 400;

    //minimum
    if ul.replaydata.r.color32 = $0000000 then
      ul.replaydata.r.color32 := $FF555555;
    if ul.replaydata.r.circleSize = 0 then
      ul.replaydata.r.circleSize := 500;
  end;
  //---------------------------------------------------------------
  if ul.uGUID.unittype = unitisplayer then
  begin
    ul.replaydata.r.circleSize := replay.playercircle;
    if not assigned(ul.replaydata.r.ishit) then
      ul.replaydata.r.color32 := $AA00FF00;
  end
  else
  begin
    if ul.replaydata.r.circleSize < 500 then
    begin
      setalpha(ul.replaydata.r.color32, $AA);
      ul.replaydata.r.unitsizeAdjust := -1
    end
    else if ul.replaydata.r.circleSize > 500 then
    begin
      ul.replaydata.r.unitsizeAdjust := ul.replaydata.r.unitsizeAdjust +
        (ul.replaydata.r.circleSize - 500) div 200;
      if ul.replaydata.r.unitsizeAdjust > 5 then
        ul.replaydata.r.unitsizeAdjust := 5
    end;
  end;
  drawDistCircle(Buffer, ul.replaydata.r.notplaced = 0, ul);
end;

procedure castBarWidget(Buffer: tbitmap32; pu: tUnitData; adjust: integer; currentTime: integer);
var
  tmp1: integer;
  x: integer;
  wposx, wposy, widgetx: integer;
  c: cardinal;
begin
  wposx := pu.replaydata.r.x + (REPLAY_UNITSIZE + adjust + 2);
  wposy := pu.replaydata.r.y - (REPLAY_UNITSIZE + adjust)+ HPWIDGETSIZEY + POWERWIDGETSIZEY + adjust + 2;

  c := $EE0055FF; // base blue

  if pu.replaydata.r.timeCastInterrupted > 0 then
  begin
    if (pu.replaydata.r.timeCastInterrupted - currentTime < 5) then
    begin
      c := $EEFF0000;
      if currentTime - pu.replaydata.r.timeCastInterrupted > 30 then
        exit
      else if currentTime - pu.replaydata.r.timeCastInterrupted > 0 then
        currentTime := pu.replaydata.r.timeCastInterrupted;
    end;
  end
  else if (pu.replaydata.r.timecastEnd - currentTime < 20) then
  begin
    if pu.replaydata.r.castSuccess then
      c := $EEFFFF00
    else
      c := $EE555555
  end;

  tmp1 := currentTime - pu.replaydata.r.timecastStart;
  widgetx := CASTWIDGETSIZEX + adjust * 5;

  x := round(divide((tmp1 * widgetx), pu.replaydata.r.timecastEnd - pu.replaydata.r.timecastStart));

  Buffer.FillRectTS(wposx, wposy, wposx + x, wposy + CASTWIDGETSIZEY + adjust,c);
  Buffer.lines(wposx + x, wposy, wposx + x, wposy + CASTWIDGETSIZEY + adjust,c);
  Buffer.FrameRectS(wposx, wposy, wposx + widgetx + 1,wposy + CASTWIDGETSIZEY + adjust, c);
  Buffer.textout(wposx + widgetx + 4, wposy + (round(ceil((CASTWIDGETSIZEY + adjust) / 2.0))) - 8 , '<' + tspellinfo(pu.replaydata.r.castSpell).name + '>')
end;

procedure drawUnitInfo(Buffer: tbitmap32; ul: tunitdata; iconArray:tIconArray);
var j, tagCast, dose, tmpSize, nbAura: integer;
  p:pevent;
  uname, tmpString: string;
begin
  Buffer.font.color := $00000000;
  Buffer.font.Style := [];

  if (uoReplayEmphasis in GetUnitOption(ul)) or (ul.replaydata.r.unitsizeAdjust > 1) then
    Buffer.font.Style := [fsBold]
  else if (ul.replaydata.r.unitsizeAdjust < 0) then
  begin
    Buffer.font.Style := [fsItalic];
    Buffer.font.color := $00555555;
  end;

  uname := getunitname(ul, [getaff, gettag, getNoserver]); // + format('(%.1f,%.1f)',[ul.replaydata.r.wowx/100,ul.replaydata.r.wowy/100]) ;

  if (replay.selectedUnit=ul)  then
  begin
    Buffer.font.Style := [fsBold];
    uname := '['+ uname  +']';
  end;

  if (ul.replaydata.r.hpFound) and (ul.replaydata.r.hp = 0) then
    Buffer.font.color := $000000AA;
  Buffer.textout(ul.replaydata.r.x -
      (REPLAY_UNITSIZE + ul.replaydata.r.unitsizeAdjust),
    ul.replaydata.r.y -
      (13 + REPLAY_UNITSIZE + ul.replaydata.r.unitsizeAdjust), uname);//+ ' '+inttostr(ul.replaydata.r.hp)+'|'+inttostr(ul.replaydata.r.hpmax));

  Buffer.FillRectTS(ul.replaydata.r.x -
      (REPLAY_UNITSIZE + ul.replaydata.r.unitsizeAdjust),
    ul.replaydata.r.y - (REPLAY_UNITSIZE + ul.replaydata.r.unitsizeAdjust),
    ul.replaydata.r.x + (REPLAY_UNITSIZE + ul.replaydata.r.unitsizeAdjust),
    ul.replaydata.r.y + (REPLAY_UNITSIZE + ul.replaydata.r.unitsizeAdjust),
    color32(ClasseStat[ul.Classe].color));

  if Buffer.font.Style = [fsBold] then  Buffer.font.Style := [];

  // widget
  if AuthUse52Log then drawHPWidget(Buffer, ul,  ul.replaydata.r.unitsizeAdjust);

  if assigned(ul.replaydata.r.castSpell) then
  begin
    castBarWidget(Buffer, ul, ul.replaydata.r.unitsizeAdjust, replay.startTime);
    tagCast := CASTWIDGETSIZEY + ul.replaydata.r.unitsizeAdjust + 5;
  end
  else
    tagCast := 3;



  for j := 0 to ul.replaydata.currentauraList.count-1 do
  begin
      p:= ul.replaydata.currentauraList[j];
      dose:= p.eventStat.amountGeneric;
      //if dose = 0 then dose := 1;

      buffer.font.style:= [fsBold];
      buffer.font.color:= p.getcolor;

      Buffer.textout(ul.replaydata.r.x + (REPLAY_UNITSIZE + ul.replaydata.r.unitsizeAdjust) + 2,
                     ul.replaydata.r.y + 9 * j + tagCast,
                     AURATAG);
      buffer.font.color:= clBlack;
      if dose > 1 then
      begin
        tmpString:='['+inttostr(dose)+'] ';
        tmpSize := Buffer.textextent(tmpString).cx;
        Buffer.textout(ul.replaydata.r.x + (REPLAY_UNITSIZE + ul.replaydata.r.unitsizeAdjust) + 15,
                     ul.replaydata.r.y + 9 * j + tagCast, tmpString);
      end
      else tmpSize := 0;
      buffer.font.style:= [];
      Buffer.textout(ul.replaydata.r.x + (REPLAY_UNITSIZE + ul.replaydata.r.unitsizeAdjust) + 15+ tmpSize,
                     ul.replaydata.r.y + 9 * j + tagCast,
                     p.spell.name);

    if ul.replaydata.r.notplaced > 0 then
      break; // write only one skill if unit is notplaced
  end;

  nbAura:=  ul.replaydata.currentauraList.count;

  // Spellcast
  if REPLAY_DRAWATTACK then
      for j := 0 to high(ul.replaydata.r.event) do
      begin
        if assigned(ul.replaydata.r.event[j]) then
        begin
          buffer.font.style:= [fsBold];
          buffer.font.color:= pEvent(ul.replaydata.r.event[j]).getcolor;

          Buffer.textout(ul.replaydata.r.x + (REPLAY_UNITSIZE + ul.replaydata.r.unitsizeAdjust) + 2,
                         ul.replaydata.r.y + 9 * (j+ nbAura) + tagCast,
                         OUT_EVENT_TAG);
          buffer.font.color:= clBlack;
          buffer.font.style:= [];
          Buffer.textout(ul.replaydata.r.x + (REPLAY_UNITSIZE + ul.replaydata.r.unitsizeAdjust) + 15,
                          ul.replaydata.r.y + 9 * (j+ nbAura) + tagCast,
                          pEvent(ul.replaydata.r.event[j]).spell.name);
        end
        else
          break;
        if ul.replaydata.r.notplaced > 0 then
          break; // write only one skill if unit is notplaced
      end;


  replaygetmarkedUnit(Buffer, ul, replay.startTime, ul.replaydata.r.unitsizeAdjust,iconArray);
end;

procedure replaygetmarkedUnit(Buffer: tbitmap32; ul: tUnitData; t, adjust: integer; iconArray:tIconArray);
var
  i, j: integer;
  pm: pmarkevent;
begin
  for i := low(markedlist) to high(markedlist) do
    for j := 0 to markedlist[i].count - 1 do
    begin
      pm := markedlist[i].items[j];
      if pm.startTime > t then
        break;
      if (pm.u = ul) and (pm.startTime <= t) and (pm.endTime >= t) then
        Buffer.draw(ul.replaydata.r.x - ((REPLAY_UNITSIZE + adjust) * 2 + 11), ul.replaydata.r.y - 7, iconArray[i]);
    end;
end;

procedure defineAura(ul:tunitdata);
var j, k: integer;
    p1, p2: pEvent;
begin
    for j := 0 to ul.replayData.auraList.count-1 do
    begin
      p1:=ul.replayData.auraList[j];
      if p1.time> replay.StartTime then break;
      for k := ul.replayData.currentauraList.count-1 downto 0 do
      begin
        p2:= ul.replayData.currentauraList[k];
        if (p1.spell = p2.spell) and (p1.sourceUnit = p2.sourceUnit) then  ul.replayData.currentauraList.delete(k);
      end;
      if not (eventisauraremove in p1.params) then ul.replayData.currentauraList.add(p1);
    end;
end;

procedure initCastBar(el: tlist; rtime, startTime: integer);
var
  j, tmp, startId, tmpInterrupt: integer;
  p: pEvent;
  tmpSuccess: boolean;
begin

  dummypEvent.Time := startTime;
  FastListSearch(el, compareEventTime, dummypEvent, startId, -1);
  if startId > 0 then
    dec(startId);

  for j := startId to el.count - 1 do
  begin
    p := el[j];
    if p.Time > rtime then
      exit;

    if eventCastWillSuccess in p.params then
    begin
      tmp := p.eventStat.castEndTime;
      tmpInterrupt := 0;
      tmpSuccess := true;
    end
    else
    begin
      tmp := p.Time + p.spell.castDuration;
      tmpInterrupt := p.eventStat.castInterruptTime;
      tmpSuccess := false;
    end;

    if tmp > rtime then
    begin
      p.sourceUnit.replaydata.r.castSpell := p.spell;
      p.sourceUnit.replaydata.r.timecastEnd := tmp;
      p.sourceUnit.replaydata.r.timecastStart := p.Time;
      p.sourceUnit.replaydata.r.castSuccess := tmpSuccess;
      p.sourceUnit.replaydata.r.timeCastInterrupted := tmpInterrupt;
    end;
  end;
end;

procedure ReplayGenerateUnitPos (eventlist, EventDeathlist: tlist; w,h, startTime: integer; autofit: boolean);
var
  i, j, i2, r, cx, cy, replayCount, tmpx: integer;
  ul: tUnitData;
  nc: TPoint;
  angle, ratiox, ratioy: double;
  p: pEvent;
  notplacedcount, tmpStartedId: integer;
begin
  replayCount := 0;
  {$IFDEF DEBUG}
      crawlCount:=0;
  {$ENDIF}

  for i := 0 to replaylist.count - 1 do
  begin
    ul := replaylist[i];
    ul.replaydata.cleanData;
    // -------------
    if (upWasPlayerInRaid in ul.params) or
      ((ul.inCombat.First <= replay.startTime) and
        (ul.inCombat.last >= replay.startTime)) then
    begin
      ul.replaydata.r.isinGfx := true;
      defineAura(ul);
      inc(replayCount);
    end
    else
      ul.replaydata.r.isinGfx := false;
    // get hp & loc  --------------------------------------------
    if not replay.UseUnitLoc then ul.replaydata.r.locFound:= true;
  end;

   // ----define castBar
  initCastBar(replayCastList, replay.startTime, startTime);

  cx := w div 2;
  cy := h div 2;
  if w > h then
    r := (h - 70) div 2
  else
    r := (h - 70) div 2;

  // draw unit in circle
  if not replay.UseUnitLoc and (replayCount > 0) then
  begin
    replay.ratio := 1.0;
    i2 := 0;
    angle := DegToRad(360.0 / replayCount);
    for i := 0 to replaylist.count - 1 do
    begin
      ul := replaylist[i];
      if ul.replaydata.r.isinGfx then
      begin
        inc(i2);
        ul.replaydata.r.x := round(cx + r * sin(angle * i2));
        ul.replaydata.r.y := round(cy + r * cos(angle * i2));
      end
      else
      begin
        ul.replaydata.r.x := 0;
        ul.replaydata.r.y := 0;
      end;
    end;
  end;

  // getPos - arbitrary bounds
  replay.minx := 4000000;
  replay.miny := 4000000;
  replay.maxx := -4000000;
  replay.maxy := -4000000;
  notplacedcount := 0;


  // backward

  tmpStartedId:= getReplayIdFromTime(Eventlist, replay.startTime + 300, 0);
  for j := tmpStartedId downto 0 do
  begin
    p := Eventlist[j];
    {$IFDEF DEBUG}
      inc(crawlCount);
    {$ENDIF}
    if p.Time < replay.startTime - REPLAY_CRAWLTIME then break; // 5sec backward

    if assigned(p.eInfo.u) then
    begin
       if not p.eInfo.u.replaydata.r.hpFound then
      begin
        p.eInfo.u.replaydata.r.hp := p.eInfo.Data[1];
        p.eInfo.u.replaydata.r.hpmax := p.eInfo.Data2[1];
        p.eInfo.u.replaydata.r.hpFound := p.Time < replay.startTime;
      end;
      if not p.eInfo.u.replaydata.r.powerFound then
      begin
        if p.eInfo.Data[4] = p.eInfo.u.getcurrentPower(CURRENTPOWER)  then
        begin
          p.eInfo.u.replaydata.r.power := p.eInfo.Data[5];
          p.eInfo.u.replaydata.r.powermax := p.eInfo.Data2[3];
          p.eInfo.u.replaydata.r.powerFound := p.Time < replay.startTime;
        end;
      end;
      if not p.eInfo.u.replaydata.r.locFound then
      begin
        p.eInfo.u.replaydata.r.wowx := -p.eInfoPos.Data[1]; // reverse X axis
        p.eInfo.u.replaydata.r.wowy := p.eInfoPos.Data[2];
        p.eInfo.u.replaydata.r.locFound := p.Time < replay.startTime;
      end;
    end;
    if (eventisdeath in p.params) and (assigned(p.destUnit)) and not p.destUnit.replaydata.r.locFound then
    begin
      p.destUnit.replaydata.r.hp := 0;
      p.destUnit.replaydata.r.power := 0;
      p.destUnit.replaydata.r.hpFound := p.Time < replay.startTime;
      p.destUnit.replaydata.r.powerFound := p.Time < replay.startTime;
    end;
  end;

  // death event list check
  tmpStartedId:= getReplayIdFromTime(EventDeathlist, replay.startTime + 100, 0);
  for j := tmpStartedId downto 0 do
  begin
    p := EventDeathlist[j];
    if p.Time > (replay.startTime) then
      continue;
    if p.Time < (startTime - 1000) then
      break;
    if assigned(p.destUnit) and  (p.destUnit.uGUID.unittype = unitisplayer) and not p.destUnit.replaydata.r.locFound then
    begin
      p.destUnit.replaydata.r.hp := 0;
      p.destUnit.replaydata.r.power := 0;
      p.destUnit.replaydata.r.hpFound := true;
      p.destUnit.replaydata.r.powerFound := true;
    end;
  end;

  // get advanceddata
  for i := 0 to replaylist.count - 1 do
  begin
    ul := replaylist[i];
    if ul.replaydata.r.isinGfx then
    begin
      // get boundaries --------------------------------------------
      if replay.UseUnitLoc then
      begin
        if (ul.replaydata.r.wowx = 0) and (ul.replaydata.r.wowy = 0) then
        begin
          inc(notplacedcount);
          ul.replaydata.r.notplaced := notplacedcount;
        end
        else
        begin
          // faster than using sin/cos for 90° step angles
          case replay.angle of
            90:
              begin
                tmpx := ul.replaydata.r.wowx;
                ul.replaydata.r.wowx := -ul.replaydata.r.wowy;
                ul.replaydata.r.wowy := tmpx;
              end;
            180:
              begin
                ul.replaydata.r.wowx := -ul.replaydata.r.wowx;
                ul.replaydata.r.wowy := -ul.replaydata.r.wowy;
              end;
            270:
              begin
                tmpx := ul.replaydata.r.wowx;
                ul.replaydata.r.wowx := ul.replaydata.r.wowy;
                ul.replaydata.r.wowy := -tmpx;
              end;
          end;
          if ul.replaydata.r.wowx < replay.minx then
            replay.minx := ul.replaydata.r.wowx;
          if ul.replaydata.r.wowy < replay.miny then
            replay.miny := ul.replaydata.r.wowy;
          if ul.replaydata.r.wowx > replay.maxx then
            replay.maxx := ul.replaydata.r.wowx;
          if ul.replaydata.r.wowy > replay.maxy then
            replay.maxy := ul.replaydata.r.wowy;
        end;
      end;
    end;
  end;

  if replay.UseUnitLoc then
  begin
    if replay.Evaluateratio or autofit then
    begin
      replay.imgoffsetx := 0;
      replay.imgoffsety := 0;
      replay.Offx := replay.minx;
      replay.Offy := replay.miny;
      ratiox := divide(w - 60, abs(replay.maxx - replay.minx));
      ratioy := divide(h - 60, abs(replay.maxy - replay.miny));
      if ratiox < ratioy then
        replay.ratio := ratiox
      else
        replay.ratio := ratioy;
      LimitRatio;
      nc := getreplaycoord(replay.maxx, replay.maxy);
      replay.imgoffsetx := (w - 30 - nc.x) div 2;
      replay.imgoffsety := (h - 30 - nc.y) div 2;
      replay.Evaluateratio := false;
    end;

    for i := 0 to replaylist.count - 1 do
    begin
      ul := replaylist[i];
      if ul.replaydata.r.powermax =0 then ul.replaydata.r.powermax := ul.mana;
      if ul.replaydata.r.hpmax =0 then ul.replaydata.r.hpmax := ul.uHp;

      if ul.replaydata.r.isinGfx then
      begin
        if ul.replaydata.r.notplaced > 0 then
        begin
          ul.replaydata.r.x := 12;
          ul.replaydata.r.y := (ul.replaydata.r.notplaced) * 30 + 15;
        end
        else
        begin
          nc := getreplaycoord(ul.replaydata.r.wowx, ul.replaydata.r.wowy);
          ul.replaydata.r.x := nc.x;
          ul.replaydata.r.y := nc.y;
        end;
      end;
    end;
  end;
end;

end.
