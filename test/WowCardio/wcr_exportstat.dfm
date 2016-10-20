object Form4: TForm4
  Left = 419
  Top = 238
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Copy/Paste to export (phpbb format)'
  ClientHeight = 436
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 8
    Width = 417
    Height = 393
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object Button1: TButton
    Left = 344
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end
