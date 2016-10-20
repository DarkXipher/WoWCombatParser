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
unit wcr_unitOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wcr_Parser_Events, wcr_ressource, wcr_Const, ComCtrls, ExtCtrls, GR32_RangeBars;

type
  TForm3 = class(TForm)
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    CheckBox4: TCheckBox;
    Edit1: TEdit;
    UnitnoFriend: TCheckBox;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    Label1: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label2: TLabel;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    ComboBox2: TComboBox;
    CheckBox5: TCheckBox;
    ComboBox3: TComboBox;
    Label3: TLabel;
    CheckBox11: TCheckBox;
    Shape1: TShape;
    ColorDialog1: TColorDialog;
    Label4: TLabel;
    GaugeBar1: TGaugeBar;
    Label5: TLabel;
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GaugeBar1Change(Sender: TObject);
  private
    firstimeshow:boolean;

    procedure initaffiliation(bypassvalidation:boolean);
  public
    currentmobId:integer;
    localUnit:tunitInfo;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.ComboBox1Change(Sender: TObject);
begin
  if tunitinfo(ComboBox1.Items.Objects[ComboBox1.Itemindex]).mobId = currentmobId then
  begin
    checkbox3.Checked:=false;
    checkbox3.enabled:=false;
  end
  else
  begin
    checkbox2.Checked:=false;
    checkbox3.enabled:=true;
    checkbox3.Checked:=true;
    shape1.brush.color:= clYellow;
  end;
end;

procedure tform3.initaffiliation(bypassvalidation:boolean);
var i:integer;
begin
    ComboBox1.Items.Clear;
   //boss---->
    for i:=1 to high(npcarray) do
      if (uoIsBoss in GetUnitOption(npcArray[i],bypassvalidation)) then
        ComboBox1.Items.AddObject(npcArray[i].name,npcarray[i]);
    ComboBox1.Sorted:=true;
    //index--->
    for i:=0 to ComboBox1.items.count-1 do
      if (uoIsBossAffiliated in localUnit.constantParams.option1) and
         (tunitinfo(ComboBox1.Items.Objects[i]).mobId = localUnit.constantParams.param1) then ComboBox1.Itemindex:=i;

    //dungeon
    ComboBox2.Items.Clear;
   //boss---->
    for i:=0 to donjonlist.count-1 do
        ComboBox2.Items.AddObject(pdonjonitem(donjonlist.items[i]).longname,donjonlist.items[i]);
    ComboBox2.Sorted:=true;
    //index--->
    if localUnit.constantParams.DonjonAff> ComboBox2.items.count-1 then localUnit.constantParams.DonjonAff:=0;
    for i:=0 to ComboBox2.items.count-1 do
    begin
      if pdonjonitem(ComboBox2.Items.Objects[i]).id= localUnit.constantParams.DonjonAff then ComboBox2.Itemindex:=i;
    end;
end;

procedure TForm3.Shape1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  colordialog1.color:= Shape1.brush.color;
  if colordialog1.execute then Shape1.brush.color:=colordialog1.color;
end;

procedure TForm3.CheckBox6Click(Sender: TObject);
begin
  if not firstimeshow then initaffiliation(CheckBox6.checked);
end;

procedure TForm3.FormShow(Sender: TObject);
var i: integer;
begin
  if firstimeshow then
  begin
    font.name:=MAIN_FONT;
    edit1.text:=localUnit.name;
    edit2.text:= inttostr(localUnit.mobId);
    currentmobId:=localUnit.mobId;
    checkbox1.checked:=uoIsBan in localUnit.constantParams.option1;
    checkbox2.checked:=uoIsBoss in localUnit.constantParams.option1;
    checkbox3.checked:=uoIsBossAffiliated in localUnit.constantParams.option1;
    checkbox4.checked:=uoDontMakePlayerAffiliation in localUnit.constantParams.option1;
    checkbox5.checked:=uoCheckForEndEncounterEvent in localUnit.constantParams.option1;
    checkbox7.checked:=uoCheckForDeath in localUnit.constantParams.option1;
    checkbox8.checked:=uoCheckForSpecialEvent in localUnit.constantParams.option1;
    checkbox9.checked:=uoIsSecure in localUnit.constantParams.option1;
    checkbox10.checked:=uoHeuristicCheck in localUnit.constantParams.option1;
    checkbox11.checked:=uoReplayEmphasis in localUnit.constantParams.option1;
    edit3.Text:=inttostr(localUnit.constantParams.option2);
    edit4.Text:=inttostr(localUnit.constantParams.timeOut);
    gaugebar1.position:=localUnit.constantParams.replaySize;
    UnitnoFriend.checked:= uoForceNotFriendly in localUnit.constantParams.option1;
    checkbox3.enabled:=checkbox3.checked;
    initaffiliation(CheckBox6.checked);
    shape1.brush.color:=localUnit.constantParams.ReplayColor;
    if shape1.brush.color = 0 then   shape1.brush.color:= DEFAULT_NPC_COLOR;
     for i :=2 to high(powerTypeparam) do
        ComboBox3.Items.Add(powerTypeparam[i]);
     combobox3.itemindex:= localUnit.constantParams.manaType;

    CheckBox2.Enabled:=checkbox9.visible or not checkbox9.checked;
  end;
  firstimeshow:=false;
