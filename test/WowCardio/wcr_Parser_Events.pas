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
unit wcr_Parser_Events;

interface

{$I _config.inc}

uses
  Classes,  SysUtils, math, wcr_Const, wcr_utils, wcr_Hash;

type
  TNodeGenericData = class
    public
      p:pointer;
      constructor create(ptmp:pointer);
  end;

  rTreeGenericData = record
      BasicND: TNodeGenericData;
  end;
  ptreeGenericdata=^rtreeGenericData;


  rBossInfoLog = record
    id: integer;
    name: string;
  end;
  pBossInfoLog = ^rBossInfoLog;

  sfocusType = (
    focusIsBoth,
    focusIsSource,
    focusIsDest
  );

  sgetnameopt =(
    getaff,
    gettag,
    getHp,
    getOccurence,
    getNoserver,
    getShowVehicleTag
  );
  sgetnameopts = set of sgetnameopt;


  guidType =(
    unitIsNil,
    unitIsPlayer,
    unitIsPet,
    unitIsNPC,
    unitIsObject
  );

  unitOpt =(
    uoisBan,
    uoIsBoss,
    uoIsBossAffiliated,
    uoDontMakePlayerAffiliation,
    uodummy4,
    uoForceNotFriendly,
    uoCheckForDeath,
    uoCheckForSpecialEvent,
    uoIsSecure,
    uoHeuristicCheck,
    uoCheckForEndEncounterEvent,
    uoReplayEmphasis,
    uodummy5,
    uodummy6,
    uodummy7,
    uodummy8
  );
  unitOpts= set of unitOpt;

  unitParam = (
    upWasInRaid,
    upWasPlayerInRaid,
    upWasFriend,
    upIsValidNPC,
    upWasNpcVsRaid,
    upDontAffiliate,
    upUnitRef, //focus
    upStatNodeOpen,
    upDummyParam7,
    upWatchNodeOpen,
    upIsVehicle,
    upDummyParam5,
    upDummyParam4,
    upDummyParam3,
    upDummyParam2,
    upDummyParam1
  );
  unitParams = set of unitParam;

  statParam = (
    statUnitHasAffiliation,
    statUnitIsOnFilter,
    StatIsAuth,
    statIstmptank,
    StatIsTank,
    statIsHealer,
    statIsDDealer,
    statInStat
  );
  statParams = set of statParam;

  guidObjectType =(
    ObjectIsPlayer,
    ObjectIsNPC,
    ObjectIsPet,
    ObjectIsGuardian,
    ObjectIsObject,
    ObjectIsNil
  );

  eventParam=(
    eventIsSelf,
    eventIsBothSide,
    eventIsFriendlyVsOther,
    eventIsFriendlyVsFriendly,
    eventIsInitbyValidUnit,
    eventIsReceivedbyValidUnit,
    eventIsInitbyPlayer,
    eventIsReceivedbyPlayer,
    eventIsInitbyRaidUnit,
    eventIsReceivedbyRaidUnit,

    eventIsCombat,

    eventIsDamage,
    eventIsOverDamage,
    eventIsSchool_Physical,
    eventIsSchool_Holy,
    eventIsSchool_Fire,
    eventIsSchool_Nature,
    eventIsSchool_Frost,
    eventIsSchool_Shadow,
    eventIsSchool_Arcane,

    eventIsFullMiss,
    eventIsMitigatigatedAbsorb,
    eventIsMitigatigatedBlock,
    eventIsMitigatigatedDeflect,
    eventIsMitigatigatedDodge,
    eventIsMitigatigatedEvade,
    eventIsMitigatigatedImmune,
    eventIsMitigatigatedMiss,
    eventIsMitigatigatedParry,
    eventIsMitigatigatedReflect,
    eventIsMitigatigatedResist,

    eventIsAutoAttack,
    eventIsCrit,
    eventIsCrush,
    eventIsGlance,

    eventIsHeal,
    eventIsOverHeal,
    eventIsEnergize,
    eventIsPeriodic,
    eventIsAura,
    eventIsAuraApply,
    eventIsAuraRefresh,
    eventIsAuraRemove,
    eventIsAuraBroken,
    eventIsBuff,
    eventIsDebuff,
    eventIsInvocation,
    eventIsInterrupt,
    eventIsBuffDispelled,
    eventIsDebuffDispelled,
    eventIsDeath,
    eventIsFixedAbsorb,//absorb, //-------- obsolete, keeped for backward comp.
    eventIsObsolete2, //-------- obsolete, keeped for backward comp.
    eventIsObsolete3, //-------- obsolete, keeped for backward comp.
    eventSourceIsFriend,
    eventDestIsFriend,
    eventIsFriendlyGoal,
    eventIsFalseDeath,
    eventCastWillSuccess,
    eventCastIsInterrupted,//dev for ast absorb  obsolete, keeped for backward comp.
    eventIsObsolete6,//dev for ast absorb obsolete, keeped for backward comp.
    eventIsCriticalBlock,
    eventIsMultiStrike,
    eventdummyParam1
  );

  eventParams = set of eventParam;

  filterDataRef = record
    id:integer;
  end;
  filterArraySpell = array of filterDataRef;
  filterArrayEvent = array of Integer;

  tfilterdata = class
    name:string;
    default:boolean;
    //tags
    FilterParamsChecked:eventParams;
    FilterParamsunChecked:eventParams;
    //spell
    spellChecked:filterArraySpell;
    spellUnChecked:filterArraySpell;
    //event
    eventChecked:filterArrayEvent;
    eventUnChecked:filterArrayEvent;
    node:pointer;//pointeur vers pvirtualnode
    constructor initData(default:boolean;n:string);
    function extracttext(interact:boolean =false):string;
    function extractsavetext:string;
    function isValid:boolean;
    function isSpellValid:boolean;
    procedure assignData(s:string;param:integer);
    procedure assignId(value,param:integer);
    procedure clear;
  end;

  var
  defaultFilter:tfilterdata;
  currentfilter: array of tfilterdata;

  type
  tcombatBlock = class
    timestart,timestop:integer;
    eventstart,eventstop:integer;
    color:cardinal;
    UnitBlock:tlist;
    containBoss:integer;//id du boss
    bossopts:sbossopts;
    bossdown:boolean;
    txtBOSSID:string;
    pnode:pointer;
    legende,legende2,legendeTime, legendeduration:string;
    constructor initdata(starttime,startEvent:integer;node:pointer);
    destructor Destroy;override;
  end;

  eventInternalParam = (
    eventInternalIsInFilter,
    eventInternalIsDontCountIt,  //if tagged, doesnt count as a new buff cast
    eventInternalIsValidforActivity,
    eventInternalIsValidForStatAuth,
    eventInternalIsValidforRez,
    eventInternalIsInCombatBlock,
    eventInternalIsAbsPool,
    eventInternalIsSpellAssigned,
    eventInternalIsEncounterInfoEvent,// tagged if event = encounte start
    eventInternaldummy2,
    eventInternaldummy3,
    eventInternaldummy4,
    eventInternaldummy5,
    eventInternaldummy6,
    eventInternaldummy7,
    eventInternaldummy8
  );
  eventInternalParams  = set of eventInternalParam;


  spelldata =(
    spellIsDamage,
    spellIsHeal,
    spellIsBuff,
    spellIsDebuff,
    spellIsPeriodic,
    spellCanCrit,
    spellCanMiss,
    spellCanBeMissed,
    spellCanHaveNoSource,
    spellIsFixedAbsb,
    spellisCastSuccess,
    spellisNotOnlyCastSuccess,
    spelluseCastStart,
    spellDummyParam3,
    spellDummyParam2,
    spellDummyParam1
  );
  spelldatas = set of spelldata;

  rEventParamsData = record
     name:string;
     auth:boolean;
  end;

  const
  EventParamsData: array[0..63] of rEventParamsData =(
      (name: 'eventIsSelf'; auth: true),
      (name: 'eventAsBothSide'; auth: true),
      (name: 'eventIsFriendlyVsOther'; auth: true),
      (name: 'eventIsFriendlyVsFriendly'; auth: true),
      (name: 'eventIsInitbyValidUnit'; auth: false),
      (name: 'eventIsReceivedbyValidUnit'; auth: false),
      (name: 'eventIsInitbyPlayer'; auth: true),
      (name: 'eventIsReceivedbyPlayer'; auth: true),
      (name: 'eventIsInitbyRaidUnit'; auth: true),
      (name: 'eventIsReceivedbyRaidUnit'; auth: true),

      (name: 'eventIsCombat'; auth: true),

      (name: 'eventIsDamage'; auth: true),
      (name: 'eventIsOverDamage (deathblow)'; auth: true),
      (name: 'eventIsSchool:Physical'; auth: true),
      (name: 'eventIsSchool:Holy'; auth: true),
      (name: 'eventIsSchool:Fire'; auth: true),
      (name: 'eventIsSchool:Nature'; auth: true),
      (name: 'eventIsSchool:Frost'; auth: true),
      (name: 'eventIsSchool:Shadow'; auth: true),
      (name: 'eventIsSchool:Arcane'; auth: true),

      (name: 'eventIsFullMiss'; auth: true),
      (name: 'eventIsAbsorb'; auth: true),
      (name: 'eventIsBlock'; auth: true),
      (name: 'eventIsDeflect'; auth: true),
      (name: 'eventIsDodge'; auth: true),
      (name: 'eventIsEvade'; auth: true),
      (name: 'eventIsImmune'; auth: true),
      (name: 'eventIsMiss'; auth: true),
      (name: 'eventIsParry'; auth: true),
      (name: 'eventIsReflect'; auth: true),
      (name: 'eventIsResist'; auth: true),

      (name: 'eventIsAutoAttack (swing)'; auth: true),
      (name: 'eventIsSpecial:Crit'; auth: true),
      (name: 'eventIsSpecial:Crush'; auth: true),
      (name: 'eventIsSpecial:Glance'; auth: true),

      (name: 'eventIsHeal'; auth: true),
      (name: 'eventIsOverHeal'; auth: true),
      (name: 'eventIsEnergize'; auth: true),
      (name: 'eventIsPeriodic'; auth: true),
      (name: 'eventIsAura'; auth: true),
      (name: 'eventIsAuraApply'; auth: false),
      (name: 'eventIsAuraRefresh'; auth: false),
      (name: 'eventIsAuraRemove'; auth: false),
      (name: 'eventIsAuraBroken (ccbreak)'; auth: true),
      (name: 'eventIsBuff'; auth: true),
      (name: 'eventIsDebuff'; auth: true),
      (name: 'eventIsInvocation'; auth: true),
      (name: 'eventIsInterrupt'; auth: true),
      (name: 'eventIsBuffDispelled'; auth: true),
      (name: 'eventIsDebuffDispelled'; auth: true),
      (name: 'eventIsDeath'; auth: true),
      (name: 'eventIsFixedAbsorb'; auth: false), //-------- obsolete, keeped for backward comp.
      (name: 'eventObsolete2'; auth: false),  //-------- obsolete, keeped for backward comp.
      (name: 'eventObsolete3'; auth: false), //-------- obsolete, keeped for backward comp.
      (name: 'eventSourceIsFriend'; auth: false),
      (name: 'eventDestIsFriend'; auth: false),
      (name: 'eventIsFriendlyGoal'; auth: false),
      (name: 'eventIsFalseDeath'; auth: true),

      {$IFDEF DEBUG}
      (name: 'eventCastWillSuccess(Dev)'; auth: true),
      (name: 'eventCastIsInterrupted(Dev)'; auth: true),
      (name: 'eventObsolete4'; auth: false),
      {$ELSE}
      (name: 'eventCastWillSuccess(Dev)'; auth: false),
      (name: 'eventCastIsInterrupted(Dev)'; auth: false),
      (name: 'eventObsolete4'; auth: false),
      {$ENDIF}

      (name: 'eventIsCriticalBlock'; auth: true),
      (name: 'eventIsMultiStrike'; auth: true),
      (name: 'eventdummy1'; auth: false)
    );

  type

  rParsedString = array[1..40] of String;

  eventType = (
    event_SPELL_DAMAGE,
    event_SWING_DAMAGE,
    event_SWING_MISSED,
    event_SPELL_CAST_SUCCESS,
    event_SPELL_HEAL,
    event_SPELL_MISSED,
    event_SPELL_PERIODIC_HEAL,
    event_SPELL_AURA_APPLIED,
    event_SPELL_AURA_REFRESH,
    event_SPELL_AURA_REMOVED,
    event_RANGE_DAMAGE,
    event_SPELL_PERIODIC_DAMAGE,
    event_SPELL_PERIODIC_ENERGIZE,
    event_SPELL_ENERGIZE,
    event_RANGE_MISSED,
    event_SPELL_PERIODIC_MISSED,
    event_SPELL_DISPEL,
    event_SPELL_AURA_REMOVED_DOSE,
    event_SPELL_AURA_APPLIED_DOSE,
    event_SPELL_AURA_BROKEN,
    event_SPELL_AURA_BROKEN_SPELL,
    event_ENVIRONMENTAL_DAMAGE,
    event_UNIT_DIED,
    event_SPELL_EXTRA_ATTACKS,
    event_SPELL_AURA_DISPELLED,
    event_SPELL_DRAIN,
    event_SPELL_PERIODIC_DRAIN,
    event_SPELL_LEECH,
    event_SPELL_PERIODIC_LEECH,
    event_SPELL_INTERRUPT,
    event_DAMAGE_SHIELD,
    event_DAMAGE_SHIELD_MISSED,
    event_SPELL_DISPEL_FAILED,
    event_SPELL_DURABILITY_DAMAGE,
    event_SPELL_DURABILITY_DAMAGE_ALL,
    event_SPELL_CREATE,
    event_SPELL_SUMMON,
    event_UNIT_DESTROYED,
    event_SPELL_INSTAKILL,
    event_ENCHANT_APPLIED,
    event_ENCHANT_REMOVED,
    event_SPELL_AURA_STOLEN,
    event_DAMAGE_SPLIT,
    event_SPELL_STOLEN,
    event_PARTY_KILL,
    event_SPELL_RESURRECT,
    event_SPELL_BUILDING_DAMAGE,
    event_SPELL_CAST_START,
    event_SPELL_CAST_FAILED,
    event_UNIT_DISSIPATES,
    event_ENCOUNTER_START,
    event_ENCOUNTER_STOP,
    event_SWING_DAMAGE_LANDED,
    event_SPELL_ABSORBED,
    event_SPELL_SKIPPED,
    event_UNKNOWN
  );

  combatTime=record
    first:integer;
    last:integer;
    validator:Longword;
  end;

  unitPresence = record
    first,last:integer;
  end;

  linearray = record
      eventarray:array of int64;
      absratio,gfxratio:integer;
      valid, started, blockstarted:boolean;
      lastDeathtime:integer;
  end;

  tCompareLineArray = class
    Line:linearray;
    color:cardinal;
    name:string;
    constructor initdata(l:linearray;xmax,color:cardinal;s:String);
    destructor Destroy;override;
  end;

  rConstantUnitParams = record
    option1:unitOpts;//params
    DonjonAff:byte;
    option2:byte;//nb unitdead
    param1,ReplayColor:integer; //param1:idunitBossaff,
    timeOut:Integer;
    manaType:Byte;
    dummy1:byte;
    replaySize:word;
    dummy2:integer;
  end;

  rInfoUnitItem = record
    id:integer;
    name:string[50];
    cUnitParam:rConstantUnitParams;
  end;



  spellOpt =(
    spellisAffiliation,
    spellisReverseAffiliation,
    spellisSingleAura,
    spellCanInterrupt,
    spellisNoAffAbsorb,
    spellisAvoidable,
    dummy3,
    spellIstanking,
    spellisHM,
    spellCloseBossEvent,
    spellExcludeForRole,
    spellExcludeForBoss,
    spellIsExcludedForTracking,
    spellIsIncludedForTracking,
    dummy7,
    dummy8
  );
  spellopts = set of spellopt;

  rConstantSpellParams = record
    option2:spellOpts;
    option1:byte;//class
    avoidableEventtype, maxStack:byte;
    forcedCastTime, avoidableColor, dummy13:integer;
    eventID:byte;
    forcedRole:byte;
    dummy1d,dummy1e:byte;
    dummy2,dummy3:integer;
  end;


  rInfoSpellItem = record
    id:integer;
    name:string[40];
    cSpellParams:rConstantSpellParams;
  end;

  combatStats = record
    valueseparate:array [1..2] of array [1..NB_GLOBAL_STAT] of array [1..2] of int64; //filtered damage/healing/effHeal for unit only
    //activity/time
    Activity:array [1..2] of integer;
    Timeperiod:integer;
    //dispel
    watchedPointer: array [1..5] of Pointer; //1 buffDispelCount, 2 debuffDispelCount, 3 InterruptCount, 4 stolenCount: integer;//aurabroken
    //utils
    dummyhp, dummyhppool: int64;
    lastdeathTime,  startDeficitPool:integer;
    lastactiontime:integer;
    ishealer,isddealer:integer;
    params:statParams;
    fixstartDeficit,onrezsituation:boolean;
    gpnode,sumpnode, sumRefUnit:pointer; //sur le treestats
    globalnoderef, iconrole, forcedRole :byte;
    sumchild:integer;
  end;

  type
  unitGUID =record
    MobID:integer;
    GUID:integer;
    listID:integer;
    unitType:guidType;
  end;

  unitClass = record
    currentclasse,savedclasse:byte;
  end;

  tauraLine = class
    spell:pointer;
    offset:integer;
    u:pointer; //tunitdata;
    isDebuff:boolean;
    list:tlist;
    Uptime:double;
    uptimestr:string;
    constructor initData(isdebuff:boolean; spell:pointer; starttime,endtime:integer;u:pointer; ac:cardinal);
    destructor Destroy;override;
    procedure clear;
    procedure newevent(starttime,endtime:integer; ac:cardinal);
    function closeevent(endtime:integer;closeall:boolean):boolean;
    procedure SetUptime(duration:integer);
    function getSpellId:integer;
    function getSpellName:String;
  end;

  rReplayData = record
    wowx,wowy: integer;
    notplaced: integer;
    x,y, hp, hpMax, power, powermax: integer;
    event: array [0..3] of pointer;
    timeCastStart, timeCastEnd, timeCastInterrupted:integer;
    castSpell:pointer;
    isinGfx, castSuccess, forceCircle:boolean;
    isHit: pointer;
    hpFound, locFound, powerFound, defined: boolean;
    color32: cardinal;
    unitsizeAdjust, circlesize: integer
  end;

  treplaydata = class
    r:rReplayData;
    auraList, currentAuraList: tlist;
    constructor initdata;
    destructor Destroy;override;
    procedure cleanData;
  end;

  tUnitData = Class
    private
      uClasse:unitClass;
      function getclasse:byte;
      procedure setclasse(c:byte);
    public
      uGUID:unitGUID;
      internalId,internalIdAff:integer; //necessaire pour la sauvegarde
      idInDrawList:integer;
      ActiveArray: array of unitPresence;
      inCombat:combatTime;
      inBosslist,inbosslistDeath:integer;
      instaline: linearray;
      uHp, mana, iLvl:integer;
      aura:tauraline;
      auracolor:cardinal;
      pNode:pointer;
      UnitAffiliation:pointer;
      unitInfoRef:pointer;
      params:unitParams;
      stats:combatStats;
      replayData: treplaydata;
      willBeSaved:boolean;
      property Classe:byte read getClasse write setClasse;
      constructor initdata(uGuid:unitGuid; uRef:pointer);
      destructor Destroy;override;
      function getCombatForLocalPeriode(t1,t2:integer;v:longword):boolean;
      procedure defineHpByClasse(sp: pointer);
      procedure define_Hp(esthp,hptank:integer);
      function getcurrentPower(feed:integer):integer;
  end;

  combatStatvalue =record
    total, maxGlobal, maxfiltered:int64;
    ref:double;
  end;

  tGlobalNode = class
      name:string;
      WatchNodeOpen, StatNodeOpen: boolean;
      eventwatchCount: array[1..5] of integer;
      watchtype:integer;
      WatchNode, statnode: pointer;
      valueseparate:array[1..NB_GLOBAL_STAT] of array [1..2] of int64;
      globalstats:array[1..NB_GLOBAL_STAT] of combatStatvalue;
      timeperiod:integer;
      filter:boolean;
      color:cardinal;
      constructor initdata(n:string;color:cardinal; defwatch,defstat:boolean);
      procedure clear;
      procedure addstat(ul:tunitdata);
  end;

  ParsedGUID = record
    ID:unitGUID;
    flags:integer;
  end;

  tUnitInfo = class
    constructor initdata(n:string;g,m:integer;cp:rconstantUnitparams;a:boolean; t:guidType; p:unitparams);
    destructor Destroy;override;
    function getNPC(uGUID:unitGUID):tUnitData;
    function assignNPC(uGUID:unitGUID):tUnitData;
    function getUnitDatabyId(id:integer):tUnitData;
    procedure clearStat;
    procedure clearSaveValidation;
    procedure clearDynamicParams;
    function hasConstantParams: boolean;
    public
      assigned:boolean;
      willBeSaved:integer;
      name:string;
      mobId,GUID:integer;
      unittype:guidType;
      params:unitParams;
      constantParams:rConstantUnitParams;
      lineratio:integer;
      list:tlist;
      focusInList:boolean;
      UnitAffiliation:tUnitData; //affiliation generique pour pet
  end;

  tEventType = class
      id:integer;
      count:integer;
      pnode:pointer;
      filtered: array[0..NBMAX_FILTER] of boolean;
    constructor initdata(id,count:integer);
    destructor Destroy;override;
  end;

  tSpellInfo = class(tEventType)
      name:string;
      constantParams:rConstantSpellParams;
      offsetaura:smallint;//auraId for detailled unit
      school:smallint;
      statcount:integer;
      sData:spelldatas;
      willBeSaved:boolean;
      castDuration,castDurationEval,castTimetotal, castCount:integer;
    constructor initdata(id,count:integer;name:string;cp:rConstantSpellParams);
    function hasConstantParams: boolean;
  end;

  eventListOptions = (optText,
                      optEvent,
                      optUnitGUID,
                      optUnitId,
                      optSpellId,
                      optAroundNode,
                      optSourceUnitID,
                      optDestUnitID,
                      optTextPos,
                      optClearTree,
                      optCheckedView,
                      optEventParam,
                      optFullFilter
                      );
  eventOptions = set of eventListOptions;

  rEventStat = record
    amountGeneric,amountOverKill,amountHeal,amountExtra,amountOverHeal,absorbpool, rawAbsorbPool, guessedAbsorb:Integer;
    miss:byte;
    powertype:byte;
    extraspellId:integer;//dispel
    resist,block,absorb:integer;
    usedAbsorb:integer;
    fixedAbsorb:integer;
    castEndTime, castInterruptTime: integer;
    //bossinfo
    bossID, bossDiff, BossPlayers, BossDown: integer;
  end;

  //type pour sauvegarde
  eventsave = record
      time:integer;
      sourceUnit,destUnit:integer;
      spellId:integer;
      params:eventParams;
      event:eventType;
  end;
  //type pour sauvegarde  52-54
  eventInfoSave52 = array[0..5] of integer;
  eventInfoSave54 = array[1..2] of integer;
  eventInfoSave60 = array[1..4] of integer;

  spellSave = record
    name:string[50];
    id,ingameid:integer;
    school:smallint;
    sData:spelldatas;
  end;
  Unitinfosave = record
    name:string[50];
    mobId,GUID:integer;
    unittype:guidType;
    params:unitParams;
  end;
  Unitlistsave = record
    uGUID:unitGUID;
    internalId:integer;
    params:unitParams;
    UnitAffiliationid:integer;
  end;

  rEventDataUnit = record
    u:tUnitData;
    data: array[1..5] of integer;
    data2: array[1..4] of integer; //extended for wow6.0.2
  end;
  rEventDataUnitPos = record
    data: array[1..2] of integer;
  end;

  pEvent=class
    Constructor initdata (s:rParsedString; hash:word;eventtime:Integer;ul:tstringlist; i: integer);
    //-events
    private
      procedure readEventstat_SWING_DAMAGE(var eventstat:rEventStat);
      procedure readEventstat_SWING_MISSED(var eventstat:rEventStat);
      procedure readEventstat_SPELL_DAMAGE(var eventstat:rEventStat);
      procedure readEventstat_SPELL_MISSED(var eventstat:rEventStat);
      procedure readEventstat_SPELL_HEAL(var eventstat:rEventStat);
      procedure readEventstat_ENVIRONMENTAL_DAMAGE(var eventstat:rEventStat);
      Procedure readEventstat_SPELL_AURA_APPLIED_DOSE(var eventstat:rEventStat);
      Procedure readEventstat_SPELL_ENERGIZE(var eventstat:rEventStat);
      Procedure readEventstat_SPELL_DRAIN(var eventstat:rEventStat);
      Procedure readEventstat_AURA_BROKEN(var eventstat:rEventStat);
      Procedure readEventstat_SPELL_AURA_APPLIED(var eventstat:rEventStat);
      Procedure readEventstat_ENCOUNTER_START(var eventstat:rEventStat);
      Procedure readEventstat_ENCOUNTER_STOP(var eventstat:rEventStat);
      Procedure readEventstat_SPELL_ABSORBED(var eventstat:rEventStat);
      Procedure readEventstat_SPELL_CAST_START(var eventstat:rEventStat);
    public
      time:integer;
      sourceUnit,destUnit,extraUnit:tUnitData; //extraUnit introduced in wow 6.0 in spell_absorb event
      spell:tspellinfo;
      statsarray:array [0..5] of integer;
      dummyFlag:integer;//used to send stuff
      params:eventParams;//8bytes
      internalParams:eventInternalParams;//2bytes
      event:eventType;//1bytes
      filter:byte;////1bytes in filter: la valeur doit etre egal au filtre courant (1-255)
      //new 5.2
      eInfo:rEventDataUnit;
      //new 5.4.2
      eInfoPos:rEventDataUnitPos ;
      {$IFDEF DEBUG}
          lastAbsorb:integer;
          fixedabsnotfound:integer;
          eventString:string;
      {$ENDIF}
      function getcolor:cardinal;
      function drawit:byte;
      function Name:string;
      function offset:smallint;
      function eventStat:rEventStat;
      function GetAuraString:string;
      function SpecialHit:byte;
      function GetExtraSpellId:integer;
      Procedure fixCompatibility;
      function inAlertFilter: boolean;
  end;

  eventparseFunc = procedure(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);

  procedure type_SWING_DAMAGE(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SWING_MISSED(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_DAMAGE(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_CAST_SUCCESS(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_MISSED(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_HEAL(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_UNIT_DIED(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_AURA_APPLIED(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_ENERGIZE(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_ENVIRONMENTAL_DAMAGE(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_AURA_APPLIED_DOSE(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_AURA_REMOVED_DOSE(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_EXTRA_ATTACKS(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_DISPEL(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_AURA_BROKEN(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_AURA_BROKEN_SPELL(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_DRAIN(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_INTERRUPT(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_ENCHANT(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_ENCOUNTER_START(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_ENCOUNTER_STOP(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_ABSORBED(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);
  procedure type_SPELL_SKIPPED(p:pevent;e:eventType;s:rParsedString;u:eventParams;tag, tag52, i:integer);



  procedure type_UNKNOWN(p:pevent;e:eventType;s:rParsedString;uL:tstringlist;u:eventParams);
  function GetMissType(p:pevent;s:String):integer;
  function getSchool(p:pevent;s:integer):integer;

  type
  rEventValue= record
      legacySize, start:integer;
      name:string;
      func: eventparseFunc;
      e:eventType;
      u:eventParams;
      color:cardinal;
      drawit,offset:smallint; //0:non, 1:oui 2 pas de loin
      //focusedMode:
      focusLine,focusOffset:byte;
      receivedLine,receivedOffset:byte;
      internalparams: eventInternalparams;
    end;

const

  guidCharType: array[0..4] of string = ( 'Nil',
                                          'Player',
                                          'Pet',
                                          'Npc',
                                          'Object'
                                         );

  CharSpecialHit: array[0..5] of string = ('',
                                          'CRIT',
                                          'GLANCE',
                                          'CRUSH',
                                          'M.S.',
                                          'M.S. CRIT'
                                         );

  CharMissType: array[0..10] of string = ('',
                                          'ABSORB',
                                          'BLOCK',
                                          'DEFLECT',
                                          'DODGE',
                                          'EVADE',
                                          'IMMUNE',
                                          'MISS',
                                          'PARRY',
                                          'REFLECT',
                                          'RESIST'
                                          );

  guidObjectCharType:array[0..5] of string =(
    'Player',
    'NPC',
    'Pet',
    'Guardian',
    'Object',
    'Nil'
  );

  COMBATLOG_OBJECT_AFFILIATION_MINE	= $00000001;
  COMBATLOG_OBJECT_AFFILIATION_PARTY = $00000002;
  COMBATLOG_OBJECT_AFFILIATION_RAID	=	$00000004;
  COMBATLOG_OBJECT_AFFILIATION_OUTSIDER	=	$00000008;
  COMBATLOG_OBJECT_AFFILIATION_MASK	=	$0000000f;

  COMBATLOG_OBJECT_REACTION_FRIENDLY	=	$00000010;
  COMBATLOG_OBJECT_REACTION_NEUTRAL	=	$00000020;
  COMBATLOG_OBJECT_REACTION_HOSTILE	=	$00000040;
  COMBATLOG_OBJECT_REACTION_MASK	=	$000000F0;

  COMBATLOG_OBJECT_CONTROL_PLAYER	=	$00000100;
  COMBATLOG_OBJECT_CONTROL_NPC	=	$00000200;
  COMBATLOG_OBJECT_CONTROL_MASK	=	$00000300;

  COMBATLOG_OBJECT_TYPE_PLAYER	=	$00000400;
  COMBATLOG_OBJECT_TYPE_NPC	=	$00000800;
  COMBATLOG_OBJECT_TYPE_PET	=	$00001000;
  COMBATLOG_OBJECT_TYPE_GUARDIAN	=	$00002000;
  COMBATLOG_OBJECT_TYPE_OBJECT	=	$00004000;
  COMBATLOG_OBJECT_TYPE_MASK	=	$0000FC00;

  COMBATLOG_OBJECT_SPECIAL_MASK = $0FF00000;
  COMBATLOG_OBJECT_RAIDTARGET8 = $08000000;
  COMBATLOG_OBJECT_RAIDTARGET7 = $04000000;
  COMBATLOG_OBJECT_RAIDTARGET6 = $02000000;
  COMBATLOG_OBJECT_RAIDTARGET5 = $01000000;
  COMBATLOG_OBJECT_RAIDTARGET4 = $00800000;
  COMBATLOG_OBJECT_RAIDTARGET3 = $00400000;
  COMBATLOG_OBJECT_RAIDTARGET2 = $00200000;
  COMBATLOG_OBJECT_RAIDTARGET1 = $00100000;

  COMBATLOG42_RAIDTARGET_SPECIAL_MASK =$000000FF;
  COMBATLOG42_OBJECT_RAIDTARGET8 = $00000080;
  COMBATLOG42_OBJECT_RAIDTARGET7 = $00000040;
  COMBATLOG42_OBJECT_RAIDTARGET6 = $00000020;
  COMBATLOG42_OBJECT_RAIDTARGET5 = $00000010;
  COMBATLOG42_OBJECT_RAIDTARGET4 = $00000008;
  COMBATLOG42_OBJECT_RAIDTARGET3 = $00000004;
  COMBATLOG42_OBJECT_RAIDTARGET2 = $00000002;
  COMBATLOG42_OBJECT_RAIDTARGET1 = $00000001;

  //school
  SPELL_SCHOOL_PHYSICAL = $01;
  SPELL_SCHOOL_HOLY = $02;
  SPELL_SCHOOL_FIRE = $04;
  SPELL_SCHOOL_NATURE = $08;
  SPELL_SCHOOL_FROST = $10;
  SPELL_SCHOOL_SHADOW = $20;
  SPELL_SCHOOL_ARCANE = $40;

  event_color_Buff = $00FFBBAA;
  event_color_falseDeath = $00647BD9;

  eventValue: array[0..56] of rEventValue = (
      (legacySize: 27; start:19; name: ' SPELL_DAMAGE';func:type_SPELL_DAMAGE; e:event_SPELL_DAMAGE; u:[eventIsCombat,eventIsDamage];  color: $0000FFFF;  drawit: 1; offset: 2; focusLine: 3;focusOffset: 2;receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsValidforActivity,eventInternalIsValidforRez]),
      (legacySize: 24; start:16; name: ' SWING_DAMAGE' ;func:type_SWING_DAMAGE; e:event_SWING_DAMAGE; u:[eventIsCombat,eventIsDamage,eventIsAutoAttack]; color: $00F0FBFF;  drawit: 1; offset: 3; focusLine: 3;focusOffset: 4;receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsValidforActivity,eventInternalIsValidforRez]),
      (legacySize: 17; start:16; name: ' SWING_MISSED';func:type_SWING_MISSED; e:event_SWING_MISSED; u:[eventIsCombat,eventIsFullMiss,eventIsAutoAttack]; color: $00888888;  drawit: 1; offset: 3; focusLine: 3;focusOffset: 4;receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsValidforActivity]),
      (legacySize: 18; start:19; name: ' SPELL_CAST_SUCCESS';func:type_SPELL_CAST_SUCCESS; e:event_SPELL_CAST_SUCCESS; u:[]; color: $00FFFFFF ;  drawit: 3; offset: -2; focusLine: 5;focusOffset: 2;receivedLine: 1; receivedOffset:4; internalParams: [eventInternalIsValidforActivity]),
      (legacySize: 22; start:19; name: ' SPELL_HEAL';func:type_SPELL_HEAL; e:event_SPELL_HEAL; u:[eventIsHeal]; color: $0029EF87;  drawit: 1; offset: 1; focusLine: 4;focusOffset: 2;receivedLine: 1; receivedOffset:2; internalParams: [eventInternalIsValidforActivity,eventInternalIsValidforRez]),
      (legacySize: 20; start:19; name: ' SPELL_MISSED';func:type_SPELL_MISSED; e:event_SPELL_MISSED; u:[eventIsCombat,eventIsFullMiss]; color: $00888888;  drawit: 1; offset: 2; focusLine: 3;focusOffset: 2;receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsValidforActivity]),
      (legacySize: 22; start:19; name: ' SPELL_PERIODIC_HEAL';func:type_SPELL_HEAL; e:event_SPELL_PERIODIC_HEAL; u:[eventIsHeal,eventIsPeriodic]; color: $000EB45C;  drawit: 1; offset: 1; focusLine: 4;focusOffset: 3;receivedLine: 1; receivedOffset:2; internalParams: [eventInternalIsValidforActivity]),
      (legacySize: 20; start:19; name: ' SPELL_AURA_APPLIED';func:type_SPELL_AURA_APPLIED; e:event_SPELL_AURA_APPLIED; u:[eventIsAura,eventIsAuraApply]; color: $00FF46A3;  drawit: 1; offset: 2; focusLine: 0;focusOffset: 0; receivedLine: 0; receivedOffset:0; internalParams: []),
      (legacySize: 20; start:19; name: ' SPELL_AURA_REFRESH';func:type_SPELL_AURA_APPLIED; e:event_SPELL_AURA_REFRESH; u:[eventIsAura,eventIsAuraRefresh]; color: $00FF46A3;  drawit: 2; offset: 2; focusLine: 0;focusOffset: 0; receivedLine: 0; receivedOffset:0; internalParams: []),
      (legacySize: 20; start:19; name: ' SPELL_AURA_REMOVED';func:type_SPELL_AURA_APPLIED; e:event_SPELL_AURA_REMOVED; u:[eventIsAura,eventIsAuraRemove]; color: $00FFDDDD;  drawit: 2; offset: 2; focusLine: 0;focusOffset: 0; receivedLine: 0; receivedOffset:0; internalParams: []),
      (legacySize: 27; start:19; name: ' RANGE_DAMAGE';func:type_SPELL_DAMAGE; e:event_RANGE_DAMAGE; u:[eventIsCombat,eventIsDamage,eventIsAutoAttack]; color: $00F0FBFF;  drawit: 1; offset: 3; focusLine: 3;focusOffset: 4;receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsValidforActivity,eventInternalIsValidforRez]),
      (legacySize: 27; start:19; name: ' SPELL_PERIODIC_DAMAGE';func:type_SPELL_DAMAGE; e:event_spell_PERIODIC_DAMAGE; u:[eventIsCombat,eventIsDamage,eventIsPeriodic]; color: $00C1FFFF;  drawit: 1; offset: 2; focusLine: 3;focusOffset: 3;receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsValidforActivity]),
      (legacySize: 20; start:19; name: ' SPELL_PERIODIC_ENERGIZE';func:type_SPELL_ENERGIZE; e:event_SPELL_PERIODIC_ENERGIZE; u:[eventIsEnergize,eventIsPeriodic]; color: $00FCE4BA;  drawit: 3; offset: 0; focusLine: 5;focusOffset: 6; receivedLine: 5; receivedOffset:2; internalParams: []),
      (legacySize: 20; start:19; name: ' SPELL_ENERGIZE';func:type_SPELL_ENERGIZE; e:event_SPELL_ENERGIZE; u:[eventIsEnergize]; color: $00FAD185;  drawit: 3; offset: 1; focusLine: 5;focusOffset: 5; receivedLine: 5; receivedOffset:2; internalParams: [eventInternalIsValidforRez]),
      (legacySize: 20; start:19; name: ' RANGE_MISSED';func:type_SPELL_MISSED; e:event_RANGE_MISSED; u:[eventIsCombat,eventIsFullMiss,eventIsAutoAttack]; color: $00888888;  drawit: 1; offset: 3; focusLine: 3;focusOffset: 4;receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsValidforActivity]),
      (legacySize: 20; start:19; name: ' SPELL_PERIODIC_MISSED';func:type_SPELL_MISSED; e:event_SPELL_PERIODIC_MISSED; u:[eventIsCombat,eventIsFullMiss,eventIsPeriodic]; color: $00888888;  drawit: 1; offset: 2; focusLine: 3;focusOffset: 3;receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsValidforActivity]),
      (legacySize: 22; start:19; name: ' SPELL_DISPEL';func:type_SPELL_DISPEL; e:event_SPELL_DISPEL; u:[]; color: $000b8eff;  drawit: 1; offset: 1; focusLine: 4;focusOffset: 1; receivedLine: 1; receivedOffset:5; internalParams: [eventInternalIsValidforActivity]),
      (legacySize: 20; start:19; name: ' SPELL_AURA_REMOVED_DOSE';func:type_SPELL_AURA_REMOVED_DOSE; e:event_SPELL_AURA_REMOVED_DOSE; u:[eventIsAura,eventisAuraRefresh]; color: $00FF46A3;  drawit: 2; offset: 2; focusLine: 0;focusOffset: 0; receivedLine: 0; receivedOffset:0; internalParams: []),
      (legacySize: 20; start:19; name: ' SPELL_AURA_APPLIED_DOSE';func:type_SPELL_AURA_APPLIED_DOSE; e:event_SPELL_AURA_APPLIED_DOSE; u:[eventIsAura,eventIsAuraRefresh]; color: $00FF46A3;  drawit: 1; offset: 2; focusLine: 0;focusOffset: 0; receivedLine: 0; receivedOffset:0; internalParams: []),
      (legacySize: 19; start:19; name: ' SPELL_AURA_BROKEN';func:type_SPELL_AURA_BROKEN; e:event_SPELL_AURA_BROKEN; u:[eventIsAuraBroken]; color: $00BB66CC;  drawit: 1; offset: 1; focusLine: 3;focusOffset: 1; receivedLine: 1; receivedOffset:5; internalParams: []),
      (legacySize: 22; start:19; name: ' SPELL_AURA_BROKEN_SPELL';func:type_SPELL_AURA_BROKEN_SPELL; e:event_SPELL_AURA_BROKEN_SPELL; u:[eventIsAuraBroken]; color: $00BB66CC;  drawit: 1; offset: 1; focusLine: 3;focusOffset: 1; receivedLine: 1; receivedOffset:5; internalParams: []),
      (legacySize: 25; start:16; name: ' ENVIRONMENTAL_DAMAGE';func:type_ENVIRONMENTAL_DAMAGE; e:event_ENVIRONMENTAL_DAMAGE; u:[eventIsDamage]; color: $00C0DCC0;  drawit: 1; offset: 2; focusLine: 3;focusOffset: 5; receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsValidforActivity,eventInternalIsValidforRez]),
      (legacySize: 15; start:16; name: ' UNIT_DIED';func:type_UNIT_DIED; e:event_UNIT_DIED; u:[eventIsDeath]; color: $005555FF;  drawit: 1; offset: 2; focusLine: 1;focusOffset: 0; receivedLine: 1; receivedOffset:1; internalParams: []),
      (legacySize: 19; start:19; name: ' SPELL_EXTRA_ATTACKS';func:type_SPELL_EXTRA_ATTACKS; e:event_SPELL_EXTRA_ATTACKS; u:[]; color: $00C0DCAA;  drawit: 2; offset: 3; focusLine: 5;focusOffset: 1; receivedLine: 5; receivedOffset:4; internalParams: []),
      (legacySize: 22; start:19; name: ' SPELL_AURA_DISPELLED';func:type_SPELL_DISPEL; e:event_SPELL_AURA_DISPELLED; u:[]; color: $00ACACFF;  drawit: 1; offset: 1; focusLine: 4;focusOffset: 1; receivedLine: 1; receivedOffset:5; internalParams: []),
      (legacySize: 21; start:19; name: ' SPELL_DRAIN';func:type_SPELL_DRAIN; e:event_SPELL_DRAIN; u:[]; color: $00BBAA99;  drawit: 1; offset: 2; focusLine: 3;focusOffset: 1; receivedLine: 1; receivedOffset:3; internalParams: [eventInternalIsValidforActivity]),
      (legacySize: 21; start:19; name: ' SPELL_PERIODIC_DRAIN';func:type_SPELL_DRAIN; e:event_SPELL_PERIODIC_DRAIN; u:[eventIsPeriodic]; color: $00BBAA99;  drawit: 1; offset: 2; focusLine: 3;focusOffset: 1; receivedLine: 1; receivedOffset:3; internalParams: []),
      (legacySize: 21; start:19; name: ' SPELL_LEECH';func:type_SPELL_DRAIN; e:event_SPELL_LEECH; u:[]; color: $00BBAA99;  drawit: 1; offset: 2; focusLine: 3;focusOffset: 1; receivedLine: 1; receivedOffset:3; internalParams: [eventInternalIsValidforActivity]),
      (legacySize: 21; start:19; name: ' SPELL_PERIODIC_LEECH';func:type_SPELL_DRAIN; e:event_SPELL_PERIODIC_LEECH; u:[eventIsPeriodic]; color: $00BBAA99;  drawit: 1; offset: 2; focusLine: 3;focusOffset: 1; receivedLine: 1; receivedOffset:3; internalParams: []),
      (legacySize: 21; start:19; name: ' SPELL_INTERRUPT';func:type_SPELL_INTERRUPT; e:event_SPELL_INTERRUPT; u:[eventIsInterrupt]; color: $00FF8877;  drawit: 1; offset: 2; focusLine: 3;focusOffset: 1; receivedLine: 1; receivedOffset:5; internalParams: []),
      (legacySize: 27; start:19; name: ' DAMAGE_SHIELD';func:type_SPELL_DAMAGE; e:event_DAMAGE_SHIELD; u:[eventIsCombat,eventIsDamage]; color:$00A1CCCC;  drawit: 2; offset: 2; focusLine: 3;focusOffset: 5;receivedLine: 1; receivedOffset:1; internalParams: []) ,
      (legacySize: 20; start:19; name: ' DAMAGE_SHIELD_MISSED';func:type_SPELL_MISSED; e:event_DAMAGE_SHIELD_MISSED; u:[eventIsCombat,eventIsFullMiss]; color: $00A1CCCC;  drawit: 2; offset: 2; focusLine: 3;focusOffset: 5;receivedLine: 1; receivedOffset:1; internalParams: []),
      (legacySize: 21; start:19; name: ' SPELL_DISPEL_FAILED';func:type_SPELL_INTERRUPT; e:event_SPELL_DISPEL_FAILED; u:[]; color: $00FF88AA;  drawit: 1; offset: 2; focusLine: 4;focusOffset: 1; receivedLine: 5; receivedOffset:1; internalParams: []),
      (legacySize: 18; start:19; name: ' SPELL_DURABILITY_DAMAGE';func:type_SPELL_CAST_SUCCESS; e:event_SPELL_DURABILITY_DAMAGE; u:[]; color: $00FFFFFF;  drawit: 0; offset: 2; focusLine: 5;focusOffset: 1; receivedLine: 1; receivedOffset:5; internalParams: []),
      (legacySize: 18; start:19; name: ' SPELL_DURABILITY_DAMAGE_ALL';func:type_SPELL_CAST_SUCCESS; e:event_SPELL_DURABILITY_DAMAGE_ALL; u:[]; color: $00FFFFFF;  drawit: 0; offset: 2; focusLine: 5;focusOffset: 1; receivedLine: 1; receivedOffset:5; internalParams: []),
      (legacySize: 18; start:19; name: ' SPELL_CREATE';func:type_SPELL_CAST_SUCCESS; e:event_SPELL_CREATE; u:[eventIsInvocation]; color: $00FFFFFF;  drawit: 2; offset: 2; focusLine: 5;focusOffset: 1; receivedLine: 5; receivedOffset:1; internalParams: [eventInternalIsValidforActivity,eventInternalIsValidforRez]),
      (legacySize: 18; start:19; name: ' SPELL_SUMMON';func:type_SPELL_CAST_SUCCESS; e:event_SPELL_SUMMON; u:[eventIsInvocation]; color: $00FFFFFF;  drawit: 2; offset: 2; focusLine: 5;focusOffset: 1 ; receivedLine: 5; receivedOffset:1; internalParams: [eventInternalIsValidforActivity,eventInternalIsValidforRez]),
      (legacySize: 15; start:16; name: ' UNIT_DESTROYED';func:type_UNIT_DIED; e:event_UNIT_DESTROYED; u:[eventIsDeath]; color: $005555FF;  drawit: 0; offset: 2; focusLine: 5;focusOffset: 1; receivedLine: 0; receivedOffset:0; internalParams: []),
      (legacySize: 18; start:19; name: ' SPELL_INSTAKILL';func:type_SPELL_CAST_SUCCESS; e:event_SPELL_INSTAKILL; u:[]; color: $00647BD9;  drawit: 1; offset: 2; focusLine: 5;focusOffset: 1; receivedLine: 5; receivedOffset:1; internalParams: []),
      (legacySize: 18; start:19; name: ' ENCHANT_APPLIED';func:type_ENCHANT; e:event_ENCHANT_APPLIED; u:[]; color: $00FFFFFF;  drawit: 2; offset: 2; focusLine: 5;focusOffset: 1; receivedLine: 5; receivedOffset:1; internalParams: [eventInternalIsValidforActivity,eventInternalIsValidforRez]),
      (legacySize: 18; start:19; name: ' ENCHANT_REMOVED';func:type_ENCHANT; e:event_ENCHANT_REMOVED; u:[]; color: $00FFFFFF;  drawit: 2; offset: 2; focusLine: 5;focusOffset: 1; receivedLine: 5; receivedOffset:1; internalParams: []),
      (legacySize: 22; start:19; name: ' SPELL_AURA_STOLEN';func:type_SPELL_DISPEL; e:event_SPELL_AURA_STOLEN; u:[]; color: $00ACCCFF;  drawit: 1; offset: 1; focusLine: 5;focusOffset: 1; receivedLine: 1; receivedOffset:5; internalParams: []),
      (legacySize: 27; start:19; name: ' DAMAGE_SPLIT' ;func:type_SPELL_DAMAGE; e:event_DAMAGE_SPLIT; u:[eventIsCombat,eventIsDamage]; color: $00F0FBFF;  drawit: 1; offset: 3; focusLine: 5;focusOffset: 7; receivedLine: 5; receivedOffset:1; internalParams: []),
      (legacySize: 22; start:19; name: ' SPELL_STOLEN';func:type_SPELL_DISPEL; e:event_SPELL_STOLEN; u:[]; color: $00ACCCFF;  drawit: 1; offset: 1; focusLine: 5;focusOffset: 1; receivedLine: 1; receivedOffset:5; internalParams: []),
      (legacySize: 15; start:16; name: ' PARTY_KILL';func:type_UNIT_DIED; e:event_PARTY_KILL; u:[]; color: $005555FF;  drawit: 0; offset: 0; focusLine: 5;focusOffset: 1; receivedLine: 1; receivedOffset:1; internalParams: []),
      (legacySize: 18; start:19; name: ' SPELL_RESURRECT';func:type_SPELL_CAST_SUCCESS; e:event_SPELL_RESURRECT; u:[]; color: $00FFFFFF;  drawit: 2; offset: 1; focusLine: 4;focusOffset: 1; receivedLine: 1; receivedOffset:5; internalParams: [eventInternalIsValidforActivity,eventInternalIsValidforRez]),
      (legacySize: 27; start:19; name: ' SPELL_BUILDING_DAMAGE';func:type_SPELL_DAMAGE; e:event_SPELL_BUILDING_DAMAGE; u:[eventIsCombat,eventIsDamage]; color: $0000FFFF;  drawit: 1; offset: 2; focusLine: 3;focusOffset: 2;receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsValidforActivity]),
      (legacySize: 18; start:19; name: ' SPELL_CAST_START';func:type_SPELL_CAST_SUCCESS; e:event_SPELL_CAST_START; u:[]; color: $00FFCCFF ;  drawit: 3; offset: -2; focusLine: 5;focusOffset: 2;receivedLine: 1; receivedOffset:4; internalParams: [eventInternalIsValidforRez]),
      (legacySize: 18; start:19; name: ' SPELL_CAST_FAILED';func:type_SPELL_CAST_SUCCESS; e:event_SPELL_CAST_FAILED; u:[]; color: $00888888 ;  drawit: 3; offset: 0; focusLine: 5;focusOffset: 3;receivedLine: 5; receivedOffset:5; internalParams: []),
      (legacySize: 15; start:16; name: ' UNIT_DISSIPATES';func:type_UNIT_DIED; e:event_UNIT_DISSIPATES; u:[eventIsDeath]; color: $005555FF;  drawit: 1; offset: 2; focusLine: 1;focusOffset: 0; receivedLine: 1; receivedOffset:1; internalParams: []),
      (legacySize: 7; start:7; name: ' ENCOUNTER_START';func:type_ENCOUNTER_START; e:event_ENCOUNTER_START; u:[]; color: $005555FF;  drawit: 1; offset: 2; focusLine: 1;focusOffset: 0; receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsEncounterInfoEvent]),
      (legacySize: 7; start:7; name: ' ENCOUNTER_END';func:type_ENCOUNTER_STOP; e:event_ENCOUNTER_STOP; u:[]; color: $005555FF;  drawit: 1; offset: 2; focusLine: 1;focusOffset: 0; receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsEncounterInfoEvent]),
      (legacySize: 24; start:16; name: ' SWING_DAMAGE_LANDED' ;func:type_SWING_DAMAGE; e:event_SWING_DAMAGE_LANDED; u:[eventIsCombat,eventIsDamage,eventIsAutoAttack]; color: $00F0FBFF;  drawit: 1; offset: 3; focusLine: 3;focusOffset: 4;receivedLine: 1; receivedOffset:1; internalParams: [eventInternalIsValidforActivity,eventInternalIsValidforRez]),
      (legacySize: 24; start:16; name: ' SPELL_ABSORBED' ;func:type_SPELL_ABSORBED; e:event_SPELL_ABSORBED; u:[eventIsFixedAbsorb]; color: $00f0fff0;  drawit: 1; offset: 1; focusLine: 4;focusOffset: 2;receivedLine: 1; receivedOffset:2; internalParams: []),
      (legacySize: 7; start:7; name: ' CHALLENGE_MODE_START' ;func:type_SPELL_SKIPPED; e:event_SPELL_SKIPPED; u:[]; color: $00f0fff0;  drawit: 1; offset: 1; focusLine: 4;focusOffset: 2;receivedLine: 1; receivedOffset:2; internalParams: []),
      (legacySize: 7; start:7; name: ' CHALLENGE_MODE_END' ;func:type_SPELL_SKIPPED; e:event_SPELL_SKIPPED; u:[]; color: $00f0fff0;  drawit: 1; offset: 1; focusLine: 4;focusOffset: 2;receivedLine: 1; receivedOffset:2; internalParams: []),
      (legacySize: 10; start:19; name: ' UNKNOWN'; e:event_unknown; u:[]; color: $000000FF;  drawit: 1; offset: 2; focusLine: 5;focusOffset: 7; receivedLine: 0; receivedOffset:0; internalParams: [])
);
type
  pChatEvent= class
    Constructor initdata (s:string; eventtime:Integer);
    public
      time:integer;
      s:string;
    end;

  function unit_isFriend(flags:integer):boolean;
  function unit_isInRaid(flags:integer):boolean;
  function unit_ismarked(flags:integer):integer;
  function unit_ismarked42(flags:integer):integer;
  procedure getmarklist(t:integer; u:tunitdata; mark:integer);
  function unit_isPlayerControled(flags:integer):boolean;
  function unit_objectType(flags:integer):guidObjectType;
  function isUnitOnFocus(u:tUnitData):boolean;
  function isEventOnFocus(p:pEvent;Exclusivemode:boolean; focusType:sfocusType):boolean;

  function getGUID(s,f,n:string; assignGuid: boolean= true):ParsedGUID;
  function assignSpellData(id: integer; strtmp: string; ep: eventParams;  s: integer; assignData: boolean):tspellInfo;
  procedure assignUnitInfos(n:string; var uGuid:ParsedGUID; params:unitparams);
  function CheckLegitSpellIdEx(id:integer):boolean;
  function CheckLegitSpellId(sp:tspellinfo): boolean;

  function getUnitParam(u:tUnitData):unitParams;
  function getUnitInfo(u:tUnitData):tUnitInfo;overload;
  function getUnitInfo(uGuid:unitGUID):tUnitInfo;overload;
  function getSecureUnitInfoName(u:tunitinfo):string;
  function getUnitDungeonAff(mobId:integer):integer;
  function getUnitName(mobId:integer; getopts: sgetnameopts; nilresult:string = UNIT_NAME_ERROR ):string; overload;
  function getUnitName(ul:tUnitData; getopts: sgetnameopts;  nilresult:string = UNIT_NAME_ERROR):string; overload;
  function getUnitName(uguid:unitGUID; getopts: sgetnameopts;  nilresult:string = UNIT_NAME_ERROR):string; overload;
  function getMissString(id:integer; strAppend:string; allow:boolean = true):string;
  function getSpecialString(id:integer; strAppend:string; allow:boolean = true):string;

  function getUnitType(u:tUnitData):guidType;
  function getUnitGUID(u:tUnitData):unitGUID;

  function newConstantUnitParam(opt1:unitOpts = []):rconstantUnitParams;
  function GetUnitOption(u:tunitinfo; bypassvalid:boolean =false ):unitOpts;overload;
  function GetUnitOption(u:tUnitData; bypassvalid:boolean =false ):unitOpts;overload;
  function GetUnitOptionMobId(u:tUnitData):integer;
  function emptySpellParam:rconstantSpellParams;

  function getEventName(id:integer):string;
  function getSpellName(id:integer;addtag:boolean = false):string;overload;
  function getSpellName(p:pEvent;addtag:boolean = false):string;overload;
  procedure setSpellFilter(id,index:integer;filter:boolean);
  procedure setEventFilter(id,index:integer;filter:boolean);
  function getSpellFilterEx(id,index:integer):boolean;
  function getSpellFilter(id:integer):boolean;
  function getFilterLabel:string;
  function getSpellDefaultFilter(id:integer):boolean;
  procedure setSpellParams(id:integer;r:rConstantSpellParams);
  function getSpellParams(sp:tspellInfo):rConstantSpellParams;
  function getSpellDatas(sp:tspellInfo):spelldatas;
  function getSpellSchool(id:integer):smallint;
  function SpellSingleAura(sp:tspellinfo): boolean;
  procedure setSpellDatas(sp: tspellInfo; s: spelldatas);
  function incSpellStats(id:integer):boolean;
  function getPowerType(s:integer):integer;
  procedure FinalizeUnitAffiliation;
  function getschooltext(p:pEvent):string; overload;
  function getschooltext(sp:tSpellInfo):string; overload;
  procedure defineFriendlyStatus(wasFriend:boolean;u:tunitdata);
  procedure getEventlist(p:pEvent);
  function returnSumUnit(ul:tunitdata; uff:tunitdata):tunitdata;
  procedure clearbossinfoList;
  function exclusiveParams(ep,checkedparams,uncheckedParams:eventParams):boolean;
  function addNewUnittoList(uGuid:ParsedGuid):tUnitData;
  function getUnitFromList(uGuid:ParsedGuid):tUnitData;

  //filter
  procedure filternewspell(var a:filterArraySpell;newvalue1:integer);
  procedure filternewEvent(var a:filterArrayEvent;newvalue1:integer);

  procedure cleardonjonlist;
  procedure BuildDonjonList(parsedline:stringArray);
  function GetDonjonInfo(id:integer; data:byte):variant;
  function GenerateListHash:integer;

  //FastListSearch
  function FastListSearch(List: TList; Compare: TListSortCompare; p: pointer; var newindex: integer; GetHiLoID: integer = 0): boolean;
  function compareSpellID(p1, p2: pointer): integer;
  function compareEventTime(p1, p2: pointer): integer;
  function addPointertoSortedList(List: TList; Compare: TListSortCompare; p: pointer): boolean;
  function getSpellFromID(id:integer): tspellInfo;


  type

  eventFilter = record
    text:string;
    p:pEvent;
    GUID:integer;
    mobId:integer;
    spellId:integer;
    idevent:integer;
    param:eventparam;
    option:eventOptions;
  end;

  tauraEvent = class
    starttime,endtime:integer;
    open:boolean;
    auracolor:cardinal;
    doseapply:array of integer;
    doseremove:array of integer;
    constructor initData(starttime,endtime:integer; ac:cardinal);
  end;

  rmarkevent =record
    u:tunitdata;
    starttime,endtime:integer;
  end;
  pmarkevent= ^rmarkevent;

  rsavemarkevent =record
    uid:integer;
    starttime,endtime:integer;
  end;

  rdonjonitem = record
    longname,shortname:string;
    id,sortindex:integer;
  end;
  pdonjonitem = ^rdonjonitem;

  var
    authsavespellarray:boolean;
    maxspellarrayid:integer;
    npcArray:array of tUnitInfo;
    unitArray:tlist;
    spellArray:tlist;
    bossinfoList : tlist;
    dummySpellInfo: tspellInfo; //dummy pointer used to find in spellList
    dummypEvent: pEvent;// //dummy pointer used to find in eventlist
    unitList:tlist;
    eventtypelist:tlist;
    unknownEventlist:tstringlist;
    donjonlist:tlist;
    //Stats:
    SpellIdMax:integer;
    NpcIdMax:integer;
    NpcTotalCount:integer;
    globalNode: array[0..2] of tglobalnode;
    markedList:array[1..8] of tlist;

    bDontdisturb, bWhileparsing, bWhilebatching :boolean;
    StartTimeStamp:ttimestamp;
    CurrentTimeStamp:integer;
    hashEventTable: array[0..$ffff] of byte;
    debugE: integer = 0;

implementation


//------------------------

procedure clearbossinfoList;
var
  pB: pBossInfoLog;
  i: integer;
begin
  for i := 0 to bossinfoList.count - 1 do
  begin
    pB := bossinfoList[i];
    dispose(pB);
  end;
  bossinfoList.clear;
end;

procedure addBosstoInfolist(id: integer; name: string);
var
  pB: pBossInfoLog;
  i: integer;
begin
  for i := 0 to bossinfoList.count - 1 do
  begin
    pB := bossinfoList[i];
    if pB.id = id then
      exit;
  end;
  new(pB);
  pB.id := id;
  pB.name := CleanString(name);
  bossinfoList.add(pB);
end;

function GenerateListHash: integer;
var
  i: integer;
  tmphash: word;
begin
  result := 0;
  fillchar(hashEventTable, sizeof(hashEventTable), $FF);
  for i := low(eventValue) to high(eventValue) do // eventValueHash[i]:=EventHash(eventValue[i].name);
  begin
    tmphash := EventHash(eventValue[i].name);
    if (hashEventTable[tmphash] <> $FF) then
      inc(result);
    hashEventTable[tmphash] := byte(i);
  end;
end;

function GetDonjonInfo(id: integer; data: byte): variant;
begin
  result := 0;
  if (id < 0) or (id > donjonlist.count - 1) then
    exit;
  case data of
    1:
      result := pdonjonitem(donjonlist.items[id]).sortindex;
    2:
      result := pdonjonitem(donjonlist.items[id]).longname;
    3:
      result := pdonjonitem(donjonlist.items[id]).shortname;
  end;
end;

procedure BuildDonjonList(parsedline: stringArray);
var
  pdi: pdonjonitem;
begin
  if parsedline[0] = '' then
    exit;
  new(pdi);
  pdi.sortindex := strtointdef(parsedline[0], 255);
  pdi.longname := parsedline[1];
  pdi.shortname := parsedline[2];
  pdi.id := donjonlist.count;
  donjonlist.add(pdi);
end;

procedure cleardonjonlist;
var
  i: integer;
begin
  for i := 0 to donjonlist.count - 1 do
    dispose(pdonjonitem(donjonlist.items[i]));
  donjonlist.clear;
end;

function returnSumUnit(ul: tUnitData; uff: tUnitData): tUnitData;
var
  i, j, k: integer;
  u: tUnitInfo;
begin
  u := ul.unitInfoRef;
  for k := 0 to u.list.count - 1 do
  begin
    if (statInStat in tUnitData(u.list.items[k]).stats.params) and
      (tUnitData(u.list.items[k]).UnitAffiliation = uff) then
    begin
      inc(tUnitData(u.list.items[k]).stats.sumchild);
      result := u.list.items[k];
      for i := 1 to NB_GLOBAL_STAT do
        for j := 1 to 2 do
          result.stats.valueseparate[2][i][j] := result.stats.valueseparate[2]
            [i][j] + ul.stats.valueseparate[1][i][j];
      result.stats.Activity[2] := result.stats.Activity[2] + ul.stats.Activity
        [1];
      exit;
    end;
  end;
  result := ul;
end;

procedure getEventlist(p: pEvent);
var
  pE: tEventType;
begin
  pE := eventtypelist.items[ord(p.event)];
  inc(pE.count);
end;

procedure defineFriendlyStatus(wasFriend: boolean; u: tUnitData);
begin
  if assigned(u) then
    if wasFriend and not(upWasNpcVsRaid in u.params) and not
      (uoForceNotFriendly in GetUnitOption(u)) then
      include(u.params, upWasFriend)
end;

constructor tGlobalNode.initData(n: string; color: cardinal;
  defwatch, defstat: boolean);
begin
  self.name := n;
  self.WatchNodeOpen := defwatch;
  self.StatNodeOpen := defstat;
  self.watchtype := 1;
  self.color := color;
  clear;
end;

procedure tGlobalNode.clear;
begin
  fillchar(self.eventwatchCount, sizeof(self.eventwatchCount), 0);
  fillchar(self.valueseparate, sizeof(self.valueseparate), 0);
  fillchar(self.globalstats, sizeof(self.globalstats), 0);
  self.WatchNode := nil;
  self.statnode := nil;
  self.Timeperiod := 0;
  self.filter := false;
end;

procedure tGlobalNode.addstat(ul: tUnitData);
var
  i, j: integer;
begin
  self.filter := statUnitIsOnFilter in ul.stats.params;
  for i := 1 to NB_GLOBAL_STAT do
    for j := 1 to 2 do
      self.valueseparate[i][j] := self.valueseparate[i][j]
        + ul.stats.valueseparate[1][i][j];
end;

constructor TNodeGenericData.create(ptmp: pointer);
begin
  p := ptmp;
end;

constructor tCompareLineArray.initData(l: linearray; xmax, color: cardinal;
  s: String);
var
  i: integer;
begin
  // adding a marging
  xmax := xmax + 5;
  if xmax > MAX_HP_ARRAY_ROW then
    xmax := MAX_HP_ARRAY_ROW;
  // assigndata
  setLength(self.Line.eventarray, xmax);
  for i := 0 to xmax - 1 do
    self.Line.eventarray[i] := l.eventarray[i];
  self.Line.absratio := l.absratio;
  self.Line.gfxratio := 1;
  self.color := color;
  self.name := s;
end;

destructor tCompareLineArray.Destroy;
begin
  setLength(Line.eventarray, 0);
  inherited;
end;

constructor tfilterdata.initData(default: boolean; n: string);
begin
  if n = '' then
    n := DEFAULTFILTERNAME;
  self.name := n;
  self.default := default;
end;

function tfilterdata.isValid: boolean;
begin
  result := (FilterParamsChecked <> []) or (FilterParamsunChecked <> []) or
    (length(eventChecked) > 0) or (length(eventUnChecked) > 0) or
    (length(spellChecked) > 0) or (length(spellUnChecked) > 0);
end;

function tfilterdata.isSpellValid: boolean;
begin
  result := (length(spellChecked) > 0) or (length(spellUnChecked) > 0);
end;

procedure tfilterdata.clear;
begin
  FilterParamsChecked := [];
  FilterParamsunChecked := [];
  setLength(spellChecked, 0);
  setLength(spellUnChecked, 0);
  setLength(eventChecked, 0);
  setLength(eventUnChecked, 0);
end;

function tfilterdata.extractsavetext: string;
var
  i: integer;
begin
  // tag
  result := inttohex(int64(FilterParamsChecked), 16);
  result := result + PARAMSEPARATOR + inttohex(int64(FilterParamsunChecked),
    16);
  // spell
  for i := 0 to high(spellChecked) do
    result := result + PARAMSEPARATOR + '1' + inttohex
      (spellChecked[i].id, 6);
  for i := 0 to high(spellUnChecked) do
    result := result + PARAMSEPARATOR + '2' + inttohex
      (spellUnChecked[i].id, 6);
  // event
  for i := 0 to high(eventChecked) do
    result := result + PARAMSEPARATOR + '3' + inttohex(eventChecked[i], 6);
  for i := 0 to high(eventUnChecked) do
    result := result + PARAMSEPARATOR + '4' + inttohex(eventUnChecked[i], 6);
  result := stringreplace(name, PARAMSEPARATOR, '_', [rfReplaceAll])
    + PARAMSEPARATOR + result + PARAMSEPARATOR;
end;

function tfilterdata.extracttext(interact: boolean = false): string;
var
  i: integer;
  tagstr, tag1str, tag2str: string;
  spellstr, eventstr: string;
  tagAnd, tagflt: string;
const
  ANDtag = ' <b>AND</b> ';

begin
  result := '';
  tag1str := '';
  tag2str := '';
  eventstr := '';
  spellstr := '';
  for i := 0 to ord( high(eventParam)) do
  begin
    if eventParam(i) in FilterParamsChecked then
      tag1str := tag1str + '+' + EventParamsData[i].name + ' ';
    if eventParam(i) in FilterParamsunChecked then
      tag2str := tag2str + '-' + EventParamsData[i].name + ' ';
  end;
  // spell
  for i := 0 to high(spellChecked) do
  begin
    if interact then
      tagflt := ' [<a href="#-ft:' + inttostr(spellChecked[i].id) + '">-</a>]'
    else
      tagflt := '';
    spellstr := spellstr + '+' + getSpellName(spellChecked[i].id)
      + tagflt + ' ';
  end;
  for i := 0 to high(spellUnChecked) do
  begin
    if interact then
      tagflt := ' [<a href="#+ft:' + inttostr(spellUnChecked[i].id) + '">+</a>]'
    else
      tagflt := '';
    spellstr := spellstr + '-' + getSpellName(spellUnChecked[i].id)
      + tagflt + ' ';
  end;
  // event
  for i := 0 to high(eventChecked) do
    eventstr := eventstr + '+' + getEventName(eventChecked[i]) + ' ';
  for i := 0 to high(eventUnChecked) do
    eventstr := eventstr + '-' + getEventName(eventUnChecked[i]) + ' ';
  tagstr := tag1str + tag2str;
  if tagstr <> '' then
    result := '( <i>tags</i> = ' + tagstr + ')';
  if result <> '' then
    tagAnd := ANDtag
  else
    tagAnd := '';
  if spellstr <> '' then
    result := result + tagAnd + '( <i>spells</i> = ' + spellstr + ')';
  if result <> '' then
    tagAnd := ANDtag
  else
    tagAnd := '';
  if eventstr <> '' then
    result := result + tagAnd + '( <i>events</i> = ' + eventstr + ')';
  if result = '' then
    result := '<i>filter empty</i>';

  if interact then
    tagflt := ' [<a href="#rfi">Reset</a>]: '
  else
    tagflt := ':<br>';
  result := '<b>' + name + '</b>' + tagflt + result;
end;

procedure tfilterdata.assignData(s: string; param: integer);
begin
  case param of
    0:
      self.name := s;
    1:
      self.FilterParamsChecked := eventParams(StrToInt64Def('$' + s, 0));
    2:
      self.FilterParamsunChecked := eventParams(StrToInt64Def('$' + s, 0));
  else
    self.assignId(strtointdef('$' + copy(s, 2, 6), 0),
      strtointdef(copy(s, 1, 1), 0));
  end;
end;

procedure tfilterdata.assignId(value, param: integer);
begin
  case param of
    1:
      filternewspell(spellChecked, value);
    2:
      filternewspell(spellUnChecked, value);
    3:
      filternewEvent(eventChecked, value);
    4:
      filternewEvent(eventUnChecked, value);
  end;
end;

procedure filternewspell(var a: filterArraySpell;
  newvalue1: integer);
begin
  setLength(a, length(a) + 1);
  a[ high(a)].id := newvalue1;
end;

procedure filternewEvent(var a: filterArrayEvent; newvalue1: integer);
begin
  setLength(a, length(a) + 1);
  a[ high(a)] := newvalue1;
end;

constructor tEventType.initData(id, count: integer);
begin
  self.id := id;
  self.count := count;
  self.pnode := nil;
  fillchar(self.filtered, sizeof(self.filtered), 1);
end;

destructor tEventType.Destroy;
begin
  fillchar(self.filtered, sizeof(self.filtered), 1);
  inherited;
end;

constructor tauraLine.initData(isDebuff: boolean; spell: pointer; starttime, endtime: integer; u: pointer; ac: cardinal);
begin
  list := tlist.create;
  self.spell := spell;
  self.u := u;
  self.isDebuff := isDebuff;
  // on ajoute la premiere aura:
  list.add(tauraEvent.initData(starttime, endtime, ac));
end;

procedure tauraLine.newevent(starttime, endtime: integer; ac: cardinal);
begin
  list.add(tauraEvent.initData(starttime, endtime, ac));
end;


function tauraLine.getSpellId:integer;
begin
  result:=tspellinfo(spell).id;
end;

function tauraLine.getSpellName:String;
begin
  result:=tspellinfo(spell).name;
end;

function tauraLine.closeevent(endtime: integer; closeall: boolean): boolean;
var
  i: integer;
  auraevent: tauraEvent;
begin
  result := false;
  for i := 0 to list.count - 1 do
  begin
    auraevent := list.items[i];
    if auraevent.open then
    begin
      result := true;
      auraevent.open := false;
      auraevent.endtime := endtime;
      if not closeall then
        break;
    end;
  end;
end;

procedure tauraLine.SetUptime(duration: integer);
var
  i: integer;
  auraevent: tauraEvent;
  starttime, lasttime, totaltime: integer;
begin
  lasttime := 0;
  totaltime := 0;
  for i := 0 to list.count - 1 do
  begin
    auraevent := list.items[i];
    if auraevent.starttime < lasttime then
      starttime := lasttime
    else
      starttime := auraevent.starttime;
    if lasttime < auraevent.endtime then
    begin
      lasttime := auraevent.endtime;
      totaltime := totaltime + lasttime - starttime;
    end;
  end;
  self.Uptime := (divide(totaltime, duration) * 100);
  self.uptimestr := format(' (%.1f%%)', [Uptime]);
end;

destructor tauraLine.Destroy;
begin
  clear;
  list.free;
  inherited;
end;

procedure tauraLine.clear;
var
  i: integer;
begin
  for i := 0 to list.count - 1 do
    tauraEvent(list.items[i]).Destroy;
end;

constructor tauraEvent.initData(starttime, endtime: integer; ac: cardinal);
begin
  self.starttime := starttime;
  open := endtime = -1;
  self.endtime := endtime;
  self.auracolor := ac;
end;

// ---------------
function exclusiveParams(ep, checkedparams, uncheckedParams: eventParams)
  : boolean;
begin
  result := (ep - uncheckedParams = ep) and
    (ep * checkedparams = checkedparams);
end;

// utils
function newConstantUnitParam(opt1: unitOpts = []): rConstantUnitParams;
begin
  fillchar(result, sizeof(result), 0);
  result.option1 := opt1;
end;

function emptySpellParam: rConstantSpellParams;
begin
  fillchar(result, sizeof(result), 0);
end;

constructor tcombatBlock.initData(starttime, startEvent: integer;
  node: pointer);
begin
  UnitBlock := tlist.create;
  self.timestart := starttime;
  self.timestop := starttime;
  self.eventstart := startEvent;
  self.eventstop := startEvent;
  self.containBoss := -1;
  self.legende := '';
  self.legende2 := '';
  self.pnode := node;
  self.bossopts := [];
  self.bossdown := false;
  self.txtBOSSID := EMPTYBOSSSTRING;
end;

destructor tcombatBlock.Destroy;
begin
  UnitBlock.free;
  inherited;
end;

constructor tReplayData.initdata;
begin
  auraList:= tlist.create;
  currentAuraList:= tlist.create;
end;

destructor tReplayData.destroy;
begin
  auraList.free;
  currentAuraList.free;
  inherited;
end;

procedure treplayData.cleanData;
begin
  FillChar(r, SizeOf(r), 0);
  currentAuraList.clear;
end;

constructor tUnitData.initData(uGUID: unitGUID; uRef: pointer);
begin
  self.uGUID := uGUID;
  self.internalId := 0;
  params := [];
  pnode := nil;
  UnitAffiliation := nil;
  unitInfoRef := uRef;
  case self.uGUID.unitType of
    unitIsPlayer:
      uHp := use52Value(ClasseStat[0].hp, 0);
    unitIsPet:
      uHp := use52Value(HP_MIN_PET, 0);
  else
    uHp := use52Value(HP_MIN_NPC, 0);
  end;
  idInDrawList := -1;
  instaline.gfxratio := NoZeroValue(uHp div RATIO_DIVIDER);
  fillchar(uClasse, sizeof(uClasse), 0);
  fillchar(inCombat, sizeof(inCombat), 0);
  ActiveArray := nil;
  aura := nil;
  replaydata:= treplaydata.initData;
end;



function tUnitData.getclasse: byte;
begin
  if uClasse.currentclasse = 0 then
    result := uClasse.savedclasse
  else
    result := uClasse.currentclasse;
end;

procedure tUnitData.setclasse(c: byte);
begin
  uClasse.currentclasse := c;
  if c <> 0 then
    uClasse.savedclasse := c;
end;

destructor tUnitData.Destroy;
begin
  instaline.eventarray := nil;
  ActiveArray := nil;
  replaydata.free;
  if assigned(aura) then
    aura.Destroy;
  inherited;
end;


function tUnitData.getCombatForLocalPeriode(t1, t2: integer;
  v: Longword): boolean;
begin
  if inCombat.validator <> v then
    result := false
  else if (inCombat.first >= t1) and (inCombat.last <= t2) then
    result := true
  else if (inCombat.first <= t1) and (inCombat.last >= t1) then
    result := true
  else if (inCombat.first <= t2) and (inCombat.last >= t2) then
    result := true
  else
    result := false;
end;

procedure tUnitData.defineHpByClasse(sp: pointer);
begin
  if uClasse.currentclasse = 0 then
  begin
    Classe := getSpellParams(sp).option1;
    self.uHp := 0;
  end
end;

procedure tUnitData.define_Hp(esthp, hptank: integer);
begin
  if esthp <> DEATH_HP then
    case uGUID.unitType of
      unitIsPlayer:
        begin
          if esthp < hptank then
            esthp := hptank;
          if esthp > self.uHp then
            self.uHp := esthp;
        end;
      unitIsPet:
        if esthp > HP_MIN_PET then
          self.uHp := esthp;
    else
      if esthp > HP_MIN_NPC then
        self.uHp := esthp;
    end;
end;

function tUnitData.getcurrentPower(feed: integer): integer;
begin
  if uGUID.unitType = unitIsNPC then
    result := tUnitInfo(unitInfoRef).constantParams.manaType
  else if Classe > 0 then
    result := ClasseStat[Classe].dFeed[feed]
  else
    result := -1;
end;

constructor tSpellInfo.initData(id, count: integer; name: string;
  cp: rConstantSpellParams);
begin
  self.name := CleanString(name);
  self.count := count;
  self.id := id;
  self.constantParams := cp;
  //debug
  //self.constantParams.forcedCastTime:=0;
  self.pnode := nil;
  self.offsetaura := 0;
  self.sData := [];
  self.school := 0;
  fillchar(self.filtered, sizeof(self.filtered), 1);
  castDuration:=0;
  castTimetotal:=0;
  castCount:=0;
end;

function tSpellInfo.hasConstantParams: boolean;
begin
  result := (constantParams.option1 > 0) or
            (constantParams.option2 <> []) or
            (constantParams.forcedCastTime >0) or
            (constantParams.forcedRole >0);
end;

constructor tUnitInfo.initData(n: string; g, m: integer;
  cp: rConstantUnitParams; a: boolean; t: guidType;
  p: unitParams);
begin
  name := CleanString(n);
  GUID := g;
  MobID := m;
  constantParams := cp;
  assigned := a;
  unitType := t;
  params := p;
  list := tlist.create;
  UnitAffiliation := nil;
  willBeSaved := 0;
end;

function tUnitInfo.hasConstantParams: boolean;
begin
  result:= (constantParams.option1 <> []) or
           (constantParams.ReplayColor > 0) or
           (constantParams.replaySize > 0) ;
end;

function tUnitInfo.getNPC(uGUID: unitGUID): tUnitData;
var
  ul: tUnitData;
  i: integer;
begin
  result := nil;
  for i := list.count - 1 downto 0 do
  begin
    ul := list.items[i];
    if uGUID.GUID = ul.uGUID.GUID then
    begin
      result := ul;
      exit;
    end;
  end;
end;

function tUnitInfo.assignNPC(uGUID: unitGUID): tUnitData;
var
  ul: tUnitData;
begin
  result := getNPC(uGUID);
  if result = nil then
  begin
    // si on est toujours là, alors on crée une nouvelle unitList
    ul := tUnitData.initData(uGUID, self);
    if uoDontMakePlayerAffiliation in self.constantParams.option1 then
      include(ul.params, upDontAffiliate);
    list.add(ul);
    result := ul;
  end;
end;

function tUnitInfo.getUnitDatabyId(id: integer): tUnitData;
var
  j: integer;
begin
  for j := 0 to list.count - 1 do
    if tUnitData(list.items[j]).internalId = id then
    begin
      result := list.items[j];
      exit;
    end;
  result := nil;
end;

procedure tUnitInfo.clearStat;
var
  j: integer;
  ul: tUnitData;
begin
  for j := 0 to list.count - 1 do
  begin
    ul := list.items[j];
    fillchar(ul.stats, sizeof(ul.stats), 0);
    ul.Classe := 0;
    ul.uHp := 0;
    ul.mana := 0;
    ul.stats.globalnoderef := 1;
    ul.iLvl := 0;
  end;
end;

procedure tUnitInfo.clearDynamicParams;
var
  j: integer;
  ul: tUnitData;
begin
  for j := 0 to list.count - 1 do
  begin
    ul := list.items[j];
    ul.params := ul.params - [upWasFriend, upWasNpcVsRaid];
  end;
end;

procedure tUnitInfo.clearSaveValidation;
var
  j: integer;
begin
  self.willBeSaved := 0;
  for j := 0 to list.count - 1 do
    tUnitData(list.items[j]).willBeSaved := false;
end;

destructor tUnitInfo.Destroy;
var
  i: integer;
begin
  for i := 0 to list.count - 1 do
    tUnitData(list.items[i]).Destroy;
  list.free;
  inherited;
end;

Constructor pChatEvent.initData(s: string; eventtime: integer);
begin
  self.s := s;
  self.time := eventtime;
end;

Constructor pEvent.initData(s: rParsedString; hash: word; eventtime: integer;
  ul: tstringlist; i: integer);
var
  sourceGUID, destGUID, dataGUID: ParsedGUID;
  log52: boolean;
  j: integer;
const
  tag52: array [0 .. 1] of integer = (0, 12);
  data1: array [1 .. 5] of integer = (1, 3, 4, 6, 7);
  data2: array [1 .. 4] of integer = (2, 5, 8, 11);
begin
  time := eventtime;
  params := [];
  filter := 0;
  spell := nil;
  log52 := (hashEventTable[hash] <> $FF) and
    ((i - eventValue[hashEventTable[hash]].legacySize) > 2);
  extraUnit := nil;
  internalParams:=[];
  {$IFDEF DEBUG}
    eventString:= format('%s<br>%s',[s[8],s[12]]);
  {$ENDIF}

   //event value--------------------------------------
  if hashEventTable[hash] = $FF then
    type_UNKNOWN(self, event_UNKNOWN, s, ul, [])
  else
    eventValue[hashEventTable[hash]].func(self, eventValue[hashEventTable[hash]].e, s, eventValue[hashEventTable[hash]].u, 2, tag52[ord(log52)], i);
  //internalParams------------------------------------
  internalParams := internalParams + eventValue[ord(event)].internalParams;
  if eventIsOverDamage in params then
    internalParams := internalParams - [eventInternalIsValidforRez]; //

  // unitInfos----------------------------------------

  if not(eventInternalIsEncounterInfoEvent in internalParams) then
  begin
    sourceGUID := getGUID(s[8], s[10], s[9]);
    destGUID := getGUID(s[12], s[14], s[13]);
    if assigned(sourceUnit) then
    begin
      extraUnit := addNewUnittoList(sourceGUID);   //let switch source for spell_absorbed
      getmarklist(time, extraUnit, unit_ismarked42(strtointdef(s[11], 0)));
      sourceGUID.flags:=dummyFlag;
    end
    else
    begin
      sourceUnit := addNewUnittoList(sourceGUID);
      getmarklist(time, sourceUnit, unit_ismarked42(strtointdef(s[11], 0)));
    end;
    destUnit := addNewUnittoList(destGUID);
    getmarklist(time, destUnit, unit_ismarked42(strtointdef(s[15], 0)));
  end
  else
  begin
    sourceGUID := getGUID('0000000000000000', '0x0', 'nil');
    destGUID := getGUID('0000000000000000', '0x0', 'nil');
    sourceUnit := addNewUnittoList(sourceGUID);
    destUnit := addNewUnittoList(destGUID);
  end;


  // 60 new param support
  if log52 and (i >= eventValue[hashEventTable[hash]].start + 7) then // high(s)
  begin
    dataGUID := getGUID(s[eventValue[hashEventTable[hash]].start], '0', '',
      false);
    eInfo.u := getUnitFromList(dataGUID);
    // 5.2 hitPoints, attackPower, spellPower, resourceType, resourceAmount, xPosition, yPosition
    // 6.0 hitPoints, maxHitPoints, attackPower, spellPower, resolve, resourceType, resourceAmount, maxResourceAmount, xPosition, yPosition, itemLevel
    if assigned(eInfo.u) then
    begin
      for j := 1 to 5 do
        eInfo.data[j] := strtointdef
          (s[eventValue[hashEventTable[hash]].start + data1[j]], 0);
      // new 6.0.2 datas
      for j := 1 to 4 do
        eInfo.data2[j] := strtointdef
          (s[eventValue[hashEventTable[hash]].start + data2[j]], 0);
      for j := 1 to 2 do // xPosition, yPosition
        eInfoPos.data[j] := round
          (strtofloatdef(s[eventValue[hashEventTable[hash]].start + j + 8],
            0) * 100);
      if eInfo.data[1] <> 0 then
        AuthUse52Log := true;
      if eInfoPos.data[1] <> 0 then
        AuthUse54Log := true;
    end
    else
    begin
      fillchar(eInfo.data, 0, sizeof(eInfo.data));
      fillchar(eInfo.data2, 0, sizeof(eInfo.data2));
      fillchar(eInfoPos.data, 0, sizeof(eInfoPos.data));
    end;
  end;

  // attribution de parametres courants
  if unit_isFriend(sourceGUID.flags) then
    include(params, eventSourceIsFriend);
  if unit_isFriend(destGUID.flags) then
    include(params, eventDestIsFriend);
  // event raid affiliation
  if unit_isInRaid(sourceGUID.flags) then
    include(params, eventIsInitbyRaidUnit);
  if unit_isInRaid(destGUID.flags) then
    include(params, eventIsReceivedbyRaidUnit);
  // ---------------
  if unit_isFriend(sourceGUID.flags) and unit_isFriend(destGUID.flags) then
    include(params, eventIsFriendlyVsFriendly)
  else if (unit_isFriend(sourceGUID.flags) <> unit_isFriend(destGUID.flags))
    then
    include(params, eventIsFriendlyVsOther);
  if assigned(sourceUnit) and assigned(destUnit) then
    include(params, eventIsBothSide);

  //secure:
  If not assigned(spell) then
    spell:=spellArray[0];
end;

function pEvent.inAlertFilter: boolean;
begin
  if (spell.constantParams.AvoidableEventtype and 1 = 1) and (eventisdamage in params) then exit(true);
  if (spell.constantParams.AvoidableEventtype and 2 = 2) then
  begin
        if event = event_SPELL_AURA_APPLIED_DOSE then exit(statsarray[0]>= spell.constantParams.maxStack);
        if (spell.constantParams.maxStack=0) and ((eventIsAuraApply in params) or (eventIsAuraRefresh in params)) then exit(true);
  end;
  if (spell.constantParams.AvoidableEventtype and 4 = 4) and (event = event_SPELL_INTERRUPT) then exit(true);
  if (spell.constantParams.AvoidableEventtype and 8 = 8) and (eventisheal in params) then exit(true);
  result := false;
end;

function pEvent.getcolor: cardinal;
begin
  if (eventIsBuff in params) and ((eventIsAuraApply in params) or
      (eventIsAuraRefresh in params)) then
    result := event_color_Buff
  else if eventIsFalseDeath in params then
    result := event_color_falseDeath
  else
    result := eventValue[ord(event)].color;
end;

function pEvent.SpecialHit: byte;
begin
  if eventIsGlance in params then exit(2);
  if eventIsCrush in params then exit(3);
  if eventIsMultiStrike in params then result := 4 else result := 0;
  if eventIsCrit in params then inc(result);  //mstrike crit = 5
end;

function pEvent.GetAuraString: string;
begin
  if eventIsBuff in params then
    result := BUFF_STR
  else if eventIsDebuff in params then
    result := DEBUFF_STR
  else
    result := '';
end;

function pEvent.drawit: byte;
begin
  result := eventValue[ord(event)].drawit;
end;

function pEvent.Name: string;
begin
  result := getEventName(ord(event));
end;

function pEvent.offset: smallint;
begin
  result := eventValue[ord(event)].offset;
end;

procedure type_ENCOUNTER_START(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
begin
  p.event := e;
  p.params := u;
  p.statsarray[0] := strtointdef(s[8], 0); // ID   9= encounter name
  p.statsarray[1] := strtointdef(s[10], 0); // instacnetag
  p.statsarray[2] := strtointdef(s[11], 0); // nbPlayer
  addBosstoInfolist(p.statsarray[0], s[9]);
end;

procedure type_ENCOUNTER_STOP(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
begin
  p.event := e;
  p.params := u;
  p.statsarray[0] := strtointdef(s[8], 0); // ID   9= encounter name
  p.statsarray[1] := strtointdef(s[10], 0); // instacetag
  p.statsarray[2] := strtointdef(s[11], 0); // nbPlayer
  p.statsarray[3] := strtointdef(s[12], 0); // 1 = down
  addBosstoInfolist(p.statsarray[0], s[9]);
end;

procedure type_UNKNOWN(p: pEvent; e: eventType; s: rParsedString;
  ul: tstringlist; u: eventParams);
var
  strtmp: string;
  tmpid: integer;
begin
  p.event := e;
  strtmp := copy(s[7], 2, length(s[7]));
  tmpid := ul.IndexOf(strtmp);
  p.params := u;
  if tmpid >= 0 then
    p.statsarray[0] := tmpid
  else
  begin
    p.statsarray[0] := ul.count;
    ul.add(strtmp);
  end;
end;

procedure type_SPELL_SKIPPED(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
begin
end;

procedure type_ENCHANT(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  Id := HashInt(s[14 + tag]) + SECUNDARY_SPELL_INDEX;
  p.spell := assignSpellData(Id, s[14 + tag],  p.params, getSchool(p, strtointdef(s[16 + tag], 0)), true);
end;

procedure type_SPELL_ABSORBED(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var
  sourceGuid: ParsedGUID;
  tagSpell, id: integer;
begin
  p.event := e;
  p.params := u;
  if i > 25 then // spell info, not here for melee
  begin
    p.statsarray[1] := strtointdef(s[16], 0); // extraSpellInfo
    assignSpellData(p.statsarray[1], s[17], p.params,
      getSchool(p, strtointdef(s[18], 0)), true); // extraspell
    tagSpell := 3;
  end
  else
  begin
    p.statsarray[1] := 6; // = !melee
    tagSpell := 0;
  end;

  // regularData
  sourceGuid := getGUID(s[16 + tagSpell], s[18 + tagSpell], s[17 + tagSpell]);
  p.sourceUnit := addNewUnittoList(sourceGuid);  //we switch extraunit and sourceunit
  getmarklist(p.time, p.extraUnit, unit_ismarked42(strtointdef(s[19 + tagSpell], 0)));
  p.dummyFlag:= sourceGuid.flags;

  Id := strtointdef(s[20 + tagSpell], 0);
  p.spell := assignSpellData(Id, s[21 + tagSpell], p.params,
    getSchool(p, strtointdef(s[22 + tagSpell], 0)), true); // extraspell
  p.statsarray[0] := strtointdef(s[23 + tagSpell], 0); // absorbedValue
end;

procedure type_SWING_DAMAGE(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
begin
  p.event := e; // ,-1,1,0,0,0,nil,nil,nil
  p.params := u;
  p.statsarray[0] := strtointdef(s[14 + tag + tag52], 0); // amount
  p.statsarray[1] := strtointdef(s[17 + tag + tag52], 0); // resist
  p.statsarray[2] := strtointdef(s[18 + tag + tag52], 0); // blocked
  p.statsarray[3] := strtointdef(s[19 + tag + tag52], 0); // absorb
  p.statsarray[4] := strtointdef(s[15 + tag + tag52], 0); // overdamage
  if p.statsarray[4] > 0 then
    include(p.params, eventIsOverDamage);
  if s[20 + tag + tag52] = '1' then
    include(p.params, eventIsCrit);
  if s[21 + tag + tag52] = '1' then
    include(p.params, eventIsGlance);
  if s[22 + tag + tag52] = '1' then
    include(p.params, eventIsCrush);
  if s[23 + tag + tag52] = '1' then
    include(p.params, eventIsMultiStrike);
  if p.statsarray[1] > 0 then
    include(p.params, eventIsMitigatigatedResist);
  if p.statsarray[2] > 0 then
    include(p.params, eventIsMitigatigatedBlock);
  if p.statsarray[3] > 0 then
    include(p.params, eventIsMitigatigatedAbsorb);
  p.spell := assignSpellData(6, SWING_LABEL, p.params, getSchool(p, 1), true);
end;

procedure type_SPELL_DISPEL(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID
  p.statsarray[0] := strtointdef(s[17 + tag + tag52], 0); // extraspellID
  if s[20 + tag + tag52] = 'BUFF' then
    p.params := p.params + [eventIsBuffDispelled]
  else
    p.params := p.params + [eventIsDebuffDispelled];

  p.spell := assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[16 + tag], 0)), true);
  assignSpellData(p.statsarray[0], s[18 + tag + tag52], p.params,
    strtointdef(s[19 + tag + tag52], 0), false); // extraspell
end;

procedure type_SPELL_AURA_BROKEN(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);

begin
  p.event := e;
  p.params := u;
  p.statsarray[0] := strtointdef(s[14 + tag], 0); // extraId
  if s[17 + tag + tag52] = 'BUFF' then
    p.params := p.params + [eventIsBuffDispelled]
  else
    p.params := p.params + [eventIsDebuffDispelled];
  assignSpellData(p.statsarray[0], s[15 + tag], p.params,
    strtointdef(s[16 + tag], 0), true);
end;

procedure type_SPELL_AURA_BROKEN_SPELL(p: pEvent; e: eventType;
  s: rParsedString; u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[17 + tag + tag52], 0);
  /// /spellID
  p.statsarray[0] := strtointdef(s[14 + tag], 0); // extraspellID
  if s[20 + tag + tag52] = 'BUFF' then
    p.params := p.params + [eventIsBuffDispelled]
  else
    p.params := p.params + [eventIsDebuffDispelled];
  p.spell := assignSpellData(id, s[18 + tag + tag52], p.params,
    getSchool(p, strtointdef(s[19 + tag + tag52], 0)), true);
  assignSpellData(p.statsarray[0], s[15 + tag], p.params,
    strtointdef(s[16 + tag], 0), false);
end;

procedure type_SPELL_INTERRUPT(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID
  p.statsarray[0] := strtointdef(s[17 + tag + tag52], 0); // extraspellID
  p.spell := assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[16 + tag], 0)), true);
  assignSpellData(p.statsarray[0], s[18 + tag + tag52], p.params,
    strtointdef(s[19 + tag + tag52], 0), false); // extraspellName
end;

procedure type_SPELL_EXTRA_ATTACKS(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID
  p.statsarray[0] := strtointdef(s[17 + tag + tag52], 0); // amount
  p.spell := assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[16 + tag], 0)), true);
end;

procedure type_SPELL_ENERGIZE(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID
  p.statsarray[0] := strtointdef(s[17 + tag + tag52], 0); // amount
  p.statsarray[1] := getPowerType(strtointdef(s[18 + tag + tag52], 0));
  // except for healing:
  if p.statsarray[1] = 1 then
    p.params := p.params + [eventIsHeal];
  p.spell := assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[16 + tag], 0)), true);
end;

procedure type_SPELL_DRAIN(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID
  p.statsarray[0] := strtointdef(s[17 + tag + tag52], 0); // amount
  p.statsarray[1] := getPowerType(strtointdef(s[18 + tag + tag52], 0));
  p.statsarray[2] := strtointdef(s[19 + tag + tag52], 0); // extraamount
  p.spell := assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[16 + tag], 0)), true);
end;

procedure type_SWING_MISSED(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
begin
  p.event := e;
  p.params := u;
  p.statsarray[0] := GetMissType(p, s[14 + tag + tag52]);
  if s[16 + tag + tag52] = '1' then
    include(p.params, eventIsMultiStrike);
  p.statsarray[1] := strtointdef(s[17 + tag + tag52], 0);
  // ------wotlk value for abs/block/resist
  p.spell := assignSpellData(6, SWING_LABEL, p.params, getSchool(p,
      SPELL_SCHOOL_PHYSICAL), true);
end;

procedure type_SPELL_CAST_SUCCESS(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID
  p.spell := assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[16 + tag], 0)), true);
end;

procedure type_SPELL_AURA_APPLIED(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID

  if s[17 + tag + tag52] = 'BUFF' then
    p.params := p.params + [eventIsBuff]
  else
    p.params := p.params + [eventIsDebuff];
  // new absorb stat 4.01+
  if s[18 + tag + tag52] <> '' then
  begin
    p.statsarray[1] := strtointdef(s[18 + tag + tag52], 0);
    // amount of absorb pool
    //p.statsarray[2] := strtointdef(s[19 + tag + tag52], 0); // unknow stat
    //p.statsarray[3] := strtointdef(s[20 + tag + tag52], 0); // unknow stat
    if p.statsarray[1] > 0 then
    begin
      include(p.internalParams, eventInternalIsAbsPool);
      if eventIsauraremove in u then
          include(p.Params, eventIsFixedAbsorb);
    end;
  end;
  p.spell := assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[16 + tag], 0)), true);
end;

procedure type_SPELL_AURA_APPLIED_DOSE(p: pEvent; e: eventType;
  s: rParsedString; u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID
  p.statsarray[0] := strtointdef(s[18 + tag + tag52], 0); // amount
  if s[17 + tag + tag52] = 'BUFF' then
    p.params := p.params + [eventIsBuff]
  else
    p.params := p.params + [eventIsDebuff];
  p.spell := assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[16 + tag], 0)), true);
