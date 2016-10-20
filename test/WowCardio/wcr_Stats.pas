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
unit wcr_Stats;

interface

uses Classes, SysUtils, wcr_Parser_Events, wcr_Const, wcr_utils, VirtualTrees;

type

  calcStatopt = (incombatonly, usefilter, usefocus, useExclusivemode, useaffiliation, usehealabsorb, useabsorbed, noffdamage, noenemyheal,
    useSumStats, forcenopet);
  scalcStatopts = set of calcStatopt;

  combatStatvalue = record
    total, max: integer;
    ref: double;
  end;

  quickStats = record
    incDamage, incHeal: integer;
  end;

  summonParams = record
    event: eventType;
    spellId, UnitId, timemin, timemax, nbUnit: integer;
  end;

  tSummonTracker = class
    p: pevent;
    UnitId, nbUnit, starttime, fadetime: integer;
    constructor initdata(p: pevent; s: summonParams);
  end;

  rotationstate = (isdamage, isheal, isabsorb, isbuff, isdebuff, isPower, isOther);
  srotationstate = set of rotationstate;

  rRotationStat = record
    // damage
    total: int64;
    fftotal: int64;
    hit: int64;
    crit: int64;
    glance: int64;
    crush: int64;
    // periodicdamage:
    ptotal: int64;
    phit: int64;
    pcrit: int64;
    pavoided: int64;
    //-multistrike
    ms_dhit: int64;
    ms_hhit: int64;
    // miss
    miss: int64;
    parry: int64;
    dodge: int64;
    othermiss: int64;
    dotmiss: int64;
    absorb: int64;
    resist: int64;
    bloccount: int64;
    blocCritCount: int64;
    blocvalue: int64;
    // heal
    h_total: int64;
    h_rawtotal: int64;
    h_ptotal: int64;
    h_prawtotal: int64;
    h_hit: int64;
    h_crit: int64;
    h_phit: int64;
    h_pcrit: int64;
    h_absorb: int64;
    h_estAbsorb: int64;
    h_enemyheal: int64;
    // power
    power_count: int64;
    power_total: array [0 .. high(powerTypeparam)] of int64;
    // other
    other_count: int64;
    other_cast: int64;
    other_interrupt: int64;
    other_dispel: int64;
    other_miss: int64;
    other_invoc: int64;
    // buff
    b_count: int64;
    b_rcount: int64;
    // debuff
    db_count: int64;
    db_rcount: int64;
    // checkpoint : must be the last value that must be added  ***d_hit_min** must be the first minmax index
    // ----min max (these value are not addede on
    d_hit_min, d_crit_min, d_phit_min, d_pcrit_min, d_bloc_min, h_hit_min, h_crit_min, h_phit_min, h_pcrit_min: int64;
    d_hit_max, d_crit_max, d_phit_max, d_pcrit_max, d_bloc_max, h_hit_max, h_crit_max, h_phit_max, h_pcrit_max: int64;
    // flag must be at the end
    endint: int64;
    state: srotationstate;
  end;

  tRotationLine = class
    spell: tspellinfo;
    mobid: integer;
    offset: integer;
    infilter, istotalnode: boolean;
    rs: rRotationStat;
    constructor initdata(p: pevent; mobid: integer; infilter: boolean; Statopts: scalcStatopts);
    constructor initTotalNode;
    procedure generatestat(p: pevent; infilter: boolean; Statopts: scalcStatopts);
    function getfullspellname: string;
    // func damages
    procedure clearstat;
    function count: integer;
    function pcount: integer;
    function avgHit: integer;
    function avgpHit: integer;
    function landedHit: integer;
    function avgHeal: integer;
    function avgRawHeal: integer;
    function h_count: integer;
    function h_pcount: integer;
    function OverHeal: integer;
  end;

  rRotationlines = record
    eventIn, eventOut: tlist;
    statsunit: tunitdata;
    statlevel: boolean;
    total: array [0 .. 1] of tRotationLine;
  end;

  tfixedabsLine = class
    p, p2: pevent;
    endtime: integer;
    Absorbpool: integer;
    startedooC: boolean;
    constructor initdata(p: pevent);
    procedure updatedata(p: pevent);
  end;

  tcastTimeLine = class
    p: pevent;
    endtime: integer;
    constructor initdata(p: pevent; castMax: integer = 3000);
  end;

  twatchedSpell = class
    count: integer;
    uiaff, uidest: tunitinfo;
    id: integer;
    constructor initdata(uiaff, uidest: tunitinfo; id: integer);
  end;

  twatchedEvent = class
    count: integer;
    u: tunitdata;
    noderef: integer;
    l: tlist;
    constructor initdata(u, uaff, udest: tunitdata; id, noderef: integer);
    procedure addEvent(uaff, udest: tunitdata; id: integer);
    destructor Destroy; override;
  end;

var
  summonsParams: array of summonParams;
  eventwatchlist: array [1 .. 5] of tlist;
  MainFilterID: byte;

procedure BuildSpecialSummon(EventList: tlist);
procedure createSpecialSummon(parsedline: stringArray);
procedure FindFeignDeath(EventList, eventdeathlist: tlist);
Function buildQuickStats(EventList: tlist; qUnit: tunitdata; startid, starttime, endtime: integer): quickStats;
function buildAbsorbCount(el: tlist): integer;
function buildcastTime(el, ecl: tlist): integer;
function buildcastInterrupt(el: tlist): integer;
procedure CreateWatchList;
procedure FreeWatchList;
procedure clearWatchList;
procedure addWatchedPointer(u, destu: tunitdata; id, watchedType: integer);
function IsEventInFilter(p: pevent): boolean;
function BuildStatForPeriod(EventList, returnList: tlist; startid, endtime: integer;
  incombatblock, usefilter, usefocus, focusmode, useAbsorb, usehealabsorb, excludeself, mergepet, nofriendheal, incombatonly: boolean;
  focusType: sfocustype): integer;
procedure finalysestats(incombatblock, mergepet: boolean; timeperiod, endCombattime: integer; returnList: tlist; u: tunitinfo);
procedure computeStats(ul, uldest: tunitdata; mainUnit, doAff: boolean);
procedure generateRotation(EventList: tlist; startid, endtime: integer; rotationlines: rRotationlines; watchedUnit: tunitdata;
  Statopts: scalcStatopts; focusType: sfocustype);
procedure generateRotationEx(p: pevent; l: tlist; mobid: integer; infilter: boolean; Statopts: scalcStatopts);
procedure buildingRotationsTotal(r: tRotationLine; l: tlist);
function sortrotationlineslistdamage(p1, p2: pointer): integer;
function sortrotationlineslistname(p1, p2: pointer): integer;
function sortrotationlineslistheal(p1, p2: pointer): integer;
function sortrotationlineslistbuff(p1, p2: pointer): integer;
procedure getminvalue(var value: integer; const newvalue: integer) overload;
procedure getmaxvalue(var value: integer; const newvalue: integer)overload;
procedure getminvalue(var value: int64; const newvalue: int64) overload;
procedure getmaxvalue(var value: int64; const newvalue: int64)  overload;

implementation

constructor tRotationLine.initdata(p: pevent; mobid: integer; infilter: boolean; Statopts: scalcStatopts);
begin
  self.spell := p.spell;
  self.mobid := mobid;
  self.istotalnode := false;
  clearstat;
  generatestat(p, infilter, Statopts);
end;

constructor tRotationLine.initTotalNode;
begin
  self.istotalnode := true;
  clearstat;
end;

procedure tRotationLine.clearstat;
begin
  fillchar(self.rs, sizeof(self.rs), 0);
end;

function tRotationLine.getfullspellname: string;
begin
  if mobid = 0 then
    result := ''
  else
    result := bracket_string(getunitname(mobid, []));
  result := trimleft(result + spell.name); // + abstag[ord(isabsorb in rs.state)]
end;

function tRotationLine.count: integer;
begin
  result := landedHit + rs.miss + rs.parry + rs.dodge + rs.othermiss;
end;

function tRotationLine.pcount: integer;
begin
  result := rs.phit + rs.pcrit + rs.dotmiss;
end;

function tRotationLine.h_count: integer;
begin
  result := rs.h_hit + rs.h_crit;
end;

function tRotationLine.h_pcount: integer;
begin
  result := rs.h_phit + rs.h_pcrit;
end;

