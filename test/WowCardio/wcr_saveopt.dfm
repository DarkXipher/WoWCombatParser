object Form5: TForm5
  Left = 626
  Top = 477
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Save Options'
  ClientHeight = 140
  ClientWidth = 442
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
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 169
    Height = 65
    Caption = 'Save Period:'
    ItemIndex = 0
    Items.Strings = (
      'Save Full Log'
      'Save Selection only')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 184
    Top = 13
    Width = 249
    Height = 60
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object CheckBox1: TCheckBox
      Left = 8
      Top = 8
      Width = 225
      Height = 17
      Caption = 'Rename live WoWCombatLog.txt as'
      Enabled = False
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 8
      Top = 32
      Width = 225
      Height = 21
      Enabled = False
      TabOrder = 1
    end
  end
  object Button1: TButton
    Left = 358
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 280
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 8
    Top = 80
    Width = 425
    Height = 21
    MaxLength = 90
    TabOrder = 4
    OnEnter = Edit2Enter
  end
end