end;

procedure type_SPELL_AURA_REMOVED_DOSE(p: pEvent; e: eventType;
  s: rParsedString; u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID
  p.statsarray[0] := strtointdef(s[18 + tag + tag52], 0); // amount
  if s[17 + tag + tag52] = 'BUFF' then
    p.params := p.params + [eventIsBuff]
  else
    p.params := p.params + [eventIsDebuff];
  p.spell := assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[16 + tag], 0)), true);
end;

procedure type_ENVIRONMENTAL_DAMAGE(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
 id := HashInt(s[14 + tag + tag52])+SECUNDARY_SPELL_INDEX;
  p.statsarray[0] := strtointdef(s[15 + tag + tag52], 0); // amount
  p.spell := assignSpellData(id,  s[14 + tag + tag52], p.params,
    getSchool(p, strtointdef(s[16 + tag + tag52], 0)), true);
end;

procedure type_SPELL_HEAL(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID
  p.statsarray[0] := strtointdef(s[17 + tag + tag52], 0); // amount
  p.statsarray[1] := strtointdef(s[18 + tag + tag52], 0);
  if p.statsarray[1] > 0 then
    include(p.params, eventIsOverHeal)
  else
    exclude(p.params, eventIsOverHeal);
  if s[20 + tag + tag52] = '1' then
    include(p.params, eventIsCrit);
  if s[21 + tag + tag52] = '1' then
    include(p.params, eventIsMultiStrike);

  p.statsarray[2] := strtointdef(s[19 + tag + tag52], 0);
  if p.statsarray[2] > 0 then
    include(p.params, eventIsMitigatigatedAbsorb)
  else
    exclude(p.params, eventIsMitigatigatedAbsorb);

  p.spell := assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[16 + tag], 0)), true);