function tRotationLine.avgHit: integer;
begin
  result := round(divide(rs.total, landedHit));
end;

function tRotationLine.avgpHit: integer;
begin
  result := round(divide(rs.ptotal, rs.phit + rs.pcrit));
end;

function tRotationLine.landedHit: integer;
begin
  result := (rs.hit + rs.crit + rs.glance + rs.crush);
end;

function tRotationLine.avgHeal: integer;
begin
  result := round(divide(rs.h_total, h_count));
end;

function tRotationLine.avgRawHeal: integer;
begin
  result := round(divide(rs.h_rawtotal, h_count));
end;

function tRotationLine.OverHeal: integer;
begin
  result := round(divide((rs.h_rawtotal + rs.h_prawtotal) - (rs.h_total + rs.h_ptotal), (rs.h_rawtotal + rs.h_prawtotal)) * 100);
end;

procedure tRotationLine.generatestat(p: pevent; infilter: boolean; Statopts: scalcStatopts);
var
  sd: spelldatas;
  pStats: rEventStat;
  tag: integer;
  eventcounted: boolean;
begin
  if not self.infilter then
    self.infilter := infilter;
  if infilter then
  begin
    pStats := p.eventStat;
    tag := 1;
  end
  else
  begin
    fillchar(pStats, sizeof(pStats), 0);
    tag := 0;
  end;
  eventcounted := false;
  sd := getSpellDatas(p.spell);

  if (useabsorbed in Statopts) and (eventIsInitbyRaidUnit in p.params) then
    pStats.usedAbsorb := pStats.absorb;

  // check damage
  if spellIsDamage in sd then
  begin
    eventcounted := true;

    //multiStrike Generic
    if (eventIsCombat in p.params) and (eventIsMultistrike in p.params) then inc(rs.ms_dHit, tag);

    if eventIsMitigatigatedAbsorb in p.params then
      rs.absorb := rs.absorb + pStats.absorb;
    if eventIsMitigatigatedResist in p.params then
      rs.resist := rs.resist + pStats.resist;
    if eventIsMitigatigatedBlock in p.params then
    begin
      inc(rs.bloccount, tag);
      if eventiscriticalblock in p.params then
        inc(rs.blocCritCount, tag);
      rs.blocvalue := rs.blocvalue + pStats.block;
      getminvalue(rs.d_bloc_min, pStats.block);
      getmaxvalue(rs.d_bloc_max, pStats.block);
    end;

    if eventIsPeriodic in p.params then
    begin
      if eventIsfullmiss in p.params then
      begin
        include(rs.state, isdamage);
        inc(rs.dotmiss, tag)
      end
      else if eventIsdamage in p.params then
      begin
        include(rs.state, isdamage);

        if (eventIsFriendlyVsFriendly in p.params) then
        begin
          rs.fftotal := rs.fftotal + pStats.amountGeneric;
          if noffdamage in Statopts then
            pStats.amountGeneric := 0; //
        end;
        rs.ptotal := rs.ptotal + pStats.amountGeneric + pStats.usedAbsorb;

        if eventisCrit in p.params then
        begin
          inc(rs.pcrit, tag);
          getminvalue(rs.d_pcrit_min, pStats.amountGeneric);
          getmaxvalue(rs.d_pcrit_max, pStats.amountGeneric);
        end
        else
        begin
          inc(rs.phit, tag);
          getminvalue(rs.d_phit_min, pStats.amountGeneric);
          getmaxvalue(rs.d_phit_max, pStats.amountGeneric);
        end;
      end;
    end
    else
    begin
      if eventIsfullmiss in p.params then
      begin
        include(rs.state, isdamage);
        if eventIsMitigatigatedMiss in p.params then
          inc(rs.miss, tag) // real miss
        else if eventIsMitigatigatedParry in p.params then
          inc(rs.parry, tag)
        else if eventIsMitigatigatedDodge in p.params then
          inc(rs.dodge, tag)
        else
          inc(rs.othermiss, tag);
      end
      else if eventIsdamage in p.params then
      begin
        include(rs.state, isdamage);
        if (eventIsFriendlyVsFriendly in p.params) then
        begin
          rs.fftotal := rs.fftotal + pStats.amountGeneric;
          if noffdamage in Statopts then
            pStats.amountGeneric := 0; // if eventIsFriendlyVsFriendly in p.params then
        end;
        rs.total := rs.total + pStats.amountGeneric + pStats.usedAbsorb;
        if eventisCrit in p.params then
        begin
          getminvalue(rs.d_crit_min, pStats.amountGeneric);
          getmaxvalue(rs.d_crit_max, pStats.amountGeneric);
          inc(rs.crit, tag)
        end
        else if eventisGlance in p.params then
          inc(rs.glance, tag)
        else if eventisCrush in p.params then
          inc(rs.crush, tag)
        else
        begin
          inc(rs.hit, tag);
          getminvalue(rs.d_hit_min, pStats.amountGeneric);
          getmaxvalue(rs.d_hit_max, pStats.amountGeneric);
        end;
      end;
    end;
  end;

  // check heal
  if spellIsheal in sd then
  begin
    eventcounted := true;
    if eventIsHeal in p.params then
    begin
       //multiStrike Generic
      if eventIsMultistrike in p.params then inc(rs.ms_hHit, tag);


      include(rs.state, isheal);
      // check for enemyheal opt
      if eventIsFriendlyVsOther in p.params then
      begin
        rs.h_enemyheal := rs.h_enemyheal + pStats.amountHeal;
        if noenemyheal in Statopts then
        begin
          pStats.amountHeal := 0;
          pStats.amountOverHeal := 0;
        end;
      end;
      // -------------

      // absb heal (like Jaraxxus)
      if eventIsMitigatigatedAbsorb in p.params then
        rs.h_absorb := rs.h_absorb + pStats.absorb;
      if eventIsPeriodic in p.params then
      begin
        // set total
        rs.h_ptotal := rs.h_ptotal + pStats.amountHeal - pStats.amountOverHeal + pStats.usedAbsorb;
        rs.h_prawtotal := rs.h_prawtotal + pStats.amountHeal + pStats.usedAbsorb;
        if eventisCrit in p.params then
        begin
          inc(rs.h_pcrit, tag);
          getminvalue(rs.h_pcrit_min, pStats.amountHeal);
          getmaxvalue(rs.h_pcrit_max, pStats.amountHeal);
        end
        else
        begin
          inc(rs.h_phit, tag);
          getminvalue(rs.h_phit_min, pStats.amountHeal);
          getmaxvalue(rs.h_phit_max, pStats.amountHeal);
        end;
      end
      else
      begin
        // set count
        rs.h_total := rs.h_total + pStats.amountHeal - pStats.amountOverHeal + pStats.usedAbsorb;
        rs.h_rawtotal := rs.h_rawtotal + pStats.amountHeal + pStats.usedAbsorb;
        if eventisCrit in p.params then
        begin
          inc(rs.h_crit, tag);
          getminvalue(rs.h_crit_min, pStats.amountHeal);
          getmaxvalue(rs.h_crit_max, pStats.amountHeal);
        end
        else
        begin
          inc(rs.h_hit, tag);
          getminvalue(rs.h_hit_min, pStats.amountHeal);
          getmaxvalue(rs.h_hit_max, pStats.amountHeal);
        end;
      end;
    end;
  end;

  if eventInternalIsSpellAssigned in p.internalParams then
  begin
    // CheckLegitSpellId
    if (spellIsFixedAbsb in p.spell.sData) then
    begin
      eventcounted := true;
      rs.state := rs.state + [isheal, isabsorb];
      if not(eventInternalIsDontCountIt in p.internalParams) and (eventIsAura in p.params) then
      begin
        inc(rs.h_hit, tag);
        getminvalue(rs.h_hit_min, pStats.absorbpool);
        getmaxvalue(rs.h_hit_max, pStats.absorbpool);
      end;
      if eventIsfixedAbsorb in p.params then
      begin
        if (usehealabsorb in Statopts) and not(spellisNoAffAbsorb in p.spell.constantParams.option2) then
        begin
          rs.h_total := rs.h_total + pStats.fixedAbsorb;
          rs.h_rawtotal := rs.h_rawtotal + pStats.absorbPool + pStats.fixedAbsorb;
        end
        else
        begin
          rs.h_estAbsorb := rs.h_estAbsorb + pStats.fixedAbsorb;
        end;
      end;
    end;
  end;
  // check Buff
  if spellIsBuff in sd then
  begin
    eventcounted := true;
    if (eventIsBuff in p.params) then
    begin
      include(rs.state, isbuff);
      if (eventIsAuraApply in p.params) then
        inc(rs.b_count, tag);
      if (eventIsAuraRefresh in p.params) then
        inc(rs.b_rcount, tag);
    end;
  end;

  // check deBuff
  if spellIsDebuff in sd then
  begin
    eventcounted := true;
    if (eventIsDeBuff in p.params) then
    begin
      include(rs.state, isdebuff);
      if (eventIsAuraApply in p.params) then
        inc(rs.db_count, tag);
      if (eventIsAuraRefresh in p.params) then
        inc(rs.db_rcount, tag);
    end;
  end;

  if eventIsEnergize in p.params then
  begin
    eventcounted := true;
    include(rs.state, isPower);
    inc(rs.power_count, tag);
    rs.power_total[pStats.powertype] := rs.power_total[pStats.powertype] + pStats.amountGeneric;
  end;

  if (not eventcounted) and (spellIsnotOnlyCastSuccess in sd) and (p.event <> event_SPELL_CAST_START) then
  begin
    include(rs.state, isOther);
    if spellIsCastSuccess in sd then
    begin
      if (p.event = event_SPELL_CAST_SUCCESS) then
        inc(rs.other_count, tag);
    end
    else
      inc(rs.other_count, tag);

    if p.event = event_SPELL_CAST_SUCCESS then
      inc(rs.other_cast, tag);
    if eventIsfullmiss in p.params then
      inc(rs.other_miss, tag);
    if (eventIsInterrupt in p.params) then
      inc(rs.other_interrupt, tag);
    if (eventIsBuffDispelled in p.params) or (eventIsDebuffDispelled in p.params) then
      inc(rs.other_dispel, tag);
    if (eventIsinvocation in p.params) then
      inc(rs.other_invoc, tag);
  end;
