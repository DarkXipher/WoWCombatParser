object FormSpell: TFormSpell
  Left = 355
  Top = 255
  Caption = 'FormSpell'
  ClientHeight = 573
  ClientWidth = 834
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
  object SpelllistTree: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 834
    Height = 540
    Align = alClient
    Color = clWhite
    Header.AutoSizeIndex = 1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoShowSortGlyphs, hoVisible]
    Header.SortColumn = 1
    PopupMenu = PopupUnitlist
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toUseBlendedImages, toUseBlendedSelection]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
    OnCompareNodes = SpelllistTreeCompareNodes
    OnGetText = SpelllistTreeGetText
    OnHeaderClick = SpelllistTreeHeaderClick
    Columns = <
      item
        Position = 0
        WideText = 'Id'
      end
      item
        Position = 1
        Width = 200
        WideText = 'Name'
      end
      item
        Position = 2
        Width = 80
        WideText = 'Class'
      end
      item
        Position = 3
        WideText = 'Aff.'
      end
      item
        Position = 4
        WideText = 'Aura'
      end
      item
        Position = 5
        WideText = 'Absb'
      end
      item
        Position = 7
        WideText = 'Abs.Prio'
      end
      item
        Position = 6
        WideText = 'Abs.noAff'
      end
      item
        Position = 8
        WideText = 'Aff.Dur.'
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 540
    Width = 834
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      834
      33)
    object Button1: TButton
      Left = 752
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Save'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 672
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PopupUnitlist: TPopupMenu
    Left = 160
    Top = 112
    object AddVirtualSpell1: TMenuItem
      Caption = 'Add Spell'
      OnClick = AddVirtualSpell1Click
    end
    object editSpell1: TMenuItem
      Caption = 'Edit Spell'
      OnClick = editSpell1Click
    end
  end
end
