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
unit wcr_spellOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, StdCtrls, wcr_Parser_Events, wcr_Const, ComCtrls, wcr_ressource, ExtCtrls;

type
  rCS = record
    name:string;
    id:integer;
  end;
  pCS=^rCS;

  rTD = record
    ND: pCS;
  end;
  pTD=^rTD;

  TForm2 = class(TForm)
    optSpellTree: TVirtualStringTree;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    ComboBox2: TComboBox;
    panel1: TGroupBox;
    cb_noabsorbAff: TCheckBox;
    Label7: TLabel;
    Edit1: TEdit;
    CheckBox4: TCheckBox;
    ComboBox1: TComboBox;
    Label3: TLabel;
    CheckBox5: TCheckBox;
    ColorDialog1: TColorDialog;
    Shape1: TShape;
    chDamage: TCheckBox;
    chAura: TCheckBox;
    chHeal: TCheckBox;
    chInterrupt: TCheckBox;
    Edit2: TEdit;
    UpDown1: TUpDown;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure optSpellTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: String);
    procedure optSpellTreeFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure optSpellTreeInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    Spellid:integer;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
var i:integer;
  PS:pCS;
begin
  font.name:=MAIN_FONT;
  Label1.caption:='Spell Param are used to define player class and to evaluate their hp pool.'+#13;
  Label1.caption:=Label1.caption+'Please assign only exclusive Spell for each Class.';
  Label2.caption:='Spell Affiliation is used to link pet or totem/object to their owner.'+#13;
  Label2.caption:= Label2.caption+'To check this, the spell MUST be exclusive (source_Owner -> dest_Affiliated_Unit). ';
  Label2.caption:= Label2.caption+'If you are not sure, dont check it.'+#13;
  Label2.caption:= Label2.caption+'(It''s not necessary to assign spell related to SPELL_SUMMON, or SPELL_CREATE events)';
  optSpellTree.NodeDataSize := SizeOf(rTD);
  
  for i:=0 to high(ClasseStat) do
  begin
    new(PS);
    pS.name:=ClasseStat[i].name;
    pS.id:=i;
    optSpellTree.AddChild(nil,pS);
  end;

  for i :=0 to high(classePlayer) do
    ComboBox1.Items.Add(classePlayer[i]);

  for i :=0 to high(eventValue) - 2 do
    ComboBox2.Items.Add(eventValue[i].name);


end;

procedure TForm2.optSpellTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: String);
var data:pTD;
begin
  data:=sender.GetNodeData(node);
  celltext:=data.nd.name;
end;

procedure TForm2.optSpellTreeFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var data:pTD;
begin
  data:=sender.GetNodeData(node);
  dispose(data.nd);
end;

procedure TForm2.optSpellTreeInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  node.CheckType:=ctRadioButton;
end;

procedure TForm2.Shape1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  colordialog1.color:= Shape1.brush.color;
  if colordialog1.execute then Shape1.brush.color:=colordialog1.color;
end;

procedure TForm2.Button1Click(Sender: TObject);
var node:pvirtualnode;
    data:pTD;
    r:rConstantSpellParams;
    tmpvalue:integer;
    tmpAvoidableEventtype: byte;