end;

procedure getminvalue(var value: integer; const newvalue: integer);
begin
  if (newvalue > 0) and ((value = 0) or (newvalue < value)) then
    value := newvalue;
end;

procedure getmaxvalue(var value: integer; const newvalue: integer);
begin
  if (newvalue > value) then
    value := newvalue;
end;

procedure getminvalue(var value: int64; const newvalue: int64);
begin
  if (newvalue > 0) and ((value = 0) or (newvalue < value)) then
    value := newvalue;
end;

procedure getmaxvalue(var value: int64; const newvalue: int64);
begin
  if (newvalue > value) then
    value := newvalue;
end;

procedure generateRotation(EventList: tlist; startid, endtime: integer; rotationlines: rRotationlines; watchedUnit: tunitdata;
  Statopts: scalcStatopts; focusType: sfocustype);
var
  p: pevent;
  i: integer;
  tmpfilter: boolean;
  udataref: tunitdata;
begin
  // get udata ref
  if useSumStats in Statopts then
    udataref := watchedUnit.stats.sumRefUnit
  else
    udataref := nil;

  for i := startid to EventList.count - 1 do
  begin
    p := EventList.items[i];
    if p.time > endtime then
      break;
    if p.spell.Id = 0 then
      continue;

    // incombatonly
    if (incombatonly in Statopts) and not(eventInternalIsInCombatBlock in p.internalParams) then
      continue;

    // filter & focus
    tmpfilter := IsEventInFilter(p);
    if usefocus in Statopts then
      tmpfilter := tmpfilter and isEventOnFocus(p, useExclusivemode in Statopts, focusType);
    // out
    if (p.sourceUnit = watchedUnit) or (assigned(udataref) and assigned(p.sourceUnit) and (p.sourceUnit.stats.sumRefUnit = udataref)) then
      generateRotationEx(p, rotationlines.eventOut, 0, tmpfilter, Statopts);

    if not(forcenopet in Statopts) and (useaffiliation in Statopts) then
      if assigned(p.sourceUnit) and (watchedUnit = p.sourceUnit.UnitAffiliation) then
        generateRotationEx(p, rotationlines.eventOut, p.sourceUnit.uGUID.mobid, tmpfilter, Statopts);
    // inc
    if (p.destUnit = watchedUnit) or (assigned(udataref) and assigned(p.destUnit) and (p.destUnit.stats.sumRefUnit = udataref)) then
      generateRotationEx(p, rotationlines.eventIn, 0, tmpfilter, Statopts - [noffdamage, noenemyheal]);
  end;
end;

procedure buildingRotationsTotal(r: tRotationLine; l: tlist);
var
  i: integer;
  rl: tRotationLine;
  ptot, p: ^int64;
begin
  for i := 0 to l.count - 1 do
  begin
    rl := l.items[i];
    // getting first pointer adress
    ptot := @r.rs.total;
    p := @rl.rs.total;
    while p <> @rl.rs.d_hit_min do
    begin
      ptot^ := ptot^ + p^;
      inc(ptot);
      inc(p);
    end;
    // minStat
    while p <> @rl.rs.d_hit_max do
    begin
      getminvalue(ptot^, p^);
      inc(ptot);
      inc(p);
    end;
    // maxStat
    while p <> @rl.rs.endint do
    begin
      getmaxvalue(ptot^, p^);
      inc(ptot);
      inc(p);
    end;
  end;
end;

procedure generateRotationEx(p: pevent; l: tlist; mobid: integer; infilter: boolean; Statopts: scalcStatopts);
var
  found: boolean;
  j: integer;
  rotationline: tRotationLine;
begin
  found := false;
  for j := 0 to l.count - 1 do
  begin
    rotationline := l.items[j];
    if (rotationline.spell = p.spell) and (rotationline.mobid = mobid) then
    begin
      rotationline.generatestat(p, infilter, Statopts);
      found := true;
      break;
    end;
  end;
  if not found then
    l.Add(tRotationLine.initdata(p, mobid, infilter, Statopts));
end;

function sortrotationlineslistname(p1, p2: pointer): integer;
begin
  result := comparetext(tRotationLine(p1).spell.name, tRotationLine(p2).spell.name);
end;

function sortrotationlineslistdamage(p1, p2: pointer): integer;
begin
  result := (tRotationLine(p2).rs.total - tRotationLine(p1).rs.total);
end;

function sortrotationlineslistheal(p1, p2: pointer): integer;
begin
  result := (tRotationLine(p2).rs.h_total - tRotationLine(p1).rs.h_total);
end;

function sortrotationlineslistbuff(p1, p2: pointer): integer;
begin
  result := (tRotationLine(p2).rs.b_count - tRotationLine(p1).rs.b_count);
end;

constructor twatchedSpell.initdata(uiaff, uidest: tunitinfo; id: integer);
begin
  self.id := id;
  self.uiaff := uiaff;
  self.uidest := uidest;
  inc(self.count);
end;

constructor twatchedEvent.initdata(u, uaff, udest: tunitdata; id, noderef: integer);
begin
  self.u := u;
  self.l := tlist.create;
  self.count := 0;
  self.noderef := noderef;

  addEvent(uaff, udest, id);
end;

procedure twatchedEvent.addEvent(uaff, udest: tunitdata; id: integer);
var
  i: integer;
  ws: twatchedSpell;
  uiaff, uidest: tunitinfo;
begin
  uidest := getunitinfo(udest);
  uiaff := getunitinfo(uaff);
  inc(count);
  for i := 0 to l.count - 1 do
  begin
    ws := l.items[i];
    if (ws.id = id) and (ws.uiaff = uiaff) and (ws.uidest = uidest) then
    begin
      inc(ws.count);
      exit;
    end;
  end;
  // if we are here then we need to create a new item:
  l.Add(twatchedSpell.initdata(uiaff, uidest, id));
end;

destructor twatchedEvent.Destroy;
var
  i: integer;
begin
  for i := 0 to l.count - 1 do
    twatchedSpell(l.items[i]).Free;
  l.Free;
end;

function IsEventInFilter(p: pevent): boolean;
var
  i: integer;
