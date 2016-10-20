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
unit wcr_Unitlist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VirtualTrees, wcr_Parser_Events, ExtCtrls, Menus, wcr_const;

type
  TForm7 = class(TForm)
    unitlistTree: TVirtualStringTree;
    Panel1: TPanel;
    Button1: TButton;
    PopupUnitlist: TPopupMenu;
    AddVirtualUnit1: TMenuItem;
    editUnit1: TMenuItem;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure unitlistTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: String);
    procedure AddVirtualUnit1Click(Sender: TObject);
    procedure editUnit1Click(Sender: TObject);
    procedure unitlistTreeCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure unitlistTreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure unitlistTreeHeaderClick(Sender: TVTHeader;
      HitInfo: TVTHeaderHitInfo);
  private
    procedure editunit(u:tunitinfo);
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses wcr_unitOpt, wcr_VirtualBoss;

{$R *.dfm}

procedure TForm7.FormCreate(Sender: TObject);
var i:integer;
begin
  font.name:=MAIN_FONT;
  unitlistTree.NodeDataSize := SizeOf(rtreeGenericdata);
  for i := 1 to high(npcArray) do
      if assigned(npcArray[i]) and (npcArray[i].constantParams.option1<>[]) then
        unitlistTree.AddChild(nil,TNodeGenericData.create(npcArray[i]));
end;

procedure TForm7.unitlistTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: String);
var data: ptreeGenericdata;
begin
  celltext:='';
  data:=unitlisttree.GetNodeData(node);
  case column of
    1: celltext:=tUnitinfo(data.BasicND.p).name;
    2: if uoIsBan in tUnitinfo(data.BasicND.p).constantParams.option1 then celltext:='x';
    3: if uoIsBoss in tUnitinfo(data.BasicND.p).constantParams.option1 then celltext:='x';
    4: if uoIsBossAffiliated in tUnitinfo(data.BasicND.p).constantParams.option1 then celltext:='x';
    5: if (uoIsBossAffiliated in tUnitinfo(data.BasicND.p).constantParams.option1) then CellText:=getunitname(tUnitinfo(data.BasicND.p).constantParams.param1,[],'')+' ['+inttostr(tUnitinfo(data.BasicND.p).constantParams.param1)+']';
    6: if uoDontMakePlayerAffiliation in tUnitinfo(data.BasicND.p).constantParams.option1 then celltext:='x';
    else celltext:=inttostr(tUnitinfo(data.BasicND.p).mobId);
  end;
end;

procedure TForm7.unitlistTreeHeaderClick(Sender: TVTHeader;
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

procedure TForm7.AddVirtualUnit1Click(Sender: TObject);
var tmpid:integer;
    tmpname:string;
begin
  form8:=tform8.create(self);
  form8.caption:='Add new Unit';
  if form8.showmodal=mrOk then
  begin
    tmpid:=strtointdef(form8.Edit1.text,0);
    tmpname:= trim(form8.Edit2.text);


    if (tmpid>0) and (tmpid<high(npcArray)) and (not assigned(npcArray[tmpid])) and (tmpname<>'') then
    begin
            npcArray[tmpid]:=tUnitInfo.initdata(tmpname,0,tmpid,newConstantUnitParam,false,unitIsNpc,[]);
            editunit(npcArray[tmpid]);

            unitlistTree.AddChild(nil,TNodeGenericData.create(npcArray[tmpid]));
            unitlisttree.Repaint;
    end;
  end;
  form8.free;
end;

procedure TForm7.editUnit1Click(Sender: TObject);
var data: ptreeGenericdata;
begin
  if assigned(unitlisttree.focusednode) then
  begin
    data:=unitlisttree.GetNodeData(unitlisttree.focusednode);
    editunit(data.BasicND.p);
    unitlisttree.Repaint;
  end;
end;

procedure tform7.editunit(u:tunitinfo);
begin
    form3:=tform3.create(self);
    form3.CheckBox6.checked:=true;
    form3.localUnit:=u;
    form3.ShowModal;
    form3.free;
end;

procedure TForm7.unitlistTreeCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var u1,u2:tunitinfo;
begin
  u1:=ptreeGenericdata(unitlisttree.GetNodeData(node1)).basicND.p;
  u2:=ptreeGenericdata(unitlisttree.GetNodeData(node2)).basicND.p;
  case column of
    1: result:=comparetext(u1.name,u2.name);
    2: result:=ord(uoIsban in u2.constantParams.option1)- ord(uoIsban in u1.constantParams.option1);
    3: result:=ord(uoIsboss in u2.constantParams.option1)- ord(uoIsboss in u1.constantParams.option1);
    4: result:=ord(uoIsBossAffiliated in u2.constantParams.option1)- ord(uoIsBossAffiliated in u1.constantParams.option1);
    5: result:=comparetext( getunitname(u1.constantParams.param1,[],''),getunitname(u2.constantParams.param1,[],''));
    6: result:=ord(uoDontMakePlayerAffiliation in u2.constantParams.option1)- ord(uoDontMakePlayerAffiliation in u1.constantParams.option1);
    else result:=u1.mobId-u2.mobId;
  end
end;

procedure TForm7.unitlistTreePaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var data: ptreeGenericdata;
    uo:unitOpts;
begin
    if column = 1 then
    begin
      data:=unitlisttree.GetNodeData(node);
      uo:=tunitInfo(data.BasicND.p).constantParams.option1;
      if uoIsBoss in uo then
      begin
        targetcanvas.font.color:=$004477AA;
        targetcanvas.font.style:=[fsBold];
      end ;
      if uoIsBan in uo then
      begin
        targetcanvas.font.color:=$00777777;
      end;
    end;

end;

end.