end;

procedure type_UNIT_DIED(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
begin
  p.event := e;
  p.params := u;
end;

procedure type_SPELL_DAMAGE(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID
  p.statsarray[0] := strtointdef(s[17 + tag + tag52], 0); // amount
  p.statsarray[1] := strtointdef(s[20 + tag + tag52], 0); // resist
  p.statsarray[2] := strtointdef(s[21 + tag + tag52], 0); // block
  p.statsarray[3] := strtointdef(s[22 + tag + tag52], 0); // absorb
  p.statsarray[4] := strtointdef(s[18 + tag + tag52], 0); // overdamage
  if p.statsarray[4] > 0 then
    include(p.params, eventIsOverDamage);

  if s[23 + tag + tag52] = '1' then
    include(p.params, eventIsCrit);
  if s[24 + tag + tag52] = '1' then
    include(p.params, eventIsGlance);
  if s[25 + tag + tag52] = '1' then
    include(p.params, eventIsCrush);
  if s[26 + tag + tag52] = '1' then
    include(p.params, eventIsMultiStrike);
  if p.statsarray[1] > 0 then
    include(p.params, eventIsMitigatigatedResist);
  if p.statsarray[2] > 0 then
    include(p.params, eventIsMitigatigatedBlock);
  if p.statsarray[3] > 0 then
    include(p.params, eventIsMitigatigatedAbsorb);

  p.spell:= assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[19 + tag + tag52], 0)), true);