begin
  if p.filter <> MainFilterID then
  begin
    // init
    p.filter := MainFilterID;
    p.internalParams := p.internalParams - [eventInternalIsInFilter];
    // filtre
    if high(currentfilter) < 0 then
      p.internalParams := p.internalParams + [eventInternalIsInFilter]
    else
      for i := 0 to high(currentfilter) do
      begin
        result := (tEventType(eventtypelist.items[ord(p.event)]).filtered[i]) and
          (p.spell.filtered[i] or getSpellFilterEx(p.GetExtraSpellId, i));
        if (currentfilter[i].FilterParamsChecked <> []) or (currentfilter[i].FilterParamsunChecked <> []) then
          result := result and (exclusiveParams(p.params, currentfilter[i].FilterParamsChecked, currentfilter[i].FilterParamsunChecked));
        if result then
        begin
          p.internalParams := p.internalParams + [eventInternalIsInFilter];
          exit;
        end;
      end;
  end;
  result := eventInternalIsInFilter in p.internalParams;
end;

constructor tSummonTracker.initdata(p: pevent; s: summonParams);
begin
  self.p := p;
  self.starttime := p.time + s.timemin;
  self.fadetime := p.time + s.timemax;
  self.UnitId := s.UnitId;
  self.nbUnit := s.nbUnit;
end;

procedure createSpecialSummon(parsedline: stringArray);
var
  i: integer;
begin
  if parsedline[6] <> 'eol' then
    exit;
  setlength(summonsParams, length(summonsParams) + 1);
  i := high(summonsParams);
  summonsParams[i].spellId := (strtointdef(parsedline[0], 0));
  summonsParams[i].UnitId := (strtointdef(parsedline[1], 0));
  summonsParams[i].nbUnit := (strtointdef(parsedline[2], 0));
  summonsParams[i].timemin := (strtointdef(parsedline[3], 0));
  summonsParams[i].timemax := (strtointdef(parsedline[4], 0));
  summonsParams[i].event := eventType(strtointdef(parsedline[5], 0));
end;

procedure BuildSpecialSummon(EventList: tlist);
var
  p: pevent;
  i, j, l: integer;
  trackerlist: tlist;
  af: tSummonTracker;
  doAffiliation: boolean;

  function compareID(ul: tunitdata; aftmp: tSummonTracker): boolean;
  begin
    result := false;
    if (assigned(ul)) and (not assigned(ul.UnitAffiliation)) and (ul.uGUID.mobid = aftmp.UnitId) then
    begin
      dec(aftmp.nbUnit);
      ul.UnitAffiliation := aftmp.p.sourceUnit;
      result := true;
    end;
  end;

begin
  trackerlist := tlist.create;
  for i := 0 to EventList.count - 1 do
  begin
    p := EventList.items[i];
    // looking for spell
    for j := low(summonsParams) to high(summonsParams) do
    begin
      if (p.event = summonsParams[j].event) and (p.spell.Id = summonsParams[j].spellId) and assigned(p.sourceUnit) then
        trackerlist.Add(tSummonTracker.initdata(p, summonsParams[j]));
    end;

    // looking for unit summoned
    for l := 0 to trackerlist.count - 1 do
    begin
      af := trackerlist.items[l];
      doAffiliation := (p.time >= af.starttime) and (p <> af.p);

      if doAffiliation then
      begin
        if compareID(p.sourceUnit, af) then
          break
        else if compareID(p.destUnit, af) then
          break;
      end;
    end;

    // elimination des résidus,
    for l := trackerlist.count - 1 downto 0 do
    begin
      af := trackerlist.items[l];
      if (p.time >= af.fadetime) or (af.nbUnit = 0) then
      begin
        af.Free;
        trackerlist.Delete(l);
      end;
    end;
  end;
  // cleaning afflist
  for i := 0 to trackerlist.count - 1 do
    tSummonTracker(trackerlist.items[i]).Free;
  trackerlist.Free;
end;

procedure FindFeignDeath(EventList,eventdeathlist: tlist);
var
  p, p2: pevent;
  i, j: integer;
  deadunit: tunitdata;
  searchlimit, removeauracount: integer;
  realdeath: boolean;
begin
  for i := 0 to EventList.count - 1 do
  begin
    p := EventList.items[i];
    if p.event = event_UNIT_DIED then
    begin
      p.params := p.params + [eventIsDeath] - [eventIsFalseDeath]; // reset du statut encas de modif sur log wcr
      deadunit := p.destUnit;
      if not assigned(deadunit) or (deadunit.uGUID.unitType <> unitIsPlayer) then
        continue; // securité
      if not ClasseStat[deadunit.Classe].canFD then
        continue;

      searchlimit := p.time - FD_LAG_DELAY_SEARCH;
      removeauracount := 0;
      realdeath := false;

      for j := i downto 0 do
      begin
        p2 := EventList.items[j];
        if p2.time < searchlimit then
          break;
        if p2.destUnit = deadunit then
        begin
          if eventIsOverDamage in p2.params then
          begin
            realdeath := true;
            break;
          end;
          if eventIsAuraRemove in p2.params then
            inc(removeauracount);
          if removeauracount > FD_AURA_REMOVE_SEARCH then
          begin
            realdeath := true;
            break;
          end;
        end;
      end;
      if not realdeath then
        p.params := p.params + [eventIsFalseDeath] - [eventIsDeath];
    end;
  end;
   //deathlist
   for i := 0 to EventList.count - 1 do
  begin
    p := EventList.items[i];
    if p.event = event_UNIT_DIED then
    begin
      deadunit := p.destUnit;
      if not assigned(deadunit) or (deadunit.uGUID.unitType <> unitIsPlayer) then
        continue; // securité
      if eventIsDeath in p.params then eventdeathlist.add(p);
    end;
  end;
end;

Function buildQuickStats(EventList: tlist; qUnit: tunitdata; startid, starttime, endtime: integer): quickStats;
var
  p: pevent;
  i: integer;
begin
  fillchar(result, sizeof(result), 0);
  for i := startid to EventList.count - 1 do
  begin
    p := EventList.items[i];
    if p.time < starttime then
      continue;
    if p.time > endtime then
      break;
    // inc event
    if qUnit = p.destUnit then
    begin
      if eventIsdamage in p.params then
        result.incDamage := result.incDamage + p.eventStat.amountGeneric
      else if eventIsHeal in p.params then
        result.incHeal := result.incHeal + p.eventStat.amountGeneric;
    end;
  end;
end;

constructor tcastTimeLine.initdata(p: pevent; castMax: integer = 3000);
begin
  self.p := p;
  self.endtime := p.time +  castMax;
end;

constructor tfixedabsLine.initdata(p: pevent);
begin
  updatedata(p);
end;

procedure tfixedabsLine.updatedata(p: pevent);
begin
  self.p := p;
  self.startedooC := not(eventInternalIsInCombatBlock in p.internalParams);
  self.endtime := p.time + DEFAULTABSDURATION * 100;
  self.Absorbpool := p.eventStat.Absorbpool;
end;

function compareAbsEventNoDest( al: tfixedabsLine; p: pEvent): boolean;
begin
 result:= (al.p.spell = p.spell) and (al.p.sourceUnit = p.sourceUnit);
end;

function compareAbsEvent( al: tfixedabsLine; p: pEvent): boolean;
begin
 result:= compareAbsEventNoDest(al,p) and (al.p.destUnit = p.destUnit);
end;

function getAbsRowEvent(p:pevent; l:tlist): tfixedabsLine;
var j : integer;
    al: tfixedabsLine;
begin
  for j := 0 to l.count - 1 do
        begin
          al := l.items[j];
          if compareAbsEvent(al, p) then  exit(al);
        end;
  result:= nil;
end;

function findAbsCastSuccess(el: tlist; al: tfixedabsLine; id: integer): boolean;
var
  i, t: integer;
  p: pEvent;
begin
  // before
  t:= al.p.time - 50;
  for i := id downto 0 do
  begin
    p := el.items[i];
    if (p.event = event_SPELL_CAST_SUCCESS)  and compareAbsEventNoDest(al, p) then exit(true);
    if p.time < t then break;
  end;
  // after
  t:= al.p.time + 50;
  for i := id to el.count - 1 do
  begin
    p := el.items[i];
    if (p.event = event_SPELL_CAST_SUCCESS)  and compareAbsEventNoDest(al, p) then exit(true);
    if p.time > t then  break;
  end;
  result := false;
end;

function findAbsEvent(el: tlist; al: tfixedabsLine; id: integer): integer;
var
  i, t: integer;
  p: pEvent;
