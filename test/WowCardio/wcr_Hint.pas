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
unit wcr_Hint;
{base code from  jhHTMLGraphics version 2/1/2005
copyright 2000-2005 Qtools Software, Jeffrey P Hamblin.
http://www.qtools.com/dev/
May be used, altered and distributed freely as
long as credit for original code is included.}

interface

uses
	SysUtils, StrUtils, Classes, Windows, Graphics, imglist, Controls, Forms;

const
  //cjhFlags  
  JC_LEFT = 0;
  JC_RIGHT = 1;
  JC_CENTER = 2;
  JC_CALCRECT = 4;  //does not draw the text, just calcs rect.bottom and return val.

type
  TStyleTipImage = (stiNormal,stiRight, stiLeft);
  rCurrentObject = record
    x,y,decal:integer;
    index:integer;
    icon:TStyleTipImage;
    lvlmin, lvlmax:string;
    colormin, colormax:tcolor;
    calc,dummy:boolean;
  end;

  rGlobalTipParam = record
    SideBorder,FootBorder, TopBorder,FirstLineHeight:integer;
    BodyColor:tcolor;
  end;

function jhDrawHTMLText(vCanvas: TCanvas; vHTMLstr: string; var vRect: TRect;
    ImListRef:Timagelist;
    const cjhFlags: Cardinal;
    const cLeading: Double)  //percentage of font height - 1 is normal)
    : rGlobalTipParam; //result = hauteur de la premiere ligne

type
  TApplyTagType = (atBreak, atLine, atStartIndent, atSpace, atImage,  atText, atGoodTag, atBadTag);

  //in interface so WordTagList can be examined for trouble-shooting.
  TjhHTMLText = class(TObject)
  private
    FWordTagList: TStringList;
    FWorkStr: string;
    FLineStartFontName: string;
    FDontBreakLine,FOnRead: boolean;
    FLineStartFontSize,
    FLineStartFontHeight,
    FIndentD,
    FIndentL,
    FCurLine,
    FLineEndWordTagIdx,
    FLineEndWordX,
    FLineObjectCount,
    FThisLineX,
    FThisLineY,
    FStaticLineHeight,
    Fppi: integer;
    FGlobalTipParam: rGlobalTipParam;
    FjhFlags: Cardinal;
    FLeading,FFontsizeMultiplier: double;
    FRect: TRect;
    FCurrentObject:rCurrentObject;
    FCanvas: TCanvas;
    FLineStartStyle: TFontStyles;
    FLineStartFontColor: TColor;
    FInPlainTextMode,
    FLineStartPlainTextMode: boolean;
    FBaseFont: TFont;
    FLastFont: TFont;
    FImListRef:TimageList;
    procedure resetFCurrentObject;
    procedure FillWordTagList;
    procedure ProcessWordTagList;
    function DrawLine(vLineEndWordTagIdx: integer): boolean; 
    function ApplyTag(str: string): TApplyTagType;
    function GetTagParam(const ParamLabStr, s: string): string;
    function DefineImageSpecialPos(const ParamLabStr, s: string):TStyleTipImage;
    procedure SetFontName(s: string);
    procedure SetFontSize(s: string);
    procedure SetFontColor(s: string);
    procedure BreakWords(s: string);
    procedure BreakLongWord(s: string; const idx, startX: integer);
  public
    constructor Create(HTMLstr: string);
    destructor Destroy; override;
    property WordTagList: TStringList read FWordTagList;  //public for trouble-shooting.
  end;

    TCartoHint = class(THintWindow)
    private
      FActivating: Boolean;
      GlobalTipParam:rGlobalTipParam;
      FImageListHint: timagelist;
      function GetImagesList: timagelist;
    public
      procedure ActivateHint(Rect: TRect; const AHint: string); override;
      function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;
    protected
      procedure CreateParams(var Params: TCreateParams);override;
      procedure Paint; override;
  end;
  
  procedure jhSetFontSize(vCanvas: TCanvas; const cSizeInPoints: Double);
implementation   ///////////////////////////////////////////////////////////////

