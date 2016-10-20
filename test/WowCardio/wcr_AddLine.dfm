object Form6: TForm6
  Left = 739
  Top = 478
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Form6'
  ClientHeight = 112
  ClientWidth = 391
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
  object Shape1: TShape
    Left = 3
    Top = 8
    Width = 17
    Height = 65
    OnMouseUp = Shape1MouseUp
  end
  object Button1: TButton
    Left = 312
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 24
    Top = 8
    Width = 361
    Height = 65
    MaxLength = 255
    TabOrder = 1
    WantReturns = False
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 88
    Width = 257
    Height = 17
    Caption = 'Show this windows when adding new lines'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object ColorDialog1: TColorDialog
    Left = 8
    Top = 48
  end
end