begin
  result:= 0;
  // before
  t:= al.p.time - 50;
  for i := id downto 0 do
  begin
    p := el.items[i];
    if (p.event = event_SPELL_ABSORBED)  and compareAbsEvent(al, p) then result:= result + p.eventstat.fixedAbsorb;
    if p.time < t then break;
  end;
  // after
  t:= al.p.time + 50;
  for i := id to el.count - 1 do
  begin
    p := el.items[i];
    if (p.event = event_SPELL_ABSORBED)  and compareAbsEvent(al, p) then result:= result + p.eventstat.fixedAbsorb;
    if p.time > t then  break;
  end;
end;

function buildAbsorbCount(el: tlist): integer;
var
  l: tlist;
  i, j: integer;
  p: pEvent;
  al: tfixedabsLine;
 begin
  // computing "fixed" absb
  result := 0;
  l := tlist.create;
  for i := 0 to el.count - 1 do
  begin
    p := el.items[i];
    //cleaning
    exclude(p.internalParams, eventInternalIsDontCountIt);
    //------------------------
    if (eventInternalIsSpellAssigned in p.internalParams) and  (spellIsFixedAbsb in p.spell.sData) then
    begin
      if p.event = event_SPELL_AURA_APPLIED then
      begin
        // clean old lines
        al :=getAbsRowEvent(p,l);
        if assigned(al) then
          al.updateData(p)
        else
          l.Add(tfixedabsLine.initdata(p));

      end
      else if p.event = event_SPELL_AURA_REFRESH then
      begin
        al :=getAbsRowEvent(p,l);
        if assigned(al) then
        begin
          p.statsarray[4]:= findAbsEvent(el,al,i);
          // if we have absorb event around, then this is mostly a refresh due to hit.
          if p.statsarray[4] > 0 then
            if not al.startedooC then include(p.internalParams, eventInternalIsDontCountIt)
          else
            al.endtime := p.time + DEFAULTABSDURATION * 100;

          if (spellIsCastSuccess in p.spell.sData) and findAbsCastSuccess(el,al,i) then
            exclude(p.internalParams, eventInternalIsDontCountIt);

          al.p := p;
          al.startedooC := not(eventInternalIsInCombatBlock in p.internalParams);
        end
        else
          l.Add(tfixedabsLine.initdata(p));
      end

      else if p.event = event_SPELL_AURA_REMOVED then
      begin
        al :=getAbsRowEvent(p,l);
        if assigned(al) then
        begin
          p.statsarray[4]:= findAbsEvent(el,al,i);
          if not al.startedooC then include(p.internalParams, eventInternalIsDontCountIt);
          al.endtime := p.time;
        end;
      end;
      // purge
      if l.count > result then
        result := l.count;

      for j := l.count - 1 downto 0 do
      begin
        al := l.items[j];
        if p.time >= al.endtime then
        begin
          l.Delete(j);
          al.Free;
        end;
      end;
    end;
  end;
  // cleaning
  for i := 0 to l.count - 1 do
    tfixedabsLine(l.items[i]).Free;
  l.Free;
end;



//castTime

function compareCastEvent( al: tcastTimeLine; p: pEvent): boolean;
begin
 result:= (al.p.spell = p.spell) and (al.p.sourceUnit = p.sourceUnit);
end;

function getcastEventUnit(ul: tunitdata; l:tlist): tcastTimeLine;
var j : integer;
    al: tcastTimeLine;
begin
  for j := 0 to l.count - 1 do
        begin
          al := l.items[j];
          if (al.p.sourceUnit = ul) then  exit(al);
        end;
  result:= nil;
end;

function getcastEvent(p:pevent; l:tlist): tcastTimeLine;
var j : integer;
    al: tcastTimeLine;
begin
  for j := 0 to l.count - 1 do
        begin
          al := l.items[j];
          if compareCastEvent(al, p) then  exit(al);
        end;
  result:= nil;
end;

procedure cleancastEventUnit(p:pevent; l:tlist; fixEndTime: boolean = false);
var j : integer;
    al: tcastTimeLine;
begin
  for j := l.count - 1 downto 0 do
      begin
        al := l.items[j];
        if al.p.sourceUnit = p.sourceUnit then
        begin
          if fixEndTime then
          begin
            include(al.p.params,eventCastIsInterrupted);
            al.p.statsarray[0] := p.time;
          end;
          l.Delete(j);
          al.Free;
        end;
      end;
end;

function buildcastTime(el, ecl: tlist): integer;
var
  l: tlist;
  i, j: integer;
  p: pEvent;
  al: tcastTimeLine;
  sp: tspellinfo;
 begin
  ecl.clear;  //eventCastList

  result := 0;
  l := tlist.create;
  for i := 0 to el.count - 1 do
  begin
    p := el.items[i];
    p.params := p.params - [eventCastWillSuccess,eventCastIsInterrupted];
    //------------------------
    if (eventInternalIsSpellAssigned in p.internalParams) and (eventIsInitbyValidUnit in p.params) and (spellusecastStart in p.spell.sData) then
    begin
      if p.event = event_SPELL_CAST_START then
      begin
        ecl.add(p);
        cleancastEventUnit(p,l);
        l.Add(tcastTimeLine.initdata(p));
      end
    else if p.event = event_SPELL_CAST_SUCCESS then
    begin
        al :=getcastEvent(p,l);
        if assigned(al) then
        begin
          if (p.time - al.p.time) >= p.spell.castDurationEval then p.spell.castDurationEval := (p.time - al.p.time) + 10;
          include(al.p.params,eventCastWillSuccess);
          al.p.statsarray[0] := p.time;
          al.endtime := p.time;
        end;
    end;
      // purge
      if l.count > result then
        result := l.count;

      for j := l.count - 1 downto 0 do
      begin
        al := l.items[j];
        if p.time >= al.endtime then
        begin
          l.Delete(j);
          al.Free;
        end;
      end;
    end;
  end;
  // cleaning
  for i := 0 to l.count - 1 do
    tfixedabsLine(l.items[i]).Free;
  l.Free;

  //finalize spellcasttime;
  for i := 0 to spellarray.count-1 do
  begin
    sp:=spellarray[i];
    if (spellusecastStart in sp.sData) then begin
      if sp.constantParams.forcedCastTime>0 then
        sp.castDuration := sp.constantParams.forcedCastTime
      else
        sp.castDuration := sp.castDurationEval;
      sp.castDurationEval:=0;
      if sp.castDuration = 0 then sp.castDuration := MINIMUMCASTTIME;
    end;
  end;
end;

//build spell interrupt  , 2nd pass
function buildcastInterrupt(el: tlist): integer;
var
  l: tlist;
  i, j: integer;
  p: pEvent;
  al: tcastTimeLine;
 begin

  result := 0;
  l := tlist.create;
  for i := 0 to el.count - 1 do
  begin
    p := el.items[i];
    exclude(p.params,eventCastIsInterrupted);
    //------------------------
    if (eventInternalIsSpellAssigned in p.internalParams)  then
    begin
        if (eventIsInitbyValidUnit in p.params) and (spellusecastStart in p.spell.sData) and not (eventCastWillSuccess in p.params) then
          if p.event = event_SPELL_CAST_START then
          begin
            cleancastEventUnit(p,l, true);
            p.statsarray[1] := 0;//reset interruptime
            l.Add(tcastTimeLine.initdata(p, p.spell.castDuration + 100));
          end;
             // else if p.event = event_SPELL_CAST_SUCCESS then cleancastEventUnit(p,l);

        //realInterrupt
        if p.event = event_SPELL_INTERRUPT then
        begin
         al := getcastEventUnit(p.destUnit, l);
         if assigned(al) and (p.eventstat.extraspellId = al.p.spell.id) then
         begin
           al.p.statsarray[1]:=p.time;
           al.endtime := p.time;
           include(al.p.params,eventCastIsInterrupted);
         end;
        end
        else if (p.event = event_SPELL_AURA_APPLIED) and (spellCanInterrupt in p.spell.constantParams.option2) then
        begin
          al := getcastEventUnit(p.destUnit, l);
          if assigned(al) then
          begin
            include( p.params,eventIsInterrupt);
            p.statsarray[2]:=al.p.spell.id; //extraspellID of the interrupted spell
            al.p.statsarray[1]:=p.time;
            al.endtime := p.time;
            include(al.p.params,eventCastIsInterrupted);
          end;
        end
        else if p.event = event_UNIT_DIED then
        begin
          al := getcastEventUnit(p.destUnit, l);
          if assigned(al) then
          begin
            al.p.statsarray[1]:=p.time;
            al.endtime := p.time;
            include(al.p.params,eventCastIsInterrupted);
          end;
        end;

        // purge
        if l.count > result then
          result := l.count;

        for j := l.count - 1 downto 0 do
        begin
          al := l.items[j];
          if p.time >= al.endtime then
          begin
            l.Delete(j);
            al.Free;
          end;
        end;
    end;
  end;


  // cleaning  final
  for i := 0 to l.count - 1 do
    tfixedabsLine(l.items[i]).Free;
  l.Free;