procedure jhSetFontSize(vCanvas: TCanvas; const cSizeInPoints: Double);
// allows setting font size to 10ths of a point, ie 9.7 points
begin
  vCanvas.Font.Height := Round(-cSizeInPoints * vCanvas.Font.PixelsPerInch / 72);
end;


function jhDrawHTMLText(vCanvas: TCanvas; vHTMLstr: string; var vRect: TRect;
    ImListRef:Timagelist;
    const cjhFlags: Cardinal;
    const cLeading: Double): rGlobalTipParam;
var
  jhHTMLText: TjhHTMLText;
begin

  if trim(vHTMLstr) = '' then begin
    vRect.Bottom := vRect.Top;
    vRect.right := vRect.left;
    exit;
  end;
  //create object and process string
  jhHTMLText := TjhHTMLText.Create(vHTMLstr);
  try
    jhHTMLText.FLastFont.Assign(vCanvas.Font);
    jhHTMLText.FBaseFont.Assign(vCanvas.Font);
    jhHTMLText.Fppi := vCanvas.Font.PixelsPerInch;
    jhHTMLText.FLeading := cLeading;
    //jhHTMLText.FLeading := 0.9;
    jhHTMLText.FRect := vRect;
    jhHTMLText.FCanvas := vCanvas;
    jhHTMLText.FjhFlags := cjhFlags;
    jhHTMLText.FStaticLineHeight := Round(vCanvas.TextHeight('Hy') * cLeading);
    jhHTMLText.FImListRef:=ImListRef;

    jhHTMLText.ProcessWordTagList; //draw the text

    vRect := jhHTMLText.FRect; //pass back the new height
    result := jhHTMLText.FGlobalTipParam;
    vCanvas.Font.Assign(jhHTMLText.FBaseFont); //revert to prev stat
  finally
    jhHTMLText.Free;
  end;
end;

///// TjhHTMLText //////////////////////////////////////////////////////////////

constructor TjhHTMLText.Create(HTMLstr: string);
begin 
  inherited Create;
  FWorkStr := HTMLstr;
  FWordTagList := TStringList.Create;
  FillWordTagList;
  FLeading := 1;
  FFontsizeMultiplier:=1;
  FIndentD := 0;
  FIndentL := 0;
  FCurLine := 1;
  FLineEndWordTagIdx := -1;
  FLineEndWordX := 0;
  FLineObjectCount := 0;
  FThisLineY := 0;
  FThisLineY := 0;
  FStaticLineHeight := 0;
  FjhFlags := 0;

  FGlobalTipParam.SideBorder:=3;
  FGlobalTipParam.FootBorder:=0;
  FGlobalTipParam.TopBorder:=0;
  FGlobalTipParam.FirstLineHeight:=0;
  FGlobalTipParam.BodyColor:=clInfoBk;


  FLineStartStyle := [];
  FInPlainTextMode := False;
  FLastFont := TFont.Create;
  FBaseFont := TFont.Create;
  FDontBreakLine:=false;
  FOnRead:=true;
  FImListRef:=nil;
end;

destructor TjhHTMLText.Destroy;
begin
  FWordTagList.Free;
  FBaseFont.Free;
  FLastFont.Free;
  inherited; 
end;

procedure TjhHTMLText.resetFCurrentObject;
begin
  fillchar(FCurrentObject,sizeof(FCurrentObject),0);
  FCurrentObject.index:=-1;
end;

procedure TjhHTMLText.FillWordTagList;
//fills the FWordTagList from the HTML tagged string passed to the function,
//breaking apart words and tags onto separate lines.
var
  Done: boolean;
  TagPos, EndTagPos: integer;
