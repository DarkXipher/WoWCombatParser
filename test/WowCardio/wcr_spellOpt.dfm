object Form2: TForm2
  Left = 615
  Top = 205
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Form2'
  ClientHeight = 517
  ClientWidth = 609
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 249
    Height = 49
    AutoSize = False
    Caption = 'Label1'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 264
    Top = 8
    Width = 337
    Height = 73
    AutoSize = False
    Caption = 'Label2'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 282
    Top = 212
    Width = 125
    Height = 13
    Caption = 'Override role detection for:'
  end
  object optSpellTree: TVirtualStringTree
    Left = 8
    Top = 64
    Width = 249
    Height = 445
    CheckImageKind = ckFlat
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = -1
    Header.Options = [hoColumnResize, hoDrag]
    TabOrder = 0
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
    OnFreeNode = optSpellTreeFreeNode
    OnGetText = optSpellTreeGetText
    OnInitNode = optSpellTreeInitNode
    Columns = <>
  end
  object Button1: TButton
    Left = 534
    Top = 484
    Width = 67
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 461
    Top = 484
    Width = 67
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object CheckBox1: TCheckBox
    Left = 263
    Top = 87
    Width = 105
    Height = 17
    Caption = 'Spell Is Affiliation'
    TabOrder = 3
  end
  object CheckBox2: TCheckBox
    Left = 440
    Top = 88
    Width = 161
    Height = 17
    Caption = 'Spell Is ReverseAffiliation'
    TabOrder = 4
  end
  object CheckBox3: TCheckBox
    Left = 264
    Top = 110
    Width = 105
    Height = 17
    Caption = 'SingleAura Line'
    TabOrder = 5
  end
  object CheckBox6: TCheckBox
    Left = 440
    Top = 111
    Width = 161
    Height = 17
    Caption = 'Spell Is Used for tanking'
    TabOrder = 6
  end
  object CheckBox7: TCheckBox
    Left = 264
    Top = 134
    Width = 153
    Height = 17
    Caption = 'Spell is used in HardMode'
    TabOrder = 7
  end
  object CheckBox8: TCheckBox
    Left = 263
    Top = 182
    Width = 153
    Height = 17
    Caption = 'Spell closes Boss event'
    TabOrder = 8
  end
  object CheckBox9: TCheckBox
    Left = 440
    Top = 134
    Width = 161
    Height = 17
    Caption = 'Exclude for role detection'
    TabOrder = 9
  end
  object CheckBox10: TCheckBox
    Left = 263
    Top = 157
    Width = 338
    Height = 17
    Caption = 'Spell is excluded for Boss detection'
    TabOrder = 10
  end
  object ComboBox2: TComboBox
    Left = 440
    Top = 182
    Width = 139
    Height = 21
    Style = csDropDownList
    DropDownCount = 10
    TabOrder = 11
  end
  object panel1: TGroupBox
    Left = 263
    Top = 236
    Width = 338
    Height = 242
    Caption = 'Spell && combat Analysis: '
    TabOrder = 12
    object Label7: TLabel
      Left = 155
      Top = 25
      Width = 112
      Height = 13
      Caption = 'FixedCastTime (1/100s)'
    end
    object Shape1: TShape
      Left = 143
      Top = 70
      Width = 50
      Height = 16
      Brush.Color = clRed
      OnMouseDown = Shape1MouseDown
    end
    object cb_noabsorbAff: TCheckBox
      Left = 16
      Top = 47
      Width = 177
      Height = 17
      Caption = 'Don'#39't affiliate Absorb to eff.Heal'
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 270
      Top = 22
      Width = 49
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object CheckBox4: TCheckBox
      Left = 16
      Top = 24
      Width = 137
      Height = 17
      Caption = 'Spell can Interrupt'
      TabOrder = 2
    end
    object CheckBox5: TCheckBox
      Left = 16
      Top = 70
      Width = 97
      Height = 17
      Caption = 'Spell Highlight'
      TabOrder = 3
    end
    object chDamage: TCheckBox
      Left = 32
      Top = 92
      Width = 97
      Height = 17
      Caption = 'Damage'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object chAura: TCheckBox
      Left = 32
      Top = 115
      Width = 105
      Height = 17
      Caption = 'Aura - Max Stack:'
      TabOrder = 5
    end
    object chHeal: TCheckBox
      Left = 32
      Top = 161
      Width = 97
      Height = 17
      Caption = 'Heal'
      TabOrder = 6
    end
    object chInterrupt: TCheckBox
      Left = 32
      Top = 138
      Width = 97
      Height = 17
      Caption = 'Interrupt'
      TabOrder = 7
    end
    object Edit2: TEdit
      Left = 143
      Top = 113
      Width = 36
      Height = 21
      ReadOnly = True
      TabOrder = 8
      Text = '0'
    end
    object UpDown1: TUpDown
      Left = 179
      Top = 113
      Width = 15
      Height = 21
      Associate = Edit2
      Max = 255
      TabOrder = 9
    end
    object CheckBox11: TCheckBox
      Left = 16
      Top = 184
      Width = 153
      Height = 17
      Caption = 'Exclude for debuff tracking'
      TabOrder = 10
    end
    object CheckBox12: TCheckBox
      Left = 16
      Top = 207
      Width = 153
      Height = 17
      Caption = 'Include to aura tracking'
      TabOrder = 11
    end
  end
  object ComboBox1: TComboBox
    Left = 440
    Top = 209
    Width = 139
    Height = 21
    Style = csDropDownList
    DropDownCount = 10
    TabOrder = 13
  end
  object ColorDialog1: TColorDialog
    Color = clRed
    Left = 552
    Top = 296
  end
end
