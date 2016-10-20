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

unit wcr_Const;

interface

{$I _config.inc}

uses SysUtils;

type

tIntToString= function (i:int64):string;
function inttostrShort(i:int64):string;
function inttostrFull(i:int64):string;


type

rPrefs = record
  liveupdatetimer:integer;
  maxeventinlist:integer;
  InterfaceScale:integer;
  ResizeStats:boolean;
  NoSpellFailed:boolean;
  useShortNumber:boolean;
  CapOverkill:boolean;
  openOnIndex:boolean;
  OpenLineWin:boolean;
  useCache:boolean;
  sortunitmode:integer;
  defaultindexsize:integer;
  WebLink:string;
  UnitWebLink:string;
  ArmoryLink:string;
  DefaultServerName:string;
  livelogpath:string;
  unknownlabel:string;
end;

var
  ICO32_BASEOFFESET:integer;
  CURRENT_BASE_SIZE:integer;
  BASE_TAI_A:integer;
  BASE_TAI_B:integer;
  GRAPH_OFFSET:integer;
  UNIT_SPACE_LINE:integer;
  RATIO_DIVIDER:integer;
  LIST_NAME_POS:integer;
  FOCUSED_NAME_POS:integer;
  FOCUSED_UNIT_SPACE_LINE:integer;
  FOCUSED_RATIO_DIVIDER :integer;
  FOCUSED_EVENT_RECEIVED_LINE:integer;
  FOCUSED_AURA_BASEOFFSET :integer;
  FOCUSED_AURA_LINE:integer;
  FONT_SIZE:integer;
  FONT_SIZE_MIN:integer;
  MARGE_CHAT_DEFAULT:integer;
  MARGE_HAUT, MARGE_RAID_BACK , MARGE_RAID,MARGE_CHAT, MARGE_NAME  :integer;
  prefs:rPrefs;
  DATETIME_YEAR:Word;
  ERRORCHECKPOINT: cardinal;
  intToStrEx:tIntToString = inttostrShort;
  AuthUse52Log:boolean = false;
  AuthUse54Log:boolean = false;
  CURRENTPOWER :integer = 0;
  CURRENTDATATYPE :integer = 5;
  UNKNOWNNAME: string = 'Unknown';
  REPLAY_DRAWATTACK: boolean = false;
  REPLAY_DRAWPLAYERCIRCLE: boolean = false;
  {$IFDEF DEBUG}
  maxPowerValue: integer = 0;
  debugError:  integer = 0;
  DRAWDEBUGREFRESH: boolean = false;
  crawlCount: integer = 0;
  {$ENDIF}