end;




procedure CreateWatchList;
var
  i: integer;
begin
  globalNode[0] := tglobalnode.initdata('Raid', $00C0EAFE, true, true);
  globalNode[1] := tglobalnode.initdata('Npc/Opponents', $00FEEAC0, true, false);
  globalNode[2] := tglobalnode.initdata('Npc/Friendly', $00E0FFCC, true, false);

  for i := 1 to high(eventwatchlist) do
    eventwatchlist[i] := tlist.create;
end;

procedure FreeWatchList;
var
  i: integer;
begin
  clearWatchList;
  for i := 1 to high(eventwatchlist) do
    eventwatchlist[i].Free;
  for i := 0 to high(globalNode) do
    globalNode[i].Free;
end;

procedure clearWatchList;
var
  i, j: integer;
begin
  for i := 0 to high(globalNode) do
    globalNode[i].clear;
  for i := 1 to high(eventwatchlist) do
  begin
    for j := 0 to eventwatchlist[i].count - 1 do
      twatchedEvent(eventwatchlist[i].items[j]).Destroy;
    eventwatchlist[i].clear;
  end;
end;

procedure addWatchedPointer(u, destu: tunitdata; id, watchedType: integer);
var
  uaff: tunitdata;
  noderef: integer;
begin
  if assigned(u.UnitAffiliation) then
  begin
    uaff := u;
    u := u.UnitAffiliation;
  end
  else
    uaff := nil;
  // node affiliation
  if upWasinRaid in u.params then
    noderef := 0
  else if upWasFriend in u.params then
    noderef := 2
  else
    noderef := 1;

  inc(globalNode[noderef].eventwatchCount[watchedType]);

  if assigned(u.stats.watchedPointer[watchedType]) then
    twatchedEvent(u.stats.watchedPointer[watchedType]).addEvent(uaff, destu, id)
  else
  begin
    u.stats.watchedPointer[watchedType] := twatchedEvent.initdata(u, uaff, destu, id, noderef);
    eventwatchlist[watchedType].Add(u.stats.watchedPointer[watchedType]);
  end;
end;

function BuildStatForPeriod(EventList, returnList: tlist; startid, endtime: integer;
  incombatblock, usefilter, usefocus, focusmode, useAbsorb, usehealabsorb, excludeself, mergepet, nofriendheal, incombatonly: boolean;
  focusType: sfocustype): integer;
var
  p: pevent;
  pstat: rEventStat;
  i, k: integer;
  u: tunitinfo;
  tmpSource: tunitdata;
  tmpOH, tmpMaxHP: integer;
  countstat, dostat: boolean;
  tmpactivity: integer;
  StartBlockActivity, EndBlockActivity: integer;
  sOpt: spellOpts;
