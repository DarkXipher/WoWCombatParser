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
unit wcr_Hash;

interface
uses wcr_const, dialogs, sysutils;

function EventHash(const Str : String): word;
function HashInt(const Str : String): integer;
function EventHashasm(const str: string): cardinal;


implementation

function EventHash(const Str : String): word;
begin
  //get a 16bits digest, seems acceptable for the 50 events-names
  result:= word(EventHashAsm(str) shr 8);
end;

function HashInt(const Str : String): integer;
begin
  //get a 24bits digest, for spell without ID (enchant/environnement)
  result:= integer(EventHashAsm(str) shr 10);
end;

function EventHashAsm(const Str : string): cardinal;
var  I: integer;
begin
  Result := 0;
  for I := 1 to length(Str) do
  begin
    Result := (Result shl 5) or (Result shr 27);
    Result := Result xor Cardinal(Str[I]);
  end;
end;




end.