end;

procedure TForm3.GaugeBar1Change(Sender: TObject);
begin
    label5.caption := inttostr(gaugebar1.position);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  firstimeshow:=true;
  gaugebar1.max:= MAXUNITCIRCLESIZE;
end;

procedure TForm3.Button1Click(Sender: TObject);
var tmpvalue:integer;
begin
      localUnit.name:=  edit1.text;
      if checkbox1.checked then
        localUnit.constantParams.option1:=localUnit.constantParams.option1+[uoIsBan]
      else
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoIsBan];

      if UnitnoFriend.checked then
        localUnit.constantParams.option1:=localUnit.constantParams.option1+[uoForceNotFriendly]
      else
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoForceNotFriendly];

      
      if checkbox2.checked then
        localUnit.constantParams.option1:=localUnit.constantParams.option1+[uoIsBoss]
      else
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoIsBoss];

      if checkbox4.checked then
        localUnit.constantParams.option1:=localUnit.constantParams.option1+[uoDontMakePlayerAffiliation]
      else
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoDontMakePlayerAffiliation];

      if checkbox7.checked then
        localUnit.constantParams.option1:=localUnit.constantParams.option1+[uoCheckForDeath]
      else
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoCheckForDeath];


      if checkbox8.checked then
        localUnit.constantParams.option1:=localUnit.constantParams.option1+[uoCheckForSpecialEvent]
      else
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoCheckForSpecialEvent];

      if checkbox9.checked then
        localUnit.constantParams.option1:=localUnit.constantParams.option1+[uoIsSecure]
      else
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoIsSecure];

      if checkbox10.checked then
        localUnit.constantParams.option1:=localUnit.constantParams.option1+[uoHeuristicCheck]
      else
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoHeuristicCheck];

      if checkbox11.checked then
        localUnit.constantParams.option1:=localUnit.constantParams.option1+[uoReplayEmphasis]
      else
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoReplayEmphasis];

       if checkbox5.checked then
        localUnit.constantParams.option1:=localUnit.constantParams.option1+[uoCheckForEndEncounterEvent]
      else
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoCheckForEndEncounterEvent];


      //nb bossaff death
      tmpvalue:=strtointdef(edit3.Text,0);
      if tmpvalue<0 then tmpvalue:=0;
      if tmpvalue>255 then tmpvalue:=255;
      if not (uoIsBoss in localUnit.constantParams.option1) then tmpvalue:=0;
      localUnit.constantParams.option2:= tmpvalue;

      //manatype
      localUnit.constantParams.manatype:= comboBox3.itemIndex;

       //replaySize
      localUnit.constantParams.replaySize:= gaugebar1.position;

       //replayColor
       if shape1.brush.color <> DEFAULT_NPC_COLOR then
          localUnit.constantParams.ReplayColor:= shape1.brush.color
       else
          localUnit.constantParams.ReplayColor := 0;

      //timeout
      tmpvalue:=strtointdef(edit4.Text,0);
      if tmpvalue<0 then tmpvalue:=0;
      if not (uoIsBoss in localUnit.constantParams.option1) then tmpvalue:=0;
      localUnit.constantParams.timeout:= tmpvalue;
      if checkbox3.checked and (ComboBox1.Itemindex>-1) then
      begin
        localUnit.constantParams.option1:=localUnit.constantParams.option1+[uoIsBossAffiliated];
        localUnit.constantParams.param1:=tunitinfo(ComboBox1.Items.Objects[ComboBox1.Itemindex]).mobId;
      end
      else
      begin
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoIsBossAffiliated];
        localUnit.constantParams.param1:=0;
      end;

      if uoIsBoss in localUnit.constantParams.option1 then
      begin
        localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoIsBossAffiliated];
        if ComboBox2.Itemindex<>-1 then localUnit.constantParams.DonjonAff:=pdonjonitem(ComboBox2.Items.Objects[ComboBox2.Itemindex]).id;
      end;
      if uoIsBossAffiliated in localUnit.constantParams.option1 then localUnit.constantParams.option1:=localUnit.constantParams.option1-[uoIsBoss];
end;

procedure TForm3.CheckBox2Click(Sender: TObject);
begin
  if not firstimeshow then
  begin
    if CheckBox2.Checked then edit3.Text:='1' else edit3.Text:='0';
    CheckBox7.Checked:= CheckBox2.Checked;
    CheckBox11.Checked:= CheckBox2.Checked;
    if CheckBox2.Checked then
    begin
        gaugebar1.position := 800;
        shape1.brush.color:= clYellow;
    end
    else gaugebar1.position := 500;
  end;
end;

end.