Const
  COPYRIGHT_1 = 'WowCardioRaid © 2008-2015 - tixu.scribe@gmail.com';
  COPYRIGHT_2 = '<b>[ <a href="http://tixu.scribe.free.fr/indexen.php">WebSite</a> ][ <a href="http://tixu.scribe.free.fr/en_dons.php">Donate</a> ]</b>';

  PROG_VERS = 'WowCardioRaid for Wow 6.0.3+ (WoD) | v1.2Beta4';

  WOW_REGISTRY_MAINPATH ='\SOFTWARE\Blizzard Entertainment\World of Warcraft\';
  WOW_REGISTRY_INSTALLPATH = 'InstallPath';

  MAX_HP_ARRAY_ROW = 7200;
  SECUNDARY_SPELL_INDEX = $10000000;
  MAX_NPC_ARRAY_ROW = $1ffff;
  UNIT_IS_NIL_NAME = 'Nil';
  UNIT_HEADER_LABEL='Unit:';
  WOW_APPLICATION = 'wow.exe';

  MAIN_FONT = 'Arial';

  SKIP_SPELL_SAVE = false;

  //-----replay const
  REPLAY_CRAWLTIME = 3000; //30sec
  REPLAY_FRAMESTEP = 10;
  REPLAY_UNITSIZE = 5;
  REPLAY_UNITSIZE_DETECT = REPLAY_UNITSIZE + 3;

  NBMAX_FILTER = 5;
  DEFAULTFILTERNAME = 'DefautFilter';
  CUSTOMFILTERNAME = 'CustomFilter';
  ERROR_SAVEFILTER = 'Enchants and Environnement spells can''t be saved in custom filter'; 
  FILTERNAMEREQUEST = 'Enter filter name';
  BROWSEFORCOMBATLOG = 'Select the live wowcombatlog.txt folder';
  REQUESTMAINTITLE = 'Enter WebLink';
  SERVERNAMEREQUEST = 'Enter your default server name';
  ARMORYLINKREQUEST = 'Armory Link (%s=server %n=playerName)';
  UNITWEBLINKREQUEST = 'NPC Base Web link (use%u as UnitID)';
  SPELLWEBLINKREQUEST ='Spell base Web Link (use %s for spellID)';

  UNITNAMESERVEURSEPARATOR = '-';

  //WCR file format proprietaire
  WCRFILE_HEADERV1:cardinal  = $01524357;//01= id de version, 524357 = 'WCR'
  //WCR with preview content part
  WCRFILE_HEADERV2:cardinal  = $02524357;//02= id de version, 524357 = 'WCR'
  WCRFILE_HEADERV3:cardinal  = $03524357;//03= id de version, 524357 = 'WCR'
  WCRFILE_HEADERV4:cardinal  = $04524357;//04= id de version, 524357 = 'WCR'
  WCRFILE_HEADERV5:cardinal  = $05524357;//05= id de version, 524357 = 'WCR'
  //WCR actual
  WCRFILE_HEADER:cardinal  = $06524357;//06= id de version, 524357 = 'WCR'

  WCRFILE_SUFFIX = '.wcr';
  LUAFILE_SUFFIX = '.lua';
  WCRFILE_TIMEBORDER = 9000;
  //WCRFILE_TIMEBORDER = 0;
  MAXREADERROR =10;


  STREAMBUFFER = 1024*1024*10; //10mo
  MAXFILESIZEEXIT = 1024*1024*800; //800mo
  MAXFILESIZEALERT = 1024*1024*350; //350mo

  APPLICATIONREFRESH = 20000; //must be a multiple of  PROGRESSBARREFRESHTIMER
  PROGRESSBARREDIVIDER = 25;
  REFRESHPARSEFREQ = STREAMBUFFER div 5;
  CUSTOM_SELECTION_LABEL = 'CustomSelection';
  EMPTYBOSSSTRING = '0000000';

  COMPARETOOLTIP='Compare dps tool';

  //Hint timer
  HINT_DELAY = 200;
  //palier zoom
  ZOOM_PALIER_1 = 8;
  ZOOM_PALIER_2 = 25;
  ZOOM_PALIER_3 = 40;
  ZOOM_PALIER_4 = 100;

  MOUSEWHEELSCROLLRATIO =1;
  GAUGEBASERATIO = 10000;
  MAXEXPORTEVENT=250;
  MAXPOSTHRESHOLD= 4*3 * 20000;

  MINIMUMCASTTIME = 500;
  DEFAULT_NPC_COLOR = $555555;

  HMTAG: array [0..1] of integer =($00FF9999,$006655BB);

  BASE_HP_FEEDBACK_INTERVAL = 25;
  HP_INTERVAL = 100 div BASE_HP_FEEDBACK_INTERVAL;
  DEMI_HP_INTERVAL = (HP_INTERVAL div 2);
  DOUBLE_HP_INTERVAL = HP_INTERVAL *2;
  USE_SMOOTH_LINE = false;

  TRASH_STRING='Trash-mobs';
  MAX_LEGENDE_LENGTH = 100;
  IMAGEZOOM_MIN = 2;
  IMAGEZOOM_MAX = 100;

  TOOLTIP_HIDEPAUSE = 30000;
  MAX_CENTI_SECOND = 8639999;

  PARAMSEPARATOR = '|';
  MARGE_NAME_DEFAULT = 120;
  //MARGE_NAME = 250;
  MARGE_HAUT_DEFAULTMIN = 20;
  MARGE_HAUT_DEFAULTMAX =35;
  MARGE_RAID_DEFAULT = 40;

  GRID_BASE_INTERVAL = 40;
  CHECKPOINT_SPACE =50;
  XINDEXTHRESHOLD=2;
  INDEXCHACHEFILE = 'logCache.ini';
  transcriptorHeaderFile = 'TranscriptorData.txt';
  LOGINDEXNAME = '_wcrindex.htm';
  FILE_ICO32 = 'ico32.bmp';
  SIZE_ICO32 = 16;
  READ_ME='Home.htm';
  HTM_HEADER = 'htmlheader.tpl';
  SAMPLE_LOG='samplelog.txt';
  NO_SPELL_LABEL='!NoSpellAction';
  SWING_LABEL='!Melee';
  NPC_OPTION_LIST='NPCParams.bin';
  SPELL_OPTION_LIST='SpellParams.bin';
  NAMEANONYMISER = 'NameAnonymiser.txt';
  PREFS_FIC = 'Prefs.ini';
  RES_TIP_FIC = 'res.txt';
  PREFS_FIC_DEFAULT ='PrefsDefault.ini';
  HINT_TEMPLATE='hint.tpl';
  HINT_STATS_TEMPLATE='hintstats.tpl';
  HINT_STATS_DTEMPLATE='hintdetailledstats.tpl';
  HINT_CHAT_TEMPLATE='hintchat.tpl';

  Html_Stats_Template ='Html_Stats_Template.tpl';
  HTML_TEMPLATE_INDEX ='Html_Template_Index.tpl';
  HTML_TEMPLATE_MENU ='Html_Template_Menu.tpl';
  HTML_TEMPLATE_HEAL='Html_Template_Heal.tpl';
  HTML_TEMPLATE_DAMAGES='Html_Template_Damages.tpl';
  HTML_TEMPLATE_AURA='Html_Template_Aura.tpl';
  HINT_STATS_DTEMPLATE_STRING = 'hintDetailledStatsContent.tpl';
  ERROR_STRING='[Error]';

  ENTER_COMMENT='<Enter comment here (Optional)>';
  //---------------

  FILE_SPECIALSUMMON = 'SummonTracking.cfg';
  FILE_DONJON = 'Dungeondatas.txt';
  WAITING_FOR_DATA = 'Waiting for datas...';
  OOCTHRESHOLD=7000;//70secondes
  AFTERDEATHTHRESHOLDLOW =6000;//60sec
  AFTERDEATHTHRESHOLD=36000;//6mn
  AURAREMOVEDINTERVAL=5;//100eme de secondes
  AURAREMOVEDTHRESHOLD=7;
  OOCBLOCKTHRESHOLD=2500;//35 secondes
  LOWACTION_THRESHOLD=2;//1 action
  LOWACTION_TIMETHRESHOLD=1500;//15secondes
  NOCTHRESHOLD=500;//5secondes
  BIGRAIDNUMBERMIN=10;

  NA_STRING='';
  MARGE_REPERE = 50;
  MAX_DAY_LIMITE = 100;
  ICON_ERROR = 'error, can''load icons';
  ACTIVITY_THRESHOLD = 600;
  MAX_ITEM_IN_LIST=50000;
  //Filtered Max ID
  FILTERMAXID=$ff;
  MAX_OVER_KILLVALUE = 5000;
  OVER_KILL_THRESHOLD= 400;

  type
  eINFOPOWERdata = record
    name:string;
    color:cardinal;
    ratio:integer;
    divider: integer;
  end;

  const
  powerTypeparam: array [0..17] of string = (
      '',
      'Health',
      'Mana',
      'Rage',
      'Focus',
      'Energy',
      'Combo',
      'Runes',
      'Runic',
      'Soulshard',
      'Eclipse',
      'Holy',
      'Misc',
      'id_11',
      'Chi',
      'Shadow Orbs',
      'Burning Ember',
      'Soulshard'
  );


  eINFOPOWER:array[0..16] of eINFOPOWERdata= (
                          (name:'UseALL'; color:$ff5555ff; ratio:1; divider: 1),
                          (name:'Mana'; color:$ff5555ff; ratio:1; divider: 1),
                          (name:'Rage'; color:$ffff5555; ratio:10; divider: 100),
                          (name:'Focus'; color:$ff55ffff; ratio:100; divider: 100),
                          (name:'Energy'; color:$ffffff55; ratio:100; divider: 100),
                          (name:'Combo'; color:$ff5555ff; ratio:100; divider: 100),
                          (name:'Runes'; color:$ff5555ff; ratio:100; divider: 100),
                          (name:'Runic power'; color:$ffff5555; ratio:10; divider: 100),
                          (name:'Soulshard?'; color:$ff5555ff; ratio:1000; divider: 1000),
                          (name:'Eclipse'; color:$ff5555ff; ratio:100; divider: 100),
                          (name:'Holy'; color:$ffff55ff; ratio:1000; divider: 1000),
                          (name:'Misc'; color:$ffffffff; ratio:1000; divider: 1000),
                          (name:'NotDefined11'; color:$ff5555ff; ratio:1; divider: 1),
                          (name:'Chi'; color:$ff55ff55; ratio:1000; divider: 1000),
                          (name:'Shadow Orbs'; color:$ffDD55CC; ratio:1000; divider: 1000),
                          (name:'Burning Ember'; color:$ffffCC55; ratio:10; divider: 10),
                          (name:'Soulshard'; color:$ffff55ff; ratio:1000; divider: 1000));


  eDATAFEED:  array[2..5] of String =('AttackPower','SpellPower','PowerType','MainPower') ;


  FOCUSED_ARRAYLINE_COLOR: array[1..7] of cardinal =($ff884422,$ff225522,$ff884422,$ff229922,$ff224455,$ff22AA22,$ff5555ff);
  FOCUSED_ARRAYLINE_POSITION: array[1..7] of integer =(3,4,2,2,1,4,5);
  FOCUSED_LABEL: array[1..5] of String =('Hp+Inc Events','Dps+Hps In','Dps Out','Hps+EffectHps Out','Misc');
  FOCUSED_EVENT_AURA_COLOR: array [0..1] of cardinal = ($FFCCEFFF, $FFDDAAFF);//buff debuff


  FOCUSED_EVENT_AURASELECTED_COLOR: array [0..1] of cardinal = ($66CCEFFF, $66DDAAFF);//buff debuff
  FOCUSED_EVENT_AURASELECTED_COLOR_BORDER: array [0..1] of cardinal = ($FFCCEFFF, $FFA346FF);//buff debuff

  AURA_COLOR_PREDEF: array[0..5] of cardinal = ($779999FF,$77FF9999, $7799FF99, $77FFFF99, $77FF99FF, $7799FFFF);



  RAID_ARRAYLINE_COLOR: array[1..8] of cardinal =($40884422,$40225522,$40AA44AA,$4022AA22,$ff884422,$ff225522,$ffAA44AA,$ff22AA22);
  RAID_ARRAYLINE_LABEL: array[1..8] of string =(' RaidDpsOut: ',' RaidHpsOut: ',' RaidDpsIn: ',' RaidEHpsOut: ',' RaidDpsOut: ',' RaidHpsOut: ',' RaidDpsIn: ',' RaidEHpsOut: ');

  UNITFOCUSCOLORGFX:array [0..1]  of cardinal=($33CCAA55, $3355AACC);
  UNITFOCUSCOLORTREE:array [0..1] of array [0..1]  of cardinal=(($0060c8Fc, $00Fcc860),
                                                                ($00C0EAFE, $00FEEAC0));
  //UNITFOCUSCOLORTREE2:array [0..1]  of cardinal=($00C0EAFE, $00FEEAC0);


  AURAFOCUSCOLOR:array [0..1]  of cardinal=($3355AACC, $99CCAA55);

  FORBIDDENFILECHAR:array [0..8] of char =   ('"', '/', '\', '*', '?', '<', '>', '|', ':');

  DEFAULT_INSTADPSINTERVAL =20; //(5secondes*4)
  MIN_INSTADPSINTERVAL = 4; //(1 secondes*4)
  MAX_INSTADPSINTERVAL = 60; //(15 secondes*4 )

  UNIT_NAME_ERROR = 'Nil';
  HP_MIN_NPC = 28;
  HP_MIN_PET = 6000;
  DEATH_HP = 986754232;
  REZ_LIFE_RATIO = 1.00;
  LAG_DELAY_TIME = 150;
  DEFAULTABSDURATION = 60; //(en sec
  ABSORBSEARCHTIME_BEFORE = 80;
  ABSORBSEARCHTIME_AFTER = 80;
  ABSORB_ERROR_THRESHOLD = 100;
  FD_LAG_DELAY_SEARCH = 150;//centiseconds
  FD_AURA_REMOVE_SEARCH = 5;
  TIMEERROR_LABEL = 'LOG TIMESTAMP ERROR: ';
  IGNORED_LABEL = ' events skipped';
  INGAMELOGNAME = 'WoWCombatLog.txt';
  DEFAULT_WOW_LOGS_DIR='Logs';
  //stats
  NB_GLOBAL_STAT  = 7;
  BUFF_STR = 'BUFF';
  DEBUFF_STR = 'DEBUFF';




  FOCUSEDMODE_IMAGE:array[0..4] of integer = (12,41,42,43,44);

  STATSCOLOR: array [1..NB_GLOBAL_STAT] of array[1..4] of cardinal =(
                ($00dd8888,$00bbbbbb,$00ebb8b8,$00bbbbbb),
                ($00396CD7,$00bbbbbb,$0088a7e7,$00bbbbbb),
                ($0099FFAA,$00bbbbbb,$00c2ffcc,$00bbbbbb),
                ($0086fec4,$00bbbbbb,$00b6fedc,$00bbbbbb),
                ($00CCFFAA,$00bbbbbb,$00e0ffcc,$00bbbbbb),
                ($0044a0da,$00bbbbbb,$008fc6e9,$00bbbbbb),
                ($00ffe5cc,$00bbbbbb,$00ffefe0,$00bbbbbb));

  STAT_AUTH_AFF:array[1..NB_GLOBAL_STAT] of boolean = (true,false, true, true, false, false, true);
  STAT_ARRAY_INDEX:array[1..3] of integer = (2,2,1);
  STAT_DSP_LABEL:array [0..1] of string = ('Dps','Act.dps');

  ARRAYLINE_COLOR: array[0..2] of cardinal =($ff224455,$ff884422,$ff225522);
  watchedEvent_STRING: array[1..5] of String =('Dispels (buff)','Dispels (debuff)','Interrupts','Spells Stolen','Aura/CC break');

{
0 - world.
1 - 5-player.
2 - 5-player Heroic.
3 - 10-player Raid.
4 - 25-player Raid.
5 - 10-player Heroic Raid.
6 - 25-player Heroic Raid.
7 - Raid Finder  LFR.
8 - Challenge Mode 5.
9 - 40-player Raid .
10 - n/a.
11 - Heroic Scenario .
12 - Scenario .
13 - n/a.
14 - Flexible Raid. flex
}






type
  rClasseStat = record
      name:string;
      //5.2 power data
      dFeed: array[0..3] of integer;
     //--------
      shortname:string;
      color:cardinal;
      htmlcolor:string;
      hp,hpMax:integer;
      canTank, canHeal, canFD: boolean;
  end;

  rSchoolParams = record
      name,name2:string;
      color:cardinal;
      ingameHex:smallint;
  end;

  rGridbase = record
    maxdps,interval:integer;
  end;

  rLiveTiming = record
    Name:string;
    Timer:Cardinal;
  end;

  linearraytype =(lineHp, lineDps, lineHeal);
const

   LIVE_TIMER:array [1..8] of rLiveTiming =
   (
      (Name: '30s'; Timer: 30000),
      (Name: '1mn'; Timer: 60000),
      (Name: '2mn'; Timer: 120000),
      (Name: '5mn'; Timer: 300000),
      (Name: '10mn'; Timer: 600000),
      (Name: '15mn'; Timer: 900000),
      (Name: '20mn'; Timer: 1200000),
      (Name: '30mn'; Timer: 1800000)
   );

  ARRAYGRID_BASE_RATIO: array [0..10] of rGridbase =
  (
    (maxdps: 150000 ; interval: 15000),
    (maxdps: 90000 ; interval: 10000),
    (maxdps: 60000 ; interval: 5000),
    (maxdps: 30000 ; interval: 2000),
    (maxdps: 10000 ; interval: 1000),
    (maxdps: 5000 ; interval: 500),
    (maxdps: 1000 ; interval: 250),
    (maxdps: 500 ; interval: 100),
    (maxdps: 100 ; interval: 50),
    (maxdps: 50 ; interval: 25),
    (maxdps: 0 ; interval: 10)
  );

  ARRAYLINE_TYPESTRING: array[0..2] of String =('<b>Health</b> lines','Dps lines','Hps lines');
  ARRAYLINEFEEDBACK_TYPESTRING: array[0..2] of String =('Hp deficit: ','Dps: ','Hps: ');
  ARRAYLINEFEEDBACK_TYPESTRING52: array[0..2] of String =('Current Hp: ','Dps: ','Hps: ');


  ORDTAG: array[0..1] of string = ('','*');
  CRITTAG: array[0..1] of string = ('','(crit)');
  MStrikeTAG: array[0..1] of string = ('','(mstrike)');
  ORDCHECK: array[0..1] of string = ('','x');
  TANK_TAG = 'ϴ ';
  HEAL_TAG ='+ ';
  VEHICLE_TAG = '';//Ѻ
  UNIT_HP_TAG = ' (hp: %d)';
  OUT_EVENT_TAG = '◄ '; //replaytag
  INC_EVENT_TAG = '';//'► ';  //replaytag
  AURATAG = '► ';
  MINUNITCIRCLESIZE= 400;
  MAXUNITCIRCLESIZE= 3000;

  ROLE_VALUEREF: array [0..3] of integer = (1,2,3,1);
  ROLE_COLORREF: array [0..3] of cardinal = ($55ffEE22, $550055FF, $5555FF22, $55ffEE22);
  STATSWIDGETSIZEX=30;
  STATSWIDGETSIZEY=10;
  WIDGETSIZEX=30;
  HPWIDGETSIZEY=5;
  POWERWIDGETSIZEY=2;
  CASTWIDGETSIZEX=30;
  CASTWIDGETSIZEY=4;

  classePlayer: array[0..3] of string = (
      'none',
      'tank',
      'heal',
      'dps'
  );

  classeStat: array[0..11] of rClasseStat = (
      (name: 'Not Defined' ; dFeed:(-1,-1,-1,-1) ; shortname: ''; color: $00777777; htmlcolor:'#777777';  hp: 300000; hpmax:350000; canTank:true; canHeal:true),
      (name: 'Shaman' ; dFeed:(0,0,0,10) ; shortname: 'Shaman';  color: $00FF5924; htmlcolor:'#2459FF';  hp: 300000; hpmax:350000; canTank:false; canHeal:true),
      (name: 'Hunter' ; dFeed:(2,2,2,10) ; shortname: 'Hunter';  color: $0073d4ab; htmlcolor:'#abd473';  hp: 300000; hpmax:350000; canTank:false; canHeal:false;canFD:true),
      (name: 'DeathKnight' ; dFeed:(6,6,6,10) ; shortname: 'DK';  color: $000000ff; htmlcolor:'#ff0000';  hp: 300000; hpmax:550000; canTank:true; canHeal:false),
      (name: 'Warlock' ; dFeed:(0,7,14,10) ; shortname: 'Warlock';  color: $00ca8294; htmlcolor:'#9482ca';  hp: 300000; hpmax:350000; canTank:false; canHeal:false),
      (name: 'Druid' ; dFeed:(0,1,3,10) ; shortname: 'Druid';  color: $000a7dff;   htmlcolor:'#ff7d0a'; hp: 300000; hpmax:550000; canTank:true; canHeal:true),
      (name: 'Warrior' ; dFeed:(1,1,1,10) ; shortname: 'Warrior';  color: $006e9cc7; htmlcolor:'#c79c6e';  hp: 300000; hpmax:550000; canTank:true; canHeal:false),
      (name: 'Mage' ; dFeed:(0,0,0,10) ; shortname: 'Mage';  color: $00f0cc69; htmlcolor:'#69ccf0';  hp: 300000; hpmax:350000; canTank:false; canHeal:false),
      (name: 'Paladin' ; dFeed:(0,9,0,10) ; shortname: 'Paladin';  color: $00ba8cf5; htmlcolor:'#f58cba';  hp: 300000; hpmax:550000; canTank:true; canHeal:true),
      (name: 'Priest' ; dFeed:(0,13,0,10) ; shortname: 'Priest';  color: $00FFFFFF; htmlcolor:'#FFFFFF';  hp: 300000; hpmax:350000; canTank:false; canHeal:true),
      (name: 'Rogue' ; dFeed:(3,3,4,10) ; shortname: 'Rogue';  color: $0069f5ff; htmlcolor:'#fff569';  hp: 300000; hpmax:350000; canTank:false; canHeal:false),
      (name: 'Monk' ; dFeed:(3,12,0,10) ; shortname: 'Monk';  color: $00848A55; htmlcolor:'#558A84';  hp: 300000; hpmax:550000; canTank:true; canHeal:true)
  );

  spellSchoolParam: array [0..7] of rSchoolParams = (
      (name:'';name2:'NoSchool';color: $00000000; ingameHex:$00),
      (name:'Physical';name2:'Physical';color: $00677E81; ingameHex:$01),
      (name:'Holy';name2:'Holy';color: $0080e6ff; ingameHex:$02),
      (name:'Fire';name2:'Fire';color: $000080ff; ingameHex:$04),
      (name:'Nature';name2:'Nature';color: $0000BB00; ingameHex:$08),
      (name:'Frost';name2:'Frost';color: $00FFAC59; ingameHex:$10),
      (name:'Shadow';name2:'Shadow';color: $00ff8080; ingameHex:$20),
      (name:'Arcane'; name2:'Arcane';color: $00ff80ff; ingameHex:$40)
  );

  spellSchoolAbsorbParam: array [0..9] of string = (
      'NoSchool',
      'Physical',
      'Holy',
      'Fire',
      'Nature',
      'Frost',
      'Shadow',
      'Arcane',
      'Melee',
      'AllMagics'
  );


  Const ParsedTagStats:array[0..18] of string = (
                    '%STATS_UNITNAME%',
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
                    '%STATS_ACTIVEDPS%',
                    '%STATS_TOTALDPS%',
                    '%STATS_ACTIVEHPS%',
                    '%STATS_TOTALHPS%',
                    '%STATS_ACTIVEEHPS%',
                    '%STATS_TOTALEHPS%'
                    );
        ParsedTagEvents:array[0..14] of string = (
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
                    '%EVENT_SOURCETYPE%',
                    '%EVENT_DESTTYPE%',
                    '%EVENT_SPECIAL%'
                    );
        ParsedTagChat:array[0..0] of string = (
                    '%CHATLINES%'
                    );


        ParsedTagDetailledStats:array[0..1] of string = (
                    '%NAME%',
                    '%CONTENT%'
                    );

        htmltagIndex:array[0..11] of string =(
                    '%UNIT_COLOR%',//0
                    '%UNIT_NAME%',//1
                    '%MENU0%', //2
                    '%MENU1%',//3
                    '%MENU2%', //4
                    '%MENU3%', //5
                    '%MENU4%', //6
                    '%MENU5%', //7
                    '%MENU6%', //8
                    '%MENU7%', //9
                    '%MENU8%', //10
                    '%MENU9%' //10
                    );

        abstag: array [0..1] of string = ('','[abs] ');
        alttag: array [0..1] of string = ('','alt');
        HTML_BR = '<br>';
        HTML_NBSP= '&nbsp;';
        HTML_MINUS='&minus;';
type
  //unitstatree
  rstatcolumn = record
    text:string;
    size,tag:integer;
    fixed,left,sort,always:boolean;
  end;

const
  statcolumn_Damages:array[0..24] of rstatcolumn=(
    (text: '';size: 15; tag: 15; fixed: true; left: true; always: true),
    (text: 'spell';size: 50; tag: 14; fixed: true; left: true; always: true),
    (text: '';size: 3; tag: 0; fixed: true; always: true),
    (text: 'total';size: 55; tag: 19; sort: true),
    (text: 'f.fire';size: 55; tag: 57;),
    //(text: '#cast';size: 55; tag: 20;),
    (text: '';size: 3; tag: 0; always: true),
    (text: '#normal';size: 55; tag: 22),
    (text: '#crit';size: 55; tag: 23),
    (text: '#glan';size: 55; tag: 24),
    (text: 'avg';size: 30; tag: 21),
    (text: '';size: 3; tag: 0; always: true),
    (text: '#miss';size: 55; tag: 26 ),
    (text: '#parry';size: 55; tag: 28),
    (text: '#dodge';size: 55; tag: 29),
    (text: '#other';size: 55; tag: 27),
    (text: '';size: 3; tag: 0; always: true),
    (text: '#dot';size: 55; tag: 34),
    (text: '#d.crit';size: 55; tag: 35),
    (text: 'd.avg';size: 55; tag: 36),
    (text: '#d.miss';size: 55; tag: 37),
    (text: '';size: 3; tag: 0; always: true),
    (text: 'absorb';size: 55; tag: 30),
    (text: 'resist';size: 55; tag: 33),
    (text: '#bloc';size: 55; tag: 32),
    (text: 'bloc';size: 55; tag:31)
  );

   statcolumn_Heal:array[0..18] of rstatcolumn=(
    (text: '';size: 15; tag: 15; fixed: true; left: true; always: true),
    (text: 'Spell';size: 50; tag: 14; fixed: true; left: true; always: true),
    (text: '';size: 3; tag: 0; fixed: true; always: true),
    (text: 'Total';size: 55; tag: 45;sort: true),
    (text: 'Total(e)';size: 55; tag: 44 ),
    (text: 'vsNPC';size: 55; tag: 58;),
    (text: 'Est.Abs';size: 55; tag: 56;),
    (text: 'OH';size: 55; tag: 55; always: true),
    (text: '#normal';size: 20; tag: 46;),
    (text: '#crit';size: 55; tag: 49;),
    (text: 'Avg';size: 35; tag:48;),
    (text: 'Avg(e)';size: 55; tag:47;),
    (text: '';size: 3; tag: 0; always: true),
    (text: '#hot';size: 55; tag: 50),
    (text: '#hcrit';size: 55; tag: 53),
    (text: 'H.Avg';size: 55; tag: 52),
    (text: 'H.Avg(e)';size: 60; tag: 51),
    (text: '';size: 3; tag: 0; always: true),
    (text: 'Absorb';size: 55; tag: 54)
  );

  statcolumn_Buff:array[0..3] of rstatcolumn=(
    (text: '';size: 15; tag: 15; fixed: true; left: true; always: true),
    (text: 'Spell';size: 50; tag: 14; fixed: true; left: true; always: true),
    (text: '';size: 3; tag: 0; fixed: true; always: true),
    (text: '#';size: 55; tag: 41; sort: true)
  );

  statcolumn_Debuff:array[0..3] of rstatcolumn=(
    (text: '';size: 15; tag: 15; fixed: true; left: true; always: true),
    (text: 'Spell';size: 50; tag: 14; fixed: true; left: true;always: true),
    (text: '';size: 3; tag: 0; fixed: true; always: true),
    (text: '#';size: 55; tag: 42; sort: true)
  );

  statcolumn_Power:array[0..21] of rstatcolumn=(
    (text: '';size: 15; tag: 15; fixed: true; left: true; always: true),
    (text: 'Spell';size: 50; tag: 14; fixed: true; left: true; always: true),
    (text: '';size: 3; tag: 0; fixed: true; always: true),
    (text: '#';size: 55; tag: 59; sort: true),
    (text: 'None';size: 55; tag: 60),
    (text: 'Health' ;size: 55; tag: 61),
    (text: 'Mana';size: 55; tag: 62),
    (text: 'Rage';size: 55; tag: 63),
    (text: 'Focus';size: 55; tag: 64),
    (text: 'Energy';size: 55; tag: 65),
    (text: 'Combo';size: 55; tag: 66),
    (text: 'Runes';size: 55; tag: 67),
    (text: 'Runic ';size: 55; tag: 68),
    (text: 'Shard';size: 55; tag: 69),
    (text: 'Eclipse';size: 55; tag: 70),
    (text: 'Holy';size: 55; tag: 71),
    (text: 'Misc';size: 55; tag: 72),
    (text: 'id_11';size: 55; tag: 73),
    (text: 'Chi';size: 55; tag: 74),
    (text: 'Orbs';size: 55; tag: 75),
    (text: 'Ember';size: 55; tag: 76),
    (text: 'Shard?';size: 55; tag: 77)
  );

  statcolumn_Other:array[0..8] of rstatcolumn=(
    (text: '';size: 15; tag: 15; fixed: true; left: true; always: true),
    (text: 'Spell';size: 50; tag: 14; fixed: true; left: true; always: true),
    (text: '';size: 3; tag: 0; fixed: true; always: true),
    (text: '#';size: 55; tag: 90; sort: true),
    (text: 'Cast';size: 55; tag: 91; ),
    (text: 'Miss';size: 55; tag: 92; ),
    (text: 'Interrupt';size: 55; tag: 93; ),
    (text: 'Dispel';size: 55; tag: 94; ),
    (text: 'invoc';size: 55; tag: 95; )
  );

type

  rBaseSizeVar = record
    a,b,normalfont,smallfont,nameposmod :integer;
  end;



const
  BaseSizeVar: array [0..6] of rBaseSizeVar = (
    (a: 1; b: 1; normalfont: 8; smallfont:7; nameposmod:-1),
    (a: 1; b: 2; normalfont: 8; smallfont:7; nameposmod:2),
    (a: 2; b: 2; normalfont: 8; smallfont:7; nameposmod:4),
    (a: 2; b: 3; normalfont: 8; smallfont:7; nameposmod:8),
    (a: 3; b: 3; normalfont: 9; smallfont:8; nameposmod:11),
    (a: 3; b: 4; normalfont: 9; smallfont:8; nameposmod:14),
    (a: 4; b: 4; normalfont: 9; smallfont:8; nameposmod:17)
  );

procedure setBaseVar(newsize:integer);
procedure setdefaultprefs;
function use52Value(value, value52:integer):integer;overload;
function use52Value(value, value52:string):string;overload;

implementation

function use52Value(value, value52:integer):integer;overload;
begin
  if AuthUse52Log then
      result := value52
    else
      result := value;
end;

function use52Value(value, value52:string):string;overload;
begin
  if AuthUse52Log then
      result := value52
    else
      result := Value;
end;

function inttostrShort(i:int64):string;
begin
  if i>999999 then
  result:= format('%.2fM', [i /1000000])
  else if i>1000 then
  result:= format('%.1fk', [i /1000])
  else result:=inttostr(i);
end;

function inttostrFull(i:int64):string;
begin
    result:=inttostr(i);
end;

                     
procedure setdefaultprefs;
begin
  prefs.maxeventinlist:=MAX_ITEM_IN_LIST;
  prefs.liveupdatetimer:=2;
  prefs.OpenLineWin:=true;
  prefs.InterfaceScale:=2;
  prefs.openOnIndex:=false;
  prefs.livelogpath:='';
  prefs.ResizeStats:=true;
  prefs.NoSpellFailed:=true;
  prefs.CapOverkill:=true;
  prefs.sortunitmode:=2;
  prefs.defaultindexsize:=10;
  prefs.useCache:=true;
  prefs.useShortNumber:=true;
  intToStrEx:= inttostrShort;
  prefs.unknownlabel := UNKNOWNNAME;
end;

procedure setBaseVar(newsize:integer);
begin
  if newsize<0 then newsize :=0;;
  if newsize>high(BaseSizeVar) then newsize:=high(BaseSizeVar);
  CURRENT_BASE_SIZE:=newsize;

   //line space
  BASE_TAI_A:=BaseSizeVar[newsize].a;
  BASE_TAI_B:=BaseSizeVar[newsize].b;
  GRAPH_OFFSET:=BASE_TAI_A+BASE_TAI_B;
  UNIT_SPACE_LINE:= GRAPH_OFFSET * 7;
  RATIO_DIVIDER:=UNIT_SPACE_LINE - 3;
  LIST_NAME_POS:= UNIT_SPACE_LINE - BaseSizeVar[newsize].nameposmod;
  ICO32_BASEOFFESET:= (UNIT_SPACE_LINE div 2) - (SIZE_ICO32 div 2);

  //focusedrender const:
  FOCUSED_UNIT_SPACE_LINE:=GRAPH_OFFSET*10;
  FOCUSED_NAME_POS := (FOCUSED_UNIT_SPACE_LINE div 2) -BaseSizeVar[newsize].normalfont;
  FOCUSED_RATIO_DIVIDER := FOCUSED_UNIT_SPACE_LINE-3;
  FOCUSED_EVENT_RECEIVED_LINE:=1;
  FOCUSED_AURA_BASEOFFSET := 6*FOCUSED_UNIT_SPACE_LINE+30;
  FOCUSED_AURA_LINE := GRAPH_OFFSET+8;

  MARGE_CHAT_DEFAULT := 2 + GRAPH_OFFSET +2;
  if MARGE_CHAT>0 then MARGE_CHAT :=MARGE_CHAT_DEFAULT;

  FONT_SIZE:= BaseSizeVar[newsize].normalfont;
  FONT_SIZE_MIN :=BaseSizeVar[newsize].smallfont;
end;

end.