begin
  Done := False;
  while not Done do begin
    TagPos := Pos('<', FWorkStr);
    if TagPos > 0 then begin //has tag - maybe
      if TagPos > 1 then begin //words before tag
        BreakWords(Copy(FWorkStr, 1, TagPos-1));
        Delete(FWorkStr, 1, TagPos-1);
      end else begin  //starts with tag
        EndTagPos := Pos('>', FWorkStr);
        if EndTagPos > TagPos then begin//has an endtag
          FWordTagList.Append(Copy(FWorkStr, 1, EndTagPos));
          Delete(FWorkStr, 1, EndTagPos);
        end else begin //no end tag so just output as string
          BreakWords(FWorkStr);
          FWorkStr := '';
        end;
      end;
    end else begin //no tags
      BreakWords(FWorkStr);
      FWorkStr := '';
    end;
    Done := (Length(FWorkStr) < 1);
  end;
end;

procedure TjhHTMLText.ProcessWordTagList;
var
  Done: boolean;
begin
  SetTextAlign(FCanvas.Handle, TA_LEFT or TA_BASELINE);
  FThisLineY := FRect.Top;
  FThisLineX := FRect.left;
  repeat
    Done := DrawLine(FLineEndWordTagIdx);
    if not Done then begin
      Inc(FCurLine);
      FLineEndWordX := 0;
      FLineObjectCount := 0;
    end;
  until Done;
  FRect.Bottom := FThisLineY;
  FRect.right := FThisLineX;
end;

function TjhHTMLText.DrawLine(vLineEndWordTagIdx: integer): boolean;
//measures and draws (if not JC_CALCRECT) a line of text, applying tags
//and parameters as needed.
//Returns True when done processing last item in FWordTagList.
var
  i, TempIdx, StartPosX, StartPosY: integer;
  TempY: integer;
  WordSize: TSize;
  Done: boolean;
  bmp:tbitmap;