end;

procedure type_SPELL_MISSED(p: pEvent; e: eventType; s: rParsedString;
  u: eventParams; tag, tag52, i: integer);
var id:integer;
begin
  p.event := e;
  p.params := u;
  id := strtointdef(s[14 + tag], 0); // spellID
  p.statsarray[0] := GetMissType(p, s[17 + tag + tag52]);
  if s[19 + tag + tag52] = '1' then
    include(p.params, eventIsMultiStrike);
  p.statsarray[1] := strtointdef(s[20 + tag + tag52], 0); // absorb value
  p.spell := assignSpellData(id, s[15 + tag], p.params,
    getSchool(p, strtointdef(s[16 + tag], 0)), true);
end;

function GetMissType(p: pEvent; s: String): integer;
var
  i: integer;
  tmpeventparam: eventParam;
begin
  tmpeventparam := eventIsMitigatigatedAbsorb;
  for i := 1 to high(CharMissType) do
  begin
    if s = CharMissType[i] then
    begin
      p.params := p.params + [tmpeventparam];
      result := i;
      exit;
    end;
    inc(tmpeventparam);
  end;
  result := 0;
end;

function getSchool(p: pEvent; s: integer): integer;
begin
  {
    SPELL_SCHOOL_PHYSICAL = $01;
    SPELL_SCHOOL_HOLY = $02;
    SPELL_SCHOOL_FIRE = $04;
    SPELL_SCHOOL_NATURE = $08;
    SPELL_SCHOOL_FROST = $10;
    SPELL_SCHOOL_SHADOW = $20;
    SPELL_SCHOOL_ARCANE = $40;
    }
  if (s and SPELL_SCHOOL_PHYSICAL) = SPELL_SCHOOL_PHYSICAL then
    p.params := p.params + [eventIsSchool_Physical];
  if (s and SPELL_SCHOOL_HOLY) = SPELL_SCHOOL_HOLY then
    p.params := p.params + [eventIsSchool_Holy];
  if (s and SPELL_SCHOOL_FIRE) = SPELL_SCHOOL_FIRE then
    p.params := p.params + [eventIsSchool_Fire];
  if (s and SPELL_SCHOOL_NATURE) = SPELL_SCHOOL_NATURE then
    p.params := p.params + [eventIsSchool_Nature];
  if (s and SPELL_SCHOOL_FROST) = SPELL_SCHOOL_FROST then
    p.params := p.params + [eventIsSchool_Frost];
  if (s and SPELL_SCHOOL_SHADOW) = SPELL_SCHOOL_SHADOW then
    p.params := p.params + [eventIsSchool_Shadow];
  if (s and SPELL_SCHOOL_ARCANE) = SPELL_SCHOOL_ARCANE then
    p.params := p.params + [eventIsSchool_Arcane];
  result := s;