begin
    if checkbox1.Checked then include(r.option2,spellIsAffiliation) else exclude(r.option2,spellIsAffiliation);
    if checkbox2.Checked then include(r.option2,spellIsReverseAffiliation) else exclude(r.option2,spellIsReverseAffiliation);
    if checkbox3.Checked then include(r.option2,spellIsSingleAura) else exclude(r.option2,spellIsSingleAura);
    if checkbox4.Checked then include(r.option2,spellCanInterrupt) else exclude(r.option2,spellCanInterrupt);
    if checkbox5.Checked then include(r.option2,spellisAvoidable) else exclude(r.option2,spellisAvoidable);
    if checkbox6.Checked then include(r.option2,spellIstanking) else exclude(r.option2,spellIstanking);
    if checkbox7.Checked then include(r.option2,spellIsHM) else exclude(r.option2,spellisHM);
    if checkbox8.Checked then include(r.option2, spellCloseBossEvent) else exclude(r.option2, spellCloseBossEvent);
    if checkBox9.Checked then include(r.option2, spellExcludeForRole) else exclude(r.option2, spellExcludeForRole);
    if checkBox10.Checked then include(r.option2, spellExcludeForBoss) else exclude(r.option2, spellExcludeForBoss);
    if checkBox11.Checked then include(r.option2, spellIsExcludedForTracking) else exclude(r.option2, spellIsExcludedForTracking);
    if checkBox12.Checked then include(r.option2, spellIsIncludedForTracking) else exclude(r.option2, spellIsIncludedForTracking);

    tmpAvoidableEventtype := 0;
    if chDamage.Checked then tmpAvoidableEventtype := tmpAvoidableEventtype or 1;
    if chAura.Checked then tmpAvoidableEventtype := tmpAvoidableEventtype or 2;
    if chInterrupt.Checked then tmpAvoidableEventtype := tmpAvoidableEventtype or 4;
    if chHeal.Checked then tmpAvoidableEventtype := tmpAvoidableEventtype or 8;

    r.AvoidableEventtype := tmpAvoidableEventtype;
    r.maxStack:=updown1.position;

    tmpvalue:=strtointdef(edit1.Text,0);
    if tmpvalue>100000 then tmpvalue:=100000;
    if tmpvalue<0 then tmpvalue:=0;
    r.forcedCastTime := tmpvalue;
    r.eventID := ComboBox2.itemIndex;
    r.forcedrole := ComboBox1.itemIndex;
    if cb_noabsorbAff.Checked then include(r.option2,spellisnoAffAbsorb)  else exclude(r.option2,spellisnoAffAbsorb);
    r.avoidableColor := shape1.Brush.color;
    node:=optSpellTree.getfirst;
    while assigned(node) do
    begin
      if node.checkstate=csCheckedNormal then
      begin
         data:=optSpellTree.GetNodeData(node);
         r.option1:=data.nd.id;
         break;
      end;
      node:=node.NextSibling;
    end;

    setSpellParams(Spellid,r);
end;

procedure TForm2.FormShow(Sender: TObject);
var r:rConstantSpellParams;
    node:pvirtualnode;
    data:pTD;
    sp: tspellInfo;
begin
  Caption:=format('%s (%d)',[GetSpellName(Spellid),spellid]);
  sp := getSpellFromID(Spellid);
  r:=GetSpellParams(sp);
  CheckBox1.checked:=spellisAffiliation in r.option2;
  CheckBox2.checked:=spellisReverseAffiliation in r.option2;
  CheckBox3.checked:=spellisSingleAura in r.option2;
  CheckBox4.checked:=spellCanInterrupt in r.option2;
  checkbox5.Checked:= spellisAvoidable in r.option2;
  CheckBox6.checked:=spellIstanking in r.option2;
  CheckBox7.checked:=spellIsHM in r.option2;
  CheckBox8.checked:=spellCloseBossEvent in r.option2;
  CheckBox9.checked:=spellExcludeForRole in r.option2;
  CheckBox10.checked:=spellExcludeForBoss in r.option2;
  CheckBox11.checked:=spellIsExcludedForTracking in r.option2;
  CheckBox12.checked:=spellIsIncludedForTracking in r.option2;

  updown1.position:= r.maxStack;
  chDamage.Checked:= r.AvoidableEventtype and 1 = 1;
  chAura.Checked:= r.AvoidableEventtype and 2 = 2;
  chInterrupt.Checked:= r.AvoidableEventtype and 4 = 4;
  chHeal.Checked:= r.AvoidableEventtype and 8 = 8;

  edit1.Text:= inttostr(r.forcedCastTime);
  ComboBox2.itemIndex := r.eventID;
  ComboBox1.itemIndex := r.forcedrole;
  cb_noabsorbAff.Checked := spellisnoAffAbsorb in r.option2;
  if r.avoidableColor <> 0 then shape1.Brush.color :=r.avoidableColor;
  //classeId
  node:=optSpellTree.getfirst;
    while assigned(node) do
    begin
      data:=optSpellTree.GetNodeData(node);
      if data.nd.id = r.option1  then
      begin
         node.checkstate:=csCheckedNormal;
         exit;
      end;
      node:=node.NextSibling;
    end;

end;

end.
