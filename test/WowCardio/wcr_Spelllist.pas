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
unit wcr_Spelllist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VirtualTrees, wcr_Parser_Events, ExtCtrls, Menus, wcr_const;

type
  TFormSpell = class(TForm)
    SpelllistTree: TVirtualStringTree;
    Panel1: TPanel;
    Button1: TButton;
    PopupUnitlist: TPopupMenu;
    AddVirtualSpell1: TMenuItem;
    editSpell1: TMenuItem;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SpelllistTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: String);
    procedure AddVirtualSpell1Click(Sender: TObject);
    procedure editSpell1Click(Sender: TObject);
    procedure SpelllistTreeCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure SpelllistTreeHeaderClick(Sender: TVTHeader;
      HitInfo: TVTHeaderHitInfo);
  private
    procedure editSpell(id:integer);
  public
    { Public declarations }
  end;

var
  FormSpell: TFormSpell;

implementation

uses wcr_unitOpt, wcr_VirtualBoss, wcr_spellOpt;

{$R *.dfm}

procedure TFormSpell.FormCreate(Sender: TObject);
var i:integer;

begin
  font.name:=MAIN_FONT;
  SpelllistTree.NodeDataSize := SizeOf(rtreeGenericdata);
  for i := 1 to spellArray.count-1 do
      if assigned(spellArray[i]) then
        SpelllistTree.AddChild(nil,TNodeGenericData.create(spellArray[i]));
end;

procedure TFormSpell.SpelllistTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: String);
var data: ptreeGenericdata;

begin
  celltext:='';
  data:=SpelllistTree.GetNodeData(node);

  case column of
    0:celltext:= inttostr(tspellinfo(data.BasicND.p).id);
    1:celltext:= tspellinfo(data.BasicND.p).name;
    2:celltext:= ClasseStat[tSpellinfo(data.BasicND.p).constantParams.option1].shortname;
    3:celltext:=ORDCHECK[ord(spellisAffiliation in tSpellinfo(data.BasicND.p).constantParams.option2)];
    4:celltext:=ORDCHECK[ord(spellisSingleAura in tSpellinfo(data.BasicND.p).constantParams.option2)];
    5:;
    6:;
    7:celltext:=ORDCHECK[ord(spellisNoAffAbsorb in tSpellinfo(data.BasicND.p).constantParams.option2)];
    8:;
  end;
end;

procedure TFormSpell.SpelllistTreeHeaderClick(Sender: TVTHeader;
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
        end
        else
          if SortDirection = sdAscending then
            SortDirection := sdDescending
          else
            SortDirection := sdAscending;
        SortTree(SortColumn, SortDirection, False);
      end;
    end;
end;

procedure TFormSpell.AddVirtualSpell1Click(Sender: TObject);
var tmpid:integer;
    tmpname:string;
begin
exit;
  form8:=tform8.create(self);
  form8.caption:='Add new Spell';
  if form8.showmodal=mrOk then
  begin
    tmpid:=strtointdef(form8.Edit1.text,0);
    tmpname:= trim(form8.Edit2.text);

    if CheckLegitSpellIdEx(tmpid) and (not assigned(spellarray[tmpid])) and (tmpname<>'') then
    begin
      spellArray[tmpid]:=tspellInfo.initdata(tmpid,0,tmpname,emptyspellparam);
      editSpell(tmpid);
      SpelllistTree.AddChild(nil,TNodeGenericData.create(spellArray[tmpid]));
      SpelllistTree.Repaint;
    end;
  end;
  form8.free;
end;

procedure TFormSpell.editSpell1Click(Sender: TObject);
var data: ptreeGenericdata;
begin
  if assigned(SpelllistTree.focusednode) then
  begin
    data:=SpelllistTree.GetNodeData(SpelllistTree.focusednode);
    editspell(tspellinfo(data.BasicND.p).id);
    SpelllistTree.Repaint;
  end;
end;

procedure TFormSpell.editSpell(id:integer);
begin
    form2:=tform2.create(self);
    form2.spellid:=id;
    form2.ShowModal;
    form2.free;
end;

procedure TFormSpell.SpelllistTreeCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var s1,s2:tspellinfo;
begin
  s1:=ptreeGenericdata(SpelllistTree.GetNodeData(node1)).basicND.p;
  s2:=ptreeGenericdata(SpelllistTree.GetNodeData(node2)).basicND.p;

  case column of
    1: result:=comparetext(s1.name,s2.name);
    2: result:=comparetext(ClasseStat[s1.constantParams.option1].shortname,ClasseStat[s2.constantParams.option1].shortname);
    3: result:=ord(spellisAffiliation in s2.constantParams.option2)- ord(spellisAffiliation in s1.constantParams.option2);
    4: result:=ord(spellisSingleAura in s2.constantParams.option2)- ord(spellisSingleAura in s1.constantParams.option2);
    5: result:=0;
    6: result:=0;
    7: result:=ord(spellisNoAffAbsorb in s2.constantParams.option2)- ord(spellisNoAffAbsorb in s1.constantParams.option2);
    8: result:=0;
    else result:=s1.id-s2.Id;
  end

end;

end.