end;

// update some stuff for backward compatibility  (mainly for *.wcr save file)

procedure pEvent.fixCompatibility;
begin
  // --------------
end;
// text facilities

function getschooltext(p: pEvent): string; overload;
begin
  result := '';
  if eventIsSchool_Physical in p.params then
    result := '<font color=' + inttostr(spellSchoolparam[1].color)
      + '>' + spellSchoolparam[1].name + '</font> ';
  if eventIsSchool_Holy in p.params then
    result := result + '<font color=' + inttostr(spellSchoolparam[2].color)
      + '>' + spellSchoolparam[2].name + '</font> ';
  if eventIsSchool_Fire in p.params then
    result := result + '<font color=' + inttostr(spellSchoolparam[3].color)
      + '>' + spellSchoolparam[3].name + '</font> ';
  if eventIsSchool_Nature in p.params then
    result := result + '<font color=' + inttostr(spellSchoolparam[4].color)
      + '>' + spellSchoolparam[4].name + '</font> ';
  if eventIsSchool_Frost in p.params then
    result := result + '<font color=' + inttostr(spellSchoolparam[5].color)
      + '>' + spellSchoolparam[5].name + '</font> ';
  if eventIsSchool_Shadow in p.params then
    result := result + '<font color=' + inttostr(spellSchoolparam[6].color)
      + '>' + spellSchoolparam[6].name + '</font> ';
  if eventIsSchool_Arcane in p.params then
    result := result + '<font color=' + inttostr(spellSchoolparam[7].color)
      + '>' + spellSchoolparam[7].name + '</font> ';
  if result <> '' then
    result := ' [' + trim(result) + ']';
