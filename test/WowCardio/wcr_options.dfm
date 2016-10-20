object OptionsForm: TOptionsForm
  Left = 529
  Top = 254
  BorderStyle = bsSingle
  Caption = 'Options'
  ClientHeight = 295
  ClientWidth = 705
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
  object Panel10: TPanel
    Left = 3
    Top = 13
    Width = 330
    Height = 108
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object ResizeStats: TCheckBox
      Left = 8
      Top = 32
      Width = 217
      Height = 17
      Caption = 'Automatically resize stats columns'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object CapOverkill: TCheckBox
      Left = 8
      Top = 80
      Width = 283
      Height = 17
      Caption = 'Cap Overkill value (to prevent huge spikes)'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object NoSpellFailed: TCheckBox
      Left = 8
      Top = 56
      Width = 265
      Height = 17
      Caption = 'Don'#39't log SPELL_CAST_FAILED events'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 8
      Width = 225
      Height = 17
      Caption = 'Open WCR on LogIndex Page'
      TabOrder = 3
    end
    object CheckBox2: TCheckBox
      Left = 202
      Top = 10
      Width = 97
      Height = 17
      Caption = 'Use Cache'
      TabOrder = 4
    end
    object CheckBox3: TCheckBox
      Left = 202
      Top = 33
      Width = 121
      Height = 17
      Caption = 'Use ShortNumbers'
      TabOrder = 5
    end
  end
  object GroupBox4: TGroupBox
    Left = 3
    Top = 128
    Width = 330
    Height = 41
    Caption = 'LiveUpdate Timer'
    TabOrder = 1
    object Label3: TLabel
      Left = 224
      Top = 18
      Width = 3
      Height = 13
    end
    object GaugeBar4: TGaugeBar
      Left = 16
      Top = 17
      Width = 193
      Height = 16
      Backgnd = bgPattern
      Max = 1000000
      Min = 1000
      ShowHandleGrip = True
      Style = rbsMac
      Position = 1000
      OnChange = GaugeBar4Change
    end
  end
  object GroupBox1: TGroupBox
    Left = 3
    Top = 176
    Width = 330
    Height = 41
    Caption = 'Max number of events in list (when secure) '
    TabOrder = 2
    object Label2: TLabel
      Left = 224
      Top = 18
      Width = 49
      Height = 13
      AutoSize = False
    end
    object GaugeBar1: TGaugeBar
      Left = 16
      Top = 17
      Width = 193
      Height = 16
      Backgnd = bgPattern
      Max = 1000000
      Min = 1000
      ShowHandleGrip = True
      Style = rbsMac
      Position = 1000
      OnChange = GaugeBar1Change
    end
  end
  object GroupBox7: TGroupBox
    Left = 339
    Top = 6
    Width = 358
    Height = 49
    Caption = 'Direct path to live wowcombatlog.txt'
    TabOrder = 3
    object Edit2: TEdit
      Left = 8
      Top = 16
      Width = 337
      Height = 21
      ReadOnly = True
      TabOrder = 0
      OnClick = Edit2Click
    end
  end
  object GroupBox6: TGroupBox
    Left = 339
    Top = 62
    Width = 358
    Height = 49
    Caption = 'Spell base Web Link (use %s for spellID)'
    TabOrder = 4
    object WebLinkEdit: TEdit
      Left = 8
      Top = 18
      Width = 337
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBox8: TGroupBox
    Left = 339
    Top = 118
    Width = 358
    Height = 81
    Caption = 'Armory Link (use %s for server and %n for playerName)'
    TabOrder = 5
    object Label5: TLabel
      Left = 8
      Top = 52
      Width = 69
      Height = 13
      Caption = 'Default server:'
    end
    object Label1: TLabel
      Left = 197
      Top = 51
      Width = 68
      Height = 13
      Caption = 'UnknownUnit:'
    end
    object DefaultServerNameEdit: TEdit
      Left = 88
      Top = 48
      Width = 97
      Height = 21
      TabOrder = 0
    end
    object ArmoryLinkEdit: TEdit
      Left = 8
      Top = 24
      Width = 337
      Height = 21
      TabOrder = 1
    end
    object UnknownEdit: TEdit
      Left = 272
      Top = 48
      Width = 73
      Height = 21
      TabOrder = 2
    end
  end
  object GroupBox9: TGroupBox
    Left = 339
    Top = 206
    Width = 358
    Height = 49
    Caption = 'NPC Base Web link (use%u as UnitID)'
    TabOrder = 6
    object UnitWebLinkEdit: TEdit
      Left = 8
      Top = 16
      Width = 337
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 3
    Top = 224
    Width = 330
    Height = 57
    Caption = 'Gfx Scale'
    TabOrder = 7
    object GaugeBar5: TGaugeBar
      Left = 16
      Top = 24
      Width = 209
      Height = 16
      Backgnd = bgPattern
      Max = 6
      ShowHandleGrip = True
      Style = rbsMac
      Position = 2
    end
    object Button3: TButton
      Left = 240
      Top = 20
      Width = 75
      Height = 25
      Caption = '&Default'
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object Button1: TButton
    Left = 624
    Top = 262
    Width = 75
    Height = 25
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 8
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 544
    Top = 262
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 9
  end
end
