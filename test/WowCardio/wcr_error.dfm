object Form9: TForm9
  Left = 582
  Top = 584
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Error'
  ClientHeight = 128
  ClientWidth = 386
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 302
    Height = 13
    Caption = 'WowCardioRaid has encountered a problem and needs to close'
  end
  object Memo1: TMemo
    Left = 8
    Top = 32
    Width = 369
    Height = 57
    Color = clBtnFace
    TabOrder = 0
  end
  object Button1: TButton
    Left = 304
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end