end;

function getschooltext(sp: tspellInfo): string; overload;
begin
  result := '';
  if assigned(sp) then
  begin
    if (sp.school and SPELL_SCHOOL_PHYSICAL)
      = SPELL_SCHOOL_PHYSICAL then
      result := '<font color=' + inttostr(spellSchoolparam[1].color)
        + '>' + spellSchoolparam[1].name + '</font> ';
    if (sp.school and SPELL_SCHOOL_HOLY) = SPELL_SCHOOL_HOLY then
      result := result + '<font color=' + inttostr(spellSchoolparam[2].color)
        + '>' + spellSchoolparam[2].name + '</font> ';
    if (sp.school and SPELL_SCHOOL_FIRE) = SPELL_SCHOOL_FIRE then
      result := result + '<font color=' + inttostr(spellSchoolparam[3].color)
        + '>' + spellSchoolparam[3].name + '</font> ';
    if (sp.school and SPELL_SCHOOL_NATURE)
      = SPELL_SCHOOL_NATURE then
      result := result + '<font color=' + inttostr(spellSchoolparam[4].color)
        + '>' + spellSchoolparam[4].name + '</font> ';
    if (sp.school and SPELL_SCHOOL_FROST) = SPELL_SCHOOL_FROST then
      result := result + '<font color=' + inttostr(spellSchoolparam[5].color)
        + '>' + spellSchoolparam[5].name + '</font> ';
    if (sp.school and SPELL_SCHOOL_SHADOW)
      = SPELL_SCHOOL_SHADOW then
      result := result + '<font color=' + inttostr(spellSchoolparam[6].color)
        + '>' + spellSchoolparam[6].name + '</font> ';
    if (sp.school and SPELL_SCHOOL_ARCANE)
      = SPELL_SCHOOL_ARCANE then
      result := result + '<font color=' + inttostr(spellSchoolparam[7].color)
        + '>' + spellSchoolparam[7].name + '</font> ';
    if result <> '' then
      result := ' [' + trim(result) + ']';
  end;
