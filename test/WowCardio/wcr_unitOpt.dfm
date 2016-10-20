object Form3: TForm3
  Left = 543
  Top = 207
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Edit Unit'
  ClientHeight = 558
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CheckBox1: TCheckBox
    Left = 24
    Top = 35
    Width = 217
    Height = 17
    Caption = 'Never show this unit on graphic'
    TabOrder = 0
  end
  object Button1: TButton
    Left = 273
    Top = 525
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 192
    Top = 525
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object CheckBox4: TCheckBox
    Left = 24
    Top = 59
    Width = 321
    Height = 17
    Caption = 'DontAffiliate this unit to player (Need to reload the log)'
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 24
    Top = 8
    Width = 257
    Height = 21
    TabOrder = 4
  end
  object UnitnoFriend: TCheckBox
    Left = 24
    Top = 83
    Width = 257
    Height = 17
    Caption = 'Force this unit to not be friendly'
    TabOrder = 5
  end
  object Edit2: TEdit
    Left = 288
    Top = 8
    Width = 65
    Height = 21
    Enabled = False
    TabOrder = 6
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 106
    Width = 329
    Height = 413
    Caption = 'Boss Analytics'
    TabOrder = 7
    object Label1: TLabel
      Left = 71
      Top = 236
      Width = 131
      Height = 13
      Caption = 'Death Boss Affiliation Count'
    end
    object Label2: TLabel
      Left = 71
      Top = 264
      Width = 40
      Height = 13
      Caption = 'TimeOut'
    end
    object Label3: TLabel
      Left = 151
      Top = 288
      Width = 54
      Height = 13
      Caption = 'PowerType'
    end
    object Shape1: TShape
      Left = 264
      Top = 334
      Width = 40
      Height = 22
      OnMouseDown = Shape1MouseDown
    end
    object Label4: TLabel
      Left = 16
      Top = 336
      Width = 56
      Height = 13
      Caption = 'Replay Size'
    end
    object Label5: TLabel
      Left = 211
      Top = 337
      Width = 3
      Height = 13
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 24
      Width = 209
      Height = 17
      Caption = 'Set this unit as a Boss'
      TabOrder = 0
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 48
      Width = 217
      Height = 17
      Caption = 'Affiliate this unit to Boss:'
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 16
      Top = 76
      Width = 217
      Height = 21
      Style = csDropDownList
      DropDownCount = 24
      TabOrder = 2
      OnChange = ComboBox1Change
    end
    object CheckBox6: TCheckBox
      Left = 240
      Top = 77
      Width = 81
      Height = 17
      Caption = 'Load all boss'
      TabOrder = 3
      OnClick = CheckBox6Click
    end
    object CheckBox7: TCheckBox
      Left = 16
      Top = 104
      Width = 113
      Height = 17
      Caption = 'CheckForDeath'
      TabOrder = 4
    end
    object CheckBox8: TCheckBox
      Left = 16
      Top = 126
      Width = 153
      Height = 17
      Caption = 'CheckForSpecialEvent'
      TabOrder = 5
    end
    object Edit3: TEdit
      Left = 16
      Top = 229
      Width = 49
      Height = 21
      TabOrder = 6
      Text = '0'
    end
    object Edit4: TEdit
      Left = 16
      Top = 256
      Width = 49
      Height = 21
      TabOrder = 7
      Text = '0'
    end
    object CheckBox9: TCheckBox
      Left = 240
      Top = 24
      Width = 86
      Height = 17
      Caption = 'Secure Unit'
      TabOrder = 8
    end
    object CheckBox10: TCheckBox
      Left = 16
      Top = 172
      Width = 145
      Height = 17
      Caption = 'Heuristic Wipe Detection'
      TabOrder = 9
    end
    object ComboBox2: TComboBox
      Left = 16
      Top = 372
      Width = 297
      Height = 21
      Style = csDropDownList
      DropDownCount = 30
      TabOrder = 10
    end
    object CheckBox5: TCheckBox
      Left = 16
      Top = 149
      Width = 171
      Height = 17
      Caption = 'CheckForEncounterEnd (Raid)'
      TabOrder = 11
    end
    object ComboBox3: TComboBox
      Left = 16
      Top = 283
      Width = 129
      Height = 21
      Style = csDropDownList
      DropDownCount = 24
      TabOrder = 12
    end
    object CheckBox11: TCheckBox
      Left = 16
      Top = 310
      Width = 189
      Height = 17
      Caption = 'Replay Emphasis'
      TabOrder = 13
    end
    object GaugeBar1: TGaugeBar
      Left = 87
      Top = 336
      Width = 118
      Height = 16
      Backgnd = bgPattern
      Max = 3000
      ShowHandleGrip = True
      Position = 99
      OnChange = GaugeBar1Change
    end
  end
  object ColorDialog1: TColorDialog
    Left = 280
    Top = 384
  end
end