begin
  Done := False;
  result := false;
  //set indent
  StartPosX := FIndentL + FRect.Left;
  StartPosY := FThisLineY;
  //store init values for line to use during draw to canvas
  FLineEndWordX := StartPosX+FIndentD;
  FLineStartStyle := FCanvas.Font.Style;
  FLineStartFontName := FCanvas.Font.Name;
  FLineStartFontSize := FCanvas.Font.Size;
  FLineStartFontColor := FCanvas.Font.Color;
  FLineStartFontHeight := FCanvas.Font.Height;
  FLineStartPlainTextMode := FInPlainTextMode;
  FOnRead:=true;
  //measure only
  TempIdx := vLineEndWordTagIdx + 1;
  i := TempIdx;
  //loop list until line end reached
  while not Done do begin
    case ApplyTag(FWordTagList[i]) of
      atBreak: begin
          if FDontBreakLine and ((JC_CALCRECT and FjhFlags) > 0) then
          begin
              If Frect.right-Frect.left<FLineEndWordX then Frect.right:= FLineEndWordX;
              if FLineEndWordX > FThisLineX then FThisLineX:=FLineEndWordX;
          end;
          FDontBreakLine:=false;
          FLineEndWordTagIdx := i;
          if FLineObjectCount = 0 then
              FThisLineY := StartPosY + Round(FCanvas.TextHeight('Hy') * FLeading);
          if i = (FWordTagList.Count - 1) then begin //finished last word or tag
            Result := True;
          end;
          break;
      end;

      atLine: begin  //actif seulement si on est sur une ligne vierge
          if not FDontBreakLine and (FLineObjectCount = 0) then
          begin
              FThisLineY := StartPosY + FCurrentObject.y;
              FLineEndWordTagIdx := i;
              if i = (FWordTagList.Count - 1) then begin //finished last word or tag
                Result := True;
              end;
              if  FCurLine=1 then
                if FGlobalTipParam.FirstLineHeight< FCurrentObject.y then FGlobalTipParam.FirstLineHeight:=FCurrentObject.y;
              break;
          end
          else FCurrentObject.calc := false;
      end;

      atStartIndent: begin
        if FLineObjectCount = 0 then
        begin
          startposx:=FIndentL + FRect.Left;
          FLineEndWordX := FIndentL + FRect.Left;
        end
        else if FLineEndWordX <=FIndentL + FRect.Left+FindentD then FLineEndWordX := FIndentL + FRect.Left + FindentD;

      end;

      atImage, atspace:
        begin
           if not Fdontbreakline then //support du tag <line>
              if (FLineEndWordX + FCurrentObject.x) > FRect.Right then
                if FLineObjectCount > 0 then
                  break
                else begin //si on repasse ici, on passe quand meme à la ligne suivante pour afficher l'objet en debordement (sinon on a un infinite loop)
                  FLineEndWordTagIdx := i;
                  if (FCurrentObject.icon=stiNormal) and not FCurrentObject.dummy then
                  begin
                    if  FCurLine=1 then
                    begin
                        if FGlobalTipParam.FirstLineHeight< FCurrentObject.y - FCurrentObject.decal then
                          FGlobalTipParam.FirstLineHeight:=FCurrentObject.y - FCurrentObject.decal;
                    end
                    else FThisLineY := StartPosY + FCurrentObject.y - FCurrentObject.decal;
                    if i = (FWordTagList.Count - 1) then begin //finished last word or tag
                      Result := True;
                    end;
                  end;
                  break;
                end;

           FLineEndWordX := FLineEndWordX + FCurrentObject.x;
           //on redefini la valeur de X pour redimentionnement de vRect si necessaire
           if FLineEndWordX > FThisLineX then FThisLineX:=FLineEndWordX;
           if (FCurrentObject.icon=stiNormal) and not FCurrentObject.dummy then
           begin
               if  FCurLine=1 then
               begin
                  if FGlobalTipParam.FirstLineHeight< FCurrentObject.y - FCurrentObject.decal then
                   FGlobalTipParam.FirstLineHeight:=FCurrentObject.y - FCurrentObject.decal;
               end
               else
               begin
                  TempY := StartPosY + FCurrentObject.y -FCurrentObject.decal;
                  if TempY > FThisLineY then FThisLineY := TempY;
               end;
           end;
           inc(FLineObjectCount);
        end;

      atText: begin
        WordSize := FCanvas.TextExtent(FWordTagList[i]);
        {on check la hauteur de la premiere ligne pour le resultat global}
        if  FCurLine=1 then
          if FGlobalTipParam.FirstLineHeight< WordSize.cy then FGlobalTipParam.FirstLineHeight:=WordSize.cy;
        //break line at word if it exceeds bounds
        if not Fdontbreakline then //support du tag <line>
          if (FLineEndWordX + WordSize.cx) > FRect.Right then begin
            if FLineObjectCount > 0 then
              break
            else begin //need to break apart too long of a word
              BreakLongWord(FWordTagList[i], i, StartposX);
              WordSize := FCanvas.TextExtent(FWordTagList[i]);
            end;
          end;
        //update WordCount
        Inc(FLineObjectCount);
        //update FLineEndWordX for right justify
        FLineEndWordX := FLineEndWordX + WordSize.cx;
        //on redefini la valeur de X pour redimentionnement de vRect si necessaire
        if FLineEndWordX > FThisLineX then FThisLineX:=FLineEndWordX;
        //update FThisLineY to tallest font in line
        if FCurLine > 1 then begin
            TempY := StartPosY + Round(WordSize.cy * FLeading);
            if TempY > FThisLineY then FThisLineY := TempY;
        end;
      end
      else
      begin
          //autre tag = nothing
      end;
    end;
    //update index of last word or tag processed
    FLineEndWordTagIdx := i;
    Inc(i);
    if i = (FWordTagList.Count) then begin //finished last word or tag in list
      Result := True;
      break;
    end;
  end;
  if (JC_CALCRECT and FjhFlags) > 0 then exit; //skip drawing of text
  //draw text
  //set init values for line
  FOnRead:=false;
  FCanvas.Font.Style := FLineStartStyle;
  FCanvas.Font.Name := FLineStartFontName;
  FCanvas.Font.Size := FLineStartFontSize;
  FCanvas.Font.Color := FLineStartFontColor;
  FCanvas.Font.Height := FLineStartFontHeight;
  FInPlainTextMode := FLineStartPlainTextMode;
  //set starting x pos according to justify
  if (JC_RIGHT and FjhFlags) > 0 then
    FCanvas.MoveTo(StartPosX + FRect.Right - FLineEndWordX, FThisLineY)
  else if (JC_CENTER and FjhFlags) > 0 then
    FCanvas.MoveTo(StartPosX + ((FRect.Right - FLineEndWordX) div 2), FThisLineY)
  else
    FCanvas.MoveTo(StartPosX, FThisLineY);
  //loop section of list processed above
  for i := TempIdx to FLineEndWordTagIdx do begin
    case ApplyTag(FWordTagList[i]) of
      atBreak: exit;
      atStartIndent: if FCanvas.PenPos.x <FIndentL + FRect.Left then FCanvas.moveto(FIndentL + FRect.Left,FThisLineY);
      atText: FCanvas.TextOut(FCanvas.PenPos.x, FThisLineY, FWordTagList[i]);

      atline: if not FCurrentObject.dummy then
              begin
                FCanvas.moveto(FRect.left-FGlobalTipParam.SideBorder,FThisLineY-(FCurrentObject.y div 2));
                FCanvas.lineto(FRect.right+FGlobalTipParam.SideBorder,FThisLineY-(FCurrentObject.y div 2));
              end;

      atImage:  if not FCurrentObject.dummy then
                    if  (FCurrentObject.index<>-1) and (
                        FImListRef <>nil) and
                        (FCurrentObject.index < FImListRef.Count)
                    then
                    begin
                        bmp:=tbitmap.create;
                        FImListRef.getbitmap(FCurrentObject.index,bmp);
                        bmp.Transparent :=True;
                        bmp.TransParentColor :=clWhite;
                        case FCurrentObject.icon of
                          stiRight: begin
                                      FCanvas.Draw( FRect.Right-FCurrentObject.x,
                                                    FRect.top-FGlobalTipParam.FirstLineHeight,bmp);
                                      FCanvas.moveto(FCanvas.PenPos.x,FThisLineY);
                                    end;
                          stiLeft:  begin
                                      FCanvas.Draw(FRect.Left,FRect.top-FGlobalTipParam.FirstLineHeight,bmp);
                                      FCanvas.moveto(FCanvas.PenPos.x+FCurrentObject.x,FThisLineY);
                                    end;

                          stiNormal:begin
                                      FCanvas.Draw(FCanvas.PenPos.x,FThisLineY-FCurrentObject.y+FCurrentObject.decal,bmp);
                                      FCanvas.moveto(FCanvas.PenPos.x+FCurrentObject.x,FThisLineY);
                                    end;
                        end;
                        bmp.free;
                  end;
      atspace: FCanvas.MoveTo(FCanvas.PenPos.x+FCurrentObject.x,FThisLineY);
    end;
  end;