begin
  for i := 0 to unitList.count - 1 do
    tunitinfo(unitList.items[i]).clearstat;
  dostat := true;
  StartBlockActivity := -1;
  EndBlockActivity := -1;
  result := 0;
  // stats-------------------

  for i := startid to EventList.count - 1 do
  begin
    p := EventList.items[i];
    if p.time > endtime then
      break;
    //get hpool   & ilvl
    if AuthUse52log and (assigned(p.eInfo.u)) then
    begin
      if p.eInfo.u.uGUID.unitType = unitIsplayer then tmpMaxHP := p.eInfo.Data[1] else tmpMaxHp:=  p.eInfo.Data2[1]; //if NPC then use the maxHp data for ressource.
      if (tmpMaxHP<>0) and (p.eInfo.u.uhp < tmpMaxHP) then p.eInfo.u.uhp := tmpMaxHP; //max Hp
      if (p.eInfo.Data2[4]<>0) and (p.eInfo.u.ilvl < p.eInfo.Data2[4]) then p.eInfo.u.iLvl := p.eInfo.Data2[4]; //iLvL
    end;

    // evaluation des events de combats uniquement
    if incombatonly and not(eventInternalIsInCombatBlock in p.internalParams) then
    begin
      if StartBlockActivity >= 0 then
        result := result + EndBlockActivity - StartBlockActivity;
      StartBlockActivity := -1;
      continue;
    end;

    // globaleactivity
    if StartBlockActivity < 0 then
      StartBlockActivity := p.time;
    EndBlockActivity := p.time;

    // filters& focus
    if usefilter then
      dostat := IsEventInFilter(p);
    if usefocus then
    begin
      usefilter := true;
      dostat := dostat and isEventOnFocus(p, focusmode, focusType);
    end;

    // getstatvalue & param for event
    pstat := p.eventStat;
    sOpt := p.spell.constantParams.option2;

    // usedAbsorb
    if useAbsorb and (eventIsInitbyRaidUnit in p.params) then
      pstat.usedAbsorb := pstat.absorb;
    // define auth pour l'affichage
    if eventInternalIsValidForStatAuth in p.internalParams then
    begin
      include(p.destUnit.stats.params, StatIsAuth);
      include(p.sourceUnit.stats.params, StatIsAuth);
    end;

    // classe
    if (eventIsInitbyPlayer in p.params) then
    begin
      if spellIstanking in sOpt then include(p.sourceUnit.stats.params, statIstmptank);
      if p.spell.constantParams.forcedRole > 0 then p.sourceUnit.stats.forcedRole :=  p.spell.constantParams.forcedRole;
      p.sourceUnit.defineHpByClasse(p.spell);
    end;

    // death et params dest
    if assigned(p.destUnit) then
    begin
      if (p.destUnit.stats.dummyhp = DEATH_HP) and (eventInternalIsValidforRez in p.internalParams) then
      begin
        if p.time - p.destUnit.stats.lastdeathTime > LAG_DELAY_TIME then
        begin
          p.destUnit.stats.dummyhp := 0;
          p.destUnit.stats.lastdeathTime := 0;
          p.destUnit.stats.onrezsituation := true;
          if not p.destUnit.stats.fixstartDeficit then
          begin
            p.destUnit.stats.startDeficitPool := 0;
            p.destUnit.stats.dummyhppool := 0;
          end;
        end;
      end;
      if usefilter then
        p.destUnit.stats.params := p.destUnit.stats.params + [statUnitIsOnFilter];
    end;

    // activity et params source
    if assigned(p.sourceUnit) then
    begin
      // watched event
      if doStat then
      begin
        if eventIsAuraBroken in p.params then
          addWatchedPointer(p.sourceUnit, p.destUnit, pstat.extraspellId, 5)
        else
        begin
          if p.event = event_SPELL_STOLEN then
            addWatchedPointer(p.sourceUnit, p.destUnit, pstat.extraspellId, 4)
          else if eventIsInterrupt in p.params then
            addWatchedPointer(p.sourceUnit, p.destUnit, pstat.extraspellId, 3)
          else if eventIsDebuffDispelled in p.params then
            addWatchedPointer(p.sourceUnit, p.destUnit, pstat.extraspellId, 2)
          else if eventIsBuffDispelled in p.params then
            addWatchedPointer(p.sourceUnit, p.destUnit, pstat.extraspellId, 1);
        end;
      end;

      // -----------------------------------
      if usefilter then
        p.sourceUnit.stats.params := p.sourceUnit.stats.params + [statUnitIsOnFilter];

      if dostat and (eventInternalIsValidforActivity in p.internalParams) then
      begin
        if p.sourceUnit.stats.lastactiontime = 0 then
          tmpactivity := 0
        else
        begin
          tmpactivity := p.time - p.sourceUnit.stats.lastactiontime;
          if tmpactivity > ACTIVITY_THRESHOLD then
            tmpactivity := 0;
        end;
        p.sourceUnit.stats.Activity[1] := p.sourceUnit.stats.Activity[1] + tmpactivity;
        p.sourceUnit.stats.lastactiontime := p.time
      end;
    end;

    // damages
    if (eventIsdamage in p.params) then
    begin
      if assigned(p.sourceUnit) then
      begin
        if excludeself then
          countstat := not(eventIsFriendlyVsFriendly in p.params)
        else
          countstat := true; // and (upWasFriend in p.sourceUnit.params)

        // -------isheal detection counter
        if (p.sourceUnit.uGUID.unitType = unitIsPlayer) and not(spellExcludeForRole in sOpt) and (eventIsFriendlyVsOther in p.params) then
          inc(p.sourceUnit.stats.isddealer);
        // ----------------
        if countstat then
        begin
          if usefilter then
          begin
            if dostat then
              p.sourceUnit.stats.valueSeparate[1][1][1] := p.sourceUnit.stats.valueSeparate[1][1][1]
                + pstat.amountGeneric + pstat.usedAbsorb
            else
              p.sourceUnit.stats.valueSeparate[1][1][2] := p.sourceUnit.stats.valueSeparate[1][1][2]
                + pstat.amountGeneric + pstat.usedAbsorb;
          end
          else
            p.sourceUnit.stats.valueSeparate[1][1][1] := p.sourceUnit.stats.valueSeparate[1][1][1] + pstat.amountGeneric + pstat.usedAbsorb;
        end;
      end;
      // --------------damage received------------
      if assigned(p.destUnit) then
      begin
        // defineHP + OH calculation
        if p.destUnit.stats.dummyhp <> DEATH_HP then
          p.destUnit.stats.dummyhp := p.destUnit.stats.dummyhp + pstat.amountGeneric - pstat.amountOverKill;
        // stats------->
        if usefilter then
        begin
          if dostat then
          begin
            p.destUnit.stats.valueSeparate[1][2][1] := p.destUnit.stats.valueSeparate[1][2][1] + pstat.amountGeneric;
            p.destUnit.stats.valueSeparate[1][6][1] := p.destUnit.stats.valueSeparate[1][6][1] + pstat.absorb + pstat.block + pstat.resist;
          end
          else
          begin
            p.destUnit.stats.valueSeparate[1][2][2] := p.destUnit.stats.valueSeparate[1][2][2] + pstat.amountGeneric;
            p.destUnit.stats.valueSeparate[1][6][2] := p.destUnit.stats.valueSeparate[1][6][2] + pstat.absorb + pstat.block + pstat.resist;
          end;
        end
        else
        begin
          p.destUnit.stats.valueSeparate[1][2][1] := p.destUnit.stats.valueSeparate[1][2][1] + pstat.amountGeneric;
          p.destUnit.stats.valueSeparate[1][6][1] := p.destUnit.stats.valueSeparate[1][6][1] + pstat.absorb + pstat.block + pstat.resist;
        end;
        // <--------------
      end;
    end;

    // complete miss
    if assigned(p.destUnit) and (eventIsfullmiss in p.params) then
    begin
      // stats------->
      if usefilter then
      begin
        if dostat then
          p.destUnit.stats.valueSeparate[1][6][1] := p.destUnit.stats.valueSeparate[1][6][1] + pstat.absorb + pstat.block + pstat.resist
        else
          p.destUnit.stats.valueSeparate[1][6][2] := p.destUnit.stats.valueSeparate[1][6][2] + pstat.absorb + pstat.block + pstat.resist;
      end
      else
        p.destUnit.stats.valueSeparate[1][6][1] := p.destUnit.stats.valueSeparate[1][6][1] + pstat.absorb + pstat.block + pstat.resist;
      // <--------------
    end;

    // fixed absorb (6.0.3)
    if eventIsfixedAbsorb in p.params then
    begin
      if assigned(p.sourceUnit) then
      begin
        // stats------->
        if usefilter then
        begin
          if dostat then
          begin
            p.sourceUnit.stats.valueSeparate[1][7][1] := p.sourceUnit.stats.valueSeparate[1][7][1] + pstat.fixedAbsorb;
            if usehealabsorb and not(spellisNoAffAbsorb in sOpt) then
            begin
              p.sourceUnit.stats.valueSeparate[1][3][1] := p.sourceUnit.stats.valueSeparate[1][3][1] + pstat.fixedAbsorb;
              p.sourceUnit.stats.valueSeparate[1][4][1] := p.sourceUnit.stats.valueSeparate[1][4][1] + pstat.fixedAbsorb + pstat.absorbpool;
              // +pstat.estimatedAbsorb;
            end;
          end
          else
          begin
            p.sourceUnit.stats.valueSeparate[1][7][2] := p.sourceUnit.stats.valueSeparate[1][7][2] + pstat.fixedAbsorb;
            if usehealabsorb and not(spellisNoAffAbsorb in sOpt) then
            begin
              p.sourceUnit.stats.valueSeparate[1][3][2] := p.sourceUnit.stats.valueSeparate[1][3][2] + pstat.fixedAbsorb;
              p.sourceUnit.stats.valueSeparate[1][4][2] := p.sourceUnit.stats.valueSeparate[1][4][2] + pstat.fixedAbsorb + pstat.absorbpool;
              // +pstat.estimatedAbsorb;
            end;
          end;
        end
        else
        begin
          p.sourceUnit.stats.valueSeparate[1][7][1] := p.sourceUnit.stats.valueSeparate[1][7][1] + pstat.fixedAbsorb;
          if usehealabsorb and not(spellisNoAffAbsorb in sOpt) then
          begin
            p.sourceUnit.stats.valueSeparate[1][3][1] := p.sourceUnit.stats.valueSeparate[1][3][1] + pstat.fixedAbsorb;
            p.sourceUnit.stats.valueSeparate[1][4][1] := p.sourceUnit.stats.valueSeparate[1][4][1] + pstat.fixedAbsorb + pstat.absorbpool;
            // +pstat.estimatedAbsorb;
          end;
        end;
      end;
      // -----dest
      if usehealabsorb and assigned(p.destUnit) and not(spellisNoAffAbsorb in sOpt) then
      begin
        // stats------->
        if usefilter then
        begin
          if dostat then
            p.destUnit.stats.valueSeparate[1][5][1] := p.destUnit.stats.valueSeparate[1][5][1] + pstat.fixedAbsorb + pstat.absorbpool
          else
            p.destUnit.stats.valueSeparate[1][5][2] := p.destUnit.stats.valueSeparate[1][5][2] + pstat.fixedAbsorb + pstat.absorbpool;
        end
        else
          p.destUnit.stats.valueSeparate[1][5][1] := p.destUnit.stats.valueSeparate[1][5][1] + pstat.fixedAbsorb + pstat.absorbpool;
      end;
    end;

    // healing
    if eventIsHeal in p.params then
    begin
      tmpOH := pstat.amountOverHeal;
      if assigned(p.destUnit) then
      begin
        // define HP and overhealing calculation:
        if p.destUnit.stats.dummyhp <> DEATH_HP then
        begin
          if pstat.amountOverHeal > 0 then
          begin
            p.destUnit.stats.dummyhp := 0;
            p.destUnit.stats.fixstartDeficit := true;
            p.destUnit.stats.onrezsituation := false;
          end
          else
          begin
            if not p.destUnit.stats.onrezsituation then
              p.destUnit.stats.dummyhp := p.destUnit.stats.dummyhp - pstat.amountHeal;
            if (p.destUnit.stats.dummyhp < 0) and (p.destUnit.stats.fixstartDeficit) then
              p.destUnit.stats.dummyhp := 0;
          end;
        end;

        // stats------->
        if usefilter then
        begin
          if dostat then
            p.destUnit.stats.valueSeparate[1][5][1] := p.destUnit.stats.valueSeparate[1][5][1] + pstat.amountGeneric + pstat.usedAbsorb
          else
            p.destUnit.stats.valueSeparate[1][5][2] := p.destUnit.stats.valueSeparate[1][5][2] + pstat.amountGeneric + pstat.usedAbsorb;
        end
        else
          p.destUnit.stats.valueSeparate[1][5][1] := p.destUnit.stats.valueSeparate[1][5][1] + pstat.amountGeneric + pstat.usedAbsorb;

        // <--------
      end;
      // en emission on ne prend pas en compte les soins non amicaux
      if (eventSourceIsFriend in p.params) and nofriendheal then
        countstat := not(eventIsFriendlyVsOther in p.params)
      else
        countstat := true;
      if assigned(p.sourceUnit) then
      begin
        // -------isheal detection counter
        if (p.sourceUnit.uGUID.unitType = unitIsPlayer) and not(spellExcludeForRole in sOpt) and not(eventisSelf in p.params) and not
          (eventIsFriendlyVsOther in p.params) and assigned(p.destUnit) and not(p.destUnit.UnitAffiliation = p.sourceUnit) then
          inc(p.sourceUnit.stats.ishealer);
        // ----------------
        if countstat then
        begin
          tmpSource := p.sourceUnit;
          if usefilter then
          begin
            if dostat then
            begin
              tmpSource.stats.valueSeparate[1][3][1] := tmpSource.stats.valueSeparate[1][3][1] + pstat.amountHeal - tmpOH + pstat.usedAbsorb;
              tmpSource.stats.valueSeparate[1][4][1] := tmpSource.stats.valueSeparate[1][4][1] + pstat.amountHeal + pstat.usedAbsorb;
            end
            else
            begin
              tmpSource.stats.valueSeparate[1][3][2] := tmpSource.stats.valueSeparate[1][3][2]+ pstat.amountHeal - tmpOH + pstat.usedAbsorb;
              tmpSource.stats.valueSeparate[1][4][2] := tmpSource.stats.valueSeparate[1][4][2] + pstat.amountHeal + pstat.usedAbsorb;
            end
          end
          else
          begin
            tmpSource.stats.valueSeparate[1][3][1] := tmpSource.stats.valueSeparate[1][3][1] + pstat.amountHeal - tmpOH + pstat.usedAbsorb;
            tmpSource.stats.valueSeparate[1][4][1] := tmpSource.stats.valueSeparate[1][4][1] + pstat.amountHeal + pstat.usedAbsorb;
          end;
        end;
      end;
      // <---------------
    end;

    // ---for HPdata
    if not AuthUse52Log then
      if assigned(p.destUnit) then
      begin
        // defining maxHppool
        if (p.destUnit.stats.dummyhp <> DEATH_HP) then
        begin
          if (p.destUnit.stats.dummyhppool < p.destUnit.stats.dummyhp) then
            p.destUnit.stats.dummyhppool := p.destUnit.stats.dummyhp;

          if not p.destUnit.stats.fixstartDeficit and (p.destUnit.stats.dummyhp < 0) then
          begin
            if (p.destUnit.stats.dummyhppool < -p.destUnit.stats.dummyhp) then
              p.destUnit.stats.dummyhppool := -p.destUnit.stats.dummyhp;

            if (p.destUnit.stats.startDeficitPool < p.destUnit.stats.dummyhppool) then
              p.destUnit.stats.startDeficitPool := p.destUnit.stats.dummyhppool;
          end;
        end;

        if (eventIsDeath in p.params) then // or (eventIsOverDamage in p.params))
        begin
          p.destUnit.stats.dummyhp := DEATH_HP;
          p.destUnit.stats.lastdeathTime := p.time;
        end;
      end;
  end;

  // ---timeperiod
  if StartBlockActivity >= 0 then
    result := result + EndBlockActivity - StartBlockActivity;

  // Finalpass pets & players
  for i := 0 to unitList.count - 1 do
    finalysestats(incombatblock, mergepet, result, EndBlockActivity, returnList, unitList.items[i]);