end;

// -Utils-------------
function getUnitParam(u: tUnitData): unitParams;
begin
  if assigned(u) then
    result := u.params
  else
    result := [];
end;


function getGUID(s, f, n: string; assignGuid: boolean = true): ParsedGUID;
var
  ParsedGUID: array [0 .. 6] of string;
  c: char;
  i, j, l, id: integer;
  params: unitParams;
const
  separator = '-';
begin
  params := [];
  // nil
  if s = '0000000000000000' then
  begin
    result.id.unitType := unitIsNil;
    result.id.MobID := 0;
    result.flags:= 0;
    exit;
  end;
  // parsed the 6.0 GUID

  id := 0;
  j := 1;
  l := length(s);
  for i := 1 to l do
  begin
    c := s[i];
    if (c = separator) then
    begin
      ParsedGUID[id] := copy(s, j, i - j);
      inc(id);
      j := i + 1;
    end
    else if i = l then
     ParsedGUID[id] := copy(s, j, i - j + 1);
  end;


  result.flags := strtointdef(f, 0);
  result.id.listID := -1;

  case length(ParsedGUID[0]) of
    3: // ='Pet'
      begin
        result.id.unitType := unitIsPet;
        result.id.GUID := strtointdef('0x' + ParsedGUID[6], 0);
        result.id.MobID := strtointdef(ParsedGUID[5], 0);
      end;
    4: // ='Item'
      begin
        result.id.unitType := unitIsObject;
        result.id.GUID := integer((StrToInt64Def('0x' + ParsedGUID[3],0) shl 32) shr 32);
        result.id.MobID := 0;
      end;
    6: // ='Player'
      begin
        result.id.unitType := unitIsPlayer;
        result.id.GUID := strtointdef('0x' + ParsedGUID[2], 0);
        result.id.MobID := 0;
      end
    else // creature/vehicle 7-8
    begin
      result.id.unitType := unitIsNPC;
      result.id.GUID := strtointdef('0x' + ParsedGUID[6], 0);
      result.id.MobID := strtointdef(ParsedGUID[5], 0);
      // keep vehicle tag:
      if ParsedGUID[0][2] = 'e' then
      begin
        params := [upIsVehicle];
      end;
    end;
  end;
  // fallback : object with flag
  if result.flags and COMBATLOG_OBJECT_TYPE_MASK =
    COMBATLOG_OBJECT_TYPE_OBJECT then
    result.id.unitType := unitIsObject;

  if assignGuid then
    assignUnitInfos(n, result, params);
  exit;
end;

procedure FixUnknownName(u: tUnitInfo; n: string);
begin
  if u.name = prefs.unknownlabel then
    u.name := CleanString(n);
end;

procedure assignUnitInfos(n: string; var uGUID: ParsedGUID; params: unitParams);
var
  i: integer;
begin
  // stats
  if (uGUID.id.unitType = unitIsNPC) and (NpcIdMax < uGUID.id.MobID) then
    NpcIdMax := uGUID.id.MobID;
  // nil
  if (uGUID.id.unitType = unitIsNil) then
    exit
    // NPC Standard
  else if (uGUID.id.unitType = unitIsNPC) and (uGUID.id.MobID > low(npcArray))
    and (uGUID.id.MobID < high(npcArray)) then
  begin
    params := params+[upIsValidNPC];
    if assigned(npcArray[uGUID.id.MobID]) then
    begin
      if not npcArray[uGUID.id.MobID].assigned then
      begin
        npcArray[uGUID.id.MobID].name := CleanString(n);
        npcArray[uGUID.id.MobID].MobID := uGUID.id.MobID;
        npcArray[uGUID.id.MobID].assigned := true;
        npcArray[uGUID.id.MobID].params := params;
      end;
      FixUnknownName(npcArray[uGUID.id.MobID], n);
    end
    else
    begin
      npcArray[uGUID.id.MobID] := tUnitInfo.initData(n, 0, uGUID.id.MobID,
        newConstantUnitParam, true, uGUID.id.unitType, params);
    end;
  end
  // player
  else if uGUID.id.unitType = unitIsPlayer then
  begin
    if unit_isInRaid(uGUID.flags) then
      params := params+[upWasPlayerInRaid, upWasInRaid];
    for i := 0 to unitArray.count - 1 do
      if tUnitInfo(unitArray.items[i]).GUID = uGUID.id.GUID then
      begin
        uGUID.id.listID := i;
        tUnitInfo(unitArray.items[i]).params := tUnitInfo(unitArray.items[i]).params + params;
        FixUnknownName(tUnitInfo(unitArray.items[i]), n);
        exit;
      end;
    uGUID.id.listID := unitArray.count;
    unitArray.add(tUnitInfo.initData(n, uGUID.id.GUID, 0, newConstantUnitParam,
        true, uGUID.id.unitType, params));
  end
  // pet ou NPC avec mobId >maxId
  else
  begin
    for i := 0 to unitArray.count - 1 do
      if (tUnitInfo(unitArray.items[i]).MobID = uGUID.id.MobID) and
        (tUnitInfo(unitArray.items[i]).unitType = uGUID.id.unitType) then
      begin
        uGUID.id.listID := i;
        tUnitInfo(unitArray.items[i]).params := tUnitInfo(unitArray.items[i])
          .params + params;
        FixUnknownName(tUnitInfo(unitArray.items[i]), n);
        exit;
      end;
    uGUID.id.listID := unitArray.count;
    unitArray.add(tUnitInfo.initData(n, 0, uGUID.id.MobID,
        newConstantUnitParam, true, uGUID.id.unitType, params));
  end;
end;

function addNewUnittoList(uGUID: ParsedGUID): tUnitData;
var
  UnitInfo: tUnitInfo;
begin
  result := nil;
  if uGUID.id.unitType <> unitIsNil then
  begin
    UnitInfo := getUnitInfo(uGUID.id);
    if assigned(UnitInfo) then
    begin
      result := UnitInfo.assignNPC(uGUID.id);
      if unit_isInRaid(uGUID.flags) then
        result.params := result.params + [upWasInRaid];
    end;
  end;
end;

function getUnitFromList(uGUID: ParsedGUID): tUnitData;
var
  UnitInfo: tUnitInfo;
begin
  result := nil;
  if uGUID.id.unitType <> unitIsNil then
  begin
    UnitInfo := getUnitInfo(uGUID.id);
    if assigned(UnitInfo) then
      result := UnitInfo.getNPC(uGUID.id);
  end;
end;

function getUnitInfo(u: tUnitData): tUnitInfo;
begin
  if assigned(u) then
    result := u.unitInfoRef
  else
    result := nil;
end;

function getUnitInfo(uGUID: unitGUID): tUnitInfo;
var
  i: integer;
begin
  result := nil;
  if (uGUID.unitType = unitIsNil) then
    result := npcArray[0]
  else if (uGUID.unitType = unitIsNPC) and (uGUID.MobID < high(npcArray))
    and assigned(npcArray[uGUID.MobID]) then
    result := npcArray[uGUID.MobID]
  else if (unitArray.count > 0) and (uGUID.listID < unitArray.count) then
  begin
    if uGUID.listID >= 0 then
      result := tUnitInfo(unitArray.items[uGUID.listID])
    else
    begin
      for i := 0 to unitArray.count - 1 do
      begin
        if (tUnitInfo(unitArray.items[i]).unitType = uGUID.unitType) and
          (tUnitInfo(unitArray.items[i]).GUID = uGUID.GUID) then
        begin
          result := unitArray.items[i];
          break;
        end
      end;
    end;
  end;
end;

function getUnitType(u: tUnitData): guidType;
begin
  if assigned(u) then
    result := u.uGUID.unitType
  else
    result := unitIsNil;
end;

function getUnitGUID(u: tUnitData): unitGUID;
begin
  if assigned(u) then
    result := u.uGUID
  else
  begin
    fillchar(result, sizeof(result), 0);
    result.unitType := unitIsNil;
  end;
end;

function getSecureUnitInfoName(u: tUnitInfo): string;
begin
  if assigned(u) then
    result := u.name
  else
    result := '';
end;

function getUnitDungeonAff(MobID: integer): integer;
begin
  result := 0;
  if MobID <= 0 then
    exit
  else if (MobID < high(npcArray)) and assigned(npcArray[MobID]) then
    result := npcArray[MobID].constantParams.DonjonAff;
end;

function getUnitName(MobID: integer; getopts: sgetnameopts;
  nilresult: string = UNIT_NAME_ERROR): string; overload;
var
  i: integer;
begin
  result := nilresult;
  if MobID <= 0 then
    exit
  else if (MobID < high(npcArray)) and assigned(npcArray[MobID]) then
    result := npcArray[MobID].name
  else
    for i := 0 to unitArray.count - 1 do
      if tUnitInfo(unitArray.items[i]).MobID = MobID then
        result := tUnitInfo(unitArray.items[i]).name;
end;

function getUnitName(uGUID: unitGUID; getopts: sgetnameopts;
  nilresult: string = UNIT_NAME_ERROR): string; overload;
var
  UnitInfo: tUnitInfo;
begin
  UnitInfo := getUnitInfo(uGUID);
  if assigned(UnitInfo) then
    result := UnitInfo.name
  else
    result := nilresult;
end;

function getUnitName(ul: tUnitData; getopts: sgetnameopts;
  nilresult: string = UNIT_NAME_ERROR): string; overload;
var
  UnitInfo: tUnitInfo;
  i: integer;
begin
  UnitInfo := getUnitInfo(ul);
  if assigned(UnitInfo) then
  begin
    result := UnitInfo.name;
    if (getNoserver in getopts) and (ul.uGUID.unitType = unitIsPlayer) then
    begin
      i := pos('-', result);
      if i > 1 then
        result := copy(result, 1, i - 1);
    end;
    if getOccurence in getopts then
      if ul.stats.sumchild > 0 then
        result := format('%s (%d)', [result, ul.stats.sumchild]);
    if getaff in getopts then
      result := result + parenthese_string
        (getUnitName(tUnitData(ul.UnitAffiliation), [getNoserver], ''));

    if getHp in getopts then
      result := result + format(UNIT_HP_TAG, [ul.uHp]);
    if gettag in getopts then
    begin
      if StatIsTank in ul.stats.params then
        result := TANK_TAG + result;
      if statIsHealer in ul.stats.params then
        result := HEAL_TAG + result;
    end;

     if upIsVehicle in ul.params then
        result := VEHICLE_TAG + result;

    //if getShowVehicleTag in getopts then
    //begin
    //  if upIsVehicle in ul.params then
    //    result := VEHICLE_TAG + result;
    //end;

  end
  else
    result := nilresult;
end;

function GetUnitOption(u: tUnitInfo; bypassvalid: boolean = false): unitOpts;
  overload;
begin
  if (assigned(u)) and (bypassvalid or (upIsValidNPC in u.params)) then
    result := u.constantParams.option1
  else
    result := [];
end;

function GetUnitOption(u: tUnitData; bypassvalid: boolean = false): unitOpts;
  overload;
begin
  if (assigned(u)) and (bypassvalid or (upIsValidNPC in u.params)) then
    result := npcArray[u.uGUID.MobID].constantParams.option1
  else
    result := [];
end;

function GetUnitOptionMobId(u: tUnitData): integer;
begin
  result := 0;
  if (assigned(u)) and (upIsValidNPC in u.params) then
  begin
    if assigned(npcArray[npcArray[u.uGUID.MobID].constantParams.param1]) then
    begin
      npcArray[npcArray[u.uGUID.MobID].constantParams.param1].params := npcArray
        [npcArray[u.uGUID.MobID].constantParams.param1].params + [upIsValidNPC];
      result := npcArray[u.uGUID.MobID].constantParams.param1;
    end
    else
    begin
      // reset affiliation
      npcArray[u.uGUID.MobID].constantParams.param1 := 0;
      npcArray[u.uGUID.MobID].constantParams.option1 := npcArray[u.uGUID.MobID]
        .constantParams.option1 - [uoIsBossAffiliated];
    end;
  end;
end;

function unit_ismarked(flags: integer): integer;
begin
  result := flags and COMBATLOG_OBJECT_SPECIAL_MASK;
  case result of
    COMBATLOG_OBJECT_RAIDTARGET1:
      result := 1;
    COMBATLOG_OBJECT_RAIDTARGET2:
      result := 2;
    COMBATLOG_OBJECT_RAIDTARGET3:
      result := 3;
    COMBATLOG_OBJECT_RAIDTARGET4:
      result := 4;
    COMBATLOG_OBJECT_RAIDTARGET5:
      result := 5;
    COMBATLOG_OBJECT_RAIDTARGET6:
      result := 6;
    COMBATLOG_OBJECT_RAIDTARGET7:
      result := 7;
    COMBATLOG_OBJECT_RAIDTARGET8:
      result := 8;
  else
    result := 0;
  end;
end;

function unit_ismarked42(flags: integer): integer;
begin
  result := flags and COMBATLOG42_RAIDTARGET_SPECIAL_MASK;
  case result of
    COMBATLOG42_OBJECT_RAIDTARGET1:
      result := 1;
    COMBATLOG42_OBJECT_RAIDTARGET2:
      result := 2;
    COMBATLOG42_OBJECT_RAIDTARGET3:
      result := 3;
    COMBATLOG42_OBJECT_RAIDTARGET4:
      result := 4;
    COMBATLOG42_OBJECT_RAIDTARGET5:
      result := 5;
    COMBATLOG42_OBJECT_RAIDTARGET6:
      result := 6;
    COMBATLOG42_OBJECT_RAIDTARGET7:
      result := 7;
    COMBATLOG42_OBJECT_RAIDTARGET8:
      result := 8;
  else
    result := 0;
  end;
end;

procedure getmarklist(t: integer; u: tUnitData; mark: integer);
var
  pm: pmarkevent;
begin
  if not(assigned(u)) or (mark <= 0) then
    exit;
  if markedList[mark].count > 0 then
  begin
    pm := markedList[mark].items[markedList[mark].count - 1];
    if pm.u = u then
    begin
      pm.endtime := t;
      exit;
    end;
  end;
  new(pm);
  markedList[mark].add(pm);
  pm.u := u;
  pm.starttime := t;
  pm.endtime := t;
end;

function unit_isFriend(flags: integer): boolean;
begin
  result := flags and COMBATLOG_OBJECT_REACTION_MASK =
    COMBATLOG_OBJECT_REACTION_FRIENDLY;
end;

function unit_isInRaid(flags: integer): boolean;
var
  tmp: integer;
begin
  tmp := flags and COMBATLOG_OBJECT_AFFILIATION_MASK;
  result := (tmp >= COMBATLOG_OBJECT_AFFILIATION_MINE) and
    (tmp <= COMBATLOG_OBJECT_AFFILIATION_RAID);
end;

function unit_isPlayerControled(flags: integer): boolean;
begin
  result := flags and COMBATLOG_OBJECT_CONTROL_MASK =
    COMBATLOG_OBJECT_CONTROL_PLAYER;
end;

function unit_objectType(flags: integer): guidObjectType;
begin
  case flags and COMBATLOG_OBJECT_TYPE_MASK of
    COMBATLOG_OBJECT_TYPE_PLAYER:
      result := ObjectIsPlayer;
    COMBATLOG_OBJECT_TYPE_NPC:
      result := ObjectIsNPC;
    COMBATLOG_OBJECT_TYPE_PET:
      result := ObjectIsPet;
    COMBATLOG_OBJECT_TYPE_GUARDIAN:
      result := ObjectIsGuardian;
    COMBATLOG_OBJECT_TYPE_OBJECT:
      result := ObjectIsObject;
  else
    result := ObjectIsNil
  end
end;

function isEventOnFocus(p: pEvent; Exclusivemode: boolean;
  focusType: sfocusType): boolean;
begin
  if Exclusivemode then
    result := isUnitOnFocus(p.sourceUnit) and isUnitOnFocus(p.destUnit)
  else
  begin
    case focusType of
      focusIsDest:
        result := isUnitOnFocus(p.destUnit);
      focusIsSource:
        result := isUnitOnFocus(p.sourceUnit);
    else
      result := isUnitOnFocus(p.sourceUnit) or isUnitOnFocus(p.destUnit);
    end;
  end;
end;

function isUnitOnFocus(u: tUnitData): boolean;
begin
  result := assigned(u) and (upUnitRef in u.params);
end;

function getPowerType(s: integer): integer;
begin
  case s of
    - 2:
      result := 1;
    0 .. 15:
      result := s + 2;
  else
    result := 0; // inconnu
  end;
end;

function CheckLegitSpellIdEx(id: integer): boolean;
begin
  result := (id > 6) and (id < SECUNDARY_SPELL_INDEX);
end;

function CheckLegitSpellId(sp:tspellinfo): boolean;
begin
  result := CheckLegitSpellIdEx(sp.id)
end;