end;

function TjhHTMLText.ApplyTag(str: string): TApplyTagType;
begin
  result := atText;
  if (str = '') or (str[1] <> '<') then exit;  // not valid tag
  if (Pos('<br>', LowerCase(str)) > 0) then begin //br outrepasse le plaintext
    result := atBreak;
    exit;
  end;

  //plaintext pour tous les autres tags

  if Pos('<pt>', LowerCase(str)) > 0 then begin
    FInPlainTextMode := True;
    result := atGoodTag;
    exit;
  end else if Pos('</pt>', LowerCase(str)) > 0 then begin
    FInPlainTextMode := False;  
    result := atGoodTag;
    exit;
  end;

  if FInPlainTextMode then begin  //don't process tags
    exit;
  end;

  if FOnRead  then
        if Pos('<body', LowerCase(str)) > 0 then begin
          if ((JC_CALCRECT and FjhFlags) > 0) then FRect.right:=FRect.Left+StrToIntDef(GetTagParam('smax=',str),FRect.right);
          FGlobalTipParam.SideBorder:=StrToIntDef(GetTagParam('side=',str),5);
          FGlobalTipParam.FootBorder:=StrToIntDef(GetTagParam('foot=',str),5);
          FGlobalTipParam.TopBorder:=StrToIntDef(GetTagParam('top=',str),5);
          FGlobalTipParam.BodyColor:=StrToIntDef(GetTagParam('color=',str),clInfoBk);
          result := atGoodTag;
          exit;
        end
        else if Pos('<line>', LowerCase(str)) > 0 then begin
          FDontBreakLine:=true;
          result := atGoodTag;
          exit;
        end else if Pos('</line>', LowerCase(str)) > 0 then begin
          if FDontBreakLine then
          begin
              result := atBreak;
              exit;
          end;
          result := atBadTag;
          exit;
        end;
        
  //alignement dynamique
  if ((JC_CALCRECT and FjhFlags) = 0) then
  begin
        if Pos('<center>', LowerCase(str)) >0 then begin
          FjhFlags:=JC_CENTER;
          result := atGoodTag;
          exit;
        end else if Pos('<right>', LowerCase(str)) >0 then begin
          FjhFlags:=JC_RIGHT;
          result := atGoodTag;
          exit;
        end else if Pos('<left>', LowerCase(str)) >0 then begin
          FjhFlags:=JC_LEFT;
          result := atGoodTag;
          exit;
        end;
  end;

  if Pos('<b>', LowerCase(str)) > 0 then begin
    FCanvas.Font.Style := FCanvas.Font.Style + [fsBold];
  end else if Pos('</b>', LowerCase(str)) > 0 then begin
    FCanvas.Font.Style := FCanvas.Font.Style - [fsBold];
  end else if Pos('<i>', LowerCase(str)) > 0 then begin
    FCanvas.Font.Style := FCanvas.Font.Style + [fsItalic];
  end else if Pos('</i>', LowerCase(str)) > 0 then begin
    FCanvas.Font.Style := FCanvas.Font.Style - [fsItalic];
  end else if Pos('<u>', LowerCase(str)) > 0 then begin
    FCanvas.Font.Style := FCanvas.Font.Style + [fsUnderline];
  end else if Pos('</u>', LowerCase(str)) > 0 then begin
    FCanvas.Font.Style := FCanvas.Font.Style - [fsUnderline];
  end else if Pos('<s>', LowerCase(str)) > 0 then begin
    FCanvas.Font.Style := FCanvas.Font.Style + [fsStrikeOut];
  end else if Pos('</s>', LowerCase(str)) > 0 then begin
    FCanvas.Font.Style := FCanvas.Font.Style - [fsStrikeOut];
  end else if Pos('<font', LowerCase(str)) > 0 then begin
    FLastFont.Assign(FCanvas.Font);
    SetFontName(GetTagParam('face=',str));
    SetFontSize(GetTagParam('size=',str));
    SetFontColor(GetTagParam('color=',str));
  end else if Pos('<fp', LowerCase(str)) > 0 then begin
    FFontsizeMultiplier:=StrTofloatDef(GetTagParam('=',str),1.0);
  end else if Pos('<img', LowerCase(str)) > 0 then begin
    resetFCurrentObject;
    FCurrentObject.calc:=StrToboolDef(GetTagParam('calc=',str),true);
    if FCurrentObject.calc then
    begin
      FCurrentObject.index:=StrToIntDef(GetTagParam('id=',str),-1);
      FCurrentObject.x:=StrToIntDef(GetTagParam('sx=',str),16);
      FCurrentObject.y:=StrToIntDef(GetTagParam('sy=',str),16);
      FCurrentObject.decal:=StrToIntDef(GetTagParam('h=',str),0);
      FCurrentObject.icon:=DefineImageSpecialPos(GetTagParam('icon=',str),'');
      FCurrentObject.dummy:=StrToboolDef(GetTagParam('dummy=',str),false);
      result := atImage;
    end
    else result := atBadTag;
    exit;
  end
  else if Pos('<space', LowerCase(str)) > 0 then begin
    resetFCurrentObject;
    FCurrentObject.calc:=StrToboolDef(GetTagParam('calc=',str),true);
    if FCurrentObject.calc then
    begin
      FCurrentObject.x:=StrToIntDef(GetTagParam('size=',str),0);
      result := atSpace;
    end
    else result := atBadTag;
    exit;
  end else if Pos('</font>', LowerCase(str)) > 0 then begin
    FCanvas.Font.Assign(FLastFont);
  end else if Pos('<ind', LowerCase(str)) >0 then begin
    FIndentL :=StrToIntDef(GetTagParam('left=',str), 0);
    FIndentD :=StrToIntDef(GetTagParam('right=',str), 0);
    //sécurité
    if FindentL+FindentD >=Frect.Right-fRect.Left then
    begin
      FindentL:=0;
      FindentD:=0;
      result:= atBadTag;
      end
    else result:= atStartIndent;
    exit;
  end else if Pos('<bl', LowerCase(str)) >0 then begin
    resetFCurrentObject;
    FCurrentObject.calc:=StrToboolDef(GetTagParam('calc=',str),true);
    if FCurrentObject.calc then
    begin
      FCurrentObject.y:=StrToIntDef(GetTagParam('size=',str),3);
      FCurrentObject.dummy:=StrToboolDef(GetTagParam('dummy=',str),true);
      result := atLine;
    end
    else result := atBadTag;
    exit;
  end else if Pos('<break', LowerCase(str)) >0 then begin //conditionnal break
    resetFCurrentObject;
    FCurrentObject.calc:=StrToboolDef(GetTagParam('calc=',str),false);
    if FCurrentObject.calc then result := atBreak
    else result := atBadTag;
    exit;
  end else if Pos('>', (str)) > 2 then begin
    //unsupported tag so do not print it
    result := atBadTag;
    exit;
  end else exit; //result is atText
  result := atGoodTag;
