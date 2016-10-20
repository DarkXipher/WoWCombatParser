object Form7: TForm7
  Left = 561
  Top = 127
  BorderIcons = []
  Caption = 'Form7'
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
  object unitlistTree: TVirtualStringTree
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
    OnCompareNodes = unitlistTreeCompareNodes
    OnGetText = unitlistTreeGetText
    OnPaintText = unitlistTreePaintText
    OnHeaderClick = unitlistTreeHeaderClick
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
        WideText = 'Ban'
      end
      item
        Position = 3
        WideText = 'Boss'
      end
      item
        Position = 4
        WideText = 'Boss Aff.'
      end
      item
        Position = 5
        Width = 200
        WideText = 'Boss Aff.Name'
      end
      item
        Position = 6
        WideText = 'NoPlayerAff'
      end
      item
        Position = 7
        WideText = 'ForceSave'
      end
      item
        Position = 8
        Width = 100
        WideText = 'RegisteredHp'
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
    object AddVirtualUnit1: TMenuItem
      Caption = 'Add Unit'
      OnClick = AddVirtualUnit1Click
    end
    object editUnit1: TMenuItem
      Caption = 'Edit Unit'
      OnClick = editUnit1Click
    end
  end
end