function assignSpellData(id: integer; strtmp: string; ep: eventParams;  s: integer; assignData: boolean):tspellInfo;
var index: integer;
begin
  // stats
  if (SpellIdMax < id) and (id< SECUNDARY_SPELL_INDEX )then
    SpellIdMax := id;
  dummySpellInfo.id := id;
  if not FastListSearch(spellArray, compareSpellID, dummySpellInfo, index) then
  begin
    result := tSpellInfo.initData(id, 1, strtmp, emptySpellParam);
    spellArray.Insert(index, result);
  end
  else
  begin
    result:=spellArray[index];
    if result.count = 0 then result.name := CleanString(strtmp);
    inc(result.count);
  end;

  if assignData and not (id in [0,6]) then
  begin
    // securité
    if s > high(smallint) then s := 0;
    result.school := result.school or s;
  end;
end;

function getEventName(id: integer): string;
begin
  if (id < 0) or (id > high(eventValue)) then
    result := 'event:' + inttostr(id)
  else
    result := trim(eventValue[id].name);
end;

// ----------Filter
procedure setSpellFilter(id, index: integer; filter: boolean);
begin
   getSpellFromID(id).filtered[index] := filter;
end;

procedure setEventFilter(id, index: integer; filter: boolean);
begin
  if (id >= 0) and (id < eventtypelist.count) then
    tEventType(eventtypelist.items[id]).filtered[index] := filter;
end;

function getSpellDefaultFilter(id: integer): boolean;
begin
  result := false;
  if high(currentfilter) >= 0 then
    result := currentfilter[0].default and currentfilter[0].isSpellValid and getSpellFilterEx(id, 0);
end;

function getSpellFilter(id: integer): boolean;
var
  i: integer;
begin
  result:= high(currentfilter) = -1;
  for i := 0 to high(currentfilter) do
  begin
    result := getSpellFilterEx(id, i);
    if result then
      exit;
  end;
end;

function getSpellFilterEx(id, index: integer): boolean;
begin
  if id = -1 then
    result := false
  else
    result:= getSpellFromID(id).filtered[index];
end;

function getFilterLabel: string;
begin
  result := '<b>No Default Filter</b>';
  if high(currentfilter) >= 0 then
    if currentfilter[0].default then
      result := currentfilter[0].extracttext(true);

end;

// ----------readingSpell
function getSpellFromID(id:integer): tspellInfo;
var index: integer;
begin
  dummySpellInfo.id := id;
  if FastListSearch(spellArray, compareSpellID, dummySpellInfo, index) then
    result := spellArray[index]
  else
    result := spellArray[0];
end;

function getSpellName(p: pEvent; addtag: boolean = false): string;
begin
  result := p.spell.name;
  if addtag then
    result := bracket_string(result);
end;

function getSpellName(id: integer; addtag: boolean = false): string;
begin
  result := getSpellFromID(id).name;
  if addtag then
    result := bracket_string(result);
end;

function getSpellDatas(sp:tspellInfo): spelldatas;
begin
  if assigned(sp) then
    result := sp.sData
  else
    result := [];
end;

function getSpellSchool(id: integer): smallint;
begin
 result:=getSpellFromID(id).school;
end;

procedure setSpellDatas(sp: tspellInfo; s: spelldatas);
begin
  if assigned(sp) then  sp.sData := s;
end;

function SpellSingleAura(sp:tspellinfo): boolean;
begin
  if assigned(sp) then
    result := (spellCanHaveNoSource in sp.sData) or
      (spellisSingleAura in sp.constantParams.option2)
  else
    result := false;
end;

function getSpellParams(sp: tspellInfo): rConstantSpellParams;
begin
  if assigned(sp) then
    result := sp.constantParams
  else
    result := emptySpellParam;
end;

procedure setSpellParams(id: integer; r: rConstantSpellParams);
begin
    getSpellFromID(id).constantParams := r;
end;

function incSpellStats(id: integer): boolean;
var sp: tspellInfo;
begin
  sp := getSpellFromID(id);
  if assigned(sp) then
  begin
    inc(sp.statcount);
    result := true;
  end
  else
    result := false;
end;

procedure FinalizeUnitAffiliation;
var
  i, j: integer;
  u: tUnitInfo;
  ul: tUnitData;
begin
  for i := 0 to unitList.count - 1 do
  begin
    u := unitList.items[i];
    // on assigne tous les pets identiques au meme joueur
    if (u.unitType = unitIsPet) and assigned(u.UnitAffiliation) then
    begin
      for j := 0 to u.list.count - 1 do
        tUnitData(u.list.items[j]).UnitAffiliation := u.UnitAffiliation;
    end;
    // effacement des raid -> hostiles
    for j := 0 to u.list.count - 1 do
    begin
      ul := u.list.items[j];
      if assigned(ul.UnitAffiliation) then
        if (upWasFriend in tUnitData(ul.UnitAffiliation).params) and
          (upWasNpcVsRaid in ul.params) then
          ul.UnitAffiliation := nil;
    end;
    // effacement des affiliations interdites
    if (uoDontMakePlayerAffiliation in u.constantParams.option1) then
    begin
      for j := 0 to u.list.count - 1 do
      begin
        ul := u.list.items[j];
        if assigned(ul.UnitAffiliation) then
          if tUnitData(ul.UnitAffiliation).uGUID.unitType = unitIsPlayer then
            ul.UnitAffiliation := nil;
      end
    end;
    // effacement des affiliations "no-players"
    for j := 0 to u.list.count - 1 do
    begin
      ul := u.list.items[j];
      if assigned(ul.UnitAffiliation) and
        (tUnitData(ul.UnitAffiliation).uGUID.unitType <> unitIsPlayer) then
        ul.UnitAffiliation := nil;
    end
  end;
end;

function getMissString(id: integer; strAppend: string;
  allow: boolean = true): string;
begin
  if allow then
  begin
    result := CharMissType[id];
    if result <> '' then
      result := result + strAppend;
  end
  else
    result := '';
end;

function getSpecialString(id: integer; strAppend: string;
  allow: boolean = true): string;
begin
  if allow then
  begin
    result := CharSpecialHit[id];
    if result <> '' then
      result := result + strAppend;
  end
  else
    result := '';
end;

// -----------------
// direct fast access to extraspellid
function pEvent.GetExtraSpellId: integer;
begin
  case event of
    event_SPELL_DISPEL:
      result := statsarray[0];
    event_SPELL_AURA_BROKEN:
      result := statsarray[0];
    event_SPELL_AURA_BROKEN_SPELL:
      result := statsarray[0];
    event_SPELL_INTERRUPT:
      result := statsarray[0];
    event_SPELL_STOLEN:
      result := statsarray[0];
  else
    result := -1;
  end;
end;

function pEvent.eventstat: rEventStat;
begin
  fillchar(result, sizeof(result), 0);
  case event of
    event_SPELL_DAMAGE:
      readEventstat_SPELL_DAMAGE(result);
    event_SWING_DAMAGE:
      readEventstat_SWING_DAMAGE(result);
    event_SWING_MISSED:
      readEventstat_SWING_MISSED(result);
    // event_SPELL_CAST_SUCCESS:readEventstat_SPELL_NOPARAM(result);
    event_SPELL_HEAL:
      readEventstat_SPELL_HEAL(result);
    event_SPELL_MISSED:
      readEventstat_SPELL_MISSED(result);
    event_SPELL_PERIODIC_HEAL:
      readEventstat_SPELL_HEAL(result);
    event_SPELL_AURA_APPLIED:
      readEventstat_SPELL_AURA_APPLIED(result);
    event_SPELL_AURA_REFRESH:
      readEventstat_SPELL_AURA_APPLIED(result);
    event_SPELL_AURA_REMOVED:
      readEventstat_SPELL_AURA_APPLIED(result);
    event_RANGE_DAMAGE:
      readEventstat_SPELL_DAMAGE(result);
    event_SPELL_PERIODIC_DAMAGE:
      readEventstat_SPELL_DAMAGE(result);
    event_SPELL_PERIODIC_ENERGIZE:
      readEventstat_SPELL_ENERGIZE(result);
    event_SPELL_ENERGIZE:
      readEventstat_SPELL_ENERGIZE(result);
    event_RANGE_MISSED:
      readEventstat_SPELL_MISSED(result);
    event_SPELL_PERIODIC_MISSED:
      readEventstat_SPELL_MISSED(result);
    event_SPELL_DISPEL:
      readEventstat_AURA_BROKEN(result);
    event_SPELL_AURA_REMOVED_DOSE:
      readEventstat_SPELL_AURA_APPLIED_DOSE(result);
    event_SPELL_AURA_APPLIED_DOSE:
      readEventstat_SPELL_AURA_APPLIED_DOSE(result);
    event_SPELL_AURA_BROKEN:
      readEventstat_AURA_BROKEN(result);
    event_SPELL_AURA_BROKEN_SPELL:
      readEventstat_AURA_BROKEN(result);
    event_ENVIRONMENTAL_DAMAGE:
      readEventstat_ENVIRONMENTAL_DAMAGE(result);
    // event_UNIT_DIED;
    // event_SPELL_EXTRA_ATTACKS:readEventstat_SPELL_NOPARAM(result);//---tmp
    event_SPELL_AURA_DISPELLED:
      readEventstat_AURA_BROKEN(result);
    event_SPELL_DRAIN:
      readEventstat_SPELL_DRAIN(result);
    event_SPELL_PERIODIC_DRAIN:
      readEventstat_SPELL_DRAIN(result);
    event_SPELL_LEECH:
      readEventstat_SPELL_DRAIN(result);
    event_SPELL_PERIODIC_LEECH:
      readEventstat_SPELL_DRAIN(result);
    event_SPELL_INTERRUPT:
      readEventstat_AURA_BROKEN(result);
    event_DAMAGE_SHIELD:
      readEventstat_SPELL_DAMAGE(result);
    event_DAMAGE_SHIELD_MISSED:
      readEventstat_SPELL_MISSED(result);
    event_SPELL_DISPEL_FAILED:
      readEventstat_AURA_BROKEN(result);
    // event_SPELL_DURABILITY_DAMAGE:readEventstat_SPELL_NOPARAM(result);
    // event_SPELL_DURABILITY_DAMAGE_ALL:readEventstat_SPELL_NOPARAM(result);
    // event_SPELL_CREATE:readEventstat_SPELL_NOPARAM(result);
    // event_SPELL_SUMMON:readEventstat_SPELL_NOPARAM(result);
    // event_UNIT_DESTROYED;
    // event_SPELL_INSTAKILL:readEventstat_SPELL_NOPARAM(result);
    // event_ENCHANT_APPLIED;
    // event_ENCHANT_REMOVED;
    event_SPELL_AURA_STOLEN:
      readEventstat_AURA_BROKEN(result);
    event_DAMAGE_SPLIT:
      readEventstat_SPELL_DAMAGE(result);
    // event_SPELL_RESURRECT:readEventstat_SPELL_NOPARAM(result);
    // event_PARTY_KILL;
    event_SPELL_STOLEN:
      readEventstat_AURA_BROKEN(result);
    event_SPELL_BUILDING_DAMAGE:
      readEventstat_SPELL_DAMAGE(result);
    event_SPELL_CAST_START:
      readEventstat_SPELL_CAST_START(result);
    event_ENCOUNTER_START:
      readEventstat_ENCOUNTER_START(result);
    event_ENCOUNTER_STOP:
      readEventstat_ENCOUNTER_STOP(result);
    event_SPELL_ABSORBED:
      readEventstat_SPELL_ABSORBED(result);
    // event_SWING_DAMAGE_LANDED:readEventstat_SWING_DAMAGE(result);
    // event_UNKNOWN;
  end
end;

Procedure pEvent.readEventstat_ENCOUNTER_START(var eventstat: rEventStat);
begin
  eventstat.bossID := statsarray[0];
  eventstat.bossDiff := statsarray[1];
  eventstat.BossPlayers := statsarray[2];
end;

Procedure pEvent.readEventstat_ENCOUNTER_STOP(var eventstat: rEventStat);
begin
  eventstat.bossID := statsarray[0];
  eventstat.bossDiff := statsarray[1];
  eventstat.BossPlayers := statsarray[2];
  eventstat.bossdown := statsarray[3];
end;

Procedure pEvent.readEventstat_AURA_BROKEN(var eventstat: rEventStat);
begin
  eventstat.extraspellId := statsarray[0];
end;

Procedure pEvent.readEventstat_SPELL_AURA_APPLIED(var eventstat: rEventStat);
begin
  eventstat.rawAbsorbPool := statsarray[0];
  eventstat.absorbpool := statsarray[1];
  eventstat.extraspellId := statsarray[2];
  eventstat.guessedAbsorb := statsarray[4];
end;

Procedure pEvent.readEventstat_SPELL_ENERGIZE(var eventstat: rEventStat);
begin
  eventstat.amountGeneric := statsarray[0];
  eventstat.powertype := statsarray[1];
  if eventstat.powertype = 1 then
    eventstat.amountHeal := statsarray[0];
end;

Procedure pEvent.readEventstat_SPELL_DRAIN(var eventstat: rEventStat);
begin
  eventstat.amountGeneric := statsarray[0];
  eventstat.powertype := statsarray[1];
  eventstat.amountExtra := statsarray[2];
end;

Procedure pEvent.readEventstat_SPELL_AURA_APPLIED_DOSE
  (var eventstat: rEventStat);
begin
  eventstat.amountGeneric := statsarray[0];
end;

Procedure pEvent.readEventstat_ENVIRONMENTAL_DAMAGE(var eventstat: rEventStat);
begin
  eventstat.amountGeneric := statsarray[0];
end;

Procedure pEvent.readEventstat_SWING_DAMAGE(var eventstat: rEventStat);
begin
  eventstat.amountGeneric := statsarray[0];
  eventstat.resist := statsarray[1];
  eventstat.block := statsarray[2];
  eventstat.absorb := statsarray[3];
  eventstat.amountOverKill := statsarray[4]; // overdamage
end;

Procedure pEvent.readEventstat_SWING_MISSED(var eventstat: rEventStat);
begin
  eventstat.miss := byte(statsarray[0]);
  case eventstat.miss of
    1:
      eventstat.absorb := statsarray[1];
    2:
      eventstat.block := statsarray[1];
    10:
      eventstat.resist := statsarray[1];
  end;
end;

Procedure pEvent.readEventstat_SPELL_DAMAGE(var eventstat: rEventStat);
begin
  eventstat.amountGeneric := statsarray[0];
  eventstat.resist := statsarray[1];
  eventstat.block := statsarray[2];
  eventstat.absorb := statsarray[3];
  eventstat.amountOverKill := statsarray[4]; // overkill
end;

Procedure pEvent.readEventstat_SPELL_MISSED(var eventstat: rEventStat);
begin
  eventstat.miss := byte(statsarray[0]);
  case eventstat.miss of
    1:
      eventstat.absorb := statsarray[1];
    2:
      eventstat.block := statsarray[1];
    10:
      eventstat.resist := statsarray[1];
  end;
end;

Procedure pEvent.readEventstat_SPELL_HEAL(var eventstat: rEventStat);
begin
  eventstat.amountGeneric := statsarray[0];
  eventstat.amountHeal := statsarray[0];
  eventstat.amountOverHeal := statsarray[1];
  // 3.2 absorb in heal
  eventstat.absorb := statsarray[2];
end;

Procedure pEvent.readEventstat_SPELL_ABSORBED(var eventstat: rEventStat);
begin
  eventstat.fixedAbsorb := statsarray[0];
  eventstat.extraspellId := statsarray[1];
end;

Procedure pEvent.readEventstat_SPELL_CAST_START(var eventstat:rEventStat);
begin
  eventstat.castEndTime := statsarray[0];
  eventstat.castInterruptTime := statsarray[1];
end;



//------------------------------------------------------------------------------------------------------------
//--------Fast Search
//------------------------------------------------------------------------------------------------------------

function addPointertoSortedList(List: TList; Compare: TListSortCompare; p: pointer): boolean;
var index: integer;
begin
  result := false;
  if not FastListSearch(List, Compare, p, index) then
  begin
    List.Insert(index, p);
    result := true
  end;
end;


function getlowestID(List: TList; Compare: TListSortCompare; p: pointer; startID: integer): integer;
begin
  result := startID;
  dec(startID);
  while (startID >= 0) do
  begin
    if (Compare(List[startID], p) = 0) then
      result := startID
    else
      exit;
    dec(startID);
  end;
end;

function getHighestID(List: TList; Compare: TListSortCompare; p: pointer; startID: integer): integer;
begin
  result := startID;
  inc(startID);
  while (startID < List.count) do
  begin
    if (Compare(List[startID], p) = 0) then
      result := startID
    else
      exit;
    inc(startID);
  end;
end;


// fastListsearch,
function FastListSearch(List: TList; Compare: TListSortCompare; p: pointer; var newindex: integer; GetHiLoID: integer = 0): boolean;
var
  i, l, h: integer;
  c: integer;
begin
  result := false;
  l := 0;
  h := List.count - 1;
  while (l <= h) do
  begin
    i := (l + h) shr 1;
    c := Compare(List[i], p);
    if c < 0 then
      l := i + 1
    else
    begin
      h := i - 1;
      if c = 0 then
      begin
        l := i;
        if GetHiLoID < 0 then l := getlowestID(List, Compare, p, l)
        else if GetHiLoID > 0 then l := gethighestID(List, Compare, p, l);
        result := true;
        break;
      end;
    end;
  end;
  newindex := l;
end;


function compareSpellID(p1, p2: pointer): integer;
begin
  result := tSpellInfo(p1).id - tSpellInfo(p2).id;
end;

//FastListSearch(eventlist,compareEventTime, dummypEvent, index, true)

function compareEventTime(p1, p2: pointer): integer;
begin
  result := pEvent(p1).time - pEvent(p2).time;
end;

end.
