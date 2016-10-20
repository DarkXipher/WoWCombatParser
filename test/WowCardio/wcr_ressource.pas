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
unit wcr_ressource;

interface
uses Dialogs,Classes,SysUtils, Menus, forms, StdCtrls, ComCtrls,ExtCtrls, Controls, Windows, tlhelp32, VirtualTrees, wcr_const, Registry, wcr_utils, StdActns;

procedure Init_caption(form:tform);
function IsProcessActive(const exename: string): Boolean;
function get_path_in_registry:string;
function setlivelogfolder(form:tform):boolean;
function getmyfolder(form:tform):boolean;

var  H_res: tstringlist;
     mainpath,datapath, logpath, livelogFile, comparepath, docPath :string;

implementation

function fixFolderString(s:string):string;
const anti:char ='\';
var   l:integer;
begin
  l:=length(s);
  if (l>0) and (s[l]<>anti) then result:=s+anti else result:=s;
end;

function getmyfolder(form:tform):boolean;
var
  BrowseForFolder1:tbrowseForfolder;
  tmp:string;
begin
   tmp:=logpath;
  BrowseForFolder1:=tbrowseForfolder.create(form);
  BrowseForFolder1.Folder := logpath;
  BrowseForFolder1.DialogCaption:='Select the logs directory';
  if BrowseForFolder1.Execute then logpath:= fixFolderString(BrowseForFolder1.folder);
  result:=tmp<>logpath;
  BrowseForFolder1.free;
end;

function setlivelogfolder(form:tform):boolean;
var initdir,tmprep:string;
    BrowseForFolder1:tbrowseForfolder;
begin
  result:=false;
  BrowseForFolder1:=tbrowseForfolder.create(form);

  tmprep:=ExtractFilePath(livelogFile);
  if not directoryexists(tmprep) then
  begin
    initdir:=get_path_in_registry;
    if initdir <>'' then
      BrowseForFolder1.folder:=initdir+DEFAULT_WOW_LOGS_DIR
    else
      BrowseForFolder1.folder:=mainpath;
  end
  else BrowseForFolder1.folder:=tmprep;

  BrowseForFolder1.DialogCaption:= BROWSEFORCOMBATLOG;
  
  if BrowseForFolder1.Execute then
  begin
    livelogFile:= fixFolderString(BrowseForFolder1.folder)+INGAMELOGNAME;
    result:=true;
  end;
  BrowseForFolder1.free;
end;


function get_path_in_registry:string;
begin
   result:='';
   With TRegistry.Create Do
    Try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey(WOW_REGISTRY_MAINPATH ,false);
      result := ReadString(WOW_REGISTRY_INSTALLPATH);
    Finally
      Free;
    End;
end;

function IsProcessActive(const exename: string): Boolean;
Var
 hSnap: Longword;
 tProcess: PROCESSENTRY32;
begin
 Result := False;
 if exename <> '' then
  begin
   hSnap := CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);
   if hSnap <> 0 then
    begin
     tProcess.dwSize := SizeOf(PROCESSENTRY32);
     if Process32First(hSnap, tProcess) then
      repeat
       Result := lowercase(tProcess.szExeFile) = exename;
       if Result then Break;
      until not Process32Next(hSnap, tProcess);
     CloseHandle(hSnap);
    end;
  end;
end;



procedure Init_caption(form:tform);
var i:integer;
begin

  for i := 0 to form.ComponentCount -1 do
        if form.Components[i].tag<>0 then
        begin
          if form.components[i] is Twincontrol then
              Twincontrol(form.Components[i]).DoubleBuffered:=true;

          {
          else if form.components[i] is TLabel then
              TLabel(form.Components[i]).Caption:=c_string(form.Components[i].tag)
          else if form.components[i] is TRadioButton then
              TRadioButton(form.Components[i]).Caption:=c_string(form.Components[i].tag)
          else if form.components[i] is TgroupBox then
             TgroupBox(form.Components[i]).Caption:=c_string(form.Components[i].tag)
          else if form.components[i] is TCheckbox then
             TCheckbox(form.Components[i]).Caption:=c_string(form.Components[i].tag)
          else}
          if form.components[i] is TToolButton then
              with form.Components[i] as TToolButton do
              begin
                    if tag<H_res.Count then
                    begin
                      hint:=H_res.Strings[tag];
                      showhint:=true;
                      parentshowhint:=false;
                    end;
              end;
          if form.components[i] is TTabSheet then
            with form.Components[i] as TTabSheet do
              begin
                    if tag<H_res.Count then
                    begin
                      hint:=H_res.Strings[tag];
                      //showhint:=true;
                      //parentshowhint:=false;
                    end;
              end

        end;
end;


end.
