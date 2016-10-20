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
unit wcr_options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GR32_RangeBars, ExtCtrls, wcr_const, wcr_ressource,
  BrwsFldr;

type
  TOptionsForm = class(TForm)
    Panel10: TPanel;
    ResizeStats: TCheckBox;
    CapOverkill: TCheckBox;
    NoSpellFailed: TCheckBox;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    GaugeBar4: TGaugeBar;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    GaugeBar1: TGaugeBar;
    GroupBox7: TGroupBox;
    Edit2: TEdit;
    GroupBox6: TGroupBox;
    WebLinkEdit: TEdit;
    GroupBox8: TGroupBox;
    Label5: TLabel;
    DefaultServerNameEdit: TEdit;
    ArmoryLinkEdit: TEdit;
    GroupBox9: TGroupBox;
    UnitWebLinkEdit: TEdit;
    GroupBox2: TGroupBox;
    GaugeBar5: TGaugeBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    UnknownEdit: TEdit;
    Label1: TLabel;
    procedure GaugeBar1Change(Sender: TObject);
    procedure GaugeBar4Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  OptionsForm: TOptionsForm;

implementation

{$R *.dfm}

procedure TOptionsForm.GaugeBar1Change(Sender: TObject);
begin
  Label2.caption := inttostr(GaugeBar1.position);
end;

procedure TOptionsForm.GaugeBar4Change(Sender: TObject);
begin
  Label3.caption := LIVE_TIMER[GaugeBar4.position].Name;
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
  GaugeBar4.Min := 1;
  GaugeBar4.Max := high(LIVE_TIMER);
  GaugeBar4.position := prefs.liveupdatetimer;

  GaugeBar1.position := prefs.maxeventinlist;

  GaugeBar5.Min := 0;
  GaugeBar5.Max := high(BaseSizeVar);
  GaugeBar5.position := prefs.InterfaceScale;
  CheckBox3.Checked:=prefs.useShortNumber;
  ResizeStats.Checked := prefs.ResizeStats;
  NoSpellFailed.Checked := prefs.NoSpellFailed;
  CapOverkill.Checked := prefs.CapOverkill;
  CheckBox1.Checked := prefs.openOnIndex;
  CheckBox2.Checked := prefs.useCache;
  Edit2.Text := prefs.livelogpath;
  WebLinkEdit.Text := prefs.WebLink;
  ArmoryLinkEdit.Text := prefs.ArmoryLink;
  DefaultServerNameEdit.Text := prefs.DefaultServerName;
  UnitWebLinkEdit.Text := prefs.UnitWebLink;
  unknownEdit.text:= prefs.unknownlabel;
end;

procedure TOptionsForm.Button3Click(Sender: TObject);
begin
  GaugeBar5.position := 2;
end;

procedure TOptionsForm.Button1Click(Sender: TObject);
begin
  prefs.InterfaceScale := GaugeBar5.position;
  prefs.liveupdatetimer := GaugeBar4.position;
  prefs.maxeventinlist := GaugeBar1.position;
  prefs.openOnIndex := CheckBox1.Checked;
  prefs.ResizeStats := ResizeStats.Checked;
  prefs.NoSpellFailed := NoSpellFailed.Checked;
  prefs.CapOverkill := CapOverkill.Checked;
  prefs.useCache := CheckBox2.Checked;
  prefs.livelogpath := Edit2.Text;
  prefs.WebLink := WebLinkEdit.Text;
  prefs.ArmoryLink := ArmoryLinkEdit.Text;
  prefs.DefaultServerName := DefaultServerNameEdit.Text;
  prefs.UnitWebLink := UnitWebLinkEdit.Text;
  prefs.useShortNumber := CheckBox3.Checked;
  prefs.unknownlabel := trim(unknownEdit.text);
  if prefs.unknownlabel ='' then  prefs.unknownlabel := UNKNOWNNAME;

  if prefs.useShortNumber then
    intToStrEx := inttostrShort
  else
    intToStrEx := inttostrFull;
end;

procedure TOptionsForm.Edit2Click(Sender: TObject);
begin
  setlivelogfolder(OptionsForm);
  Edit2.Text := livelogFile;
end;

end.
