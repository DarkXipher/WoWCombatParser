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

Unit wcr_Main;

interface

{$I _config.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, shellapi,
  Dialogs, StdCtrls, DateUtils, ComCtrls, ExtCtrls, Menus, ActiveX,
  GR32_Layers, GR32, math, wcr_Parser_Events, wcr_Hint, wcr_Const,
  wcr_utils, wcr_Stats, wcr_hintdatas, ImgList, wcr_ressource, G32_ProgressBar,
  wcr_Hash, BrwsFldr, NiceSideBar, ActnList, Htmlview, ToolWin, AppEvnts, GR32_RangeBars,
  wcr_Html, GR32_Image, GR32_Polygons, VirtualTrees, HTMLUn2, wcr_replay;

type
  sLogError = (logNoError, logInterrupted, logTimeStampError, logReadError,
    logBigSession, logFicError, logOldLog, ChatlogReadError, ChatLogIsEventLog);

  RefreshOpt = (RefreshUnit, RefreshStats, RefreshUnitStats, RefreshMap,
    RefreshMapOnDetail, PostponeUnitRefresh);

  sRefreshOpts = set of RefreshOpt;

  TNodeData = class
  public
    p: pEvent;
    constructor create(pTmp: pEvent);
  end;

  rwindowpos = record
    width, height, top, left: integer;
  end;

  rTreeData = record
    BasicND: TNodeData;
  end;

  ptreedata = ^rTreeData;

  rResultEvent = record
    r: array [1 .. 5] of pEvent;
    idActive: integer;
  end;

  rEventIgnored = record
    t: integer;
    count: integer;
  end;

  pEventIgnored = ^rEventIgnored;

  rmapnode = record
    x, y: smallint;
    p: pEvent;
  end;

  pmapnode = ^rmapnode;

  rmasterNode = record
    gType: byte;
  end;

  pmasternode = ^rmasterNode;

  mousedrag = (drag_0, drag_x, drag_y, splitRaid_y, splitMarge_x);

  selectState = (sS_empty, sS_step1, sS_valid);

  rSelection = record
    startTime, endTime: integer;
    startId: integer;
    state: selectState;
    selectionLabel: string;
    isBlockSelection: boolean;
    pnode: pvirtualnode;
  end;

  rMouseDetect = record
    stream_mapnode: tmemorystream;
    CheckPoint: array of integer;
    Yarray: array of integer;
    threshold: integer;
    maxpos: int64;
    onfilter: boolean;
  end;

  rGraph = record

    idleEvent_RefreshImage: boolean;
    forceStatUpdate: boolean;
    postponeStatUpdate: boolean;
    // ------param generique d'affichage
    startDrawEventId: integer;
    startDrawMarkId: array [1 .. high(markedlist)] of integer;

    startDrawTime: integer;
    maxtime: integer; // temps max du log
    imagemap_zoom: double;
    mouseTime: integer;
    oldMouseOffsetx: integer;
    oldMouseOffsety: integer;
    select: rSelection;
    unitRef: boolean;
    linetype: linearraytype;
    dpsInterval: integer;
    noredim: boolean;
    // array
    startHpEventId: integer;
    startRealTime, startHpTime, endHpTime: integer;
    Xmax: cardinal;
    dragging: mousedrag;
    yoffset, oldyoffset: double;
    activeUnitGfx: tUnitData;
    activeUnitStatNode: pvirtualnode;
    oldmargeRaid: integer;
    // activeUnitStat:tUnitData;
    // support tooltip
    activeEvent: pEvent;
    nbactiveEvent: integer;
    activeFilter: tfilterdata;
    // menuhandle
    MenuActiveEvent: pEvent;
    MenuActiveSpell: tspellInfo;
    MenuActiveUnitGfx: tUnitData;
    // utils
    repere: integer;
    DrawEvent, DrawHpline: boolean;
    // reglette
    reglette: array [0 .. 1] of integer;
    regletteY: integer;
    reglettetime: string;
    // focusedUnit
    WatchedUnit: tUnitData;
    WatchedUnitUseSum: boolean;
    //
    WatchedLineHidden: boolean;
    FocusedAura: integer;
    FocusedAuraUnit: tUnitData;
    FocusedAuraOffset: integer;
    FocusedRotation: integer;
    FocusedMode: integer;
    FocusedModeOld: integer;
    // spell
    focusedSpell: tspellinfo;
    focusedSpellHint: trotationline;
    focusedSpelltag: integer;
    /// /
    unittreenode: pvirtualnode;
    lines: array [1 .. 8] of linearray;
    auralines: tlist;

    // statsunit
    Rotationlines: rRotationlines;
    statsmode: integer;
    overridefiltercheck: boolean;
    keepunitstattreeOffset: boolean;
    unitstattreeOffset: integer;
    unitstattreeSortCol: array [0 .. 9] of integer;
    // ---
    AuthScrollList: boolean;
    // gauge
    gaugecount: integer;
    gaugeNoDirectChange: boolean;
    hzBarRatio, hzBarBase, hzOldPos: integer;
    hzNoDirectChange: boolean;
    // chat
    chatNode: pvirtualnode;
    activechatNode: pvirtualnode;
    // aurawatch
    aurawatch: integer;
    aurawatchSource: tUnitData;
    // quickstats
    qstats: quickstats;
    qstatsUnit: tUnitData;
    qstatsStart, qstatsEnd, qstatsFirstStart: integer;
    qstatsLabel: String;
    QstatMouse: boolean;
  end;

  rFilterDatanode = record
    e: eventParam;
  end;

  pFilterDatanode = ^rFilterDatanode;

  rTimeDatanode = record
    bossId: integer;
    starteventId, lasteventId: integer;
    nbAction, debuffremoved, debuffremovedtime: integer;
    startCombattime, lastCombattime: integer;
    checkforwipe, AuthCheckEvent, HeuristicCheck: boolean;
    deathcount, timemout, randomId: integer;
    playercount, playerdeathcount: integer;
    bossopts: sbossopts;
  end;

  pTimeDatanode = ^rTimeDatanode;

  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    TreeMenu: TPopupMenu;
    filterSrcName: TMenuItem;
    filterDestName: TMenuItem;
    N1: TMenuItem;
    OpenDialog1: TOpenDialog;
    FilterAroundEvents1: TMenuItem;
    Panel2: TPanel;
    CheckSpell1: TMenuItem;
    SetStartGraph1: TMenuItem;
    ImagePopUp: TPopupMenu;
    ViewEventInList1: TMenuItem;
    N5: TMenuItem;
    LoadLog1: TMenuItem;
    N3: TMenuItem;
    Splitter1: TSplitter;
    UnitTreePopup: TPopupMenu;
    N2: TMenuItem;
    UpdateUnit2: TMenuItem;
    ShowOnlyUnit1: TMenuItem;
    SpellPopup: TPopupMenu;
    EventPopUp: TPopupMenu;
    CheckAll1: TMenuItem;
    CheckAll2: TMenuItem;
    ShowOnlySpell1: TMenuItem;
    N4: TMenuItem;
    Reset1: TMenuItem;
    ResetSel1: TMenuItem;
    ResetSel2: TMenuItem;
    ResetSel4: TMenuItem;
    ResetSel3: TMenuItem;
    EditSpell1: TMenuItem;
    EditSpell2: TMenuItem;
    EditUnitParams1: TMenuItem;
    EditSpell3: TMenuItem;
    N6: TMenuItem;
    ResetPlayerStates1: TMenuItem;
    UncheckAllPlayers1: TMenuItem;
    Filterpopup: TPopupMenu;
    ResetSelection1: TMenuItem;
    N7: TMenuItem;
    GfxNoNpc: TMenuItem;
    GfxNoPet: TMenuItem;
    GfxAlwaysBoss: TMenuItem;
    GfxShowInactive: TMenuItem;
    GfxNoExternal: TMenuItem;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    loadlog2: TMenuItem;
    DetailsOnUnit1: TMenuItem;
    N9: TMenuItem;
    CheckSpell2: TMenuItem;
    Panel6: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    unitTree: TVirtualStringTree;
    TabSheet5: TTabSheet;
    FilterTree: TVirtualStringTree;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Panel8: TPanel;
    Label1: TLabel;
    SpellTree: TVirtualStringTree;
    EventTree: TVirtualStringTree;
    Panel7: TPanel;
    TimeTree: TVirtualStringTree;
    Splitter2: TSplitter;
    imagelist1: TImageList;
    imagelist2: TImageList;
    Splitter3: TSplitter;
    GfxNoAffiliation: TMenuItem;
    PopupFilter: TPopupMenu;
    ResetFilter1: TMenuItem;
    StatPopup: TPopupMenu;
    Stat_SetFocus: TMenuItem;
    N8: TMenuItem;
    ExpandAll1: TMenuItem;
    CollapseAll1: TMenuItem;
    Resetfullfilter1: TMenuItem;
    N11: TMenuItem;
    Resetfullfilter2: TMenuItem;
    ResetFullFilter3: TMenuItem;
    N12: TMenuItem;
    ResetFullFilter4: TMenuItem;
    ResetFocus4: TMenuItem;
    Panel5: TPanel;
    ToolBar4: TToolBar;
    ToolButton9: TToolButton;
    SpellInfo1: TMenuItem;
    SaveDialog1: TSaveDialog;
    HintTimer: TTimer;
    SaveFilter1: TMenuItem;
    CustomFilterTree: TVirtualStringTree;
    RenameFilter1: TMenuItem;
    DeleteFilter1: TMenuItem;
    Anon: TMenuItem;
    ShowOnlyAllUnit1: TMenuItem;
    TabSheet2: TTabSheet;
    ChatPopup: TPopupMenu;
    BlackList1: TMenuItem;
    ApplyBlackList1: TMenuItem;
    BlPopup: TPopupMenu;
    DeleteEntry1: TMenuItem;
    ClearList1: TMenuItem;
    LiveUpdateTimer: TTimer;
    TabSheet3: TTabSheet;
    CompareTree: TVirtualStringTree;
    MenuCompare: TPopupMenu;
    AddRaidGfx1: TMenuItem;
    Clear1: TMenuItem;
    Save1: TMenuItem;
    Load1: TMenuItem;
    N14: TMenuItem;
    Supprimer1: TMenuItem;
    LoadMenu1: TPopupMenu;
    LoadLog3: TMenuItem;
    LoadLiveLog1: TMenuItem;
    N15: TMenuItem;
    Panel12: TPanel;
    Label4: TLabel;
    EditLine1: TMenuItem;
    N16: TMenuItem;
    RegisteredUnits1: TMenuItem;
    Edit1: TEdit;
    SetAuraWatch1: TMenuItem;
    RemoveAuraWatch1: TMenuItem;
    SetAuraWatch2: TMenuItem;
    RemoveAuraWatch2: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    clipboard1: TMenuItem;

    RegisteredSpells1: TMenuItem;
    LogIndex: TMenuItem;
    Options1: TMenuItem;
    CheckOnWeb1: TMenuItem;
    CheckUnitOnWeb1: TMenuItem;
    N10: TMenuItem;
    TabSheet9: TTabSheet;
    MemoStat: TMemo;
    MemoError: TMemo;
    Panel21: TPanel;
    Panel22: TPanel;
    PageControl3: TPageControl;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    ChatTree: TVirtualStringTree;
    Panel23: TPanel;
    autoclearchat: TCheckBox;
    ListBox1: TListBox;
    Panel11: TPanel;
    Button3: TButton;
    Button4: TButton;
    Panel25: TPanel;
    MainPanel: TPanel;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    Panel4: TPanel;
    GraphicTab: TTabSheet;
    Panel1: TPanel;
    Imagemap: TImage32;
    GaugeBar2: TGaugeBar;
    Panel9: TPanel;
    Bevel1: TBevel;
    GaugeBar3: TGaugeBar;
    Panel3: TPanel;
    Panel13: TPanel;
    ToolBar5: TToolBar;
    LoadLogBut: TToolButton;
    SaveWcrFileBut: TToolButton;
    LiveUpdateCheck: TToolButton;
    LiveUpdateUpdate: TToolButton;
    ToolButton21: TToolButton;
    gfx_ResetFilter: TToolButton;
    ToolButton17: TToolButton;
    gfx_ResetFocus: TToolButton;
    ToolButton26: TToolButton;
    btnFocusMode: TToolButton;
    btnFocusType: TToolButton;
    ToolButton14: TToolButton;
    Panel14: TPanel;
    ToolBar1: TToolBar;
    HideEvents: TToolButton;
    LineOnBG: TToolButton;
    relativeRatio: TToolButton;
    ToolButton3: TToolButton;
    gfxtb1: TToolButton;
    gfxtb2: TToolButton;
    gfxtb3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    useFilterInArray: TToolButton;
    btnAbsorb: TToolButton;
    GfxRaidDpsOut: TToolButton;
    GfxRaidDpsIn: TToolButton;
    GfxRaidHpsOut: TToolButton;
    GfxRaidEffHpsOut: TToolButton;
    StatsTab: TTabSheet;
    StatTree: TVirtualStringTree;
    Panel16: TPanel;
    Panel18: TPanel;
    ToolBar3: TToolBar;
    Stats_UseFilter: TToolButton;
    Stat_UseUnitRef: TToolButton;
    Stat_assignAff: TToolButton;
    Stat_absorb: TToolButton;
    Stat_MergeAbsorb: TToolButton;
    Stat_NoEnemyHeal: TToolButton;
    Stat_NoFriendDamage: TToolButton;
    Stat_ShowActDps: TToolButton;
    ToolButton2: TToolButton;
    Stat_LaunchStat: TToolButton;
    ToolButton11: TToolButton;
    ToolButton15: TToolButton;
    Stat_OnlyCombat: TToolButton;
    TabSheet8: TTabSheet;
    WatchedEventTree: TVirtualStringTree;
    SideBar1: TNiceSideBar;
    Panel15: TPanel;
    Panel17: TPanel;
    ListViewTab: TTabSheet;
    MyTree: TVirtualStringTree;
    Panel19: TPanel;
    Panel20: TPanel;
    ToolBar2: TToolBar;
    ListBut_UseSelection: TToolButton;
    ListBut_ApplyFullFilter: TToolButton;
    ListBut_UseUnitRef: TToolButton;
    ListBut_AutoRefresh: TToolButton;
    ListBut_Security: TToolButton;
    ListBut_Refresh: TToolButton;
    Splitter4: TSplitter;
    Panel24: TPanel;
    But_Options: TToolButton;
    ToolButton8: TToolButton;
    menu_detailmode: TPopupMenu;
    ToolButton10: TToolButton;
    gfxDetail1: TMenuItem;
    gfxDetail2: TMenuItem;
    gfxDetail3: TMenuItem;
    gfxDetail4: TMenuItem;
    N13: TMenuItem;
    Unit1: TMenuItem;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    ProgressBar1: TG32_ProgressBar;
    ReadMeViewer: THTMLViewer;
    menu_focusmode: TPopupMenu;
    focusmode01: TMenuItem;
    focusmode11: TMenuItem;
    focusmode21: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Splitter5: TSplitter;
    htmlstats: THTMLViewer;
    Panel10: TPanel;
    htmlstatsMenu: THTMLViewer;
    UnitStatTree: TVirtualStringTree;
    gfxDetail0: TMenuItem;
    Action5: TAction;
    CheckUnitOnWeb2: TMenuItem;
    UpdateUnitAff2: TMenuItem;
    treeOnlyInCombat1: TMenuItem;
    GfxDrawMarks: TToolButton;
    AutosortListby1: TMenuItem;
    Unittreesort0: TMenuItem;
    Unittreesort1: TMenuItem;
    Unittreesort2: TMenuItem;
    imagelist3: TImageList;
    GfxDrawStatsWidget: TToolButton;
    SetAuraWatchUnit1: TMenuItem;
    SetAuraWatchUnit2: TMenuItem;
    ToggleFocus1: TMenuItem;
    ForcePlayerInRaid1: TMenuItem;
    ReplayTab: TTabSheet;
    Panel26: TPanel;
    Panel27: TPanel;
    ImageReplay: TImage32;
    Panel28: TPanel;
    ToolBar6: TToolBar;
    butreplay_play: TToolButton;
    butreplay_autofit: TToolButton;
    butreplay_fitimage: TToolButton;
    replayTimer: TTimer;
    ToolButton1: TToolButton;
    butreplay_circle: TToolButton;
    replayPopup: TPopupMenu;
    play111: TMenuItem;
    play211: TMenuItem;
    playx41: TMenuItem;
    playx101: TMenuItem;
    replayPopupRotate: TPopupMenu;
    ToolButton5: TToolButton;
    rotate901: TMenuItem;
    rotate1801: TMenuItem;
    rotate2701: TMenuItem;
    rotate01: TMenuItem;
    butreplay_showAttack: TToolButton;
    butreplay_showPlayer: TToolButton;
    Action6: TAction;
    Action7: TAction;
    procedure FormCreate(Sender: TObject);
    procedure MyTreeFreeNode(Sender: TBaseVirtualTree; Node: pvirtualnode);
    procedure MyTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MyTreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure TreeMenuPopup(Sender: TObject);
    procedure filterSrcNameClick(Sender: TObject);
    procedure filterDestNameClick(Sender: TObject);
    procedure FilterAroundEvents1Click(Sender: TObject);
    procedure CheckSpell1Click(Sender: TObject);
    procedure ImagemapMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure ImagemapMouseMove(Sender: TObject; Shift: TShiftState;
      x, y: integer; Layer: TCustomLayer);
    procedure ImagemapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; x, y: integer; Layer: TCustomLayer);
    procedure SetStartGraph1Click(Sender: TObject);
    procedure ImagemapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; x, y: integer; Layer: TCustomLayer);
    procedure ViewEventInList1Click(Sender: TObject);
    procedure ImagePopUpPopup(Sender: TObject);
    procedure ImagemapMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure LoadLog1Click(Sender: TObject);
    procedure MyTreeMouseMove(Sender: TObject; Shift: TShiftState;
      x, y: integer);
    procedure unitTreeFreeNode(Sender: TBaseVirtualTree; Node: pvirtualnode);
    procedure unitTreeCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: pvirtualnode; Column: TColumnIndex; var Result: integer);
    procedure unitTreeInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: pvirtualnode;
      var InitialStates: TVirtualNodeInitStates);
    procedure unitTreeChecked(Sender: TBaseVirtualTree; Node: pvirtualnode);
    procedure ImagemapResize(Sender: TObject);
    procedure UnitTreePopupPopup(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UpdateUnit2Click(Sender: TObject);
    procedure ShowOnlyUnit1Click(Sender: TObject);
    procedure SpellTreeInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: pvirtualnode;
      var InitialStates: TVirtualNodeInitStates);
    procedure SpellTreeFreeNode(Sender: TBaseVirtualTree; Node: pvirtualnode);
    procedure EventTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure SpellTreeCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: pvirtualnode; Column: TColumnIndex; var Result: integer);
    procedure EventTreeCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: pvirtualnode; Column: TColumnIndex; var Result: integer);
    procedure SpellTreeChecked(Sender: TBaseVirtualTree; Node: pvirtualnode);
    procedure CheckAll1Click(Sender: TObject);
    procedure CheckAll2Click(Sender: TObject);
    procedure unitTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure SpellTreeChecking(Sender: TBaseVirtualTree; Node: pvirtualnode;
      var NewState: TCheckState; var Allowed: boolean);
    procedure ShowOnlySpell1Click(Sender: TObject);
    procedure ResetSel1Click(Sender: TObject);
    procedure ResetSel2Click(Sender: TObject);
    procedure ResetSel3Click(Sender: TObject);
    procedure ResetSel4Click(Sender: TObject);
    procedure EditSpell1Click(Sender: TObject);
    procedure SpellTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure EditSpell2Click(Sender: TObject);
    procedure SpellPopupPopup(Sender: TObject);
    procedure EditUnitParams1Click(Sender: TObject);
    procedure StatTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure StatTreeFreeNode(Sender: TBaseVirtualTree; Node: pvirtualnode);
    procedure StatTreeCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: pvirtualnode; Column: TColumnIndex; var Result: integer);
    procedure StatTreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure EditSpell3Click(Sender: TObject);
    procedure StatTreeBeforePaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas);
    procedure unitTreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure unitTreeChecking(Sender: TBaseVirtualTree; Node: pvirtualnode;
      var NewState: TCheckState; var Allowed: boolean);
    procedure UncheckAllPlayers1Click(Sender: TObject);
    procedure ResetPlayerStates1Click(Sender: TObject);
    procedure FilterTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure FilterTreeInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: pvirtualnode;
      var InitialStates: TVirtualNodeInitStates);
    procedure FilterTreeChecking(Sender: TBaseVirtualTree; Node: pvirtualnode;
      var NewState: TCheckState; var Allowed: boolean);
    procedure FilterTreeChecked(Sender: TBaseVirtualTree; Node: pvirtualnode);
    procedure ResetSelection1Click(Sender: TObject);
    procedure TimeTreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure TimeTreeFocusChanging(Sender: TBaseVirtualTree;
      OldNode, NewNode: pvirtualnode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: boolean);
    procedure unitTreeFocusChanging(Sender: TBaseVirtualTree;
      OldNode, NewNode: pvirtualnode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: boolean);
    procedure SpellTreeFocusChanging(Sender: TBaseVirtualTree;
      OldNode, NewNode: pvirtualnode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: boolean);
    procedure EventTreeFocusChanging(Sender: TBaseVirtualTree;
      OldNode, NewNode: pvirtualnode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: boolean);
    procedure GfxNoExternalClick(Sender: TObject);
    procedure GfxNoNpcClick(Sender: TObject);
    procedure CheckSpell2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure StatTreeMouseMove(Sender: TObject; Shift: TShiftState;
      x, y: integer);
    procedure FilterTreeFocusChanging(Sender: TBaseVirtualTree;
      OldNode, NewNode: pvirtualnode;
      OldColumn, NewColumn: TColumnIndex; var Allowed: boolean);
    procedure gfxtb1Click(Sender: TObject);
    procedure relativeRatioClick(Sender: TObject);
    procedure LineOnBGClick(Sender: TObject);
    procedure ListBut_UseSelectionClick(Sender: TObject);
    procedure ListBut_RefreshClick(Sender: TObject);
    procedure ButStat_damageTypeClick(Sender: TObject);
    procedure Stat_LaunchStatClick(Sender: TObject);
    procedure gfx_ResetFocusClick(Sender: TObject);
    procedure gfx_detailledViewClick(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure StatsTabShow(Sender: TObject);
    procedure Stat_SetFocusClick(Sender: TObject);
    procedure StatPopupPopup(Sender: TObject);
    procedure CollapseAll1Click(Sender: TObject);
    procedure ExpandAll1Click(Sender: TObject);
    procedure StatTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure ToolButton9Click(Sender: TObject);
    procedure SpellTreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure SpellInfo1Click(Sender: TObject);
    procedure SaveWcrFileButClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure HintTimerTimer(Sender: TObject);
    procedure SaveFilter1Click(Sender: TObject);
    procedure CustomFilterTreeInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: pvirtualnode;
      var InitialStates: TVirtualNodeInitStates);
    procedure CustomFilterTreeFreeNode(Sender: TBaseVirtualTree;
      Node: pvirtualnode);
    procedure CustomFilterTreeMouseMove(Sender: TObject; Shift: TShiftState;
      x, y: integer);
    procedure Panel7MouseMove(Sender: TObject; Shift: TShiftState;
      x, y: integer);
    procedure TimeTreeMouseMove(Sender: TObject; Shift: TShiftState;
      x, y: integer);
    procedure CustomFilterTreeChecked(Sender: TBaseVirtualTree;
      Node: pvirtualnode);
    procedure gfx_ResetFilterClick(Sender: TObject);
    procedure ResetFilter1Click(Sender: TObject);
    procedure Resetfullfilter1Click(Sender: TObject);
    procedure Resetfullfilter2Click(Sender: TObject);
    procedure ResetFullFilter3Click(Sender: TObject);
    procedure PopupFilterPopup(Sender: TObject);
    procedure CustomFilterTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure DeleteFilter1Click(Sender: TObject);
    procedure RenameFilter1Click(Sender: TObject);
    procedure AnonClick(Sender: TObject);
    procedure GfxRaidDpsOutClick(Sender: TObject);
    procedure ShowOnlyAllUnit1Click(Sender: TObject);
    procedure GaugeBar2Change(Sender: TObject);
    procedure GaugeBar3Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ChatTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure ChatTreeFocusChanging(Sender: TBaseVirtualTree;
      OldNode, NewNode: pvirtualnode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: boolean);
    procedure ChatTreeFreeNode(Sender: TBaseVirtualTree; Node: pvirtualnode);
    procedure Button4Click(Sender: TObject);
    procedure BlackList1Click(Sender: TObject);
    procedure ApplyBlackList1Click(Sender: TObject);
    procedure ChatTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure ClearList1Click(Sender: TObject);
    procedure DeleteEntry1Click(Sender: TObject);
    procedure LiveUpdateTimerTimer(Sender: TObject);
    procedure LiveUpdateCheckClick(Sender: TObject);
    procedure LiveUpdateUpdateClick(Sender: TObject);
    procedure AddRaidGfx1Click(Sender: TObject);
    procedure CompareTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure CompareTreeFreeNode(Sender: TBaseVirtualTree; Node: pvirtualnode);
    procedure Clear1Click(Sender: TObject);
    procedure CompareTreeInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: pvirtualnode;
      var InitialStates: TVirtualNodeInitStates);
    procedure CompareTreeChecked(Sender: TBaseVirtualTree; Node: pvirtualnode);
    procedure CompareTreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure Save1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure Supprimer1Click(Sender: TObject);
    procedure LoadLog3Click(Sender: TObject);
    procedure LoadLiveLog1Click(Sender: TObject);
    procedure EditLine1Click(Sender: TObject);
    procedure RegisteredUnits1Click(Sender: TObject);
    procedure SetAuraWatch1Click(Sender: TObject);
    procedure RemoveAuraWatch1Click(Sender: TObject);
    procedure SetAuraWatch2Click(Sender: TObject);
    procedure ReadMeViewerHotSpotClick(Sender: TObject; const URL: String;
      var Handled: boolean);
    procedure clipboard1Click(Sender: TObject);
    procedure btnAbsorbClick(Sender: TObject);
    procedure Stat_absorbClick(Sender: TObject);
    procedure Stat_MergeAbsorbClick(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure RegisteredSpells1Click(Sender: TObject);
    procedure WatchedEventTreeGetText(Sender: TBaseVirtualTree;
      Node: pvirtualnode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: String);
    procedure WatchedEventTreeCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: pvirtualnode; Column: TColumnIndex; var Result: integer);
    procedure WatchedEventTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure WatchedEventTreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure SideBar1Select(Sender: TObject; Index, SubIndex: integer;
      Caption: String);
    procedure WatchedEventTreeExpanded(Sender: TBaseVirtualTree;
      Node: pvirtualnode);
    procedure WatchedEventTreeFreeNode(Sender: TBaseVirtualTree;
      Node: pvirtualnode);
    procedure ResetFullFilter4Click(Sender: TObject);
    procedure GraphicTabShow(Sender: TObject);
    procedure TabSheet8Show(Sender: TObject);
    procedure ListViewTabShow(Sender: TObject);
    procedure LogIndexClick(Sender: TObject);
    procedure StatTreeExpanded(Sender: TBaseVirtualTree; Node: pvirtualnode);
    procedure Stat_NoEnemyHealClick(Sender: TObject);
    procedure Stat_ShowActDpsClick(Sender: TObject);
    procedure Stat_OnlyCombatClick(Sender: TObject);
    procedure CheckOnWeb1Click(Sender: TObject);
    procedure CheckUnitOnWeb1Click(Sender: TObject);
    procedure PageControl1MouseMove(Sender: TObject; Shift: TShiftState;
      x, y: integer);
    procedure HideEventsClick(Sender: TObject);
    procedure htmlstatsMenuHotSpotClick(Sender: TObject; const URL: String;
      var Handled: boolean);
    procedure TabSheet4Show(Sender: TObject);
    procedure But_OptionsClick(Sender: TObject);
    procedure gfxDetail1Click(Sender: TObject);
    procedure DetailsOnUnit1Click(Sender: TObject);
    procedure Unit1Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure btnFocusModeClick(Sender: TObject);
    procedure focusmode01Click(Sender: TObject);

    procedure UnitStatTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure UnitStatTreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: pvirtualnode;
      Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
      var ContentRect: TRect);
    procedure UnitStatTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure UnitStatTreeMouseMove(Sender: TObject; Shift: TShiftState;
      x, y: integer);
    procedure UnitStatTreeCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: pvirtualnode; Column: TColumnIndex; var Result: integer);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: boolean);
    procedure UnitStatTreeCollapsing(Sender: TBaseVirtualTree;
      Node: pvirtualnode; var Allowed: boolean);
    procedure UnitStatTreeColumnClick(Sender: TBaseVirtualTree;
      Column: TColumnIndex; Shift: TShiftState);
    procedure StatTreeFocusChanged(Sender: TBaseVirtualTree;
      Node: pvirtualnode; Column: TColumnIndex);
    procedure Action5Execute(Sender: TObject);
    procedure menu_detailmodePopup(Sender: TObject);
    procedure UnitStatTreeContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);
    procedure SpellTreeContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);
    procedure unitTreeContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);
    procedure StatTreeContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);
    procedure CheckUnitOnWeb2Click(Sender: TObject);
    procedure UpdateUnitAff2Click(Sender: TObject);
    procedure TimeTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure treeOnlyInCombat1Click(Sender: TObject);
    procedure GfxDrawMarksClick(Sender: TObject);
    procedure Unittreesort0Click(Sender: TObject);
    procedure unitTreeGetImageIndex(Sender: TBaseVirtualTree;
      Node: pvirtualnode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: boolean; var ImageIndex: integer);
    procedure StatTreeGetImageIndex(Sender: TBaseVirtualTree;
      Node: pvirtualnode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: boolean; var ImageIndex: integer);
    procedure MyTreeGetImageIndex(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: boolean;
      var ImageIndex: integer);
    procedure ApplicationEvents1Exception(Sender: TObject; e: Exception);
    procedure GfxDrawStatsWidgetClick(Sender: TObject);
    procedure SetAuraWatchUnit1Click(Sender: TObject);
    procedure SetAuraWatchUnit2Click(Sender: TObject);
    procedure unitTreeMouseMove(Sender: TObject; Shift: TShiftState;
      x, y: integer);
    procedure ToggleFocus1Click(Sender: TObject);
    procedure ChatTreeCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: pvirtualnode; Column: TColumnIndex; var Result: integer);
    procedure unitTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure CustomFilterTreeGetText(Sender: TBaseVirtualTree;
      Node: pvirtualnode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure TimeTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure SpellTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure doiteratefocus(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Data: Pointer; var Abort: boolean);
    procedure getiteratefocus(Sender: TBaseVirtualTree; Node: pvirtualnode;
      Data: Pointer; var Abort: boolean);
    procedure StatTreeHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure UnitStatTreeAdvancedHeaderDraw(Sender: TVTHeader;
      var PaintInfo: THeaderPaintInfo; const Elements: THeaderPaintElements);
    procedure UnitStatTreeHeaderDrawQueryElements(Sender: TVTHeader;
      var PaintInfo: THeaderPaintInfo; var Elements: THeaderPaintElements);
    procedure ForcePlayerInRaid1Click(Sender: TObject);
    procedure ReplayTabShow(Sender: TObject);
    procedure butreplay_circleClick(Sender: TObject);
    procedure butreplay_fitimageClick(Sender: TObject);
    procedure replayTimerTimer(Sender: TObject);
    procedure butreplay_playClick(Sender: TObject);
    procedure ImageReplayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; x, y: integer; Layer: TCustomLayer);
    procedure ImageReplayMouseMove(Sender: TObject; Shift: TShiftState;
      x, y: integer; Layer: TCustomLayer);
    procedure ImageReplayMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; x, y: integer; Layer: TCustomLayer);
    procedure ImageReplayMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure ImageReplayMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: boolean);
    procedure play111Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure rotate01Click(Sender: TObject);
    procedure butreplay_autofitClick(Sender: TObject);
    procedure UnitStatTreeHeaderClick(Sender: TVTHeader;
      HitInfo: TVTHeaderHitInfo);
    procedure butreplay_showAttackClick(Sender: TObject);
    procedure butreplay_showPlayerClick(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);

  private
    windowpos: rwindowpos;
    // PARSING var
    LiveParsing_Fic: string;
    LiveParsing_LastPos: int64;
    LiveParsing_TotalTime: dword;
    LiveParsing_firststring: boolean;
    LiveParsing_validLiveLog: boolean;
    globalFocusType: sfocusType;
    // index

    // boolean pour bloquer le keydown si on ecrit dans les champs
    authKeyDown: boolean;
    Eventlist, EventIgnoredlist, LocalStatList, CombatBlockList,
      EventDeathlist: tlist;
    openlogcomment: string;
    openlogarrayIndex, openlogUtf8: boolean;
    // FilterParamsChecked,FilterParamsunChecked:eventParams;
    firsttime: boolean;
    authStatResize: boolean;
    drawedList: tlist;
    logerror: sLogError;
    logReadErrorCount: integer;
    CurrentLogError: boolean;
    mousedetect: rMouseDetect;
    firsttimeLaunch: boolean;
    paramGraph: rGraph;
    GlobalEndLogTime: integer;
    masterNode: array [1 .. 4] of pvirtualnode;

    MaxAbsRow, MaxCastRow: integer;
    markedicon: ticonarray; //array [ low(markedlist) .. high(markedlist)] of tbitmap32;
    iconrole: array [1 .. 3] of tbitmap32;
    procedure unitTreeFocus(Node: pvirtualnode);
    procedure Stat_Typo;
    procedure setIcon;
    procedure clearUnitStatTree;
    procedure fillUnitStats;
    procedure fillunitstatEx(l: tlist; state: rotationstate;
      firstnode: trotationline; statcol: array of rstatcolumn);
    procedure fixstatcolumnParams(Rotationline: trotationline;
      highcol: integer);
    function dontdisturb: boolean;
    procedure settimetreefocus(Node: pvirtualnode);
    procedure LogStatsOutput;
    procedure showlogerror(erreur: string);
    procedure getMouseTime(x: integer);
    function getControltime(x: integer): integer;
    function unpackwcrlog(filename: string; f: tmemorystream): byte;
    function Loadwcrlog(filename: string): boolean;
    procedure fixCompatibility(p: pEvent);
    procedure saveWcrLog(filename, commentstr: string; useFullLog: boolean);
    procedure scrollListUp(step: integer);
    procedure scrollListDown(step: integer);
    function getmaxfocusedOffset: integer;
    procedure scrollListHome;
    procedure getWebInfoforSpell(spell: tspellinfo);
    procedure getWebInfoForUnit(u: tunitinfo);
    function setmapnode(r: rmapnode; check: boolean = false): boolean;
    function getmapnode(x, y: smallint): rResultEvent;
    procedure loadprefs;
    procedure loadprefsfiles(filename: string; skipfilter: boolean);
    procedure analysePrefLine(s: string; skipfilter: boolean);
    procedure addcustomfilter(s: string; skipfilter: boolean);
    procedure saveprefs;
    procedure launchParsing(const filename, bossId: string;
      simpleLoad: boolean);
    procedure FinalysingLogLoading(bossId: string; simpleLoad: boolean);
    procedure reactivateControls;
    procedure ParsingLogFeedback;
    Procedure InitLogLoading;
    Procedure CleaningControl(IsExtended: boolean);
    procedure clearMouseDetect(doclearStream: boolean);
    procedure validateMouseDetect;
    procedure resetParamGraph;
    procedure resetReglette;
    procedure resetParamGraphFocusedData;
    procedure clearRotationlines;
    procedure assignLineType(l: linearraytype);
    procedure initNPCArray;
    procedure initSpellArray;
    procedure saveNPCArray;
    procedure saveSpellArray;
    function validateStream(stream: tstream): boolean;
    procedure ParseFile(filename: string);
    function getPointedUnit: tunitdata;
    function getPointedSpell: tSpellInfo;
    function getPointedEvent: pEvent;
    procedure ExtendParsing(filename: string);
    function initStream(filename: string): TfileStream;
    procedure readLnFromStream(stream: tstream);
    Procedure readLnSetTextStr(const Value: rawbytestring; Size: integer);
    procedure ParseLine(strtmp: String);
    procedure validateError;
    function AnalyseEvent(p: pchar): pEvent;
    procedure launchChatParsing(f: string);
    procedure defineChatRender(refreshTree: boolean = true);
    procedure clearChatTreefromBL;
    procedure ParseChatFile(filename: string);
    function AnalyseChatEvent(t: string): pChatEvent;
    procedure getChatEvent(x1, x2: integer);
    procedure AssignData;
    procedure generateCombatBlock;
    procedure generateBossIndex;
    procedure validdatablock(l0, l1, l2: tlist; datatime: pTimeDatanode);
    procedure AssignDrawedUnit(maxunit: integer);
    procedure assignUnittoTree(u: tunitinfo);
    procedure addignoredEvent(t: integer);
    procedure clearEventlist;
    procedure clearCombatBlocklist;
    procedure clearEventTypeList;
    procedure clearSpellArray;
    procedure clearUnitArray;
    procedure clearMarkedList;
    procedure BuildEventlist;
    procedure fillTreeEvent(filter: eventFilter);
    procedure filterAroundNode(filterOpt: eventOptions);
    procedure InitBitmap;
    procedure PaintSimpleDrawingHandler(Sender: TObject; Buffer: tbitmap32);
    procedure InitBitmap2;
    procedure ReplayZoom(mx, my: integer; ratio: double);
    procedure replayplay(playforward: integer; stopTimer: boolean = false);
    procedure updateReplayTimer(enabled: boolean);
    procedure setReplay_circle(b: boolean);
    procedure PaintSimpleDrawingHandler2(Sender: TObject; Buffer: tbitmap32);
    procedure drawstatsWidget(Buffer: tbitmap32; pu: tUnitData;
      wposx, wposy: integer);
    procedure drawauraWidget(Buffer: tbitmap32; pu: tUnitData;
      wposx, wposy: integer);
    Procedure GraphicDrawFullUnitList(Buffer: tbitmap32);
    procedure GraphicDrawMarkIcon(Buffer: tbitmap32);
    procedure GraphicDrawFullUnitAura(Buffer: tbitmap32);
    function Getauraoffset(spell: tspellinfo; u: tUnitData): integer;
    function GetRotationoffset(spell: tspellinfo): integer;
    procedure GraphicDrawSeconds(sizeSecond: double; Buffer: tbitmap32);
    procedure GraphicDrawMinutes(sizeSecond: double; Buffer: tbitmap32);
    procedure GraphicDrawTimeLine(i: integer; sizeSecond, d: double;
      Buffer: tbitmap32);
    procedure GraphicDrawSelection(Buffer: tbitmap32);
    procedure GraphicDrawCombatBlock(sizeSecond: double; Buffer: tbitmap32;
      drawtext: boolean);
    Procedure GraphicDrawChat(Buffer: tbitmap32);
    procedure GraphicDrawTag(Buffer: tbitmap32);
    procedure GraphicDrawQuickStats(Buffer: tbitmap32);
    procedure GraphicDrawReglette(Buffer: tbitmap32);
    procedure GraphicDrawIgnoredEvent(Buffer: tbitmap32);
    Procedure GraphicDrawFocusedUnit(Buffer: tbitmap32);
    Procedure GraphicDrawFocusedLineArray(sizeSecond: double;
      Buffer: tbitmap32);
    procedure GraphicDrawFocusedEvents_SourceAura(Buffer: tbitmap32);
    procedure GraphicDrawFocusedEvents_RotationIn(l: tlist; Buffer: tbitmap32);
    procedure GraphicDrawFocusedEvents_RotationOut(l: tlist; Buffer: tbitmap32);
    procedure GraphicDrawFocusedEvents_DestAura(Buffer: tbitmap32);
    procedure GraphicDrawFocusedAura(Buffer: tbitmap32);
    procedure drawDose(Buffer: tbitmap32; pstats: reventstat; r: rmapnode);
    procedure GraphicDrawFocusedRotation(l: tlist; Buffer: tbitmap32);
    function GraphicDrawRaidInitHeader: integer;
    procedure GraphicDrawRaid(maxvalue: integer; sizeSecond: double;
      Buffer: tbitmap32);
    procedure GraphicDrawMarge(Buffer: tbitmap32);
    procedure GraphicDrawRaidLine(l: linearray; baseHpRow, maxratio: integer;
      sizehpinterval: double; Buffer: tbitmap32);
    procedure interactGraph(x, y: integer; clic: boolean);
    procedure interactCombatBlockGraph(t: integer);
    function nextCombatBlockGraph: boolean;
    procedure previousCombatBlockGraph;
    function getfocusedRotation(l: tlist; yaura: integer): integer;
    procedure filleventArray;
    procedure filleventArrayHp(Xmax: integer);
    procedure filleventArrayDpsHps(Xmax: integer; lookedEvent: eventParams);
    function controltotime(x: integer): integer;
    function GetFirstEventIdOnTime(startId, t: integer): integer;
    function GetFirstEventIdOnReverseTime(startId, t: integer): integer;
    procedure AssignDrawStartID(b: boolean);
    procedure GetFirstDrawNode(refreshTree: boolean = true);
    procedure assignHzBarPos;
    function getIdFromTime(startId, timepos: integer; b: boolean): integer;
    procedure getmarkedIdOnTime(t: integer);
    function timetocontrol(t: integer): integer;
    procedure scaleimage_onTime(x: integer; s: double);
    procedure scaleimagefix_onTime(x: integer; zoomtmp: double);
    procedure scaleDpsInterval(s: integer);
    procedure DoHint(control: tcontrol; hintstr: string);
    procedure SetGraphOnEvent(p: pEvent; addtag: boolean; delay: integer = 100);
    procedure SetGraphOnTime(t: integer);
    procedure SetGraphOnReverseTime(startId, t: integer);

    // function GetFirstEventForUnit(u:tUnitData;condition:eventParam):pEvent;
    procedure unitTreeInitData;
    function getUnitOnY(y: integer): tUnitData;
    function getInstaValue(line: linearray; adjust: single): integer;
    function getFormattedInstaValue(v: integer): string;
    procedure completeRefresh(rOpts: sRefreshOpts);
    procedure evaluateWatchedUnit;
    procedure ImagemapFullRefresh(refresharray: boolean;
      RefreshMap: boolean = true);
    procedure dynamicAddUnit(periodEventId, t1, t2: integer;
      RefreshMap: boolean = true);
    procedure ShowUnitOnlyInCombat(OnlyInCombat: boolean);
    procedure ViewPortRefresh;
    procedure checkLocalEvent(p: pEvent; v: longword);
    procedure assignLocalCombatTime(ul: tUnitData; t: integer; v: longword);
    procedure CheckAllNodes(Node: pvirtualnode; cs: TCheckState;
      checkchild: boolean = false);
    function getCheckstateForNewNode(Node: pvirtualnode;
      defaultcs: TCheckState): TCheckState;
    procedure ConditionalCheckAllNodes(Node: pvirtualnode;
      cs1, cs2: TCheckState; checkchild: boolean = false);
    function ValidEventSelection(vt: TBaseVirtualTree): boolean;
    function resetRepere: boolean;
    function resetUnitRef: boolean;
    function isUnitRefActive: boolean;
    function resetTimePeriod: boolean;
    procedure resetTimePeriodDatas;
    function resetSpellEventselection: boolean;
    function resetCurrentFilter(dofilterrefresh: boolean = true): boolean;
    procedure editSpellParams(id: integer);
    procedure editUnitParams(u: tunitinfo);
    procedure unitToEventTree(Node: pvirtualnode);
    procedure buildUnitStats;
    Procedure BuildStat(usefilter, usefocus, focusmode, useAbsorb,
      usehealabsorb, excludeself, mergepet, nofriendheal,
      incombatonly: boolean);
    procedure buildWatchedEvent(watchtype: integer);
    procedure setWatchedEventComboBox(oldindex: integer);
    function IsNodeChecked(Node: pvirtualnode): boolean;
    Procedure StatTreeResizeColumn;
    function GetRightForDynamicAdd(inCombat: boolean; ul: tUnitData;
      UOpt: unitOpts; n: pvirtualnode): TCheckState;
    Procedure HidePlayerNotInRaid;
    function getrolefromunitInfo(u: tunitinfo;
      forcenoroleindex: boolean = true): integer;
    function getclassfromunitInfo(u: tunitinfo): integer;
    function getDpsvaluefromunitInfo(u: tunitinfo): integer;
    procedure validTimeButton;
    procedure changewatchedUnit(Node: pvirtualnode);
    procedure getBossFight(Node: pvirtualnode);
    function getBossFightById(bossId: string): boolean;
    procedure directBlockSelect(blocklabel: string;
      startId, startTime, endTime: integer; pos: boolean);
    procedure DrawLineArray(sizeSecond: double; Buffer: tbitmap32);
    function GetLineLOD(i: integer): boolean;
    procedure buildFocusedStats(Xmax: integer);
    procedure generateAura(p: pEvent; pstats: reventstat; u: tUnitData);
    procedure generateUnitAura(spellId: integer; sourceUnit: tUnitData);
    procedure generateUnitAuraEx(p: pEvent; u: tUnitData; auracolor: tcolor32);
    procedure buildRaidStats(x, Xmax: integer; p: pEvent; pstats: reventstat;
      filtered: integer);
    procedure fillFocusedStats;
    procedure GetPerSecondeValue(x, Xmax: integer; amount: integer;
      var instaline: linearray; var ratio: integer;
      getratio: boolean = false);
    procedure GetHpValue(u: tUnitData; p: pEvent; pstats: reventstat;
      x: integer; var hpline: linearray);
    procedure GetHpValue52(u: tUnitData; p: pEvent; pstats: reventstat;
      x: integer; var hpline: linearray);
    procedure GetManaValue(u: tUnitData; p: pEvent; pstats: reventstat;
      x: integer; var hpline: linearray);
    procedure GetHpValueDeath(u: tUnitData; p: pEvent; pstats: reventstat;
      x: integer; var hpline: linearray);
    function AssignFilterFromtree(evaluatedefault, checkDefault: boolean)
      : boolean;
    procedure SaveFilter;
    procedure resetFilterState(Sender: TBaseVirtualTree; initialstate: boolean;
      index: integer);
    procedure assign_icon(list_i: TImageList; filename: string;
      startId: integer);
    procedure toggledetailledview(u: tUnitData);
    function loadLog(initialdir: string): string;

    procedure LoadCompareFile(filename: string);
    procedure SaveCompareFile(filename: string);
    procedure renameLiveLog(optRenameName: string);
    procedure ValidateCompareLine(var linecomment: string;
      var linecolor: tcolor; openlinewin: boolean);
    procedure realtimeQstat(finalyze: boolean);
    procedure BatchLogs;
    procedure getLogIndex;
    function generateLogIndex(RestrictBoss: integer;
      HMonly, useCache: boolean): boolean;
    procedure definepathlogindex;
    procedure WMDropFiles(var Msg: TMessage); message WM_DROPFILES;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function sortdrawlist(p1, p2: Pointer): integer;
function sortauralinelist(p1, p2: Pointer): integer;

function FileOperation(const Source, dest: string; op, flags: integer): boolean;

implementation

uses wcr_spellOpt, wcr_UnitOpt, wcr_exportstat, wcr_saveopt, wcr_AddLine,
  wcr_Unitlist, wcr_Spelllist, wcr_options, wcr_error;
{$R *.dfm}

procedure testbossinfoList(memo: TMemo);
var
  pB: pBossInfoLog;
  i: integer;
begin
  for i := 0 to bossinfoList.count - 1 do
  begin
    pB := bossinfoList[i];
    memo.lines.add(pB.name);
  end;
  memo.lines.add(format('Deathevent: %d', [Form1.EventDeathlist.count]));
end;

procedure TForm1.WMDropFiles(var Msg: TMessage);
var
  hDrop: THandle;
  filename: array [0 .. 255] of char;
begin
  hDrop := Msg.wParam;
  DragQueryFile(hDrop, 0, filename, length(filename));
  DragFinish(hDrop);
  if not bWhileparsing then
    launchParsing(filename, EMPTYBOSSSTRING, false)
  else
    beep;
end;

function FileOperation(const Source, dest: string; op, flags: integer): boolean;
var
  shf: TSHFileOpStruct;
  s1, s2: string;
begin
  { Send a file to the trashcan
    FileOperation (filename, '', FO_DELETE, FOF_ALLOWUNDO + FOF_NOCONFIRMATION);
    }
  FillChar(shf, SizeOf(shf), #0);
  s1 := Source + #0#0;
  s2 := dest + #0#0;
  shf.Wnd := 0;
  shf.wFunc := op;
  shf.pFrom := pchar(s1);
  shf.pTo := pchar(s2);
  shf.fFlags := flags;
  Result := SHFileOperation(shf) = 0;
end;

constructor TNodeData.create(pTmp: pEvent);
begin
  p := pTmp;
end;

// tree

procedure TForm1.showlogerror(erreur: string);
begin
  MemoError.lines.add(TimeToStr(Time) + ':   ' + erreur);
end;

procedure TForm1.assign_icon(list_i: TImageList; filename: string;
  startId: integer);
var
  bitfile, bittmp, bittmp2: tbitmap;
  i: integer;
  MyRect, MyOther: TRect;
begin
  bitfile := tbitmap.create;
  bittmp := tbitmap.create;
  bittmp2 := tbitmap.create;
  try
    try
      if fileexists(filename) then
        bitfile.loadfromfile(filename);
      bittmp.width := list_i.width;
      bittmp.height := list_i.height;
      bittmp2.width := list_i.width;
      bittmp2.height := list_i.height;
      for i := startId to (bitfile.width div list_i.width) do
      begin
        MyRect := Rect(i * list_i.width, 0, i * list_i.width + list_i.width,
          list_i.height);
        MyOther := Rect(0, 0, list_i.width, list_i.height);
        bittmp.Canvas.CopyRect(MyOther, bitfile.Canvas, MyRect);
        bittmp2.Canvas.draw(0, 0, bittmp);
        bittmp2.Monochrome := true;
        list_i.add(bittmp, bittmp2);
      end;
    except
      showmessage(ICON_ERROR);
    end;
  finally
    bitfile.free;
    bittmp.free;
    bittmp2.free;
  end;
end;

function TForm1.dontdisturb: boolean;
begin
  Result := bDontdisturb or (Eventlist.count = 0);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
  m, d: Word;
begin
  font.name := MAIN_FONT;
  ERRORCHECKPOINT := 0;
  DecimalSeparator := '.';
  DecodeDate(Date, DATETIME_YEAR, m, d);
  DragAcceptFiles(Handle, true);
  bDontdisturb := true;
  firsttimeLaunch := true;
  bWhileparsing := false;
  bwhilebatching := false;
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
  mainpath := ExtractFilePath(Application.Exename);
  datapath := mainpath + 'datas\';
  if not directoryexists(datapath) then
    Raise Exception.create(
      'Data directory not found, please reinstall WowCardioRaid');
  docpath := mainpath + 'docs\';
  firsttime := true;
  InitBitmap;
  InitBitmap2;
  authKeyDown := true;
  Caption := PROG_VERS;
  mousedetect.stream_mapnode := tmemorystream.create;
  MyTree.NodeDataSize := SizeOf(rTreeData);
  setReplay_circle(true);
  replay.angle := 90;
  replay.playercircle := 500;
  UnitStatTree.NodeDataSize := SizeOf(rtreeGenericdata);
  unitTree.NodeDataSize := SizeOf(rtreeGenericdata);
  ChatTree.NodeDataSize := SizeOf(rtreeGenericdata);
  SpellTree.NodeDataSize := SizeOf(rtreeGenericdata);
  EventTree.NodeDataSize := SizeOf(rtreeGenericdata);
  StatTree.NodeDataSize := SizeOf(rtreeGenericdata);
  CompareTree.NodeDataSize := SizeOf(rtreeGenericdata);
  CustomFilterTree.NodeDataSize := SizeOf(rtreeGenericdata);
  FilterTree.NodeDataSize := SizeOf(rFilterDatanode);
  TimeTree.NodeDataSize := SizeOf(rTimeDatanode);
  WatchedEventTree.NodeDataSize := SizeOf(rtreeGenericdata);
  LogList := tlist.create;
  Eventlist := tlist.create;
  EventDeathlist := tlist.create;
  CombatBlockList := tlist.create;
  LocalStatList := tlist.create;
  EventIgnoredlist := tlist.create;
  drawedList := tlist.create;
  eventtypelist := tlist.create;
  unitArray := tlist.create;
  spellArray := tlist.create;
  unitList := tlist.create;
  bossinfoList := tlist.create;
  initreplay;
  dummySpellInfo := tspellinfo.initdata(0, 0, '', emptySpellParam);
  dummypEvent := pEvent.create;
  for i := low(markedlist) to high(markedlist) do
    markedlist[i] := tlist.create;
  unknownEventlist := tstringlist.create;
  ProgressBar1.Parent := StatusBar1;
  ProgressBar1.SetBounds(0, 2, StatusBar1.Panels[0].width - 1,
    StatusBar1.height - 3);
  // --hint&ressources---
  Hinttemplate := gethinttemplate(datapath, HINT_TEMPLATE);
  HintStatstemplate := gethinttemplate(datapath, HINT_STATS_TEMPLATE);
  HintChattemplate := gethinttemplate(datapath, HINT_CHAT_TEMPLATE);
  HintStatsDtemplate := gethinttemplate(datapath, HINT_STATS_DTEMPLATE);
  htmlTemplateIndex := getHtmlTemplate(datapath, HTML_TEMPLATE_INDEX);
  htmlTemplateMenu := getHtmlTemplate(datapath, HTML_TEMPLATE_MENU);
  HtmlStatsTemplate := gethinttemplate(datapath, Html_Stats_Template);
  init_tStringlist(TTString, datapath, HINT_STATS_DTEMPLATE_STRING);
  init_tStringlist(H_res, datapath, RES_TIP_FIC);
  // assign_icon(imagelist1, datapath + 'icon_a.bmp', 0);
  // assign_icon(imagelist2, datapath + 'icon_b.bmp', 0);
  assign_icon(imagelist3, datapath + 'ico32.bmp', 8);

  Application.ShowHint := true;
  HintWindowClass := TCartoHint;
  Application.hintpause := 500;
  Application.HintHidePause := TOOLTIP_HIDEPAUSE;
  MARGE_HAUT := MARGE_HAUT_DEFAULTMIN;
  MARGE_RAID_BACK := MARGE_RAID_DEFAULT;
  MARGE_NAME := MARGE_NAME_DEFAULT;
  HintTimer.Interval := HINT_DELAY;
  Label4.Caption := COMPARETOOLTIP;
  globalFocusType := focusIsBoth;
  authStatResize := false;
  //
  i := GenerateListHash;
  if i > 0 then
    showmessage(format('Warning: [%d] DuplicateHash(s) ', [i]));

  // ---------

  Init_caption(Form1);
  resetParamGraph;
  // ressources
  donjonlist := tlist.create;
  ParseBaseFile(datapath + FILE_DONJON, '|', 3, BuildDonjonList);
  ParseBaseFile(datapath + FILE_SPECIALSUMMON, ',', 7, createSpecialSummon);

  // stats
  CreateWatchList;
  setWatchedEventComboBox(0);
  buildWatchedEvent(0);
  // customfilter
  defaultFilter := tfilterdata.initdata(true, '');
  defaultFilter.Node := CustomFilterTree.AddChild(nil,
    TNodeGenericData.create(defaultFilter));
  // livetimer
  livelogFile := '';
  // -----
  windowpos.width := 800;
  windowpos.height := 600;
  windowpos.top := 50;
  windowpos.left := 50;
  // prefs
  setdefaultprefs;
  loadprefs;
  setIcon;
  Stat_Typo;
  // -unitsortmode

  case prefs.sortunitmode of
    1:
      Unittreesort1.checked := true;
    2:
      Unittreesort2.checked := true;
  else
    Unittreesort0.checked := true;
  end;
  // base size
  setBaseVar(prefs.InterfaceScale);
  LiveUpdateTimer.Interval := LIVE_TIMER[prefs.LiveUpdateTimer].Timer;
  // ----------
  Stat_ShowActDpsClick(nil);
  // -------
  if not directoryexists(logpath) then
    logpath := mainpath;
  if not directoryexists(comparepath) then
    comparepath := mainpath;
  prefs.livelogpath := livelogFile;
  // position:
  if windowpos.width > screen.width then
    width := screen.width
  else
    width := windowpos.width;
  if windowpos.height > screen.height then
    height := screen.height
  else
    height := windowpos.height;
  top := windowpos.top;
  left := windowpos.left;

  // html
  headerString := tstringlist.create;
  if fileexists(datapath + HTM_HEADER) then
    headerString.loadfromfile(datapath + HTM_HEADER);
  // ------
  if prefs.openOnIndex and (paramstr(1) = '') then
    getLogIndex
  else
    openHtmFile(READ_ME, ReadMeViewer);

  // caption := format('event:%d internal:%d params:%d',[sizeof(eventType),sizeof(eventInternalParams),sizeof(eventParams)]);
end;

procedure TForm1.setIcon;
var
  tmp: tbitmap32;
  i: integer;
begin
  tmp := tbitmap32.create;
  try
    if fileexists(datapath + FILE_ICO32) then
      tmp.loadfromfile(datapath + FILE_ICO32);
    for i := low(markedicon) to high(markedicon) do
      markedicon[i] := get_icon32(tmp, SIZE_ICO32, i - 1);
    for i := 1 to 3 do
      iconrole[i] := get_icon32(tmp, SIZE_ICO32, i + 7);
  finally
    tmp.free;
  end;
end;

procedure TForm1.ForcePlayerInRaid1Click(Sender: TObject);
var
  i: integer;
  p: pEvent;
begin
  if assigned(paramGraph.MenuActiveUnitGfx) then
  begin
    // faking unit in raid
    paramGraph.MenuActiveUnitGfx.params :=
      paramGraph.MenuActiveUnitGfx.params + [upWasInRaid, upWasPlayerInRaid,
      upWasFriend];
    // faking event
    for i := 0 to Eventlist.count - 1 do
    begin
      p := Eventlist.items[i];
      if p.sourceUnit = paramGraph.MenuActiveUnitGfx then
      begin
        include(p.params, eventIsInitbyRaidUnit)

      end;
      if p.destUnit = paramGraph.MenuActiveUnitGfx then
      begin
        include(p.params, eventIsReceivedbyRaidUnit)
      end;
    end;
    // finalizing
    generateBossIndex;
    generateCombatBlock;
    unitTree.repaint;
    completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats, RefreshMap]);
    LogStatsOutput;
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  if firsttimeLaunch then
  begin
    Application.ProcessMessages;
    // lancement auto
    if paramstr(1) <> '' then
      if fileexists(paramstr(1)) then
        launchParsing(paramstr(1), EMPTYBOSSSTRING, false);
    firsttimeLaunch := false;
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if bWhileparsing then
  begin
    CanClose := false;
    beep;
  end;
end;

procedure TForm1.assignLineType(l: linearraytype);
begin
  paramGraph.linetype := l;
  case l of
    lineHp:
      gfxtb1.down := true;
    lineDps:
      gfxtb2.down := true;
    lineHeal:
      gfxtb3.down := true;
  end;
end;

procedure TForm1.resetParamGraph;
var
  i: integer;
begin
  paramGraph.auralines.free;
  paramGraph.Rotationlines.eventIn.free;
  paramGraph.Rotationlines.eventOut.free;
  paramGraph.Rotationlines.total[0].free;
  paramGraph.Rotationlines.total[1].free;

  for i := 1 to high(paramGraph.lines) do
    paramGraph.lines[i].eventarray := nil;

  FillChar(paramGraph, SizeOf(paramGraph), 0);
  paramGraph.startDrawEventId := -1;
  for i := 1 to high(paramGraph.startDrawMarkId) do
    paramGraph.startDrawMarkId[i] := -1;
  paramGraph.dragging := drag_0;
  paramGraph.DrawEvent := true;
  paramGraph.DrawHpline := true;
  assignLineType(lineHp);
  paramGraph.dpsInterval := DEFAULT_INSTADPSINTERVAL;
  paramGraph.FocusedAura := -1;
  paramGraph.FocusedRotation := -1;
  paramGraph.FocusedAuraUnit := nil;
  paramGraph.imagemap_zoom := 50.0;
  resetReglette;
  if not assigned(paramGraph.auralines) then
    paramGraph.auralines := tlist.create;
  if not assigned(paramGraph.Rotationlines.eventIn) then
    paramGraph.Rotationlines.eventIn := tlist.create;
  if not assigned(paramGraph.Rotationlines.eventOut) then
    paramGraph.Rotationlines.eventOut := tlist.create;
  for i := 0 to 1 do
    if not assigned(paramGraph.Rotationlines.total[i]) then
      paramGraph.Rotationlines.total[i] := trotationline.initTotalNode;
end;

procedure TForm1.resetReglette;
begin
  paramGraph.reglette[0] := -1;
  paramGraph.reglette[1] := -1;
  paramGraph.reglettetime := '';
end;

procedure TForm1.resetParamGraphFocusedData;
var
  i: integer;
  auraline: tauraline;
begin
  if assigned(paramGraph.auralines) then
  begin
    for i := 0 to paramGraph.auralines.count - 1 do
    begin
      auraline := paramGraph.auralines.items[i];
      // on nettoie les offsets
      if assigned(auraline.spell) then
        tspellinfo(auraline.spell).offsetaura := 0;
      auraline.destroy;
    end;
    paramGraph.auralines.clear;
  end;
end;

procedure TForm1.clearRotationlines;
var
  i: integer;
begin
  clearUnitStatTree;
  if assigned(paramGraph.Rotationlines.eventIn) then
  begin
    for i := 0 to paramGraph.Rotationlines.eventIn.count - 1 do
      trotationline(paramGraph.Rotationlines.eventIn.items[i]).destroy;
    paramGraph.Rotationlines.eventIn.clear;
  end;
  if assigned(paramGraph.Rotationlines.eventOut) then
  begin
    for i := 0 to paramGraph.Rotationlines.eventOut.count - 1 do
      trotationline(paramGraph.Rotationlines.eventOut.items[i]).destroy;
    paramGraph.Rotationlines.eventOut.clear;
  end;
  paramGraph.Rotationlines.total[0].clearstat;
  paramGraph.Rotationlines.total[1].clearstat;
end;

procedure TForm1.initNPCArray;
var
  p: rInfoUnitItem;
  t: tmemorystream;
  count: integer;
begin
  ERRORCHECKPOINT := 1;
  setlength(npcArray, MAX_NPC_ARRAY_ROW);
  NpcIdMax := 0;
  NpcTotalCount := 0;
  npcArray[0] := tunitinfo.initdata(UNIT_IS_NIL_NAME, 0, 0,
    newConstantUnitParam, true, unitIsnil, []);
  if not fileexists(datapath + NPC_OPTION_LIST) then
    exit;
  t := tmemorystream.create;
  try
    try
      t.loadfromfile(datapath + NPC_OPTION_LIST);
      t.Position := 0;
      repeat
        FillChar(p, SizeOf(p), 0);
        count := t.read(p, SizeOf(p));
        if (count <> SizeOf(p)) then
          break;
        // ----
        if InRange(p.id, low(npcArray), high(npcArray)) then
          npcArray[p.id] := tunitinfo.initdata(utf8tostring(p.name), 0, p.id,
            p.cUnitParam, false, unitIsNpc, []);
      until t.Position >= t.Size;
    except
    end;
  finally
    t.free;
  end
end;

procedure TForm1.saveNPCArray;
var
  t: tmemorystream;
  i: integer;
  p: rInfoUnitItem;
begin
  if high(npcArray) > 0 then
  begin
    t := tmemorystream.create;
    for i := 1 to high(npcArray) do
    begin
      if assigned(npcArray[i]) and (npcArray[i].hasConstantParams)
        then
      begin
        FillChar(p, SizeOf(p), 0);
        p.name := UTF8EncodeToShortString(npcArray[i].name);
        p.id := npcArray[i].mobId;
        p.cUnitParam := npcArray[i].constantParams;
        //if p.cUnitParam.option1*[uoIsBoss, uoIsBossAffiliated] <>[] then include(p.cUnitParam.option1,uoReplayEmphasis);
        t.Write(p, SizeOf(p));
      end
    end;
    t.Position := 0;
    t.SaveToFile(datapath + NPC_OPTION_LIST);
    t.free;
  end;
end;

procedure TForm1.initSpellArray;
var
  p: rInfoSpellItem;
  t: tmemorystream;
  count: integer;
  sp: tspellinfo;
begin
  ERRORCHECKPOINT := 2;
  authsavespellarray := true;
  SpellIdMax := 0;

  // !nospellGeneric
  sp := tspellinfo.initdata(0, 1, NO_SPELL_LABEL, emptySpellParam);
  sp.school := 0;
  addPointertoSortedList(spellArray, compareSpellID, sp);
  // creating swing
  sp := tspellinfo.initdata(6, 1, SWING_LABEL, emptySpellParam);
  sp.sdata := sp.sdata + [spellIsDamage];
  sp.school := 1; // spell physical
  addPointertoSortedList(spellArray, compareSpellID, sp);

  if not fileexists(datapath + SPELL_OPTION_LIST) then
    exit;
  t := tmemorystream.create;
  try
    try
      // lecture des options sauvées
      t.loadfromfile(datapath + SPELL_OPTION_LIST);
      t.Position := 0;
      repeat
        FillChar(p, SizeOf(p), 0);
        count := t.read(p, SizeOf(p));
        if (count <> SizeOf(p)) then
          break;
        addPointertoSortedList(spellArray, compareSpellID,
          tspellinfo.initdata(p.id, 0, utf8tostring(p.name), p.cSpellParams));
        maxspellarrayid := p.id;
      until t.Position >= t.Size;
    except
    end;
  finally
    t.free;
  end
end;

procedure TForm1.saveSpellArray;
var
  t: tmemorystream;
  i: integer;
  p: rInfoSpellItem;
  sp: tspellinfo;
begin
  if SKIP_SPELL_SAVE or not authsavespellarray then
    exit;
  if spellArray.count > 0 then
  begin
    t := tmemorystream.create;
    for i := 0 to spellArray.count - 1 do
    begin
      sp := spellArray[i];
      if sp.hasConstantParams then
      begin
        FillChar(p, SizeOf(p), 0);
        p.name := UTF8EncodeToShortString(sp.name);
        p.id := sp.id;
        p.cSpellParams := sp.constantParams;
        t.Write(p, SizeOf(p));
      end
    end;
    t.Position := 0;
    t.SaveToFile(datapath + SPELL_OPTION_LIST);
    t.free;
  end;
end;

procedure TForm1.saveprefs;
var
  t: tstringlist;
  Node: pvirtualnode;
  dataGeneric: ptreeGenericdata;
  i: integer;
  windata: TWindowPlacement;
begin
  windata.length := SizeOf(windata);
  GetWindowPlacement(Handle, @windata);
  t := tstringlist.create;
  // options diverse
  t.add('NNPC=' + booltostr(GfxNoNpc.checked));
  t.add('NPET=' + booltostr(GfxNoPet.checked));
  t.add('NAFF=' + booltostr(GfxNoAffiliation.checked));
  t.add('BOSS=' + booltostr(GfxAlwaysBoss.checked));
  t.add('IRAI=' + booltostr(GfxShowInactive.checked));
  t.add('NEXT=' + booltostr(GfxNoExternal.checked));
  t.add('OOLF=' + booltostr(prefs.openOnIndex));
  t.add('GFXS=' + inttostr(prefs.InterfaceScale));
  t.add('SSAC=' + booltostr(Stat_ShowActDps.down));
  t.add('GFXW=' + booltostr(GfxDrawStatsWidget.down));
  t.add('USEC=' + booltostr(prefs.useCache));
  // options panels
  t.add('SIZE=' + booltostr(prefs.ResizeStats));
  t.add('NHEA=' + booltostr(Stat_NoEnemyHeal.down));
  t.add('NSEL=' + booltostr(Stat_NoFriendDamage.down));
  t.add('SABS=' + booltostr(Stat_absorb.down));
  t.add('SMEA=' + booltostr(Stat_MergeAbsorb.down));
  t.add('GAUG=' + inttostr(prefs.maxeventinlist));
  t.add('MARG=' + inttostr(MARGE_HAUT));
  t.add('MARR=' + inttostr(MARGE_RAID_BACK));
  t.add('MARN=' + inttostr(MARGE_NAME));
  t.add('CFTH=' + inttostr(CustomFilterTree.height));
  t.add('HTMW=' + inttostr(htmlstats.width));
  t.add('PSUM=' + inttostr(prefs.sortunitmode));
  if prefs.WebLink <> '' then
    t.add('WEBL=' + prefs.WebLink);
  if prefs.UnitWebLink <> '' then
    t.add('UNWL=' + prefs.UnitWebLink);
  if prefs.ArmoryLink <> '' then
    t.add('PNWL=' + prefs.ArmoryLink);
  if prefs.DefaultServerName <> '' then
    t.add('DEFS=' + prefs.DefaultServerName);

  t.add('NSFA=' + booltostr(prefs.NoSpellFailed));
  t.add('CAPO=' + booltostr(prefs.CapOverkill));
  // path
  t.add('PAT1=' + logpath);
  t.add('PAT2=' + livelogFile);
  t.add('PAT3=' + comparepath);
  // -------------
  t.add('UFIA=' + booltostr(useFilterInArray.down));
  t.add('GFDO=' + booltostr(GfxRaidDpsOut.down));
  t.add('GFDI=' + booltostr(GfxRaidDpsIn.down));
  t.add('GFHO=' + booltostr(GfxRaidHpsOut.down));
  t.add('GFEH=' + booltostr(GfxRaidEffHpsOut.down));
  t.add('GFDM=' + booltostr(GfxDrawMarks.down));
  t.add('RATI=' + booltostr(relativeRatio.down));
  t.add('BGLI=' + booltostr(LineOnBG.down));
  t.add('POLW=' + booltostr(prefs.openlinewin));
  t.add('SHNB=' + booltostr(prefs.useShortNumber));
  // livetimer
  t.add('LIVT=' + inttostr(prefs.LiveUpdateTimer));

  // ----------
  // sauvegarde taille windows
  t.add('POSW=' + inttostr(windata.rcNormalPosition.right -
        windata.rcNormalPosition.left));
  t.add('POSH=' + inttostr(windata.rcNormalPosition.bottom -
        windata.rcNormalPosition.top));
  // sauvegarde pos de windows
  t.add('POST=' + inttostr(windata.rcNormalPosition.top));
  t.add('POSL=' + inttostr(windata.rcNormalPosition.left));
  t.add('SPL1=' + inttostr(Panel6.width));
  t.add('SPL2=' + inttostr(Panel7.height));
  t.add('SPL3=' + inttostr(Panel25.height));
  // namecolum stattree
  t.add('SNCL=' + inttostr(StatTree.Header.columns[0].width));
  t.add('UNKU=' + prefs.unknownlabel);
  // filtre
  Node := CustomFilterTree.getfirst;
  Node := CustomFilterTree.GetNext(Node);
  while assigned(Node) do
  begin
    dataGeneric := CustomFilterTree.GetNodeData(Node);
    t.add('FILT=' + tfilterdata(dataGeneric.BasicND.p).extractsavetext);
    Node := Node.NextSibling; // default filter non sauvé
  end;
  // blacklist
  for i := 0 to ListBox1.items.count - 1 do
    t.add('BLCK=' + ListBox1.items.Strings[i]);

  try
    t.SaveToFile(mainpath + PREFS_FIC);
  finally
    t.free;
  end;
end;

procedure TForm1.loadprefs;
begin
  ERRORCHECKPOINT := 3;
  loadprefsfiles(datapath + PREFS_FIC_DEFAULT,
    fileexists(mainpath + PREFS_FIC));
  loadprefsfiles(mainpath + PREFS_FIC, false);
end;

procedure TForm1.loadprefsfiles(filename: string; skipfilter: boolean);
var
  t: tstringlist;
  i: integer;
begin
  t := tstringlist.create;
  // filtre
  try
    if fileexists(filename) then
      t.loadfromfile(filename);
    for i := 0 to t.count - 1 do
      analysePrefLine(t.Strings[i], skipfilter);
  finally
    t.free;
  end;
end;

procedure TForm1.analysePrefLine(s: string; skipfilter: boolean);
var
  Header, Value: string;
  tmpvalue: integer;
begin
  Header := copy(s, 1, 5);
  Value := copy(s, 6, length(s));
  if Header = 'FILT=' then
    addcustomfilter(Value, skipfilter)
  else if Header = 'NNPC=' then
    GfxNoNpc.checked := strtobooldef(Value, false)
  else if Header = 'NPET=' then
    GfxNoPet.checked := strtobooldef(Value, true)
  else if Header = 'NAFF=' then
    GfxNoAffiliation.checked := strtobooldef(Value, true)
  else if Header = 'BOSS=' then
    GfxAlwaysBoss.checked := strtobooldef(Value, true)
  else if Header = 'IRAI=' then
    GfxShowInactive.checked := strtobooldef(Value, false)
  else if Header = 'SSAC=' then
    Stat_ShowActDps.down := strtobooldef(Value, true)
  else if Header = 'GFXW=' then
    GfxDrawStatsWidget.down := strtobooldef(Value, true)
  else if Header = 'OOLF=' then
    prefs.openOnIndex := strtobooldef(Value, false)
  else if Header = 'USEC=' then
    prefs.useCache := strtobooldef(Value, true)
  else if Header = 'GFXS=' then
    prefs.InterfaceScale := strtointdef(Value, 2)
  else if Header = 'WEBL=' then
    prefs.WebLink := Value
  else if Header = 'UNWL=' then
    prefs.UnitWebLink := Value
  else if Header = 'PNWL=' then
    prefs.ArmoryLink := Value
  else if Header = 'DEFS=' then
    prefs.DefaultServerName := Value
  else if Header = 'NEXT=' then
    GfxNoExternal.checked := strtobooldef(Value, true)
  else if Header = 'SIZE=' then
    prefs.ResizeStats := strtobooldef(Value, true)
  else if Header = 'NHEA=' then
    Stat_NoEnemyHeal.down := strtobooldef(Value, true)
  else if Header = 'NSEL=' then
    Stat_NoFriendDamage.down := strtobooldef(Value, true)
  else if Header = 'SABS=' then
  begin
    Stat_absorb.down := strtobooldef(Value, false);
    btnAbsorb.down := Stat_absorb.down;
  end
  else if Header = 'SMEA=' then
    Stat_MergeAbsorb.down := strtobooldef(Value, false)
  else if Header = 'GAUG=' then
    prefs.maxeventinlist := strtointdef(Value, 50000)
  else if Header = 'SNCL=' then
    StatTree.Header.columns[0].width := strtointdef(Value, 140)
  else if Header = 'SPL1=' then
    Panel6.width := strtointdef(Value, 208)
  else if Header = 'SPL2=' then
    Panel7.height := strtointdef(Value, 235)
  else if Header = 'SPL3=' then
    Panel25.height := strtointdef(Value, 40)
  else if Header = 'MARG=' then
    MARGE_HAUT := strtointdef(Value, MARGE_HAUT_DEFAULTMIN)
  else if Header = 'MARR=' then
    MARGE_RAID_BACK := strtointdef(Value, MARGE_RAID_DEFAULT)
  else if Header = 'MARN=' then
    MARGE_NAME := strtointdef(Value, MARGE_NAME_DEFAULT)
  else if Header = 'CFTH=' then
    CustomFilterTree.height := strtointdef(Value, 109)
  else if Header = 'PSUM=' then
    prefs.sortunitmode := strtointdef(Value, 3)
  else if Header = 'HTMW=' then
    htmlstats.width := strtointdef(Value, 200)
  else if Header = 'NSFA=' then
    prefs.NoSpellFailed := strtobooldef(Value, true)
  else if Header = 'CAPO=' then
    prefs.CapOverkill := strtobooldef(Value, true)
  else if Header = 'UFIA=' then
    useFilterInArray.down := strtobooldef(Value, true)
  else if Header = 'GFDO=' then
    GfxRaidDpsOut.down := strtobooldef(Value, true)
  else if Header = 'GFDI=' then
    GfxRaidDpsIn.down := strtobooldef(Value, false)
  else if Header = 'GFDM=' then
    GfxDrawMarks.down := strtobooldef(Value, false)
  else if Header = 'GFHO=' then
    GfxRaidHpsOut.down := strtobooldef(Value, false)
  else if Header = 'GFEH=' then
    GfxRaidEffHpsOut.down := strtobooldef(Value, false)
  else if Header = 'POLW=' then
    prefs.openlinewin := strtobooldef(Value, true)
  else if Header = 'RATI=' then
    relativeRatio.down := strtobooldef(Value, false)
  else if Header = 'BGLI=' then
    LineOnBG.down := strtobooldef(Value, true)
  else if Header = 'POSW=' then
    windowpos.width := strtointdef(Value, 800)
  else if Header = 'POSH=' then
    windowpos.height := strtointdef(Value, 600)
  else if Header = 'POST=' then
    windowpos.top := strtointdef(Value, 50)
  else if Header = 'POSL=' then
    windowpos.left := strtointdef(Value, 50)
  else if Header = 'PAT1=' then
    logpath := Value
  else if Header = 'PAT2=' then
    livelogFile := Value
  else if Header = 'PAT3=' then
    comparepath := Value
  else if Header = 'BLCK=' then
    ListBox1.items.add(Value)
  else if Header = 'UNKU=' then
    prefs.unknownlabel := Value
  else if Header = 'LIVT=' then
  begin
    tmpvalue := strtointdef(Value, 2);
    if (tmpvalue > 0) and (tmpvalue <= high(LIVE_TIMER)) then
      prefs.LiveUpdateTimer := tmpvalue;
  end
  else if Header = 'SHNB=' then
  begin
    prefs.useShortNumber := strtobooldef(Value, true);
    if prefs.useShortNumber then
      intToStrEx := inttostrShort
    else
      intToStrEx := inttostrFull;
  end;

end;

procedure TForm1.addcustomfilter(s: string; skipfilter: boolean);
var
  i, j: integer;
  cf: tfilterdata;
  c: char;
  strtmp: string;
begin
  if skipfilter then
    exit;
  i := 0;
  strtmp := '';
  cf := tfilterdata.initdata(false, '');
  for j := 1 to length(s) do
  begin
    c := s[j];
    if c = PARAMSEPARATOR then
    begin
      cf.AssignData(strtmp, i);
      inc(i);
      strtmp := '';
    end
    else
      strtmp := strtmp + c;
  end;
  if cf.isValid then
    cf.Node := CustomFilterTree.AddChild(nil, TNodeGenericData.create(cf))
  else
    cf.free;
end;

procedure TForm1.launchParsing(const filename, bossId: string;
  simpleLoad: boolean);
var
  file_ext: string;
begin
  ERRORCHECKPOINT := 10;
  // interface states
  StatusBar1.Panels[1].Text := '';
  StatusBar1.Panels[2].Text := 'Cleaning...';
  StatusBar1.repaint;
  bDontdisturb := true;

  LiveUpdateCheck.down := false;
  LiveParsing_Fic := '';
  LiveParsing_firststring := true;
  LiveParsing_LastPos := 0;
  LiveParsing_TotalTime := 0;
  LiveParsing_validLiveLog := false;
  openlogcomment := '';
  openlogarrayIndex := true;

  logerror := logNoError;
  logReadErrorCount := 0;
  MemoError.clear;
  CurrentLogError := false;
  AuthUse52Log := false;
  AuthUse54Log := false;
  InitLogLoading;
  CleaningControl(false);

  defaultFilter.clear;
  saveNPCArray;
  saveSpellArray;
  // ----------init&clear------------
  clearRotationlines;
  resetParamGraphFocusedData;
  resetParamGraph;
  ToolButton10.ImageIndex := FOCUSEDMODE_IMAGE[0];
  // clearlist
  drawedList.clear;
  replaylist.clear;
  ChatTree.clear;
  clearEventlist;
  clearCombatBlocklist;
  clearbossinfoList;
  unknownEventlist.clear;
  clearMouseDetect(true);
  clearSpellArray;
  clearUnitArray;
  clearEventTypeList;
  clearMarkedList;
  WatchedEventTree.clear;
  clearWatchList;
  htmlstats.clear;

  // refreshInterface pour esthetique
  Imagemap.repaint;
  PageControl1.Refresh;
  PageControl2.Refresh;
  Panel25.Refresh;
  TimeTree.Refresh;
  MainFilterID := 0;

  // -------------------------

  BuildEventlist;
  // ------------------------
  StartTimeStamp.Time := 0;
  StartTimeStamp.Date := 0;
  CurrentTimeStamp := 0;
  // -----------------
  StatusBar1.Panels[2].Text := '';
  StatusBar1.repaint;

  LiveParsing_validLiveLog := livelogFile = filename;

  // ------
  initNPCArray;
  initSpellArray;
  // ------
  try
    file_ext := lowercase(ExtractFileExt(filename));

    if file_ext = WCRFILE_SUFFIX then
      Loadwcrlog(filename)
    else
      ParseFile(filename);

    if Eventlist.count > 0 then
      FinalysingLogLoading(bossId, simpleLoad);
  finally
    reactivateControls;
    ParsingLogFeedback;
    GraphicTab.show;
  end;
end;

Procedure TForm1.InitLogLoading;
begin
  // invalidate some control
  screen.Cursor := crHourGlass;
  gfx_ResetFilter.enabled := false;
  ToolButton17.enabled := false;
  gfx_ResetFocus.enabled := false;
  SaveWcrFileBut.enabled := false;
  LoadLogBut.enabled := false;
  GaugeBar2.enabled := false;
  GaugeBar3.enabled := false;
  PageControl1.enabled := false;
  PageControl2.enabled := false;
  LiveUpdateCheck.enabled := false;
  LiveUpdateUpdate.enabled := false;
  Panel7.enabled := false;
  // init some vars
  GlobalEndLogTime := 0;
  authKeyDown := true;
  // timers
  LiveUpdateTimer.enabled := false;
end;

procedure TForm1.CleaningControl(IsExtended: boolean);
begin
  // cleaning Controls
  clearUnitStatTree;
  htmlstats.clear;
  htmlstatsMenu.clear;
  unitTree.clear;
  MyTree.clear;
  StatTree.clear;
  TimeTree.clear;
  // cleaning internal unitlist since its restructured directly
  unitList.clear;
  // ------------
  FillChar(masterNode, SizeOf(masterNode), 0);
  // we dont clean filter/spell/event tree to keep filters up
  if not IsExtended then
  begin
    SpellTree.clear;
    EventTree.clear;
    FilterTree.clear;
  end;
end;

procedure TForm1.reactivateControls;
begin
  screen.Cursor := crDefault;
  if LiveParsing_Fic <> '' then
  begin
    LiveUpdateCheck.enabled := true;
    LiveUpdateUpdate.enabled := true;
    LiveUpdateTimer.enabled := LiveUpdateCheck.down;
  end;
  PageControl1.enabled := true;
  PageControl2.enabled := true;
  Panel7.enabled := true;
  LoadLogBut.enabled := true;
  HideEvents.down := not paramGraph.DrawEvent;
end;

procedure TForm1.ParsingLogFeedback;
var
  i: integer;
begin
  // feedback
  for i := 0 to EventIgnoredlist.count - 1 do
    showlogerror('Timestamp Error at: ' + GetRealTimeFromTimeEvent
        (StartTimeStamp, pEventIgnored(EventIgnoredlist.items[i]).t, 0,
        toShowFullTime) + ' (' + inttostr
        (pEventIgnored(EventIgnoredlist.items[i]).count)
        + ' event(s) skipped.)');
  if logReadErrorCount > 0 then
    showlogerror(inttostr(logReadErrorCount)
        + ' read error(s) have been found');
  case logerror of
    logReadError:
      showlogerror('Fatal Read Error');
    logBigSession:
      showlogerror('Session too long, combatlog truncated');
    logInterrupted:
      showlogerror('Parsing interrupted');
    logFicError:
      showlogerror('Fatal Error: Log file can''t be accessed');
    logOldLog:
      begin
        showlogerror('Fatal Error: This log is not a wow 4.2 log');
        // showmessage('Fatal Error: This log is not a wow 4.2 log.'+#13+'Clean up the existing live logs before using WowCardioRaid.');
      end;
  end;
  if MemoError.lines.count > 0 then
  begin
    CurrentLogError := true;
    Imagemap.changed;
  end;
  // reinit
  logerror := logNoError;
  logReadErrorCount := 0;

  StatusBar1.Panels[1].Text := format('Total: %.2fs',
    [LiveParsing_TotalTime / 1000]);
  StatusBar1.Panels[2].Text := '';
  StatusBar1.repaint;
end;

procedure TForm1.play111Click(Sender: TObject);
begin
  TMenuItem(Sender).checked := true;
  replayTimer.Interval := TMenuItem(Sender).tag;
end;

procedure TForm1.FinalysingLogLoading(bossId: string; simpleLoad: boolean);
var
  timedebut, timefin: dword;
begin
  StatusBar1.Panels[1].Text := format('Total: %.2fs',
    [LiveParsing_TotalTime / 1000]);
  ERRORCHECKPOINT := 11;

  if not AuthUse54Log then showmessage('Warning:'+#13+'This log doesnt have advanced ressources'+#13+
                                        'You need to set the advanced log in Wow.'+#13+
                                        'Go to Options->system->Network->check: Advanced log, then restart the game');


  timedebut := GetTickCount;
  StatusBar1.Panels[2].Text := 'Analysing events...';
  StatusBar1.repaint;
  GlobalEndLogTime := pEvent(Eventlist.items[Eventlist.count - 1]).Time;
  BuildSpecialSummon(Eventlist);
  unitTreeInitData;
  AssignData;
  FindFeignDeath(Eventlist, EventDeathlist);
  setReplay_circle(AuthUse54Log);
  // combats block
  generateBossIndex;
  generateCombatBlock;

  //
  FinalizeUnitAffiliation;
  if not simpleLoad then // simpleload = load without rendering after
  begin
    // guessedabsorb
    StatusBar1.Panels[2].Text := 'Computing Absorbs count...';
    StatusBar1.repaint;
    MaxAbsRow := buildAbsorbCount(Eventlist);
    MaxCastRow := buildcastTime(Eventlist, replayCastList);
    buildcastInterrupt(Eventlist);
    // horizBar
    paramGraph.maxtime := pEvent(Eventlist.items[Eventlist.count - 1]).Time;
    paramGraph.hzBarRatio := (pEvent(Eventlist.items[Eventlist.count - 1])
        .Time - pEvent(Eventlist.items[0]).Time) div GAUGEBASERATIO;
    if paramGraph.hzBarRatio < 1 then
      paramGraph.hzBarRatio := 1;
    paramGraph.hzBarBase := pEvent(Eventlist.items[0]).Time;
    GaugeBar3.min := 0;
    GaugeBar3.max := (pEvent(Eventlist.items[Eventlist.count - 1]).Time - pEvent
        (Eventlist.items[0]).Time) div paramGraph.hzBarRatio;
    GaugeBar2.enabled := true;
    GaugeBar3.enabled := true;
    // ---------------------
    unitTree.Expanded[unitTree.getfirst] := true;

    // ValidateButton for filter and select
    paramGraph.unitRef := isUnitRefActive;
    gfx_ResetFocus.enabled := paramGraph.unitRef;
    ToolButton17.enabled := paramGraph.select.state <> sS_empty;
    // init filter
    AssignFilterFromtree(true, false);
    // --Chat---
    defineChatRender;
    // ------------------------
    if dontdisturb then
      bDontdisturb := false;

    if paramGraph.startDrawTime > 0 then
    begin
      completeRefresh([RefreshStats, PostponeUnitRefresh]);
      SetGraphOnTime(paramGraph.startDrawTime)
    end
    else
    begin
      // if not nextCombatBlockGraph then
      if not getBossFightById(bossId) then
      begin
        completeRefresh([RefreshStats, PostponeUnitRefresh]);
        SetGraphOnEvent(Eventlist.items[0], false);
      end;
    end;
  end;
  // -------------------
  SaveWcrFileBut.enabled := true;
  // ------------------
  timefin := GetTickCount;
  LiveParsing_TotalTime := LiveParsing_TotalTime + (timefin - timedebut);
  LogStatsOutput;
{$IFDEF DEBUG}
  testbossinfoList(MemoStat);
{$ENDIF}
end;

procedure TForm1.LiveUpdateTimerTimer(Sender: TObject);
begin
  LiveUpdateTimer.enabled := false;
  ExtendParsing(LiveParsing_Fic);
  LiveUpdateTimer.enabled := LiveUpdateCheck.down;
end;

procedure TForm1.LiveUpdateCheckClick(Sender: TObject);
begin
  if LiveParsing_Fic = '' then
    LiveUpdateCheck.down := false;
  LiveUpdateTimer.enabled := LiveUpdateCheck.down;
end;

procedure TForm1.LiveUpdateUpdateClick(Sender: TObject);
begin
  LiveUpdateTimerTimer(nil);
end;

function TForm1.initStream(filename: string): TfileStream;
begin
  Result := nil;
  try
    Result := TfileStream.create(filename, fmOpenRead + fmShareDenyNone);
  except
    logerror := logFicError;
  end;
end;

function TForm1.validateStream(stream: tstream): boolean;
begin
  Result := true;
  if stream.Size > MAXFILESIZEEXIT then
  begin
    MessageDlg('The log size is more than ' + inttostr
        (MAXFILESIZEEXIT div (1024 * 1024)) + 'mo' + #13 +
        'and will not be loaded.', mtInformation, [mbOk], 0);
    Result := false;
    exit;
  end;
  if stream.Size > MAXFILESIZEALERT then
    Result := MessageDlg('The log size is more than ' + inttostr
        (MAXFILESIZEALERT div (1024 * 1024)) + 'mo' + #13 +
        'do you really want to load it?', mtConfirmation, [mbYes, mbNo], 0)
      = mrYes
end;

procedure TForm1.ParseFile(filename: string);
var
  tLogStream: TfileStream;
begin
  ERRORCHECKPOINT := 12;
  if filename = livelogFile then
  begin
    LiveParsing_Fic := filename;
    if not fileexists(filename) then
      exit;
  end;
  bDontdisturb := true;
  bWhileparsing := true;
  tLogStream := initStream(filename);
  try
    if assigned(tLogStream) and validateStream(tLogStream) then
    begin
      while tLogStream.Position < tLogStream.Size do
      begin
        Application.ProcessMessages;
        if ord(logerror) > 0 then
          break;
        tLogStream.Position := LiveParsing_LastPos;
        readLnFromStream(tLogStream);
      end;
    end;
  finally
    ProgressBar1.Position := ProgressBar1.max;
    tLogStream.free;
    bWhileparsing := false;
  end;
end;

Procedure TForm1.ExtendParsing(filename: string);
var
  tLogStream: TfileStream;
begin
  ERRORCHECKPOINT := 13;
  if not fileexists(filename) then
    exit;
  bWhileparsing := true;
  bDontdisturb := true;

  tLogStream := initStream(filename);
  try
    if assigned(tLogStream) and (LiveParsing_LastPos < tLogStream.Size) then
    begin
      InitLogLoading;
      tLogStream.Position := LiveParsing_LastPos;
      while tLogStream.Position < tLogStream.Size do
      begin
        Application.ProcessMessages;
        if ord(logerror) > 0 then
          break;
        tLogStream.Position := LiveParsing_LastPos;
        readLnFromStream(tLogStream);
        // break;//for testing
      end;
      CleaningControl(true);
      if Eventlist.count > 0 then
        FinalysingLogLoading(EMPTYBOSSSTRING, false);
    end;
  finally
    tLogStream.free;
    ProgressBar1.Position := ProgressBar1.max;
    StatusBar1.Panels[1].Text := format('Total: %.2fs',
      [LiveParsing_TotalTime / 1000]);
    bWhileparsing := false;
    bDontdisturb := Eventlist.count = 0; // need to reassign this if user lauch extend on a compteted log
    reactivateControls;
    ParsingLogFeedback;
  end;
end;

procedure TForm1.readLnFromStream(stream: tstream);
var
  Size: int64;
  s: rawbytestring;
  timedebut, timefin: dword;
begin
  ERRORCHECKPOINT := 15;
  // Initfeedback1
  StatusBar1.Panels[2].Text := 'Parsing events... Press esc to stop';
  StatusBar1.repaint;
  timedebut := GetTickCount;

  // Init parsing
  Size := stream.Position + STREAMBUFFER;
  if Size > stream.Size then
    Size := stream.Size;
  Size := Size - stream.Position;
  SetString(s, nil, Size);
  stream.Read(Pointer(s)^, Size);
  LiveParsing_LastPos := stream.Position;

  // Initfeedback2
  ProgressBar1.min := 0;
  ProgressBar1.max := ceil(stream.Size / (STREAMBUFFER)) * PROGRESSBARREDIVIDER;
  ProgressBar1.tag := floor(((stream.Position - 1) / STREAMBUFFER))
    * PROGRESSBARREDIVIDER;
  ProgressBar1.Position := ProgressBar1.tag;

  // parsing
  readLnSetTextStr(rawbytestring(s), Size);
  // timefeedback
  timefin := GetTickCount;
  LiveParsing_TotalTime := LiveParsing_TotalTime + (timefin - timedebut);
  StatusBar1.Panels[1].Text := format('Estim.: %.2fs',
    [divide((stream.Size - stream.Position) * (timefin - timedebut),
      Size) / 1000]);
end;

Procedure TForm1.readLnSetTextStr(const Value: rawbytestring; Size: integer);
var
  p, OldP, Start, Origine, LastPos: PansiChar;
  s: rawbytestring;
begin
  p := Pointer(Value);
  LastPos := p;
  Origine := p;
  OldP := p;
  if p <> nil then
    while p^ <> #0 do
    begin
      Start := p;
      while not(p^ in [#0, #10, #13]) do
        inc(p); // charInSet(p^,[#0, #10, #13])    seems slower
      SetString(s, Start, p - Start);
      if p^ = #13 then
      begin
        inc(p);
        LastPos := p;
        ParseLine(utf8tostring(s))
      end;
      if p^ = #10 then
      begin
        inc(p);
        LastPos := p;
      end;
      if ord(logerror) > 1 then
        exit;
      if p - OldP > REFRESHPARSEFREQ then
      begin
        ProgressBar1.Position := ProgressBar1.tag + round
          (((p - Origine) * PROGRESSBARREDIVIDER) / Size);
        ProgressBar1.repaint;
        OldP := p;
      end;
    end;
  LiveParsing_LastPos := LiveParsing_LastPos - (p - LastPos);
end;

procedure TForm1.ParseLine(strtmp: String);
var
  p: pEvent;
begin
  // jump over firstline to avoid Utf8 encoding problems
  if LiveParsing_firststring then
  begin
    LiveParsing_firststring := false;
    exit;
  end;
  try
    p := AnalyseEvent(pchar(strtmp));
    if (ord(logerror) <= 2) and assigned(p) then // blockparsing is stopped if error are different than user interrupt (so we can resume later)
    begin
      getEventlist(p);
      Eventlist.add(p);
    end;
  except
    validateError;
  end;
end;

procedure TForm1.validateError;
begin
  inc(logReadErrorCount);
  if logReadErrorCount > MAXREADERROR then
    logerror := logReadError;
end;

function TForm1.AnalyseEvent(p: pchar): pEvent;
var
  i: integer;
  openstring: boolean;
  timetmp: tdatetime;
  timestamptmp: ttimestamp;
  datetmp: integer;
  eventtime: integer;
  Start: pchar;
  hash: Word;
  sGeneric: rParsedString;
const
  SEPARATOR: array [1 .. 40] of char = ('/', ' ', ':', ':', '.', ' ', ',', ',',
    ',', ',', ',', ',', ',', ',', ',', ',', ',', ',', ',', ',', ',', ',', ',',
    ',', ',', ',', ',', ',', ',', ',', ',', ',', ',', ',', ',', ',', ',', ',',
    ',', ',');
  GUILLEMET_CHAR: char = #34;
  ESCAPED_CHAR: char = #92;
begin
  Result := nil;
  // cleanup
  hash := 0;
  // init
  Start := p;
  i := 1;
  openstring := false;
  while p^ <> #0 do
  begin
    if (not openstring) and (p^ = SEPARATOR[i]) then
    begin
      SetString(sGeneric[i], Start, p - Start);
      inc(i);
      inc(p);
      Start := p;
      if (i = 8) then
      begin
        hash := EventHash(sGeneric[7]);
        if prefs.NoSpellFailed and (hashEventTable[hash] = 48) then
          exit; // skip SPELL_CAST_FAIL
        if (hashEventTable[hash] in [54, 55]) then
          exit; // skip skippedevent (challenge start/end)
      end;
      continue;
    end
    else if (p^ = GUILLEMET_CHAR) and ((p - 1)^ <> ESCAPED_CHAR) then
      openstring := not openstring;
    inc(p);
  end;
  SetString(sGeneric[i], Start, p - Start);

  if i < 10 then
  begin
    validateError;
    exit;
  end;

  eventtime := 0;
  timetmp := EncodeDateTime(DATETIME_YEAR, strtointdef(sGeneric[1], 0),
    strtointdef(sGeneric[2], 0), strtointdef(sGeneric[3], 0),
    strtointdef(sGeneric[4], 0), strtointdef(sGeneric[5], 0),
    strtointdef(sGeneric[6], 0));
  timestamptmp := DateTimeToTimeStamp(timetmp);

  if Eventlist.count = 0 then
  begin
    // le 1er event est arrondi à la minute inferieure.
    StartTimeStamp.Date := timestamptmp.Date;
    StartTimeStamp.Time := timestamptmp.Time div 60000 * 60000
  end
  else
  begin
    datetmp := timestamptmp.Date - StartTimeStamp.Date;
    // max session = MAX_DAY_LIMITE days
    if (datetmp >= 0) and (datetmp < MAX_DAY_LIMITE) then
      eventtime := ((timestamptmp.Time - StartTimeStamp.Time) div 10) +
        (datetmp * MAX_CENTI_SECOND)
    else
      logerror := logBigSession;
  end;

  if (ord(logerror) < 2) then
  begin
    if (eventtime >= CurrentTimeStamp) then
    begin
      CurrentTimeStamp := eventtime;
      Result := pEvent.initdata(sGeneric, hash, eventtime, unknownEventlist, i);
    end
    else
      addignoredEvent(CurrentTimeStamp);
  end
end;

procedure TForm1.ParseChatFile(filename: string);
var
  f: textfile;
  strtmp: rawbytestring;
  decodedstr: string;
  c: pChatEvent;
  i: integer;
  fpos: longint;
begin
  ERRORCHECKPOINT := 16;
  bWhileparsing := true;
  ProgressBar1.min := 0;
  ProgressBar1.max := getfilesize(filename);
  i := 0;
  fpos := 0;
  FileMode := fmOpenRead;
  AssignFile(f, filename);
  try
    try
      Reset(f);
      readln(f, strtmp); // lazy jump over the firstEvent to avoid encoded textformat ref
      while not eof(f) do
      begin
        inc(i);
        readln(f, strtmp);
        decodedstr := utf8tostring(strtmp);
        if decodedstr <> '' then
          c := (AnalyseChatEvent(decodedstr))
        else
          c := AnalyseChatEvent(string(strtmp));
        fpos := fpos + length(strtmp);
        if assigned(c) then
          ChatTree.AddChild(nil, TNodeGenericData.create(c));
        if logerror = ChatLogIsEventLog then
          break;
        if i mod APPLICATIONREFRESH = 0 then
        begin
          ProgressBar1.Position := fpos div APPLICATIONREFRESH;
          Application.ProcessMessages
        end;
      end;
    except
      logerror := logReadError;
    end;
  finally
    bWhileparsing := false;
    closeFile(f);
    FileMode := fmOpenReadWrite;
  end;
end;

function TForm1.AnalyseChatEvent(t: string): pChatEvent;
var
  s: array [1 .. 7] of string;
  c: char;
  i, j, tai: integer;
  timetmp: tdatetime;
  timestamptmp: ttimestamp;
  datetmp: integer;
  eventtime: integer;
const
  SEPARATOR: array [1 .. 6] of char = ('/', ' ', ':', ':', '.', ' ');
begin
  Result := nil;
  t := trim(t);
  if t = '' then
    exit;
  i := 1;
  tai := length(t);
  for j := 1 to tai do
  begin
    c := t[j];
    if (i < 7) and (c = SEPARATOR[i]) then
      inc(i)
    else
      s[i] := s[i] + c;
  end;

  // pas de texte
  s[7] := trim(s[7]);
  if s[7] = '' then
    exit;
  // erreur de lecture générale
  if i < 7 then
  begin
    logerror := ChatlogReadError;
    exit;
  end;
  // checking for EventLog
  if pos('SPELL_CAST_SUCCESS', s[7]) >= 1 then
  begin
    logerror := ChatLogIsEventLog;
    exit;
  end;
  timetmp := EncodeDateTime(DATETIME_YEAR, strtointdef(s[1], 0),
    strtointdef(s[2], 0), strtointdef(s[3], 0), strtointdef(s[4], 0),
    strtointdef(s[5], 0), strtointdef(s[6], 0));
  timestamptmp := DateTimeToTimeStamp(timetmp);
  datetmp := timestamptmp.Date - StartTimeStamp.Date;

  if (datetmp >= 0) and (datetmp < MAX_DAY_LIMITE) then
    eventtime := ((timestamptmp.Time - StartTimeStamp.Time) div 10) +
      (datetmp * MAX_CENTI_SECOND)
  else
    exit;
  if eventtime > paramGraph.maxtime then
    exit;

  if (ord(logerror) = 0) then
  begin
    if (eventtime >= CurrentTimeStamp) then
    begin
      CurrentTimeStamp := eventtime;
      Result := pChatEvent.initdata(s[7], eventtime);
    end;
  end;
end;

procedure TForm1.addignoredEvent(t: integer); // t=CurrentTimeStamp
var
  p: pEventIgnored;
  found: boolean;
begin
  found := false;
  if EventIgnoredlist.count > 0 then
  begin
    p := EventIgnoredlist.items[EventIgnoredlist.count - 1];
    if p.t = CurrentTimeStamp then
    begin
      found := true;
      inc(p.count);
    end;
  end;
  if not found then
  begin
    new(p);
    p.t := t;
    p.count := 1;
    EventIgnoredlist.add(p);
  end
end;

procedure TForm1.BuildEventlist;
var
  j: integer;
begin
  for j := 0 to integer( high(eventtype)) do
    eventtypelist.add(tEventType.initdata(j, 0));
end;

procedure TForm1.assignUnittoTree(u: tunitinfo);
var
  Node: pvirtualnode;
  ul: tUnitData;
  i: integer;
begin
  if u.list.count > 0 then
  begin
    Node := unitTree.AddChild(masterNode[ord(u.unittype)],
      TNodeGenericData.create(u));
    for i := 0 to u.list.count - 1 do
    begin
      ul := u.list.items[i];
      ul.params := ul.params + u.params; // on profite de la boucle pour assigner les parametres generiques de l'unité
      ul.pnode := unitTree.AddChild(Node, TNodeGenericData.create(ul));
      // stats
      inc(NpcTotalCount);
      // internalId
      if ul.internalId = 0 then
        ul.internalId := NpcTotalCount;
    end;
  end;
end;

procedure TForm1.validdatablock(l0, l1, l2: tlist; datatime: pTimeDatanode);
var
  i: integer;
begin
  for i := 0 to l0.count - 1 do
    if pEvent(l0.items[i]).Time <= datatime.lastCombattime then
      inc(datatime.playercount);
  for i := 0 to l1.count - 1 do
    if pEvent(l1.items[i]).Time <= datatime.lastCombattime then
      inc(datatime.playerdeathcount);
  for i := 0 to l2.count - 1 do
    if pEvent(l2.items[i]).Time <= datatime.lastCombattime then
      dec(datatime.playerdeathcount);
end;

procedure TForm1.generateBossIndex;
  function getproperNpcUnit(p: pEvent): tUnitData;
  begin
    if (eventIsInitbyRaidUnit in p.params) and
      (getUnitType(p.destUnit) = unitIsNpc) then
      Result := p.destUnit
    else if (eventIsReceivedbyRaidUnit in p.params) and
      (getUnitType(p.sourceUnit) = unitIsNpc) then
      Result := p.sourceUnit
    else
      Result := nil;
  end;

var
  i, j: integer;
  datatime: pTimeDatanode;
  ul: tUnitData;
  opts: unitOpts;
  sopts: rConstantSpellParams;
  p: pEvent;
  Node, nodetmp: pvirtualnode;
  tmpid, AfterdeathTime, afterdeathId: integer;
  larray: array [0 .. 2] of tlist;
begin
  ERRORCHECKPOINT := 20;
  paramGraph.select.pnode := nil;
  // ------BOSS Index
  randomize;
  StatusBar1.Panels[2].Text := 'Finding Boss...';
  StatusBar1.repaint;
  TimeTree.clear;
  TimeTree.BeginUpdate;
  datatime := nil;
  Node := nil;
  AfterdeathTime := 0;
  afterdeathId := -1;

  for i := 0 to 2 do
    larray[i] := tlist.create;

  for i := 0 to Eventlist.count - 1 do
  begin
    p := Eventlist.items[i];
    // checkspecial spell (HM and bossEnds)
    sopts := getSpellParams(p.spell);

    if spellExcludeForBoss in sopts.option2 then
      continue;

    if assigned(datatime) then
    begin
      // closing block after NOACTION
      if (datatime.lastCombattime < p.Time - datatime.timemout) then
      begin
        validdatablock(larray[0], larray[1], larray[2], datatime);
        if (datatime.HeuristicCheck) and
          ((datatime.playercount - datatime.playerdeathcount) >
            (datatime.playercount div 5)) then
        begin
          if ((datatime.playercount - datatime.playerdeathcount) <=
              ((datatime.playercount div 3) + 2)) then
            datatime.checkforwipe := false;
          datatime.deathcount := 0;
          AfterdeathTime := p.Time + AFTERDEATHTHRESHOLDLOW;
        end;
        datatime := nil;
        continue;
      end;

      // check for bossdead
      if p.event = event_UNIT_DIED then
        if assigned(p.destUnit) then
        begin

          // checking player death
          if (eventisdeath in p.params) and
            (p.destUnit.uGUID.unittype = unitisplayer) and
            (p.destUnit.inBosslist = datatime.randomId) and
            (p.destUnit.inBosslistDeath <> datatime.randomId) then
          begin
            p.destUnit.inBosslistDeath := datatime.randomId;
            larray[1].add(p);
            if (datatime.HeuristicCheck) then
            begin
              inc(datatime.nbAction);
              datatime.lastCombattime := p.Time;
              datatime.lasteventId := i;
            end;
            continue;
          end;

          if (datatime.deathcount > 0) then
            if (datatime.bossId = p.destUnit.uGUID.mobId) or
              (datatime.bossId = GetUnitOptionMobId(p.destUnit)) then
            begin
              if uoCheckfordeath in GetUnitOption(p.destUnit) then
              begin
                dec(datatime.deathcount);
                inc(datatime.nbAction);
                datatime.lastCombattime := p.Time;
                datatime.lasteventId := i;
                // reinit
                if datatime.deathcount <= 0 then
                begin
                  validdatablock(larray[0], larray[1], larray[2], datatime);
                  datatime := nil;
                  AfterdeathTime := p.Time + AFTERDEATHTHRESHOLD;
                end;
                continue;
              end;
            end;
        end;

      // counting player
      if not(eventisaura in p.params) then
        if assigned(p.sourceUnit) and
          (p.sourceUnit.uGUID.unittype = unitisplayer) and
          (p.sourceUnit.inBosslist <> datatime.randomId) then
        begin
          p.sourceUnit.inBosslist := datatime.randomId;
          larray[0].add(p);
        end;

      // HM
      if not(bossishm in datatime.bossopts) then
        if spellisHM in sopts.option2 then
          include(datatime.bossopts, bossishm);

      // closeevents
      if datatime.AuthCheckEvent and (byte(ord(p.event)) = sopts.eventID) and
        (spellCloseBossEvent in sopts.option2) then
      begin
        datatime.lastCombattime := p.Time;
        datatime.lasteventId := i;
        datatime.deathcount := 0;
        AfterdeathTime := p.Time + AFTERDEATHTHRESHOLD;
        validdatablock(larray[0], larray[1], larray[2], datatime);
        datatime := nil;
        continue;
      end;

      // deathcount, resurrect support
      if (p.event = event_SPELL_RESURRECT) and assigned(p.destUnit) and
        (p.destUnit.uGUID.unittype = unitisplayer) and
        (p.destUnit.inBosslistDeath = datatime.randomId) then
      begin
        larray[2].add(p);
        p.destUnit.inBosslistDeath := 0;
      end;
    end; // if assigned(datatime)

    // ------mesuring bossblock
    if (eventIsCombat in p.params) then
    begin
      ul := getproperNpcUnit(p);
      opts := GetUnitOption(ul);

      if uoIsBoss in opts then
        tmpid := ul.uGUID.mobId
      else if uoIsBossAffiliated in opts then
        tmpid := GetUnitOptionMobId(ul)
      else
        tmpid := 0;

      if (tmpid <> 0) then
      begin
        if assigned(datatime) then
        begin
          // si il n'y a eu que LOWACTION_THRESHOLD action hostile depuis LOWACTION_TIMETHRESHOLD secondes, alors on annule le depart du combat
          if (datatime.nbAction <= LOWACTION_THRESHOLD) and
            (p.Time > datatime.startCombattime + LOWACTION_TIMETHRESHOLD) then
          begin
            TimeTree.DeleteNode(Node);
            datatime := nil;
            continue;
          end;
          inc(datatime.nbAction);
          datatime.lastCombattime := p.Time;
          datatime.lasteventId := i;
        end
        else
        begin
          // checking new block validity
          if (afterdeathId = tmpid) and (p.Time < AfterdeathTime) then
            continue;

          // dont starblock on some eventype that can cause misinterpreting
          if (p.event = event_SPELL_MISSED) and
            ((eventIsMitigatigatedResist in p.params) or
              (eventIsMitigatigatedImmune in p.params) or
              (eventIsMitigatigatedEvade in p.params)) then
            continue;
          // otherwise, lets add a new bossblock
          Node := TimeTree.AddChild(nil, datatime);
          for j := 0 to 2 do
            larray[j].clear;
          datatime := TimeTree.GetNodeData(Node);

          datatime.bossopts := [];
          datatime.debuffremovedtime := 0;
          datatime.debuffremoved := 0;
          datatime.starteventId := i;
          datatime.lasteventId := i;
          datatime.startCombattime := p.Time;
          datatime.lastCombattime := p.Time;
          datatime.randomId := p.Time + random($FF);
          datatime.nbAction := 1;
          datatime.playercount := 0;
          datatime.playerdeathcount := 0;
          datatime.bossId := tmpid;
          datatime.deathcount := npcArray[tmpid].constantParams.option2;
          datatime.AuthCheckEvent := false;

          afterdeathId := tmpid;
          AfterdeathTime := 0;

          if npcArray[tmpid].constantParams.timeOut > 0 then
            datatime.timemout := npcArray[tmpid].constantParams.timeOut * 100
          else
            datatime.timemout := OOCTHRESHOLD;
          if uoHeuristicCheck in npcArray[tmpid].constantParams.option1 then
          begin
            datatime.deathcount := 1;
            datatime.HeuristicCheck := true;
          end;
          if uoCheckForSpecialEvent in npcArray[tmpid]
            .constantParams.option1 then
          begin
            datatime.deathcount := 1;
            datatime.AuthCheckEvent := true;
          end;
          datatime.checkforwipe := (datatime.deathcount > 0);
        end;
      end; // if (tmpid <>0) then
    end; // if (eventIsCombat in p.params) then
  end; // for i:= 0 to eventlist.count-1 do

  // closing last block if it's still open
  if assigned(datatime) then
  begin
    validdatablock(larray[0], larray[1], larray[2], datatime);
    if (datatime.HeuristicCheck) and
      ((datatime.playercount - datatime.playerdeathcount) >
        (datatime.playercount div 5)) then
    begin
      if ((datatime.playercount - datatime.playerdeathcount) <=
          ((datatime.playercount div 3) + 2)) then
        datatime.checkforwipe := false;
      datatime.deathcount := 0;
    end;
  end;

  // ------purge: si le combat dure NOCTHRESHOLD secondes, on le supprime de l'index (uniquement pour bosscombat
  Node := TimeTree.getfirst;
  while assigned(Node) do
  begin
    datatime := TimeTree.GetNodeData(Node);
    nodetmp := Node.NextSibling;
    if datatime.playercount > BIGRAIDNUMBERMIN then
      include(datatime.bossopts, bossis25);
    if (datatime.lastCombattime - datatime.startCombattime) < NOCTHRESHOLD then
      TimeTree.DeleteNode(Node);
    Node := nodetmp;
  end;

  // freeing stuff
  for i := 0 to 2 do
    larray[i].free;

  TimeTree.endupdate;
  // ------BOSS Index
  StatusBar1.Panels[2].Text := '';
  StatusBar1.repaint;
end;

procedure TForm1.generateCombatBlock;
var
  p: pEvent;
  i, j: integer;
  unitregistered: boolean;
  cb: tcombatBlock;
  lasttime, openBossBlock: integer;
  u: tunitinfo;
  Node, newfirstnode: pvirtualnode;
  datatime: pTimeDatanode;
  tagopt: string;
begin
  ERRORCHECKPOINT := 21;
  StatusBar1.Panels[2].Text := 'Finding CombatBlock...';
  StatusBar1.repaint;
  // the module is also used to set some special param on unit - lets cleanup
  for i := 0 to unitList.count - 1 do
    tunitinfo(unitList.items[i]).clearDynamicParams;

  // init
  clearCombatBlocklist;
  lasttime := -1;
  newfirstnode := TimeTree.getfirst;
  openBossBlock := -1;
  cb := nil;
  for i := 0 to Eventlist.count - 1 do
  begin
    p := Eventlist.items[i];
    // reset param combat
    exclude(p.internalParams, eventInternalIsInCombatBlock);
    // init;
    u := nil;

    // priority for BossSections
    Node := newfirstnode;
    while assigned(Node) do
    begin
      datatime := TimeTree.GetNodeData(Node);
      if (openBossBlock < 0) and (i = datatime.starteventId) then
      begin
        openBossBlock := datatime.bossId;

        cb := tcombatBlock.initdata(p.Time, i, Node);
        CombatBlockList.add(cb);
        cb.containBoss := openBossBlock;
        cb.bossopts := datatime.bossopts;
        cb.bossdown := datatime.deathcount <= 0;
        cb.txtBOSSID := inttohex(datatime.bossId, 6) + inttohex
          (byte(datatime.bossopts), 1);
        lasttime := p.Time;
        break;
      end;
      if (openBossBlock > 0) and (i = datatime.lasteventId) then
      begin
        cb.timestop := p.Time;
        cb.eventstop := i;
        openBossBlock := -1;
        newfirstnode := Node.NextSibling;
        lasttime := -1;
        break;
      end;
      Node := Node.NextSibling;
    end;

    // la boucle sert aussi a assigner le tags upWasNpcVsRaid aux NPC et le tag eventInternalIsRaidvsWorld de p.internalParams
    if not(eventIsFriendlyVsFriendly in p.params) and
      ((eventIsBothSide in p.params) and not(eventIsself in p.params)) and
      (eventIsCombat in p.params) then
    begin
      // check for dest
      if (eventIsInitbyRaidUnit in p.params) then
        if upIsValidNPC in p.destUnit.params then
        begin
          include(p.internalParams, eventInternalIsValidForStatAuth);
          include(p.destUnit.params, upWasNpcVsRaid);
          u := getunitinfo(p.destUnit);
        end;
      // check for Source
      if (eventIsReceivedbyRaidUnit in p.params) then
        if upIsValidNPC in p.sourceUnit.params then
        begin
          include(p.internalParams, eventInternalIsValidForStatAuth);
          include(p.sourceUnit.params, upWasNpcVsRaid);
          u := getunitinfo(p.sourceUnit);
        end;
    end;

    // handle only healing/buff activity  for raid to raid
    if (eventIsInitbyRaidUnit in p.params) and
      (eventIsReceivedbyRaidUnit in p.params) then
      include(p.internalParams, eventInternalIsValidForStatAuth);

    // combatblock si l'unité est elligible
    if assigned(u) then
    begin
      if uoisBan in u.constantParams.option1 then
        continue;

      if openBossBlock < 0 then
        if (lasttime = -1) or (p.Time - lasttime > OOCBLOCKTHRESHOLD) then
        begin
          cb := tcombatBlock.initdata(p.Time, i, nil);
          cb.containBoss := -1;
          CombatBlockList.add(cb);
        end;

      if assigned(cb) then
      begin
        cb.timestop := p.Time;
        cb.eventstop := i;
        // list d'unité du block
        unitregistered := false;
        for j := 0 to cb.UnitBlock.count - 1 do
          if cb.UnitBlock.items[j] = u then
          begin
            unitregistered := true;
            break;
          end;
        if not unitregistered then
          cb.UnitBlock.add(u);
      end;
      lasttime := p.Time;
    end;
  end;

  // purge des combat trop cours et entete
  for i := CombatBlockList.count - 1 downto 0 do
  begin
    cb := CombatBlockList.items[i];
    if cb.timestop - cb.timestart < 500 then
    begin
      CombatBlockList.Delete(i);
      cb.destroy;
    end
    else
    begin
      if cb.containBoss > 0 then
      begin
        tagopt := '';
        if bossis25 in cb.bossopts then
          tagopt := '25';
        if bossishm in cb.bossopts then
          tagopt := 'HM';
        if tagopt <> '' then
          tagopt := bracket_string(tagopt);
        cb.legende := cb.legende + append_legit_string(cb.legende, ', ') +
          (getunitname(cb.containBoss, [])) + tagopt;
        // cb.color:=$55CCAA55;
        if (cb.bossdown) then
          cb.color := $AACCFF55
        else
          cb.color := $AAFFCC55;
      end
      else
      begin
        cb.legende := TRASH_STRING;
        cb.color := $55FFAAFF;
      end;
      // time:
      cb.legendetime := GetRealTimeFromTimeEvent(StartTimeStamp, cb.timestart,
        0, toShowNormalnoMs);
      cb.legendeduration := GetFormattedLocalTime(cb.timestop - cb.timestart,
        false);
      // global legende
      for j := 0 to cb.UnitBlock.count - 1 do
        cb.legende2 := cb.legende2 + append_legit_string(cb.legende2, ', ') +
          (tunitinfo(cb.UnitBlock.items[j]).name);
    end;
  end;

  // assignation des events de combats
  if CombatBlockList.count > 0 then
  begin
    for i := 0 to CombatBlockList.count - 1 do
    begin
      cb := CombatBlockList.items[i];
      for j := cb.eventstart to cb.eventstop do
        include(pEvent(Eventlist.items[j]).internalParams,
          eventInternalIsInCombatBlock);
    end;
  end;

  // complete friendlyunit;
  for i := 0 to Eventlist.count - 1 do
  begin
    p := Eventlist.items[i];
    defineFriendlyStatus(eventSourceisFriend in p.params, p.sourceUnit);
    defineFriendlyStatus(eventDestisFriend in p.params, p.destUnit);
  end;

  // -----------
  StatusBar1.Panels[2].Text := '';
  StatusBar1.repaint;
end;

procedure TForm1.AssignData;
var
  i, j: integer;
  pET: tEventType;
  p: pEvent;
  Node: pvirtualnode;
  Data: pFilterDatanode;
  cs: TCheckState;
  u: tunitinfo;
  sOpt: spellOpts;
  pstats: reventstat;
  sp: tspellinfo;
begin
  ERRORCHECKPOINT := 22;
  StatusBar1.Panels[2].Text := 'Finalising...';
  StatusBar1.repaint;

  // Transfert des données dans les VirtualTree  et listes generiques
  unitTree.BeginUpdate;
  for i := 1 to high(npcArray) do
    if assigned(npcArray[i]) then
    begin
      unitList.add(npcArray[i]);
      assignUnittoTree(npcArray[i]);
    end;
  for i := 0 to unitArray.count - 1 do
  begin
    unitList.add(unitArray.items[i]);
    assignUnittoTree(tunitinfo(unitArray.items[i]));
  end;
  unitTree.endupdate;

  // get classe and params validation, et section time--------------
  for i := 0 to Eventlist.count - 1 do
  begin
    p := Eventlist.items[i];
    sOpt := getSpellParams(p.spell).option2;
    // assign critical block
    if eventisMitigatigatedblock in p.params then
    begin
      pstats := p.eventStat;
      if pstats.block > pstats.amountGeneric + pstats.absorb +
        pstats.resist then
        include(p.params, eventIsCriticalblock)
      else
        exclude(p.params, eventIsCriticalblock);
    end;

    // secure tagging p for spell
    if assigned(p.spell) then
    begin
      include(p.internalParams, eventInternalIsSpellAssigned);
      if (p.eventStat.absorbpool > 0) or (p.eventStat.fixedAbsorb > 0) then
        include(p.spell.sdata, spellIsFixedAbsb);
      if p.event = event_SPELL_CAST_SUCCESS then
        include(p.spell.sdata, spellisCastSuccess);
      if (p.event = event_SPELL_CAST_START) then
        include(p.spell.sdata, spelluseCastStart);
      if (p.event <> event_SPELL_CAST_SUCCESS) and
        (p.event <> event_SPELL_CAST_START) and not
        (eventisFullmiss in p.params) then
        include(p.spell.sdata, spellisNotOnlyCastSuccess);
      if eventIsDamage in p.params then
        p.spell.sdata := p.spell.sdata + [spellIsDamage];
      if eventIsHeal in p.params then
        p.spell.sdata := p.spell.sdata + [spellIsHeal];
      if eventIsBuff in p.params then
        p.spell.sdata := p.spell.sdata + [spellIsBuff];
      if eventIsDebuff in p.params then
        p.spell.sdata := p.spell.sdata + [spellIsDebuff];
      if eventIsPeriodic in p.params then
        p.spell.sdata := p.spell.sdata + [spellIsPeriodic];
    end;

    if eventIsBothSide in p.params then
    begin
      // affiliation
      if (eventIsInvocation in p.params) or (spellIsaffiliation in sOpt) then
      begin
        if (p.sourceUnit <> p.destUnit) then
        begin
          // exception pet or totem make is own summon (ie: chaman elemental)
          if assigned(p.sourceUnit.UnitAffiliation) then
            p.destUnit.UnitAffiliation := p.sourceUnit.UnitAffiliation
          else
            p.destUnit.UnitAffiliation := p.sourceUnit;
          // si l'unité invoqué est un pet alors on memorise le maitre dans le unitInfo
          if p.destUnit.uGUID.unittype = unitIsPet then
          begin
            u := getunitinfo(p.destUnit.uGUID);
            if assigned(u) then
              u.UnitAffiliation := p.sourceUnit;
          end;
        end;
      end
      else if (spellIsReverseAffiliation in sOpt) then
      begin
        if (p.sourceUnit <> p.destUnit) then
        begin
          p.sourceUnit.UnitAffiliation := p.destUnit;
          if p.sourceUnit.uGUID.unittype = unitIsPet then
          begin
            u := getunitinfo(p.sourceUnit.uGUID);
            if assigned(u) then
              u.UnitAffiliation := p.destUnit;
          end;
        end;
      end;
    end;

    // assignation params utile ValidUnit
    if assigned(p.sourceUnit) then
    begin
      include(p.params, eventIsInitbyValidUnit);
      if p.sourceUnit.uGUID.unittype = unitisplayer then
      begin
        include(p.params, eventIsInitbyPlayer);
        // player classe
        p.sourceUnit.defineHpByClasse(p.spell);
      end;
    end
    else
      // if no source, then spell can be "no source" (used for aura)
      setSpellDatas(p.spell, getSpellDatas(p.spell) + [spellCanHaveNoSource]);

    // absorb as effective damage
    if (eventIsCombat in p.params) and (eventIsMitigatigatedAbsorb in p.params)
      then
      p.params := p.params + [eventIsDamage];

    // -----------------------------
    if assigned(p.destUnit) then
    begin
      include(p.params, eventIsReceivedbyValidUnit);
      if p.destUnit.uGUID.unittype = unitisplayer then
        p.params := p.params + [eventIsReceivedbyPlayer];
    end;
    if p.sourceUnit = p.destUnit then
      include(p.params, eventIsself);
    // clean security:
    if not(eventIsInitbyValidUnit in p.params) then
      p.params := p.params - [eventIsInitbyRaidUnit];
    if not(eventIsReceivedbyValidUnit in p.params) then
      p.params := p.params - [eventIsReceivedbyRaidUnit];
    // friendlygoal
    if ((eventIsBuff in p.params) or (eventIsHeal in p.params) or
        (eventIsDebuffDispelled in p.params) or
        (eventIsFriendlyVsFriendly in p.params)) then
      include(p.params, eventIsFriendlyGoal);
    if (eventIsDamage in p.params) then // or (p.sourceUnit = nil) then
      exclude(p.params, eventIsFriendlyGoal);
  end;

  // tri des unités ----------
  for i := 2 to 4 do
    unitTree.Sort(masterNode[i], -1, sdAscending, true);

  // spell ------------
  cs := getCheckstateForNewNode(SpellTree.getfirst, csCheckedPressed);
  SpellTree.BeginUpdate;
  for j := 0 to spellArray.count - 1 do
  begin
    sp := spellArray[j];
    if assigned(spellArray[j]) and (sp.count > 0) and (not assigned(sp.pnode))
      then
    begin
      sp.pnode := SpellTree.AddChild(nil,
        TNodeGenericData.create(spellArray[j]));
      pvirtualnode(sp.pnode).CheckState := cs;
    end;
  end;
  SpellTree.endupdate;

  // events-------------
  cs := getCheckstateForNewNode(EventTree.getfirst, csCheckedPressed);
  EventTree.BeginUpdate;
  for j := 0 to eventtypelist.count - 1 do
  begin
    pET := eventtypelist.items[j];
    if (pET.count > 0) and not assigned(pET.pnode) then
    begin
      pET.pnode := EventTree.AddChild(nil, TNodeGenericData.create(pET));
      pvirtualnode(pET.pnode).CheckState := cs;
    end;
  end;
  EventTree.endupdate;

  // filter  (we dont regenerate it in extendparsing)
  if FilterTree.RootNodeCount = 0 then
  begin
    FilterTree.BeginUpdate;
    for i := ord( low(eventParam)) to ord( high(eventParam)) do
    begin
      if EventParamsData[i].auth then
      begin
        Data := nil;
        Node := FilterTree.AddChild(nil, Data);
        pFilterDatanode(FilterTree.GetNodeData(Node)).e := eventParam(i);
        Node.CheckState := csunCheckedPressed;
      end;
    end;
    FilterTree.endupdate;
  end;

  // hide stuff
  HidePlayerNotInRaid;
end;

function TForm1.getCheckstateForNewNode(Node: pvirtualnode;
  defaultcs: TCheckState): TCheckState;
begin
  Result := defaultcs;
  while assigned(Node) do
  begin
    if (Node.CheckState = csCheckedPressed) or
      (Node.CheckState = csunCheckedPressed) then
    begin
      Result := Node.CheckState;
      break;
    end;
    if Node.CheckState = csCheckedNormal then
    begin
      Result := csunCheckedPressed;
      break;
    end;
    Node := Node.NextSibling;
  end;
end;

procedure TForm1.filleventArray;
var
  i: integer;
  p: pEvent;
  Xmax: integer;
  pu: tUnitData;
  Node: pvirtualnode;
  authAbsLine: boolean;
begin
  ERRORCHECKPOINT := 23;
  if (paramGraph.startDrawEventId = -1) or (Eventlist.count = 0) then
    exit; // securité
  // securité bis
  if paramGraph.dpsInterval < MIN_INSTADPSINTERVAL then
    paramGraph.dpsInterval := MIN_INSTADPSINTERVAL;
  paramGraph.Xmax := MAX_HP_ARRAY_ROW;
  // getting time params
  case paramGraph.select.state of
    sS_step1:
      begin
        paramGraph.startHpEventId := paramGraph.select.startId;
        paramGraph.startRealTime := paramGraph.select.startTime;
        paramGraph.startHpTime := paramGraph.select.startTime div 100 * 100;
        paramGraph.endHpTime := -1;
        Xmax := high(integer);
      end;
    sS_valid:
      begin
        paramGraph.startHpEventId := paramGraph.select.startId;
        paramGraph.startHpTime := paramGraph.select.startTime div 100 * 100;
        paramGraph.startRealTime := paramGraph.select.startTime;
        paramGraph.endHpTime := paramGraph.select.endTime div 100 * 100 + 100;
        Xmax := ((paramGraph.endHpTime - paramGraph.startHpTime) div 100) * 4;
      end;
  else
    begin
      paramGraph.startHpEventId := paramGraph.startDrawEventId;
      // paramGraph.startHpEventId:=paramgraph.currentcombatBlockStartId;
      p := Eventlist.items[paramGraph.startHpEventId];
      paramGraph.startRealTime := p.Time;
      paramGraph.startHpTime := p.Time div 100 * 100;
      // on se cale sur l'unité de temps: Seconde
      paramGraph.endHpTime := -1;
      Xmax := high(integer);
    end;
  end;

  if (paramGraph.FocusedMode > 0) and assigned(paramGraph.WatchedUnit) then
  begin
    buildFocusedStats(Xmax);
  end
  else
  begin
    // cleaning Ratio
    Node := masterNode[3];
    while Node <> masterNode[4] do
    begin
      if unitTree.GetNodeLevel(Node) = 1 then
        tunitinfo(ptreeGenericdata(unitTree.GetNodeData(Node)).BasicND.p)
          .lineratio := 0;
      Node := unitTree.GetNext(Node)
    end;
    // cleaning table
    for i := 0 to drawedList.count - 1 do
    begin
      pu := drawedList.items[i];
      pu.instaline.eventarray := nil;
      pu.instaline.absratio := 0;
      pu.instaline.lastDeathtime := 0;
      pu.instaline.started := false;
      pu.instaline.blockstarted := false;
      setlength(pu.instaline.eventarray, MAX_HP_ARRAY_ROW + 1);
      if (paramGraph.linetype = lineHp) and not(AuthUse52Log) then
        pu.instaline.eventarray[0] := pu.stats.startDeficitPool;
    end;

    // cleaning raid table  - preparing stuff
    for i := 1 to high(paramGraph.lines) do
    begin
      paramGraph.lines[i].eventarray := nil;
      paramGraph.lines[i].absratio := 0;
      paramGraph.lines[i].started := false;
      paramGraph.lines[i].blockstarted := false;
      setlength(paramGraph.lines[i].eventarray, MAX_HP_ARRAY_ROW + 1);
    end;
    // ratio
    authAbsLine := gfx_ResetFocus.enabled or
      (useFilterInArray.down and gfx_ResetFilter.enabled);
    paramGraph.lines[1].valid := GfxRaidDpsOut.down and authAbsLine;
    paramGraph.lines[2].valid := GfxRaidHpsOut.down and authAbsLine;
    paramGraph.lines[3].valid := GfxRaidDpsIn.down and authAbsLine;
    paramGraph.lines[4].valid := GfxRaidEffHpsOut.down and authAbsLine;
    paramGraph.lines[5].valid := GfxRaidDpsOut.down;
    paramGraph.lines[6].valid := GfxRaidHpsOut.down;
    paramGraph.lines[7].valid := GfxRaidDpsIn.down;
    paramGraph.lines[8].valid := GfxRaidEffHpsOut.down;

    // --------------------------->
    case paramGraph.linetype of
      lineHp:
        filleventArrayHp(Xmax);
      lineDps:
        filleventArrayDpsHps(Xmax, [eventIsDamage]);
    else
      if Stat_MergeAbsorb.down then
        filleventArrayDpsHps(Xmax, [eventIsHeal, eventIsFixedAbsorb])
      else
        filleventArrayDpsHps(Xmax, [eventIsHeal])
    end;
  end;
end;

procedure TForm1.buildRaidStats(x, Xmax: integer; p: pEvent;
  pstats: reventstat; filtered: integer);
var
  dummyratio: integer;
  tmpvalue: integer;
begin
  // dps taken
  if eventIsReceivedbyRaidUnit in p.params then
    if eventIsDamage in p.params then
    begin
      if prefs.CapOverkill and (pstats.amountOverKill > MAX_OVER_KILLVALUE) then
        tmpvalue := MAX_OVER_KILLVALUE
      else
        tmpvalue := pstats.amountOverKill;
      if paramGraph.lines[3 + filtered].valid then
        GetPerSecondeValue(x, Xmax,
          pstats.amountGeneric - pstats.amountOverKill +
            tmpvalue, paramGraph.lines[3 + filtered], dummyratio);
    end;
  // hps/dps done
  if eventIsInitbyRaidUnit in p.params then
  begin
    if paramGraph.lines[1 + filtered].valid and (eventIsDamage in p.params) then
      if not(Stat_NoFriendDamage.down and not
          (eventIsFriendlyVsOther in p.params)) then
        GetPerSecondeValue(x, Xmax, pstats.amountGeneric + pstats.usedAbsorb,
          paramGraph.lines[1 + filtered], dummyratio);
    if (eventIsHeal in p.params) or (Stat_MergeAbsorb.down and
        (eventIsFixedAbsorb in p.params)) then
    begin
      if Stat_NoEnemyHeal.down and (eventIsFriendlyVsOther in p.params) then
        exit;
      if paramGraph.lines[2 + filtered].valid then
        GetPerSecondeValue(x, Xmax,
          pstats.amountHeal + pstats.usedAbsorb + pstats.fixedAbsorb +
            pstats.absorbpool, paramGraph.lines[2 + filtered], dummyratio);
      if paramGraph.lines[4 + filtered].valid then
        GetPerSecondeValue(x, Xmax,
          pstats.amountHeal - pstats.amountOverHeal + pstats.usedAbsorb,
          paramGraph.lines[4 + filtered], dummyratio);
    end;
  end;
end;

procedure TForm1.buildFocusedStats(Xmax: integer);
var
  i, j, k: integer;
  p: pEvent;
  x: integer;
  pstats: reventstat;
  xchange: integer;
  auraline: tauraline;
  auraEndTime: integer;
  dummyratio: integer;
begin
  for i := 1 to high(paramGraph.lines) do
  begin
    paramGraph.lines[i].eventarray := nil;
    paramGraph.lines[i].absratio := 0;
    paramGraph.lines[i].started := false;
    paramGraph.lines[i].blockstarted := false;
    setlength(paramGraph.lines[i].eventarray, MAX_HP_ARRAY_ROW + 1);
  end;

  // start hp deficit  (line [5])
  if not AuthUse52Log then
    paramGraph.lines[5].eventarray[0] :=
      paramGraph.WatchedUnit.stats.startDeficitPool;

  auraEndTime := pEvent(Eventlist.items[Eventlist.count - 1]).Time;
  xchange := 0;

  resetParamGraphFocusedData;

  for i := paramGraph.startHpEventId to Eventlist.count - 1 do
  begin
    p := Eventlist.items[i];
    x := (p.Time - paramGraph.startHpTime) div BASE_HP_FEEDBACK_INTERVAL;
    if x >= MAX_HP_ARRAY_ROW then
    begin
      auraEndTime := p.Time;
      break;
    end;
    if (paramGraph.endHpTime >= 0) and (p.Time >= paramGraph.endHpTime) then
    begin
      auraEndTime := paramGraph.select.endTime;
      paramGraph.Xmax := x;
      break;
    end;

    // globalstats
    pstats := p.eventStat;
    if Stat_absorb.down and (eventIsInitbyRaidUnit in p.params) then
      pstats.usedAbsorb := pstats.absorb;
    // hp - mana
    if x > xchange then
    begin
      paramGraph.lines[5].blockstarted := false;
      paramGraph.lines[7].blockstarted := false;
      for k := xchange + 1 to x do
      begin
        if (k > Xmax) then
          break; // si on sort de la zone de selection on sort de la boucle
        paramGraph.lines[5].eventarray[k] := paramGraph.lines[5].eventarray
          [xchange];
        if AuthUse52Log then
          paramGraph.lines[7].eventarray[k] := paramGraph.lines[7].eventarray
            [xchange];
      end;
      xchange := x;
    end;

    // -------------------
    if AuthUse52Log then
    begin
      if assigned(p.eInfo.u) and (p.eInfo.u = paramGraph.WatchedUnit) then
      begin
        GetHpValue52(p.eInfo.u, p, pstats, x, paramGraph.lines[5]);
        GetManaValue(p.eInfo.u, p, pstats, x, paramGraph.lines[7]);
      end;
      if p.destUnit = paramGraph.WatchedUnit then
      begin
        GetHpValueDeath(p.destUnit, p, pstats, x, paramGraph.lines[5]);
        GetHpValueDeath(p.destUnit, p, pstats, x, paramGraph.lines[7]);
      end;
    end
    else
    begin
      if p.destUnit = paramGraph.WatchedUnit then
        GetHpValue(paramGraph.WatchedUnit, p, pstats, x, paramGraph.lines[5]);
    end;
    // focus
    if paramGraph.unitRef then
      if not isEventOnFocus(p, btnFocusMode.down, globalFocusType) then
        continue;
    // aura are always taken in filter but not dps/hps line (depend of the useFilterInArray options)
    if IsEventInFilter(p) then
    begin
      // auras
      if (p.Time > paramGraph.select.startTime) and
        (p.Time <= paramGraph.select.endTime) then
        case paramGraph.FocusedMode of
          1:
            if (p.sourceUnit = paramGraph.WatchedUnit) then
              generateAura(p, pstats, nil);
          2:
            if (p.destUnit = paramGraph.WatchedUnit) then
              generateAura(p, pstats, nil);
          3:
            if (p.sourceUnit = paramGraph.WatchedUnit) then
              generateAura(p, pstats, p.destUnit);
          4:
            if (p.destUnit = paramGraph.WatchedUnit) then
              generateAura(p, pstats, p.sourceUnit);
        end;
    end
    else if useFilterInArray.down then
      continue;

    // hps/dps done
    if p.sourceUnit = paramGraph.WatchedUnit then
    begin
      if eventIsDamage in p.params then
        GetPerSecondeValue(x, Xmax, pstats.amountGeneric + pstats.usedAbsorb,
          paramGraph.lines[1], dummyratio);
      if (eventIsHeal in p.params) then
      begin
        GetPerSecondeValue(x, Xmax, pstats.amountHeal + pstats.usedAbsorb,
          paramGraph.lines[2], dummyratio);
        GetPerSecondeValue(x, Xmax,
          pstats.amountHeal - pstats.amountOverHeal + pstats.usedAbsorb,
          paramGraph.lines[6], dummyratio);
      end;
      if Stat_MergeAbsorb.down and (eventIsFixedAbsorb in p.params) then
      begin
        GetPerSecondeValue(x, Xmax, pstats.fixedAbsorb + pstats.absorbpool,
          paramGraph.lines[2], dummyratio);
        GetPerSecondeValue(x, Xmax, pstats.fixedAbsorb, paramGraph.lines[6],
          dummyratio);
      end;

    end;
    // hps/dps taken
    if p.destUnit = paramGraph.WatchedUnit then
    begin
      if eventIsDamage in p.params then
        GetPerSecondeValue(x, Xmax, pstats.amountGeneric, paramGraph.lines[3],
          dummyratio);
      if (eventIsHeal in p.params) or (eventIsFixedAbsorb in p.params) then
        GetPerSecondeValue(x, Xmax, pstats.amountHeal + pstats.usedAbsorb,
          paramGraph.lines[4], dummyratio);
      if Stat_MergeAbsorb.down and (eventIsFixedAbsorb in p.params) then
        GetPerSecondeValue(x, Xmax, pstats.fixedAbsorb + pstats.absorbpool,
          paramGraph.lines[4], dummyratio);
    end;
  end;

  for i := 1 to 4 do
    paramGraph.lines[i].gfxratio := NoZeroValue
      (paramGraph.lines[i].absratio div FOCUSED_RATIO_DIVIDER);
  paramGraph.lines[5].gfxratio := NoZeroValue
    (paramGraph.WatchedUnit.uhp div FOCUSED_RATIO_DIVIDER);
  paramGraph.lines[7].gfxratio := NoZeroValue
    (paramGraph.WatchedUnit.mana div FOCUSED_RATIO_DIVIDER);
  // exception ratio Heal+EffectiveHeal
  paramGraph.lines[6].gfxratio := paramGraph.lines[2].gfxratio;

  // sorting aura
  paramGraph.auralines.Sort(sortauralinelist);

  // cleaning aura
  for j := 0 to paramGraph.auralines.count - 1 do
  begin
    auraline := paramGraph.auralines.items[j];
    auraline.closeevent(auraEndTime, true);
    auraline.Setuptime(auraEndTime - paramGraph.startRealTime);
  end;
  // fix max offset for aura/rotation
  GaugeBar2.max := getmaxfocusedOffset;
end;

procedure TForm1.generateAura(p: pEvent; pstats: reventstat; u: tUnitData);
var
  found: boolean;
  j: integer;
  auraline: tauraline;
begin
  if SpellSingleAura(p.spell) then
    u := nil;

  if (eventisAuraApply in p.params) and (pstats.amountGeneric = 0) then
  begin
    found := false;
    // looking for auraline
    for j := 0 to paramGraph.auralines.count - 1 do
    begin
      auraline := paramGraph.auralines.items[j];
      if (auraline.spell = p.spell) and (auraline.u = u) then
      begin
        // ajoute une nouvelle aura sur la ligne
        auraline.newevent(p.Time, -1, 0);
        found := true;
        break;
      end;
    end;
    // si on est la on cree une nouvelle ligne
    if not found then
      paramGraph.auralines.add(tauraline.initdata(eventIsDebuff in p.params,
          p.spell, p.Time, -1, u, 0));
  end;
  /// remove event
  if eventisAuraRemove in p.params then
  begin
    found := false;
    for j := 0 to paramGraph.auralines.count - 1 do
    begin
      auraline := paramGraph.auralines.items[j];
      if (auraline.spell = p.spell) and (auraline.u = u) then
      begin
        // ajoute une nouvelle aura sur la ligne
        if not auraline.closeevent(p.Time, false) then
          auraline.newevent(paramGraph.startRealTime, p.Time, 0);
        found := true;
        break;
      end;
    end;
    // si on est la on a affaire a une aura qui existait avant le debut
    if not found then
      paramGraph.auralines.add(tauraline.initdata(eventIsDebuff in p.params,
          p.spell, paramGraph.startRealTime, p.Time, u, 0));
  end;
  /// refresh event
  if eventisAuraRefresh in p.params then
  begin
    found := false;
    for j := 0 to paramGraph.auralines.count - 1 do
    begin
      auraline := paramGraph.auralines.items[j];
      if (auraline.spell = p.spell) and (auraline.u = u) then
      begin
        found := true;
        break;
      end;
    end;
    // si on est la on a affaire a une aura qui existait avant le debut
    if not found then
      paramGraph.auralines.add(tauraline.initdata(eventIsDebuff in p.params,
          p.spell, paramGraph.startRealTime, -1, u, 0));
  end;
  {
    //unitdied: on ferme tous les events (obsolete depuis wow 3.0)
    if p.event= event_UNIT_DIED then                                      include
    for j:=0 to paramgraph.auralines.count-1 do
    tauraline(paramgraph.auralines.items[j]).closeevent(p.time, true);
    }
end;

procedure TForm1.generateUnitAura(spellId: integer; sourceUnit: tUnitData);
var
  i, j, predefid: integer;
  p: pEvent;
  auraEndTime: integer;
  ui: tunitinfo;
  u: tUnitData;
  auracolor: tcolor32;
begin
  // cleaning
  for i := 0 to unitList.count - 1 do
  begin
    ui := unitList.items[i];
    for j := 0 to ui.list.count - 1 do
    begin
      u := ui.list.items[j];
      if assigned(u.aura) then
        u.aura.destroy;
      u.aura := nil;
      u.auracolor := 0;
    end;
  end;
  predefid := 0;
  // validation d'aurawatch
  if (spellId = 0) or (paramGraph.select.state <> sS_valid) then
    exit;
  // looking
  auraEndTime := pEvent(Eventlist.items[Eventlist.count - 1]).Time;
  for i := paramGraph.startHpEventId to Eventlist.count - 1 do
  begin
    p := Eventlist.items[i];
    if (paramGraph.endHpTime >= 0) and (p.Time >= paramGraph.endHpTime) then
    begin
      auraEndTime := paramGraph.select.endTime;
      break;
    end;

    if (p.spell.id = spellId) then
    begin
      auracolor := 0;
      if assigned(sourceUnit) and (p.sourceUnit <> sourceUnit) then
        continue;
      if assigned(p.sourceUnit) then
      begin
        if p.sourceUnit.auracolor = 0 then
        begin
          p.sourceUnit.auracolor := getauracolor(predefid);
          inc(predefid);
        end;
        auracolor := p.sourceUnit.auracolor;
      end;
      if assigned(p.destUnit) then
        generateUnitAuraEx(p, p.destUnit, auracolor);
    end;

  end;

  // ending aura
  for i := 0 to unitList.count - 1 do
  begin
    ui := unitList.items[i];
    for j := 0 to ui.list.count - 1 do
    begin
      u := ui.list.items[j];
      if assigned(u.aura) then
        u.aura.closeevent(auraEndTime, true);
    end;
  end;
end;

procedure TForm1.generateUnitAuraEx(p: pEvent; u: tUnitData;
  auracolor: tcolor32);
begin
  if (eventisAuraApply in p.params) and (p.eventStat.amountGeneric = 0) then
  begin
    if assigned(u.aura) then
    begin
      u.aura.closeevent(p.Time, true);
      u.aura.newevent(p.Time, -1, auracolor)
    end
    else
      u.aura := tauraline.initdata(eventIsDebuff in p.params, p.spell, p.Time,
        -1, u, auracolor);
  end;
  /// remove event
  if eventisAuraRemove in p.params then
  begin
    if assigned(u.aura) then
    begin
      u.aura.closeevent(p.Time, true);
      // if not u.aura.closeevent(p.time, false) then u.aura.newevent(paramgraph.startrealtime,p.time, auracolor);
    end
    else
      u.aura := tauraline.initdata(eventIsDebuff in p.params, p.spell,
        paramGraph.startRealTime, p.Time, u, auracolor)
  end;
  /// refresh event
  if eventisAuraRefresh in p.params then
    if not assigned(u.aura) then
      u.aura := tauraline.initdata(eventIsDebuff in p.params, p.spell,
        paramGraph.startRealTime, -1, u, auracolor);
end;

function sortauralinelist(p1, p2: Pointer): integer;
begin
  Result := (tauraline(p1).getspellId - tauraline(p2).getspellId) +
    (comparetext(tauraline(p1).getspellname,
      tauraline(p2).getspellname) * 200000);
end;

procedure TForm1.GetHpValue(u: tUnitData; p: pEvent; pstats: reventstat;
  x: integer; var hpline: linearray);
begin
  if (eventisdeath in p.params) then // or (eventIsOverDamage in p.params)
  begin
    hpline.eventarray[x] := DEATH_HP;
    hpline.lastDeathtime := p.Time;
  end
  else
  begin
    // si l'unité etait morte elle repart avec un deficit de vie = hp-REZ_LIFE_RATIO%
    // on regarde l'unité est mort depuis au moins LAG_DELAY_TIME secondes pour contrebalancrer les eventuels bugs lié aulags
    if (hpline.eventarray[x] = DEATH_HP) and
      (eventInternalIsValidforRez in p.internalParams) then
      if p.Time - hpline.lastDeathtime > LAG_DELAY_TIME then
        hpline.eventarray[x] := u.uhp - round(u.uhp * REZ_LIFE_RATIO);
    // events influencants la vie de l'unité
    if (eventIsDamage in p.params) and (hpline.eventarray[x] <> DEATH_HP) then
      hpline.eventarray[x] := hpline.eventarray[x] + pstats.amountGeneric -
        pstats.amountOverKill
    else if (eventIsHeal in p.params) and (hpline.eventarray[x] <> DEATH_HP)
      then
    begin
      hpline.eventarray[x] := hpline.eventarray[x] - pstats.amountHeal;
      // si overheal alors le deficit est reset
      if (pstats.amountOverHeal > 0) or (hpline.eventarray[x] < 0) then
        hpline.eventarray[x] := 0;
    end;
  end;
end;

procedure TForm1.GetHpValueDeath(u: tUnitData; p: pEvent; pstats: reventstat;
  x: integer; var hpline: linearray);
begin
  if (eventisdeath in p.params) then
    hpline.eventarray[x] := 0;
end;

procedure averageArrayValue(x, v2: integer; var hpline: linearray);
var
  i: integer;
begin
  if hpline.started then
  begin
    if hpline.blockstarted then
      hpline.eventarray[x] := (hpline.eventarray[x] + v2) div 2
    else
    begin
      hpline.eventarray[x] := v2;
      hpline.blockstarted := true;
    end;
  end
  else
  begin
    for i := 0 to x do
      hpline.eventarray[i] := v2;
    hpline.started := true;
  end;
end;

procedure TForm1.GetHpValue52(u: tUnitData; p: pEvent; pstats: reventstat;
  x: integer; var hpline: linearray);
begin
  averageArrayValue(x, p.eInfo.Data[1], hpline);
  if p.eInfo.u.uhp < p.eInfo.Data[1] then
    p.eInfo.u.uhp := p.eInfo.Data[1];
end;

procedure TForm1.GetManaValue(u: tUnitData; p: pEvent; pstats: reventstat;
  x: integer; var hpline: linearray);
var
  usePowerType: integer;
  Value: integer;
begin
  usePowerType := u.getcurrentPower(CURRENTPOWER);

  //if (usePowerType = 0) and (CURRENTDATATYPE = 5) and
 //   (p.eInfo.Data[CURRENTDATATYPE] = 0) then
  //  exit; // do not handle 0 mana (combatlog bug?)
  Value := p.eInfo.Data[CURRENTDATATYPE] * eINFOPOWER[usePowerType + 1].ratio;

  if (usePowerType < 0) or (p.eInfo.Data[4] = usePowerType) then
  // (p.eInfo.Data[CURRENTDATATYPE]>0) and
  begin
    averageArrayValue(x, Value, hpline);
    if p.eInfo.u.mana < Value then
      p.eInfo.u.mana := Value;
  end;
end;

procedure TForm1.filleventArrayDpsHps(Xmax: integer; lookedEvent: eventParams);
var
  i: integer;
  p: pEvent;
  x: integer;
  pu: tUnitData;
  RelativeratioValue: integer;
  pstats: reventstat;
begin
  RelativeratioValue := 0;
  for i := paramGraph.startHpEventId to Eventlist.count - 1 do
  begin
    p := Eventlist.items[i];
    x := (p.Time - paramGraph.startHpTime) div BASE_HP_FEEDBACK_INTERVAL;

    // si on sort du range de l'array on sort.
    if x >= MAX_HP_ARRAY_ROW then
      break;
    // si on depasse le temps max on quitte la boucle
    if (paramGraph.endHpTime >= 0) and (p.Time >= paramGraph.endHpTime) then
    begin
      paramGraph.Xmax := x;
      break;
    end;

    pstats := p.eventStat;
    if Stat_absorb.down and (eventIsInitbyRaidUnit in p.params) then
      pstats.usedAbsorb := pstats.absorb;
    // build unfiltered lines
    buildRaidStats(x, Xmax, p, pstats, 0);
    // focus
    if paramGraph.unitRef then
      if not(isEventOnFocus(p, btnFocusMode.down, globalFocusType)) then
        continue;
    if useFilterInArray.down then
      if not IsEventInFilter(p) then
        continue;
    // build filtered lines
    buildRaidStats(x, Xmax, p, pstats, 4);

    if assigned(p.sourceUnit) and (p.sourceUnit.idInDrawList >= 0) then
    begin
      if p.params * lookedEvent <> [] then
      begin
        if getUnitType(p.sourceUnit) = unitIsNpc then
          GetPerSecondeValue(x, Xmax,
            pstats.amountGeneric + pstats.usedAbsorb + pstats.fixedAbsorb +
              pstats.absorbpool, p.sourceUnit.instaline,
            getunitinfo(p.sourceUnit).lineratio, true)
        else
          GetPerSecondeValue(x, Xmax,
            pstats.amountGeneric + pstats.usedAbsorb + pstats.fixedAbsorb +
              pstats.absorbpool, p.sourceUnit.instaline, RelativeratioValue,
            true);
      end;
    end;
  end;

  // calcul des ratios(optimisation)
  for i := 0 to drawedList.count - 1 do
  begin
    pu := drawedList.items[i];
    if (relativeRatio.down) then
      pu.instaline.gfxratio := NoZeroValue
        (pu.instaline.absratio div RATIO_DIVIDER)
    else
    begin
      if (pu.uGUID.unittype <> unitIsNpc) then
        pu.instaline.gfxratio := NoZeroValue
          (RelativeratioValue div RATIO_DIVIDER)
      else
        pu.instaline.gfxratio := NoZeroValue
          (getunitinfo(pu).lineratio div RATIO_DIVIDER);
    end;
  end;
end;

procedure TForm1.GetPerSecondeValue(x, Xmax: integer; amount: integer;
  var instaline: linearray; var ratio: integer; getratio: boolean = false);
var
  j: integer;
  piRatio: double;
begin
  if USE_SMOOTH_LINE then
    piRatio := (pi) / (paramGraph.dpsInterval)
    // SmoothMode
  else
    piRatio := amount / paramGraph.dpsInterval; // linearmode
  for j := -paramGraph.dpsInterval to paramGraph.dpsInterval do
  begin
    // on check les caps
    if ((x + j) < 0) then
      continue;
    if ((x + j) >= MAX_HP_ARRAY_ROW) or (x + j > Xmax) then
      break;
    if USE_SMOOTH_LINE then
      instaline.eventarray[x + j] := instaline.eventarray[x + j] + round
        ((1 + cos(piRatio * j)) * (amount div 2))
      // SmoothMode
    else
      instaline.eventarray[x + j] := instaline.eventarray[x + j] + round
        (piRatio * (paramGraph.dpsInterval - abs(j))); // linearmode
    if instaline.eventarray[x + j] > instaline.absratio then
      instaline.absratio := instaline.eventarray[x + j];
    if getratio and (instaline.absratio > ratio) then
      ratio := instaline.absratio;
  end;
end;

procedure TForm1.filleventArrayHp(Xmax: integer);
var
  i, j, k: integer;
  p: pEvent;
  x, xchange: integer;
  pu: tUnitData;
  pstats: reventstat;
begin
  // ----------
  xchange := 0;
  for i := paramGraph.startHpEventId to Eventlist.count - 1 do
  begin
    p := Eventlist.items[i];
    x := (p.Time - paramGraph.startHpTime) div BASE_HP_FEEDBACK_INTERVAL;

    // si on sort du range de l'array on sort.
    if x >= MAX_HP_ARRAY_ROW then
      break;
    // si on depasse le temps max on quitte la boucle
    if (paramGraph.endHpTime >= 0) and (p.Time >= paramGraph.endHpTime) then
    begin
      paramGraph.Xmax := x;
      break;
    end;

    // a chaque changement d'interval on recopie la colonne precedente
    if x > xchange then
    begin
      for j := 0 to drawedList.count - 1 do
      begin
        pu := drawedList.items[j];
        pu.instaline.blockstarted := false;
        for k := xchange + 1 to x do
        begin
          if (k > Xmax) then
            break; // si on sort de la zone de selection on sort de la boucle
          pu.instaline.eventarray[k] := pu.instaline.eventarray[xchange];
        end
      end;
      xchange := x;
    end;
    pstats := p.eventStat;
    if Stat_absorb.down and (eventIsInitbyRaidUnit in p.params) then
      pstats.usedAbsorb := pstats.absorb;

    if AuthUse52Log then
    begin
      if assigned(p.eInfo.u) and (p.eInfo.u.idInDrawList >= 0) then
        GetHpValue52(p.eInfo.u, p, pstats, x, p.eInfo.u.instaline);
      if assigned(p.destUnit) and (p.destUnit.idInDrawList >= 0) then
        GetHpValueDeath(p.destUnit, p, pstats, x, p.destUnit.instaline);
    end
    else if assigned(p.destUnit) and (p.destUnit.idInDrawList >= 0) then
      GetHpValue(p.destUnit, p, pstats, x, p.destUnit.instaline);

    buildRaidStats(x, Xmax, p, pstats, 0);
    // focus and raid
    if paramGraph.unitRef then
      if not(isEventOnFocus(p, btnFocusMode.down, globalFocusType)) then
        continue;
    if useFilterInArray.down then
      if not IsEventInFilter(p) then
        continue;
    buildRaidStats(x, Xmax, p, pstats, 4);
  end;

  // calcul des ratios(optimisation)
  for i := 0 to drawedList.count - 1 do
  begin
    pu := drawedList.items[i];
    pu.instaline.gfxratio := NoZeroValue(pu.uhp div RATIO_DIVIDER);
  end;
end;

procedure TForm1.fillTreeEvent(filter: eventFilter);
var
  i: integer;
  p: pEvent;
  nodetmp, nodePos, nodeTop: pvirtualnode;
  nbnode: integer;
  isNodeAdded: boolean;
  search_startId, search_stoptime: integer;
begin
  ERRORCHECKPOINT := 30;
  StatusBar1.Panels[2].Text := 'Sorting Events...';
  StatusBar1.repaint;
  ProgressBar1.min := 0;
  ProgressBar1.max := Eventlist.count;
  MyTree.clear;
  MyTree.BeginUpdate;
  nodePos := nil;
  nodetmp := nil;
  nbnode := 0;
  search_startId := 0;
  search_stoptime := GlobalEndLogTime;

  // getting time params
  if ListBut_UseSelection.down then
    case paramGraph.select.state of
      sS_step1:
        begin
          search_startId := paramGraph.select.startId;
          search_stoptime := GlobalEndLogTime;
        end;
      sS_valid:
        begin
          search_startId := paramGraph.select.startId;
          search_stoptime := paramGraph.select.endTime;
        end;
    end;

  if filter.option <> [optClearTree] then
    // calcul nodetop
    if optAroundNode in filter.option then
      nbnode := ((MyTree.ClientHeight div integer(MyTree.DefaultNodeHeight))
          div 2);

  // -fill
  for i := search_startId to Eventlist.count - 1 do
  begin
    if i mod APPLICATIONREFRESH = 0 then
    begin
      ProgressBar1.Position := i;
      ProgressBar1.repaint;
    end;

    isNodeAdded := true;
    p := Eventlist.items[i];

    if p.Time > search_stoptime then
      break;
    if ListBut_Security.down and (MyTree.RootNodeCount >= cardinal
        (prefs.maxeventinlist)) then
      break;

    // pas de filtre
    if filter.option = [] then
    begin
      MyTree.AddChild(nil, TNodeData.create(p));
      continue;
    end;

    // si on est en mode fullfilter:
    if ListBut_ApplyFullFilter.down then
      isNodeAdded := isNodeAdded and IsEventInFilter(p);

    // apply relevant focus
    if ListBut_UseUnitRef.down and paramGraph.unitRef then
      if not isEventOnFocus(p, btnFocusMode.down, globalFocusType) then
        continue;

    if optEventParam in filter.option then
      isNodeAdded := isNodeAdded and (filter.param in p.params);

    if optText in filter.option then
      isNodeAdded := isNodeAdded and
        ((getunitname(p.sourceUnit, []) = filter.Text) or
          (getunitname(p.destUnit, []) = filter.Text));

    if optTextPos in filter.option then
      isNodeAdded := isNodeAdded and
        ((pos(filter.Text, getunitname(p.sourceUnit, [])) > 0) or
          (pos(filter.Text, getunitname(p.destUnit, [])) > 0));

    if optEvent in filter.option then
      isNodeAdded := isNodeAdded and (ord(p.event) = filter.idEvent);

    if optUnitGUID in filter.option then
      isNodeAdded := isNodeAdded and
        ((getUnitGUID(p.sourceUnit).GUID = filter.GUID) or
          (getUnitGUID(p.destUnit).GUID = filter.GUID));

    if optUnitId in filter.option then
      isNodeAdded := isNodeAdded and
        ((getUnitGUID(p.sourceUnit).mobId = filter.mobId) or
          (getUnitGUID(p.destUnit).mobId = filter.mobId));

    if optSourceUnitID in filter.option then
      isNodeAdded := isNodeAdded and
        (getUnitGUID(p.sourceUnit).GUID = filter.GUID);

    if optDestUnitID in filter.option then
      isNodeAdded := isNodeAdded and
        (getUnitGUID(p.destUnit).GUID = filter.GUID);

    if optSpellId in filter.option then
      isNodeAdded := isNodeAdded and (p.spell.id = filter.spellId);

    // if optAroundNode in filter.option then
    // isNodeAdded:=isNodeAdded and ((p.time>=filter.p.time-SEARCH_AROUND_TIME) and (p.time<=filter.p.time+SEARCH_AROUND_TIME));

    // ajout du noeud
    if isNodeAdded then
      nodetmp := MyTree.AddChild(nil, TNodeData.create(p));
    // placement
    if (optAroundNode in filter.option) then
      if p = filter.p then
        nodePos := nodetmp;
  end;
  MyTree.endupdate;

  // recuperation de la position de l'event
  if assigned(nodePos) then
  begin
    nodeTop := nodePos;
    for i := 0 to nbnode do
      if assigned(nodeTop.PrevSibling) then
        nodeTop := nodeTop.PrevSibling
      else
        break;
    MyTree.TopNode := nodeTop;
    MyTree.focusednode := nodePos;
    MyTree.Selected[nodePos] := true;
  end;

  // ------feedback-
  ProgressBar1.Position := ProgressBar1.max;
  ProgressBar1.repaint;
  StatusBar1.Panels[2].Text := 'Events: ' + inttostr(MyTree.RootNodeCount)
    + '/' + inttostr(Eventlist.count);
end;

procedure TForm1.MyTreeFreeNode(Sender: TBaseVirtualTree; Node: pvirtualnode);
Var
  Data: ptreedata;
begin
  Data := Sender.GetNodeData(Node);
  Data.BasicND.destroy;
end;

procedure TForm1.MyTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
var
  Data: ptreedata;
  pStat: reventstat;
  strtmp: string;
begin

  Data := Sender.GetNodeData(Node);
  pStat := Data.BasicND.p.eventStat;

  {$IFDEF DEBUG}
  if assigned(Data.BasicND.p.eInfo.u) then
    strtmp := format(' [::%s:hp:%d]', [getunitname(Data.BasicND.p.eInfo.u, []), Data.BasicND.p.eInfo.data[1]])
  else
  {$ENDIF}
    strtmp := '';

  case Column of
    0:
      CellText := GetRealTimeFromTimeEvent(StartTimeStamp, Data.BasicND.p.Time,
        paramGraph.select.startTime, toShowFullTime);
    1:
      if Data.BasicND.p.event = event_UNKNOWN then
        CellText := unknownEventlist.Strings[Data.BasicND.p.statsarray[0]]
      else
        CellText := Data.BasicND.p.name + strtmp;
    2:
      CellText := getunitname(Data.BasicND.p.sourceUnit, [getaff]);
    3:
      CellText := getunitname(Data.BasicND.p.destUnit, [getaff]);
    4:
      begin
        if Data.BasicND.p.event = event_ENCOUNTER_START then
          CellText := format('id:%d, %d,%d', [pStat.bossId, pStat.bossdiff,
            pStat.BossPlayers])
        else if Data.BasicND.p.event = event_ENCOUNTER_STOP then
          CellText := format('id:%d, %d,%d %d', [pStat.bossId, pStat.bossdiff,
            pStat.BossPlayers, pStat.bossdown])
        else
          CellText := getspellname(Data.BasicND.p);
      end;
    5:
      begin
        if pStat.amountGeneric > 0 then
          CellText := intToStrEx(pStat.amountGeneric)
        else
          CellText := '';
        if pStat.amountExtra > 0 then
          CellText := CellText + ' (' + intToStrEx(pStat.amountExtra) + ')';
        if pStat.amountOverKill > 0 then
          CellText := CellText + ' (OD: ' + intToStrEx(pStat.amountOverKill)
            + ')';
        if pStat.amountOverHeal > 0 then
          CellText := CellText + ' (EFF: ' + intToStrEx
            (pStat.amountGeneric - pStat.amountOverHeal)
            + ' | OH: ' + intToStrEx(pStat.amountOverHeal) + ')';
        if pStat.absorbpool > 0 then
          CellText := CellText + ' ABS(pool): ' + intToStrEx(pStat.absorbpool)
            + ' ';
        if pStat.usedAbsorb > 0 then
          CellText := CellText + ' eABS: ' + intToStrEx(pStat.usedAbsorb) + ' ';

        if pStat.fixedAbsorb > 0 then
          CellText := CellText + ' ABS: ' + intToStrEx(pStat.fixedAbsorb) + ' ';
{$IFDEF DEBUG}
        if (pStat.guessedAbsorb) > 0 then
          CellText := CellText + ' ABS(raw): ' + intToStrEx
            (pStat.guessedAbsorb) + ' ';
        if (Data.BasicND.p.fixedabsnotfound) > 0 then
          CellText := CellText + ' ABS(notfound): ' + intToStrEx
            (Data.BasicND.p.fixedabsnotfound) + ' ';
{$ENDIF}
      end;
    6:
      begin
        CellText := getSpecialString(Data.BasicND.p.specialhit, ' ')
          + powerTypeparam[pStat.powertype] + getMissString(pStat.miss, '',
          (pStat.resist + pStat.block + pStat.absorb = 0))
          + Data.BasicND.p.GetAuraString;
        if pStat.extraspellId > 0 then
        begin
          if Data.BasicND.p.event = event_SPELL_AURA_APPLIED then
            CellText := CellText + '->cs:';
          CellText := CellText + getspellname(pStat.extraspellId);
        end;
        if pStat.absorb > 0 then
          CellText := CellText + getMissString(1, ':') + intToStrEx
            (pStat.absorb) + ' ';
{$IFDEF DEBUG}
        if Data.BasicND.p.lastabsorb > 0 then
          CellText := CellText + ' ABS(undef): ' + intToStrEx
            (Data.BasicND.p.lastabsorb) + ' '; ;
{$ENDIF}
        if pStat.block > 0 then
          CellText := CellText + getMissString(2,
            CRITTAG[ord(eventIsCriticalblock in Data.BasicND.p.params)] + ':')
            + intToStrEx(pStat.block) + ' ';
        if pStat.resist > 0 then
          CellText := CellText + getMissString(10, ':') + intToStrEx
            (pStat.resist) + ' ';
        if assigned(Data.BasicND.p.extraUnit) then
          CellText := CellText + ' (' + getunitname(Data.BasicND.p.extraUnit,
            [getaff, getNoserver]) + ') ';
      end;
    7:
      if Data.BasicND.p.spell.id > 0 then
        CellText := inttohex(Data.BasicND.p.spell.id, 6)
      else
        CellText := '';
    8:
      if MyTree.Selected[Node] = true then
        CellText := '>'
      else
        CellText := '';
  end;
end;

procedure TForm1.clearCombatBlocklist;
var
  i: integer;
begin
  for i := 0 to CombatBlockList.count - 1 do
    tcombatBlock(CombatBlockList.items[i]).destroy;
  CombatBlockList.clear;
end;

procedure TForm1.clearEventlist;
var
  i: integer;
begin
  ProgressBar1.min := 0;
  ProgressBar1.max := Eventlist.count;
  EventDeathlist.clear;
  replayCastList.clear;
  for i := 0 to Eventlist.count - 1 do
  begin
    if i mod APPLICATIONREFRESH = 0 then
    begin
      ProgressBar1.Position := i;
      ProgressBar1.repaint;
    end;
    pEvent(Eventlist.items[i]).destroy;
  end;
  Eventlist.clear;

  for i := 0 to EventIgnoredlist.count - 1 do
    dispose(pEventIgnored(EventIgnoredlist.items[i]));
  EventIgnoredlist.clear;

end;

procedure TForm1.clearEventTypeList;
var
  i: integer;
begin
  for i := 0 to eventtypelist.count - 1 do
    tEventType(eventtypelist.items[i]).destroy;
  eventtypelist.clear;
end;

procedure TForm1.clearMarkedList;
var
  i, j: integer;
begin
  for i := low(markedlist) to high(markedlist) do
  begin
    for j := 0 to markedlist[i].count - 1 do
      dispose(pmarkevent(markedlist[i].items[j]));
    markedlist[i].clear;
  end;

end;

procedure TForm1.clearSpellArray;
var
  i: integer;
begin
  for i := 0 to spellArray.count - 1 do
    tspellinfo(spellArray.items[i]).destroy;
  spellArray.clear;
end;

procedure TForm1.clearUnitArray;
var
  i: integer;
begin
  for i := 0 to high(npcArray) do
    if assigned(npcArray[i]) then
      npcArray[i].destroy;
  npcArray := nil;
  for i := 0 to unitArray.count - 1 do
    tunitinfo(unitArray.items[i]).destroy;
  unitArray.clear;
end;

procedure TForm1.FormClose(Sender: TObject;

  var Action: TCloseAction);
var
  i: integer;
begin
  ERRORCHECKPOINT := 100;
  screen.Cursor := crHourGlass;
  LiveUpdateTimer.enabled := false;
  saveprefs;

  StatusBar1.Panels[2].Text := 'Cleaning...';
  StatusBar1.repaint;

  clearRotationlines;
  resetParamGraphFocusedData;

  saveNPCArray;
  saveSpellArray;

  StatTree.clear;
  CustomFilterTree.clear;
  clearEventlist;
  ChatTree.clear;
  clearCombatBlocklist;
  drawedList.clear;
  unknownEventlist.free;
  clearEventTypeList;
  clearSpellArray;
  clearUnitArray;
  unitList.clear;
  unitList.free;
  Eventlist.free;
  EventDeathlist.free;
  clearbossinfoList;
  bossinfoList.free;
  LocalStatList.free;
  EventIgnoredlist.free;
  unitArray.free;
  spellArray.free;
  freeReplay;
  drawedList.free;
  clearLogIndexLists;
  LogList.free;
  cleardonjonlist;
  donjonlist.free;
  dummySpellInfo.free;
  dummypEvent.free;
  CompareTree.clear;
  WatchedEventTree.clear;
  FreeWatchList;
  clearMarkedList;
  TTString.free;
  H_res.free;
  for i := low(markedlist) to high(markedlist) do
  begin
    markedlist[i].free;
    markedicon[i].free;
  end;
  for i := 1 to 3 do
    iconrole[i].free;
  paramGraph.auralines.free;
  paramGraph.Rotationlines.eventIn.free;
  paramGraph.Rotationlines.eventOut.free;
  paramGraph.Rotationlines.total[0].free;
  paramGraph.Rotationlines.total[1].free;

  for i := 1 to high(paramGraph.lines) do
    paramGraph.lines[i].eventarray := nil;

  mousedetect.stream_mapnode.free;
  cleanAllHtmlTemplate;
  eventtypelist.free;
  CombatBlockList.free;
  headerString.free;
  screen.Cursor := crDefault;
end;

procedure TForm1.MyTreeBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect;

  var ContentRect: TRect);
var
  Data: ptreedata;
begin
  if Column <> 8 then
  begin
    Data := Sender.GetNodeData(Node);
    TargetCanvas.Brush.color := Data.BasicND.p.getcolor;
    TargetCanvas.FillRect(CellRect);
  end;
end;

procedure TForm1.TreeMenuPopup(Sender: TObject);
var
  Data: ptreedata;
begin
  if assigned(MyTree.focusednode) then
  begin
    Data := MyTree.GetNodeData(MyTree.focusednode);
    filterSrcName.Caption := 'src: ' + getunitname(Data.BasicND.p.sourceUnit,
      [getaff]) + ':' + inttohex(getUnitGUID(Data.BasicND.p.sourceUnit).GUID,
      8);
    filterDestName.Caption := 'dest: ' + getunitname(Data.BasicND.p.destUnit,
      [getaff]) + ':' + inttohex(getUnitGUID(Data.BasicND.p.destUnit).GUID, 8);
    EditSpell3.enabled := Data.BasicND.p.spell.id > 0;
  end;
  filterSrcName.Visible := assigned(MyTree.focusednode);
  filterDestName.Visible := assigned(MyTree.focusednode);
  FilterAroundEvents1.Visible := assigned(MyTree.focusednode);
  EditSpell3.Visible := assigned(MyTree.focusednode);
end;

// --------sorting Events---------------

procedure TForm1.filterSrcNameClick(Sender: TObject);
var
  Data: ptreedata;
  filter: eventFilter;
begin
  if assigned(MyTree.focusednode) then
  begin
    Data := MyTree.GetNodeData(MyTree.focusednode);
    filter.option := [optAroundNode, optSourceUnitID];
    filter.GUID := getUnitGUID(Data.BasicND.p.sourceUnit).GUID;
    filter.p := Data.BasicND.p;
    fillTreeEvent(filter);
  end;
end;

procedure TForm1.SetStartGraph1Click(Sender: TObject);
var
  Data: ptreedata;
begin
  if assigned(MyTree.focusednode) then
  begin
    Data := MyTree.GetNodeData(MyTree.focusednode);
    SetGraphOnEvent(Data.BasicND.p, true,
      round((100 / (100 / paramGraph.imagemap_zoom)) * MARGE_REPERE));
    GraphicTab.show;
  end;
end;

procedure TForm1.filterDestNameClick(Sender: TObject);
var
  Data: ptreedata;
  filter: eventFilter;
begin
  if assigned(MyTree.focusednode) then
  begin
    Data := MyTree.GetNodeData(MyTree.focusednode);
    filter.option := [optAroundNode, optDestUnitID];
    filter.GUID := getUnitGUID(Data.BasicND.p.destUnit).GUID;
    filter.p := Data.BasicND.p;
    fillTreeEvent(filter);
  end;
end;

procedure TForm1.filterAroundNode(filterOpt: eventOptions);
var
  Data: ptreedata;
  filter: eventFilter;
begin
  if assigned(MyTree.focusednode) then
  begin
    Data := MyTree.GetNodeData(MyTree.focusednode);
    filter.option := filterOpt;
    filter.p := Data.BasicND.p;
    fillTreeEvent(filter);
  end;
end;

procedure TForm1.FilterAroundEvents1Click(Sender: TObject);
begin
  filterAroundNode([optAroundNode]);
end;

procedure TForm1.CheckSpell1Click(Sender: TObject);
var
  Data: ptreedata;
begin
  if assigned(MyTree.focusednode) then
  begin
    Data := MyTree.GetNodeData(MyTree.focusednode);
    getWebInfoforSpell(Data.BasicND.p.spell);
  end;
end;

procedure TForm1.EditSpell3Click(Sender: TObject);
var
  Data: ptreedata;
begin
  if assigned(MyTree.focusednode) then
  begin
    Data := MyTree.GetNodeData(MyTree.focusednode);
    editSpellParams(Data.BasicND.p.spell.id);
  end;
end;

// ---------graphic

procedure TForm1.InitBitmap;
var
  l: TPositionedLayer;
begin
  with Imagemap do
  begin
    Scale := 1;
    Bitmap.SetSize(2, 2);
    Bitmap.clear(color32($00AAAAAA));
    Buffer.StippleStep := 0.5;
    BufferOversize := 0;
  end;
  l := TPositionedLayer.create(Imagemap.Layers);
  l.Location := FloatRect(0, 0, 2, 2);
  l.OnPaint := PaintSimpleDrawingHandler;
end;

procedure TForm1.PaintSimpleDrawingHandler(Sender: TObject; Buffer: tbitmap32);
begin
  Buffer.font.Name := 'Arial';
  Buffer.font.Style := [];
  Buffer.font.color := clBlack;
  Buffer.font.Size := FONT_SIZE;

  ERRORCHECKPOINT := 50;

  if dontdisturb then
  begin
    Buffer.textout(10, 24, WAITING_FOR_DATA);
    exit;
  end;

  // ----------
  clearMouseDetect(false);
  // secure MARGE_NAME;
  if MARGE_NAME < 12 + iconrole[1].width + STATSWIDGETSIZEX then
    MARGE_NAME := 12 + iconrole[1].width + STATSWIDGETSIZEX;
  if MARGE_NAME > Imagemap.width - 22 then
    MARGE_NAME := Imagemap.width - 22;
  // ---------------------
  if paramGraph.FocusedMode > 0 then
    GraphicDrawFocusedUnit(Buffer)
  else
    GraphicDrawFullUnitList(Buffer);

  GraphicDrawMarge(Buffer);

  validateMouseDetect;

  if CurrentLogError then
  begin
    Buffer.font.Name := 'Arial';
    Buffer.font.Style := [fsBold];
    Buffer.font.color := clRed;
    Buffer.textout(5, 3, '!!!');
    Buffer.font.color := clBlack;
  end;

  ERRORCHECKPOINT := 51;
end;

function TForm1.GraphicDrawRaidInitHeader: integer;
var
  i: integer;
  margevalid: boolean;
  Node: pvirtualnode;
  Data: ptreeGenericdata;
begin
  Result := 1;
  margevalid := false;
  for i := 1 to 8 do
    if paramGraph.lines[i].valid and (Result < paramGraph.lines[i].absratio)
      then
    begin
      Result := paramGraph.lines[i].absratio;
      margevalid := true;
    end;
  if paramGraph.select.state = sS_valid then
  begin
    Node := CompareTree.getfirst;
    while assigned(Node) do
    begin
      if Node.CheckState = csCheckedNormal then
      begin
        Data := CompareTree.GetNodeData(Node);
        if (Result < tCompareLineArray(Data.BasicND.p).line.absratio) then
          Result := tCompareLineArray(Data.BasicND.p).line.absratio;
        margevalid := true;
      end;
      Node := Node.NextSibling;
    end;
  end;

  if margevalid then
  begin
    // securisation
    if MARGE_RAID = 0 then
      MARGE_RAID := MARGE_RAID_BACK;
    if MARGE_RAID > Imagemap.height - (MARGE_HAUT + MARGE_CHAT) - 20 then
      MARGE_RAID := Imagemap.height - (MARGE_HAUT + MARGE_CHAT) - 20;
    if MARGE_RAID < MARGE_RAID_DEFAULT then
      MARGE_RAID := MARGE_RAID_DEFAULT;
    if MARGE_RAID > 0 then
      MARGE_RAID_BACK := MARGE_RAID;
  end
  else
  begin
    if MARGE_RAID > 0 then
      MARGE_RAID_BACK := MARGE_RAID;
    MARGE_RAID := 0;
  end;
end;

procedure TForm1.GraphicDrawMarge(Buffer: tbitmap32);
begin
  Buffer.pencolor := $20FFFFFF;
  Buffer.movetof(MARGE_NAME, MARGE_HAUT);
  Buffer.linetofs(MARGE_NAME, Imagemap.height);
end;

procedure TForm1.GraphicDrawRaid(maxvalue: integer; sizeSecond: double;
  Buffer: tbitmap32);
var
  i, j: integer;
  sizehpinterval: double;
  y, y0: double;
  baseHpRow, yint, tmpy: integer;
  maxratio, aLine: integer;
  GRID_BASE_RATIO: integer;
  t: tsize;
  strtmp: string;
  Node: pvirtualnode;
  Data: ptreeGenericdata;
begin
  // ------------
  Buffer.font.Style := [];
  Buffer.font.Size := FONT_SIZE_MIN;
  maxratio := NoZeroValue(maxvalue div (MARGE_RAID - (3 + 3)));
  maxvalue := maxvalue div round(paramGraph.dpsInterval / 4);
  // grid
  GRID_BASE_RATIO := 1000;
  for i := 0 to high(ARRAYGRID_BASE_RATIO) do
    if maxvalue >= ARRAYGRID_BASE_RATIO[i].maxdps then
    begin
      GRID_BASE_RATIO := ARRAYGRID_BASE_RATIO[i].Interval;
      break;
    end;

  aLine := GRID_BASE_RATIO;

  y0 := 0;
  Buffer.SetStipple([$FFAAAAAA, $FFAAAAAA, $FF888888]);
  while aLine <= maxvalue do
  begin
    y := (aLine * round(paramGraph.dpsInterval / 4)) / maxratio;
    yint := round(y);
    if (y - y0 > GRID_BASE_INTERVAL) then
    begin
      y0 := y;
      tmpy := MARGE_HAUT + MARGE_CHAT + MARGE_RAID - 3 - yint;
      if tmpy > MARGE_HAUT + MARGE_CHAT then
      begin
        Buffer.movetof(MARGE_NAME, tmpy);
        Buffer.linetofsp(Imagemap.width, tmpy);

        strtmp := intToStrEx(aLine);
        t := Buffer.TextExtent(strtmp);
        Buffer.textout(MARGE_NAME - t.cx - 3, tmpy,
          Rect(0, MARGE_HAUT + MARGE_CHAT, MARGE_NAME,
            MARGE_HAUT + MARGE_CHAT + MARGE_RAID), strtmp);
      end;
    end;
    aLine := aLine + GRID_BASE_RATIO
  end;

  // header
  Buffer.FillRectS(0, MARGE_HAUT + MARGE_CHAT + 3, 5,
    MARGE_HAUT + MARGE_CHAT + MARGE_RAID - 3, color32(ClasseStat[0].color));
  Buffer.font.Style := [fsBold];
  Buffer.font.Size := FONT_SIZE;
  Buffer.textout(10, MARGE_HAUT + MARGE_CHAT + 3,
    Rect(0, MARGE_HAUT + MARGE_CHAT + 3, MARGE_NAME,
      MARGE_HAUT + MARGE_CHAT + MARGE_RAID), 'Raid');
  Buffer.font.Style := [];
  sizehpinterval := sizeSecond / HP_INTERVAL;
  baseHpRow := (paramGraph.startDrawTime - paramGraph.startHpTime)
    div BASE_HP_FEEDBACK_INTERVAL;

  // compare
  if paramGraph.select.state = sS_valid then
  begin
    Node := CompareTree.getfirst;
    while assigned(Node) do
    begin
      if Node.CheckState = csCheckedNormal then
      begin
        Data := CompareTree.GetNodeData(Node);
        Buffer.pencolor := tCompareLineArray(Data.BasicND.p).color;
        if assigned(tCompareLineArray(Data.BasicND.p).line.eventarray) then
          GraphicDrawRaidLine(tCompareLineArray(Data.BasicND.p).line,
            baseHpRow, maxratio, sizehpinterval, Buffer);
      end;
      Node := Node.NextSibling;
    end;
  end;

  // regulars
  for j := 1 to 8 do
    if paramGraph.lines[j].valid then
    begin
      Buffer.pencolor := RAID_ARRAYLINE_COLOR[j];
      if assigned(paramGraph.lines[j].eventarray) then
        GraphicDrawRaidLine(paramGraph.lines[j], baseHpRow, maxratio,
          sizehpinterval, Buffer);
    end;
end;

procedure TForm1.GraphicDrawRaidLine(l: linearray;
  baseHpRow, maxratio: integer; sizehpinterval: double; Buffer: tbitmap32);
var
  i, hp: integer;
  x: double;
begin
  for i := baseHpRow to high(l.eventarray) do
  begin
    // level of distance
    if (i > baseHpRow) then
      if not GetLineLOD(i) then
        continue;
    x := MARGE_NAME + i * sizehpinterval - baseHpRow * sizehpinterval;
    if x > Imagemap.width then
      break;
    if i >= 0 then
    begin
      hp := l.eventarray[i] div maxratio;
      if hp > MARGE_RAID - 3 then
        hp := MARGE_RAID - 3;
    end
    else
      hp := 0;
    if i = baseHpRow then
      Buffer.movetof(x, MARGE_HAUT + MARGE_CHAT + MARGE_RAID - hp - 3);
    Buffer.linetofs(x + sizehpinterval + 1,
      MARGE_HAUT + MARGE_CHAT + MARGE_RAID - hp - 3);
  end;
end;

Procedure TForm1.GraphicDrawChat(Buffer: tbitmap32);
var
  Node: pvirtualnode;
  Data: ptreeGenericdata;
  eventoffset, x, y: integer;
begin
  if MARGE_CHAT = 0 then
    exit;
  Buffer.FillRectS(0, MARGE_HAUT, Imagemap.width, MARGE_HAUT + MARGE_CHAT,
    $FF888888);
  y := MARGE_HAUT + BASE_TAI_A + 2;
  Node := paramGraph.chatNode;
  while assigned(Node) do
  begin
    Data := ChatTree.GetNodeData(Node);
    eventoffset := timetocontrol(pChatEvent(Data.BasicND.p).Time);
    if eventoffset > Imagemap.width then
      exit; ;
    x := eventoffset;

    Buffer.FillRectTS(x - BASE_TAI_A, y - BASE_TAI_A, x + BASE_TAI_B,
      y + BASE_TAI_B, $FFDDDDDD);
    Node := Node.NextSibling;
  end;
end;

procedure TForm1.GraphicDrawCombatBlock(sizeSecond: double; Buffer: tbitmap32;
  drawtext: boolean);
var
  i, xs1, xs2: integer;
  cb: tcombatBlock;
begin
  Buffer.FillRectS(MARGE_NAME, 0, Imagemap.width, MARGE_HAUT, $FFBABABA);

  Buffer.font.Style := [];
  for i := 0 to CombatBlockList.count - 1 do
  begin
    cb := CombatBlockList.items[i];
    xs1 := timetocontrol(cb.timestart);
    xs2 := timetocontrol(cb.timestop);

    Buffer.FillRectTS(xs1, 0, xs2, MARGE_HAUT, cb.color);
    Buffer.font.Size := FONT_SIZE;
    if cb.containBoss > 0 then
      Buffer.font.Style := [fsBold];

    Buffer.textout(xs1 + 10, 2, Rect(xs1 + 10, 0, xs2 - 11, MARGE_HAUT),
      cb.legende + '  (' + cb.legendeduration + ')');

    if MARGE_HAUT > MARGE_HAUT_DEFAULTMIN then
    begin
      Buffer.font.Style := [];
      Buffer.font.Size := FONT_SIZE_MIN;
      Buffer.textout(xs1 + 10, MARGE_HAUT_DEFAULTMIN - 2,
        Rect(xs1 + 10, 0, xs2 - 11, MARGE_HAUT),
        cb.legendetime + ': ' + cb.legende2);
    end;
  end;
  // entete marge_name opaque
  Buffer.FillRectS(0, 0, MARGE_NAME, MARGE_HAUT, $FFBABABA);
  // reset font data
  Buffer.font.Style := [];
  Buffer.font.Size := FONT_SIZE;
end;

Procedure TForm1.GraphicDrawFocusedUnit(Buffer: tbitmap32);
var
  i: integer;
  sizeSecond: double;
  strtmp: string;
  tag: integer;
begin
  sizeSecond := 100 / paramGraph.imagemap_zoom;
  // paramgraph.WatchedLineHidden:=true;
  if paramGraph.WatchedLineHidden then
    FOCUSED_AURA_BASEOFFSET := FOCUSED_UNIT_SPACE_LINE + 20
  else
  begin
    FOCUSED_AURA_BASEOFFSET := 6 * FOCUSED_UNIT_SPACE_LINE + 20;
    for i := 1 to 5 do
    begin
      if (i + 1) mod 2 = 0 then
        Buffer.FillRectS(0, MARGE_HAUT + MARGE_CHAT + (i)
            * FOCUSED_UNIT_SPACE_LINE, Imagemap.width,
          MARGE_HAUT + MARGE_CHAT + (i + 1)
            * FOCUSED_UNIT_SPACE_LINE, $FFBABABA);
      Buffer.textout(5, MARGE_HAUT + MARGE_CHAT + FOCUSED_NAME_POS + i *
          FOCUSED_UNIT_SPACE_LINE, Rect(0, 0, MARGE_NAME - 5, Imagemap.height),
        FOCUSED_LABEL[i]);
    end;
    Buffer.FillRectS(0,
      MARGE_HAUT + MARGE_CHAT + (FOCUSED_ARRAYLINE_POSITION[5] + 1)
        * FOCUSED_UNIT_SPACE_LINE - GRAPH_OFFSET, Imagemap.width,
      MARGE_HAUT + MARGE_CHAT + (FOCUSED_ARRAYLINE_POSITION[5] + 1)
        * FOCUSED_UNIT_SPACE_LINE, $00CCBBBB);
    Buffer.font.Style := [];
  end;

  Buffer.FillRectS(0, MARGE_HAUT + MARGE_CHAT, 20,
    MARGE_HAUT + MARGE_CHAT + FOCUSED_UNIT_SPACE_LINE,
    color32(ClasseStat[paramGraph.WatchedUnit.Classe].color));
  Buffer.font.Style := [fsBold];

  strtmp := getunitname(paramGraph.WatchedUnit, [getaff]);
  tag := 22;
  if paramGraph.WatchedUnit.stats.iconrole > 0 then
  begin
    Buffer.draw(tag, MARGE_HAUT + MARGE_CHAT + FOCUSED_NAME_POS - 1,
      iconrole[paramGraph.WatchedUnit.stats.iconrole]);
    tag := tag + iconrole[1].width;
    if GfxDrawStatsWidget.down then
    begin
      drawstatsWidget(Buffer, paramGraph.WatchedUnit, tag,
        MARGE_HAUT + MARGE_CHAT + FOCUSED_NAME_POS + 2);
      tag := tag + STATSWIDGETSIZEX;
    end;
  end;
  tag := tag + 5;

  Buffer.textout(tag, MARGE_HAUT + MARGE_CHAT + FOCUSED_NAME_POS,
    Rect(0, 0, MARGE_NAME - 5, Imagemap.height), strtmp);

  GraphicDrawSeconds(sizeSecond, Buffer);
  GraphicDrawMinutes(sizeSecond, Buffer);
  GraphicDrawCombatBlock(sizeSecond, Buffer, true);
  GraphicDrawChat(Buffer);
  GraphicDrawSelection(Buffer);
  GraphicDrawTag(Buffer);

  case paramGraph.FocusedMode of
    2:
      begin
        GraphicDrawFocusedRotation(paramGraph.Rotationlines.eventIn, Buffer);
        GraphicDrawFocusedEvents_RotationIn(paramGraph.Rotationlines.eventIn,
          Buffer)
      end;
    3:
      begin
        GraphicDrawFocusedAura(Buffer);
        GraphicDrawFocusedEvents_SourceAura(Buffer)
      end;
    4:
      begin
        GraphicDrawFocusedAura(Buffer);
        GraphicDrawFocusedEvents_DestAura(Buffer);
      end;
  else
    begin
      GraphicDrawFocusedRotation(paramGraph.Rotationlines.eventOut, Buffer);
      GraphicDrawFocusedEvents_RotationOut(paramGraph.Rotationlines.eventOut,
        Buffer)
    end;
  end;

  if not paramGraph.WatchedLineHidden then
  begin
    GraphicDrawFocusedLineArray(sizeSecond, Buffer);
    if paramGraph.qstatsUnit = paramGraph.WatchedUnit then
      GraphicDrawQuickStats(Buffer);
  end;

  GraphicDrawIgnoredEvent(Buffer);
  GraphicDrawReglette(Buffer);

end;

procedure TForm1.GraphicDrawFocusedRotation(l: tlist; Buffer: tbitmap32);
var
  i, j, posY, x1, x2, y, offset: integer;
  Rotationline: trotationline;
  strtmp: string;
  auraline: tauraline;
  auraEvent: tauraevent;
  eventoffsetstart, eventoffsetend: integer;
begin
  i := -1;
  // etablissement du maxoffset en tnatn compte des filtres
  for j := 0 to l.count - 1 do
  begin
    Rotationline := l.items[j];
    Rotationline.spell.offsetaura := -1;
    if Rotationline.infilter and (Rotationline.mobId = 0) then
      inc(i);
  end;

  if paramGraph.FocusedAuraOffset > i then
    paramGraph.FocusedAuraOffset := i;
  i := -1;
  // draw arrow, if offset is not 0
  If paramGraph.FocusedAuraOffset > 0 then
    Buffer.textout(5, MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET - 18,
      '^');
  // auras
  for j := 0 to l.count - 1 do
  begin
    Rotationline := l.items[j];
    if (not Rotationline.infilter) or (Rotationline.mobId > 0) then
      continue;

    inc(i);
    Rotationline.offset := i - paramGraph.FocusedAuraOffset;
    Rotationline.spell.offsetaura := Rotationline.offset;

    if Rotationline.offset < 0 then
      continue;
    // grid
    if i mod 2 = 0 then
      Buffer.FillRectTS(0, MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET +
          (Rotationline.offset) * FOCUSED_AURA_LINE - FOCUSED_AURA_LINE div 2,
        Imagemap.width, MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET +
          (Rotationline.offset) * FOCUSED_AURA_LINE +
          FOCUSED_AURA_LINE div 2 - 1, $1FFFFFFF);

    if Rotationline.spell.id = paramGraph.FocusedRotation then
    begin
      Buffer.FillRectTS(0, MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET +
          (Rotationline.offset) * FOCUSED_AURA_LINE - FOCUSED_AURA_LINE div 2,
        Imagemap.width, MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET +
          (Rotationline.offset) * FOCUSED_AURA_LINE +
          FOCUSED_AURA_LINE div 2 - 1, AURAFOCUSCOLOR[1]);
    end;

    strtmp := Rotationline.spell.name; // +auraline.uptimestr;
    posY := MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET +
      (Rotationline.offset) * FOCUSED_AURA_LINE - 8;
    Buffer.font.Style := [];
    Buffer.textout(5, posY, Rect(0, 0, MARGE_NAME - 5, Imagemap.height),
      strtmp);
  end;
  /// aura

  for i := 0 to paramGraph.auralines.count - 1 do
  begin
    auraline := paramGraph.auralines.items[i];
    x2 := 0;
    for j := 0 to auraline.list.count - 1 do
    begin
      offset := GetRotationoffset(auraline.spell);
      if offset < 0 then
        break;
      y := MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET + (offset)
        * FOCUSED_AURA_LINE;
      auraEvent := auraline.list.items[j];
      eventoffsetstart := timetocontrol(auraEvent.startTime);
      eventoffsetend := timetocontrol(auraEvent.endTime);

      if eventoffsetstart > Imagemap.width then
        continue;
      if auraEvent.endTime = -1 then
        continue; // test

      if eventoffsetstart < MARGE_NAME then
        eventoffsetstart := MARGE_NAME;
      if eventoffsetend > Imagemap.width then
        eventoffsetend := Imagemap.width;

      x1 := eventoffsetstart - BASE_TAI_A;
      if x1 < x2 then
        x1 := x2;
      if eventoffsetend + BASE_TAI_B > x2 then
        x2 := eventoffsetend + BASE_TAI_B;
      if x1 < x2 then
        Buffer.FillRectTS(x1, y - BASE_TAI_A, x2, y + BASE_TAI_B,
          FOCUSED_EVENT_AURA_COLOR[ord(auraline.isdebuff)]);

      if auraline.getspellId = paramGraph.FocusedRotation then
      begin
        Buffer.FillRectTS(x1,
          MARGE_HAUT + MARGE_CHAT + FOCUSED_UNIT_SPACE_LINE, x2,
          MARGE_HAUT + MARGE_CHAT + FOCUSED_UNIT_SPACE_LINE * 6,
          FOCUSED_EVENT_AURASELECTED_COLOR[ord(auraline.isdebuff)]);
        Buffer.FrameRectS(x1,
          MARGE_HAUT + MARGE_CHAT + FOCUSED_UNIT_SPACE_LINE, x2,
          MARGE_HAUT + MARGE_CHAT + FOCUSED_UNIT_SPACE_LINE * 6,
          FOCUSED_EVENT_AURASELECTED_COLOR_BORDER[ord(auraline.isdebuff)]);
      end;

      Buffer.font.Style := [];
      Buffer.textout(5, y - 8, Rect(0, 0, MARGE_NAME - 5, Imagemap.height),
        getspellname(auraline.getspellId) + auraline.uptimestr);

    end;
  end;
end;

procedure TForm1.GraphicDrawFocusedAura(Buffer: tbitmap32);
var
  i, j, y, taix, posY, x1, x2: integer;
  auraline: tauraline;
  auraEvent: tauraevent;
  eventoffsetstart, eventoffsetend: integer;
  multilinespell: integer;
  strtmp: string;
  isauraselected: boolean;
begin
  multilinespell := -1;
  // draw arrow, if offset is not 0
  If paramGraph.FocusedAuraOffset > 0 then
    Buffer.textout(5, MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET - 18,
      '^');
  // auras
  for i := 0 to paramGraph.auralines.count - 1 do
  begin
    auraline := paramGraph.auralines.items[i];
    // checking if the aura has multi line rendering  due to multi-source

    auraline.offset := i - (paramGraph.FocusedAuraOffset);
    if multilinespell <> auraline.getspellId then
    begin
      tspellinfo(auraline.spell).offsetaura := i;
      multilinespell := auraline.getspellId;
    end;
    if auraline.offset < 0 then
      continue;

    isauraselected := false;
    if auraline.getspellId = paramGraph.FocusedAura then
    begin
      isauraselected := auraline.u = paramGraph.FocusedAuraUnit;
      Buffer.FillRectTS(0, MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET +
          (auraline.offset) * FOCUSED_AURA_LINE - FOCUSED_AURA_LINE div 2,
        Imagemap.width, MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET +
          (auraline.offset) * FOCUSED_AURA_LINE + FOCUSED_AURA_LINE div 2 - 1,
        AURAFOCUSCOLOR[ord(isauraselected)]);
    end;

    if auraline.isdebuff then
      Buffer.font.Style := [fsBold]
    else
      Buffer.font.Style := [];
    strtmp := auraline.getspellname;
    posY := MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET +
      (auraline.offset) * FOCUSED_AURA_LINE - 8;
    Buffer.textout(5, posY, Rect(0, 0, MARGE_NAME - 5, Imagemap.height),
      strtmp);
    taix := Buffer.TextExtent(strtmp).cx + 5;
    Buffer.font.Style := [fsItalic];
    Buffer.textout(taix + 8, posY, Rect(0, 0, MARGE_NAME - 5, Imagemap.height),
      getunitname(tUnitData(auraline.u), [getaff, getNoserver],
        '*') + auraline.uptimestr);

    x2 := 0;
    for j := 0 to auraline.list.count - 1 do
    begin
      auraEvent := auraline.list.items[j];
      eventoffsetstart := timetocontrol(auraEvent.startTime);
      eventoffsetend := timetocontrol(auraEvent.endTime);

      if eventoffsetstart > Imagemap.width then
        continue;
      if auraEvent.endTime = -1 then
        continue; // test

      if eventoffsetstart < MARGE_NAME then
        eventoffsetstart := MARGE_NAME;
      if eventoffsetend > Imagemap.width then
        eventoffsetend := Imagemap.width;

      y := MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET +
        (auraline.offset) * FOCUSED_AURA_LINE;

      x1 := eventoffsetstart - BASE_TAI_A;
      if x1 < x2 then
        x1 := x2;
      if eventoffsetend + BASE_TAI_B > x2 then
        x2 := eventoffsetend + BASE_TAI_B;
      if x1 < x2 then
      begin
        Buffer.FillRectTS(x1, y - BASE_TAI_A, x2, y + BASE_TAI_B,
          FOCUSED_EVENT_AURA_COLOR[ord(auraline.isdebuff)]);

        if isauraselected then
        begin
          Buffer.FillRectTS(x1,
            MARGE_HAUT + MARGE_CHAT + FOCUSED_UNIT_SPACE_LINE, x2,
            MARGE_HAUT + MARGE_CHAT + FOCUSED_UNIT_SPACE_LINE * 6,
            FOCUSED_EVENT_AURASELECTED_COLOR[ord(auraline.isdebuff)]);
          Buffer.FrameRectS(x1,
            MARGE_HAUT + MARGE_CHAT + FOCUSED_UNIT_SPACE_LINE, x2,
            MARGE_HAUT + MARGE_CHAT + FOCUSED_UNIT_SPACE_LINE * 6,
            FOCUSED_EVENT_AURASELECTED_COLOR_BORDER[ord(auraline.isdebuff)]);
        end;
      end;
    end;
  end;
end;

procedure TForm1.GraphicDrawFocusedLineArray(sizeSecond: double;
  Buffer: tbitmap32);
var
  i, j: integer;
  sizehpinterval: double;
  hp: integer;
  x: double;
  baseHpRow: integer;
begin
  sizehpinterval := sizeSecond / HP_INTERVAL;
  baseHpRow := (paramGraph.startDrawTime - paramGraph.startHpTime)
    div BASE_HP_FEEDBACK_INTERVAL;
  for j := 1 to 7 do
  begin
    if j > 6 then
      Buffer.pencolor := eINFOPOWER[paramGraph.WatchedUnit.getcurrentPower
        (CURRENTPOWER) + 1].color
    else
      Buffer.pencolor := FOCUSED_ARRAYLINE_COLOR[j];
    if assigned(paramGraph.lines[j].eventarray) then
      for i := baseHpRow to high(paramGraph.lines[j].eventarray) do
      begin
        // level of distance
        if (i > baseHpRow) then
          if not GetLineLOD(i) then
            continue;
        x := MARGE_NAME + i * sizehpinterval - baseHpRow * sizehpinterval;
        if x > Imagemap.width then
          break;
        if i >= 0 then
        begin
          hp := paramGraph.lines[j].eventarray[i] div paramGraph.lines[j]
            .gfxratio;
          if hp > FOCUSED_UNIT_SPACE_LINE - 3 then
            hp := FOCUSED_UNIT_SPACE_LINE - 3;
        end
        else
          hp := 0;

        if (j = 5) and (not AuthUse52Log) then // hp
        begin
          if i = baseHpRow then
            Buffer.movetof(x, MARGE_HAUT + MARGE_CHAT +
                FOCUSED_ARRAYLINE_POSITION[j] * FOCUSED_UNIT_SPACE_LINE + hp +
                2);
          Buffer.linetofs(x + sizehpinterval + 1,
            MARGE_HAUT + MARGE_CHAT + FOCUSED_ARRAYLINE_POSITION[j] *
              FOCUSED_UNIT_SPACE_LINE + hp + 2);
        end
        else
        begin
          if i = baseHpRow then
            Buffer.movetof(x, MARGE_HAUT + MARGE_CHAT +
                (FOCUSED_ARRAYLINE_POSITION[j] + 1) *
                (FOCUSED_UNIT_SPACE_LINE) - hp - 1);
          Buffer.linetofs(x + sizehpinterval + 1,
            MARGE_HAUT + MARGE_CHAT + (FOCUSED_ARRAYLINE_POSITION[j] + 1) *
              (FOCUSED_UNIT_SPACE_LINE) - hp - 1);
        end;
      end;
  end;
end;

procedure TForm1.drawDose(Buffer: tbitmap32; pstats: reventstat; r: rmapnode);
var
  sdose: tsize;
  strdose: string;
begin
  if (paramGraph.imagemap_zoom < ZOOM_PALIER_2) then
  begin
    if pstats.amountGeneric > 0 then
    begin
      strdose := inttostr(pstats.amountGeneric);
      sdose := Buffer.TextExtent(strdose);
      sdose.cy := sdose.cy div 2;
      Buffer.FillRectTS(r.x + BASE_TAI_B + 1, r.y - (sdose.cy),
        r.x + BASE_TAI_B + 3 + sdose.cx, r.y + (sdose.cy - 1),
        $FFFFFFFF);
      Buffer.textout(r.x + BASE_TAI_B + 2, r.y - sdose.cy, strdose);
    end;
  end;
end;

procedure TForm1.GraphicDrawFocusedEvents_DestAura(Buffer: tbitmap32);
var
  i, tmpy: integer;
  eventoffset: integer;
  r: rmapnode;
  p: pEvent;
begin
  // --------EVENTS--------
  Buffer.font.Size := FONT_SIZE_MIN;
  Buffer.font.Style := [];
  // source
  if paramGraph.DrawEvent then
    for i := paramGraph.startDrawEventId to Eventlist.count - 1 do
    begin
      p := Eventlist.items[i];
      // si on depasse la taille de l'image = exit
      eventoffset := timetocontrol(p.Time);
      if eventoffset > Imagemap.width then
        break;
      if eventoffset < MARGE_NAME then
        continue;
      // -----------
      if p.drawit = 0 then
        continue;
      // focus
      if paramGraph.unitRef then
        if not isEventOnFocus(p, btnFocusMode.down, globalFocusType) then
          continue;
      //
      if IsEventInFilter(p) then
      begin

        // SOURCE_EVENT
        if (p.sourceUnit = paramGraph.WatchedUnit) and not
          (eventisaura in p.params) then
        begin
          r.x := eventoffset;
          r.y := MARGE_HAUT + MARGE_CHAT + (eventValue[ord(p.event)].focusLine)
            * FOCUSED_UNIT_SPACE_LINE + eventValue[ord(p.event)]
            .focusOffset * GRAPH_OFFSET + 4;
          // print
          r.p := p;
          setmapnode(r);
          Buffer.FillRectTS(r.x - BASE_TAI_A, r.y - BASE_TAI_A,
            r.x + BASE_TAI_B, r.y + BASE_TAI_B, color32(p.getcolor));

        end;

        // DEST_EVENT
        // si l'action est d'unité à unité on continue.
        // if (eventIsSelf in p.params) and (not (eventIsAura in p.params) then continue;

        // destination---- (dégat recus + aura )
        if p.destUnit = paramGraph.WatchedUnit then
        begin
          // affichage
          r.x := eventoffset;
          // aura :
          if (eventisaura in p.params) then
          begin
            tmpy := Getauraoffset(p.spell, p.sourceUnit);
            if (tmpy >= 0) then
            begin
              r.y := MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET + (tmpy)
                * FOCUSED_AURA_LINE;
              drawDose(Buffer, p.eventStat, r);
            end
            else
              continue;
          end
          else
            r.y := MARGE_HAUT + MARGE_CHAT +
              (eventValue[ord(p.event)].receivedLine)
              * FOCUSED_UNIT_SPACE_LINE +
              FOCUSED_UNIT_SPACE_LINE - GRAPH_OFFSET * eventValue[ord(p.event)]
              .receivedOffset + BASE_TAI_B;
          // print
          r.p := p;
          if setmapnode(r, false) then
            Buffer.FillRectTS(r.x - BASE_TAI_A, r.y - BASE_TAI_A,
              r.x + BASE_TAI_B, r.y + BASE_TAI_B, color32(p.getcolor));
        end;
      end;
    end;
  Buffer.font.Style := [];
  Buffer.font.Size := FONT_SIZE;
end;

procedure TForm1.GraphicDrawFocusedEvents_SourceAura(Buffer: tbitmap32);
var
  i, tmpy: integer;
  eventoffset: integer;
  r: rmapnode;
  p: pEvent;
begin
  // --------EVENTS--------
  Buffer.font.Size := FONT_SIZE_MIN;
  Buffer.font.Style := [];
  // source
  if paramGraph.DrawEvent then
    for i := paramGraph.startDrawEventId to Eventlist.count - 1 do
    begin
      p := Eventlist.items[i];
      // si on depasse la taille de l'image = exit
      eventoffset := timetocontrol(p.Time);
      if eventoffset > Imagemap.width then
        break;
      if eventoffset < MARGE_NAME then
        continue;
      // -----------
      if p.drawit = 0 then
        continue;
      // focus
      if paramGraph.unitRef then
        if not isEventOnFocus(p, btnFocusMode.down, globalFocusType) then
          continue;
      //
      if IsEventInFilter(p) then
      begin
        // SOURCE_EVENT
        if (p.sourceUnit = paramGraph.WatchedUnit) then
        begin
          r.x := eventoffset;
          if (eventisaura in p.params) then
          begin
            tmpy := Getauraoffset(p.spell, p.destUnit);
            if (tmpy >= 0) then
            begin
              r.y := MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET + (tmpy)
                * FOCUSED_AURA_LINE;
              drawDose(Buffer, p.eventStat, r);
            end
            else
              continue;
          end
          else
            r.y := MARGE_HAUT + MARGE_CHAT +
              (eventValue[ord(p.event)].focusLine)
              * FOCUSED_UNIT_SPACE_LINE + eventValue[ord(p.event)]
              .focusOffset * GRAPH_OFFSET + 4;

          // print
          r.p := p;
          setmapnode(r);
          Buffer.FillRectTS(r.x - BASE_TAI_A, r.y - BASE_TAI_A,
            r.x + BASE_TAI_B, r.y + BASE_TAI_B, color32(p.getcolor));

        end;

        // DEST_EVENT
        // si l'action est d'unité à unité on continue.
        // if (eventIsSelf in p.params) then continue;

        // destination---- (dégat recus + aura )
        if (p.destUnit = paramGraph.WatchedUnit) and not
          (eventisaura in p.params) then
        begin
          // affichage
          r.x := eventoffset;
          r.y := MARGE_HAUT + MARGE_CHAT +
            (eventValue[ord(p.event)].receivedLine)
            * FOCUSED_UNIT_SPACE_LINE + FOCUSED_UNIT_SPACE_LINE -
            GRAPH_OFFSET * eventValue[ord(p.event)]
            .receivedOffset + BASE_TAI_B;
          // print
          r.p := p;
          if setmapnode(r, false) then
            Buffer.FillRectTS(r.x - BASE_TAI_A, r.y - BASE_TAI_A,
              r.x + BASE_TAI_B, r.y + BASE_TAI_B, color32(p.getcolor));
        end;
      end;
    end;
  Buffer.font.Style := [];
  Buffer.font.Size := FONT_SIZE;
end;

procedure TForm1.GraphicDrawFocusedEvents_RotationOut(l: tlist;
  Buffer: tbitmap32);
var
  i, tmpy: integer;
  eventoffset: integer;
  r: rmapnode;
  p: pEvent;
begin
  // --------EVENTS--------
  Buffer.font.Size := FONT_SIZE_MIN;
  Buffer.font.Style := [];
  // source
  if paramGraph.DrawEvent then
    for i := paramGraph.startDrawEventId to Eventlist.count - 1 do
    begin
      p := Eventlist.items[i];
      // si on depasse la taille de l'image = exit
      eventoffset := timetocontrol(p.Time);
      if eventoffset > Imagemap.width then
        break;
      if eventoffset < MARGE_NAME then
        continue;
      // -----------
      if p.drawit = 0 then
        continue;
      // focus
      if paramGraph.unitRef then
        if not isEventOnFocus(p, btnFocusMode.down, globalFocusType) then
          continue;
      //
      if IsEventInFilter(p) then
      begin
        // SOURCE_EVENT
        if (p.sourceUnit = paramGraph.WatchedUnit) then
        begin
          r.x := eventoffset;
          tmpy := GetRotationoffset(p.spell);
          if (tmpy >= 0) then
            r.y := MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET + (tmpy)
              * FOCUSED_AURA_LINE
          else if p.spell.id = 0 then
            r.y := MARGE_HAUT + MARGE_CHAT +
              (eventValue[ord(p.event)].focusLine)
              * FOCUSED_UNIT_SPACE_LINE + eventValue[ord(p.event)]
              .focusOffset * GRAPH_OFFSET + 4
          else
            continue;

          if eventisaura in p.params then
            drawDose(Buffer, p.eventStat, r);
          // print
          r.p := p;
          setmapnode(r);
          // plot
          Buffer.FillRectTS(r.x - BASE_TAI_A, r.y - BASE_TAI_A,
            r.x + BASE_TAI_B, r.y + BASE_TAI_B, color32(p.getcolor));
          continue;
        end;

        // DEST_EVENT
        if (p.destUnit = paramGraph.WatchedUnit) and not
          (eventisaura in p.params) then
        begin
          // affichage
          r.x := eventoffset;
          r.y := MARGE_HAUT + MARGE_CHAT +
            (eventValue[ord(p.event)].receivedLine)
            * FOCUSED_UNIT_SPACE_LINE + FOCUSED_UNIT_SPACE_LINE -
            GRAPH_OFFSET * eventValue[ord(p.event)]
            .receivedOffset + BASE_TAI_B;
          // print
          r.p := p;
          if setmapnode(r, false) then
            Buffer.FillRectTS(r.x - BASE_TAI_A, r.y - BASE_TAI_A,
              r.x + BASE_TAI_B, r.y + BASE_TAI_B, color32(p.getcolor));
        end;
      end;
    end;
  Buffer.font.Style := [];
  Buffer.font.Size := FONT_SIZE;
end;

procedure TForm1.GraphicDrawFocusedEvents_RotationIn(l: tlist;
  Buffer: tbitmap32);
var
  i, tmpy: integer;
  eventoffset: integer;
  r: rmapnode;
  p: pEvent;
begin
  // --------EVENTS--------
  Buffer.font.Size := FONT_SIZE_MIN;
  Buffer.font.Style := [];
  // source
  if paramGraph.DrawEvent then
    for i := paramGraph.startDrawEventId to Eventlist.count - 1 do
    begin
      p := Eventlist.items[i];
      // si on depasse la taille de l'image = exit
      eventoffset := timetocontrol(p.Time);
      if eventoffset > Imagemap.width then
        break;
      if eventoffset < MARGE_NAME then
        continue;
      // -----------
      if p.drawit = 0 then
        continue;
      // focus
      if paramGraph.unitRef then
        if not isEventOnFocus(p, btnFocusMode.down, globalFocusType) then
          continue;
      //
      if IsEventInFilter(p) then
      begin
        // DEST_EVENT
        if (p.destUnit = paramGraph.WatchedUnit) then
        begin
          // affichage
          r.x := eventoffset;
          tmpy := GetRotationoffset(p.spell);
          if (tmpy >= 0) then
            r.y := MARGE_HAUT + MARGE_CHAT + FOCUSED_AURA_BASEOFFSET + (tmpy)
              * FOCUSED_AURA_LINE
          else if p.spell.id = 0 then
            r.y := MARGE_HAUT + MARGE_CHAT +
              (eventValue[ord(p.event)].receivedLine)
              * FOCUSED_UNIT_SPACE_LINE +
              FOCUSED_UNIT_SPACE_LINE - GRAPH_OFFSET * eventValue[ord(p.event)]
              .receivedOffset + BASE_TAI_B
          else
            continue;

          if eventisaura in p.params then
            drawDose(Buffer, p.eventStat, r);
          // print
          r.p := p;
          setmapnode(r);
          Buffer.FillRectTS(r.x - BASE_TAI_A, r.y - BASE_TAI_A,
            r.x + BASE_TAI_B, r.y + BASE_TAI_B, color32(p.getcolor));
          continue;
        end;

        // SOURCE_EVENT
        if (p.sourceUnit = paramGraph.WatchedUnit) and not
          (eventisaura in p.params) then
        begin
          r.x := eventoffset;
          r.y := MARGE_HAUT + MARGE_CHAT + (eventValue[ord(p.event)].focusLine)
            * FOCUSED_UNIT_SPACE_LINE + eventValue[ord(p.event)]
            .focusOffset * GRAPH_OFFSET + 4;

          // print
          r.p := p;
          setmapnode(r);
          // plot
          Buffer.FillRectTS(r.x - BASE_TAI_A, r.y - BASE_TAI_A,
            r.x + BASE_TAI_B, r.y + BASE_TAI_B, color32(p.getcolor));
        end;
      end;
    end;
  Buffer.font.Style := [];
  Buffer.font.Size := FONT_SIZE;
end;

function TForm1.GetRotationoffset(spell: tspellinfo): integer;
begin
  if assigned(spell) then
    Result := spell.offsetaura
  else
    Result := -1;
end;

function TForm1.Getauraoffset(spell: tspellinfo; u: tUnitData): integer;
var
  i: integer;
begin
  Result := -1;
  if spell.offsetaura = -1 then
    exit;
  for i := spell.offsetaura to paramGraph.auralines.count - 1 do
  begin
    if SpellSingleAura(spell) then
    begin
      Result := tauraline(paramGraph.auralines.items[i]).offset;
      exit;
    end;
    if tauraline(paramGraph.auralines.items[i]).spell <> spell then
      exit
    else if tauraline(paramGraph.auralines.items[i]).u = u then
    begin
      Result := tauraline(paramGraph.auralines.items[i]).offset;
      exit;
    end;
  end;
end;

procedure TForm1.GraphicDrawFullUnitAura(Buffer: tbitmap32);
var
  i: integer;
  pu: tUnitData;
  j, x1, x2, y1, y2: integer;
  auraEvent: tauraevent;
  eventoffsetstart, eventoffsetend: integer;
begin
  // selected aura
  for i := 0 to drawedList.count - 1 do
  begin
    pu := drawedList.items[i];
    if assigned(pu.aura) then
    begin
      // x2:=0;
      for j := 0 to pu.aura.list.count - 1 do
      begin
        auraEvent := pu.aura.list.items[j];
        eventoffsetstart := timetocontrol(auraEvent.startTime);
        eventoffsetend := timetocontrol(auraEvent.endTime);

        if eventoffsetstart > Imagemap.width then
          continue;
        if auraEvent.endTime = -1 then
          continue; // test
        if eventoffsetstart < MARGE_NAME then
          eventoffsetstart := MARGE_NAME;
        if eventoffsetend > Imagemap.width then
          eventoffsetend := Imagemap.width;

        y1 := MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i) * UNIT_SPACE_LINE + 1;
        y2 := MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1)
          * UNIT_SPACE_LINE - GRAPH_OFFSET;
        x1 := eventoffsetstart;
        x2 := eventoffsetend;

        Buffer.FillRectTS(x1, y1, x2, y2, auraEvent.auracolor);
        Buffer.FrameRectS(x1, y1, x2, y2, 0); // auraEvent.auracolor

        // if x1 < x2 then x1:=x2;
        // if eventoffsetend> x2 then x2:=eventoffsetend;
        // if x1<x2 then
        // begin
        // Buffer.FillRectTS (x1,y1,x2,y2, FOCUSED_EVENT_AURASELECTED_COLOR[ord(pU.aura.isdebuff)]);
        // Buffer.FrameRectS(x1,y1,x2,y2, FOCUSED_EVENT_AURASELECTED_COLOR_BORDER[ord(pU.aura.isdebuff)]);
        // end;
      end;
    end;
  end;
end;

procedure TForm1.drawstatsWidget(Buffer: tbitmap32; pu: tUnitData;
  wposx, wposy: integer);
var
  tmpvalue: int64;
  x: integer;
begin
  tmpvalue := pu.stats.valueSeparate[2][ROLE_VALUEREF[pu.stats.iconrole]][1];
  x := round(divide((tmpvalue * STATSWIDGETSIZEX),
      globalnode[pu.stats.globalnoderef].globalstats
        [ROLE_VALUEREF[pu.stats.iconrole]].maxFiltered));
  Buffer.FillRectTS(wposx, wposy, wposx + x, wposy + STATSWIDGETSIZEY,
    ROLE_COLORREF[pu.stats.iconrole]);
  Buffer.lines(wposx + x, wposy, wposx + x, wposy + STATSWIDGETSIZEY,
    ROLE_COLORREF[pu.stats.iconrole]);
  Buffer.FrameRectS(wposx, wposy, wposx + STATSWIDGETSIZEX + 1,
    wposy + STATSWIDGETSIZEY, ROLE_COLORREF[pu.stats.iconrole]);
end;

procedure TForm1.drawauraWidget(Buffer: tbitmap32; pu: tUnitData;
  wposx, wposy: integer);
begin
  Buffer.FillRectTS(wposx, wposy, wposx + STATSWIDGETSIZEY,
    wposy + STATSWIDGETSIZEY, pu.auracolor);

  Buffer.FrameRectS(wposx, wposy, wposx + STATSWIDGETSIZEY,
    wposy + STATSWIDGETSIZEY, 0);
end;

Procedure TForm1.GraphicDrawFullUnitList(Buffer: tbitmap32);
var
  i: integer;
  tag: integer;
  pu: tUnitData;
  p: pEvent;
  eventoffset: integer;
  sizeSecond: double;
  r: rmapnode;
  maxvalue, poffset, alternatecolor: integer;
  uO: unitOpts;
  checkopti: boolean;
  strtmp: string;
begin
  sizeSecond := 100 / paramGraph.imagemap_zoom;
  maxvalue := GraphicDrawRaidInitHeader;
  if MARGE_RAID = 0 then
    alternatecolor := 1
  else
    alternatecolor := 0;
  // GRILLE:
  for i := 0 to drawedList.count - 1 do
  begin
    pu := drawedList.items[i];
    if (i + 1) mod 2 <> alternatecolor then
      Buffer.FillRectS(6, MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i)
          * UNIT_SPACE_LINE, Imagemap.width,
        MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1)
          * UNIT_SPACE_LINE - GRAPH_OFFSET, $FFBABABA);
    Buffer.FillRectS(0, MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1)
        * UNIT_SPACE_LINE - GRAPH_OFFSET, Imagemap.width,
      MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1) * UNIT_SPACE_LINE,
      $00CCBBBB);
    Buffer.FillRectS(0, MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i)
        * UNIT_SPACE_LINE, 5, MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1)
        * UNIT_SPACE_LINE - GRAPH_OFFSET,
      color32(ClasseStat[pu.Classe].color));

    if isunitonFocus(pu) then
    begin
      Buffer.font.Style := [fsBold];
      Buffer.FillRectTS(6, MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i)
          * UNIT_SPACE_LINE, Imagemap.width,
        MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1)
          * UNIT_SPACE_LINE - GRAPH_OFFSET,
        UNITFOCUSCOLORGFX[ord(btnFocusMode.down)]);
    end
    else
      Buffer.font.Style := [];

    // boss feedback
    if pu.Classe = 0 then
    begin
      uO := GetUnitOption(pu);
      if uoIsBoss in uO then
        Buffer.FrameRectS(6, MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i)
            * UNIT_SPACE_LINE, MARGE_NAME - 1,
          MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1)
            * UNIT_SPACE_LINE - GRAPH_OFFSET, $00AA7744)
      else if uoIsBossAffiliated in uO then
      begin
        Buffer.SetStipple([$FFAA7744, $FFAA7744, $00AA7744]);
        Buffer.FrameRectTSP(6, MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i)
            * UNIT_SPACE_LINE, MARGE_NAME - 1,
          MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1)
            * UNIT_SPACE_LINE - GRAPH_OFFSET);
      end
    end;

    strtmp := getunitname(pu, [getaff]);
    // means unitisplayer
    tag := 7;
    if pu.stats.iconrole > 0 then
    begin
      Buffer.draw(tag, MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1)
          * UNIT_SPACE_LINE - LIST_NAME_POS - 1, iconrole[pu.stats.iconrole]);
      tag := tag + iconrole[1].width;
      if GfxDrawStatsWidget.down then
      begin
        drawstatsWidget(Buffer, pu, tag,
          MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1)
            * UNIT_SPACE_LINE - LIST_NAME_POS + 2);
        tag := tag + STATSWIDGETSIZEX;
      end;
    end;
    // aurawatch legende
    if pu.auracolor > 0 then
    begin
      tag := tag + 3;
      drawauraWidget(Buffer, pu, tag,
        MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1)
          * UNIT_SPACE_LINE - LIST_NAME_POS + 2);
      tag := tag + STATSWIDGETSIZEY - 3;
    end;
    tag := tag + 5;
    Buffer.textout(tag, MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (i + 1)
        * UNIT_SPACE_LINE - LIST_NAME_POS, Rect(0, 0, MARGE_NAME - 5,
        Imagemap.height), strtmp);
  end;

  GraphicDrawSeconds(sizeSecond, Buffer);
  GraphicDrawMinutes(sizeSecond, Buffer);
  GraphicDrawChat(Buffer);
  GraphicDrawCombatBlock(sizeSecond, Buffer, true);
  // ----------------------------------------
  GraphicDrawSelection(Buffer);
  GraphicDrawTag(Buffer);
  if not LineOnBG.down then
    DrawLineArray(sizeSecond, Buffer);

  // --------EVENTS--------
  // source
  if paramGraph.DrawEvent then
    for i := paramGraph.startDrawEventId to Eventlist.count - 1 do
    begin
      p := Eventlist.items[i];
      // si on depasse la taille de l'image = exit
      eventoffset := timetocontrol(p.Time);
      if eventoffset > Imagemap.width then
        break;
      if eventoffset < MARGE_NAME then
        continue;

      // checking right for full list // poffset = 0 , no draw, poffset <0, draw for opponent only in Abs(offset)
      poffset := p.offset;
      if poffset = 0 then
        continue;
      if (poffset < 0) then
        if (eventSourceisFriend in p.params) then
          continue
        else
          poffset := -poffset;

      // focus
      if paramGraph.unitRef then
        if not isEventOnFocus(p, btnFocusMode.down, globalFocusType) then
          continue;

      // filter
      if IsEventInFilter(p) then
      begin
        // SOURCE_EVENT
        if not(eventIsself in p.params) then
        begin
          if assigned(p.sourceUnit) and (p.sourceUnit.idInDrawList >= 0) and not
            (eventisaura in p.params) then
          begin
            r.x := eventoffset;
            r.y := MARGE_HAUT + MARGE_CHAT + MARGE_RAID +
              (p.sourceUnit.idInDrawList) * UNIT_SPACE_LINE + poffset *
              GRAPH_OFFSET + 4;
            r.p := p;
            if setmapnode(r, true) then
              Buffer.FillRectTS(r.x - BASE_TAI_A, r.y - BASE_TAI_A,
                r.x + BASE_TAI_B, r.y + BASE_TAI_B, color32(p.getcolor));
          end;
        end;

        // DEST_EVENT ---- (dégat recus + aura )
        if assigned(p.destUnit) and (p.destUnit.idInDrawList >= 0) then
        begin
          // affichage
          r.x := eventoffset;
          if eventIsFriendlyGoal in p.params then
          begin
            r.y := MARGE_HAUT + MARGE_CHAT + MARGE_RAID +
              (p.destUnit.idInDrawList) * UNIT_SPACE_LINE + UNIT_SPACE_LINE -
              (GRAPH_OFFSET + BASE_TAI_B);
            checkopti := true;
          end
          else
          begin
            r.y := MARGE_HAUT + MARGE_CHAT + MARGE_RAID +
              (p.destUnit.idInDrawList) * UNIT_SPACE_LINE + UNIT_SPACE_LINE -
              BASE_TAI_B;
            checkopti := not(p.destUnit.uGUID.unittype = unitisplayer);
            // damages received by player are all showed
          end;
          r.p := p;

          if setmapnode(r, checkopti) then
            Buffer.FillRectTS(r.x - BASE_TAI_A, r.y - BASE_TAI_A,
              r.x + BASE_TAI_B, r.y + BASE_TAI_B, color32(p.getcolor));
        end;
      end;
    end;
  if LineOnBG.down then
    DrawLineArray(sizeSecond, Buffer);
  if MARGE_RAID > 0 then
    GraphicDrawRaid(maxvalue, sizeSecond, Buffer);
  GraphicDrawIgnoredEvent(Buffer);
  GraphicDrawReglette(Buffer);
  GraphicDrawFullUnitAura(Buffer);
  if GfxDrawMarks.down then
    GraphicDrawMarkIcon(Buffer);
  GraphicDrawQuickStats(Buffer);
  // caption:=format ('event: %d | stream: %d',[eventgraph, mousedetect.maxpos div sizeof(rmapnode)]);
end;

procedure TForm1.GraphicDrawMarkIcon(Buffer: tbitmap32);
var
  i, j, x, y: integer;
  pm: pmarkevent;
begin
  for i := low(markedlist) to high(markedlist) do
  begin
    if paramGraph.startDrawMarkId[i] >= 0 then
      for j := paramGraph.startDrawMarkId[i] to markedlist[i].count - 1 do
      begin
        pm := markedlist[i].items[j];
        if pm.u.idInDrawList >= 0 then
        begin
          x := timetocontrol(pm.startTime);
          if ((x - 8) > MARGE_NAME) then
            if (x < Imagemap.width) then
            begin
              y := MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (pm.u.idInDrawList)
                * UNIT_SPACE_LINE + ICO32_BASEOFFESET;
              Buffer.draw(x - 8, y, markedicon[i]);
            end
            else
              break;
        end;
      end;
  end;
end;

function TForm1.GetLineLOD(i: integer): boolean;
begin
  Result := false;
  if (paramGraph.imagemap_zoom > ZOOM_PALIER_4) then
    if i mod DOUBLE_HP_INTERVAL <> 0 then
      exit;
  if (paramGraph.imagemap_zoom > ZOOM_PALIER_3) then
    if i mod HP_INTERVAL <> 0 then
      exit;
  if (paramGraph.imagemap_zoom > ZOOM_PALIER_2) then
    if i mod DEMI_HP_INTERVAL <> 0 then
      exit;
  Result := true;
end;

procedure TForm1.DrawLineArray(sizeSecond: double; Buffer: tbitmap32);
var
  i, j: integer;
  pu: tUnitData;
  sizehpinterval: double;
  hp: integer;
  x: double;
  baseHpRow: integer;
begin
  // --------HPLINES----------------
  if paramGraph.DrawHpline then
  begin
    Buffer.pencolor := ARRAYLINE_COLOR[ord(paramGraph.linetype)];
    sizehpinterval := sizeSecond / HP_INTERVAL;
    baseHpRow := (paramGraph.startDrawTime - paramGraph.startHpTime)
      div BASE_HP_FEEDBACK_INTERVAL;
    for j := 0 to drawedList.count - 1 do
    begin
      pu := drawedList.items[j];
      if assigned(pu.instaline.eventarray) then
        for i := baseHpRow to high(pu.instaline.eventarray) do
        begin
          // level of distance
          if (i > baseHpRow) then
            if not GetLineLOD(i) then
              continue;
          x := MARGE_NAME + i * sizehpinterval - baseHpRow * sizehpinterval;
          if x > Imagemap.width then
            break;
          if i >= 0 then
          begin
            hp := pu.instaline.eventarray[i] div pu.instaline.gfxratio;
            if hp > UNIT_SPACE_LINE - 3 then
              hp := UNIT_SPACE_LINE - 3;
          end
          else
            hp := 0;

          if (not AuthUse52Log) and (paramGraph.linetype = lineHp) then
          begin
            if i = baseHpRow then
              Buffer.movetof(x,
                MARGE_HAUT + MARGE_CHAT + MARGE_RAID + j * UNIT_SPACE_LINE +
                  hp + 2);
            Buffer.linetofs(x + sizehpinterval + 1,
              MARGE_HAUT + MARGE_CHAT + MARGE_RAID + j * UNIT_SPACE_LINE +
                hp + 2);
          end
          else
          begin
            if i = baseHpRow then
              Buffer.movetof(x,
                MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (j + 1) *
                  (UNIT_SPACE_LINE) - hp - 1);
            Buffer.linetofs(x + sizehpinterval + 1,
              MARGE_HAUT + MARGE_CHAT + MARGE_RAID + (j + 1) *
                (UNIT_SPACE_LINE) - hp - 1);
          end;
        end;
    end;
  end;
end;

procedure TForm1.GraphicDrawSeconds(sizeSecond: double; Buffer: tbitmap32);
var
  i: integer;
  maxcol: integer;
  d: double;
begin
  // affichage des secondes
  if paramGraph.imagemap_zoom < 10 then
  begin
    Buffer.SetStipple([$FFAAAAAA, $FFAAAAAA, $FF888888]);
    maxcol := round((Imagemap.width - MARGE_NAME) / sizeSecond) + 1;
    d := ((100 - paramGraph.select.startTime mod 100) * sizeSecond) / 100;
    for i := 0 to maxcol do
      GraphicDrawTimeLine(i, sizeSecond, d, Buffer);
  end;
end;

procedure TForm1.GraphicDrawMinutes(sizeSecond: double; Buffer: tbitmap32);
var
  i: integer;
  d: double;
  maxcol: integer;
begin
  // affichage des minutes
  Buffer.SetStipple([$FFAAAAAA, $FFAAAAAA, $FF444444]);
  maxcol := round((Imagemap.width - MARGE_NAME) / sizeSecond) + 60;
  d := ((6000 - paramGraph.select.startTime mod 6000) * (60 * sizeSecond))
    / 6000;
  for i := 0 to maxcol do
    if (paramGraph.startDrawTime + (i * 100)) mod 6000 = 0 then
      GraphicDrawTimeLine(i, sizeSecond, d, Buffer);
end;

procedure TForm1.GraphicDrawTimeLine(i: integer; sizeSecond, d: double;
  Buffer: tbitmap32);
var
  x: double;
begin
  x := MARGE_NAME + i * sizeSecond - d;
  if x > MARGE_NAME then
  begin
    Buffer.movetof(x, MARGE_HAUT);
    Buffer.linetofsp(x, Imagemap.height);
  end;
end;

procedure TForm1.GraphicDrawSelection(Buffer: tbitmap32);
var
  xs: integer;
begin
  // selection
  Buffer.pencolor := $FFFF0000;
  if paramGraph.select.state <> sS_empty then
  begin
    xs := timetocontrol(paramGraph.select.startTime);
    if (xs >= MARGE_NAME) and (xs <= Imagemap.width) then
    begin
      Buffer.FillRectTS(xs, MARGE_HAUT, xs + 10, Imagemap.height, $55CCAA55);
      Buffer.movetof(xs, MARGE_HAUT);
      Buffer.linetofs(xs, Imagemap.height);
    end;
    if paramGraph.select.state = sS_valid then
    begin
      xs := round(timetocontrol(paramGraph.select.endTime));
      if (xs >= MARGE_NAME) and (xs <= Imagemap.width) then
      begin
        Buffer.FillRectTS(xs - 10, MARGE_HAUT, xs, Imagemap.height, $55CCAA55);
        Buffer.movetof(xs, MARGE_HAUT);
        Buffer.linetofs(xs, Imagemap.height);
      end;
    end
  end;
end;

procedure TForm1.GraphicDrawTag(Buffer: tbitmap32);
var
  xs: integer;
begin
  // reperes
  Buffer.pencolor := $FF00FFFF;
  if paramGraph.repere > 0 then
  begin
    xs := timetocontrol(paramGraph.repere);
    if (xs > MARGE_NAME) and (xs < Imagemap.width) then
    begin
      Buffer.movetof(xs, MARGE_HAUT);
      Buffer.linetofs(xs, Imagemap.height);
    end;
  end;
end;

procedure TForm1.GraphicDrawQuickStats(Buffer: tbitmap32);
var
  x1, x2, y1, y2: integer;
  t: tsize;
begin
  if not assigned(paramGraph.qstatsUnit) then
    exit;

  if paramGraph.FocusedMode > 0 then
  begin
    y1 := MARGE_HAUT + MARGE_CHAT + FOCUSED_UNIT_SPACE_LINE;
    y2 := MARGE_HAUT + MARGE_CHAT + FOCUSED_UNIT_SPACE_LINE * 2;
  end
  else
  begin
    if paramGraph.qstatsUnit.idInDrawList < 0 then
      exit;
    y1 := MARGE_HAUT + MARGE_CHAT + MARGE_RAID +
      (paramGraph.qstatsUnit.idInDrawList) * UNIT_SPACE_LINE;
    y2 := MARGE_HAUT + MARGE_CHAT + MARGE_RAID +
      (paramGraph.qstatsUnit.idInDrawList) * UNIT_SPACE_LINE + UNIT_SPACE_LINE;
  end;

  x1 := timetocontrol(paramGraph.qstatsStart);
  if x1 < MARGE_NAME then
    x1 := MARGE_NAME;

  x2 := timetocontrol(paramGraph.qstatsEnd) + 1;
  if x1 >= x2 then
    exit;

  Buffer.FillRectTS(x1, y1, x2, y2, $33FF5555);
  Buffer.pencolor := $FFFFFFFF;

  Buffer.movetof(x1, y1);
  Buffer.linetofs(x2, y1);
  Buffer.linetofs(x2, y2);
  Buffer.linetofs(x1, y2);
  if x1 > MARGE_NAME then
    Buffer.linetofs(x1, y1);

  Buffer.font.Style := [fsBold];
  t := Buffer.TextExtent(paramGraph.qstatsLabel);

  Buffer.FillRectTS(x2 + 4, y1, x2 + t.cx + 8, y1 + t.cy + 1, $AAFFFFFF);
  Buffer.FrameRectS(x2 + 4, y1, x2 + t.cx + 8, y1 + t.cy + 1, $FFFFFFFF);
  Buffer.font.Style := [fsBold];
  Buffer.textout(x2 + 6, y1 + 1, paramGraph.qstatsLabel);
end;

procedure TForm1.GraphicDrawReglette(Buffer: tbitmap32);
var
  xs, xs0, textx: integer;
  t: tsize;
const
  regletteTAI = 20;
begin
  // reglette:
  Buffer.pencolor := $FF0000FF;
  if paramGraph.reglette[0] > 0 then
  begin
    xs0 := timetocontrol(paramGraph.reglette[0]);
    if (xs0 > MARGE_NAME) and (xs0 < Imagemap.width) then
    begin
      Buffer.movetof(xs0, paramGraph.regletteY - regletteTAI);
      Buffer.linetofs(xs0, paramGraph.regletteY + regletteTAI);
    end;
    if paramGraph.reglette[1] > 0 then
    begin
      xs := timetocontrol(paramGraph.reglette[1]);
      if (xs > MARGE_NAME) and (xs < Imagemap.width) then
      begin
        Buffer.movetof(xs, paramGraph.regletteY - regletteTAI);
        Buffer.linetofs(xs, paramGraph.regletteY + regletteTAI);
      end;
      textx := xs0;
      if xs0 < MARGE_NAME then
        xs0 := MARGE_NAME;
      Buffer.FillRectTS(xs0 + 1, paramGraph.regletteY - regletteTAI, xs,
        paramGraph.regletteY + regletteTAI, $220000FF);
      Buffer.FillRectTS(xs0 + 1, paramGraph.regletteY + 5, xs,
        paramGraph.regletteY + regletteTAI, $AAFFFFFF);

      If textx < MARGE_NAME + 1 then
        textx := MARGE_NAME + 1;
      if textx > xs then
        textx := xs;

      if (textx > MARGE_NAME) then
      begin

        Buffer.font.Style := [fsBold];
        t := Buffer.TextExtent(paramGraph.reglettetime);
        Buffer.textout(xs0 + 5, paramGraph.regletteY + regletteTAI - t.cy,
          paramGraph.reglettetime);
      end;
    end;
  end;
end;

procedure TForm1.GraphicDrawIgnoredEvent(Buffer: tbitmap32);
var
  xs, i: integer;
  p: pEventIgnored;
  t: tsize;
begin
  // error feedback

  if EventIgnoredlist.count > 0 then
  begin
    Buffer.pencolor := $FFFF0000;
    Buffer.font.Style := [fsBold];
    for i := 0 to EventIgnoredlist.count - 1 do
    begin
      p := EventIgnoredlist.items[i];
      xs := timetocontrol(p.t);
      if (xs > MARGE_NAME) and (xs < Imagemap.width) then
      begin
        Buffer.FillRectTS(xs, 0, xs + 3, Imagemap.height, $AAFF0000);
        t := Buffer.TextExtent(TIMEERROR_LABEL + inttostr(p.count)
            + IGNORED_LABEL);
        Buffer.FillRectTS(xs + 5, 10, xs + 9 + t.cx, 10 + t.cy, $55FF0000);
        Buffer.FrameRectS(xs + 5, 10, xs + 9 + t.cx, 12 + t.cy, $55FF0000);
        Buffer.textout(xs + 7, 11,
          TIMEERROR_LABEL + inttostr(p.count) + IGNORED_LABEL);
      end;
    end;
    Buffer.font.Style := [];
  end;
end;

procedure TForm1.clearMouseDetect(doclearStream: boolean);
begin
  if doclearStream then
    mousedetect.stream_mapnode.clear;
  mousedetect.stream_mapnode.Position := 0;
  mousedetect.onfilter := (gfx_ResetFilter.enabled or gfx_ResetFocus.enabled);
  mousedetect.CheckPoint := nil;
  setlength(mousedetect.CheckPoint, (Imagemap.width div CHECKPOINT_SPACE) + 2);
  mousedetect.Yarray := nil;
  setlength(mousedetect.Yarray, Imagemap.height div GRAPH_OFFSET);

  if paramGraph.imagemap_zoom > ZOOM_PALIER_3 then
    mousedetect.threshold := 2
  else if paramGraph.imagemap_zoom > ZOOM_PALIER_2 then
    mousedetect.threshold := 1
  else
    mousedetect.threshold := 0;
end;

procedure TForm1.validateMouseDetect;
var
  i: integer;
begin
  if high(mousedetect.CheckPoint) < 1 then
    exit;
  for i := 1 to high(mousedetect.CheckPoint) do
    if mousedetect.CheckPoint[i] = 0 then
      mousedetect.CheckPoint[i] := mousedetect.CheckPoint[i - 1];
end;

function TForm1.setmapnode(r: rmapnode; check: boolean = false): boolean;
var
  tmppos: integer;
  Yindex: integer;
begin
  Result := r.p.event = event_UNIT_DIED;
  if not Result then
  begin
    Yindex := r.y div GRAPH_OFFSET;
    if ((Yindex) < length(mousedetect.Yarray)) then
    begin
      if not(mousedetect.onfilter) then
        if check and (r.x < mousedetect.Yarray[Yindex] + mousedetect.threshold)
          then
        begin
          Result := false;
          exit;
        end;
      Result := not(r.x = mousedetect.Yarray[Yindex]);
      mousedetect.Yarray[Yindex] := r.x;
    end;
  end;
  mousedetect.stream_mapnode.Write(r, SizeOf(r));
  mousedetect.maxpos := mousedetect.stream_mapnode.Position;
  if (mousedetect.maxpos > MAXPOSTHRESHOLD) and (mousedetect.threshold > 1) then
    mousedetect.onfilter := false;

  tmppos := r.x div CHECKPOINT_SPACE;
  if InRange(tmppos, low(mousedetect.CheckPoint), high(mousedetect.CheckPoint))
    then
  begin
    if mousedetect.CheckPoint[tmppos] = 0 then
      mousedetect.CheckPoint[tmppos] := mousedetect.stream_mapnode.Position;
    mousedetect.CheckPoint[tmppos + 1] := mousedetect.stream_mapnode.Position;
  end
end;

function TForm1.getmapnode(x, y: smallint): rResultEvent;
var
  r: rmapnode;
  marge1, marge2, pos1, pos2: integer;
begin
  FillChar(Result, SizeOf(Result), 0);
  if (mousedetect.stream_mapnode.Size = 0) or not InRange
    (Imagemap.width div CHECKPOINT_SPACE, low(mousedetect.CheckPoint),
    high(mousedetect.CheckPoint)) then
    exit;

  // on recupere les checkpoint pour optimiser la recherche:
  marge1 := (x div CHECKPOINT_SPACE) - 1;
  marge2 := (x div CHECKPOINT_SPACE) + 1;

  if marge1 < 0 then
    pos1 := 0
  else
    pos1 := mousedetect.CheckPoint[marge1];

  if marge2 > high(mousedetect.CheckPoint) then
    pos2 := mousedetect.maxpos
  else
    pos2 := mousedetect.CheckPoint[marge2];

  mousedetect.stream_mapnode.Position := pos1;
  repeat
    mousedetect.stream_mapnode.read(r, SizeOf(r));
    if x >= r.x - BASE_TAI_A then
      if x <= r.x + BASE_TAI_B then
        if y >= r.y - BASE_TAI_A then
          if y <= r.y + BASE_TAI_B then
          begin
            inc(Result.idActive);
            if Result.idActive > high(Result.r) then
              Result.idActive := high(Result.r);
            Result.r[Result.idActive] := r.p;
          end;
  until mousedetect.stream_mapnode.Position >= pos2;
end;

procedure TForm1.scrollListUp(step: integer);
var
  tmp: integer;
begin
  if paramGraph.FocusedMode > 0 then
  begin
    tmp := paramGraph.FocusedAuraOffset;
    paramGraph.FocusedAuraOffset := paramGraph.FocusedAuraOffset - step;
    if paramGraph.FocusedAuraOffset < 0 then
      paramGraph.FocusedAuraOffset := 0;
    if tmp <> paramGraph.FocusedAuraOffset then
      Imagemap.changed;
    GaugeBar2.Position := paramGraph.FocusedAuraOffset;
  end
  else
  begin
    tmp := round(paramGraph.yoffset);
    paramGraph.yoffset := paramGraph.yoffset + (step / 3);
    if paramGraph.yoffset > 0 then
      paramGraph.yoffset := 0;
    if tmp <> round(paramGraph.yoffset) then
      paramGraph.idleEvent_RefreshImage := true;
  end
end;

function TForm1.getmaxfocusedOffset: integer;
begin
  Result := 0;
  case paramGraph.FocusedMode of
    1:
      begin
        Result := paramGraph.Rotationlines.eventOut.count - 1;
        if paramGraph.FocusedAuraOffset > Result then
          paramGraph.FocusedAuraOffset := Result;
      end;
    2:
      begin
        Result := paramGraph.Rotationlines.eventIn.count - 1;
        if paramGraph.FocusedAuraOffset > Result then
          paramGraph.FocusedAuraOffset := Result;
      end;
    3 .. 4:
      begin
        Result := paramGraph.auralines.count;
        if paramGraph.FocusedAuraOffset > Result then
          paramGraph.FocusedAuraOffset := Result;
      end;
  end;
end;

procedure TForm1.scrollListDown(step: integer);
var
  tmp: integer;
begin
  if paramGraph.FocusedMode > 0 then
  begin
    tmp := paramGraph.FocusedAuraOffset;
    paramGraph.FocusedAuraOffset := paramGraph.FocusedAuraOffset + step;
    getmaxfocusedOffset;
    if tmp <> paramGraph.FocusedAuraOffset then
      Imagemap.changed;
    GaugeBar2.Position := paramGraph.FocusedAuraOffset;
  end
  else
  begin
    tmp := round(paramGraph.yoffset);
    paramGraph.yoffset := paramGraph.yoffset - (step / 3);
    if tmp <> round(paramGraph.yoffset) then
      paramGraph.idleEvent_RefreshImage := true; ;
  end
end;

procedure TForm1.GaugeBar2Change(Sender: TObject);
var
  tmp: integer;
begin
  if dontdisturb or paramGraph.gaugeNoDirectChange then
    exit;

  if paramGraph.FocusedMode > 0 then
  begin
    tmp := round(paramGraph.FocusedAuraOffset);
    paramGraph.FocusedAuraOffset := GaugeBar2.Position;
    getmaxfocusedOffset;
    if tmp <> paramGraph.FocusedAuraOffset then
      Imagemap.changed
  end
  else
  begin
    tmp := round(paramGraph.yoffset);
    paramGraph.yoffset := -GaugeBar2.Position;
    if tmp <> round(paramGraph.yoffset) then
      paramGraph.idleEvent_RefreshImage := true;
  end;

end;

procedure TForm1.scrollListHome;
begin
  if paramGraph.FocusedMode > 0 then
  begin
    paramGraph.FocusedAuraOffset := 0;
    Imagemap.changed;
  end
  else
  begin
    paramGraph.yoffset := 0;
    paramGraph.idleEvent_RefreshImage := true;
  end
end;

procedure TForm1.ImagemapMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint;

  var Handled: boolean);
begin
  if paramGraph.AuthScrollList then
    scrollListUp(MOUSEWHEELSCROLLRATIO)
  else if Shift = [] then
    scaleimage_onTime(MousePos.x, 0.95);
  releasecapture;
end;

procedure TForm1.ImagemapMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint;

  var Handled: boolean);
begin
  if paramGraph.AuthScrollList then
    scrollListDown(MOUSEWHEELSCROLLRATIO)
  else if Shift = [] then
    scaleimage_onTime(MousePos.x, 1.05);
  releasecapture;
end;

procedure TForm1.scaleimage_onTime(x: integer; s: double);
var
  zoomtmp: double;
begin
  if dontdisturb then
    exit;
  x := x - (Form1.left + Imagemap.left);
  // if (x< MARGE_NAME) then exit;
  zoomtmp := paramGraph.imagemap_zoom * s;
  if zoomtmp < IMAGEZOOM_MIN then
    zoomtmp := IMAGEZOOM_MIN;
  if zoomtmp > IMAGEZOOM_MAX then
    zoomtmp := IMAGEZOOM_MAX;
  if zoomtmp <> paramGraph.imagemap_zoom then
    scaleimagefix_onTime(x, zoomtmp);
end;

procedure TForm1.scaleimagefix_onTime(x: integer; zoomtmp: double);
var
  xbefore, xafter: integer;
begin
  xbefore := controltotime(x);
  paramGraph.imagemap_zoom := zoomtmp;
  xafter := controltotime(x);
  paramGraph.startDrawTime := ((paramGraph.startDrawTime - (xafter - xbefore))
      div 100) * 100;
  if paramGraph.startDrawTime < 0 then
    paramGraph.startDrawTime := 0;
  AssignDrawStartID(xbefore > xafter);
  Imagemap.changed;
  releasecapture;
end;

function TForm1.controltotime(x: integer): integer;
begin
  Result := ((paramGraph.startDrawTime + round
        (((x - MARGE_NAME) * paramGraph.imagemap_zoom))) div 100) * 100;
end;

function TForm1.timetocontrol(t: integer): integer;
begin
  Result := round((t - paramGraph.startDrawTime) / paramGraph.imagemap_zoom)
    + MARGE_NAME;
end;

procedure TForm1.assignHzBarPos;
begin
  paramGraph.hzNoDirectChange := true;
  GaugeBar3.Position := (paramGraph.startDrawTime - paramGraph.hzBarBase)
    div paramGraph.hzBarRatio;
  paramGraph.hzOldPos := GaugeBar3.Position * paramGraph.hzBarRatio +
    paramGraph.hzBarBase;
  paramGraph.hzNoDirectChange := false;
end;

function TForm1.GetFirstEventIdOnTime(startId, t: integer): integer;
var
  i: integer;
begin
  Result := 0;

  for i := startId to Eventlist.count - 1 do
    if pEvent(Eventlist.items[i]).Time >= t then
    begin
      Result := i;
      break;
    end;
  getmarkedIdOnTime(t);
end;

function TForm1.GetFirstEventIdOnReverseTime(startId, t: integer): integer;
var
  i, currentid: integer;
begin
  Result := 0;
  currentid := startId;
  for i := startId downto 0 do
  begin
    if pEvent(Eventlist.items[i]).Time < t then
    begin
      Result := currentid;
      getmarkedIdOnTime(t);
      break;
    end;
    currentid := i;
  end;
  // prevent eventual problem (should not happen)
  if Result = 0 then
    Result := GetFirstEventIdOnTime(0, t);
end;

function TForm1.getIdFromTime(startId, timepos: integer; b: boolean): integer;
var
  i, currentid: integer;
begin
  Result := startId;
  if b then
  begin
    for i := startId to Eventlist.count - 1 do
      if pEvent(Eventlist.items[i]).Time >= timepos then
      begin
        Result := i;
        break;
      end;
  end
  else
  begin
    currentid := startId;
    for i := startId downto 0 do
    begin
      if (pEvent(Eventlist.items[i]).Time < timepos) or (i = 0) then
      begin
        Result := currentid;
        break;
      end;
      currentid := i;
    end;
  end;

  getmarkedIdOnTime(timepos);
end;

procedure TForm1.getmarkedIdOnTime(t: integer);
var
  i, j: integer;
begin
  // getting markedid
  for i := 1 to high(markedlist) do
    for j := 0 to markedlist[i].count - 1 do
      if pmarkevent(markedlist[i].items[j]).startTime >= t then
      begin
        paramGraph.startDrawMarkId[i] := j;
        break;
      end;
end;

procedure TForm1.GetFirstDrawNode(refreshTree: boolean = true);
var
  Node: pvirtualnode;
  Data: ptreeGenericdata;
begin
  Node := ChatTree.getfirst;
  while assigned(Node) do
  begin
    Data := ChatTree.GetNodeData(Node);
    if pChatEvent(Data.BasicND.p).Time >= paramGraph.startDrawTime then
    begin
      paramGraph.chatNode := Node;
      if assigned(Node) and ChatTree.IsVisible[Node] then
      begin
        ChatTree.TopNode := Node;
        if refreshTree then
          ChatTree.repaint;
      end;
      exit;
    end;
    Node := Node.NextSibling;
  end;
end;

procedure TForm1.AssignDrawStartID(b: boolean);
begin
  paramGraph.startDrawEventId := getIdFromTime(paramGraph.startDrawEventId,
    paramGraph.startDrawTime, b);
  assignHzBarPos;
  GetFirstDrawNode;
end;

procedure TForm1.ImagemapMouseMove(Sender: TObject; Shift: TShiftState;
  x, y: integer; Layer: TCustomLayer);
var
  diffx, diffy, tmpoffset, i, usePowerType: integer;
begin
  if dontdisturb then
    exit;
  if not Imagemap.Focused then
  begin
    Imagemap.SetFocus;
    exit;
  end;
  getMouseTime(x);
  paramGraph.activeUnitGfx := nil;
  paramGraph.AuthScrollList := (x > 1) and (x < MARGE_NAME);

  if (Shift = [ssAlt, ssLeft]) and paramGraph.QstatMouse then
  begin
    realtimeQstat(false);
    exit;
  end
  else
    paramGraph.QstatMouse := false;

  if ssLeft in Shift then
  begin
    diffy := paramGraph.oldMouseOffsety - y;
    diffx := paramGraph.oldMouseOffsetx - x;

    case paramGraph.dragging of
      drag_x:
        begin
          diffx := round(diffx / (100 / paramGraph.imagemap_zoom));
          if diffx = 0 then
            exit;
          paramGraph.oldMouseOffsetx := x;
          paramGraph.startDrawTime := paramGraph.startDrawTime + diffx * 100;
          if paramGraph.startDrawTime <= 0 then
            paramGraph.startDrawTime := 0;
          AssignDrawStartID(diffx > 0);
          Imagemap.changed;
        end;
      drag_y:
        begin
          if diffy = 0 then
            exit;
          paramGraph.oldMouseOffsety := y;
          tmpoffset := round(paramGraph.yoffset);
          paramGraph.yoffset := (paramGraph.yoffset - (diffy / UNIT_SPACE_LINE)
            );
          // bornes
          if paramGraph.yoffset > 0 then
            paramGraph.yoffset := 0;
          if (diffy > 0) and (drawedList.count = 1) then
            paramGraph.yoffset := tmpoffset;
          // affichage:
          if round(paramGraph.yoffset) <> tmpoffset then
            paramGraph.idleEvent_RefreshImage := true;
        end;
      splitRaid_y:
        begin
          if diffy = 0 then
            exit;
          paramGraph.oldMouseOffsety := y;
          MARGE_RAID := MARGE_RAID - diffy;
          if MARGE_RAID < MARGE_RAID_DEFAULT then
            MARGE_RAID := MARGE_RAID_DEFAULT;
          if paramGraph.oldmargeRaid <> MARGE_RAID then
            paramGraph.idleEvent_RefreshImage := true;
        end;
      splitMarge_x:
        begin
          if diffx = 0 then
            exit;
          paramGraph.oldMouseOffsetx := x;
          MARGE_NAME := MARGE_NAME - diffx;
          Imagemap.changed;
        end;
    end;
  end
  else
  begin
    // time tooltip
    if (x > MARGE_NAME) then
    begin
      StatusBar1.Panels[2].Text := GetRealTimeFromTimeEvent(StartTimeStamp,
        paramGraph.mouseTime, paramGraph.select.startTime) + '  ';
      if (y < MARGE_HAUT + MARGE_CHAT) and (y > MARGE_HAUT) then
        getChatEvent(getControltime(x - (BASE_TAI_B)),
          getControltime(x + (BASE_TAI_A)))
      else
        interactGraph(x, y, false);

    end
    else
      StatusBar1.Panels[2].Text := '';
    Imagemap.Cursor := crDefault;
    if (x <= MARGE_NAME) and (x >= MARGE_NAME - 3) then
      Imagemap.Cursor := crHSplit;
    // unit si mode unitlist
    if paramGraph.FocusedMode = 0 then
    begin
      if (MARGE_RAID > 0) then
      begin
        if (y > MARGE_HAUT + MARGE_CHAT + MARGE_RAID - 1) and
          (y < MARGE_HAUT + MARGE_CHAT + MARGE_RAID + 1) then
          Imagemap.Cursor := crVSplit;
        if y < MARGE_HAUT + MARGE_CHAT + MARGE_RAID then
          for i := 5 to 8 do
            if paramGraph.lines[i].valid then
              StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text +
                RAID_ARRAYLINE_LABEL[i] + intToStrEx
                (getInstaValue(paramGraph.lines[i],
                  paramGraph.dpsInterval / 4));
      end;
      paramGraph.activeUnitGfx := getUnitOnY(y);
      if assigned(paramGraph.activeUnitGfx) then
      begin
        StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + getunitname
          (paramGraph.activeUnitGfx, [getaff, gettag, gethp]);
        StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + ' ';
        case paramGraph.linetype of
          lineHp:
            StatusBar1.Panels[2].Text := StatusBar1.Panels[2]
              .Text + ' ' + use52value(ARRAYLINEFEEDBACK_TYPESTRING[0],
              ARRAYLINEFEEDBACK_TYPESTRING52[0]) + getFormattedInstaValue
              (getInstaValue(paramGraph.activeUnitGfx.instaline, 1))
              + use52value('', format(' (%.0f%%)',
                [100 * divide(getInstaValue
                    (paramGraph.activeUnitGfx.instaline, 1),
                  paramGraph.activeUnitGfx.uhp)]));
          lineDps .. lineHeal:
            StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + ' ' +
              ARRAYLINEFEEDBACK_TYPESTRING[ord(paramGraph.linetype)]
              + intToStrEx(getInstaValue(paramGraph.activeUnitGfx.instaline,
                paramGraph.dpsInterval / 4));
        end
      end;
    end
    else
    begin
      case (y - (MARGE_HAUT + MARGE_CHAT)) div FOCUSED_UNIT_SPACE_LINE of
        1:
          StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + use52value
            ('Hp deficit: ', 'Current Hp: ') + getFormattedInstaValue
            (getInstaValue(paramGraph.lines[5], 1)) + use52value('',
            format(' (%.0f%%)',
              [100 * divide(getInstaValue(paramGraph.lines[5], 1),
                paramGraph.WatchedUnit.uhp)]));
        2:
          StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + 'dps in: ' +
            intToStrEx(getInstaValue(paramGraph.lines[3],
              paramGraph.dpsInterval / 4))
            + ' - hps in: ' + intToStrEx(getInstaValue(paramGraph.lines[4],
              paramGraph.dpsInterval / 4));
        3:
          StatusBar1.Panels[2].Text := StatusBar1.Panels[2]
            .Text + 'dps out: ' + intToStrEx
            (getInstaValue(paramGraph.lines[1], paramGraph.dpsInterval / 4));
        4:
          StatusBar1.Panels[2].Text := StatusBar1.Panels[2]
            .Text + 'hps out: ' + intToStrEx
            (getInstaValue(paramGraph.lines[2], paramGraph.dpsInterval / 4))
            + ' - eff.hps out: ' + intToStrEx
            (getInstaValue(paramGraph.lines[6], paramGraph.dpsInterval / 4));
        5:
          begin
            usePowerType := paramGraph.WatchedUnit.getcurrentPower
              (CURRENTPOWER);
            StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + use52value
              ('NeedLog5.2:', 'Pool[' + eINFOPOWER[usePowerType + 1].name)
              + '] :' + intToStrEx(paramGraph.WatchedUnit.mana div eINFOPOWER
                [usePowerType + 1].divider) + use52value(' - Need log5.2:',
              ' - current:') + getFormattedInstaValue
              (getInstaValue(paramGraph.lines[7],
                1) div eINFOPOWER[usePowerType + 1].divider);
          end;
      end;
    end;
  end;
end;

function TForm1.getInstaValue(line: linearray; adjust: single): integer;
var
  x: integer;
begin
  x := (paramGraph.mouseTime - paramGraph.startHpTime)
    div BASE_HP_FEEDBACK_INTERVAL;
  if InRange(x, low(line.eventarray), high(line.eventarray)) then
    Result := round(line.eventarray[x] / adjust)
  else
    Result := 0;
end;

function TForm1.getFormattedInstaValue(v: integer): string;
begin
  if v = DEATH_HP then
    Result := 'dead'
  else if v <> 0 then
    Result := use52value('-', '') + intToStrEx(v)
  else
    Result := '0';
end;

function TForm1.getUnitOnY(y: integer): tUnitData;
var
  tmpid: integer;
begin
  Result := nil;
  if y < MARGE_HAUT + MARGE_CHAT + MARGE_RAID then
    exit;
  tmpid := (y - (MARGE_HAUT + MARGE_CHAT + MARGE_RAID)) div UNIT_SPACE_LINE;
  if (tmpid >= 0) and (tmpid < drawedList.count) then
    Result := drawedList.items[tmpid];
end;

procedure TForm1.getMouseTime(x: integer);
begin
  paramGraph.mouseTime := getControltime(x);
end;

function TForm1.getControltime(x: integer): integer;
begin
  if x < MARGE_NAME then
    x := MARGE_NAME + 1;
  if x > Imagemap.width then
    x := Imagemap.width - 2;
  Result := paramGraph.startDrawTime + round
    (((x - MARGE_NAME) * paramGraph.imagemap_zoom));
end;

procedure TForm1.ImagemapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; x, y: integer; Layer: TCustomLayer);
var
  yaura, tmpvalue: integer;
begin
  if dontdisturb then
    exit;
  Imagemap.SetFocus;
  DoHint(Imagemap, '');
  getMouseTime(x);
  // quickstat
  if Shift = [ssAlt, ssLeft] then
  begin
    if paramGraph.FocusedMode > 0 then
      paramGraph.qstatsUnit := paramGraph.WatchedUnit
    else
      paramGraph.qstatsUnit := getUnitOnY(y);

    paramGraph.QstatMouse := assigned(paramGraph.qstatsUnit);
    paramGraph.qstatsFirstStart := paramGraph.mouseTime;
    paramGraph.qstatsStart := paramGraph.mouseTime;
    paramGraph.qstatsEnd := paramGraph.mouseTime;
    realtimeQstat(false);
  end
  // timeselection
  else if Shift = [ssCtrl, ssLeft] then
  begin
    case paramGraph.select.state of
      sS_empty, sS_valid:
        begin
          paramGraph.select.startTime := paramGraph.mouseTime;
          paramGraph.select.startId := GetFirstEventIdOnTime
            (paramGraph.startDrawEventId, paramGraph.select.startTime);
          paramGraph.select.state := sS_step1;
          assignHzBarPos;
          GetFirstDrawNode;
          paramGraph.forceStatUpdate := true;
        end;
      sS_step1:
        begin
          if paramGraph.mouseTime < paramGraph.select.startTime then
          begin
            paramGraph.select.endTime := paramGraph.select.startTime;
            paramGraph.select.startTime := paramGraph.mouseTime;
            paramGraph.select.startId := GetFirstEventIdOnTime
              (paramGraph.startDrawEventId, paramGraph.select.startTime);
            assignHzBarPos;
            GetFirstDrawNode;
            paramGraph.forceStatUpdate := true;
          end
          else
            paramGraph.select.endTime := paramGraph.mouseTime;
          paramGraph.select.state := sS_valid;
          completeRefresh([RefreshStats, PostponeUnitRefresh]);
          dynamicAddUnit(paramGraph.select.startId,
            paramGraph.select.startTime, paramGraph.select.endTime, false);
          generateUnitAura(paramGraph.aurawatch, paramGraph.aurawatchSource);
        end;
    end;
    settimetreefocus(nil);

    paramGraph.select.selectionLabel := CUSTOM_SELECTION_LABEL;
    paramGraph.select.isBlockSelection := false;
    Imagemap.changed;
    validTimeButton;
  end
  // tag
  else if Shift = [ssShift, ssLeft] then
  begin
    paramGraph.repere := paramGraph.mouseTime;
    replay.startTime := paramGraph.mouseTime;
    replay.startId := getReplayIdFromTime(eventlist, replay.startTime, -1);
    replay.Evaluateratio := true;
    ImageReplay.changed;
    Imagemap.changed;
  end
  // rulers
  else if Shift = [ssCtrl, ssAlt, ssLeft] then
  begin
    if paramGraph.reglette[0] = -1 then
    begin
      paramGraph.reglette[0] := paramGraph.mouseTime;
      paramGraph.regletteY := y;
    end
    else if paramGraph.reglette[1] = -1 then
    begin
      paramGraph.reglette[1] := paramGraph.mouseTime;
      if paramGraph.reglette[0] > paramGraph.reglette[1] then
      begin
        tmpvalue := paramGraph.reglette[1];
        paramGraph.reglette[1] := paramGraph.reglette[0];
        paramGraph.reglette[0] := tmpvalue;
      end;
    end
    else
      resetReglette;
    // calcul
    if (paramGraph.reglette[0] > 0) and (paramGraph.reglette[0] > 0) then
      paramGraph.reglettetime := GetFormattedLocalTime
        (abs(paramGraph.reglette[0] - paramGraph.reglette[1]), false)
    else
      paramGraph.reglettetime := '';
    Imagemap.changed;
  end
  else
  begin
    if y < MARGE_HAUT then
    begin
      if x < MARGE_NAME then
      begin
        if MARGE_HAUT = MARGE_HAUT_DEFAULTMIN then
          MARGE_HAUT := MARGE_HAUT_DEFAULTMAX
        else
          MARGE_HAUT := MARGE_HAUT_DEFAULTMIN;
        Imagemap.changed;
      end
      else
        interactCombatBlockGraph(paramGraph.mouseTime);
    end
    else
    begin
      // redim MARGE_NAME
      if (x <= MARGE_NAME) and (x >= MARGE_NAME - 3) then
      begin
        Imagemap.Cursor := crHSplit;
        paramGraph.dragging := splitMarge_x;
      end
      else
      begin
        // vue list
        if paramGraph.FocusedMode = 0 then
        begin
          if (MARGE_RAID > 0) and
            (y > MARGE_HAUT + MARGE_CHAT + MARGE_RAID - 3) and
            (y < MARGE_HAUT + MARGE_CHAT + MARGE_RAID + 3) then
          begin
            Imagemap.Cursor := crVSplit;
            paramGraph.dragging := splitRaid_y;
            paramGraph.oldmargeRaid := MARGE_RAID;
          end
          else
          begin
            if (x < MARGE_NAME) then
            begin
              if Shift = [ssLeft] then
              begin
                paramGraph.dragging := drag_y;
                paramGraph.oldyoffset := paramGraph.yoffset;
                Imagemap.Cursor := crSizeNS;
              end;
            end
            else
            begin
              paramGraph.dragging := drag_x;
              Imagemap.Cursor := crSizeWE;
            end;
          end
        end
        else
        // detailled  view
        begin
          if (x < MARGE_NAME) then
          begin
            yaura := (y - (MARGE_HAUT + MARGE_CHAT) +
                (paramGraph.FocusedAuraOffset * FOCUSED_AURA_LINE)
                - FOCUSED_AURA_BASEOFFSET + (FOCUSED_AURA_LINE div 2))
              div FOCUSED_AURA_LINE;
            case paramGraph.FocusedMode of
              1:
                if (yaura < paramGraph.Rotationlines.eventOut.count) and
                  (yaura >= 0) then
                  paramGraph.FocusedRotation := getfocusedRotation
                    (paramGraph.Rotationlines.eventOut, yaura);
              // tRotationline(paramGraph.Rotationlines.eventOut.items[yAura]).spellId;
              2:
                if (yaura < paramGraph.Rotationlines.eventIn.count) and
                  (yaura >= 0) then
                  paramGraph.FocusedRotation := getfocusedRotation
                    (paramGraph.Rotationlines.eventIn, yaura);
              3 .. 4:
                begin
                  if (yaura < paramGraph.auralines.count) and (yaura >= 0) then
                  begin
                    paramGraph.FocusedAura := tauraline
                      (paramGraph.auralines.items[yaura]).getspellId;
                    paramGraph.FocusedAuraUnit := tauraline
                      (paramGraph.auralines.items[yaura]).u;
                  end;
                end;
            end;
            Imagemap.changed;
          end
          else
          begin
            paramGraph.dragging := drag_x;
            Imagemap.Cursor := crSizeWE;
          end;
        end;
      end;
    end;
  end;
  paramGraph.oldMouseOffsety := y;
  paramGraph.oldMouseOffsetx := x;
end;

function TForm1.getfocusedRotation(l: tlist; yaura: integer): integer;
var
  i, j: integer;
  r: trotationline;
begin
  j := -1;
  Result := -1;
  for i := 0 to l.count - 1 do
  begin
    r := l.items[i];
    if r.infilter and (r.mobId = 0) then
    begin
      inc(j);
      if yaura = j then
        Result := r.spell.id;
    end;
  end;
end;

procedure TForm1.interactGraph(x, y: integer; clic: boolean);
var
  r: rResultEvent;
  p: pEvent;
  hinttmp: string;
  i: integer;
begin
  // vidage chat
  if assigned(paramGraph.activechatNode) then
  begin
    DoHint(Imagemap, '');
    paramGraph.activechatNode := nil;
  end;
  // eventHint
  r := getmapnode(x, y);
  if r.idActive = 0 then
    p := nil
  else
    p := r.r[r.idActive];
  if (p <> paramGraph.activeEvent) or (paramGraph.nbactiveEvent <> r.idActive)
    then
  begin
    hinttmp := '';
    if assigned(p) then
    begin
      for i := r.idActive downto 1 do
      begin
        hinttmp := hinttmp + fillHintData(StartTimeStamp,
          paramGraph.select.startTime, r.r[i], Eventlist);
        if i > 1 then
          hinttmp := hinttmp + '<bl size=5><bl size=10 dummy=false>';
      end;
      DoHint(Imagemap, hinttmp);
    end
    else
      DoHint(Imagemap, '');
  end;
  paramGraph.activeEvent := p;
  paramGraph.nbactiveEvent := r.idActive;
end;

procedure TForm1.getChatEvent(x1, x2: integer);
var
  Data: ptreeGenericdata;
  Node, tmpnode: pvirtualnode;
  strtmp: string;
begin
  strtmp := '';
  Node := paramGraph.chatNode;
  tmpnode := nil;
  while assigned(Node) do
  begin
    Data := ChatTree.GetNodeData(Node);
    if (pChatEvent(Data.BasicND.p).Time >= x1) then
    begin
      if (pChatEvent(Data.BasicND.p).Time <= x2) then
      begin
        strtmp := strtmp + GetRealTimeFromTimeEvent(StartTimeStamp,
          pChatEvent(Data.BasicND.p).Time, 0, toShowNormalnoMs) + ': ';
        strtmp := strtmp + stringreplace(pChatEvent(Data.BasicND.p).s, '|', '',
          [rfReplaceall]) + HTML_BR;
        tmpnode := Node;
      end
      else
        break;
    end;
    Node := Node.NextSibling;
  end;
  if not assigned(tmpnode) or (paramGraph.activechatNode <> tmpnode) then
    DoHint(Imagemap, fillHintChat(strtmp));
  paramGraph.activechatNode := tmpnode;
  // vidage registered events
  paramGraph.activeEvent := nil;
  paramGraph.nbactiveEvent := 0;
end;

procedure TForm1.DoHint(control: tcontrol; hintstr: string);
begin
  Application.hidehint;
  HintTimer.enabled := false;
  if not Application.ShowHint then
    exit;
  control.Hint := hintstr;
  if hintstr <> '' then
    HintTimer.enabled := true;
end;

procedure TForm1.HintTimerTimer(Sender: TObject);
begin
  Application.activatehint(mouse.cursorpos);
  HintTimer.enabled := false;
end;

procedure TForm1.ImagemapMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; x, y: integer; Layer: TCustomLayer);
begin
  if dontdisturb then
    exit;
  Imagemap.Cursor := crDefault;
  screen.Cursor := crDefault;
  getMouseTime(x);

  if (paramGraph.dragging = drag_y) then
    if paramGraph.oldyoffset <> paramGraph.yoffset then
      paramGraph.idleEvent_RefreshImage := true
    else
    begin
      paramGraph.activeUnitGfx := getUnitOnY(y);
      if assigned(paramGraph.activeUnitGfx) then
      begin
        if (paramGraph.WatchedUnit <> paramGraph.activeUnitGfx) or
          (paramGraph.WatchedUnitUseSum) then
        begin
          paramGraph.WatchedUnit := paramGraph.activeUnitGfx;
          paramGraph.WatchedUnitUseSum := false;
          completeRefresh([RefreshUnitStats]);
        end;
      end;
    end;

  if (paramGraph.dragging = splitRaid_y) then
    if paramGraph.oldmargeRaid <> MARGE_RAID then
      paramGraph.idleEvent_RefreshImage := true;

  paramGraph.dragging := drag_0;

  if paramGraph.QstatMouse then
  begin
    realtimeQstat(true);
    paramGraph.QstatMouse := false;
  end;
end;

procedure TForm1.realtimeQstat(finalyze: boolean);
begin
  if (paramGraph.mouseTime > paramGraph.qstatsFirstStart) then
  begin
    paramGraph.qstatsEnd := paramGraph.mouseTime;
    paramGraph.qstatsStart := paramGraph.qstatsFirstStart;
  end
  else
  begin
    paramGraph.qstatsStart := paramGraph.mouseTime;
    paramGraph.qstatsEnd := paramGraph.qstatsFirstStart;
  end;
  if finalyze and (paramGraph.qstatsEnd = paramGraph.qstatsStart) then
    paramGraph.qstatsUnit := nil;
  if assigned(paramGraph.qstatsUnit) then
  begin
    paramGraph.qstats := buildQuickStats(Eventlist, paramGraph.qstatsUnit,
      paramGraph.startDrawEventId, paramGraph.qstatsStart,
      paramGraph.qstatsEnd);
    paramGraph.qstatsLabel := GetFormattedLocalTime
      (paramGraph.qstatsEnd - paramGraph.qstatsStart, false)
      + ' >> D=' + intToStrEx(paramGraph.qstats.incDamage) + ' H=' + intToStrEx
      (paramGraph.qstats.incHeal);
  end;
  Imagemap.changed;
end;

procedure TForm1.ViewEventInList1Click(Sender: TObject);
var
  filter: eventFilter;
begin
  if assigned(paramGraph.MenuActiveEvent) then
  begin
    filter.option := [optAroundNode];
    filter.p := paramGraph.MenuActiveEvent;
    fillTreeEvent(filter);
    ListViewTab.show;
  end;
end;

procedure TForm1.LoadLog1Click(Sender: TObject);
begin
  logpath := loadLog(logpath);
end;

function TForm1.loadLog(initialdir: string): string;
begin
  OpenDialog1.CleanupInstance;
  OpenDialog1.DefaultExt := 'txt';
  OpenDialog1.filter := 'Logs (*.txt, *.wcr)|*.txt;*.wcr|All files (*.*)|*.*';
  Result := initialdir;
  OpenDialog1.initialdir := initialdir;
  if OpenDialog1.Execute then
  begin
    Application.ProcessMessages;
    Result := ExtractFilePath(OpenDialog1.filename);
    launchParsing(OpenDialog1.filename, EMPTYBOSSSTRING, false);
  end;
end;

procedure TForm1.MyTreeMouseMove(Sender: TObject; Shift: TShiftState;
  x, y: integer);
var
  Node: pvirtualnode;
  Data: ptreedata;
begin
  Node := MyTree.GetNodeAt(x, y);
  if assigned(Node) then
  begin
    Data := MyTree.GetNodeData(Node);
    if paramGraph.activeEvent = Data.BasicND.p then
      exit
    else
    begin
      DoHint(MyTree, fillHintData(StartTimeStamp, paramGraph.select.startTime,
          Data.BasicND.p, Eventlist));
      paramGraph.activeEvent := Data.BasicND.p;
    end;
  end
  else
  begin
    paramGraph.activeEvent := nil;
    DoHint(MyTree, '');
  end;
end;

procedure TForm1.unitTreeInitData;
var
  i: integer;
  pMN: pmasternode;
begin
  for i := 1 to 4 do
  begin
    new(pMN);
    pMN.gType := i;
    masterNode[i] := unitTree.AddChild(nil, TNodeGenericData.create(pMN));
  end;
end;

procedure TForm1.HidePlayerNotInRaid;
  procedure assignUnitStatus(n: pvirtualnode; b: boolean; cs: TCheckState);
  begin
    unitTree.ValidateChildren(n, false);
    unitTree.IsVisible[n] := b;
    unitTree.IsVisible[n.firstchild] := b;
    n.CheckState := cs;
    n.firstchild.CheckState := cs;
  end;

var
  Node: pvirtualnode;
  Data: ptreeGenericdata;
begin

  unitTree.BeginUpdate;
  if assigned(masterNode[1]) then
  begin
    Node := masterNode[1].firstchild;
    while assigned(Node) do
    begin
      Data := unitTree.GetNodeData(Node);
      if GfxNoExternal.checked then
      begin
        if upWasInRaid in tunitinfo(Data.BasicND.p).params then
          assignUnitStatus(Node, true, csCheckedPressed)
        else
          assignUnitStatus(Node, false, csuncheckedNormal);
      end
      else
        assignUnitStatus(Node, true, csCheckedPressed);
      Node := Node.NextSibling;
    end
  end;
  unitTree.endupdate;
end;

procedure TForm1.unitTreeFreeNode(Sender: TBaseVirtualTree; Node: pvirtualnode);
var
  Data: ptreeGenericdata;
begin
  Data := unitTree.GetNodeData(Node);
  if unitTree.GetNodeLevel(Node) = 0 then
    dispose(pmasternode(Data.BasicND.p));
  Data.BasicND.destroy;
end;

function TForm1.getrolefromunitInfo(u: tunitinfo;
  forcenoroleindex: boolean = true): integer;
begin
  Result := 0;
  if assigned(u) then
    if u.list.count > 0 then
      Result := tUnitData(u.list[0]).stats.iconrole;
  if forcenoroleindex then
    if Result = 0 then
      Result := 4;
end;

function TForm1.getDpsvaluefromunitInfo(u: tunitinfo): integer;
var
  ul: tUnitData;
begin
  Result := 0;
  if assigned(u) then
    if u.list.count > 0 then
    begin
      ul := tUnitData(u.list[0]);
      Result := round
        (divide(ul.stats.valueSeparate[2][ROLE_VALUEREF[ul.stats.iconrole]]
            [1], (ul.stats.timeperiod / 100)));
    end;
end;

function TForm1.getclassfromunitInfo(u: tunitinfo): integer;
begin
  Result := 0;
  if assigned(u) then
    if u.list.count > 0 then
      Result := tUnitData(u.list[0]).Classe;
end;

procedure TForm1.unitTreeCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: pvirtualnode; Column: TColumnIndex;

  var Result: integer);
var
  data1, data2: ptreeGenericdata;
  lvl1, lvl2, txtcompare: integer;
begin
  data1 := unitTree.GetNodeData(Node1);
  data2 := unitTree.GetNodeData(Node2);
  lvl1 := unitTree.GetNodeLevel(Node1);
  lvl2 := unitTree.GetNodeLevel(Node2);
  if (Node1.Parent = masterNode[1]) and (Node2.Parent = masterNode[1]) and
    (lvl1 = 1) and (lvl2 = 1) then
  begin
    txtcompare := comparetext(tunitinfo(data1.BasicND.p).name,
      tunitinfo(data2.BasicND.p).name);
    case prefs.sortunitmode of
      1:
        Result := (getclassfromunitInfo(data1.BasicND.p) - getclassfromunitInfo
            (data2.BasicND.p)) * 1000000 + txtcompare;
      2:
        Result := (getrolefromunitInfo(data1.BasicND.p) - getrolefromunitInfo
            (data2.BasicND.p)) * 1000000 +
          (getDpsvaluefromunitInfo(data2.BasicND.p) - getDpsvaluefromunitInfo
            (data1.BasicND.p));
    else
      Result := txtcompare;
    end;
  end
  else
  begin
    if (lvl1 = 1) and (lvl2 = 1) then
      Result := comparetext(tunitinfo(data1.BasicND.p).name,
        tunitinfo(data2.BasicND.p).name)
    else if (lvl1 = 2) and (lvl2 = 2) then
      Result := tUnitData(data1.BasicND.p).uGUID.GUID - tUnitData
        (data2.BasicND.p).uGUID.GUID
    else
      Result := 0;
  end;
end;

procedure TForm1.unitTreeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: pvirtualnode;

  var InitialStates: TVirtualNodeInitStates);
var
  Data: ptreeGenericdata;
begin
  Data := unitTree.GetNodeData(Node);
  case unitTree.GetNodeLevel(Node) of
    0:
      Node.checktype := ctNone;
    1:
      if tunitinfo(Data.BasicND.p).unittype = unitisplayer then
      begin
        Node.checktype := ctTriStateCheckBox;
        Node.CheckState := csCheckedPressed;
      end;
    2:
      if tUnitData(Data.BasicND.p).uGUID.unittype = unitisplayer then
      begin
        Node.checktype := ctTriStateCheckBox;
        Node.CheckState := csCheckedPressed;
      end
      else
        Node.checktype := ctTriStateCheckBox;
  end
end;

procedure TForm1.ImagemapResize(Sender: TObject);
begin
  if not paramGraph.noredim then
    paramGraph.idleEvent_RefreshImage := true;
  htmlstatsMenu.height := htmlstatsMenu.FullDisplaySize(htmlstatsMenu.width).cy;
end;

procedure TForm1.UnitTreePopupPopup(Sender: TObject);
var
  Data: ptreeGenericdata;
begin
  RegisteredUnits1.Visible := length(npcArray) = 0;
  RegisteredSpells1.Visible := spellArray.count = 0;

  EditUnitParams1.Visible := false;
  if assigned(paramGraph.unittreenode) then
  begin
    Data := unitTree.GetNodeData(paramGraph.unittreenode);
    case unitTree.GetNodeLevel(paramGraph.unittreenode) of
      0:
        begin
          Unit1.Caption := UNIT_HEADER_LABEL + bracket_string(UNIT_IS_NIL_NAME);
          ToggleFocus1.Caption := 'Toggle Focus' + bracket_string
            (UNIT_IS_NIL_NAME);
          paramGraph.unittreenode := nil;
        end;
      1:
        begin
          Unit1.Caption := UNIT_HEADER_LABEL + bracket_string
            (tunitinfo(Data.BasicND.p).name);
          ToggleFocus1.Caption := 'Toggle Focus' + bracket_string
            (tunitinfo(Data.BasicND.p).name);
          EditUnitParams1.Visible := tunitinfo(Data.BasicND.p)
            .unittype = unitIsNpc;
          EditUnitParams1.Caption := 'Edit Params for: ' + tunitinfo
            (Data.BasicND.p).name;
          CheckOnWeb1.Visible :=
            (tunitinfo(Data.BasicND.p).unittype = unitIsNpc) or
            (tunitinfo(Data.BasicND.p).unittype = unitisplayer);
        end;
      2:
        begin
          Unit1.Caption := UNIT_HEADER_LABEL + bracket_string
            (getunitname(tUnitData(Data.BasicND.p), []));
          ToggleFocus1.Caption := 'Toggle Focus' + bracket_string
            (getunitname(tUnitData(Data.BasicND.p), []));
        end;

    end;
  end
  else
    Unit1.Caption := UNIT_HEADER_LABEL + bracket_string(UNIT_IS_NIL_NAME);
end;

procedure TForm1.FormKeyDown(Sender: TObject;

  var Key: Word; Shift: TShiftState);
begin
  if authKeyDown then
    // caption:=inttostr(key);
    case Key of
      VK_BACK:
        previousCombatBlockGraph;
      VK_ESCAPE:
        begin
          if bwhilebatching then
            bwhilebatching := false
          else if bWhileparsing then
            logerror := logInterrupted
          else
          begin
            if resetCurrentFilter then
            begin
            end
            else if resetUnitRef then
              completeRefresh([RefreshStats, RefreshUnitStats, RefreshMap])
            else if resetTimePeriod then
              Imagemap.changed
            else if resetRepere then
              Imagemap.changed;
          end;
        end;
      VK_SPACE:
        if Shift = [ssShift] then
          previousCombatBlockGraph
        else
          nextCombatBlockGraph;
      VK_PRIOR:
        if Shift = [ssShift] then
          scrollListUp(15)
        else
          scrollListUp(6);
      VK_NEXT:
        if Shift = [ssShift] then
          scrollListDown(15)
        else
          scrollListDown(6);
      VK_HOME:
        scrollListHome;
      65:
        begin // a:events
          HideEvents.down := not HideEvents.down;
          HideEventsClick(nil);
        end;
      66:
        scaleDpsInterval(4);
      67:
        begin
          case paramGraph.linetype of
            lineHp:
              assignLineType(lineDps);
            lineDps:
              assignLineType(lineHeal);
            lineHeal:
              assignLineType(lineHp);
          end;
          paramGraph.idleEvent_RefreshImage := true;
        end;
      69: // e
        begin
          inc(CURRENTDATATYPE);
          if CURRENTDATATYPE > 4 then
            CURRENTDATATYPE := 2;
          Caption := format('%s - DATAFEED: %s', [PROG_VERS, eDATAFEED[CURRENTDATATYPE]]);
          completeRefresh([RefreshStats, RefreshMap]);
        end;
      70: // f
        begin
          inc(CURRENTPOWER);
          if CURRENTPOWER > high(ClasseStat[0].dfeed) then
            CURRENTPOWER := 0;
          completeRefresh([RefreshStats, RefreshMap]);
        end;
      72:
        begin // h:hpline
          paramGraph.DrawHpline := not paramGraph.DrawHpline;
          Imagemap.changed;
        end;
      // replay;
      74:
        replayplay(-1, true); // j
      75:
        replayplay(1, true); // k
      77:
        if butreplay_circle.enabled then
          butreplay_circleClick(nil);
      86:
        scaleDpsInterval(-4);
    end;
end;

procedure TForm1.scaleDpsInterval(s: integer);
var
  tmp: integer;
begin
  tmp := paramGraph.dpsInterval;
  paramGraph.dpsInterval := paramGraph.dpsInterval + s;
  if paramGraph.dpsInterval < MIN_INSTADPSINTERVAL then
    paramGraph.dpsInterval := MIN_INSTADPSINTERVAL;
  if paramGraph.dpsInterval > MAX_INSTADPSINTERVAL then
    paramGraph.dpsInterval := MAX_INSTADPSINTERVAL;
  if (tmp <> paramGraph.dpsInterval) then
    paramGraph.idleEvent_RefreshImage := true;
  StatusBar1.Panels[2].Text := 'Insta Dps/Hps interval: ' + inttostr
    (paramGraph.dpsInterval div (100 div BASE_HP_FEEDBACK_INTERVAL)) + 's';
end;

procedure TForm1.interactCombatBlockGraph(t: integer);
var
  i: integer;
  cb: tcombatBlock;
begin
  for i := 0 to CombatBlockList.count - 1 do
  begin
    cb := CombatBlockList.items[i];
    if (t >= cb.timestart) and (t <= cb.timestop) then
    begin
      settimetreefocus(cb.pnode);
      directBlockSelect(cb.legende, cb.eventstart, cb.timestart, cb.timestop,
        false);
      break;
    end;
  end;
end;

function TForm1.nextCombatBlockGraph: boolean;
var
  i, t: integer;
  cb: tcombatBlock;
begin
  Result := false;
  case paramGraph.select.state of
    sS_step1:
      t := paramGraph.select.startTime;
    sS_valid:
      t := paramGraph.select.endTime;
  else
    t := paramGraph.startDrawTime;
  end;

  for i := 0 to CombatBlockList.count - 1 do
  begin
    cb := CombatBlockList.items[i];
    if (cb.timestart >= t) then
    begin
      settimetreefocus(cb.pnode);
      directBlockSelect(cb.legende, cb.eventstart, cb.timestart, cb.timestop,
        true);
      Result := true;
      break;
    end;
  end;
end;

procedure TForm1.previousCombatBlockGraph;
var
  i, t: integer;
  cb: tcombatBlock;
begin
  case paramGraph.select.state of
    sS_step1, sS_valid:
      t := paramGraph.select.startTime
    else
      t := controltotime(Imagemap.width);
  end;

  for i := CombatBlockList.count - 1 downto 0 do
  begin
    cb := CombatBlockList.items[i];
    if (cb.timestop <= t) then
    begin
      settimetreefocus(cb.pnode);
      directBlockSelect(cb.legende, cb.eventstart, cb.timestart, cb.timestop,
        true);
      break;
    end;
  end;
end;

function TForm1.getBossFightById(bossId: string): boolean;
var
  i: integer;
  cb: tcombatBlock;
begin
  Result := false;
  for i := 0 to CombatBlockList.count - 1 do
  begin
    cb := CombatBlockList.items[i];
    if (bossId = EMPTYBOSSSTRING) or (cb.txtBOSSID = bossId) then
    begin
      settimetreefocus(cb.pnode);
      directBlockSelect(cb.legende, cb.eventstart, cb.timestart, cb.timestop,
        true);
      Result := true;
      break;
    end;
  end;
  if not Result then
    Result := nextCombatBlockGraph;
end;

procedure TForm1.getBossFight(Node: pvirtualnode);
var
  Data: pTimeDatanode;
begin
  settimetreefocus(Node);
  Data := TimeTree.GetNodeData(Node);
  directBlockSelect(getunitname(Data.bossId, []), Data.starteventId,
    Data.startCombattime, Data.lastCombattime, true);
end;

procedure TForm1.directBlockSelect(blocklabel: string;
  startId, startTime, endTime: integer; pos: boolean);
var
  tmppos: integer;
begin
  paramGraph.select.selectionLabel := blocklabel;
  paramGraph.select.isBlockSelection := true;
  paramGraph.select.startTime := startTime;
  paramGraph.select.endTime := endTime;
  paramGraph.select.startId := startId;
  paramGraph.select.state := sS_valid;
  completeRefresh([RefreshStats, PostponeUnitRefresh]);
  if pos then
  begin
    tmppos := ((controltotime(Imagemap.width) - controltotime(MARGE_NAME)) -
        (endTime - startTime)) div 2;
    if tmppos < 0 then
      tmppos := 0;
    SetGraphOnReverseTime(startId, paramGraph.select.startTime - tmppos)
  end
  else
    ViewPortRefresh;
  if ListViewTab.Visible then
    ListBut_UseSelectionClick(nil);
  validTimeButton;
end;

procedure TForm1.SetGraphOnEvent(p: pEvent; addtag: boolean;
  delay: integer = 100);
begin
  if assigned(p) then
  begin
    if addtag then
      paramGraph.repere := p.Time;
    SetGraphOnTime(p.Time - delay);
  end;
end;

procedure TForm1.SetGraphOnTime(t: integer);
begin
  paramGraph.startDrawTime := t div 100 * 100;
  if paramGraph.startDrawTime < 0 then
    paramGraph.startDrawTime := 0;
  paramGraph.startDrawEventId := GetFirstEventIdOnTime(0,
    paramGraph.startDrawTime);
  assignHzBarPos;
  GetFirstDrawNode;
  ViewPortRefresh;
end;

procedure TForm1.SetGraphOnReverseTime(startId, t: integer);
begin
  paramGraph.startDrawTime := t div 100 * 100;
  if paramGraph.startDrawTime < 0 then
    paramGraph.startDrawTime := 0;
  paramGraph.startDrawEventId := GetFirstEventIdOnReverseTime(startId,
    paramGraph.startDrawTime);
  assignHzBarPos;
  GetFirstDrawNode;
  ViewPortRefresh;
end;

procedure TForm1.ViewPortRefresh;
begin
  if dontdisturb then
    exit;
  if paramGraph.select.state = sS_empty then
    dynamicAddUnit(paramGraph.startDrawEventId, controltotime(MARGE_NAME),
      controltotime(Imagemap.width), false)
  else
    dynamicAddUnit(paramGraph.select.startId, paramGraph.select.startTime,
      paramGraph.select.endTime, false);
  generateUnitAura(paramGraph.aurawatch, paramGraph.aurawatchSource);
  Imagemap.changed;
end;

procedure TForm1.evaluateWatchedUnit;
var
  u: tunitinfo;
  ul: tUnitData;
  i, j: integer;
  unitfound: boolean;
  Node: pvirtualnode;
begin
  // assigning the first watchedUnit
  if not assigned(paramGraph.WatchedUnit) then
  begin
    Node := masterNode[1];
    while assigned(Node) do
    begin
      if unitTree.GetNodeLevel(Node) = 2 then
      begin
        if IsNodeChecked(Node) then
        begin
          paramGraph.WatchedUnit := ptreeGenericdata(unitTree.GetNodeData(Node))
            .BasicND.p;
          paramGraph.WatchedUnitUseSum := false;
          break;
        end;
      end;
      Node := unitTree.GetNext(Node);
    end;
  end;
  // ---------------------------------
  unitfound := false;
  paramGraph.noredim := true;
  if assigned(paramGraph.WatchedUnit) then
  begin
    // recherche dynamique de l'unité en focus
    u := getunitinfo(paramGraph.WatchedUnit);
    if pvirtualnode(paramGraph.WatchedUnit.pnode)
      .CheckState < csCheckedNormal then
    begin
      for i := 0 to u.list.count - 1 do
      begin
        ul := u.list.items[i];
        if pvirtualnode(ul.pnode).CheckState >= csCheckedNormal then
        begin
          paramGraph.WatchedUnit := ul;
          paramGraph.WatchedUnitUseSum := false;
          unitfound := true;
          break;
        end;
      end;
    end
    else
      unitfound := true;
    // si on a rien trouvé on switch sur boss
    if (not unitfound) and (uoIsBoss in u.constantParams.option1) then
    begin
      for j := 0 to unitList.count - 1 do
      begin
        u := unitList.items[j];
        if uoIsBoss in u.constantParams.option1 then
          for i := 0 to u.list.count - 1 do
          begin
            ul := u.list.items[i];
            if pvirtualnode(ul.pnode).CheckState >= csCheckedNormal then
            begin
              paramGraph.WatchedUnit := ul;
              paramGraph.WatchedUnitUseSum := false;
              break;
            end;
          end;
      end;
    end;
  end;
{$IFDEF DEBUG}
  if DRAWDEBUGREFRESH then
    MemoStat.lines.add(format('U_EVAL: %d', [random(100)]));
{$ENDIF DEBUG}
end;

procedure TForm1.completeRefresh(rOpts: sRefreshOpts);
begin
  // call: completeRefresh([RefreshUnit,RefreshStats,RefreshUnitStats,RefreshMap]);
  if dontdisturb then
    exit;
  paramGraph.postponeStatUpdate := PostponeUnitRefresh in rOpts;
  if RefreshUnit in rOpts then
    evaluateWatchedUnit;
  if (RefreshStats in rOpts) or paramGraph.forceStatUpdate then
    BuildStat(gfx_ResetFilter.enabled and Stats_UseFilter.down,
      paramGraph.unitRef and Stat_UseUnitRef.down, btnFocusMode.down,
      Stat_absorb.down, Stat_MergeAbsorb.down, Stat_NoFriendDamage.down,
      Stat_assignAff.down, Stat_NoEnemyHeal.down, Stat_OnlyCombat.down);
  if RefreshUnitStats in rOpts then
    buildUnitStats;
  if RefreshMap in rOpts then
    ImagemapFullRefresh(true);
  if RefreshMapOnDetail in rOpts then
    if paramGraph.FocusedMode > 0 then
      ImagemapFullRefresh(true);
  ImageReplay.changed;
end;

procedure TForm1.ApplicationEvents1Idle(Sender: TObject;

  var Done: boolean);
begin
  if paramGraph.idleEvent_RefreshImage then
    ImagemapFullRefresh(true);
  Done := true;
end;

procedure TForm1.ImagemapFullRefresh(refresharray: boolean;
  RefreshMap: boolean = true);
var
  Node: pvirtualnode;
  Data: ptreeGenericdata;
begin
  if dontdisturb then
    exit;
  ERRORCHECKPOINT := 45;
  screen.Cursor := crHourGlass;
  // clear offset:
  Node := SpellTree.getfirst;
  while assigned(Node) do
  begin
    Data := SpellTree.GetNodeData(Node);
    tspellinfo(Data.BasicND.p).offsetaura := -1;
    Node := SpellTree.GetNextSibling(Node);
  end;

  // forceupdate
  if paramGraph.postponeStatUpdate then
    completeRefresh([RefreshUnit, RefreshUnitStats]);

  // security:
  if not assigned(paramGraph.WatchedUnit) then
    paramGraph.FocusedMode := 0;
  // gauge
  if paramGraph.FocusedMode > 0 then
  begin
    paramGraph.gaugeNoDirectChange := true;
    GaugeBar2.min := 0;
    GaugeBar2.max := getmaxfocusedOffset;
    GaugeBar2.Position := paramGraph.FocusedAuraOffset;
    GaugeBar2.Visible := true;
    paramGraph.gaugeNoDirectChange := false;
  end
  else
  begin
    paramGraph.gaugeNoDirectChange := true;
    if paramGraph.yoffset < -paramGraph.gaugecount then
      paramGraph.yoffset := -paramGraph.gaugecount;
    GaugeBar2.min := 0;
    GaugeBar2.max := paramGraph.gaugecount;
    GaugeBar2.Position := -round(paramGraph.yoffset);
    AssignDrawedUnit(Imagemap.height div UNIT_SPACE_LINE + 1);
    GaugeBar2.Visible := true;
    paramGraph.gaugeNoDirectChange := false;
  end;
  paramGraph.noredim := false;

  // refresh
  if refresharray then
    filleventArray;
  if RefreshMap then
    Imagemap.changed;

  paramGraph.postponeStatUpdate := false;
  paramGraph.idleEvent_RefreshImage := false;
  screen.Cursor := crDefault;
{$IFDEF DEBUG}
  if DRAWDEBUGREFRESH then
    MemoStat.lines.add(format('REFRESH: %d', [random(100)]));
{$ENDIF DEBUG}
  ERRORCHECKPOINT := 46;
end;

procedure TForm1.dynamicAddUnit(periodEventId, t1, t2: integer;
  RefreshMap: boolean = true);
  procedure checkNodeAndParent(gt: guidType; Node: pvirtualnode;
    c: TCheckState);
  begin
    if (Node.Parent = masterNode[1]) and not unitTree.IsVisible[Node] then
      c := csuncheckedNormal;
    Node.CheckState := c;
    if gt = unitisplayer then
      Node.Parent.CheckState := c;
  end;

var
  i, j, k: integer;
  ul: tUnitData;
  u: tunitinfo;
  p: pEvent;
  v: longword;
  cs: TCheckState;
begin
  //clean replay data
  for i := 0 to replaylist.count -1 do
    tUnitData(replaylist[i]).replayData.cleanData;
  replaylist.clear;
  replay.Evaluateratio := true;
  replay.startId := paramGraph.select.startId;
  replay.startTime := paramGraph.select.startTime;

  //define unit
  paramGraph.gaugecount := 0;
  v := GetTickCount;
  if t1 = 0 then
    t1 := 1;
  if t2 = 0 then
    t2 := 1;
  // info for peventrange
  for i := periodEventId to Eventlist.count - 1 do
  begin
    p := Eventlist.items[i];
    if p.Time > t2 then
      break;
    checkLocalEvent(p, v);
  end;
  // Units
  for j := 0 to unitList.count - 1 do
  begin
    u := unitList.items[j];
    if u.unittype <> unitIsObject then
      for k := 0 to u.list.count - 1 do
      begin
        ul := u.list.items[k];
        ul.replayData.auraList.clear;
        cs := GetRightForDynamicAdd(ul.getCombatForLocalPeriode(t1, t2, v), ul,
          u.constantParams.option1, ul.pnode);
        checkNodeAndParent(ul.uGUID.unittype, ul.pnode, cs);
        // count for gaugebar
        if (cs = csCheckedPressed) or (cs = csCheckedNormal) then
        begin
          replaylist.add(ul);
          inc(paramGraph.gaugecount);
        end;
      end;
  end;
  //replay assign auraevent
  for i := periodEventId to Eventlist.count - 1 do
  begin
    p := Eventlist.items[i];
    if p.Time > t2 then break;
    if assigned(p.destUnit) then
    begin
      if spellIsExcludedForTracking in p.spell.constantParams.option2 then
        continue
      else if spellIsIncludedForTracking in p.spell.constantParams.option2 then
        p.destUnit.replaydata.auraList.add(p)
      else if (p.destUnit.uGUID.unittype = unitIsPlayer) and (eventIsdebuff in p.params) then
           p.destUnit.replaydata.auraList.add(p);
    end;
  end;

  ShowUnitOnlyInCombat(treeOnlyInCombat1.checked);
  unitTree.repaint;
  paramGraph.gaugecount := paramGraph.gaugecount - 1;
  ImagemapFullRefresh(true, RefreshMap);
end;

procedure TForm1.ShowUnitOnlyInCombat(OnlyInCombat: boolean);
var
  Node: pvirtualnode;
begin
  if not assigned(masterNode[2]) then
    exit;
  unitTree.BeginUpdate;
  Node := masterNode[2].firstchild;
  while assigned(Node) do
  begin
    if OnlyInCombat then
    begin
      if unitTree.GetNodeLevel(Node) > 0 then
        unitTree.IsVisible[Node] := false;
      if (Node.CheckState = csCheckedNormal) or
        (Node.CheckState = csCheckedPressed) then
      begin
        unitTree.IsVisible[Node] := true;
        unitTree.IsVisible[Node.Parent] := true;
        // unittree.Expanded[node.parent]:=true;
      end;
    end
    else
      unitTree.IsVisible[Node] := true;
    Node := unitTree.GetNext(Node);
  end;
  unitTree.endupdate;
end;

function TForm1.GetRightForDynamicAdd(inCombat: boolean; ul: tUnitData;
  UOpt: unitOpts; n: pvirtualnode): TCheckState;
var
  tmpbool: boolean;
begin
  tmpbool := inCombat;
  case ul.uGUID.unittype of
    unitIsNpc:
      begin
        if not(upWasNpcVsRaid in ul.params) then
        begin
          tmpbool := false;
          if assigned(ul.UnitAffiliation) and
            (upWasNpcVsRaid in tUnitData(ul.UnitAffiliation).params) then
            tmpbool := inCombat;
        end;

        if (upWasInRaid in ul.params) then
          tmpbool := inCombat;
        if (uoisBan in UOpt) then
          tmpbool := false
        else
        begin
          if GfxNoAffiliation.checked and (upWasInRaid in ul.params) then
            if ul.UnitAffiliation <> nil then
              tmpbool := false;
          if GfxNoNpc.checked then
            tmpbool := false;
          if GfxAlwaysBoss.checked and ([uoIsBoss,
            uoIsBossAffiliated] * UOpt <> []) then
            tmpbool := inCombat;
        end;
        if tmpbool then
          Result := csCheckedNormal
        else
          Result := csuncheckedNormal;
      end;
    unitisplayer:
      begin
        if GfxShowInactive.checked and (upWasPlayerInRaid in (getUnitParam(ul))
          ) then
          tmpbool := true;
        case n.CheckState of
          csuncheckedNormal:
            Result := csuncheckedNormal;
          csunCheckedPressed:
            if tmpbool then
              Result := csCheckedPressed
            else
              Result := csunCheckedPressed;
          csCheckedNormal:
            Result := csCheckedNormal;
        else
          if tmpbool then
            Result := csCheckedPressed
          else
            Result := csunCheckedPressed;
        end
      end;
    unitIsPet:
      if GfxNoPet.checked then
        Result := csuncheckedNormal
      else if tmpbool then
        Result := csCheckedNormal
      else
        Result := csuncheckedNormal;
  else
    Result := csuncheckedNormal;
  end;
end;

function sortdrawlist(p1, p2: Pointer): integer;
begin
  Result := (tUnitData(p1).inCombat.First - tUnitData(p2).inCombat.First);
end;

procedure TForm1.AssignDrawedUnit(maxunit: integer);
var
  Node: pvirtualnode;
  pu: tUnitData;
  offset: integer;
  i: integer;
  l: tlist;
begin
  drawedList.clear;
  l := tlist.create;
  // building npc list classés par ordre d'apparition
  Node := masterNode[3];
  while Node <> masterNode[4] do
  begin
    if unitTree.GetNodeLevel(Node) = 2 then
    begin
      pu := ptreeGenericdata(unitTree.GetNodeData(Node)).BasicND.p;
      pu.idInDrawList := -1;
      pu.instaline.eventarray := nil;
      if IsNodeChecked(Node) then
        l.add(pu);
    end;
    Node := unitTree.GetNext(Node);
  end;
  l.Sort(sortdrawlist);
  // player / pet /objets
  Node := masterNode[1];
  offset := round(paramGraph.yoffset);
  while assigned(Node) do
  begin
    if unitTree.GetNodeLevel(Node) = 2 then
    begin
      pu := ptreeGenericdata(unitTree.GetNodeData(Node)).BasicND.p;
      pu.idInDrawList := -1;
      pu.instaline.eventarray := nil;
      if IsNodeChecked(Node) then
      begin
        if ((drawedList.count) < maxunit) and (offset >= 0) then
          drawedList.add(pu);
        inc(offset);
      end;
    end;
    Node := unitTree.GetNext(Node);
    if Node = masterNode[3] then
      Node := masterNode[4];
  end;

  // transfert des NPC classés
  for i := 0 to l.count - 1 do
  begin
    if ((drawedList.count) < maxunit) and (offset >= 0) then
      drawedList.add(l.items[i]);
    inc(offset);
  end;
  // classification
  for i := 0 to drawedList.count - 1 do
    tUnitData(drawedList.items[i]).idInDrawList := i;
  l.free;
end;

procedure TForm1.checkLocalEvent(p: pEvent; v: longword);
begin
  assignLocalCombatTime(p.sourceUnit, p.Time, v);
  assignLocalCombatTime(p.destUnit, p.Time, v);
end;

procedure TForm1.assignLocalCombatTime(ul: tUnitData; t: integer; v: longword);
begin
  if assigned(ul) then
  begin
    if t = 0 then
      t := 1; // on prevoit l'eventualité d'un premier event = combat
    if ul.inCombat.validator <> v then
    begin
      ul.inCombat.First := 0;
      ul.inCombat.validator := v;
    end;
    if ul.inCombat.First = 0 then
    begin
      ul.inCombat.First := t;
      ul.inCombat.last := t;
    end
    else
      ul.inCombat.last := t;
  end
end;

procedure TForm1.ShowOnlySpell1Click(Sender: TObject);
begin
  if assigned(paramGraph.MenuActiveEvent) then
  begin
    if paramGraph.MenuActiveEvent.spell.id > 0 then
    begin
      CheckAllNodes(SpellTree.getfirst, csunCheckedPressed);
      CheckAllNodes(EventTree.getfirst, csCheckedPressed);
      pvirtualnode(paramGraph.MenuActiveEvent.spell.pnode).CheckState :=
        csCheckedNormal;
      AssignFilterFromtree(true, true);
    end;
  end;
end;

procedure TForm1.CheckSpell2Click(Sender: TObject);
begin
  if assigned(paramGraph.MenuActiveEvent) then
    getWebInfoforSpell(paramGraph.MenuActiveEvent.spell);
end;

procedure TForm1.getWebInfoforSpell(spell: tspellinfo);
var
  strlink: string;
begin
  if assigned(spell) and (spell.id > 6) and (spell.id < SECUNDARY_SPELL_INDEX)
    then
  begin
    strlink := prefs.WebLink;
    if strlink = '' then
    begin
      if InputQuery(REQUESTMAINTITLE, SPELLWEBLINKREQUEST, strlink) then
        prefs.WebLink := strlink
      else
        exit;
    end;
    ShellExecute(0, 'open', pchar(stringreplace(strlink, '%s',
          inttostr(spell.id), [rfReplaceall])), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure TForm1.getWebInfoForUnit(u: tunitinfo);
var
  strlink, uname, userver: string;
begin
  if u.unittype = unitisplayer then
  begin
    strlink := prefs.ArmoryLink;
    if strlink = '' then
    begin
      if InputQuery(REQUESTMAINTITLE, ARMORYLINKREQUEST, strlink) then
        prefs.ArmoryLink := strlink
      else
        exit;
    end;
    uname := trim(GetFirstToken(u.name, UNITNAMESERVEURSEPARATOR));
    userver := trim(GetLastToken(u.name, UNITNAMESERVEURSEPARATOR));
    if (userver = '') or (uname = userver) then
    begin
      userver := prefs.DefaultServerName;
      if userver = '' then
      begin
        if InputQuery(REQUESTMAINTITLE, SERVERNAMEREQUEST, userver) then
          prefs.DefaultServerName := userver
        else
          exit;
      end;
      userver := prefs.DefaultServerName;
    end;
    strlink := stringreplace(strlink, '%s', userver, [rfReplaceall]);
    strlink := stringreplace(strlink, '%n', uname, [rfReplaceall]);
    ShellExecute(0, 'open', pchar(strlink), nil, nil, SW_SHOWNORMAL);
  end
  else if u.unittype = unitIsNpc then
  begin
    strlink := prefs.UnitWebLink;
    if strlink = '' then
    begin
      if InputQuery(REQUESTMAINTITLE, UNITWEBLINKREQUEST, strlink) then
        prefs.UnitWebLink := strlink
      else
        exit;
    end;
    ShellExecute(0, 'open', pchar(stringreplace(strlink, '%u',
          inttostr(u.mobId), [rfReplaceall])), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure TForm1.SpellTreeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: pvirtualnode;

  var InitialStates: TVirtualNodeInitStates);
begin
  Node.checktype := ctTriStateCheckBox;
end;

procedure TForm1.SpellTreeBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect;

  var ContentRect: TRect);
var
  Data: ptreeGenericdata;
begin
  if Column = 1 then
  begin
    Data := SpellTree.GetNodeData(Node);
    inc(CellRect.top);
    dec(CellRect.bottom);
    CellRect.right := CellRect.left + 5;
    if spellIsDamage in tspellinfo(Data.BasicND.p).sdata then
    begin
      TargetCanvas.Brush.color := eventValue[0].color;
      TargetCanvas.FillRect(CellRect);
    end;
    CellRect.left := CellRect.right + 1;
    CellRect.right := CellRect.left + 5;
    if spellIsHeal in tspellinfo(Data.BasicND.p).sdata then
    begin
      TargetCanvas.Brush.color := eventValue[4].color;
      TargetCanvas.FillRect(CellRect);
    end;
    CellRect.left := CellRect.right + 1;
    CellRect.right := CellRect.left + 5;
    if spellIsBuff in tspellinfo(Data.BasicND.p).sdata then
    begin
      TargetCanvas.Brush.color := event_color_Buff;
      TargetCanvas.FillRect(CellRect);
    end;
    CellRect.left := CellRect.right + 1;
    CellRect.right := CellRect.left + 5;
    if spellIsDebuff in tspellinfo(Data.BasicND.p).sdata then
    begin
      TargetCanvas.Brush.color := eventValue[7].color;
      TargetCanvas.FillRect(CellRect);
    end;
  end;
end;

procedure TForm1.SpellTreeFreeNode(Sender: TBaseVirtualTree;
  Node: pvirtualnode);
var
  Data: ptreeGenericdata;
begin
  Data := Sender.GetNodeData(Node);
  Data.BasicND.destroy;
end;

procedure TForm1.SpellTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
  Column: TColumnIndex; TextType: TVSTTextType;

  var CellText: string);
var
  Data: ptreeGenericdata;
begin
  if Column = 0 then
  begin
    Data := SpellTree.GetNodeData(Node);
    CellText := tspellinfo(Data.BasicND.p).name;
    // params
    if (tspellinfo(Data.BasicND.p).constantParams.option1 > 0) then
      CellText := CellText + ' (' + ClasseStat[tspellinfo(Data.BasicND.p)
        .constantParams.option1].shortname + ')';
    if (spellIsaffiliation in tspellinfo(Data.BasicND.p)
        .constantParams.option2) or (spellIsReverseAffiliation in tspellinfo
        (Data.BasicND.p).constantParams.option2) then
      CellText := CellText + ' (pet affiliation)';
    if (spellIsSingleAura in tspellinfo(Data.BasicND.p).constantParams.option2)
      then
      CellText := CellText + ' (single auraline)';

    if tspellinfo(Data.BasicND.p).castDuration > 0 then
    begin
      CellText := CellText + format(' <castDuration: %d>',
        [tspellinfo(Data.BasicND.p).castDuration]);
    end;

    // spellSchoolparam[ae.school].ingameHex
    // celltext:=celltext+' 0x'+inttohex(tspellInfo(data.basicND.p).school,2);
  end
  else
    CellText := '';
end;

procedure TForm1.EventTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
  Column: TColumnIndex; TextType: TVSTTextType;

  var CellText: String);
var
  Data: ptreeGenericdata;
begin
  Data := EventTree.GetNodeData(Node);
  CellText := geteventname(tEventType(Data.BasicND.p).id);
end;

procedure TForm1.SpellTreeCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: pvirtualnode; Column: TColumnIndex;

  var Result: integer);
var
  data1, data2: ptreeGenericdata;
begin
  data1 := SpellTree.GetNodeData(Node1);
  data2 := SpellTree.GetNodeData(Node2);
  Result := comparetext(tspellinfo(data1.BasicND.p).name,
    tspellinfo(data2.BasicND.p).name);
end;

procedure TForm1.EventTreeCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: pvirtualnode; Column: TColumnIndex;

  var Result: integer);
var
  data1, data2: ptreeGenericdata;
begin
  data1 := EventTree.GetNodeData(Node1);
  data2 := EventTree.GetNodeData(Node2);
  Result := comparetext(eventValue[tEventType(data1.BasicND.p).id].name,
    eventValue[tEventType(data2.BasicND.p).id].name);
end;

procedure TForm1.SpellTreeChecked(Sender: TBaseVirtualTree; Node: pvirtualnode);
var
  nodetmp: pvirtualnode;
  nodechecked, nodeunchecked: boolean;
begin
  nodechecked := false;
  nodeunchecked := false;
  // on regarde si il y a au moins un node en csnormal
  if Node.CheckState = csCheckedNormal then
    nodechecked := true
  else
  begin
    nodetmp := Sender.getfirst;
    while assigned(nodetmp) do
    begin
      if nodetmp.CheckState = csCheckedNormal then
        nodechecked := true;
      if nodetmp.CheckState = csuncheckedNormal then
        nodeunchecked := true;
      if nodechecked and nodeunchecked then
        break;
      nodetmp := nodetmp.NextSibling;
    end;
  end;
  // si on a un node checkednormal on passe tous les pressedchecked pressedUnchecked
  if nodechecked then
    ConditionalCheckAllNodes(Sender.getfirst, csCheckedPressed,
      csunCheckedPressed)
    // sinon on inverse
  else if nodeunchecked then
    ConditionalCheckAllNodes(Sender.getfirst, csunCheckedPressed,
      csCheckedPressed)
    // sinon on retablit tout
  else
    CheckAllNodes(Sender.getfirst, csCheckedPressed);
  AssignFilterFromtree(true, true);
end;

function TForm1.ValidEventSelection(vt: TBaseVirtualTree): boolean;
var
  Node: pvirtualnode;
begin
  Node := vt.getfirst;
  while assigned(Node) do
  begin
    if Node.CheckState <> csCheckedPressed then
    begin
      Result := true;
      exit;
    end;
    Node := Node.NextSibling;
  end;
  Result := false;
end;

procedure TForm1.CheckAllNodes(Node: pvirtualnode; cs: TCheckState;
  checkchild: boolean = false);
begin
  while assigned(Node) do
  begin
    Node.CheckState := cs;
    if checkchild and assigned(Node.firstchild) then
      Node.firstchild.CheckState := cs;
    Node := Node.NextSibling;
  end;
end;

procedure TForm1.ConditionalCheckAllNodes(Node: pvirtualnode;
  cs1, cs2: TCheckState; checkchild: boolean = false);
begin
  while assigned(Node) do
  begin
    if Node.CheckState = cs1 then
    begin
      Node.CheckState := cs2;
      if checkchild and assigned(Node.firstchild) then
        Node.firstchild.CheckState := cs2;
    end;
    Node := Node.NextSibling;
  end;
end;

procedure TForm1.CheckAll1Click(Sender: TObject);
begin
  CheckAllNodes(SpellTree.getfirst, csCheckedPressed);
  AssignFilterFromtree(true, true);
end;

procedure TForm1.CheckAll2Click(Sender: TObject);
begin
  CheckAllNodes(EventTree.getfirst, csCheckedPressed);
  AssignFilterFromtree(true, true);
end;

procedure TForm1.unitTreePaintText(Sender: TBaseVirtualTree;

  const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: ptreeGenericdata;
  uO: unitOpts;
begin
  Data := unitTree.GetNodeData(Node);
  if unitTree.GetNodeLevel(Node) = 1 then
  begin
    uO := GetUnitOption(tunitinfo(Data.BasicND.p));
    if uoIsBoss in uO then
    begin
      TargetCanvas.font.color := $004477AA;
      TargetCanvas.font.Style := [fsBold];
    end;
    if uoIsBossAffiliated in uO then
    begin
      TargetCanvas.font.color := $004477AA;
    end;
    if uoisBan in uO then
    begin
      TargetCanvas.font.color := $00777777;
    end;
  end;
  if unitTree.GetNodeLevel(Node) = 2 then
  begin
    if (upIsValidNPC in tUnitData(Data.BasicND.p).params) and
      ((uoisBan in GetUnitOption(tUnitData(Data.BasicND.p))) or not
        (upWasNpcVsRaid in tUnitData(Data.BasicND.p).params)) then
      TargetCanvas.font.color := $00777777
  end;

end;

procedure TForm1.SpellTreeChecking(Sender: TBaseVirtualTree; Node: pvirtualnode;

  var NewState: TCheckState;

  var Allowed: boolean);
begin
  if not paramGraph.overridefiltercheck then
    case Node.CheckState of
      // csuncheckednormal:NewState:=cscheckedpressed;
      csunCheckedPressed:
        NewState := csCheckedNormal;
      // cscheckednormal:NewState:=csuncheckednormal;
      csCheckedNormal:
        NewState := csCheckedPressed;
      csCheckedPressed:
        NewState := csCheckedNormal;
    end
  else
    paramGraph.overridefiltercheck := false;
  Allowed := true;
end;

function TForm1.resetCurrentFilter(dofilterrefresh: boolean = true): boolean;
var
  Node: pvirtualnode;
begin
  Result := false;
  Node := CustomFilterTree.getfirst;
  while assigned(Node) do
  begin
    Result := Result or ((Node.CheckState = csCheckedNormal));
    Node.CheckState := csuncheckedNormal;
    Node := Node.NextSibling;
  end;
  if dofilterrefresh and Result then
    AssignFilterFromtree(false, false);
end;

function TForm1.resetSpellEventselection: boolean;
begin
  Result := resetCurrentFilter(false);
  if defaultFilter.isValid then
  begin
    CheckAllNodes(SpellTree.getfirst, csCheckedPressed);
    CheckAllNodes(EventTree.getfirst, csCheckedPressed);
    CheckAllNodes(FilterTree.getfirst, csunCheckedPressed);
    AssignFilterFromtree(true, false);
    Result := true;
  end
  else if Result then
    AssignFilterFromtree(false, false);

end;

function TForm1.resetRepere: boolean;
begin
  if paramGraph.repere <> 0 then
  begin
    paramGraph.repere := 0;
    Result := true;
  end
  else
    Result := false;
end;

procedure TForm1.resetTimePeriodDatas;
begin
  paramGraph.select.state := sS_empty;
  paramGraph.select.startTime := -1;
  paramGraph.select.endTime := GlobalEndLogTime;
  paramGraph.select.startId := 0;
  paramGraph.select.selectionLabel := '';
  paramGraph.select.isBlockSelection := false;
  settimetreefocus(nil);
end;

function TForm1.resetTimePeriod: boolean;
begin
  if paramGraph.select.state <> sS_empty then
  begin
    resetTimePeriodDatas;
    completeRefresh([RefreshStats, RefreshUnitStats]);
    Result := true;
  end
  else
    Result := false;
  validTimeButton;
end;

function TForm1.resetUnitRef: boolean;
var
  i, j: integer;
  u: tunitinfo;
begin
  if paramGraph.unitRef then
  begin
    for i := 0 to unitList.count - 1 do
    begin
      u := unitList.items[i];
      for j := 0 to u.list.count - 1 do
        tUnitData(u.list.items[j]).params := tUnitData(u.list.items[j])
          .params - [upUnitRef];
      u.focusInList := false;
    end;
    paramGraph.unitRef := false;
    Result := true;
  end
  else
    Result := false;
  gfx_ResetFocus.enabled := false;
  unitTree.repaint;
end;

procedure TForm1.rotate01Click(Sender: TObject);
begin
  TMenuItem(Sender).checked := true;
  replay.angle := TMenuItem(Sender).tag;
  replay.Evaluateratio := true;
  ImageReplay.changed;
end;

function TForm1.isUnitRefActive: boolean;
var
  i, j: integer;
  u: tunitinfo;
begin
  Result := false;
  for i := 0 to unitList.count - 1 do
  begin
    u := unitList.items[i];
    u.focusInList := false;
    for j := 0 to u.list.count - 1 do
      if upUnitRef in tUnitData(u.list.items[j]).params then
      begin
        u.focusInList := true;
        Result := true;
        break;
      end
  end;
  // refresh unittree.
  unitTree.repaint
end;

function TForm1.getPointedUnit: tunitdata;
begin
   if assigned(replay.unitonMouse) then
      result := replay.unitonMouse
   else if paramGraph.FocusedMode > 0 then
    result:= paramGraph.watchedUnit
   else
    result := paramGraph.activeUnitGfx;
end;

function TForm1.getPointedSpell: tSpellInfo;
begin
  if assigned (paramGraph.activeEvent) then
    result:=paramGraph.activeEvent.spell
  else
    result:=nil;
end;

function TForm1.getPointedEvent: pEvent;
begin
  result :=paramGraph.activeEvent;
end;

procedure TForm1.ImagePopUpPopup(Sender: TObject);
var
  sdata: spelldatas;
  actEventName: string;
  tmpid: integer;
begin
  paramGraph.MenuActiveEvent := getPointedEvent;
  paramGraph.MenuActiveSpell := getPointedSpell;
  paramGraph.MenuActiveUnitGfx := getPointedUnit;





  ViewEventInList1.enabled := assigned(paramGraph.MenuActiveEvent);
  SetAuraWatch1.enabled := false;
  SetAuraWatch1.Caption := 'Set AuraWatch [All Sources]';
  SetAuraWatchUnit2.enabled := false;
  SetAuraWatchUnit2.Caption := 'Set AuraWatch [Source: Nil]';
  EditSpell1.Visible := false;

  tmpid := GetUnitOptionMobId(paramGraph.MenuActiveUnitGfx);
  UpdateUnitAff2.Visible := tmpid > 0;
  UpdateUnitAff2.Caption := 'Options for (boss aff): ' + getunitname(tmpid, []);

  if paramGraph.aurawatch > 0 then
  begin
    RemoveAuraWatch1.enabled := true;
    RemoveAuraWatch1.Caption := 'Remove auraWatch [actual: ' + getspellname
      (paramGraph.aurawatch) + ']';
  end
  else
  begin
    RemoveAuraWatch1.enabled := false;
    RemoveAuraWatch1.Caption := 'Remove auraWatch';
  end;

  if assigned(paramGraph.MenuActiveUnitGfx) then
  begin
    ForcePlayerInRaid1.enabled :=
      (paramGraph.MenuActiveUnitGfx.uGUID.unittype = unitisplayer);
    UpdateUnit2.enabled :=
      (paramGraph.MenuActiveUnitGfx.uGUID.unittype = unitIsNpc) and
      (not(uoisBan in GetUnitOption(getunitinfo(paramGraph.MenuActiveUnitGfx)))
      );
    CheckUnitOnWeb1.enabled :=
      (paramGraph.MenuActiveUnitGfx.uGUID.unittype = unitIsNpc) or
      (paramGraph.MenuActiveUnitGfx.uGUID.unittype = unitisplayer)
  end
  else
  begin
    UpdateUnit2.enabled := false;
    CheckUnitOnWeb1.enabled := false;
    ForcePlayerInRaid1.enabled := false;
  end;

  ShowOnlyUnit1.enabled := assigned(paramGraph.MenuActiveUnitGfx);
  ShowOnlyUnit1.Caption := 'Toggle focus on: : ' + getunitname
    (paramGraph.MenuActiveUnitGfx, [getaff]);
  ShowOnlyAllUnit1.enabled := assigned(paramGraph.MenuActiveUnitGfx);
  ShowOnlyAllUnit1.Caption := 'Toggle focus on all instances of: ' + getunitname
    (paramGraph.MenuActiveUnitGfx, [getaff]);


  if ReplayTab.visible then
  begin
    DetailsOnUnit1.enabled := assigned(paramGraph.MenuActiveUnitGfx);
      DetailsOnUnit1.Caption := 'Details for : ' + getunitname
        (paramGraph.MenuActiveUnitGfx, [getaff]);
  end
  else
  begin
    if paramGraph.FocusedMode > 0 then
    begin
      DetailsOnUnit1.enabled := true;
      DetailsOnUnit1.Caption := 'Go back to list';
    end
    else
    begin
      DetailsOnUnit1.enabled := assigned(paramGraph.MenuActiveUnitGfx);
      DetailsOnUnit1.Caption := 'Details for : ' + getunitname
        (paramGraph.MenuActiveUnitGfx, [getaff]);
    end;
  end;

  UpdateUnit2.Caption := 'Options for: ' + getunitname
    (paramGraph.MenuActiveUnitGfx, []);
  CheckUnitOnWeb1.Caption := format('Check [%s] on Web',
    [getunitname(paramGraph.MenuActiveUnitGfx, [])]);
  ForcePlayerInRaid1.Caption := format('Force [%s] in Raid',
    [getunitname(paramGraph.MenuActiveUnitGfx, [])]);

  ShowOnlySpell1.enabled := assigned(paramGraph.MenuActiveEvent);
  ShowOnlySpell1.Caption := 'ShowOnlySpell: ';

  CheckSpell2.enabled := assigned(paramGraph.MenuActiveEvent)
    and CheckLegitSpellId(paramGraph.MenuActiveEvent.spell); ;
  CheckSpell2.Caption := 'Check [Spell] on Web';

  if assigned(paramGraph.MenuActiveEvent) then
  begin
    actEventName := getspellname(paramGraph.MenuActiveEvent);
    ShowOnlySpell1.Caption := ShowOnlySpell1.Caption + actEventName;
    CheckSpell2.Caption := format('Check [%s] on Web', [actEventName]);
    sdata := getSpellDatas(paramGraph.MenuActiveEvent.spell);
    if (spellIsBuff in sdata) or (spellIsDebuff in sdata) then
    begin
      SetAuraWatch1.enabled := true;
      SetAuraWatch1.Caption := format('Set AuraWatch for [%s][All Sources]',
        [actEventName]);
      SetAuraWatchUnit2.Visible := assigned
        (paramGraph.MenuActiveEvent.sourceUnit);
      SetAuraWatchUnit2.enabled := true;
      SetAuraWatchUnit2.Caption := format('Set AuraWatch for [%s][Source:%s]',
        [actEventName, getunitname(paramGraph.MenuActiveEvent.sourceUnit,
          [])]);
    end;
    if CheckLegitSpellId(paramGraph.MenuActiveEvent.spell) then
    begin
      EditSpell1.Visible := true;
      EditSpell1.Caption := format('EditSpellParams [%s]', [actEventName]);
    end
  end;
  ResetSel1.enabled := paramGraph.unitRef;
  ResetSel2.enabled := ValidEventSelection(SpellTree) or ValidEventSelection
    (EventTree) or (defaultFilter.FilterParamsChecked <> []) or
    (defaultFilter.FilterParamsunChecked <> []);
  ResetSel3.enabled := paramGraph.select.state <> sS_empty;
  ResetSel4.enabled := paramGraph.repere <> 0;
end;

procedure TForm1.ResetSel1Click(Sender: TObject);
begin
  if resetUnitRef then
    completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats, RefreshMap]);
end;

procedure TForm1.ResetSel2Click(Sender: TObject);
begin
  if resetSpellEventselection then
    Imagemap.changed;
end;

procedure TForm1.ResetSel3Click(Sender: TObject);
begin
  if resetTimePeriod then
    Imagemap.changed;
end;

procedure TForm1.ResetSel4Click(Sender: TObject);
begin
  if resetRepere then
    Imagemap.changed;
end;

procedure TForm1.EditSpell1Click(Sender: TObject);
begin
  if assigned(paramGraph.MenuActiveEvent) then
    editSpellParams(paramGraph.MenuActiveEvent.spell.id);
end;

procedure TForm1.SpellPopupPopup(Sender: TObject);
begin
  SetAuraWatch2.enabled := false;
  SetAuraWatchUnit1.enabled := false;
  SetAuraWatch2.Caption := 'Set AuraWatch [All Sources]';
  SetAuraWatchUnit1.Caption := 'Set AuraWatch [Source: Nil]';

  if assigned(paramGraph.focusedSpell) then
  begin
    SpellInfo1.Caption := format('Check [%s (%d)] on web',
      [paramGraph.focusedSpell.name, paramGraph.focusedSpell.id]);
    EditSpell2.Visible := CheckLegitSpellId(paramGraph.focusedSpell);
    EditSpell2.Caption := 'EditSpellParams: ' + paramGraph.focusedSpell.name;
    SpellInfo1.Visible := true;
    SpellInfo1.enabled := EditSpell2.Visible;
    SetAuraWatch2.Visible := true;
    if (spellIsBuff in paramGraph.focusedSpell.sdata) or
      (spellIsDebuff in paramGraph.focusedSpell.sdata) then
    begin
      SetAuraWatch2.enabled := true;
      SetAuraWatch2.Caption := format('Set AuraWatch for [%s][All Sources]',
        [paramGraph.focusedSpell.name]);
      SetAuraWatchUnit1.Visible := assigned(paramGraph.WatchedUnit);
      SetAuraWatchUnit1.enabled := true;
      SetAuraWatchUnit1.Caption := format('Set AuraWatch for [%s][Source:%s]',
        [paramGraph.focusedSpell.name, getunitname(paramGraph.WatchedUnit,
          [])]);
    end;
  end
  else
  begin
    EditSpell2.Visible := false;
    SpellInfo1.Visible := false;
    SetAuraWatch2.Visible := false;
    SetAuraWatchUnit1.Visible := false;
  end;

  if paramGraph.aurawatch > 0 then
  begin
    RemoveAuraWatch2.enabled := true;
    RemoveAuraWatch2.Caption := 'Remove auraWatch [actual: ' + getspellname
      (paramGraph.aurawatch) + ']';
  end
  else
  begin
    RemoveAuraWatch2.enabled := false;
    RemoveAuraWatch2.Caption := 'Remove auraWatch';
  end;
  Resetfullfilter2.enabled := gfx_ResetFilter.enabled;
end;

procedure TForm1.EditSpell2Click(Sender: TObject);
begin
  if assigned(paramGraph.focusedSpell) then
    editSpellParams(paramGraph.focusedSpell.id);

end;

procedure TForm1.editSpellParams(id: integer);
begin
  if not authsavespellarray then
  begin
    showmessage('old spellarray  used: modification forbidden');
    exit;
  end;
  if CheckLegitSpellIdex(id) then
  begin
    form2 := tform2.create(self);
    form2.spellId := id;
    if form2.showmodal = mrOk then
    begin

      // finalysing
      SpellTree.repaint;
      // ---------rebuild absorb
      screen.Cursor := crHourGlass;
      generateBossIndex;
      generateCombatBlock;
      MaxAbsRow := buildAbsorbCount(Eventlist);
      MaxCastRow := buildcastTime(Eventlist, replayCastList);
      buildcastInterrupt(Eventlist);

      MyTree.repaint;
      completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats,
        RefreshMap]);
      LogStatsOutput;
      screen.Cursor := crDefault;
    end;
    form2.free;
  end;
end;

procedure TForm1.SpellTreePaintText(Sender: TBaseVirtualTree;

  const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: ptreeGenericdata;
begin
  Data := SpellTree.GetNodeData(Node);
  if tspellinfo(Data.BasicND.p).hasConstantParams then
    TargetCanvas.font.Style := [fsBold];
  if tspellinfo(Data.BasicND.p).id > SECUNDARY_SPELL_INDEX then
    TargetCanvas.font.Style := TargetCanvas.font.Style + [fsItalic];
end;

procedure TForm1.EditUnitParams1Click(Sender: TObject);
var
  Data: ptreeGenericdata;
begin
  if assigned(unitTree.focusednode) then
    if unitTree.GetNodeLevel(unitTree.focusednode) = 1 then
    begin
      Data := unitTree.GetNodeData(unitTree.focusednode);
      editUnitParams(Data.BasicND.p)
    end;
end;

procedure TForm1.editUnitParams(u: tunitinfo);
begin
  if (upIsValidNPC in u.params) then
  begin
    form3 := tform3.create(self);
    form3.Edit1.enabled := false;
    form3.checkbox9.Visible := false;
    form3.localUnit := u;
    if form3.showmodal = mrOk then
    begin
      generateBossIndex;
      generateCombatBlock;
      unitTree.repaint;
      completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats,
        RefreshMap]);
      LogStatsOutput;
    end;
    form3.free;
  end;
end;

procedure TForm1.unitToEventTree(Node: pvirtualnode);
var
  Data: ptreeGenericdata;
  filter: eventFilter;
begin
  if assigned(Node) then
  begin
    Data := unitTree.GetNodeData(Node);
    case unitTree.GetNodeLevel(Node) of
      0:
        ;
      1:
        if tunitinfo(Data.BasicND.p).unittype = unitisplayer then
        begin
          filter.option := [optUnitGUID];
          filter.GUID := tunitinfo(Data.BasicND.p).GUID;
          fillTreeEvent(filter);
        end
        else
        begin
          filter.option := [optUnitId];
          filter.mobId := tunitinfo(Data.BasicND.p).mobId;
          fillTreeEvent(filter);
        end;
      2:
        begin
          filter.option := [optUnitGUID];
          filter.GUID := tUnitData(Data.BasicND.p).uGUID.GUID;
          fillTreeEvent(filter);
        end
    end;
  end;
end;

function TForm1.AssignFilterFromtree(evaluatedefault, checkDefault: boolean)
  : boolean;
var
  dataTag: pFilterDatanode;
  dataGeneric: ptreeGenericdata;
  Node: pvirtualnode;
  filter: eventFilter;
  i, j: integer;
begin
  // mainfilter id: gestion de l'otimisation des filtre: si l'event a le meme ID, il a deja été evalué comme etant dans le filtre.
  // lorsque l'id revient a 0 (sur 256), il faut reinitialiser l'etat de tous les event
  inc(MainFilterID);
  if MainFilterID = FILTERMAXID then
  begin
    MainFilterID := 1;
    for i := 0 to Eventlist.count - 1 do
      pEvent(Eventlist.items[i]).filter := 0;
  end;
  Result := false;
  if evaluatedefault then
  begin
    defaultFilter.clear;
    if checkDefault then
      pvirtualnode(defaultFilter.Node).CheckState := csCheckedNormal;
    // tags
    Node := FilterTree.getfirst;
    while assigned(Node) do
    begin
      dataTag := FilterTree.GetNodeData(Node);
      if Node.CheckState = csCheckedNormal then
        defaultFilter.FilterParamsChecked :=
          defaultFilter.FilterParamsChecked + [dataTag.e];
      if Node.CheckState = csuncheckedNormal then
        defaultFilter.FilterParamsunChecked :=
          defaultFilter.FilterParamsunChecked + [dataTag.e];
      Node := Node.NextSibling;
    end;
    // spells
    Node := SpellTree.getfirst;
    while assigned(Node) do
    begin
      dataGeneric := SpellTree.GetNodeData(Node);
      if Node.CheckState = csCheckedNormal then
        filternewspell(defaultFilter.spellChecked,
          tspellinfo(dataGeneric.BasicND.p).id);
      if Node.CheckState = csuncheckedNormal then
        filternewspell(defaultFilter.spellunChecked,
          tspellinfo(dataGeneric.BasicND.p).id);
      Node := Node.NextSibling;
    end;
    // events
    Node := EventTree.getfirst;
    while assigned(Node) do
    begin
      dataGeneric := EventTree.GetNodeData(Node);
      if Node.CheckState = csCheckedNormal then
        filternewEvent(defaultFilter.EventChecked,
          tEventType(dataGeneric.BasicND.p).id);
      if Node.CheckState = csuncheckedNormal then
        filternewEvent(defaultFilter.EventUnChecked,
          tEventType(dataGeneric.BasicND.p).id);
      Node := Node.NextSibling;
    end;
  end;

  // mise en place des filtres courants
  setlength(currentfilter, 0);
  Node := CustomFilterTree.getfirst;
  while assigned(Node) do
  begin
    if Node.CheckState = csCheckedNormal then
    begin
      dataGeneric := EventTree.GetNodeData(Node);
      setlength(currentfilter, length(currentfilter) + 1);
      currentfilter[ high(currentfilter)] := dataGeneric.BasicND.p;
    end;
    // si on sort du cap de filtre alors on sort
    if high(currentfilter) = NBMAX_FILTER then
      break;
    Node := Node.NextSibling;
  end;
  for i := 0 to high(currentfilter) do
  begin
    resetFilterState(SpellTree, length(currentfilter[i].spellChecked) = 0, i);
    resetFilterState(EventTree, length(currentfilter[i].EventChecked) = 0, i);
    for j := 0 to high(currentfilter[i].spellChecked) do
      setSpellFilter(currentfilter[i].spellChecked[j].id, i, true);
    for j := 0 to high(currentfilter[i].spellunChecked) do
      setSpellFilter(currentfilter[i].spellunChecked[j].id, i, false);
    for j := 0 to high(currentfilter[i].EventChecked) do
      setEventFilter(currentfilter[i].EventChecked[j], i, true);
    for j := 0 to high(currentfilter[i].EventUnChecked) do
      setEventFilter(currentfilter[i].EventUnChecked[j], i, false);
    Result := Result or currentfilter[i].isValid;
  end;
  // -----------------------

  CustomFilterTree.repaint;
  FilterTree.repaint;
  EventTree.repaint;
  SpellTree.repaint;

  gfx_ResetFilter.enabled := Result;
  paramGraph.keepunitstattreeOffset := true;

  if ListViewTab.Visible and ListBut_AutoRefresh.down then
  begin
    filter.option := [optFullFilter];
    fillTreeEvent(filter);
  end;

  completeRefresh([RefreshStats, RefreshUnitStats, RefreshMap]);
end;

procedure TForm1.SaveFilter;
var
  cf: tfilterdata;
  i: integer;
  freenode, saveerror: boolean;
begin
  saveerror := false;
  // transfert des données du defaultfilter vers customfilter, on verifie que les sorts avec un InGameId invalide ainsi que les event Unknown ne sont pas filtrés
  cf := tfilterdata.initdata(false, CUSTOMFILTERNAME);
  // tag
  cf.FilterParamsChecked := defaultFilter.FilterParamsChecked;
  cf.FilterParamsunChecked := defaultFilter.FilterParamsunChecked;
  // spell
  for i := 0 to high(defaultFilter.spellChecked) do
    if (defaultFilter.spellChecked[i].id >= 0) then
      filternewspell(cf.spellChecked, defaultFilter.spellChecked[i].id)
    else
      saveerror := true;
  for i := 0 to high(defaultFilter.spellunChecked) do
    if (defaultFilter.spellunChecked[i].id >= 0) then
      filternewspell(cf.spellunChecked, defaultFilter.spellunChecked[i].id)
    else
      saveerror := true;
  // event
  for i := 0 to high(defaultFilter.EventChecked) do
    if (defaultFilter.EventChecked[i] < ord( high(eventtype))) then
      // on bannit les unknown
      filternewEvent(cf.EventChecked, defaultFilter.EventChecked[i])
    else
      saveerror := true;
  for i := 0 to high(defaultFilter.EventUnChecked) do
    if (defaultFilter.EventUnChecked[i] < ord( high(eventtype))) then
      // on bannit les unknown
      filternewEvent(cf.EventUnChecked, defaultFilter.EventUnChecked[i])
    else
      saveerror := true;

  freenode := false;
  if (not cf.isValid) or saveerror then
  begin
    showmessage(ERROR_SAVEFILTER);
    freenode := true;
  end
  else
  begin
    if InputQuery(FILTERNAMEREQUEST, '', cf.name) then
      cf.Node := CustomFilterTree.AddChild(nil, TNodeGenericData.create(cf))
    else
      freenode := true;
  end;
  if freenode then
    cf.free;
end;

procedure TForm1.resetFilterState(Sender: TBaseVirtualTree;
  initialstate: boolean; index: integer);
var
  Node: pvirtualnode;
  dataGeneric: ptreeGenericdata;

begin
  Node := Sender.getfirst;
  while assigned(Node) do
  begin
    dataGeneric := Sender.GetNodeData(Node);
    tEventType(dataGeneric.BasicND.p).filtered[index] := initialstate;
    Node := Node.NextSibling;
  end;
end;

function TForm1.IsNodeChecked(Node: pvirtualnode): boolean;
begin
  Result := (Node.CheckState = csCheckedNormal) or
    (Node.CheckState = csCheckedPressed);
end;

procedure TForm1.buildWatchedEvent(watchtype: integer);
var
  i, j: integer;
  Node: pvirtualnode;
  we: twatchedEvent;
begin
  watchtype := watchtype + 1;
  WatchedEventTree.BeginUpdate;
  WatchedEventTree.clear;
  for i := 0 to high(globalnode) do
  begin
    globalnode[i].WatchNode := WatchedEventTree.AddChild(nil,
      TNodeGenericData.create(globalnode[i]));
    WatchedEventTree.NodeHeight[globalnode[i].WatchNode] := 30;
    globalnode[i].watchtype := watchtype;
  end;
  for i := 0 to eventwatchlist[watchtype].count - 1 do
  begin
    we := eventwatchlist[watchtype].items[i];
    Node := WatchedEventTree.AddChild(globalnode[we.noderef].WatchNode,
      TNodeGenericData.create(we));
    for j := 0 to we.l.count - 1 do
      WatchedEventTree.AddChild(Node, TNodeGenericData.create(we.l.items[j]));
    WatchedEventTree.Expanded[Node] := upWatchNodeOpen in we.u.params;
  end;
  for i := 0 to high(globalnode) do
    WatchedEventTree.Expanded[pvirtualnode(globalnode[i].WatchNode)] :=
      globalnode[i].WatchNodeOpen;
  WatchedEventTree.endupdate;
end;

procedure TForm1.setWatchedEventComboBox(oldindex: integer);
var
  i: integer;
  item: TSideBarItem;
begin
  SideBar1.BeginUpdate;
  SideBar1.ItemIndex := -1;
  SideBar1.SubItemIndex := -1;
  SideBar1.items.clear;
  item := SideBar1.items.add;
  item.Caption := 'Overview';
  for i := 1 to high(watchedEvent_STRING) do
    item.items.add(watchedEvent_STRING[i] + parenthese_string
        (inttostr(globalnode[0].eventwatchCount[i]) + ' | ' + inttostr
          (globalnode[1].eventwatchCount[i]) + ' | ' + inttostr
          (globalnode[2].eventwatchCount[i])));
  SideBar1.ItemIndex := 0;
  SideBar1.SubItemIndex := oldindex;
  SideBar1.endupdate;
end;

procedure TForm1.buildUnitStats;
var
  startId, endTime: integer;
  restorecursor: tcursor;
  statopts: scalcStatopts;
begin
  if dontdisturb then
    exit;
  if not assigned(paramGraph.WatchedUnit) then
    exit;
  // --------------------------------
  restorecursor := screen.Cursor;
  screen.Cursor := crHourGlass;
  clearRotationlines;
  case paramGraph.select.state of
    sS_step1:
      begin
        startId := paramGraph.select.startId;
        endTime := GlobalEndLogTime;
      end;
    sS_valid:
      begin
        startId := paramGraph.select.startId;
        endTime := paramGraph.select.endTime;
      end;
  else
    begin
      startId := 0;
      endTime := GlobalEndLogTime;
    end;
  end;

  statopts := [];
  if gfx_ResetFilter.enabled and Stats_UseFilter.down then
    include(statopts, usefilter);
  if paramGraph.unitRef and Stat_UseUnitRef.down then
    include(statopts, usefocus);
  if Stat_OnlyCombat.down then
    include(statopts, incombatonly);
  if Stat_MergeAbsorb.down then
    include(statopts, usehealabsorb);
  if btnFocusMode.down then
    include(statopts, useExclusivemode);
  if Stat_assignAff.down then
    include(statopts, useaffiliation);
  if Stat_absorb.down then
    include(statopts, useabsorbed);
  if Stat_NoEnemyHeal.down then
    include(statopts, noenemyheal);
  if Stat_NoFriendDamage.down then
    include(statopts, noffdamage);

  // test
  if paramGraph.WatchedUnitUseSum then
    include(statopts, useSumStats)
  else
    include(statopts, forcenopet);

  generateRotation(Eventlist, startId, endTime, paramGraph.Rotationlines,
    paramGraph.WatchedUnit, statopts, globalFocusType);

  // building totals
  buildingRotationsTotal(paramGraph.Rotationlines.total[0],
    paramGraph.Rotationlines.eventOut);
  buildingRotationsTotal(paramGraph.Rotationlines.total[1],
    paramGraph.Rotationlines.eventIn);
  // ------------
  paramGraph.Rotationlines.statsunit := paramGraph.WatchedUnit;
  paramGraph.Rotationlines.statlevel := paramGraph.WatchedUnitUseSum;
  fillFocusedStats;
  screen.Cursor := restorecursor;
{$IFDEF DEBUG}
  if DRAWDEBUGREFRESH then
    MemoStat.lines.add(format('U_STAT: %d', [random(100)]));
{$ENDIF DEBUG}
end;

procedure TForm1.fillFocusedStats;
var
  ts: tstringlist;
  restorecursor: tcursor;
begin
  restorecursor := screen.Cursor;
  screen.Cursor := crHourGlass;

  ts := tstringlist.create;
  parsehtmlStats(htmlTemplateIndex, ts, paramGraph.Rotationlines,
    paramGraph.statsmode);
  htmlstats.LoadFromString(ts.Text, '#Stats');
  ts.clear;
  parsehtmlStats(htmlTemplateMenu, ts, paramGraph.Rotationlines,
    paramGraph.statsmode);
  htmlstatsMenu.LoadFromString(ts.Text, '#Menu');
  htmlstatsMenu.height := htmlstatsMenu.FullDisplaySize(htmlstatsMenu.width).cy;
  ts.free;

  fillUnitStats;

  paramGraph.Rotationlines.eventIn.Sort(sortrotationlineslistname);
  paramGraph.Rotationlines.eventOut.Sort(sortrotationlineslistname);
  screen.Cursor := restorecursor;
end;

procedure TForm1.BuildStat(usefilter, usefocus, focusmode, useAbsorb,
  usehealabsorb, excludeself, mergepet, nofriendheal, incombatonly: boolean);
var
  i, k, GlobalTime: integer;
  tmpvalue: int64;
  l: tlist;
  ul: tUnitData;
  Data: ptreeGenericdata;
  Node: pvirtualnode;
begin
  if dontdisturb then
    exit;
  StatusBar1.Panels[2].Text := 'Building Stats...';
  StatusBar1.repaint;
  screen.Cursor := crHourGlass;
  l := tlist.create;

  // clear stats
  WatchedEventTree.clear;
  clearWatchList;

  case paramGraph.select.state of
    sS_step1:
      GlobalTime := BuildStatForPeriod(Eventlist, l, paramGraph.select.startId,
        GlobalEndLogTime, false, usefilter, usefocus, focusmode, useAbsorb,
        usehealabsorb, excludeself, mergepet, nofriendheal, incombatonly,
        globalFocusType);
    sS_valid:
      GlobalTime := BuildStatForPeriod(Eventlist, l, paramGraph.select.startId,
        paramGraph.select.endTime, paramGraph.select.isBlockSelection,
        usefilter, usefocus, focusmode, useAbsorb, usehealabsorb,
        excludeself, mergepet, nofriendheal, incombatonly, globalFocusType);
  else
    GlobalTime := BuildStatForPeriod(Eventlist, l, 0, GlobalEndLogTime, false,
      usefilter, usefocus, focusmode, useAbsorb, usehealabsorb, excludeself,
      mergepet, nofriendheal, incombatonly, globalFocusType);
  end;

  // building stattree
  StatTree.BeginUpdate;
  StatTree.clear;

  /// creation des noeuds globaux
  for i := 0 to high(globalnode) do
  begin
    globalnode[i].statnode := StatTree.AddChild(nil,
      TNodeGenericData.create(globalnode[i]));
    globalnode[i].timeperiod := GlobalTime;
    StatTree.NodeHeight[globalnode[i].statnode] := 30;
  end;

  // summarypass
  for i := 0 to l.count - 1 do
  begin
    ul := l.items[i];
    if not(ul.uGUID.unittype = unitisplayer) then
      ul.stats.sumRefUnit := returnSumUnit(ul, ul.UnitAffiliation);
  end;

  // premiere passe, les units sans affiliation/owner
  for i := 0 to l.count - 1 do
  begin
    ul := l.items[i];
    if ul.UnitAffiliation = nil then
    begin
      // sum
      if ul.stats.sumchild > 0 then
        ul.stats.sumpnode := StatTree.AddChild
          (globalnode[ul.stats.globalnoderef].statnode,
          TNodeGenericData.create(ul));

      if assigned(ul.stats.sumRefUnit) then
      begin
        ul.stats.gpnode := StatTree.AddChild
          (tUnitData(ul.stats.sumRefUnit).stats.sumpnode,
          TNodeGenericData.create(ul));
        globalnode[ul.stats.globalnoderef].addstat(ul);
      end
      else
      begin
        ul.stats.gpnode := StatTree.AddChild
          (globalnode[ul.stats.globalnoderef].statnode,
          TNodeGenericData.create(ul));
        computeStats(ul, ul, true, mergepet);
        globalnode[ul.stats.globalnoderef].addstat(ul);
      end;
    end;
  end;

  // deuxieme passe, les units affiliées
  for i := 0 to l.count - 1 do
  begin
    ul := l.items[i];
    if assigned(ul.UnitAffiliation) then
    begin
      if ul.stats.sumchild > 0 then
        ul.stats.sumpnode := StatTree.AddChild
          (tUnitData(ul.UnitAffiliation).stats.gpnode,
          TNodeGenericData.create(ul));

      if assigned(ul.stats.sumRefUnit) then
      begin
        StatTree.AddChild(tUnitData(ul.stats.sumRefUnit).stats.sumpnode,
          TNodeGenericData.create(ul));
        computeStats(ul, ul.UnitAffiliation, false, mergepet);
        globalnode[ul.stats.globalnoderef].addstat(ul);
        if mergepet then
          include(tUnitData(ul.UnitAffiliation).stats.params,
            statUnitHasAffiliation);
      end;
    end
  end;

  // troisieme pass computing global
  for i := 0 to l.count - 1 do
  begin
    ul := l.items[i];
    for k := 1 to NB_GLOBAL_STAT do
    begin
      tmpvalue := ul.stats.valueSeparate[1][k][1] + ul.stats.valueSeparate[1][k]
        [2];
      globalnode[ul.stats.globalnoderef].globalstats[k].total := globalnode
        [ul.stats.globalnoderef].globalstats[k].total + tmpvalue;
      tmpvalue := ul.stats.valueSeparate[2][k][1] + ul.stats.valueSeparate[2][k]
        [2];
      if tmpvalue > globalnode[ul.stats.globalnoderef].globalstats[k]
        .maxGlobal then
        globalnode[ul.stats.globalnoderef].globalstats[k].maxGlobal := tmpvalue;
      if ul.stats.valueSeparate[2][k][1] > globalnode[ul.stats.globalnoderef]
        .globalstats[k].maxFiltered then
        globalnode[ul.stats.globalnoderef].globalstats[k].maxFiltered :=
          ul.stats.valueSeparate[2][k][1];
    end;
  end;

  // precalculate globalratio
  for i := 0 to high(globalnode) do
    for k := 1 to NB_GLOBAL_STAT do
      globalnode[i].globalstats[k].Ref :=
        (divide(globalnode[i].globalstats[k].maxGlobal,
          globalnode[i].globalstats[k].total) * 100);

  // ----expand node
  Node := StatTree.getfirst;
  while assigned(Node) do
  begin
    Data := StatTree.GetNodeData(Node);
    case StatTree.GetNodeLevel(Node) of
      0:
        StatTree.Expanded[Node] := tglobalnode(Data.BasicND.p).StatNodeOpen;
      1:
        begin
          ul := Data.BasicND.p;
          // add the playerUnit into the pet/aff node
          if pvirtualnode(ul.stats.gpnode).ChildCount > 0 then
            StatTree.AddChild(ul.stats.gpnode, TNodeGenericData.create(ul));
          // ------------
          StatTree.Expanded[Node] := upStatNodeOpen in ul.params;
        end;
      2:
        begin
          ul := Data.BasicND.p;
          StatTree.Expanded[Node] := upStatNodeOpen in ul.params;
        end;
    end;
    Node := StatTree.GetNext(Node);
  end;

  StatTree.endupdate;
  l.free;
  // sorting unittree
  unitTree.Sort(masterNode[1], 0, sdAscending);

  // watched events
  setWatchedEventComboBox(SideBar1.SubItemIndex);
  buildWatchedEvent(SideBar1.SubItemIndex);

  // finalyse
  case paramGraph.select.state of
    sS_step1:
      StatusBar1.Panels[2].Text := 'Time start at: ' + GetRealTimeFromTimeEvent
        (StartTimeStamp, paramGraph.select.startTime, 0);
    sS_valid:
      StatusBar1.Panels[2].Text := 'Time selection: ' + GetRealTimeFromTimeEvent
        (StartTimeStamp, paramGraph.select.startTime, 0) + ' to ' +
        GetRealTimeFromTimeEvent(StartTimeStamp, paramGraph.select.endTime, 0)
        + parenthese_string(paramGraph.select.selectionLabel);
  else
    StatusBar1.Panels[2].Text := 'No time selection. Using complete log.';
  end;

  StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + parenthese_string
    ('CombatTime: ' + GetFormattedLocalTime(GlobalTime, false));
  StatusBar1.repaint;
  paramGraph.forceStatUpdate := false;

  screen.Cursor := crDefault;
{$IFDEF DEBUG}
  if DRAWDEBUGREFRESH then
    MemoStat.lines.add(format('G_STAT: %d', [random(100)]));
{$ENDIF DEBUG}
end;

procedure TForm1.StatTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
  Column: TColumnIndex; TextType: TVSTTextType;

  var CellText: String);
var
  Data: ptreeGenericdata;
  ul: tUnitData;
  gn: tglobalnode;
  i, nodelvl, timeref: integer;
  Value: int64;
begin
  Data := StatTree.GetNodeData(Node);
  nodelvl := Sender.GetNodeLevel(Node);
  if nodelvl = 0 then
  begin
    gn := Data.BasicND.p;
    case Column of
      0:
        CellText := gn.name;
      1 .. 7:
        begin
          Value := gn.globalstats[Column].total;
          // gn.valueseparate[column][1]+gn.valueseparate[column][2];
          if gn.filter then
            CellText := getformattedstatsvalue(gn.valueSeparate[Column][1],
              Value)
          else
            CellText := getformattedstatsvalue(Value);
        end;
      9:
        if gn.valueSeparate[1][1] < high(integer) then
          CellText := intToStrEx(round(divide(gn.valueSeparate[1][1],
                (gn.timeperiod / 100))));
    end;
  end
  else
  begin
    ul := Data.BasicND.p;
    i := STAT_ARRAY_INDEX[nodelvl];
    if (i = 2) and (Node.ChildCount = 0) then
      i := 1;
    if Stat_ShowActDps.down then
      timeref := ul.stats.Activity[i]
    else
      timeref := ul.stats.timeperiod;
    case Column of
      0:
        if i = 2 then
          CellText := getunitname(ul, [getOccurence])
        else
          CellText := getunitname(ul, []);
      1 .. 7:
        begin
          Value := ul.stats.valueSeparate[i][Column][1] + ul.stats.valueSeparate
            [i][Column][2];
          if statUnitIsOnFilter in ul.stats.params then
            CellText := getformattedstatsvalue
              (ul.stats.valueSeparate[i][Column][1], Value)
          else
          begin
            if upWasNpcVsRaid in ul.params then
              CellText := getformattedstatsvalue(Value)
            else
            begin
              if Column = 6 then
                CellText := getformattedstatsvalue(Value)
              else
                CellText := getformattedstatsvalue(Value,
                  globalnode[ul.stats.globalnoderef].globalstats[Column]
                    .total);
            end;
          end;
        end;
      8:
        if (Node <> ul.stats.sumpnode) or (ul.stats.sumchild = 1) then
          CellText := format('%.d%%',
            [floor(divide(ul.stats.Activity[i], ul.stats.timeperiod) * 100)])
        else
          CellText := '*';
      9:
        CellText := intToStrEx(round(divide(ul.stats.valueSeparate[i][1][1],
              (timeref / 100))));
      10:
        CellText := intToStrEx(ul.ilvl);
    end;
  end;
end;

procedure TForm1.StatTreeHeaderClick(Sender: TVTHeader;
  HitInfo: TVTHeaderHitInfo);
begin
  if HitInfo.Button = mbLeft then
  begin
    with Sender, Treeview do
    begin
      if (SortColumn = NoColumn) or (SortColumn <> HitInfo.Column) then
      begin
        SortColumn := HitInfo.Column;
        SortDirection := sdAscending;
        if SortColumn >= 0 then
          if Sender.columns[SortColumn].tag = 14 then
            SortDirection := sdAscending
          else
            SortDirection := sdDescending;
      end
      else if SortDirection = sdAscending then
        SortDirection := sdDescending
      else
        SortDirection := sdAscending;
      SortTree(SortColumn, SortDirection, false);
    end;
  end;
end;

procedure TForm1.StatTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: pvirtualnode; Kind: TVTImageKind; Column: TColumnIndex;

  var Ghosted: boolean;

  var ImageIndex: integer);
var
  Data: ptreeGenericdata;
begin
  if (Column = 0) and (StatTree.GetNodeLevel(Node) > 0) then
  begin
    Data := unitTree.GetNodeData(Node);
    ImageIndex := tUnitData(Data.BasicND.p).stats.iconrole - 1;
  end;
end;

procedure TForm1.StatTreePaintText(Sender: TBaseVirtualTree;

  const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: ptreeGenericdata;
  ul: tUnitData;
  gn: tglobalnode;
  i, nodelvl: integer;
begin
  Data := StatTree.GetNodeData(Node);
  nodelvl := Sender.GetNodeLevel(Node);
  TargetCanvas.font.color := clBlack;
  if nodelvl = 0 then
  begin
    gn := Data.BasicND.p;
    if Column = 0 then
      TargetCanvas.font.Style := [fsBold];
    case Column of
      1 .. 7:
        if gn.valueSeparate[Column][1] = 0 then
          TargetCanvas.font.color := tcolor($E0E0E0);
    end;
  end
  else
  begin
    i := STAT_ARRAY_INDEX[nodelvl];
    if (i = 2) and (Node.ChildCount = 0) then
      i := 1;
    ul := Data.BasicND.p;
    case Column of
      1 .. 7:
        if ul.stats.valueSeparate[i][Column][1] = 0 then
          TargetCanvas.font.color := tcolor($E0E0E0);
    end;
  end;
  if Stat_MergeAbsorb.down and (Column = 7) then
    TargetCanvas.font.Style := TargetCanvas.font.Style + [fsItalic];
end;

procedure TForm1.StatTreeFreeNode(Sender: TBaseVirtualTree; Node: pvirtualnode);
var
  Data: ptreeGenericdata;
begin
  Data := StatTree.GetNodeData(Node);
  Data.BasicND.destroy;
end;

function CompareInt64toInt(Value: int64): integer;
begin
  if Value > 0 then
    Result := 1
  else if Value < 0 then
    Result := -1
  else
    Result := 0;
end;

procedure TForm1.StatTreeCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: pvirtualnode; Column: TColumnIndex; var Result: integer);
var
  data1, data2: ptreeGenericdata;
  ul1, ul2: tUnitData;
  i1, i2, timeref1, timeref2: integer;
  tmpvalue: int64;
begin
  if (Sender.GetNodeLevel(Node1) = 0) or (Sender.GetNodeLevel(Node2) = 0) then
    exit;
  data1 := StatTree.GetNodeData(Node1);
  ul1 := data1.BasicND.p;
  data2 := StatTree.GetNodeData(Node2);
  ul2 := data2.BasicND.p;

  i1 := STAT_ARRAY_INDEX[Sender.GetNodeLevel(Node1)];
  if (i1 = 2) and (Node1.ChildCount = 0) then
    i1 := 1;
  i2 := STAT_ARRAY_INDEX[Sender.GetNodeLevel(Node2)];
  if (i2 = 2) and (Node2.ChildCount = 0) then
    i2 := 1;

  if Stat_ShowActDps.down then
  begin
    timeref1 := ul1.stats.Activity[i1];
    timeref2 := ul2.stats.Activity[i2]
  end
  else
  begin
    timeref1 := ul1.stats.timeperiod;
    timeref2 := ul2.stats.timeperiod;
  end;
  // -----
  if Column in [1 .. 7] then
    tmpvalue := (ul2.stats.valueSeparate[i2][Column][1]
        + ul2.stats.valueSeparate[i2][Column][2]) -
      (ul1.stats.valueSeparate[i1][Column][1] + ul1.stats.valueSeparate[i1]
        [Column][2])
  else
    tmpvalue := 0;
  // -----
  if statUnitIsOnFilter in ul1.stats.params then
    case Column of
      0:
        Result := comparetext(getunitname(ul1, []), getunitname(ul2, []));
      1 .. 7:
        Result := -CompareInt64toInt
          (((ul2.stats.valueSeparate[i2][Column][1]) -
              (ul1.stats.valueSeparate[i1][Column][1]))
            * 10 + tmpvalue div 100);
    end
  else
    case Column of
      0:
        Result := comparetext(getunitname(ul1, []), getunitname(ul2, []));
      1 .. 7:
        Result := -CompareInt64toInt(tmpvalue);
    end;

  case Column of
    8:
      Result := -(round(divide(ul2.stats.Activity[i2],
            ul2.stats.timeperiod) * 100) - round
          (divide(ul1.stats.Activity[i1], ul1.stats.timeperiod) * 100));
    9:
      Result := -(CompareInt64toInt
          (round(divide(ul2.stats.valueSeparate[i2][1][1]
                + ul2.stats.valueSeparate[i2][1][2], (timeref2 / 100))) - round
            (divide(ul1.stats.valueSeparate[i1][1][1] + ul1.stats.valueSeparate
                [i1][1][2], (timeref1 / 100)))));
    10:
      Result := -(ul2.ilvl - ul1.ilvl);
  end;
end;

procedure TForm1.getiteratefocus(Sender: TBaseVirtualTree; Node: pvirtualnode;
  Data: Pointer;

  var Abort: boolean);
var
  nodedata: ptreeGenericdata;
  ul: tUnitData;
begin
  if Node.ChildCount = 0 then
  begin
    nodedata := Sender.GetNodeData(Node);
    ul := nodedata.BasicND.p;
    if upUnitRef in ul.params then
      byte(Data^) := byte(Data^) or 2
    else
      byte(Data^) := byte(Data^) or 1
  end;
end;

procedure TForm1.StatTreeBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect;

  var ContentRect: TRect);

var
  Data: ptreeGenericdata;
  ul: tUnitData;
  x1, x2: double;
  posx, posY: integer;
  i, j, colArray, nodelvl: integer;
  gn: tglobalnode;
  tmpvalue: int64;
  focusstate: byte;
begin
  Data := StatTree.GetNodeData(Node);
  nodelvl := Sender.GetNodeLevel(Node);
  if nodelvl = 0 then
  begin
    gn := Data.BasicND.p;
    if InRange(Column, 0, 7) then
    begin
      case Column of
        0:
          begin
            TargetCanvas.Brush.color := gn.color;
            TargetCanvas.FillRect(CellRect);
          end;
        1 .. 7:
          begin
            posx := (CellRect.right - CellRect.left);
            posY := CellRect.right;
            CellRect.right := CellRect.left + round
              (posx * divide(gn.valueSeparate[Column][1],
                gn.valueSeparate[Column][1] + gn.valueSeparate[Column][2]));
            TargetCanvas.Brush.color := STATSCOLOR[Column][1];
            TargetCanvas.FillRect(CellRect);
            CellRect.left := CellRect.right;
            CellRect.right := posY;
            TargetCanvas.Brush.color := STATSCOLOR[Column][2];
            TargetCanvas.FillRect(CellRect);
          end;
      end;
    end;
  end
  else
  begin
    colArray := nodelvl;
    j := STAT_ARRAY_INDEX[colArray];
    if (j = 2) and (Node.ChildCount = 0) then
      j := 1;
    if colArray > 2 then
      colArray := 2;
    ul := Data.BasicND.p;
    if InRange(Column, 0, 7) then
    begin
      posx := (CellRect.right - CellRect.left);
      posY := CellRect.right;
      x2 := CellRect.left;
      case Column of
        0:
          begin
            inc(CellRect.left);
            CellRect.right := CellRect.left + 5;
            TargetCanvas.Brush.color := ClasseStat[ul.Classe].color;
            TargetCanvas.FillRect(CellRect);

            if Node.ChildCount = 0 then
            begin
              if (upUnitRef in ul.params) then
              begin
                TargetCanvas.Brush.color := UNITFOCUSCOLORTREE[0]
                  [ord(btnFocusMode.down)];
                CellRect.left := CellRect.right;
                CellRect.right := posY;
                TargetCanvas.FillRect(CellRect);
              end;
            end
            else
            begin
              focusstate := 0;
              StatTree.IterateSubtree(Node, getiteratefocus, @focusstate, []);
              if focusstate > 1 then
              begin
                TargetCanvas.Brush.color := UNITFOCUSCOLORTREE[focusstate - 2]
                  [ord(btnFocusMode.down)];
                CellRect.left := CellRect.right;
                CellRect.right := posY;
                TargetCanvas.FillRect(CellRect);
              end;
            end;
          end;
        1 .. 7:
          for i := 1 to 2 do
          begin
            CellRect.left := round(x2);
            tmpvalue := ul.stats.valueSeparate[j][Column][i];
            x1 := (divide(tmpvalue,
                globalnode[ul.stats.globalnoderef].globalstats[Column].total)
                * 100);
            x2 := CellRect.left + x1 * (divide(posx,
                globalnode[ul.stats.globalnoderef].globalstats[Column].Ref));
            CellRect.right := round(x2);
            TargetCanvas.Brush.color := STATSCOLOR[Column]
              [i + (colArray - 1) * 2];
            TargetCanvas.FillRect(CellRect);
          end;
      end;
    end;
  end;
end;

procedure TForm1.StatTreeBeforePaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas);
begin
  StatTreeResizeColumn;
end;

procedure TForm1.StatTreeResizeColumn;
var
  x, i: integer;
begin
  if authStatResize then
  begin
    x := (StatTree.width - 12 - StatTree.Header.columns[0].width -
        (StatTree.Header.columns[8].width + StatTree.Header.columns[9]
          .width + StatTree.Header.columns[10].width)) div (7) - 1;
    for i := 1 to 7 do
      StatTree.Header.columns[i].width := x;
    authStatResize := false;
  end;
end;

procedure TForm1.unitTreeBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect;

  var ContentRect: TRect);
var
  Data: ptreeGenericdata;
  nodechild: pvirtualnode;
  u: tunitinfo;
  ud: tUnitData;
  backupRight: integer;
begin
  inc(CellRect.left);
  inc(CellRect.top);
  backupRight := CellRect.right - 1;

  case unitTree.GetNodeLevel(Node) of
    1:
      begin
        if assigned(masterNode[1]) then
          if Node.Parent = masterNode[1] then
          begin
            nodechild := Node.firstchild;
            if assigned(nodechild) then
            begin
              Data := unitTree.GetNodeData(nodechild);
              CellRect.right := CellRect.left + 5;
              TargetCanvas.Brush.color := ClasseStat[tUnitData(Data.BasicND.p)
                .Classe].color;
              TargetCanvas.FillRect(CellRect);
              CellRect.left := CellRect.right + 1;
            end;
          end;
        // focus
        Data := unitTree.GetNodeData(Node);
        u := Data.BasicND.p;
        if u.focusInList then
        begin
          CellRect.right := backupRight;
          TargetCanvas.Brush.color := UNITFOCUSCOLORTREE[1]
            [ord(btnFocusMode.down)];
          TargetCanvas.FillRect(CellRect);
        end;
      end;
    2:
      begin
        // focus
        Data := unitTree.GetNodeData(Node);
        ud := Data.BasicND.p;
        if (upUnitRef in ud.params) then
        begin
          CellRect.right := backupRight;
          CellRect.left := CellRect.left + integer(unitTree.indent);
          TargetCanvas.Brush.color := UNITFOCUSCOLORTREE[0]
            [ord(btnFocusMode.down)];
          TargetCanvas.FillRect(CellRect);
        end;
      end;
  end;
end;

procedure TForm1.unitTreeChecked(Sender: TBaseVirtualTree; Node: pvirtualnode);
begin
  // player---on valide le noeud enfant ou parent:
  if unitTree.GetNodeLevel(Node) = 2 then
    Node.Parent.CheckState := Node.CheckState
  else if (Node.Parent = masterNode[1]) and assigned(Node.firstchild) then
    Node.firstchild.CheckState := Node.CheckState;
  unitTree.repaint;
  paramGraph.idleEvent_RefreshImage := true;
end;

procedure TForm1.unitTreeChecking(Sender: TBaseVirtualTree; Node: pvirtualnode;

  var NewState: TCheckState;

  var Allowed: boolean);
begin
  Allowed := true;
  if (Node.Parent = masterNode[1]) or (Node.Parent.Parent = masterNode[1]) then
    case Node.CheckState of
      csuncheckedNormal:
        NewState := csCheckedPressed;
      csunCheckedPressed:
        NewState := csCheckedPressed;
      csCheckedNormal:
        NewState := csuncheckedNormal;
      csCheckedPressed:
        NewState := csCheckedNormal;
    end;
end;

procedure TForm1.UncheckAllPlayers1Click(Sender: TObject);
begin
  if assigned(masterNode[1]) then
  begin
    CheckAllNodes(masterNode[1].firstchild, csuncheckedNormal, true);
    unitTree.repaint;
    paramGraph.idleEvent_RefreshImage := true;
  end;
end;

procedure TForm1.ResetPlayerStates1Click(Sender: TObject);
begin
  if assigned(masterNode[1]) then
  begin
    CheckAllNodes(masterNode[1].firstchild, csCheckedPressed, true);
    unitTree.repaint;
    ViewPortRefresh;
  end;
end;

procedure TForm1.FilterTreeGetText(Sender: TBaseVirtualTree;
  Node: pvirtualnode; Column: TColumnIndex; TextType: TVSTTextType;

  var CellText: String);
begin
  CellText := EventParamsData
    [(ord(pFilterDatanode(FilterTree.GetNodeData(Node)).e))].name;
end;

procedure TForm1.FilterTreeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: pvirtualnode;

  var InitialStates: TVirtualNodeInitStates);
begin
  Node.checktype := ctTriStateCheckBox;
end;

procedure TForm1.FilterTreeChecking(Sender: TBaseVirtualTree;
  Node: pvirtualnode;

  var NewState: TCheckState;

  var Allowed: boolean);
begin
  case Node.CheckState of
    csuncheckedNormal:
      NewState := csunCheckedPressed;
    csunCheckedPressed:
      NewState := csCheckedNormal;
    csCheckedNormal:
      NewState := csuncheckedNormal;
  end;
  Allowed := true;
end;

procedure TForm1.FilterTreeChecked(Sender: TBaseVirtualTree;
  Node: pvirtualnode);
begin
  AssignFilterFromtree(true, true);
end;

procedure TForm1.ResetSelection1Click(Sender: TObject);
begin
  CheckAllNodes(FilterTree.getfirst, csunCheckedPressed);
  AssignFilterFromtree(true, true);
end;

procedure TForm1.TimeTreeBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect;

  var ContentRect: TRect);
var
  Data: pTimeDatanode;
begin
  Data := TimeTree.GetNodeData(Node);
  if Data.checkforwipe then
  begin
    if (Data.deathcount <= 0) then
      TargetCanvas.Brush.color := $0055FFCC
    else
      TargetCanvas.Brush.color := $0055CCFF;
  end
  else
    TargetCanvas.Brush.color := $00CCCCCC;

  if Column = 1 then
  begin
    if Node <> paramGraph.select.pnode then
    begin
      dec(CellRect.right, 2);
      inc(CellRect.left, 2);
      dec(CellRect.bottom);
      inc(CellRect.top);
    end;
    TargetCanvas.Brush.color := HMTAG[ord(bossishm in Data.bossopts)];
  end;

  TargetCanvas.FillRect(CellRect);

  if (Column = 0) and (Node = paramGraph.select.pnode) then
  begin
    TargetCanvas.Brush.color := HMTAG[ord(bossishm in Data.bossopts)];
    TargetCanvas.FrameRect(CellRect);
  end;
end;

procedure TForm1.validTimeButton;
begin
  ToolButton17.enabled := not(paramGraph.select.state = sS_empty);
end;

procedure TForm1.TimeTreeFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: pvirtualnode; OldColumn, NewColumn: TColumnIndex;

  var Allowed: boolean);
begin
  if assigned(NewNode) then
    getBossFight(NewNode);
  Allowed := true;
end;

procedure TForm1.TimeTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
  Column: TColumnIndex; TextType: TVSTTextType;

  var CellText: string);
var
  Data: pTimeDatanode;
begin
  Data := TimeTree.GetNodeData(Node);
  case Column of
    0:
      begin
        CellText := GetRealTimeFromTimeEvent(StartTimeStamp,
          Data.startCombattime, 0, toShowDateAndMn) + ': ' + getunitname
          (Data.bossId, []); // +format (' P:%d D:%d ',[data.playercount,data.playerdeathcount]) ;
        CellText := CellText + parenthese_string
          (GetFormattedLocalTime(Data.lastCombattime - Data.startCombattime,
            false));
      end;
    1:
      CellText := inttostr(Data.playercount);
  end;
end;

procedure TForm1.changewatchedUnit(Node: pvirtualnode);
var
  Data: ptreeGenericdata;
  nodechild: pvirtualnode;
begin
  if assigned(Node) then
  begin
    if ListViewTab.Visible then
    begin
      unitTree.repaint; // antifreeze
      unitToEventTree(Node);
    end;
    Data := unitTree.GetNodeData(Node);
    case unitTree.GetNodeLevel(Node) of
      0:
        ;
      1:
        if tunitinfo(Data.BasicND.p).unittype = unitisplayer then
        begin
          nodechild := Node.firstchild;
          if assigned(nodechild) then
          begin
            Data := unitTree.GetNodeData(nodechild);
            paramGraph.WatchedUnit := Data.BasicND.p;
            paramGraph.WatchedUnitUseSum := false;
            completeRefresh([RefreshUnit, RefreshUnitStats,
              RefreshMapOnDetail]);
            if replayTab.visible then
            begin
              replay.selectedUnit:= paramGraph.WatchedUnit;
              imageReplay.changed;
            end;
          end
        end;
      2:
        begin
          paramGraph.WatchedUnit := Data.BasicND.p;
          paramGraph.WatchedUnitUseSum := false;
          completeRefresh([RefreshUnit, RefreshUnitStats, RefreshMapOnDetail]);
          if replayTab.visible then
            begin
              replay.selectedUnit:= paramGraph.WatchedUnit;
              imageReplay.changed;
            end;
        end
    end;


  end;
end;

procedure TForm1.unitTreeFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: pvirtualnode; OldColumn, NewColumn: TColumnIndex;

  var Allowed: boolean);
begin
  changewatchedUnit(NewNode);
  Allowed := true;
end;

procedure TForm1.SpellTreeFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: pvirtualnode; OldColumn, NewColumn: TColumnIndex;

  var Allowed: boolean);
var
  Data: ptreeGenericdata;
  filter: eventFilter;
begin
  Data := SpellTree.GetNodeData(NewNode);
  if ListViewTab.Visible then
  begin
    Sender.repaint;
    filter.option := [optSpellId];
    filter.spellId := tspellinfo(Data.BasicND.p).id;
    fillTreeEvent(filter);
  end;
  Allowed := true;
end;

procedure TForm1.EventTreeFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: pvirtualnode; OldColumn, NewColumn: TColumnIndex;

  var Allowed: boolean);
var
  Data: ptreeGenericdata;
  filter: eventFilter;
begin
  if ListViewTab.Visible then
  begin
    Sender.repaint;
    Data := EventTree.GetNodeData(NewNode);
    filter.option := [optEvent];
    filter.idEvent := tEventType(Data.BasicND.p).id;
    fillTreeEvent(filter);
  end;
  Allowed := true;
end;

procedure TForm1.GfxNoExternalClick(Sender: TObject);
begin
  HidePlayerNotInRaid;
  ViewPortRefresh;
end;

procedure TForm1.GfxNoNpcClick(Sender: TObject);
begin
  ViewPortRefresh;
end;

procedure TForm1.Edit1Change(Sender: TObject);
var
  Data: ptreeGenericdata;
  Node: pvirtualnode;
  strtmp: string;
begin
  strtmp := lowercase(trim(Edit1.Text));
  SpellTree.BeginUpdate;
  Node := SpellTree.getfirst; // on passse au premier child
  while assigned(Node) do
  begin
    Data := SpellTree.GetNodeData(Node);
    if strtmp <> '' then
      SpellTree.IsVisible[Node] := pos(strtmp,
        lowercase(tspellinfo(Data.BasicND.p).name)) > 0
    else
      SpellTree.IsVisible[Node] := true;
    Node := SpellTree.GetNextSibling(Node);
  end;
  SpellTree.endupdate;
end;

procedure TForm1.Edit1Enter(Sender: TObject);
begin
  authKeyDown := false;
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
  authKeyDown := true;
end;

procedure TForm1.StatTreeMouseMove(Sender: TObject; Shift: TShiftState;
  x, y: integer);
var
  Node: pvirtualnode;
  Data: ptreeGenericdata;
  cleanhint: boolean;
  nodelvl, statlvl: integer;
begin
  Node := StatTree.GetNodeAt(x, y);
  cleanhint := true;
  nodelvl := StatTree.GetNodeLevel(Node);
  if assigned(Node) and (nodelvl > 0) then
  begin
    if x < StatTree.Header.columns[0].width then
    begin
      cleanhint := false;
      Data := StatTree.GetNodeData(Node);
      if paramGraph.activeUnitStatNode = Node then
        exit
      else
      begin
        paramGraph.activeUnitStatNode := Node;
        statlvl := STAT_ARRAY_INDEX[nodelvl];
        if (statlvl = 2) and (Node.ChildCount = 0) then
          statlvl := 1;
        DoHint(StatTree, fillHintDataStat(HintStatstemplate, Data.BasicND.p,
            statlvl));
      end;
    end
  end;

  if cleanhint then
  begin
    paramGraph.activeUnitStatNode := nil;
    DoHint(StatTree, '');
  end;
end;

procedure TForm1.FilterTreeFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: pvirtualnode; OldColumn, NewColumn: TColumnIndex;

  var Allowed: boolean);
var
  Data: pFilterDatanode;
  filter: eventFilter;
begin
  if ListViewTab.Visible then
  begin
    Sender.repaint;
    filter.option := [optEventParam];
    Data := Sender.GetNodeData(NewNode);
    filter.param := Data.e;
    fillTreeEvent(filter);
  end;
  Allowed := true;
end;

procedure TForm1.gfxtb1Click(Sender: TObject);
begin
  paramGraph.linetype := linearraytype(TToolButton(Sender).tag - 1);
  completeRefresh([RefreshMap]);
end;

procedure TForm1.relativeRatioClick(Sender: TObject);
begin
  if (paramGraph.linetype <> lineHp) then
    paramGraph.idleEvent_RefreshImage := true;
end;

procedure TForm1.LineOnBGClick(Sender: TObject);
begin
  Imagemap.changed;
end;

procedure TForm1.ListBut_UseSelectionClick(Sender: TObject);
var
  filter: eventFilter;
begin
  filter.option := [optFullFilter];
  if ListBut_AutoRefresh.down then
    fillTreeEvent(filter);
end;

procedure TForm1.ListBut_RefreshClick(Sender: TObject);
var
  filter: eventFilter;
begin
  filter.option := [optFullFilter];
  fillTreeEvent(filter);
end;

procedure TForm1.ButStat_damageTypeClick(Sender: TObject);
begin
  StatTree.repaint;
end;

procedure TForm1.Stat_LaunchStatClick(Sender: TObject);
begin
  completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats]);
end;

procedure TForm1.gfx_ResetFocusClick(Sender: TObject);
begin
  if resetUnitRef then
  begin
    completeRefresh([RefreshStats, RefreshUnitStats, RefreshMap]);
    if ListViewTab.Visible and ListBut_AutoRefresh.down then
      ListBut_RefreshClick(nil);
  end;
end;

procedure TForm1.ToolButton17Click(Sender: TObject);
begin
  if resetTimePeriod then
  begin
    Imagemap.changed;
    if ListViewTab.Visible and ListBut_AutoRefresh.down then
      ListBut_RefreshClick(nil);
  end;
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
var
  i: integer;
begin
  replay.angle := replay.angle + 90;
  if replay.angle = 360 then
    replay.angle := 0;
  for i := 0 to replayPopupRotate.items.count - 1 do
  begin
    if replayPopupRotate.items[i].tag = replay.angle then
    begin
      replayPopupRotate.items[i].checked := true;
      break;
    end;
  end;
  replay.Evaluateratio := true;
  ImageReplay.changed;
end;

procedure TForm1.ToolButton15Click(Sender: TObject);
begin
  authStatResize := true;
  StatTreeResizeColumn;
end;

procedure TForm1.doiteratefocus(Sender: TBaseVirtualTree; Node: pvirtualnode;
  Data: Pointer;

  var Abort: boolean);
var
  nodedata: ptreeGenericdata;
  ul: tUnitData;
begin
  nodedata := Sender.GetNodeData(Node);
  ul := nodedata.BasicND.p;
  if boolean(Data^) then
    ul.params := ul.params - [upUnitRef]
  else
    ul.params := ul.params + [upUnitRef];
end;

procedure TForm1.Stat_SetFocusClick(Sender: TObject);
var
  nodedata: ptreeGenericdata;
  ul: tUnitData;
  focusstate: byte;
  initialstate: boolean;
begin
  if assigned(paramGraph.unittreenode) then
  begin
    nodedata := StatTree.GetNodeData(paramGraph.unittreenode);
    ul := nodedata.BasicND.p;
    initialstate := upUnitRef in ul.params;
    if paramGraph.unittreenode.ChildCount > 0 then
    begin
      focusstate := 0;
      StatTree.IterateSubtree(paramGraph.unittreenode, getiteratefocus,
        @focusstate, []);
      initialstate := focusstate >= 2;
    end
    else
      initialstate := upUnitRef in ul.params;
    StatTree.IterateSubtree(paramGraph.unittreenode, doiteratefocus,
      @initialstate, []);
    paramGraph.unitRef := isUnitRefActive;
    gfx_ResetFocus.enabled := paramGraph.unitRef;
    completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats, RefreshMap]);
  end;
end;

procedure TForm1.CollapseAll1Click(Sender: TObject);
begin
  StatTree.FullCollapse(nil);
end;

procedure TForm1.ExpandAll1Click(Sender: TObject);
begin
  StatTree.FullExpand(nil);
end;

procedure TForm1.ToolButton9Click(Sender: TObject);
begin
  if Edit1.Text <> '' then
    Edit1.Text := ''
  else
    Edit1Change(nil);
end;

procedure TForm1.SpellInfo1Click(Sender: TObject);
begin
  if assigned(paramGraph.focusedSpell) then
    getWebInfoforSpell(paramGraph.focusedSpell);
end;

procedure TForm1.SaveWcrFileButClick(Sender: TObject);
var
  tmpstart: integer;
  wowopen: boolean;
  optRename, optFulllog: boolean;
  optrRenameName, tmpLabel: string;
begin
  ERRORCHECKPOINT := 300;
  wowopen := IsProcessActive(WOW_APPLICATION);
  form5 := tform5.create(self);

  if LiveParsing_validLiveLog then
  begin
    if wowopen then
      form5.Edit1.Text := 'Wow.exe must be closed for this'
    else
    begin
      form5.Edit1.Text := GetRealTimeFromTimeEvent(StartTimeStamp,
        pEvent(Eventlist.items[0]).Time, 0, toShowFilename)
        + '_' + INGAMELOGNAME;
      form5.checkbox1.enabled := true;
      form5.Edit1.enabled := true;
    end;
  end
  else
    form5.Edit1.Text := 'the log is not the livelog';
  if openlogcomment = '' then
    form5.edit2.Text := ENTER_COMMENT
  else
    form5.edit2.Text := openlogcomment;

  if paramGraph.select.state <> sS_empty then
    form5.RadioGroup1.enabled := true;

  if form5.showmodal <> mrOk then
    exit;
  optRename := LiveParsing_validLiveLog and form5.checkbox1.checked;
  optrRenameName := form5.Edit1.Text;
  optFulllog := (form5.RadioGroup1.ItemIndex = 0) or
    (paramGraph.select.state = sS_empty);
  if form5.edit2.Text = ENTER_COMMENT then
    openlogcomment := ''
  else
    openlogcomment := form5.edit2.Text;

  form5.free;
  tmpstart := pEvent(Eventlist.items[0]).Time;
  tmpLabel := '';
  if not optFulllog then
    case paramGraph.select.state of
      sS_step1, sS_valid:
        begin
          tmpstart := paramGraph.select.startTime - WCRFILE_TIMEBORDER;
          if tmpstart < 0 then
            tmpstart := 0;
          tmpLabel := '_' + paramGraph.select.selectionLabel
        end;
    end;

  SaveDialog1.CleanupInstance;
  SaveDialog1.initialdir := logpath;
  SaveDialog1.DefaultExt := '*.wcr';
  SaveDialog1.filter := 'WcrLog (*.wcr) | *.wcr';
  SaveDialog1.Options := [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing];
  SaveDialog1.filename := GetRealTimeFromTimeEvent(StartTimeStamp, tmpstart, 0,
    toShowFilename) + tmpLabel;

  if SaveDialog1.filename = '' then
    SaveDialog1.filename := '*' + WCRFILE_SUFFIX
  else
    SaveDialog1.filename := SaveDialog1.filename + WCRFILE_SUFFIX;

  SaveDialog1.filename := stringreplace(SaveDialog1.filename, ' ', '_',
    [rfReplaceall]);

  if SaveDialog1.Execute then
  begin
    Application.ProcessMessages;
    saveWcrLog(SaveDialog1.filename, openlogcomment, optFulllog);
    logpath := ExtractFilePath(SaveDialog1.filename);
    if optRename then
      renameLiveLog(optrRenameName);
    generateLogIndex(0, false, prefs.useCache);
  end;
end;

procedure TForm1.renameLiveLog(optRenameName: string);
var
  f: file;
  i: integer;
const
  FORBIDDENFILECHAR: array [0 .. 8] of char = ('"', '/', '\', '*', '?', '<',
    '>', '|', ':');
begin
  optRenameName := stringreplace(optRenameName, ' ', '_', [rfReplaceall]);
  for i := 0 to high(FORBIDDENFILECHAR) do
    optRenameName := stringreplace(optRenameName, FORBIDDENFILECHAR[i], '',
      [rfReplaceall]);
  try
    AssignFile(f, livelogFile);
    Rename(f, ExtractFilePath(livelogFile) + '\' + optRenameName);
    // stop liveparsing:
    LiveParsing_Fic := '';
    LiveUpdateCheckClick(nil);
    LiveUpdateCheck.enabled := false;
    LiveUpdateUpdate.enabled := false;
    LiveParsing_validLiveLog := false;
  except
    on e: Exception do
      showmessage('Error while renaming ' + INGAMELOGNAME + #13 +
          'Can''t access file or file not found');
  end;
end;

procedure TForm1.saveWcrLog(filename, commentstr: string; useFullLog: boolean);
  Procedure validateUnitsave(ul: tUnitData);
  var
    u: tunitinfo;
  begin
    if assigned(ul) then
    begin
      ul.willBeSaved := true;
      u := getunitinfo(ul.uGUID);
      if assigned(u) then
        u.willBeSaved := 1;
      if assigned(ul.UnitAffiliation) then
        validateUnitsave(ul.UnitAffiliation);
      // traitement recursif des affiliations
    end;
  end;

  Procedure CountUnitsave(u: tunitinfo;

    var uc, ulc: integer);
  var
    j: integer;
    localcount: integer;
  begin
    localcount := 0;
    for j := 0 to u.list.count - 1 do
      if tUnitData(u.list.items[j]).willBeSaved then
        inc(localcount);
    u.willBeSaved := localcount;
    ulc := ulc + localcount;
    if u.willBeSaved > 0 then
      inc(uc);
  end;

  function getUSaveData(u: tunitinfo): unitinfosave;
  begin
    Result.name := UTF8EncodeToShortString(u.name);
    Result.mobId := u.mobId;
    Result.GUID := u.GUID;
    Result.unittype := u.unittype;
    Result.params := u.params;
  end;

  function getUlSaveData(ul: tUnitData): unitlistsave;
  begin
    Result.uGUID := ul.uGUID;
    Result.internalId := ul.internalId;
    Result.params := ul.params;
    if assigned(ul.UnitAffiliation) then
      Result.UnitAffiliationid := tUnitData(ul.UnitAffiliation).internalId
    else
      Result.UnitAffiliationid := 0;
  end;

  procedure validSpellToSave(sv: integer; var sct: integer);
  var
    sp: tspellinfo;
  begin
    sp := getSpellFromID(sv);
    if assigned(sp) then
    begin
      if not sp.willBeSaved then
        inc(sct);
      sp.willBeSaved := true;
    end;
  end;

var
  p: pEvent;
  pc: pChatEvent;
  i, j, k: integer;
  es: eventsave;
  sp: tspellinfo;
  eis: eventInfoSave52;
  eis2: eventInfoSave54;
  eis3: eventInfoSave60;
  exu: integer;
  ss: spellsave;
  us: unitinfosave;
  uls: unitlistsave;
  sme: rsavemarkevent;
  u: tunitinfo;
  f: tmemorystream;
  taitmp: byte;
  taistr: Word;
  arraysize, eventcount, ucount, ulcount, scount, ccount, ceventcount,
    mtotcount, cbossSize: integer;
  mcount: array [1 .. high(markedlist)] of integer;
  SavestartId, SaveStarttime, SaveEndtime: integer;
  Node: pvirtualnode;
  Data: ptreeGenericdata;
  data2: pTimeDatanode;
  c: rWcrContent;
  found: boolean;
  ContentIndex: integer;
  pm: pmarkevent;
  tmpint: integer;
  strtmpraw: ansistring;
  pB: pBossInfoLog;
begin
  // securité
  if Eventlist.count = 0 then
    exit;

  ERRORCHECKPOINT := 301;
  SavestartId := 0;
  SaveStarttime := 0;
  ContentIndex := 0;
  SaveEndtime := GlobalEndLogTime;
  FillChar(c, SizeOf(c), 0);
  if not useFullLog then
    case paramGraph.select.state of
      sS_step1:
        begin
          SaveStarttime := paramGraph.select.startTime - WCRFILE_TIMEBORDER;
          SavestartId := getIdFromTime(paramGraph.select.startId,
            SaveStarttime, false);
          SaveEndtime := GlobalEndLogTime;
        end;
      sS_valid:
        begin
          SaveStarttime := paramGraph.select.startTime - WCRFILE_TIMEBORDER;
          SavestartId := getIdFromTime(paramGraph.select.startId,
            SaveStarttime, false);
          SaveEndtime := paramGraph.select.endTime + WCRFILE_TIMEBORDER;
        end;
    end;
  if SaveStarttime < 0 then
    SaveStarttime := 0;

  screen.Cursor := crHourGlass;
  StatusBar1.Panels[2].Text := 'Compiling datas, please wait...';
  StatusBar1.repaint;
  // preparation de la liste des unités et spells
  for i := 0 to unitList.count - 1 do
    tunitinfo(unitList.items[i]).clearSaveValidation;
  for i := 0 to spellArray.count - 1 do
    if assigned(spellArray[i]) then
      tspellinfo(spellArray[i]).willBeSaved := false;
  // size estimate
  arraysize := 0;
  eventcount := 0;
  ucount := 0;
  ulcount := 0;
  scount := 0;
  FillChar(mcount, SizeOf(mcount), 0);
  mtotcount := 0;
  for i := SavestartId to Eventlist.count - 1 do
  begin
    p := Eventlist.items[i];

    if p.Time > SaveEndtime then
      break;
    if p.event = event_UNKNOWN then
      continue;
    // estimation de la taille du flux
    arraysize := arraysize + ( high(p.statsarray) + 1) * 4 + 1;
    inc(eventcount);
    // validation des unités
    validateUnitsave(p.sourceUnit);
    validateUnitsave(p.destUnit);
    // 52
    validateUnitsave(p.eInfo.u);
    // 6.0.2
    validateUnitsave(p.extraUnit);

    validSpellToSave(p.spell.id, scount); // sv:integer;var sct:integer);
    validSpellToSave(p.eventStat.extraspellId, scount);
    // sv:integer;var sct:integer);
  end;
  // compte des unitinfo/unitlist
  for i := 0 to unitList.count - 1 do
    CountUnitsave(unitList.items[i], ucount, ulcount);
  // chat
  ccount := 4;
  ceventcount := 0;

  Node := ChatTree.getfirst;
  while assigned(Node) do
  begin
    Data := ChatTree.GetNodeData(Node);
    pc := Data.BasicND.p;
    if (pc.Time >= SaveStarttime) and (pc.Time <= SaveEndtime) then
    begin
      strtmpraw := UTF8EncodeToShortString(pc.s);
      ccount := ccount + length(strtmpraw) + 2 + 4;
      inc(ceventcount);
    end;
    Node := Node.NextSibling;
  end;

  // encounter
  cbossSize := 4;
  for i := 0 to bossinfoList.count - 1 do
  begin
    pB := bossinfoList[i];
    strtmpraw := UTF8EncodeToShortString(pB.name);
    cbossSize := cbossSize + length(strtmpraw) + 2 + 4;
  end;

  // --markedlist
  for i := low(markedlist) to high(markedlist) do
    for j := 0 to markedlist[i].count - 1 do
    begin
      pm := markedlist[i].items[j];
      if pm.u.willBeSaved and (pm.startTime >= SaveStarttime) and
        (pm.endTime <= SaveEndtime) then
      begin
        inc(mcount[i]);
        inc(mtotcount);
      end;
    end;

  // size global
  arraysize := arraysize + eventcount * (SizeOf(eventsave)) + eventcount *
    (SizeOf(exu)) + eventcount * (SizeOf(eis)) + eventcount * (SizeOf(eis2))
    + eventcount * (SizeOf(eis3)) + ucount * (SizeOf(unitinfosave) + 4)
    + ulcount * SizeOf(unitlistsave) + scount * SizeOf(spellsave)
    + ccount + cbossSize + mtotcount * SizeOf(rsavemarkevent) + high
    (markedlist) * 4 + 4 + 32;

  // Sauvegarde
  f := tmemorystream.create;
  try
    f.SetSize(arraysize);
    ProgressBar1.min := 0;
    ProgressBar1.max := eventcount + (eventcount div 5);
    // on rajoute 20% pour le feedback du packing
    // startTime
    f.Write(StartTimeStamp, SizeOf(StartTimeStamp));
    // spellsave:
    f.Write(scount, SizeOf(scount));
    for i := 0 to spellArray.count - 1 do
    begin
      sp := spellArray[i];
      if assigned(sp) and sp.willBeSaved then
      begin
        ss.name := UTF8EncodeToShortString(sp.name);
        ss.inGameId := integer(0); // dummy
        ss.id := sp.id;
        ss.school := sp.school;
        ss.sdata := sp.sdata;
        f.Write(ss, SizeOf(ss));
      end;
    end;
    // unitinfo-UnitList
    f.Write(ucount, SizeOf(ucount));
    for i := 0 to unitList.count - 1 do
      if tunitinfo(unitList[i]).willBeSaved > 0 then
      begin
        u := unitList[i];
        // content
        if (u.unittype = unitisplayer) and (upWasInRaid in u.params) then
        begin
          if ContentIndex <= high(c.playerlist) then
            c.playerlist[ContentIndex] := UTF8EncodeToShortString(u.name);
          inc(ContentIndex);
        end;
        // ---------------------
        us := getUSaveData(u);
        f.Write(us, SizeOf(us));
        // nb unitlist
        f.Write(u.willBeSaved, SizeOf(integer));
        // write related Ulist
        for j := 0 to u.list.count - 1 do
        begin
          if tUnitData(u.list[j]).willBeSaved then
          begin
            uls := getUlSaveData(u.list[j]);
            f.Write(uls, SizeOf(uls));
          end;
        end
      end;
    // events
    f.Write(eventcount, SizeOf(eventcount));
    eventcount := 0;
    for i := SavestartId to Eventlist.count - 1 do
    begin
      inc(eventcount);
      if eventcount mod APPLICATIONREFRESH = 0 then
      begin
        ProgressBar1.Position := i;
        ProgressBar1.repaint;
      end;
      p := Eventlist.items[i];
      // ----------------

      if p.Time > SaveEndtime then
        break;
      if p.event = event_UNKNOWN then
        continue;

      es.Time := p.Time;
      // --unit
      if assigned(p.sourceUnit) then
        es.sourceUnit := p.sourceUnit.internalId
      else
        es.sourceUnit := 0;
      if assigned(p.destUnit) then
        es.destUnit := p.destUnit.internalId
      else
        es.destUnit := 0;
      // 6.0.2  extraUnit
      if assigned(p.extraUnit) then
        exu := p.extraUnit.internalId
      else
        exu := 0;
      // 5.2
      if assigned(p.eInfo.u) then
      begin
        eis[0] := p.eInfo.u.internalId;
        for k := 1 to 5 do
          eis[k] := p.eInfo.Data[k];
        // 5.4
        for k := 1 to 2 do
          eis2[k] := p.eInfoPos.Data[k];
        // 6.0.2
        for k := 1 to 4 do
          eis3[k] := p.eInfo.data2[k];
      end
      else
      begin
        FillChar(eis, SizeOf(eis), 0);
        FillChar(eis2, SizeOf(eis2), 0);
        FillChar(eis3, SizeOf(eis3), 0);
      end;
      // 6.0.2

      // -------------
      es.spellId := p.spell.id;
      es.params := p.params - [eventCastWillSuccess .. eventIsObsolete6];
      // cleaning dev params
      es.event := p.event;
      f.Write(es, SizeOf(es));
      f.Write(exu, SizeOf(exu)); // 6.0.2 extraunit
      f.Write(eis, SizeOf(eis)); // 5.2
      f.Write(eis2, SizeOf(eis2)); // 5.4
      f.Write(eis3, SizeOf(eis3)); // 6.0.2 extradata
      taitmp := high(p.statsarray) + 1;
      f.write(taitmp, SizeOf(taitmp));
      for j := 0 to high(p.statsarray) do
        f.write(p.statsarray[j], SizeOf(p.statsarray[j]));
    end;
    // chat
    f.Write(ceventcount, SizeOf(ceventcount));
    Node := ChatTree.getfirst;
    while assigned(Node) do
    begin
      Data := ChatTree.GetNodeData(Node);
      pc := Data.BasicND.p;
      if (pc.Time >= SaveStarttime) and (pc.Time <= SaveEndtime) then
      begin
        f.write(pc.Time, 4);
        strtmpraw := UTF8EncodeToShortString(pc.s);
        taistr := length(strtmpraw);
        f.write(taistr, 2);
        f.write(PansiChar(strtmpraw)^, taistr);
      end;
      Node := Node.NextSibling;
    end;

    // encounterlist
    f.Write(bossinfoList.count, SizeOf(bossinfoList.count));
    for i := 0 to bossinfoList.count - 1 do
    begin
      pB := bossinfoList[i];
      strtmpraw := UTF8EncodeToShortString(pB.name);
      taistr := length(strtmpraw);
      f.write(pB.id, 4);
      f.write(taistr, 2);
      f.write(PansiChar(strtmpraw)^, taistr);
    end;

    // --markedlist
    tmpint := high(markedlist);
    f.Write(tmpint, SizeOf(tmpint));
    for i := 1 to high(markedlist) do
    begin
      f.Write(mcount[i], SizeOf(mcount[i]));
      for j := 0 to markedlist[i].count - 1 do
      begin
        pm := markedlist[i].items[j];
        if pm.u.willBeSaved and (pm.startTime >= SaveStarttime) and
          (pm.endTime <= SaveEndtime) then
        begin
          sme.uid := pm.u.internalId;
          sme.startTime := pm.startTime;
          sme.endTime := pm.endTime;
          f.Write(sme, SizeOf(sme));
        end;
      end;
    end;

    // final
    StatusBar1.Panels[2].Text := 'Packing datas, please wait...';
    StatusBar1.repaint;
    // sauvegarde
    ContentIndex := 0;
    // compute bosslist
    Node := TimeTree.getfirst;
    while assigned(Node) do
    begin
      data2 := TimeTree.GetNodeData(Node);
      if (SaveStarttime < data2.startCombattime) and
        (SaveEndtime > data2.lastCombattime) then
      begin
        found := false;
        for i := low(c.bosslist) to high(c.bosslist) do
        begin
          if (c.bosslist[i].bossId = data2.bossId) and
            (c.bosslist[i].bossopts = data2.bossopts) then
          begin
            inc(c.bosslist[i].bosstry);
            if data2.deathcount = 0 then
              include(c.bosslist[i].bossopt2s, bossisdown);
            found := true;
            break;
          end;
        end;
        if not found then
        begin
          c.bosslist[ContentIndex].bossId := data2.bossId;
          c.bosslist[ContentIndex].bossopts := data2.bossopts;
          if data2.deathcount = 0 then
            include(c.bosslist[ContentIndex].bossopt2s, bossisdown);
          inc(c.bosslist[ContentIndex].bosstry);
          inc(ContentIndex);
          if ContentIndex > high(c.bosslist) then
            break;
        end;
      end;
      Node := Node.NextSibling;
    end;
    c.comment := UTF8EncodeToShortString(commentstr); ;
    // adjust logdate on first event.
    if SaveStarttime = 0 then
      SaveStarttime := pEvent(Eventlist.items[0]).Time;
    c.startTime := AddLocalTimeToBaseTime(StartTimeStamp, SaveStarttime);
    c.newlogArrayIndex := ord(openlogarrayIndex);
    // new spell array = $2ffff,  old was $1ffff
    c.utf8Tag := 1;
    compresse_zlib(f, filename, c);
    ProgressBar1.Position := ProgressBar1.max;
    ProgressBar1.repaint;
    screen.Cursor := crDefault;
    StatusBar1.Panels[2].Text := '';
    StatusBar1.repaint;
  finally
    f.free;
  end;
end;

function TForm1.unpackwcrlog(filename: string; f: tmemorystream): byte;
var
  fileheader: cardinal;
  InputStream: TfileStream;
  rwc: rWcrContent;
begin
  ERRORCHECKPOINT := 302;
  openlogUtf8 := false;
  Result := 0;
  InputStream := TfileStream.create(filename, fmOpenRead);
  try
    try
      InputStream.read(fileheader, SizeOf(fileheader));
      if (fileheader >= WCRFILE_HEADERV1) and (fileheader <= WCRFILE_HEADER)
        then
      begin
        FillChar(rwc, SizeOf(rwc), 0);
        if (fileheader >= WCRFILE_HEADERV2) and (fileheader <= WCRFILE_HEADER)
          then
          InputStream.read(rwc, SizeOf(rwc));
        if maxspellarrayid >= $1FFFF then
          authsavespellarray := rwc.newlogArrayIndex = 1;
        openlogarrayIndex := rwc.newlogArrayIndex = 1;
        openlogUtf8 := rwc.utf8Tag = 1;
        openlogcomment := Utf8conditional(rwc.comment, openlogUtf8);

        ProgressBar1.Position := 10;
        ProgressBar1.repaint;
        StatusBar1.Panels[2].Text := 'Unpacking datas...';
        StatusBar1.repaint;
        if decompresse_zlib(f, InputStream, fileheader <= WCRFILE_HEADERV1) then
          Result := byte(fileheader shr 24);
        ProgressBar1.Position := 50;
        ProgressBar1.repaint;
      end;
    except
    end;
  finally
    InputStream.free;
  end;
end;

procedure TForm1.fixCompatibility(p: pEvent);
begin
  // compatibility backward
  if (p.spell.id = 0) and (eventIsAutoAttack in p.params) then
    p.spell := getSpellFromID(6);
  p.internalParams := eventValue[ord(p.event)].internalParams;
  if eventIsOverDamage in p.params then
    exclude(p.internalParams, eventInternalIsValidforRez);
end;

function TForm1.Loadwcrlog(filename: string): boolean;
var
  f: tmemorystream;
  Value, value2: integer;
  versioning: byte;
  i, j, l: integer;
  es: eventsave;
  eis: eventInfoSave52;
  eis2: eventInfoSave54;
  eis3: eventInfoSave60;
  exu: integer;
  ss: spellsave;
  us: unitinfosave;
  uls: unitlistsave;
  sme: rsavemarkevent;
  pm: pmarkevent;
  tai: byte;
  taistr: Word;
  strtmpraw: ansistring;
  p: pEvent;
  ug: ParsedGUID;
  tmparray: array of tUnitData;
  timefin, timedebut: dword;
  index: integer;
  sp: tspellinfo;
  pB: pBossInfoLog;
  function cleanparams(params: unitParams): unitParams;
  begin
    Result := params - [upWasFriend, upWasNpcVsRaid, upStatNodeOpen,
      upWatchNodeOpen];
  end;

begin
  ERRORCHECKPOINT := 200;
  Result := false;
  timedebut := GetTickCount;
  ProgressBar1.max := 100;
  ProgressBar1.Position := 0;

  f := tmemorystream.create;
  try
    versioning := unpackwcrlog(filename, f);
    if versioning > 0 then
    begin
      StatusBar1.Panels[2].Text := 'Loading, please wait...';
      StatusBar1.repaint;
      setlength(tmparray, 4096);

      // timestamp
      f.read(StartTimeStamp, SizeOf(StartTimeStamp));
      // spell
      f.read(Value, SizeOf(Value));
      for i := 1 to Value do
      begin
        f.read(ss, SizeOf(ss));
        if (ss.id >= 0) then
        begin
          if (SpellIdMax < ss.id) and (ss.id < SECUNDARY_SPELL_INDEX) then
            SpellIdMax := ss.id;

          // todo, should be already sorted.
          dummySpellInfo.id := ss.id;
          if not FastListSearch(spellArray, compareSpellID, dummySpellInfo,
            index) then
          begin
            sp := tspellinfo.initdata(ss.id, 1,
              Utf8conditional(ss.name, openlogUtf8), emptySpellParam);
            spellArray.Insert(index, sp)
          end
          else
            sp := spellArray[index];

          if sp.count = 0 then
          begin
            sp.name := Utf8conditional(ss.name, openlogUtf8);
            inc(sp.count)
          end;

          if ss.id = 6 then
            sp.school := 1 // backward compat.
          else
            sp.school := ss.school;
          sp.sdata := ss.sdata;

        end;
      end;

      // units
      f.read(Value, SizeOf(Value));
      for i := 1 to Value do
      begin
        f.read(us, SizeOf(us));
        ug.flags := 0;
        ug.id.unittype := us.unittype;
        ug.id.mobId := us.mobId;
        ug.id.GUID := us.GUID;
        us.params := cleanparams(us.params); // cleanup;
        assignUnitInfos(Utf8conditional(us.name, openlogUtf8), ug, us.params);
        // unitlist
        f.read(Value, SizeOf(Value));
        for j := 1 to Value do
        begin
          f.read(uls, SizeOf(uls));
          ug.id.mobId := uls.uGUID.mobId;
          ug.id.GUID := uls.uGUID.GUID;
          // table de reference pour assignation aux pEvent
          // on agrandi la table au besoin
          if uls.internalId > high(tmparray) then
            setlength(tmparray, uls.internalId + 4096);
          // --------------------------------------
          tmparray[uls.internalId] := addNewUnittoList(ug);
          tmparray[uls.internalId].params := cleanparams(uls.params);
          tmparray[uls.internalId].internalId := uls.internalId;
          tmparray[uls.internalId].internalIdAff := uls.UnitAffiliationid;
          // eventuel sauvegarde du focus
          if upUnitRef in tmparray[uls.internalId].params then
            paramGraph.unitRef := true;
        end;
      end;

      // affiliation:
      for i := 0 to high(tmparray) do
        if assigned(tmparray[i]) and (tmparray[i].internalIdAff > 0) then
        begin
          if tmparray[i].uGUID.unittype = unitIsPet then
            getunitinfo(tmparray[i]).UnitAffiliation := tmparray
              [tmparray[i].internalIdAff];
          tmparray[i].UnitAffiliation := tmparray[tmparray[i].internalIdAff];
        end;

      // event
      Value := 0;
      exu := 0;
      FillChar(eis, SizeOf(eis), 0);
      FillChar(eis2, SizeOf(eis2), 0);
      FillChar(eis3, SizeOf(eis3), 0);
      f.read(Value, SizeOf(Value));

      for i := 1 to Value do
      begin
        f.read(es, SizeOf(es));
        if versioning > 5 then // wow6.0.2 extraunit
          f.read(exu, SizeOf(exu));
        if versioning > 3 then // wow5.2
          f.read(eis, SizeOf(eis));
        if versioning > 4 then // wow5.2
          f.read(eis2, SizeOf(eis2));
        if versioning > 5 then // wow6.0.2
          f.read(eis3, SizeOf(eis3));

        f.read(tai, SizeOf(tai));
        p := pEvent.create;
        p.Time := es.Time;
        if es.sourceUnit > 0 then
          p.sourceUnit := tmparray[es.sourceUnit]
        else
          p.sourceUnit := nil;
        if es.destUnit > 0 then
          p.destUnit := tmparray[es.destUnit]
        else
          p.destUnit := nil;

        // assign Spell
        p.spell := getSpellFromID(es.spellId);
        inc(p.spell.count);

        // ---------5.2
        p.eInfo.u := nil;
        // 6.0.2 extraunit
        if es.sourceUnit > 0 then
          p.extraUnit := tmparray[exu]
        else
          p.extraUnit := nil;

        // data 5.2
        if eis[0] <> 0 then
        begin
          AuthUse52Log := true;
          p.eInfo.u := tmparray[eis[0]];
        end
        else
          p.eInfo.u := nil;
        // data 5.2
        for l := 1 to 5 do
          p.eInfo.Data[l] := eis[l];
        // pos 5.4.2
        for l := 1 to 2 do
          p.eInfoPos.Data[l] := eis2[l];
        if eis2[1] <> 0 then
          AuthUse54Log := true;
        // data 6.0.2
        for l := 1 to 4 do
          p.eInfo.data2[l] := eis3[l];
{$IFDEF DEBUG}
        if maxPowerValue < p.eInfo.Data[4] then
          maxPowerValue := p.eInfo.Data[4]; // test maxpower
{$ENDIF}
        // ------------
        p.params := es.params;
        p.event := es.event;
        // reset statarray;
        // fillchar(p.statsarray,sizeof(p.statsarray),0);
        for j := 0 to tai - 1 do
        begin
          f.read(value2, SizeOf(value2));
          p.statsarray[j] := value2;
        end;
        getEventlist(p);
        { ---------------------- }
        fixCompatibility(p);
        { ---------------------- }
        Eventlist.add(p);
      end;

      // chat
      Value := 0;
      f.read(Value, SizeOf(Value));
      for i := 1 to Value do
      begin
        f.Read(value2, 4);
        f.Read(taistr, 2);
        setlength(strtmpraw, taistr);
        f.Read(PansiChar(strtmpraw)^, taistr);
        ChatTree.AddChild(nil,
          TNodeGenericData.create(pChatEvent.initdata
              (Utf8conditional(strtmpraw, openlogUtf8), value2)));
      end;

      // encounter
      if versioning > 4 then
      begin
        Value := 0;
        f.read(Value, SizeOf(Value));
        for i := 1 to Value do
        begin
          f.Read(value2, 4);
          f.Read(taistr, 2);
          setlength(strtmpraw, taistr);
          f.Read(PansiChar(strtmpraw)^, taistr);
          new(pB);
          pB.id := value2;
          pB.name := utf8tostring(strtmpraw);
          bossinfoList.add(pB);
        end;
      end;

      // --markedlist
      Value := 0;
      f.read(Value, SizeOf(Value));
      for i := 1 to Value do
      begin
        value2 := 0;
        f.read(value2, SizeOf(value2));
        for j := 1 to value2 do
        begin
          f.read(sme, SizeOf(sme));
          new(pm);
          markedlist[i].add(pm);
          pm.startTime := sme.startTime;
          pm.endTime := sme.endTime;
          pm.u := tmparray[sme.uid];
        end;
      end;

      // eyecandi
      ProgressBar1.Position := 100;
      ProgressBar1.repaint;
      Result := true;
    end
    else
      showmessage(
        'this log has a newer format: you need to upgrade WowCardioRaid');
    // cleaning
  finally
    // ------------------
    timefin := GetTickCount;
    LiveParsing_TotalTime := LiveParsing_TotalTime + (timefin - timedebut);
    setlength(tmparray, 0);
    f.free;
  end;
end;

procedure TForm1.SaveFilter1Click(Sender: TObject);
begin
  SaveFilter;
end;

procedure TForm1.CustomFilterTreeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: pvirtualnode;

  var InitialStates: TVirtualNodeInitStates);
begin
  Node.checktype := ctCheckBox;

end;

procedure TForm1.CustomFilterTreeFreeNode(Sender: TBaseVirtualTree;
  Node: pvirtualnode);
var
  Data: ptreeGenericdata;
begin
  Data := CustomFilterTree.GetNodeData(Node);
  tfilterdata(Data.BasicND.p).destroy;
  Data.BasicND.destroy;
end;

procedure TForm1.CustomFilterTreeGetText(Sender: TBaseVirtualTree;
  Node: pvirtualnode; Column: TColumnIndex; TextType: TVSTTextType;

  var CellText: string);
var
  Data: ptreeGenericdata;
begin
  Data := CustomFilterTree.GetNodeData(Node);
  CellText := tfilterdata(Data.BasicND.p).name;
end;

procedure TForm1.CustomFilterTreeMouseMove(Sender: TObject; Shift: TShiftState;
  x, y: integer);
var
  Node: pvirtualnode;
  Data: ptreeGenericdata;
begin
  Node := CustomFilterTree.GetNodeAt(x, y);
  if assigned(Node) then
  begin
    Data := CustomFilterTree.GetNodeData(Node);
    if paramGraph.activeFilter = Data.BasicND.p then
      exit
    else
    begin
      paramGraph.activeFilter := Data.BasicND.p;
      DoHint(CustomFilterTree, tfilterdata(Data.BasicND.p).extracttext);
    end;
  end
  else
  begin
    paramGraph.activeFilter := nil;
    DoHint(CustomFilterTree, '');
  end;
end;

procedure TForm1.Panel7MouseMove(Sender: TObject; Shift: TShiftState;
  x, y: integer);
begin
  // reset filterhint
  paramGraph.activeFilter := nil;
end;

procedure TForm1.TimeTreeMouseMove(Sender: TObject; Shift: TShiftState;
  x, y: integer);
begin
  // reset filterhint
  paramGraph.activeFilter := nil;
end;

procedure TForm1.CustomFilterTreeChecked(Sender: TBaseVirtualTree;
  Node: pvirtualnode);
begin
  AssignFilterFromtree(false, false);
end;

procedure TForm1.gfx_ResetFilterClick(Sender: TObject);
begin
  resetSpellEventselection;
end;

procedure TForm1.ResetFilter1Click(Sender: TObject);
begin
  resetSpellEventselection;
end;

procedure TForm1.Resetfullfilter1Click(Sender: TObject);
begin
  resetSpellEventselection;
end;

procedure TForm1.Resetfullfilter2Click(Sender: TObject);
begin
  resetSpellEventselection;
end;

procedure TForm1.ResetFullFilter3Click(Sender: TObject);
begin
  resetSpellEventselection
end;

procedure TForm1.PopupFilterPopup(Sender: TObject);
var
  Data: ptreeGenericdata;
  Node: pvirtualnode;
begin
  SaveFilter1.enabled := defaultFilter.isValid;
  RenameFilter1.enabled := false;
  DeleteFilter1.enabled := false;
  Node := CustomFilterTree.focusednode;
  if assigned(Node) then
  begin
    Data := CustomFilterTree.GetNodeData(Node);
    if not tfilterdata(Data.BasicND.p).default then
    begin
      RenameFilter1.enabled := true;
      DeleteFilter1.enabled := true;
    end;
  end
end;

procedure TForm1.CustomFilterTreePaintText(Sender: TBaseVirtualTree;

  const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: ptreeGenericdata;
begin
  Data := CustomFilterTree.GetNodeData(Node);
  if tfilterdata(Data.BasicND.p).default then
    TargetCanvas.font.Style := TargetCanvas.font.Style + [fsItalic];
end;

procedure TForm1.DeleteFilter1Click(Sender: TObject);
var
  Node: pvirtualnode;
begin
  Node := CustomFilterTree.focusednode;
  if assigned(Node) then
  begin
    CustomFilterTree.DeleteNode(Node);
    AssignFilterFromtree(false, false);
  end;
end;

procedure TForm1.RenameFilter1Click(Sender: TObject);
var
  Data: ptreeGenericdata;
  filtername: string;
  Node: pvirtualnode;
begin
  Node := CustomFilterTree.focusednode;
  if assigned(Node) then
  begin
    Data := CustomFilterTree.GetNodeData(Node);
    filtername := tfilterdata(Data.BasicND.p).name;
    if InputQuery('Filter Name', '', filtername) then
      tfilterdata(Data.BasicND.p).name := filtername;
  end;
  CustomFilterTree.repaint;
end;

procedure TForm1.AnonClick(Sender: TObject);
var
  i, tmpid: integer;
  u: tunitinfo;
  t: tstringlist;
begin
  t := tstringlist.create;
  try
    t.loadfromfile(datapath + NAMEANONYMISER);
    for i := 0 to unitArray.count - 1 do
    begin
      u := unitArray.items[i];
      tmpid := random(t.count);
      if (u.unittype = unitisplayer) or (u.unittype = unitIsPet) then
      begin
        u.name := trim(t.Strings[tmpid]);
        t.Delete(tmpid);
        if t.count = 0 then
          exit;
      end;
    end;
  finally
    t.free;
    unitTree.repaint;
    Imagemap.changed;
  end;
end;

procedure TForm1.gfx_detailledViewClick(Sender: TObject);
begin
  toggledetailledview(paramGraph.WatchedUnit);
end;

procedure TForm1.toggledetailledview(u: tUnitData);
begin
  if assigned(u) then
    paramGraph.WatchedUnit := u;
  if not assigned(paramGraph.WatchedUnit) then
    paramGraph.FocusedMode := 0;
  ToolButton10.ImageIndex := FOCUSEDMODE_IMAGE[paramGraph.FocusedMode];

  resetParamGraphFocusedData;
  paramGraph.activeUnitGfx := nil;
  completeRefresh([RefreshUnitStats, RefreshMap]);
end;

procedure TForm1.GfxRaidDpsOutClick(Sender: TObject);
begin
  completeRefresh([RefreshMap]);
end;

procedure TForm1.GaugeBar3Change(Sender: TObject);
var
  diffx, newpos: integer;
begin
  if dontdisturb or paramGraph.hzNoDirectChange then
    exit;
  newpos := GaugeBar3.Position * paramGraph.hzBarRatio + paramGraph.hzBarBase;
  diffx := newpos - paramGraph.hzOldPos;
  if diffx = 0 then
    exit;
  paramGraph.startDrawTime := (paramGraph.startDrawTime + diffx) div 100 * 100;
  if paramGraph.startDrawTime <= 0 then
    paramGraph.startDrawTime := 0;
  AssignDrawStartID(diffx > 0);
  Imagemap.changed;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if IsProcessActive(WOW_APPLICATION) then
  begin
    showmessage('Wow must be closed to load the ChatLog');
    exit;
  end;
  if Eventlist.count = 0 then
  begin
    showmessage('A Wowcombatlog must be loaded first');
    exit;
  end;

  OpenDialog1.CleanupInstance;
  OpenDialog1.DefaultExt := 'txt';
  OpenDialog1.filter := 'Logs (*.log , *txt)|*.log;*.txt';

  OpenDialog1.initialdir := ExtractFilePath(livelogFile);
  if OpenDialog1.Execute then
  begin
    Application.ProcessMessages;
    launchChatParsing(OpenDialog1.filename);
  end;
end;

procedure TForm1.launchChatParsing(f: string);
begin
  logerror := logNoError;
  ChatTree.BeginUpdate;
  ChatTree.clear;
  CurrentTimeStamp := 0;
  StatusBar1.Panels[2].Text := 'Analysing events... press Esc to stop';
  StatusBar1.repaint;
  ParseChatFile(f);
  // esthetique
  ProgressBar1.Position := ProgressBar1.max;
  // error
  case logerror of
    logInterrupted:
      showmessage('LoadingInterrupted Read Error');
    ChatlogReadError:
      showmessage('ChatLog Read Error');
    ChatLogIsEventLog:
      begin
        ChatTree.clear;
        showmessage('Parsing Stopped:' + #13 +
            'This appears to be eventlog, and should not be parsed as a ChatLog'
          );
      end;
  end;
  if autoclearchat.checked then
    clearChatTreefromBL;
  defineChatRender(false);
  ChatTree.endupdate;
  Imagemap.changed;
end;

procedure TForm1.defineChatRender(refreshTree: boolean = true);
begin
  if ChatTree.TotalCount > 0 then
  begin
    MARGE_CHAT := MARGE_CHAT_DEFAULT;
    GetFirstDrawNode(refreshTree);
  end
  else
    MARGE_CHAT := 0;
end;

procedure TForm1.ChatTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
  Column: TColumnIndex; TextType: TVSTTextType;

  var CellText: String);
var
  Data: ptreeGenericdata;
begin
  Data := ChatTree.GetNodeData(Node);
  CellText := pChatEvent(Data.BasicND.p).s;
end;

procedure TForm1.ChatTreeFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: pvirtualnode; OldColumn, NewColumn: TColumnIndex;

  var Allowed: boolean);
var
  Data: ptreeGenericdata;
begin
  Data := ChatTree.GetNodeData(NewNode);
  paramGraph.repere := pChatEvent(Data.BasicND.p).Time;
  Imagemap.changed;
  Allowed := true;
end;

procedure TForm1.ChatTreeFreeNode(Sender: TBaseVirtualTree; Node: pvirtualnode);
var
  Data: ptreeGenericdata;
begin
  Data := ChatTree.GetNodeData(Node);
  pChatEvent(Data.BasicND.p).destroy;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  ChatTree.clear;
  defineChatRender;
  Imagemap.changed;
end;

procedure TForm1.BlackList1Click(Sender: TObject);
var
  Data: ptreeGenericdata;
  Node: pvirtualnode;
  strtmp: string;
begin
  Node := ChatTree.focusednode;
  if assigned(Node) then
  begin
    Data := ChatTree.GetNodeData(Node);
    strtmp := pChatEvent(Data.BasicND.p).s;
    if InputQuery('BlackList', 'Edit the part of the line to blacklist:',
      strtmp) then
      ListBox1.items.add(strtmp);
  end;
end;

procedure TForm1.clearChatTreefromBL;
var
  Node, nodetmp: pvirtualnode;
  Data: ptreeGenericdata;
  i: integer;
begin
  Node := ChatTree.getfirst;
  paramGraph.activechatNode := nil;
  paramGraph.chatNode := nil;
  while assigned(Node) do
  begin
    nodetmp := Node.NextSibling; // memorize next node
    Data := ChatTree.GetNodeData(Node);
    for i := 0 to ListBox1.items.count - 1 do
    begin
      if pos(ListBox1.items.Strings[i], pChatEvent(Data.BasicND.p).s) > 0 then
      begin
        ChatTree.DeleteNode(Node);
        break;
      end;
    end;
    Node := nodetmp;
  end;
end;

procedure TForm1.ApplyBlackList1Click(Sender: TObject);
begin
  ChatTree.BeginUpdate;
  clearChatTreefromBL;
  defineChatRender(false);
  ChatTree.endupdate;
  Imagemap.changed;
end;

procedure TForm1.ChatTreePaintText(Sender: TBaseVirtualTree;

  const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: ptreeGenericdata;
begin
  Data := ChatTree.GetNodeData(Node);
  if (pChatEvent(Data.BasicND.p).Time < paramGraph.startDrawTime) or
    (pChatEvent(Data.BasicND.p).Time > controltotime(Imagemap.width))
    then
    TargetCanvas.font.color := $00AAAAAA;
end;

procedure TForm1.ClearList1Click(Sender: TObject);
begin
  ListBox1.items.clear;
end;

procedure TForm1.DeleteEntry1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex > 0 then
    ListBox1.items.Delete(ListBox1.ItemIndex);
end;

procedure TForm1.LogStatsOutput;
var
  i: integer;
begin
  if Eventlist.count > 0 then
  begin
    // stats
    MemoStat.clear;
    MemoStat.lines.add('Events: ' + inttostr(Eventlist.count));
    MemoStat.lines.add(format('SpellIdMax: %d', [SpellIdMax]));
    MemoStat.lines.add(format('NpcIdMax: %d/%d', [NpcIdMax, MAX_NPC_ARRAY_ROW])
      );
    MemoStat.lines.add('SpellCount: ' + inttostr(SpellTree.RootNodeCount));
    MemoStat.lines.add('NPCCount: ' + inttostr(NpcTotalCount));
    MemoStat.lines.add('CombatBlock: ' + inttostr(CombatBlockList.count));
    MemoStat.lines.add('time Min: ' + inttostr(pEvent(Eventlist.items[0]).Time)
      );
    MemoStat.lines.add('time Max: ' + inttostr
        (pEvent(Eventlist.items[Eventlist.count - 1]).Time));
    MemoStat.lines.add('MaxAbsorbRow: ' + inttostr(MaxAbsRow));
    MemoStat.lines.add('MaxCastRow: ' + inttostr(MaxCastRow));
    MemoStat.lines.add('MaxCastList: ' + inttostr(replayCastList.count));
{$IFDEF DEBUG}
    MemoStat.lines.add('MaxPowerValue: ' + inttostr(maxPowerValue));
    MemoStat.lines.add('dgError: ' + inttostr(debugError));
{$ENDIF}
    for i := low(markedlist) to high(markedlist) do
      MemoStat.lines.add('markedlist' + inttostr(i) + ' count: ' + inttostr
          (markedlist[i].count));
    if ChatTree.RootNodeCount > 0 then
      MemoStat.lines.add('ChatLines: ' + inttostr(ChatTree.RootNodeCount));
  end;
end;

procedure TForm1.AddRaidGfx1Click(Sender: TObject);
var
  i: integer;
  strtmp: string;
  tmpcolor: tcolor;
begin
  if paramGraph.FocusedMode > 0 then
    exit;
  randomize;
  if paramGraph.select.state = sS_valid then
    for i := 5 to 8 do
      if paramGraph.lines[i].valid then
      begin
        strtmp := RAID_ARRAYLINE_LABEL[i] + paramGraph.select.selectionLabel;
        strtmp := strtmp + ' (' + GetRealTimeFromTimeEvent(StartTimeStamp,
          paramGraph.select.startTime, 0, toShowDateAndMn) + ')';
        strtmp := strtmp + ' (' + GetFormattedLocalTime
          (paramGraph.select.endTime - paramGraph.select.startTime, false)
          + ')';
        tmpcolor := WinColor(color32(random(255), random(255), random(255)));
        ValidateCompareLine(strtmp, tmpcolor, prefs.openlinewin);
        CompareTree.AddChild(nil,
          TNodeGenericData.create(tCompareLineArray.initdata
              (paramGraph.lines[i], paramGraph.Xmax, color32(tmpcolor),
              strtmp)));
      end;
end;

procedure TForm1.EditLine1Click(Sender: TObject);
var
  Data: ptreeGenericdata;
  Node: pvirtualnode;
  strtmp: string;
  tmpcolor: tcolor;
begin
  Node := CompareTree.focusednode;
  if assigned(Node) then
  begin
    Data := CompareTree.GetNodeData(Node);
    tmpcolor := WinColor(tCompareLineArray(Data.BasicND.p).color);
    strtmp := tCompareLineArray(Data.BasicND.p).name;
    ValidateCompareLine(strtmp, tmpcolor, true);
    tCompareLineArray(Data.BasicND.p).color := color32(tmpcolor);
    tCompareLineArray(Data.BasicND.p).name := string
      (UTF8EncodeToShortString(strtmp));
    Imagemap.changed;
    CompareTree.repaint;
  end;
end;

procedure TForm1.ValidateCompareLine(var linecomment: string;

  var linecolor: tcolor; openlinewin: boolean);
var
  j: integer;
begin
  if openlinewin then
  begin
    form6 := tform6.create(self);
    form6.Caption := 'Edit line options';
    form6.memo1.Text := linecomment;
    form6.colordialog1.color := linecolor;
    form6.Shape1.Brush.color := linecolor;
    form6.checkbox1.checked := prefs.openlinewin;
    form6.showmodal;
    prefs.openlinewin := form6.checkbox1.checked;
    linecolor := form6.colordialog1.color;
    if form6.memo1.lines.count > 0 then
    begin
      linecomment := '';
      for j := 0 to form6.memo1.lines.count - 1 do
        linecomment := linecomment + form6.memo1.lines[j];
    end;
    form6.free;
  end;
  linecomment := trim(linecomment);
end;

procedure TForm1.CompareTreeGetText(Sender: TBaseVirtualTree;
  Node: pvirtualnode; Column: TColumnIndex; TextType: TVSTTextType;

  var CellText: String);
var
  Data: ptreeGenericdata;
begin
  Data := CompareTree.GetNodeData(Node);
  CellText := tCompareLineArray(Data.BasicND.p).name;
end;

procedure TForm1.CompareTreeFreeNode(Sender: TBaseVirtualTree;
  Node: pvirtualnode);
var
  Data: ptreeGenericdata;
begin
  Data := CompareTree.GetNodeData(Node);
  tCompareLineArray(Data.BasicND.p).destroy;
  Data.BasicND.destroy;
end;

procedure TForm1.Clear1Click(Sender: TObject);
begin
  CompareTree.clear;
  Imagemap.changed;
end;

procedure TForm1.CompareTreeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: pvirtualnode;

  var InitialStates: TVirtualNodeInitStates);
begin
  Node.checktype := ctCheckBox;
  Node.CheckState := csuncheckedNormal;
end;

procedure TForm1.CompareTreeChecked(Sender: TBaseVirtualTree;
  Node: pvirtualnode);
begin
  Imagemap.changed;
end;

procedure TForm1.CompareTreeBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect;

  var ContentRect: TRect);
var
  Data: ptreeGenericdata;
begin
  inc(CellRect.left);
  inc(CellRect.top);
  Data := CompareTree.GetNodeData(Node);
  CellRect.right := CellRect.left + 5;
  TargetCanvas.Brush.color := WinColor(tCompareLineArray(Data.BasicND.p).color);
  TargetCanvas.FillRect(CellRect);
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
  if CompareTree.RootNodeCount = 0 then
    exit;
  SaveDialog1.CleanupInstance;
  SaveDialog1.initialdir := comparepath;
  SaveDialog1.DefaultExt := '*.wcc';
  SaveDialog1.filter := 'Wcr Compare File (*.wcc)|*.wcc';
  SaveDialog1.Options := [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing];

  if SaveDialog1.Execute then
  begin
    Application.ProcessMessages;
    SaveCompareFile(SaveDialog1.filename);
    comparepath := ExtractFilePath(SaveDialog1.filename);
  end;
end;

procedure TForm1.SaveCompareFile(filename: string);
var
  f: tmemorystream;
  Data: ptreeGenericdata;
  Node: pvirtualnode;
  tca: tCompareLineArray;
  i, tmpvalue: integer;
  tmpstr: string[255];
begin
  screen.Cursor := crHourGlass;
  f := tmemorystream.create;
  try
    try
      Node := CompareTree.getfirst;
      while assigned(Node) do
      begin
        Data := CompareTree.GetNodeData(Node);
        tca := Data.BasicND.p;
        // arraysize
        tmpvalue := length(tca.line.eventarray);
        // datas
        f.Write(tmpvalue, SizeOf(tmpvalue));
        for i := 0 to tmpvalue - 1 do
          f.Write(tca.line.eventarray[i], SizeOf(tca.line.eventarray[i]));
        f.Write(tca.line.absratio, SizeOf(tca.line.absratio));
        f.Write(tca.color, SizeOf(tca.color));
        tmpstr := UTF8EncodeToShortString(tca.name);
        f.Write(tmpstr, SizeOf(tmpstr));
        Node := Node.NextSibling;
      end;
      f.SaveToFile(filename);
      screen.Cursor := crDefault;
    except
    end;
  finally
    f.free;
  end;
end;

procedure TForm1.Load1Click(Sender: TObject);
begin
  OpenDialog1.CleanupInstance;
  OpenDialog1.DefaultExt := 'wcc';
  OpenDialog1.filter := 'Wcr Compare File (*.wcc)|*.wcc';
  OpenDialog1.initialdir := comparepath;
  if OpenDialog1.Execute then
  begin
    LoadCompareFile(OpenDialog1.filename);
    comparepath := ExtractFilePath(OpenDialog1.filename);
  end;
end;

procedure TForm1.LoadCompareFile(filename: string);
var
  f: tmemorystream;
  tca: tCompareLineArray;
  i, tmpvalue: integer;
  tmpstr: string[255];
begin
  f := tmemorystream.create;
  try
    try
      f.loadfromfile(filename);
      f.Position := 0;
      while f.Position < f.Size - 1 do
      begin
        tmpvalue := 0;
        f.Read(tmpvalue, SizeOf(tmpvalue));
        if tmpvalue > 0 then
        begin
          tca := tCompareLineArray.create;
          setlength(tca.line.eventarray, tmpvalue);
          for i := 0 to tmpvalue - 1 do
            f.Read(tca.line.eventarray[i], SizeOf(integer));
          f.Read(tca.line.absratio, SizeOf(tca.line.absratio));
          f.Read(tca.color, SizeOf(tca.color));
          f.Read(tmpstr, SizeOf(tmpstr));
          tca.name := utf8tostring(tmpstr);
          CompareTree.AddChild(nil, TNodeGenericData.create(tca));
        end;
      end;
    except
    end
  finally
    f.free;
  end;
end;

procedure TForm1.Supprimer1Click(Sender: TObject);
begin
  if assigned(CompareTree.focusednode) then
  begin
    CompareTree.DeleteNode(CompareTree.focusednode);
    Imagemap.changed;
  end;
end;

procedure TForm1.LoadLog3Click(Sender: TObject);
begin
  logpath := loadLog(logpath);
end;

procedure TForm1.LoadLiveLog1Click(Sender: TObject);
begin
  if lowercase(ExtractFileName(livelogFile)) <> lowercase(INGAMELOGNAME) then
    if not setlivelogfolder(Form1) then
      exit;
  launchParsing(livelogFile, EMPTYBOSSSTRING, false);
end;

procedure TForm1.RegisteredUnits1Click(Sender: TObject);
begin
  if length(npcArray) > 0 then
    exit;
  clearUnitArray;
  initNPCArray;
  form7 := tform7.create(self);
  form7.Caption := 'Registered Units';
  try
    if form7.showmodal = mrOk then
      saveNPCArray;
  finally
    form7.free;
    clearUnitArray;
  end;
end;

procedure TForm1.RegisteredSpells1Click(Sender: TObject);
begin
  if spellArray.count > 0 then
    exit;
  clearSpellArray;
  initSpellArray;
  FormSpell := tFormSpell.create(self);
  FormSpell.Caption := 'Registered Spells';
  try
    if FormSpell.showmodal = mrOk then
      saveSpellArray;
  finally
    FormSpell.free;
    clearSpellArray;
  end;
end;

procedure TForm1.SetAuraWatch1Click(Sender: TObject);
begin
  if assigned(paramGraph.MenuActiveEvent) then
  begin
    paramGraph.aurawatch := paramGraph.MenuActiveEvent.spell.id;
    paramGraph.aurawatchSource := nil;
    generateUnitAura(paramGraph.aurawatch, paramGraph.aurawatchSource);
    Imagemap.changed;
  end;
end;

procedure TForm1.SetAuraWatchUnit2Click(Sender: TObject);
begin
  if assigned(paramGraph.MenuActiveEvent) then
  begin
    paramGraph.aurawatch := paramGraph.MenuActiveEvent.spell.id;
    paramGraph.aurawatchSource := paramGraph.MenuActiveEvent.sourceUnit;
    generateUnitAura(paramGraph.aurawatch, paramGraph.aurawatchSource);
    Imagemap.changed;
  end;
end;

procedure TForm1.SetAuraWatch2Click(Sender: TObject);
begin
  if assigned(paramGraph.focusedSpell) then
  begin
    paramGraph.aurawatch := paramGraph.focusedSpell.id;
    paramGraph.aurawatchSource := nil;
    generateUnitAura(paramGraph.aurawatch, paramGraph.aurawatchSource);
    Imagemap.changed;
  end;
end;

procedure TForm1.SetAuraWatchUnit1Click(Sender: TObject);
begin
  if assigned(paramGraph.focusedSpell) then
  begin
    paramGraph.aurawatch := paramGraph.focusedSpell.id;
    paramGraph.aurawatchSource := paramGraph.WatchedUnit;
    generateUnitAura(paramGraph.aurawatch, paramGraph.aurawatchSource);
    Imagemap.changed;
  end;
end;

procedure TForm1.RemoveAuraWatch1Click(Sender: TObject);
begin
  paramGraph.aurawatch := 0;
  paramGraph.aurawatchSource := nil;
  generateUnitAura(paramGraph.aurawatch, paramGraph.aurawatchSource);
  Imagemap.changed;
end;

procedure TForm1.ReadMeViewerHotSpotClick(Sender: TObject;

  const URL: String;

  var Handled: boolean);
var
  s: string;
  Ext: string;
  i, j: integer;
  bossId, filename: string;
begin
  Handled := false;
  // special commands
  if URL = '#loadlog' then
  begin
    LoadLog1Click(nil);
    Handled := true;
    exit;
  end
  else if URL = '#options' then
  begin
    But_OptionsClick(nil);
    Handled := true;
    exit;
  end
  else if URL = '#livelog' then
  begin
    LoadLiveLog1Click(nil);
    Handled := true;
    exit;
  end
  else if URL = '#logindex' then
  begin
    getLogIndex;
    Handled := true;
    exit;
  end
  else if URL = '#dirlog' then
  begin
    definepathlogindex;
    Handled := true;
    exit;
  end
  else if URL = '#refresh' then
  begin
    if not prefs.useCache then
      clearLogIndexLists;
    generateLogIndex(0, false, prefs.useCache);
    Handled := true;
    exit;
  end
  else if URL = '#rebuild' then
  begin
    clearLogIndexLists;
    generateLogIndex(0, false, false);
    Handled := true;
    exit;
  end
  else if URL = '#batch' then
  begin
    BatchLogs;
    Handled := true;
    exit;
  end;
  // effacement
  if pos(':del:', URL) = 1 then
  begin
    if FileOperation(copy(URL, 6, length(URL)), '', FO_DELETE, FOF_ALLOWUNDO)
      then
      generateLogIndex(0, false, prefs.useCache);
    Handled := true;
    exit;
  end;
  // dl with bossid
  if pos('#WCR:', URL) = 1 then
  begin
    // #WCR:FFFFFFName.wcr
    bossId := copy(URL, 6, 7);
    filename := copy(URL, 13, length(URL));
    Handled := true;
    if fileexists(filename) then
      launchParsing(filename, bossId, false);
    exit;
  end;
  // bossid
  if pos('#BOSS:', URL) = 1 then
  begin
    generateLogIndex(strtointdef(copy(URL, 7, 7), 0), false, prefs.useCache);
    Handled := true;
    exit;
  end;
  // bossid
  if pos('#BOSH:', URL) = 1 then
  begin
    generateLogIndex(strtointdef(copy(URL, 7, 7), 0), true, prefs.useCache);
    Handled := true;
    exit;
  end;

  i := pos(':', URL);
  j := pos('FILE:', UpperCase(URL));
  if (i <= 2) or (j > 0) then
  begin { apparently the URL is a filename }
    s := URL;
    s := ReadMeViewer.HTMLExpandFileName(s);
    // if textfle
    Ext := UpperCase(ExtractFileExt(s));
    if Ext = '.HTM' then
    begin
      Handled := true;
      openHtmFile(s, ReadMeViewer);
    end
    else if Ext = '.TXT' then
    begin
      Handled := true;
      ReadMeViewer.loadfromfile(s, TextType);
    end
    else if Ext = '.WCR' then
    begin
      Handled := true;
      if fileexists(s) then
        launchParsing(s, EMPTYBOSSSTRING, false);
    end;
    exit;
  end;
  i := pos('MAILTO:', UpperCase(URL));
  j := pos('HTTP:', UpperCase(URL));
  if (i > 0) or (j > 0) then
  begin
    ShellExecute(0, nil, @URL[1], nil, nil, SW_SHOWNORMAL);
    Handled := true;
  end;
end;

procedure TForm1.getLogIndex;
begin
  if not generateLogIndex(0, false, prefs.useCache) then
    definepathlogindex;
end;

procedure TForm1.definepathlogindex;
begin
  if getmyfolder(Form1) then
  begin
    clearLogIndexLists;
    generateLogIndex(0, false, prefs.useCache);
  end;
end;

procedure TForm1.clipboard1Click(Sender: TObject);
begin
  if ReadMeViewer.Focused then
    ReadMeViewer.CopyToClipboard
  else if htmlstats.Focused then
    htmlstats.CopyToClipboard;
end;

function TForm1.generateLogIndex(RestrictBoss: integer;
  HMonly, useCache: boolean): boolean;
var
  cleanonExit: boolean;
begin
  Result := false;
  screen.Cursor := crHourGlass;
  StatusBar1.Panels[2].Text := format('FileCheck[%d]',
    [generateDirList(LogList, logpath, useCache)]);
  LogList.Sort(sortwcrcontentlist);
  if prefs.useCache then
    saveIndexCache(LogList, logpath);
  if LogList.count > 0 then
  begin
    if length(npcArray) = 0 then
    begin
      initNPCArray;
      cleanonExit := true;
    end
    else
      cleanonExit := false;

    generateLogHTML(RestrictBoss, HMonly, useCache, ReadMeViewer);
    if cleanonExit then
      clearUnitArray;
    Result := true
  end;
  screen.Cursor := crDefault;
end;

procedure TForm1.BatchLogs;
var
  l: tlist;
  W: tWcrfile;
  i: integer;
begin
  screen.Cursor := crHourGlass;
  clearLogIndexLists;
  bwhilebatching := true;
  l := tlist.create;
  generateDirList(l, logpath, false);
  for i := 0 to l.count - 1 do
  begin
    W := l.items[i];
    if W.content.wcrheader < WCRFILE_HEADER then
    begin
      if bwhilebatching then
      begin
        launchParsing(W.path + string(W.content.name), EMPTYBOSSSTRING, true);
        Application.ProcessMessages;
        saveWcrLog(W.path + string(W.content.name),
          string(W.content.content.comment), true);
      end;
      Application.ProcessMessages;
    end;
    W.free;
  end;
  l.free;
  screen.Cursor := crDefault;
  if bwhilebatching then
    showmessage('Batch finished')
  else
    showmessage('Batch interrupted');
  bwhilebatching := false;
  generateLogIndex(0, false, false);
  TabSheet4.show;
end;

procedure TForm1.btnAbsorbClick(Sender: TObject);
begin
  Stat_absorb.down := btnAbsorb.down;
  completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats, RefreshMap]);
end;

procedure TForm1.Stat_absorbClick(Sender: TObject);
begin
  btnAbsorb.down := Stat_absorb.down;
  completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats, RefreshMap]);
end;

procedure TForm1.Stat_Typo;
begin
  if Stat_MergeAbsorb.down then
  begin
    StatTree.Header.columns[3].Text := 'Eff.H+Abs Done';
    StatTree.Header.columns[4].Text := 'Raw.H+Abs Done';
  end
  else
  begin
    StatTree.Header.columns[3].Text := 'Eff.H Done';
    StatTree.Header.columns[4].Text := 'Raw.H Done';
  end;
  StatTree.Header.columns[9].Text := STAT_DSP_LABEL[ord(Stat_ShowActDps.down)];
end;

procedure TForm1.Stat_MergeAbsorbClick(Sender: TObject);
begin
  Stat_Typo;
  completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats, RefreshMap]);
end;

procedure TForm1.Splitter1Moved(Sender: TObject);
begin
  authStatResize := prefs.ResizeStats;
  StatTreeResizeColumn;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  authStatResize := prefs.ResizeStats;
  StatTreeResizeColumn;
  if Panel25.height > self.ClientHeight -
    (StatusBar1.height + Splitter4.MinSize) then
    Panel25.height := self.ClientHeight -
      (StatusBar1.height + Splitter4.MinSize);
end;

procedure TForm1.WatchedEventTreeGetText(Sender: TBaseVirtualTree;
  Node: pvirtualnode; Column: TColumnIndex; TextType: TVSTTextType;

  var CellText: String);
var
  Data: ptreeGenericdata;
begin
  Data := Sender.GetNodeData(Node);
  case Sender.GetNodeLevel(Node) of
    0:
      case Column of
        0:
          CellText := tglobalnode(Data.BasicND.p).name;
        1:
          CellText := inttostr(tglobalnode(Data.BasicND.p).eventwatchCount
              [tglobalnode(Data.BasicND.p).watchtype]);
        2:
          CellText := '';
      end;
    1:
      case Column of
        0:
          CellText := getunitname(twatchedEvent(Data.BasicND.p).u, []);
        1:
          CellText := inttostr(twatchedEvent(Data.BasicND.p).count);
        2:
          CellText := '';
      end;
    2:
      case Column of
        0:
          CellText := parenthese_string
            (getSecureUnitInfoName(twatchedspell(Data.BasicND.p).uiaff));
        1:
          CellText := inttostr(twatchedspell(Data.BasicND.p).count);
        2:
          CellText := getspellname(twatchedspell(Data.BasicND.p).id)
            + parenthese_string
            (getSecureUnitInfoName(twatchedspell(Data.BasicND.p).uidest));
      end;
  end;
end;

procedure TForm1.WatchedEventTreeCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: pvirtualnode; Column: TColumnIndex;

  var Result: integer);
var
  data1, data2: ptreeGenericdata;
begin
  data1 := Sender.GetNodeData(Node1);
  data2 := Sender.GetNodeData(Node2);
  if (Sender.GetNodeLevel(Node1) = 1) and (Sender.GetNodeLevel(Node2) = 1) then
    Result := twatchedEvent(data2.BasicND.p).count - twatchedEvent
      (data1.BasicND.p).count
  else if (Sender.GetNodeLevel(Node1) = 2) and (Sender.GetNodeLevel(Node2) = 2)
    then
    Result := twatchedspell(data2.BasicND.p).count - twatchedspell
      (data1.BasicND.p).count;
end;

procedure TForm1.WatchedEventTreePaintText(Sender: TBaseVirtualTree;

  const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  if (Sender.GetNodeLevel(Node) = 0) then
    TargetCanvas.font.Style := [fsBold]
  else if (Sender.GetNodeLevel(Node) = 1) and (Column = 1) then
    TargetCanvas.font.Style := [fsBold]
  else if Sender.GetNodeLevel(Node) = 2 then
    TargetCanvas.font.Style := [fsItalic];
end;

procedure TForm1.WatchedEventTreeBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect;

  var ContentRect: TRect);
var
  Data: ptreeGenericdata;
  ul: tUnitData;
  backupRight: integer;
begin
  Data := Sender.GetNodeData(Node);
  if Sender.GetNodeLevel(Node) = 0 then
  begin
    TargetCanvas.Brush.color := tglobalnode(Data.BasicND.p).color;
    TargetCanvas.FillRect(CellRect);
  end
  else if Sender.GetNodeLevel(Node) = 1 then
  begin
    ul := twatchedEvent(Data.BasicND.p).u;
    if Column = 0 then
    begin
      backupRight := CellRect.right - 1;
      inc(CellRect.left);
      CellRect.right := CellRect.left + 5;
      TargetCanvas.Brush.color := ClasseStat[ul.Classe].color;
      TargetCanvas.FillRect(CellRect);
      CellRect.left := CellRect.right + 1;
      CellRect.right := backupRight;
      TargetCanvas.Brush.color := $FAFAFA;
      TargetCanvas.FillRect(CellRect);
    end;
  end;
end;

procedure TForm1.SideBar1Select(Sender: TObject; Index, SubIndex: integer;
  Caption: String);
begin
  buildWatchedEvent(SubIndex);
end;

procedure TForm1.WatchedEventTreeExpanded(Sender: TBaseVirtualTree;
  Node: pvirtualnode);
var
  Data: ptreeGenericdata;
begin
  Data := Sender.GetNodeData(Node);
  case Sender.GetNodeLevel(Node) of
    0:
      tglobalnode(Data.BasicND.p).WatchNodeOpen := Sender.Expanded[Node];
    1:
      if Sender.Expanded[Node] then
        include(twatchedEvent(Data.BasicND.p).u.params, upWatchNodeOpen)
      else
        exclude(twatchedEvent(Data.BasicND.p).u.params, upWatchNodeOpen);
  end;
end;

procedure TForm1.WatchedEventTreeFreeNode(Sender: TBaseVirtualTree;
  Node: pvirtualnode);
var
  Data: ptreeGenericdata;
begin
  Data := WatchedEventTree.GetNodeData(Node);
  Data.BasicND.destroy;
end;

procedure TForm1.ResetFullFilter4Click(Sender: TObject);
begin
  resetSpellEventselection;
end;

procedure TForm1.ReplayTabShow(Sender: TObject);
begin
  Panel13.Parent := Panel26;
  Panel25.Visible := false;
  Splitter4.Visible := false;
end;

procedure TForm1.TabSheet4Show(Sender: TObject);
begin
  Panel25.Visible := false;
  Splitter4.Visible := false;
end;

procedure TForm1.GraphicTabShow(Sender: TObject);
begin
  Panel13.Parent := Panel3;
  Panel25.Visible := true;
  Splitter4.Visible := true;
  Imagemap.changed;
end;

procedure TForm1.TabSheet8Show(Sender: TObject);
begin
  Panel13.Parent := Panel17;
  Panel25.Visible := false;
  Splitter4.Visible := false;
end;

procedure TForm1.ListViewTabShow(Sender: TObject);
begin
  Panel13.Parent := Panel19;
  Panel25.Visible := true;
  Splitter4.Visible := true;
end;

procedure TForm1.StatsTabShow(Sender: TObject);
begin
  authStatResize := prefs.ResizeStats;
  StatTreeResizeColumn;
  Panel13.Parent := Panel16;
  Panel25.Visible := true;
  Splitter4.Visible := true;
end;

procedure TForm1.LogIndexClick(Sender: TObject);
begin
  getLogIndex;
  TabSheet4.show;
end;

procedure TForm1.StatTreeExpanded(Sender: TBaseVirtualTree; Node: pvirtualnode);
var
  Data: ptreeGenericdata;
begin
  Data := Sender.GetNodeData(Node);
  case Sender.GetNodeLevel(Node) of
    0:
      tglobalnode(Data.BasicND.p).StatNodeOpen := Sender.Expanded[Node];
    1 .. 2:
      if Sender.Expanded[Node] then
        include(tUnitData(Data.BasicND.p).params, upStatNodeOpen)
      else
        exclude(tUnitData(Data.BasicND.p).params, upStatNodeOpen);
  end;
end;

procedure TForm1.Stat_NoEnemyHealClick(Sender: TObject);
begin
  completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats, RefreshMap]);
end;

procedure TForm1.Stat_ShowActDpsClick(Sender: TObject);
begin
  Stat_Typo;
  StatTree.repaint;
end;

procedure TForm1.Stat_OnlyCombatClick(Sender: TObject);
begin
  completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats]);
end;

procedure TForm1.CheckOnWeb1Click(Sender: TObject);
var
  Data: ptreeGenericdata;
begin
  if assigned(unitTree.focusednode) then
    if unitTree.GetNodeLevel(unitTree.focusednode) = 1 then
    begin
      Data := unitTree.GetNodeData(unitTree.focusednode);
      getWebInfoForUnit(Data.BasicND.p)
    end;
end;

procedure TForm1.CheckUnitOnWeb1Click(Sender: TObject);
begin
  if assigned(paramGraph.MenuActiveUnitGfx) then
    getWebInfoForUnit(getunitinfo(paramGraph.MenuActiveUnitGfx));
end;

procedure TForm1.PageControl1MouseMove(Sender: TObject; Shift: TShiftState;
  x, y: integer);
var
  tabindex: integer;
begin
  tabindex := PageControl1.IndexOfTabAt(x, y);
  if tabindex >= 0 then
  begin
    PageControl1.Hint := PageControl1.Pages[tabindex].Hint;
    PageControl1.ShowHint := true;
  end;
end;

procedure TForm1.HideEventsClick(Sender: TObject);
begin
  paramGraph.DrawEvent := not HideEvents.down;
  Imagemap.changed;
end;

procedure TForm1.htmlstatsMenuHotSpotClick(Sender: TObject; const URL: String;
  var Handled: boolean);
var
  spellId: integer;
begin
  Handled := false;
  // statsmode
  if pos('#mode', URL) = 1 then
  begin
    paramGraph.statsmode := strtointdef(copy(URL, 6, 1), 0);
    // securité
    if paramGraph.statsmode > high(paramGraph.unitstattreeSortCol) then
      paramGraph.statsmode := high(paramGraph.unitstattreeSortCol);
    fillFocusedStats;
    Handled := true;
    exit;
  end;

  // spellfilter
  if pos('#+ft:', URL) = 1 then
  begin
    spellId := strtointdef(copy(URL, 6, 255), -1);
    paramGraph.overridefiltercheck := true;
    SpellTree.CheckState[pvirtualnode(getSpellFromID(spellId).pnode)] :=
      csCheckedNormal;
    Handled := true;
    exit;
  end;

  // spellfilter
  if pos('#-ft:', URL) = 1 then
  begin
    spellId := strtointdef(copy(URL, 6, 255), -1);
    paramGraph.overridefiltercheck := true;
    SpellTree.CheckState[pvirtualnode(getSpellFromID(spellId).pnode)] :=
      csunCheckedPressed;
    Handled := true;
    exit;
  end;

  // reset filter
  if URL = '#rfi' then
  begin
    resetSpellEventselection;
    Handled := true;
    exit;
  end;
  // reset focus
  if URL = '#rfo' then
  begin
    gfx_ResetFocusClick(nil);
    Handled := true;
    exit;
  end;

  // reset aurawatch
  if URL = '#rau' then
  begin
    RemoveAuraWatch1Click(nil);
    Handled := true;
    exit;
  end;
end;

procedure TForm1.But_OptionsClick(Sender: TObject);
begin
  OptionsForm := tOptionsForm.create(self);
  if OptionsForm.showmodal = mrOk then
  begin
    LiveUpdateTimer.Interval := LIVE_TIMER[prefs.LiveUpdateTimer].Timer;
    authStatResize := prefs.ResizeStats;
    StatTreeResizeColumn;
    setBaseVar(prefs.InterfaceScale);
    paramGraph.idleEvent_RefreshImage := true;

    StatTree.repaint;
    UnitStatTree.repaint;
    MyTree.repaint;
  end;
  form3.free;
end;

procedure TForm1.gfxDetail1Click(Sender: TObject);
begin
  if dontdisturb then
    exit;
  if paramGraph.FocusedMode > 0 then
    paramGraph.FocusedModeOld := paramGraph.FocusedMode;
  paramGraph.FocusedMode := strtointdef(copy(TMenuItem(Sender).name, 10, 1), 0);
  toggledetailledview(nil);
end;

procedure TForm1.DetailsOnUnit1Click(Sender: TObject);
begin
  if ReplayTab.visible then
  begin
    if paramGraph.FocusedModeOld = 0 then paramGraph.FocusedModeOld := 1;
    if paramGraph.FocusedMode = 0 then
      paramGraph.FocusedMode := paramGraph.FocusedModeOld;
    toggledetailledview(paramGraph.MenuActiveUnitGfx);
    GraphicTab.show;
  end
  else
  begin
    if paramGraph.FocusedModeOld = 0 then paramGraph.FocusedModeOld := 1;
    if paramGraph.FocusedMode = 0 then
      paramGraph.FocusedMode := paramGraph.FocusedModeOld
    else
    begin
      paramGraph.FocusedModeOld := paramGraph.FocusedMode;
      paramGraph.FocusedMode := 0;
    end;
    toggledetailledview(paramGraph.MenuActiveUnitGfx);
  end;
end;

procedure TForm1.Unit1Click(Sender: TObject);
begin
  changewatchedUnit(paramGraph.unittreenode);
end;

procedure TForm1.Action1Execute(Sender: TObject);
begin
  gfxDetail1Click(gfxDetail1);
end;

procedure TForm1.Action2Execute(Sender: TObject);
begin
  gfxDetail1Click(gfxDetail2);
end;

procedure TForm1.Action3Execute(Sender: TObject);
begin
  gfxDetail1Click(gfxDetail3);
end;

procedure TForm1.Action4Execute(Sender: TObject);
begin
  gfxDetail1Click(gfxDetail4);
end;

procedure TForm1.Action5Execute(Sender: TObject);
begin
  gfxDetail1Click(gfxDetail0);
end;

procedure TForm1.Action6Execute(Sender: TObject);
begin
  butreplay_playClick(nil)
end;

procedure TForm1.Action7Execute(Sender: TObject);
begin
  butreplay_fitimageClick(nil);
end;

procedure TForm1.btnFocusModeClick(Sender: TObject);
begin
  btnFocusType.enabled := not btnFocusMode.down;
  if paramGraph.unitRef then
  begin
    completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats, RefreshMap]);
    if ListViewTab.Visible and ListBut_AutoRefresh.down then
      ListBut_RefreshClick(nil);
    unitTree.repaint;
  end;
end;

procedure TForm1.focusmode01Click(Sender: TObject);
begin
  globalFocusType := sfocusType(byte(strtointdef(copy(TMenuItem(Sender).name,
          10, 1), 0)));
  btnFocusType.ImageIndex := ord(globalFocusType) + 46;
  btnFocusModeClick(nil);
end;

// -------------
procedure TForm1.fillUnitStats;
begin
  UnitStatTree.BeginUpdate;
  case paramGraph.statsmode of
    0:
      fillunitstatEx(paramGraph.Rotationlines.eventOut, isDamage,
        paramGraph.Rotationlines.total[0], statcolumn_Damages);
    1:
      fillunitstatEx(paramGraph.Rotationlines.eventIn, isDamage,
        paramGraph.Rotationlines.total[1], statcolumn_Damages);
    2:
      fillunitstatEx(paramGraph.Rotationlines.eventOut, isHeal,
        paramGraph.Rotationlines.total[0], statcolumn_Heal);
    3:
      fillunitstatEx(paramGraph.Rotationlines.eventIn, isHeal,
        paramGraph.Rotationlines.total[1], statcolumn_Heal);
    4:
      fillunitstatEx(paramGraph.Rotationlines.eventOut, IsBuff,
        paramGraph.Rotationlines.total[0], statcolumn_Buff);
    5:
      fillunitstatEx(paramGraph.Rotationlines.eventIn, IsBuff,
        paramGraph.Rotationlines.total[1], statcolumn_Buff);
    6:
      fillunitstatEx(paramGraph.Rotationlines.eventOut, isdebuff,
        paramGraph.Rotationlines.total[0], statcolumn_Debuff);
    7:
      fillunitstatEx(paramGraph.Rotationlines.eventIn, isdebuff,
        paramGraph.Rotationlines.total[1], statcolumn_Debuff);
    8:
      fillunitstatEx(paramGraph.Rotationlines.eventIn, IsPower,
        paramGraph.Rotationlines.total[1], statcolumn_Power);
    9:
      fillunitstatEx(paramGraph.Rotationlines.eventOut, IsOther,
        paramGraph.Rotationlines.total[0], statcolumn_Other);
  end;
  UnitStatTree.endupdate;
end;

procedure TForm1.clearUnitStatTree;
begin

  if UnitStatTree.TotalCount > 0 then
  begin
    // ---------------------------
    if paramGraph.keepunitstattreeOffset then
      paramGraph.unitstattreeOffset := UnitStatTree.OffsetY
    else
      paramGraph.unitstattreeOffset := 0;
    paramGraph.keepunitstattreeOffset := false;
  end;

  UnitStatTree.clear;
  UnitStatTree.Header.columns.clear;
end;

procedure TForm1.fillunitstatEx(l: tlist; state: rotationstate;
  firstnode: trotationline; statcol: array of rstatcolumn);
var
  i, sortcol: integer;
  Rotationline: trotationline;
  tc: tvirtualtreecolumn;
  Node: pvirtualnode;
  tagcol: boolean;
begin
  // clear;
  sortcol := 0;
  clearUnitStatTree;
  // creating column:
  for i := 0 to high(statcol) do
  begin
    tc := UnitStatTree.Header.columns.add;
    tc.Text := statcol[i].Text;
    tc.tag := statcol[i].tag;
    tc.Options := tc.Options - [coResizable];
    tc.minwidth := 2;
    tc.width := statcol[i].Size;
    tc.Style := vsOwnerDraw;
    if statcol[i].fixed then
      tc.Options := tc.Options + [coFixed];
    if not statcol[i].left then
      tc.Alignment := taRightJustify;
    if statcol[i].Sort then
      sortcol := i;
    if not statcol[i].always then
      tc.Options := tc.Options - [coVisible];
  end;

  // firstnode;
  Node := UnitStatTree.AddChild(nil, TNodeGenericData.create(firstnode));
  UnitStatTree.Canvas.font.Name := UnitStatTree.font.name;
  UnitStatTree.Canvas.font.Size := UnitStatTree.font.Size;

  UnitStatTree.Canvas.font.Style := [fsBold];
  fixstatcolumnParams(firstnode, high(statcol));
  UnitStatTree.Canvas.font.Style := [];
  // filling tree
  for i := 0 to l.count - 1 do
  begin
    Rotationline := l.items[i];
    if state in Rotationline.rs.state then
    begin
      UnitStatTree.AddChild(Node, TNodeGenericData.create(Rotationline));
      fixstatcolumnParams(Rotationline, high(statcol));
    end;
  end;
  UnitStatTree.Expanded[Node] := true;

  // ---cleaning col intecalaire
  tagcol := false;
  for i := 0 to UnitStatTree.Header.columns.count - 2 do
  begin
    if (coVisible in UnitStatTree.Header.columns[i].Options) then
    begin
      if tagcol and (UnitStatTree.Header.columns[i].width = 3) then
        UnitStatTree.Header.columns[i].Options := UnitStatTree.Header.columns[i]
          .Options - [coVisible];
      tagcol := (UnitStatTree.Header.columns[i].width = 3);
    end;
  end;

  // sorting and design
  if paramGraph.unitstattreeSortCol[paramGraph.statsmode] = 0 then
    UnitStatTree.Header.SortColumn := sortcol
  else
    UnitStatTree.Header.SortColumn := paramGraph.unitstattreeSortCol
      [paramGraph.statsmode];
  UnitStatTree.OffsetY := paramGraph.unitstattreeOffset;
end;

procedure TForm1.fixstatcolumnParams(Rotationline: trotationline;
  highcol: integer);
var
  j: integer;
  tmpcx: integer;
begin
  // get columnsize
  for j := 0 to highcol do
  begin
    tmpcx := UnitStatTree.Canvas.TextExtent(fillDataStats(Rotationline,
        UnitStatTree.Header.columns[j].tag, 0)).cx + 10 + UnitStatTree.margin;
    // checkvisibility:
    if fillDataStatsNum(Rotationline, UnitStatTree.Header.columns[j].tag, 0)
      > 0 then
      UnitStatTree.Header.columns[j].Options := UnitStatTree.Header.columns[j]
        .Options + [coVisible];
    if (UnitStatTree.Header.columns[j].width < tmpcx) and
      (UnitStatTree.Header.columns[j].tag > 0) then
      UnitStatTree.Header.columns[j].width := tmpcx
  end;
end;

procedure TForm1.UnitStatTreeGetText(Sender: TBaseVirtualTree;
  Node: pvirtualnode; Column: TColumnIndex; TextType: TVSTTextType;

  var CellText: String);
var
  Data: ptreeGenericdata;
begin
  if Column >= 0 then
  begin
    Data := UnitStatTree.GetNodeData(Node);
    CellText := fillDataStats(Data.BasicND.p,
      UnitStatTree.Header.columns[Column].tag, 0);
  end;
end;

procedure TForm1.UnitStatTreeHeaderClick(Sender: TVTHeader;
  HitInfo: TVTHeaderHitInfo);
begin
  StatTreeHeaderClick(Sender, HitInfo);
  paramGraph.unitstattreeSortCol[paramGraph.statsmode] :=
    UnitStatTree.Header.SortColumn;
end;

procedure TForm1.UnitStatTreeHeaderDrawQueryElements(Sender: TVTHeader;

  var PaintInfo: THeaderPaintInfo;

  var Elements: THeaderPaintElements);
begin
  Elements := [hpeBackground]
end;

procedure TForm1.UnitStatTreeAdvancedHeaderDraw(Sender: TVTHeader;

  var PaintInfo: THeaderPaintInfo;

  const Elements: THeaderPaintElements);
begin
  PaintInfo.TargetCanvas.Brush.color := $00CCCCCC;
  PaintInfo.TargetCanvas.FillRect(PaintInfo.PaintRectangle);
  if assigned(PaintInfo.Column) then
  begin
    PaintInfo.TargetCanvas.Brush.color := $00AAAAAA;
    PaintInfo.TargetCanvas.FillRect(PaintInfo.PaintRectangle);
  end;
end;

procedure TForm1.UnitStatTreeBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect;

  var ContentRect: TRect);
begin
  if UnitStatTree.GetNodeLevel(Node) = 0 then
  begin
    TargetCanvas.Brush.color := $00FFCCCC;
    TargetCanvas.FillRect(CellRect);
  end
  else if odd(Node.index) then
  begin
    TargetCanvas.Brush.color := $00DADADA;
    TargetCanvas.FillRect(CellRect);
  end;
  if Column = 0 then
  begin
    TargetCanvas.pen.color := UnitStatTree.Colors.GridLineColor;
    TargetCanvas.MoveTo(CellRect.left, CellRect.top);
    TargetCanvas.LineTo(CellRect.left, CellRect.bottom);
  end;

  if Node.NextSibling = nil then
  begin
    TargetCanvas.pen.color := UnitStatTree.Colors.GridLineColor;
    TargetCanvas.MoveTo(CellRect.left, CellRect.bottom - 1);
    TargetCanvas.LineTo(CellRect.right, CellRect.bottom - 1);
  end;
end;

procedure TForm1.UnitStatTreePaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: ptreeGenericdata;
  csp: rConstantSpellParams;
begin
  if UnitStatTree.GetNodeLevel(Node) = 0 then
    TargetCanvas.font.Style := [fsBold];
  TargetCanvas.font.color := clBlack;

  Data := UnitStatTree.GetNodeData(Node);
  csp := getSpellParams(trotationline(Data.BasicND.p).spell);
  if assigned(trotationline(Data.BasicND.p).spell) then
    if (spellIsFixedAbsb in trotationline(Data.BasicND.p).spell.sdata) then
      TargetCanvas.font.color := clBlue;

end;

procedure TForm1.UnitStatTreeCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: pvirtualnode; Column: TColumnIndex;

  var Result: integer);
var
  data1, data2: ptreeGenericdata;
begin
  if Column >= 0 then
  begin
    data1 := UnitStatTree.GetNodeData(Node1);
    data2 := UnitStatTree.GetNodeData(Node2);
    if UnitStatTree.Header.columns[Column].Alignment = taleftJustify then
      Result := comparetext(trotationline(data1.BasicND.p).getfullspellname,
        trotationline(data2.BasicND.p).getfullspellname)
    else
      Result := fillDataStatsNum(data1.BasicND.p,
        UnitStatTree.Header.columns[Column].tag, 0) - fillDataStatsNum
        (data2.BasicND.p, UnitStatTree.Header.columns[Column].tag, 0);
  end;
end;

procedure TForm1.UnitStatTreeCollapsing(Sender: TBaseVirtualTree;
  Node: pvirtualnode;

  var Allowed: boolean);
begin
  Allowed := false;
end;

procedure TForm1.UnitStatTreeColumnClick(Sender: TBaseVirtualTree;
  Column: TColumnIndex; Shift: TShiftState);
var
  Node: pvirtualnode;
  Rotationline: trotationline;
begin
  Node := UnitStatTree.focusednode;
  if not assigned(Node) or (Sender.GetNodeLevel(Node) = 0) then
    exit;
  Rotationline := ptreeGenericdata(UnitStatTree.GetNodeData(Node)).BasicND.p;
  case Column of
    // filter
    0:
      begin
        paramGraph.overridefiltercheck := true;
        if getSpellDefaultFilter(Rotationline.spell.id) then
          SpellTree.CheckState[pvirtualnode(Rotationline.spell.pnode)] :=
            csunCheckedPressed
        else
          SpellTree.CheckState[pvirtualnode(Rotationline.spell.pnode)] :=
            csCheckedNormal;
      end;
  end;
end;

procedure TForm1.StatTreeFocusChanged(Sender: TBaseVirtualTree;
  Node: pvirtualnode; Column: TColumnIndex);
var
  Data: ptreeGenericdata;
begin
  if assigned(Node) and (StatTree.GetNodeLevel(Node) > 0) then
  begin
    Data := StatTree.GetNodeData(Node);
    if (paramGraph.WatchedUnit <> Data.BasicND.p) or
      (paramGraph.WatchedUnitUseSum <> (Node.ChildCount > 0)) then
    begin
      paramGraph.WatchedUnit := Data.BasicND.p;
      paramGraph.WatchedUnitUseSum := Node.ChildCount > 0;
      completeRefresh([RefreshUnitStats, RefreshMapOnDetail]);
    end;
  end;
end;

procedure TForm1.UnitStatTreeMouseMove(Sender: TObject; Shift: TShiftState;
  x, y: integer);
var
  Node: pvirtualnode;
  Data: ptreeGenericdata;
  HitInfo: THitInfo;
  ptotal: Pointer;
begin
  UnitStatTree.SetFocus;
  UnitStatTree.GetHitTestInfoAt(x, y, true, HitInfo);
  Node := HitInfo.HitNode;
  if assigned(Node) and (HitInfo.HitColumn > 0) and
    (HitInfo.HitColumn < UnitStatTree.Header.columns.count) then
  begin
    Data := UnitStatTree.GetNodeData(Node);
    if (paramGraph.focusedSpellHint = Data.BasicND.p) and
      (paramGraph.focusedSpelltag = HitInfo.HitColumn) then
      exit
    else
    begin
      // get totalreference
      if UnitStatTree.GetNodeLevel(Node) = 1 then
        ptotal := ptreeGenericdata(UnitStatTree.GetNodeData(Node.Parent))
          .BasicND.p
      else
        ptotal := Data.BasicND.p;

      paramGraph.focusedSpellHint := Data.BasicND.p;
      paramGraph.focusedSpelltag := HitInfo.HitColumn;
      DoHint(UnitStatTree, fillHintDataDetailledStat(HintStatsDtemplate,
          Data.BasicND.p, ptotal,
          tvirtualtreecolumn(UnitStatTree.Header.columns[HitInfo.HitColumn])
            .tag));
    end;
  end
  else
  begin
    paramGraph.focusedSpellHint := nil;
    paramGraph.focusedSpelltag := -1;
    DoHint(UnitStatTree, '');
  end;
end;

procedure TForm1.menu_detailmodePopup(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to menu_detailmode.items.count - 1 do
    menu_detailmode.items[i].enabled := assigned(paramGraph.WatchedUnit);
end;

procedure TForm1.UnitStatTreeContextPopup(Sender: TObject; MousePos: TPoint;

  var Handled: boolean);
var
  Node: pvirtualnode;
  Data: ptreeGenericdata;
begin
  Node := UnitStatTree.GetNodeAt(MousePos.x, MousePos.y);
  if assigned(Node) and (UnitStatTree.GetNodeLevel(Node) > 0) then
  begin
    Data := UnitStatTree.GetNodeData(Node);
    paramGraph.focusedSpell := trotationline(Data.BasicND.p).spell;
  end
  else
    paramGraph.focusedSpell := nil;
  CheckAll1.Visible := false;
  SpellPopup.Popup(mouse.cursorpos.x, mouse.cursorpos.y);
  Handled := true;
end;

procedure TForm1.SpellTreeContextPopup(Sender: TObject; MousePos: TPoint;

  var Handled: boolean);
var
  Node: pvirtualnode;
  Data: ptreeGenericdata;
begin
  Node := SpellTree.GetNodeAt(MousePos.x, MousePos.y);
  if assigned(Node) then
  begin
    Data := SpellTree.GetNodeData(Node);
    paramGraph.focusedSpell := tspellinfo(Data.BasicND.p);
  end
  else
    paramGraph.focusedSpell := nil;
  CheckAll1.Visible := true;
  SpellPopup.Popup(mouse.cursorpos.x, mouse.cursorpos.y);
  Handled := true;
end;

procedure TForm1.unitTreeContextPopup(Sender: TObject; MousePos: TPoint;

  var Handled: boolean);
begin
  paramGraph.unittreenode := unitTree.GetNodeAt(MousePos.x, MousePos.y);
  UnitTreePopup.Popup(mouse.cursorpos.x, mouse.cursorpos.y);
  Handled := true;
end;

procedure TForm1.StatTreeContextPopup(Sender: TObject; MousePos: TPoint;

  var Handled: boolean);
begin
  paramGraph.unittreenode := StatTree.GetNodeAt(MousePos.x, MousePos.y);
  StatPopup.Popup(mouse.cursorpos.x, mouse.cursorpos.y);
  Handled := true;
end;

procedure TForm1.StatPopupPopup(Sender: TObject);
var
  Data: ptreeGenericdata;
begin
  if assigned(paramGraph.unittreenode) and
    (StatTree.GetNodeLevel(paramGraph.unittreenode) > 0) then
  begin
    Data := StatTree.GetNodeData(paramGraph.unittreenode);
    Stat_SetFocus.Visible := true;
    CheckUnitOnWeb2.Visible := true;
    CheckUnitOnWeb2.Caption := 'Check' + bracket_string
      (getunitname(tUnitData(Data.BasicND.p), [])) + 'on Web';
    Stat_SetFocus.Caption := 'Toggle Focus on: ' + getunitname
      (tUnitData(Data.BasicND.p), [getaff]);
  end
  else
  begin
    Stat_SetFocus.Visible := false;
    CheckUnitOnWeb2.Visible := false;
  end;
  ResetFullFilter4.enabled := gfx_ResetFilter.enabled;
  ResetFocus4.enabled := gfx_ResetFocus.enabled;
end;

procedure TForm1.CheckUnitOnWeb2Click(Sender: TObject);
var
  Data: ptreeGenericdata;
begin
  if assigned(paramGraph.unittreenode) then
  begin
    Data := StatTree.GetNodeData(paramGraph.unittreenode);
    getWebInfoForUnit(getunitinfo(tUnitData(Data.BasicND.p)));
  end;
end;

procedure TForm1.UpdateUnit2Click(Sender: TObject);
begin
  if assigned(paramGraph.MenuActiveUnitGfx) then
    editUnitParams(getunitinfo(paramGraph.MenuActiveUnitGfx));
end;

procedure TForm1.UpdateUnitAff2Click(Sender: TObject);
var
  tmpid: integer;
begin
  tmpid := GetUnitOptionMobId(paramGraph.MenuActiveUnitGfx);
  if tmpid > 0 then
    editUnitParams(npcArray[tmpid]);
end;

procedure TForm1.TimeTreePaintText(Sender: TBaseVirtualTree;

  const TargetCanvas: TCanvas; Node: pvirtualnode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  case Column of
    0:
      TargetCanvas.font.color := TimeTree.font.color;
    1:
      begin
        TargetCanvas.font.color := clWhite;
        TargetCanvas.font.Size := 7;
      end;
  end;
end;

procedure TForm1.settimetreefocus(Node: pvirtualnode);
begin
  paramGraph.select.pnode := Node;
  TimeTree.ScrollIntoView(Node, false);
  TimeTree.repaint;
end;

procedure TForm1.treeOnlyInCombat1Click(Sender: TObject);
begin
  ViewPortRefresh;
end;

procedure TForm1.GfxDrawMarksClick(Sender: TObject);
begin
  Imagemap.changed;
end;

procedure TForm1.Unittreesort0Click(Sender: TObject);
begin
  prefs.sortunitmode := strtointdef(copy(TMenuItem(Sender).name, 13, 1), 0);
  unitTree.Sort(masterNode[1], 0, sdAscending);
  ViewPortRefresh;
end;

procedure TForm1.unitTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: pvirtualnode; Kind: TVTImageKind; Column: TColumnIndex;

  var Ghosted: boolean;

  var ImageIndex: integer);
var
  Data: ptreeGenericdata;
begin
  ImageIndex := -1;
  if Node.Parent = masterNode[1] then
  begin
    Data := unitTree.GetNodeData(Node);
    ImageIndex := getrolefromunitInfo(Data.BasicND.p, false) - 1;
  end;
end;

procedure TForm1.unitTreeGetText(Sender: TBaseVirtualTree; Node: pvirtualnode;
  Column: TColumnIndex; TextType: TVSTTextType;

  var CellText: string);
var
  Data: ptreeGenericdata;
begin
  Data := unitTree.GetNodeData(Node);
  case unitTree.GetNodeLevel(Node) of
    0:
      CellText := guidCharType[pmasternode(Data.BasicND.p).gType];
    1:
      begin
        CellText := tunitinfo(Data.BasicND.p).name;
        if assigned(tunitinfo(Data.BasicND.p).UnitAffiliation) then
          CellText := CellText + parenthese_string
            (getunitname(tunitinfo(Data.BasicND.p).UnitAffiliation, []));
      end;
    2:
      CellText := getunitname(tUnitData(Data.BasicND.p), [getaff,
        getShowVehicleTag]); // + inttohex(tUnitData(Data.BasicND.p).uGUID.mobId,8)+ inttostr(tUnitData(Data.BasicND.p).uGUID.mobId);
  end;
end;

procedure TForm1.MyTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: pvirtualnode; Kind: TVTImageKind; Column: TColumnIndex;

  var Ghosted: boolean;

  var ImageIndex: integer);
var
  Data: ptreedata;
  pStat: reventstat;
begin
  Data := Sender.GetNodeData(Node);
  pStat := Data.BasicND.p.eventStat;
  ImageIndex := -1;
  case Column of
    2:
      if assigned(Data.BasicND.p.sourceUnit) then
        ImageIndex := Data.BasicND.p.sourceUnit.stats.iconrole - 1;
    3:
      if assigned(Data.BasicND.p.destUnit) then
        ImageIndex := Data.BasicND.p.destUnit.stats.iconrole - 1;
  end;
end;

procedure TForm1.ApplicationEvents1Exception(Sender: TObject; e: Exception);
begin
  form9 := tform9.create(self);
  form9.memo1.lines.add('ERRORCHECK' + inttostr(ERRORCHECKPOINT));
  form9.memo1.lines.add(e.Message);
  form9.showmodal;
  form9.free;
  ApplicationEvents1.CancelDispatch;
  Application.Terminate;
end;

procedure TForm1.GfxDrawStatsWidgetClick(Sender: TObject);
begin
  Imagemap.changed;
end;

procedure TForm1.unitTreeMouseMove(Sender: TObject; Shift: TShiftState;
  x, y: integer);
begin
  PageControl1.ShowHint := false;
end;

procedure TForm1.ToggleFocus1Click(Sender: TObject);
begin
  unitTreeFocus(paramGraph.unittreenode);
end;

procedure TForm1.unitTreeFocus(Node: pvirtualnode);
var
  Data: ptreeGenericdata;
  nodechild: pvirtualnode;
  udata: tUnitData;
  uinfo: tunitinfo;
  i: integer;
begin
  udata := nil;
  uinfo := nil;
  if assigned(Node) then
  begin
    Data := unitTree.GetNodeData(Node);
    case unitTree.GetNodeLevel(Node) of
      0:
        ;
      1:
        if tunitinfo(Data.BasicND.p).unittype = unitisplayer then
        begin
          nodechild := Node.firstchild;
          if assigned(nodechild) then
          begin
            Data := unitTree.GetNodeData(nodechild);
            udata := Data.BasicND.p;
          end
        end
        else
          uinfo := Data.BasicND.p;
      2:
        begin
          udata := Data.BasicND.p;
        end
    end;
    if assigned(udata) then
    begin
      if upUnitRef in udata.params then
        udata.params := udata.params - [upUnitRef]
      else
        udata.params := udata.params + [upUnitRef];
      paramGraph.unitRef := isUnitRefActive;
      gfx_ResetFocus.enabled := paramGraph.unitRef;
      completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats,
        RefreshMap]);
      exit;
    end;
    if assigned(uinfo) then
    begin
      for i := 0 to uinfo.list.count - 1 do
      begin
        udata := uinfo.list.items[i];
        if uinfo.focusInList then
          udata.params := udata.params - [upUnitRef]
        else
          udata.params := udata.params + [upUnitRef];
      end;
      paramGraph.unitRef := isUnitRefActive;
      gfx_ResetFocus.enabled := paramGraph.unitRef;
      completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats,
        RefreshMap]);
    end;
  end;
end;

procedure TForm1.ShowOnlyAllUnit1Click(Sender: TObject);
var
  u: tunitinfo;
  ud: tUnitData;
  i: integer;
  canceltype: boolean;
begin
  if assigned(paramGraph.MenuActiveUnitGfx) then
  begin
    canceltype := upUnitRef in paramGraph.MenuActiveUnitGfx.params;
    u := getunitinfo(paramGraph.MenuActiveUnitGfx);
    for i := 0 to u.list.count - 1 do
    begin
      ud := u.list.items[i];
      if canceltype then
        ud.params := ud.params - [upUnitRef]
      else
        ud.params := ud.params + [upUnitRef];
    end;
    paramGraph.unitRef := isUnitRefActive;
    gfx_ResetFocus.enabled := paramGraph.unitRef;
    completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats, RefreshMap]);
  end;
end;

procedure TForm1.ShowOnlyUnit1Click(Sender: TObject);
begin
  if assigned(paramGraph.MenuActiveUnitGfx) then
  begin
    if upUnitRef in paramGraph.MenuActiveUnitGfx.params then
      paramGraph.MenuActiveUnitGfx.params :=
        paramGraph.MenuActiveUnitGfx.params - [upUnitRef]
    else
      paramGraph.MenuActiveUnitGfx.params :=
        paramGraph.MenuActiveUnitGfx.params + [upUnitRef];
    paramGraph.unitRef := isUnitRefActive;
    gfx_ResetFocus.enabled := paramGraph.unitRef;
    completeRefresh([RefreshUnit, RefreshStats, RefreshUnitStats, RefreshMap]);
  end;
end;

procedure TForm1.ChatTreeCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: pvirtualnode; Column: TColumnIndex;

  var Result: integer);
var
  data1, data2: ptreeGenericdata;
begin
  data1 := ChatTree.GetNodeData(Node1);
  data2 := ChatTree.GetNodeData(Node2);
  Result := pChatEvent(data1.BasicND.p).Time - pChatEvent(data2.BasicND.p).Time;
end;

// ------------------replay------------------

procedure TForm1.InitBitmap2;
var
  l: TPositionedLayer;
begin
  with ImageReplay do
  begin
    Scale := 1;
    Bitmap.SetSize(2, 2);
    Bitmap.clear(color32($00AAAAAA));
    Buffer.StippleStep := 0.5;
    BufferOversize := 0;
  end;
  l := TPositionedLayer.create(ImageReplay.Layers);
  l.Location := FloatRect(0, 0, 2, 2);
  l.OnPaint := PaintSimpleDrawingHandler2;
end;

// ----------------------


procedure TForm1.PaintSimpleDrawingHandler2(Sender: TObject; Buffer: tbitmap32);
var
  i, j: integer;
  p: pEvent;
  authReplay: boolean;
const
  authparams = [eventIsDamage, eventisAuraApply, eventisAuraRefresh, eventIsInterrupt, eventIsHeal];
  forbidparams = [eventIsperiodic];
begin
  Buffer.font.Name := 'Arial';
  Buffer.font.Style := [];
  Buffer.font.color := clBlack;
  Buffer.font.Size := FONT_SIZE;
  if dontdisturb or (paramGraph.select.state <> sS_valid) then
  begin
    Buffer.textout(10, 24, WAITING_FOR_DATA);
    exit;
  end;

  replayHighlight.clear;
  // -----------------------
  ReplayGenerateUnitPos(eventlist, EventDeathlist, imagereplay.width, imagereplay.height, paramgraph.select.startTime, butreplay_autofit.down);
   {$IFDEF DEBUG}
  //  caption := inttostr(crawlCount);
   {$ENDIF}
  ReplayDrawGrid(Buffer, imagereplay.width, imagereplay.height );
  // infoTime
  Buffer.textout(10, 5, GetRealTimeFromTimeEvent(StartTimeStamp,
      replay.startTime, paramGraph.select.startTime));

  // draw events
  for i := replay.startId downto 0 do
  begin
    p := Eventlist[i];
    if p.Time < replay.startTime - (REPLAY_FRAMESTEP + 5) then
      break;

    if not assigned(p.destUnit) or not p.destUnit.replaydata.r.isinGfx then
      continue;

    // define spellHighlight
    if (spellIsAvoidable in p.spell.constantParams.option2) then
    begin
      if p.inAlertFilter then
      begin
        p.destUnit.replaydata.r.ishit := p.spell;
        p.destUnit.replaydata.r.color32 := color32
          (p.spell.constantParams.avoidableColor);
        addreplayHighligh(p.spell);
      end;
    end;

    if not(eventIsBothSide in p.params) then
      continue;
    if not p.sourceUnit.replaydata.r.isinGfx then
      continue;

    if paramGraph.unitRef then
      if not isEventOnFocus(p, btnFocusMode.down, globalFocusType) then
        continue;

    if gfx_ResetFilter.enabled then
      authReplay := IsEventInFilter(p) // on filter
    else // no filter
      authReplay := (p.params * authparams <> []) and (p.params * forbidparams = []); ;

    if authReplay then
    begin
      replayDrawArrow(Buffer, p.sourceUnit.replaydata.r.x,
      p.sourceUnit.replaydata.r.y, p.destUnit.replaydata.r.x,
      p.destUnit.replaydata.r.y, p.getcolor);
      for j := 0 to high(p.sourceUnit.replaydata.r.event) do
      begin
        if p.sourceUnit.replaydata.r.event[j] = nil then
          p.sourceUnit.replaydata.r.event[j] := p;
        if p.spell = pevent(p.sourceUnit.replaydata.r.event[j]).spell then
          break;
      end;
    end;
  end;

  //final display
  if replay.UseUnitLoc then
    drawUnits(buffer, drawUnitCircle, markedicon);
  drawUnits(buffer, drawUnitInfo, markedicon);
  drawhighLightlabel(buffer, imageReplay.width);
end;


// commands

procedure TForm1.setReplay_circle(b: boolean);
begin
  replay.UseUnitLoc := b and AuthUse54Log;
  if not AuthUse54Log then
    butreplay_circle.down := false;
  butreplay_circle.enabled := AuthUse54Log;
end;

procedure TForm1.butreplay_autofitClick(Sender: TObject);
begin
  ImageReplay.changed;
end;

procedure TForm1.butreplay_circleClick(Sender: TObject);
begin // m
  replay.UseUnitLoc := (not replay.UseUnitLoc) and AuthUse54Log;
  replay.Evaluateratio := true;
  ImageReplay.changed;
end;

procedure TForm1.butreplay_fitimageClick(Sender: TObject);
begin // l
  replay.Evaluateratio := true;
  ImageReplay.changed;
end;

procedure tform1.updateReplayTimer(enabled: boolean);
begin
  replayTimer.enabled:= enabled;
  if enabled then
    butreplay_play.imageIndex := 51
  else
    butreplay_play.imageIndex := 50;
end;

procedure TForm1.butreplay_playClick(Sender: TObject);
begin
  replayTimer.tag := 1;
  updateReplayTimer(not replayTimer.enabled);
end;

procedure TForm1.butreplay_showAttackClick(Sender: TObject);
begin
  REPLAY_DRAWATTACK:= butreplay_showAttack.down;
  imagereplay.changed;
end;

procedure TForm1.butreplay_showPlayerClick(Sender: TObject);
begin
  REPLAY_DRAWPLAYERCIRCLE:= butreplay_showPlayer.down;
  imagereplay.changed;
end;

procedure TForm1.replayplay(playforward: integer; stopTimer: boolean = false);
begin
  if stopTimer then
    updateReplayTimer(false);
  replay.startTime := replay.startTime + REPLAY_FRAMESTEP * playforward;

  if replay.startTime > paramGraph.select.endTime then
  begin
    replay.startTime := paramGraph.select.endTime;
    paramGraph.repere := replay.startTime;
    replay.startId := getReplayIdFromTime(eventlist, replay.startTime, 1);
    updateReplayTimer(false);
    ImageReplay.changed;
    Imagemap.changed;
    exit;
  end;
  if replay.startTime < paramGraph.select.startTime then
  begin
    replay.startTime := paramGraph.select.startTime;
    paramGraph.repere := replay.startTime;
    replay.startId := getReplayIdFromTime(eventlist, replay.startTime, -1);
    ImageReplay.changed;
    Imagemap.changed;
    exit;
  end;

  paramGraph.repere := replay.startTime;
  replay.startId := getReplayIdFromTime(eventlist, replay.startTime, 1);
  ImageReplay.changed;
  Imagemap.changed;
end;

procedure TForm1.replayTimerTimer(Sender: TObject);
begin
  if PageControl2.ActivePageIndex <> 2 then
    updateReplayTimer(false);
  replayplay(replayTimer.tag);
end;

// -----------scrolling image

procedure TForm1.ImageReplayMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; x, y: integer; Layer: TCustomLayer);
begin
  if dontdisturb then
    exit;
  if not replay.UseUnitLoc then
    exit;

  replay.mouseHasMoved:= false;
  replay.timemousedown:= gettickcount;

  if (Shift = [ssLeft]) and assigned(replay.unitOnMouse) then
    begin
       replay.SelectedUnit := replay.unitOnMouse;
       replay.mouseIsSelecting:= true;
       ImageReplay.changed;
       exit;
    end;

  if (Shift = [ssLeft, ssCtrl]) then
  begin
    ImageReplay.Cursor := crSizeWE;
    screen.Cursor := crSizeWE;
  end
  else if not (ssRight in  Shift) then
  begin
    ImageReplay.Cursor := crSize;
    screen.Cursor := crSize;
  end;

  replay.oldMouseOffsetx := x;
  replay.oldMouseOffsety := y;
end;

procedure TForm1.ImageReplayMouseMove(Sender: TObject; Shift: TShiftState;
  x, y: integer; Layer: TCustomLayer);
var
  diffx, diffy: integer;
  i, tmpSize: integer;
  ul: tUnitData;
  p:^integer;
begin
  if dontdisturb then
    exit;
  if not ImageReplay.Focused then
  begin
    ImageReplay.SetFocus;
    exit;
  end;

  if replay.mouseIsSelecting then exit;
  replay.mouseHasMoved:= true;

  replay.unitOnMouse := nil;
  for i := replaylist.count - 1 downto 0 do
  begin
    ul := replaylist[i];
    if ul.replaydata.r.isinGfx then
    begin
      if (x > ul.replaydata.r.x - REPLAY_UNITSIZE_DETECT) and
        (x < ul.replaydata.r.x + REPLAY_UNITSIZE_DETECT) then
        if (y > ul.replaydata.r.y - REPLAY_UNITSIZE_DETECT) and
          (y < ul.replaydata.r.y + REPLAY_UNITSIZE_DETECT) then
        begin
          replay.unitOnMouse := ul;
          break;
        end;
    end;
  end;

  if replay.UseUnitLoc then
  begin
    if Shift = [ssLeft, ssCtrl] then
    begin
     p := nil;
     if (replay.selectedUnit <>nil) and (replay.selectedUnit.uGUID.mobID > 0) then
     begin
          p:= @getunitInfo(replay.selectedUnit).constantParams.replaySize;
          tmpsize:= p^;
          if tmpSize = 0 then tmpSize := 500;
     end
     else
        tmpsize:= replay.playercircle;

      diffx := replay.oldMouseOffsetx - x;
      replay.oldMouseOffsetx := x;
      replay.oldMouseOffsety := y;

      tmpsize := tmpsize - diffx * 2;
      if tmpsize < MINUNITCIRCLESIZE then
        tmpsize := MINUNITCIRCLESIZE;
      if tmpsize > MAXUNITCIRCLESIZE then
        tmpsize := MAXUNITCIRCLESIZE;

      if p= nil then replay.playercircle := tmpSize else p^:= tmpsize;

      StatusBar1.Panels[2].Text := format('Circle Size: %.1fyd',
        [tmpsize / 100]);
      ImageReplay.changed;
      exit;
    end;

    if Shift = [ssLeft] then
    begin
      diffx := replay.oldMouseOffsetx - x;
      diffy := replay.oldMouseOffsety - y;
      replay.oldMouseOffsetx := x;
      replay.oldMouseOffsety := y;
      replay.imgoffsetx := replay.imgoffsetx - diffx;
      replay.imgoffsety := replay.imgoffsety - diffy;
      ImageReplay.changed;
      exit;
    end;
  end;

  if assigned(replay.unitOnMouse) then
    StatusBar1.Panels[2].Text := getunitname(replay.unitOnMouse, [])
  else
    StatusBar1.Panels[2].Text := '';
end;

procedure TForm1.ImageReplayMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; x, y: integer; Layer: TCustomLayer);
begin

  if dontdisturb then
    exit;
  if not replay.UseUnitLoc then
    exit;
  ImageReplay.Cursor := crDefault;
  screen.Cursor := crDefault;

  if (gettickcount-replay.timeMousedown < 300) and (not replay.mouseHasMoved) and (replay.unitOnMouse = nil) then
  begin
     replay.SelectedUnit := nil;
     ImageReplay.changed;
  end;
  replay.mouseIsSelecting:= false;
  replay.mouseHasMoved:= false;
end;

procedure TForm1.ImageReplayMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: boolean);
begin
  ReplayZoom(MousePos.x, MousePos.y, 0.97);
  releasecapture;
end;

procedure TForm1.ImageReplayMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: boolean);
begin
  ReplayZoom(MousePos.x, MousePos.y, 1.03);
  releasecapture;
end;

procedure TForm1.ReplayZoom(mx, my: integer; ratio: double);
var
  x, y: integer;
  nc: TPoint;
begin
  if dontdisturb then
    exit;
  if not replay.UseUnitLoc then
    exit;
  x := mx - (Form1.left + ImageReplay.left);
  y := my - (Form1.top + ImageReplay.top);

  nc := getwowcoords(x, y);
  replay.ratio := replay.ratio * ratio;

  // limit
  LimitRatio;

  nc := getreplaycoord(nc.x, nc.y);
  replay.imgoffsetx := replay.imgoffsetx + (x - nc.x);
  replay.imgoffsety := replay.imgoffsety + (y - nc.y);
  ImageReplay.changed;
end;

end.