end;

function TjhHTMLText.DefineImageSpecialPos(const ParamLabStr, s: string):TStyleTipImage;
begin
    if lowercase(ParamLabStr) = 'right' then
      result:=stiRight
    else if lowercase(ParamLabStr)='left' then
      result:=stiLeft
    else
      result:=stiNormal;
end;

function TjhHTMLText.GetTagParam(const ParamLabStr, s: string): string;
//returns a specific value from a <font....> tag.
//ParamLabStr can be "face=", "size=", "color=" etc.
var
  TempPos, i: integer;
  TempStr: string;
begin
  result := '';
  //error checking
  if (ParamLabStr = '') or
      (Length(s) <= Length(ParamLabStr)) or
      (s = '') then exit;
  //find start of ParamLabStr in string
  TempPos := Pos(ParamLabStr, LowerCase(s));
  if TempPos > 0 then begin
    //delete ParamLabStr from string
    TempStr := Copy(s, TempPos + Length(ParamLabStr), Length(s));
    //extract value
    case TempStr[1] of
      '"': begin //quoted value - allows space char
        for i := 2 to Length(TempStr) do begin
          if charinset(TempStr[i],['"', '>']) then break;
          result := result + TempStr[i];
        end;
      end;
      else begin //no quotes on value
        for i := 1 to Length(TempStr) do begin
          if charinset(TempStr[i],[' ', '>']) then break;
          result := result + TempStr[i];
        end;
      end;
    end;
  end;
