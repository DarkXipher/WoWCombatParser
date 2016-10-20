object Form8: TForm8
  Left = 825
  Top = 519
  BorderIcons = []
  BorderStyle = bsSingle
  ClientHeight = 96
  ClientWidth = 265
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
    Top = 12
    Width = 14
    Height = 13
    Caption = 'ID:'
  end
  object Label2: TLabel
    Left = 8
    Top = 36
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object Edit1: TEdit
    Left = 48
    Top = 8
    Width = 73
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 48
    Top = 32
    Width = 209
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 184
    Top = 64
    Width = 75
    Height = 25
    Caption = 'ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 104
    Top = 64
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