end;

procedure finalysestats(incombatblock, mergepet: boolean; timeperiod, endCombattime: integer; returnList: tlist; u: tunitinfo);
var
  j, k: integer;
  ul: tunitdata;
  tmpvalue, tmphpvalue: integer;
  doauth, rolefound: boolean;
begin
  // calibrate fixedHp
  tmphpvalue := 0;
  // boss and affiliated unit are always shown in list
  doauth := (uoIsBoss in u.constantParams.option1) or (uoIsBossAffiliated in u.constantParams.option1);

  // <-----------
  for j := 0 to u.list.count - 1 do
  begin
    ul := u.list.items[j];
    // let also validate all affiliations to a raid unit:
    if assigned(ul.UnitAffiliation) and (upWasinRaid in tunitdata(ul.UnitAffiliation).params) then
      doauth := true;
    if doauth then
      include(ul.stats.params, StatIsAuth);
  end;

  // finalise
  for j := 0 to u.list.count - 1 do
  begin
    ul := u.list.items[j];

    // role:
    if (ul.uGUID.unitType = unitIsPlayer) and (StatIsAuth in ul.stats.params) then
    begin

       roleFound := false;
      //forced
      case ul.stats.forcedrole of
      1:
       begin
          ul.stats.iconrole := 1 ;
          include(ul.stats.params, statIsTank);
          roleFound := true;
       end;
       2:
       begin
          ul.stats.iconrole := 2;
          include(ul.stats.params, statIsHealer);
          roleFound := true;
       end;
      3:
       begin
          ul.stats.iconrole := 3;
          include(ul.stats.params, statIsddealer);
          roleFound := true;
       end;
      end;

      if not roleFound then
      begin
        if (statIstmptank in ul.stats.params) then
        begin
          ul.stats.iconrole := 1 ;
          include(ul.stats.params, statIsTank)
        end
        else
        begin
          if ClasseStat[ul.Classe].canHeal and  (ul.stats.ishealer > ul.stats.isddealer) then
          begin
            ul.stats.iconrole := 2;
            include(ul.stats.params, statIsHealer)
          end
          else
          begin
            ul.stats.iconrole := 3;
            include(ul.stats.params, statIsddealer)
          end;
        end;
      end;
    end;


    // normalise Hp
    if not AuthUse52Log then
    begin
      if statIstank in ul.stats.params then
        ul.define_Hp(tmphpvalue, ClasseStat[ul.Classe].hpMax)
      else
        ul.define_Hp(tmphpvalue, 0);
    end;

    // raid --
    if upWasPlayerInRaid in ul.params then
      ul.stats.globalnoderef := 0
    else if assigned(ul.UnitAffiliation) then
      if upWasPlayerInRaid in tunitdata(ul.UnitAffiliation).params then
        ul.stats.globalnoderef := 0;

    // npc
    if ul.stats.globalnoderef > 0 then
    begin
      if (upWasFriend in ul.params) then
        ul.stats.globalnoderef := 2;
      if assigned(ul.UnitAffiliation) then
        if upWasFriend in tunitdata(ul.UnitAffiliation).params then
          ul.stats.globalnoderef := 2;
    end;

    // activity
    ul.stats.timeperiod := timeperiod;
    tmpvalue := endCombattime - ul.stats.lastactiontime;
    if tmpvalue > ACTIVITY_THRESHOLD then
      tmpvalue := 0;
    ul.stats.Activity[1] := ul.stats.Activity[1] + tmpvalue;
    if ul.stats.Activity[1] < ACTIVITY_THRESHOLD then
    begin
      if ul.stats.lastactiontime > 0 then
        ul.stats.Activity[1] := ACTIVITY_THRESHOLD
      else
        ul.stats.Activity[1] := 0;
    end;
    if ul.stats.Activity[1] > timeperiod then
      ul.stats.Activity[1] := timeperiod;

    // export unit in statlist
    if StatIsAuth in ul.stats.params then
      for k := 1 to NB_GLOBAL_STAT do
      begin
        if ul.stats.valueSeparate[1][k][1] + ul.stats.valueSeparate[1][k][2] > 0 then
        begin
          if not(statinstat in ul.stats.params) then
          begin
            returnList.Add(ul);
            include(ul.stats.params, statinstat);
            // check for unitaff toujours ajoutée:
            if assigned(ul.UnitAffiliation) and not(statinstat in tunitdata(ul.UnitAffiliation).stats.params) then
            begin
              returnList.Add(ul.UnitAffiliation);
              include(tunitdata(ul.UnitAffiliation).stats.params, statinstat);
            end;
          end;
          break;
        end;
      end;
  end;
end;

procedure computeStats(ul, uldest: tunitdata; mainUnit, doAff: boolean);
var
  i, j: integer;
begin
  // computing ul->ul
  for i := 1 to NB_GLOBAL_STAT do
    for j := 1 to 2 do
    begin
      if not mainUnit then
        if not(doAff and STAT_AUTH_AFF[i]) then
          continue;
      uldest.stats.valueSeparate[2][i][j] := uldest.stats.valueSeparate[2][i][j] + ul.stats.valueSeparate[1][i][j]
    end;

  if uldest.stats.Activity[2] < ul.stats.Activity[1] then
    uldest.stats.Activity[2] := ul.stats.Activity[1];
end;

end.