end;

procedure TjhHTMLText.SetFontName(s: string);
begin
  if s = '' then exit;
  if FCanvas.Font.Name <> s then
    FCanvas.Font.Name := s;
end;

procedure TjhHTMLText.SetFontSize(s: string);
var
  TempSize: double;
begin
  if s = '' then exit;
  TempSize := StrToFloatDef(s, 0)*FFontsizeMultiplier;
  if TempSize < 4 then
    TempSize := FBaseFont.Size;
  if FCanvas.Font.Size <> TempSize then
    jhSetFontSize(FCanvas, TempSize);
end;

procedure TjhHTMLText.SetFontColor(s: string);
var
  TempColor: TColor;
begin
  if s = '' then exit;
  TempColor := strtointdef(s,0);
  if FCanvas.Font.Color <> TempColor then
    FCanvas.Font.Color := TempColor;
end;

procedure TjhHTMLText.BreakWords(s: string);
//breaks a string of words on spaces or #10 and appends to FWordTagList
var
  i, sLen: integer;
  TempStr: string;
begin
  sLen := Length(s);
  for i := 1 to sLen do begin
    if s[i] <> ' ' then begin //not a space
      if (s[i] <> #10) and (s[i] <> #13) then begin
        TempStr := TempStr + s[i];
      end else if s[i] = #10 then begin //new line for #10, skip #13
        FWordTagList.Append(TempStr);
        FWordTagList.Append('<br>');    //replace CRLF with a <br>
        TempStr := '';
      end;
    end else  begin  //is a space
      FWordTagList.Append(TempStr + ' ');
      TempStr := '';
    end;
    if (i = sLen) and (TempStr <> '') then
      FWordTagList.Append(TempStr); //catch the last string
  end;
end; 

procedure TjhHTMLText.BreakLongWord(s: string; const idx, startX: integer);
//breaks a single word that will not fit on one line into multiple lines.
var
  TempWidth, FitInWidth, CharCount: integer;
  TempPerc: double;
  Done: boolean;
begin
  Done := False;
  TempWidth := FCanvas.TextWidth(s);
  FitInWidth := FRect.Right - startX-FIndentD;
  TempPerc := (FitInWidth / TempWidth) * 1.05; // fudge
  CharCount := Round(Length(s) * TempPerc);
  repeat
    if FCanvas.TextWidth(Copy(s,1,CharCount)) < FitInWidth then
      Done := True
    else begin
      Dec(CharCount);
    end;
  until Done;
  FWordTagList.Insert(idx + 1, Copy(s, CharCount + 1, Length(s)));
  FWordTagList[idx] := Copy(s, 1, CharCount);
end;




//**************************************************

procedure TCartoHint.CreateParams(var Params: TCreateParams);
begin
    inherited CreateParams(Params);
    Params.Style := WS_POPUP;
end;

procedure TCartoHint.Paint;
var
 R: TRect;
begin
 R := ClientRect;
 Inc(R.Top,GlobalTipParam.FirstLineHeight+GlobalTipParam.TopBorder);
 Inc(R.left,GlobalTipParam.SideBorder);
 Dec(R.right,GlobalTipParam.SideBorder);
 jhDrawHTMLText(canvas,caption,R,FImageListHint,JC_LEFT ,1);
end;

function TCartoHint.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
begin
  Result := Rect(0, 0, 350, 0);
  GlobalTipParam:=jhDrawHTMLText(canvas,AHint,result,FImageListHint,JC_CALCRECT or JC_LEFT ,1);
  inc(result.Bottom,GlobalTipParam.firstlineheight+GlobalTipParam.footborder+GlobalTipParam.topborder+4);
  dec(result.left,GlobalTipParam.SideBorder);
  inc(result.right,GlobalTipParam.SideBorder);
end;

procedure TCartoHint.ActivateHint(Rect: TRect; const AHint: string);
begin
  FActivating := True;
  try
      Caption:=AHint;
      FImageListHint:=GetImagesList;
      UpdateBoundsRect(Rect);
      if Rect.Top + Height > Screen.DesktopHeight then Rect.Top := Screen.DesktopHeight - Height;
      if Rect.Left + Width > Screen.DesktopWidth then Rect.Left := Screen.DesktopWidth - Width;
      if Rect.Left < Screen.DesktopLeft then Rect.Left := Screen.DesktopLeft;
      if Rect.Bottom < Screen.DesktopTop then Rect.Bottom := Screen.DesktopTop;
      color:=GlobalTipParam.BodyColor;
      SetWindowPos(Handle, HWND_TOPMOST, Rect.Left, Rect.Top, Width, Height, SWP_NOACTIVATE);
      ShowWindow(Handle, SW_SHOWNOACTIVATE);
  finally
  FActivating := false;
  end;
end;

function TCartoHint.GetImagesList: timagelist;
var
  I: Integer;
begin
  Result := nil;
  with Application.MainForm do
  for I := 0 to ComponentCount-1 do
    if Components[I] is Timagelist then
      if Timagelist(Components[I]).tag>0 then
        begin
          Result := timagelist(Components[I]);
          Break;
        end;
end;


end.
