object Form1: TForm1
  Left = 259
  Top = 233
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  ClientHeight = 887
  ClientWidth = 1016
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 868
    Width = 1016
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Panels = <
      item
        Width = 100
      end
      item
        Width = 80
      end
      item
        Width = 50
      end>
    ParentShowHint = False
    ShowHint = False
    UseSystemFont = False
    ExplicitTop = 849
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1016
    Height = 868
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 849
    object Splitter1: TSplitter
      Left = 793
      Top = 0
      Width = 4
      Height = 868
      Align = alRight
      AutoSnap = False
      Color = clBtnFace
      MinSize = 60
      ParentColor = False
      OnMoved = Splitter1Moved
      ExplicitLeft = 795
      ExplicitHeight = 488
    end
    object Panel6: TPanel
      Left = 797
      Top = 0
      Width = 219
      Height = 868
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitHeight = 849
      object Splitter2: TSplitter
        Left = 0
        Top = 629
        Width = 219
        Height = 4
        Cursor = crVSplit
        Align = alBottom
        AutoSnap = False
        MinSize = 60
        ResizeStyle = rsUpdate
        ExplicitTop = 251
      end
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 219
        Height = 629
        ActivePage = TabSheet1
        Align = alClient
        BiDiMode = bdLeftToRight
        Images = imagelist1
        MultiLine = True
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = True
        Style = tsFlatButtons
        TabOrder = 0
        TabWidth = 21
        OnMouseMove = PageControl1MouseMove
        ExplicitHeight = 610
        object TabSheet1: TTabSheet
          Tag = 46
          ImageIndex = 7
          ParentShowHint = False
          ShowHint = False
          ExplicitHeight = 578
          object unitTree: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 211
            Height = 597
            Align = alClient
            ButtonStyle = bsTriangle
            CheckImageKind = ckFlat
            DragOperations = [doMove]
            DragType = dtVCL
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag]
            Images = imagelist3
            PopupMenu = UnitTreePopup
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoScrollOnExpand, toAutoDeleteMovedNodes]
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowRoot, toUseBlendedImages, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnBeforeCellPaint = unitTreeBeforeCellPaint
            OnChecked = unitTreeChecked
            OnChecking = unitTreeChecking
            OnCompareNodes = unitTreeCompareNodes
            OnContextPopup = unitTreeContextPopup
            OnFocusChanging = unitTreeFocusChanging
            OnFreeNode = unitTreeFreeNode
            OnGetText = unitTreeGetText
            OnPaintText = unitTreePaintText
            OnGetImageIndex = unitTreeGetImageIndex
            OnInitNode = unitTreeInitNode
            OnMouseMove = unitTreeMouseMove
            ExplicitHeight = 578
            Columns = <
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 0
                Width = 207
              end>
          end
          object ProgressBar1: TG32_ProgressBar
            Left = 21
            Top = 32
            BackColor = clBtnFace
            BorderStyle = bsNone
            Caption = 'ProgressBar1'
            Color = clHotLight
            ParentColor = False
            Position = 0
          end
        end
        object TabSheet5: TTabSheet
          Tag = 47
          Caption = 'Tags'
          ImageIndex = 9
          ExplicitHeight = 578
          object FilterTree: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 211
            Height = 597
            Align = alClient
            CheckImageKind = ckFlat
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag]
            PopupMenu = Filterpopup
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnChecked = FilterTreeChecked
            OnChecking = FilterTreeChecking
            OnFocusChanging = FilterTreeFocusChanging
            OnGetText = FilterTreeGetText
            OnInitNode = FilterTreeInitNode
            OnMouseMove = unitTreeMouseMove
            ExplicitHeight = 578
            Columns = <
              item
                Position = 0
                Width = 207
              end>
          end
        end
        object TabSheet6: TTabSheet
          Tag = 48
          Caption = 'Spells'
          ImageIndex = 8
          ExplicitHeight = 578
          object Panel8: TPanel
            Left = 0
            Top = 0
            Width = 211
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            OnMouseMove = unitTreeMouseMove
            DesignSize = (
              211
              25)
            object Label1: TLabel
              Left = 0
              Top = 2
              Width = 41
              Height = 13
              AutoSize = False
              Caption = 'Filter:'
              ParentShowHint = False
              ShowHint = False
              OnMouseMove = unitTreeMouseMove
            end
            object Panel5: TPanel
              Left = 187
              Top = 0
              Width = 24
              Height = 25
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 0
              object ToolBar4: TToolBar
                Left = 0
                Top = 0
                Width = 24
                Height = 28
                Align = alNone
                Caption = 'ToolBar4'
                EdgeInner = esNone
                EdgeOuter = esNone
                HotImages = imagelist2
                Images = imagelist1
                TabOrder = 0
                object ToolButton9: TToolButton
                  Tag = 26
                  Left = 0
                  Top = 0
                  Caption = 'ToolButton9'
                  ImageIndex = 20
                  OnClick = ToolButton9Click
                end
              end
            end
            object Edit1: TEdit
              Left = 32
              Top = 0
              Width = 152
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              ParentShowHint = False
              ShowHint = False
              TabOrder = 1
              OnChange = Edit1Change
              OnEnter = Edit1Enter
              OnExit = Edit1Exit
              OnMouseMove = unitTreeMouseMove
            end
          end
          object SpellTree: TVirtualStringTree
            Left = 0
            Top = 25
            Width = 211
            Height = 572
            Align = alClient
            CheckImageKind = ckFlat
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag]
            Header.SortColumn = 0
            PopupMenu = SpellPopup
            TabOrder = 1
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnBeforeCellPaint = SpellTreeBeforeCellPaint
            OnChecked = SpellTreeChecked
            OnChecking = SpellTreeChecking
            OnCompareNodes = SpellTreeCompareNodes
            OnContextPopup = SpellTreeContextPopup
            OnFocusChanging = SpellTreeFocusChanging
            OnFreeNode = SpellTreeFreeNode
            OnGetText = SpellTreeGetText
            OnPaintText = SpellTreePaintText
            OnInitNode = SpellTreeInitNode
            OnMouseMove = unitTreeMouseMove
            ExplicitHeight = 553
            Columns = <
              item
                Position = 0
                Width = 182
              end
              item
                Position = 1
                Width = 25
              end>
          end
        end
        object TabSheet7: TTabSheet
          Tag = 49
          Caption = 'Events'
          ImageIndex = 8
          ExplicitHeight = 578
          object EventTree: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 211
            Height = 597
            Align = alClient
            CheckImageKind = ckFlat
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag]
            Header.SortColumn = 0
            PopupMenu = EventPopUp
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnChecked = SpellTreeChecked
            OnChecking = SpellTreeChecking
            OnCompareNodes = EventTreeCompareNodes
            OnFocusChanging = EventTreeFocusChanging
            OnFreeNode = SpellTreeFreeNode
            OnGetText = EventTreeGetText
            OnInitNode = SpellTreeInitNode
            OnMouseMove = unitTreeMouseMove
            ExplicitHeight = 578
            Columns = <
              item
                Position = 0
                Width = 207
              end>
          end
        end
        object TabSheet3: TTabSheet
          Tag = 50
          ImageIndex = 3
          ExplicitHeight = 578
          object CompareTree: TVirtualStringTree
            Left = 0
            Top = 25
            Width = 211
            Height = 572
            Align = alClient
            CheckImageKind = ckFlat
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag]
            Margin = 8
            PopupMenu = MenuCompare
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnBeforeCellPaint = CompareTreeBeforeCellPaint
            OnChecked = CompareTreeChecked
            OnFreeNode = CompareTreeFreeNode
            OnGetText = CompareTreeGetText
            OnInitNode = CompareTreeInitNode
            OnMouseMove = unitTreeMouseMove
            ExplicitHeight = 553
            Columns = <
              item
                Position = 0
                Width = 207
              end>
          end
          object Panel12: TPanel
            Left = 0
            Top = 0
            Width = 211
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Label4: TLabel
              Left = 0
              Top = 0
              Width = 201
              Height = 25
              AutoSize = False
              ParentShowHint = False
              ShowHint = False
              WordWrap = True
              OnMouseMove = unitTreeMouseMove
            end
          end
        end
        object TabSheet2: TTabSheet
          Tag = 51
          ImageIndex = 36
          ExplicitHeight = 578
          object PageControl3: TPageControl
            Left = 0
            Top = 41
            Width = 211
            Height = 556
            ActivePage = TabSheet10
            Align = alClient
            Style = tsFlatButtons
            TabOrder = 0
            OnMouseMove = unitTreeMouseMove
            ExplicitHeight = 537
            object TabSheet10: TTabSheet
              Caption = 'ChatLog'
              ExplicitHeight = 506
              object ChatTree: TVirtualStringTree
                Left = 0
                Top = 0
                Width = 203
                Height = 525
                Align = alClient
                Header.AutoSizeIndex = 0
                Header.Font.Charset = DEFAULT_CHARSET
                Header.Font.Color = clWindowText
                Header.Font.Height = -11
                Header.Font.Name = 'MS Sans Serif'
                Header.Font.Style = []
                Header.Options = [hoAutoResize, hoColumnResize, hoDrag]
                PopupMenu = ChatPopup
                TabOrder = 0
                TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
                OnCompareNodes = ChatTreeCompareNodes
                OnFocusChanging = ChatTreeFocusChanging
                OnFreeNode = ChatTreeFreeNode
                OnGetText = ChatTreeGetText
                OnPaintText = ChatTreePaintText
                OnMouseMove = unitTreeMouseMove
                ExplicitHeight = 506
                Columns = <
                  item
                    Position = 0
                    Width = 199
                  end>
              end
            end
            object TabSheet11: TTabSheet
              Caption = 'Chat BlackList'
              ImageIndex = 1
              ExplicitHeight = 506
              object Panel23: TPanel
                Left = 0
                Top = 0
                Width = 203
                Height = 25
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object autoclearchat: TCheckBox
                  Left = 7
                  Top = 4
                  Width = 162
                  Height = 17
                  Caption = 'Auto clear chat on loading'
                  Checked = True
                  ParentShowHint = False
                  ShowHint = False
                  State = cbChecked
                  TabOrder = 0
                  OnMouseMove = unitTreeMouseMove
                end
              end
              object ListBox1: TListBox
                Left = 0
                Top = 25
                Width = 203
                Height = 500
                Align = alClient
                ItemHeight = 13
                ParentShowHint = False
                PopupMenu = BlPopup
                ShowHint = False
                TabOrder = 1
                OnMouseMove = unitTreeMouseMove
                ExplicitHeight = 481
              end
            end
          end
          object Panel11: TPanel
            Left = 0
            Top = 0
            Width = 211
            Height = 41
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            OnMouseMove = unitTreeMouseMove
            object Button3: TButton
              Left = 3
              Top = 8
              Width = 121
              Height = 25
              Caption = 'Load ChatLog'
              TabOrder = 0
              OnClick = Button3Click
              OnMouseMove = unitTreeMouseMove
            end
            object Button4: TButton
              Left = 128
              Top = 8
              Width = 81
              Height = 25
              Caption = 'Clear'
              TabOrder = 1
              OnClick = Button4Click
              OnMouseMove = unitTreeMouseMove
            end
          end
        end
        object TabSheet9: TTabSheet
          Tag = 52
          Caption = 'TabSheet9'
          ImageIndex = 10
          ExplicitHeight = 578
          object MemoStat: TMemo
            Left = 0
            Top = 25
            Width = 211
            Height = 459
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ReadOnly = True
            ScrollBars = ssVertical
            ShowHint = False
            TabOrder = 0
            OnMouseMove = unitTreeMouseMove
            ExplicitHeight = 440
          end
          object MemoError: TMemo
            Left = 0
            Top = 508
            Width = 211
            Height = 89
            Align = alBottom
            ParentShowHint = False
            ScrollBars = ssVertical
            ShowHint = False
            TabOrder = 1
            WordWrap = False
            OnMouseMove = unitTreeMouseMove
            ExplicitTop = 489
          end
          object Panel21: TPanel
            Left = 0
            Top = 484
            Width = 211
            Height = 24
            Align = alBottom
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '   Error log:'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 2
            OnMouseMove = unitTreeMouseMove
            ExplicitTop = 465
          end
          object Panel22: TPanel
            Left = 0
            Top = 0
            Width = 211
            Height = 25
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Caption = '   Log Stats'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 3
            OnMouseMove = unitTreeMouseMove
          end
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 633
        Width = 219
        Height = 235
        Align = alBottom
        BevelOuter = bvNone
        BevelWidth = 3
        BorderWidth = 4
        TabOrder = 1
        OnMouseMove = Panel7MouseMove
        ExplicitTop = 614
        object Splitter3: TSplitter
          Left = 4
          Top = 113
          Width = 211
          Height = 6
          Cursor = crVSplit
          Align = alTop
          AutoSnap = False
          MinSize = 20
          ResizeStyle = rsUpdate
        end
        object TimeTree: TVirtualStringTree
          Left = 4
          Top = 119
          Width = 211
          Height = 112
          Align = alClient
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.MainColumn = 1
          Header.Options = [hoAutoResize, hoColumnResize, hoDrag]
          SelectionBlendFactor = 0
          TabOrder = 0
          TreeOptions.PaintOptions = [toHideFocusRect, toHideSelection, toShowButtons, toShowDropmark, toShowHorzGridLines, toUseBlendedImages, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toFullRowSelect]
          OnBeforeCellPaint = TimeTreeBeforeCellPaint
          OnFocusChanging = TimeTreeFocusChanging
          OnGetText = TimeTreeGetText
          OnPaintText = TimeTreePaintText
          OnMouseMove = TimeTreeMouseMove
          Columns = <
            item
              Position = 1
              Width = 182
            end
            item
              Alignment = taRightJustify
              Margin = 0
              MinWidth = 8
              Position = 0
              Spacing = 0
              Width = 25
            end>
        end
        object CustomFilterTree: TVirtualStringTree
          Left = 4
          Top = 4
          Width = 211
          Height = 109
          Align = alTop
          CheckImageKind = ckFlat
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.Options = [hoAutoResize, hoColumnResize, hoDrag]
          HintAnimation = hatNone
          LineStyle = lsSolid
          ParentShowHint = False
          PopupMenu = PopupFilter
          ShowHint = True
          TabOrder = 1
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toUseBlendedImages, toUseBlendedSelection]
          TreeOptions.SelectionOptions = [toFullRowSelect]
          OnChecked = CustomFilterTreeChecked
          OnFreeNode = CustomFilterTreeFreeNode
          OnGetText = CustomFilterTreeGetText
          OnPaintText = CustomFilterTreePaintText
          OnInitNode = CustomFilterTreeInitNode
          OnMouseMove = CustomFilterTreeMouseMove
          Columns = <
            item
              Position = 0
              Width = 207
            end>
        end
      end
    end
    object MainPanel: TPanel
      Left = 0
      Top = 0
      Width = 793
      Height = 868
      Align = alClient
      BevelOuter = bvNone
      Caption = 'MainPanel'
      TabOrder = 1
      ExplicitHeight = 849
      object Splitter4: TSplitter
        Left = 0
        Top = 680
        Width = 793
        Height = 4
        Cursor = crVSplit
        Align = alBottom
        AutoSnap = False
        MinSize = 90
        ExplicitTop = 302
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 793
        Height = 680
        ActivePage = ReplayTab
        Align = alClient
        BiDiMode = bdLeftToRight
        Images = imagelist1
        MultiLine = True
        ParentBiDiMode = False
        Style = tsFlatButtons
        TabOrder = 0
        ExplicitHeight = 661
        object TabSheet4: TTabSheet
          Caption = 'Home'
          ImageIndex = 10
          OnShow = TabSheet4Show
          ExplicitHeight = 629
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 785
            Height = 648
            Align = alClient
            BevelInner = bvLowered
            BevelOuter = bvNone
            TabOrder = 0
            ExplicitHeight = 629
            object ReadMeViewer: THtmlViewer
              Left = 1
              Top = 1
              Width = 783
              Height = 646
              TabOrder = 0
              Align = alClient
              BorderStyle = htFocused
              CharSet = DEFAULT_CHARSET
              DefBackground = clWindow
              DefFontName = 'Times New Roman'
              DefFontSize = 8
              DefHotSpotColor = 10485760
              DefPreFontName = 'Courier New'
              HistoryMaxCount = 0
              MarginHeight = 0
              MarginWidth = 0
              NoSelect = False
              PrintMarginBottom = 2.000000000000000000
              PrintMarginLeft = 2.000000000000000000
              PrintMarginRight = 2.000000000000000000
              PrintMarginTop = 2.000000000000000000
              PrintScale = 1.000000000000000000
              QuirksMode = qmDetect
              OnHotSpotClick = ReadMeViewerHotSpotClick
              ExplicitHeight = 627
            end
          end
        end
        object GraphicTab: TTabSheet
          Caption = 'Graphic'
          ImageIndex = 1
          OnShow = GraphicTabShow
          ExplicitHeight = 629
          object Panel1: TPanel
            Left = 0
            Top = 25
            Width = 785
            Height = 623
            Align = alClient
            BevelOuter = bvLowered
            TabOrder = 0
            ExplicitHeight = 604
            object Imagemap: TImage32
              Left = 1
              Top = 1
              Width = 771
              Height = 609
              Align = alClient
              Bitmap.ResamplerClassName = 'TNearestResampler'
              BitmapAlign = baTopLeft
              Color = 11184810
              ParentColor = False
              ParentShowHint = False
              PopupMenu = ImagePopUp
              Scale = 1.000000000000000000
              ScaleMode = smNormal
              ShowHint = True
              TabOrder = 0
              OnMouseDown = ImagemapMouseDown
              OnMouseMove = ImagemapMouseMove
              OnMouseUp = ImagemapMouseUp
              OnMouseWheelDown = ImagemapMouseWheelDown
              OnMouseWheelUp = ImagemapMouseWheelUp
              OnResize = ImagemapResize
              ExplicitHeight = 590
            end
            object GaugeBar2: TGaugeBar
              Left = 772
              Top = 1
              Width = 12
              Height = 609
              Align = alRight
              Backgnd = bgPattern
              BorderStyle = bsNone
              Enabled = False
              Kind = sbVertical
              ShowHandleGrip = True
              Style = rbsMac
              Position = 0
              OnChange = GaugeBar2Change
              ExplicitHeight = 590
            end
            object Panel9: TPanel
              Left = 1
              Top = 610
              Width = 783
              Height = 12
              Align = alBottom
              BevelOuter = bvNone
              Caption = 'Panel9'
              TabOrder = 2
              ExplicitTop = 591
              object Bevel1: TBevel
                Left = 772
                Top = 0
                Width = 11
                Height = 12
                Align = alRight
                Style = bsRaised
              end
              object GaugeBar3: TGaugeBar
                Left = 0
                Top = 0
                Width = 772
                Height = 12
                Align = alClient
                Backgnd = bgPattern
                BorderStyle = bsNone
                Enabled = False
                ShowHandleGrip = True
                Style = rbsMac
                Position = 0
                OnChange = GaugeBar3Change
              end
            end
          end
          object Panel3: TPanel
            Left = 0
            Top = 0
            Width = 785
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Panel13: TPanel
              Left = 0
              Top = 0
              Width = 274
              Height = 25
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              object ToolBar5: TToolBar
                Left = 0
                Top = 0
                Width = 274
                Height = 25
                Caption = 'ToolBar5'
                EdgeInner = esNone
                EdgeOuter = esNone
                HotImages = imagelist2
                Images = imagelist1
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                object LoadLogBut: TToolButton
                  Tag = 6
                  Left = 0
                  Top = 0
                  Caption = 'LoadLogBut'
                  DropdownMenu = LoadMenu1
                  ImageIndex = 17
                  Style = tbsDropDown
                  OnClick = LoadLog1Click
                end
                object SaveWcrFileBut: TToolButton
                  Tag = 28
                  Left = 36
                  Top = 0
                  Caption = 'SaveWcrFileBut'
                  Enabled = False
                  ImageIndex = 32
                  OnClick = SaveWcrFileButClick
                end
                object LiveUpdateCheck: TToolButton
                  Tag = 36
                  Left = 59
                  Top = 0
                  Caption = 'LiveUpdateCheck'
                  Enabled = False
                  ImageIndex = 34
                  Style = tbsCheck
                  OnClick = LiveUpdateCheckClick
                end
                object LiveUpdateUpdate: TToolButton
                  Tag = 37
                  Left = 82
                  Top = 0
                  Caption = 'LiveUpdateUpdate'
                  Enabled = False
                  ImageIndex = 35
                  OnClick = LiveUpdateUpdateClick
                end
                object ToolButton21: TToolButton
                  Left = 105
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton21'
                  ImageIndex = 4
                  Style = tbsSeparator
                end
                object But_Options: TToolButton
                  Tag = 55
                  Left = 113
                  Top = 0
                  Caption = 'Options'
                  ImageIndex = 30
                  OnClick = But_OptionsClick
                end
                object ToolButton8: TToolButton
                  Left = 136
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton8'
                  ImageIndex = 38
                  Style = tbsSeparator
                end
                object gfx_ResetFilter: TToolButton
                  Tag = 14
                  Left = 144
                  Top = 0
                  Caption = 'gfx_ResetFilter'
                  Enabled = False
                  ImageIndex = 5
                  OnClick = gfx_ResetFilterClick
                end
                object ToolButton17: TToolButton
                  Tag = 10
                  Left = 167
                  Top = 0
                  Caption = 'ToolButton17'
                  Enabled = False
                  ImageIndex = 6
                  OnClick = ToolButton17Click
                end
                object gfx_ResetFocus: TToolButton
                  Tag = 15
                  Left = 190
                  Top = 0
                  Caption = 'gfx_ResetFocus'
                  Enabled = False
                  ImageIndex = 13
                  OnClick = gfx_ResetFocusClick
                end
                object ToolButton26: TToolButton
                  Left = 213
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton26'
                  Enabled = False
                  ImageIndex = 34
                  Style = tbsSeparator
                end
                object btnFocusMode: TToolButton
                  Tag = 38
                  Left = 221
                  Top = 0
                  Caption = 'btnFocusMode'
                  ImageIndex = 33
                  Style = tbsCheck
                  OnClick = btnFocusModeClick
                end
                object btnFocusType: TToolButton
                  Tag = 53
                  Left = 244
                  Top = 0
                  Caption = 'btnFocusType'
                  DropdownMenu = menu_focusmode
                  ImageIndex = 46
                end
                object ToolButton14: TToolButton
                  Left = 267
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton14'
                  Enabled = False
                  ImageIndex = 37
                  Style = tbsSeparator
                end
              end
            end
            object Panel14: TPanel
              Left = 274
              Top = 0
              Width = 511
              Height = 25
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              object ToolBar1: TToolBar
                Left = 0
                Top = 0
                Width = 511
                Height = 25
                Caption = 'ToolBar1'
                EdgeInner = esNone
                EdgeOuter = esNone
                HotImages = imagelist2
                Images = imagelist1
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                object HideEvents: TToolButton
                  Tag = 54
                  Left = 0
                  Top = 0
                  Caption = 'HideEvents'
                  ImageIndex = 45
                  Style = tbsCheck
                  OnClick = HideEventsClick
                end
                object GfxDrawMarks: TToolButton
                  Tag = 56
                  Left = 23
                  Top = 0
                  Caption = 'GfxDrawMarks'
                  Down = True
                  ImageIndex = 49
                  Style = tbsCheck
                  OnClick = GfxDrawMarksClick
                end
                object GfxDrawStatsWidget: TToolButton
                  Tag = 57
                  Left = 46
                  Top = 0
                  Caption = 'GfxDrawStatsWidget'
                  Down = True
                  ImageIndex = 28
                  Style = tbsCheck
                  OnClick = GfxDrawStatsWidgetClick
                end
                object LineOnBG: TToolButton
                  Tag = 5
                  Left = 69
                  Top = 0
                  Caption = 'LineOnBG'
                  ImageIndex = 4
                  Style = tbsCheck
                  OnClick = LineOnBGClick
                end
                object relativeRatio: TToolButton
                  Tag = 4
                  Left = 92
                  Top = 0
                  Caption = 'relativeRatio'
                  ImageIndex = 3
                  Style = tbsCheck
                  OnClick = relativeRatioClick
                end
                object ToolButton3: TToolButton
                  Left = 115
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton3'
                  ImageIndex = 3
                  Style = tbsSeparator
                end
                object gfxtb1: TToolButton
                  Tag = 1
                  Left = 123
                  Top = 0
                  Hint = 'Hp'
                  Caption = 'gfxtb1'
                  Grouped = True
                  ImageIndex = 0
                  Style = tbsCheck
                  OnClick = gfxtb1Click
                end
                object gfxtb2: TToolButton
                  Tag = 2
                  Left = 146
                  Top = 0
                  Hint = 'Dps'
                  Caption = 'gfxtb2'
                  Grouped = True
                  ImageIndex = 1
                  Style = tbsCheck
                  OnClick = gfxtb1Click
                end
                object gfxtb3: TToolButton
                  Tag = 3
                  Left = 169
                  Top = 0
                  Hint = 'Hps'
                  Caption = 'gfxtb3'
                  Grouped = True
                  ImageIndex = 2
                  Style = tbsCheck
                  OnClick = gfxtb1Click
                end
                object ToolButton4: TToolButton
                  Left = 192
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton4'
                  ImageIndex = 8
                  Style = tbsSeparator
                end
                object ToolButton10: TToolButton
                  Tag = 16
                  Left = 200
                  Top = 0
                  Caption = 'ToolButton10'
                  DropdownMenu = menu_detailmode
                  ImageIndex = 12
                end
                object ToolButton6: TToolButton
                  Left = 223
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton6'
                  ImageIndex = 3
                  Style = tbsSeparator
                end
                object useFilterInArray: TToolButton
                  Tag = 29
                  Left = 231
                  Top = 0
                  Caption = 'useFilterInArray'
                  ImageIndex = 21
                  Style = tbsCheck
                  OnClick = GfxRaidDpsOutClick
                end
                object btnAbsorb: TToolButton
                  Tag = 40
                  Left = 254
                  Top = 0
                  Caption = 'btnAbsorb'
                  ImageIndex = 37
                  Style = tbsCheck
                  OnClick = btnAbsorbClick
                end
                object GfxRaidDpsOut: TToolButton
                  Tag = 32
                  Left = 277
                  Top = 0
                  Caption = 'GfxRaidDpsOut'
                  ImageIndex = 1
                  Style = tbsCheck
                  OnClick = GfxRaidDpsOutClick
                end
                object GfxRaidDpsIn: TToolButton
                  Tag = 33
                  Left = 300
                  Top = 0
                  Caption = 'GfxRaidDpsIn'
                  ImageIndex = 1
                  Style = tbsCheck
                  OnClick = GfxRaidDpsOutClick
                end
                object GfxRaidHpsOut: TToolButton
                  Tag = 34
                  Left = 323
                  Top = 0
                  Caption = 'GfxRaidHpsOut'
                  ImageIndex = 2
                  Style = tbsCheck
                  OnClick = GfxRaidDpsOutClick
                end
                object GfxRaidEffHpsOut: TToolButton
                  Tag = 35
                  Left = 346
                  Top = 0
                  Caption = 'GfxRaidEffHpsOut'
                  ImageIndex = 2
                  Style = tbsCheck
                  OnClick = GfxRaidDpsOutClick
                end
              end
            end
          end
        end
        object ReplayTab: TTabSheet
          Caption = 'ReplayGfx'
          ImageIndex = 9
          OnShow = ReplayTabShow
          ExplicitHeight = 629
          object Panel26: TPanel
            Left = 0
            Top = 0
            Width = 785
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Panel28: TPanel
              Left = 0
              Top = 0
              Width = 785
              Height = 25
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              object ToolBar6: TToolBar
                Left = 0
                Top = 0
                Width = 785
                Height = 25
                Caption = 'ToolBar1'
                EdgeInner = esNone
                EdgeOuter = esNone
                HotImages = imagelist2
                Images = imagelist1
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                object butreplay_play: TToolButton
                  Tag = 58
                  Left = 0
                  Top = 0
                  Caption = 'butreplay_play'
                  DropdownMenu = replayPopup
                  ImageIndex = 50
                  Style = tbsDropDown
                  OnClick = butreplay_playClick
                end
                object ToolButton1: TToolButton
                  Left = 36
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton1'
                  ImageIndex = 4
                  Style = tbsSeparator
                end
                object ToolButton5: TToolButton
                  Tag = 62
                  Left = 44
                  Top = 0
                  Caption = 'ToolButton5'
                  DropdownMenu = replayPopupRotate
                  ImageIndex = 52
                  Style = tbsDropDown
                  OnClick = ToolButton5Click
                end
                object butreplay_fitimage: TToolButton
                  Tag = 59
                  Left = 80
                  Top = 0
                  Caption = 'butreplay_fitimage'
                  ImageIndex = 25
                  OnClick = butreplay_fitimageClick
                end
                object butreplay_autofit: TToolButton
                  Tag = 60
                  Left = 103
                  Top = 0
                  Caption = 'butreplay_autofit'
                  ImageIndex = 53
                  Style = tbsCheck
                  OnClick = butreplay_autofitClick
                end
                object butreplay_circle: TToolButton
                  Tag = 61
                  Left = 126
                  Top = 0
                  Caption = 'butreplay_autofit'
                  ImageIndex = 54
                  Style = tbsCheck
                  OnClick = butreplay_circleClick
                end
                object butreplay_showAttack: TToolButton
                  Tag = 63
                  Left = 149
                  Top = 0
                  Caption = 'butreplay_showAttack'
                  ImageIndex = 55
                  Style = tbsCheck
                  OnClick = butreplay_showAttackClick
                end
                object butreplay_showPlayer: TToolButton
                  Tag = 64
                  Left = 172
                  Top = 0
                  Caption = 'butreplay_showPlayer'
                  ImageIndex = 56
                  Style = tbsCheck
                  OnClick = butreplay_showPlayerClick
                end
              end
            end
          end
          object Panel27: TPanel
            Left = 0
            Top = 25
            Width = 785
            Height = 623
            Align = alClient
            BevelOuter = bvLowered
            TabOrder = 1
            ExplicitHeight = 604
            object ImageReplay: TImage32
              Left = 1
              Top = 1
              Width = 783
              Height = 621
              Align = alClient
              Bitmap.ResamplerClassName = 'TNearestResampler'
              BitmapAlign = baTopLeft
              Color = 11184810
              ParentColor = False
              ParentShowHint = False
              PopupMenu = ImagePopUp
              Scale = 1.000000000000000000
              ScaleMode = smNormal
              ShowHint = True
              TabOrder = 0
              OnMouseDown = ImageReplayMouseDown
              OnMouseMove = ImageReplayMouseMove
              OnMouseUp = ImageReplayMouseUp
              OnMouseWheelDown = ImageReplayMouseWheelDown
              OnMouseWheelUp = ImageReplayMouseWheelUp
              ExplicitHeight = 602
            end
          end
        end
        object StatsTab: TTabSheet
          Caption = 'Stats'
          ImageIndex = 28
          OnShow = StatsTabShow
          ExplicitHeight = 629
          object StatTree: TVirtualStringTree
            Left = 0
            Top = 25
            Width = 785
            Height = 623
            Align = alClient
            ButtonStyle = bsTriangle
            CheckImageKind = ckFlat
            Color = clWhite
            Colors.GridLineColor = 14540253
            Ctl3D = False
            DefaultNodeHeight = 16
            Header.AutoSizeIndex = 0
            Header.Background = clWhite
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'Arial'
            Header.Font.Style = []
            Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
            Header.SortColumn = 1
            Header.SortDirection = sdDescending
            Header.Style = hsPlates
            Images = imagelist3
            Indent = 20
            LineMode = lmBands
            Margin = 2
            ParentCtl3D = False
            ParentShowHint = False
            PopupMenu = StatPopup
            SelectionBlendFactor = 40
            ShowHint = True
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toUseBlendedImages, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
            OnBeforeCellPaint = StatTreeBeforeCellPaint
            OnBeforePaint = StatTreeBeforePaint
            OnCollapsed = StatTreeExpanded
            OnCompareNodes = StatTreeCompareNodes
            OnContextPopup = StatTreeContextPopup
            OnExpanded = StatTreeExpanded
            OnFocusChanged = StatTreeFocusChanged
            OnFreeNode = StatTreeFreeNode
            OnGetText = StatTreeGetText
            OnPaintText = StatTreePaintText
            OnGetImageIndex = StatTreeGetImageIndex
            OnHeaderClick = StatTreeHeaderClick
            OnMouseMove = StatTreeMouseMove
            ExplicitHeight = 604
            Columns = <
              item
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coFixed]
                Position = 0
                Tag = 14
                Width = 140
                WideText = 'Name'
              end
              item
                Alignment = taRightJustify
                Position = 4
                Width = 100
                WideText = 'Damages Done'
              end
              item
                Alignment = taRightJustify
                Position = 5
                Width = 100
                WideText = 'Damages Taken'
              end
              item
                Alignment = taRightJustify
                Position = 9
                Width = 100
                WideText = 'Eff.H Done'
              end
              item
                Alignment = taRightJustify
                Position = 8
                Width = 100
                WideText = 'Raw.H Done'
              end
              item
                Alignment = taRightJustify
                Position = 10
                Width = 100
                WideText = 'Healing Taken'
              end
              item
                Alignment = taRightJustify
                Position = 6
                WideText = 'Mitig.'
              end
              item
                Alignment = taRightJustify
                Position = 7
                WideText = 'Est.Absorb Done'
              end
              item
                Alignment = taRightJustify
                Position = 2
                Width = 40
                WideText = 'Act.'
              end
              item
                Alignment = taRightJustify
                Position = 3
                WideText = 'Act.Dps'
              end
              item
                Position = 1
                Width = 40
                WideText = 'iLvl'
              end>
            WideDefaultText = ''
          end
          object Panel16: TPanel
            Left = 0
            Top = 0
            Width = 785
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Panel18: TPanel
              Left = 0
              Top = 0
              Width = 785
              Height = 25
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              object ToolBar3: TToolBar
                Left = 0
                Top = 0
                Width = 785
                Height = 25
                Caption = 'ToolBar1'
                EdgeInner = esNone
                EdgeOuter = esNone
                HotImages = imagelist2
                Images = imagelist1
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                object Stats_UseFilter: TToolButton
                  Tag = 19
                  Left = 0
                  Top = 0
                  Caption = 'Stats_UseFilter'
                  Down = True
                  ImageIndex = 21
                  Style = tbsCheck
                  OnClick = Stat_LaunchStatClick
                end
                object Stat_UseUnitRef: TToolButton
                  Tag = 23
                  Left = 23
                  Top = 0
                  Caption = 'Stat_UseUnitRef'
                  Down = True
                  ImageIndex = 11
                  Style = tbsCheck
                  OnClick = Stat_LaunchStatClick
                end
                object Stat_assignAff: TToolButton
                  Tag = 22
                  Left = 46
                  Top = 0
                  Caption = 'Stat_assignAff'
                  Down = True
                  ImageIndex = 31
                  Style = tbsCheck
                  OnClick = Stat_LaunchStatClick
                end
                object Stat_absorb: TToolButton
                  Tag = 40
                  Left = 69
                  Top = 0
                  Caption = 'Stat_absorb'
                  ImageIndex = 37
                  Style = tbsCheck
                  OnClick = Stat_absorbClick
                end
                object Stat_MergeAbsorb: TToolButton
                  Tag = 41
                  Left = 92
                  Top = 0
                  Caption = 'Stat_MergeAbsorb'
                  Down = True
                  ImageIndex = 38
                  Style = tbsCheck
                  OnClick = Stat_MergeAbsorbClick
                end
                object Stat_NoEnemyHeal: TToolButton
                  Tag = 43
                  Left = 115
                  Top = 0
                  Caption = 'Stat_NoEnemyHeal'
                  Down = True
                  ImageIndex = 39
                  Style = tbsCheck
                  OnClick = Stat_NoEnemyHealClick
                end
                object Stat_NoFriendDamage: TToolButton
                  Tag = 44
                  Left = 138
                  Top = 0
                  Caption = 'Stat_NoFriendDamage'
                  Down = True
                  ImageIndex = 40
                  Style = tbsCheck
                  OnClick = Stat_NoEnemyHealClick
                end
                object Stat_ShowActDps: TToolButton
                  Tag = 45
                  Left = 161
                  Top = 0
                  Caption = 'Stat_ShowActDps'
                  Down = True
                  ImageIndex = 15
                  Style = tbsCheck
                  OnClick = Stat_ShowActDpsClick
                end
                object ToolButton2: TToolButton
                  Left = 184
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton2'
                  ImageIndex = 20
                  Style = tbsSeparator
                end
                object Stat_LaunchStat: TToolButton
                  Tag = 7
                  Left = 192
                  Top = 0
                  Caption = 'Stat_LaunchStat'
                  ImageIndex = 28
                  OnClick = Stat_LaunchStatClick
                end
                object ToolButton11: TToolButton
                  Left = 215
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton11'
                  ImageIndex = 6
                  Style = tbsSeparator
                end
                object ToolButton15: TToolButton
                  Tag = 24
                  Left = 223
                  Top = 0
                  Caption = 'ToolButton15'
                  ImageIndex = 25
                  OnClick = ToolButton15Click
                end
                object Stat_OnlyCombat: TToolButton
                  Left = 246
                  Top = 0
                  Caption = 'Stat_OnlyCombat'
                  Down = True
                  ImageIndex = 20
                  Style = tbsCheck
                  Visible = False
                  OnClick = Stat_OnlyCombatClick
                end
              end
            end
          end
        end
        object ListViewTab: TTabSheet
          Caption = 'EventsList'
          ImageIndex = 8
          OnShow = ListViewTabShow
          ExplicitHeight = 629
          object MyTree: TVirtualStringTree
            Left = 0
            Top = 25
            Width = 785
            Height = 623
            Align = alClient
            Color = clWhite
            Ctl3D = False
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoVisible, hoAutoSpring]
            Header.Style = hsPlates
            Images = imagelist3
            LineStyle = lsSolid
            ParentCtl3D = False
            ParentShowHint = False
            PopupMenu = TreeMenu
            ShowHint = True
            TabOrder = 0
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toUseBlendedImages, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
            OnBeforeCellPaint = MyTreeBeforeCellPaint
            OnFreeNode = MyTreeFreeNode
            OnGetText = MyTreeGetText
            OnGetImageIndex = MyTreeGetImageIndex
            OnMouseMove = MyTreeMouseMove
            ExplicitHeight = 604
            Columns = <
              item
                Position = 1
                Width = 100
                WideText = 'Time'
              end
              item
                Position = 2
                Width = 150
                WideText = 'Event'
              end
              item
                Position = 3
                Width = 150
                WideText = 'Source'
              end
              item
                Position = 4
                Width = 150
                WideText = 'Dest'
              end
              item
                Position = 5
                Width = 120
                WideText = 'Spell'
              end
              item
                Alignment = taRightJustify
                Position = 6
                Width = 150
                WideText = 'Amount'
              end
              item
                Alignment = taRightJustify
                Position = 7
                Width = 150
                WideText = 'Sp'#233'cial'
              end
              item
                Alignment = taRightJustify
                Position = 8
                Width = 70
                WideText = 'SpellID'
              end
              item
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible]
                Position = 0
                Width = 20
              end>
          end
          object Panel19: TPanel
            Left = 0
            Top = 0
            Width = 785
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Panel20: TPanel
              Left = 0
              Top = 0
              Width = 785
              Height = 25
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              object ToolBar2: TToolBar
                Left = 0
                Top = 0
                Width = 785
                Height = 25
                Caption = 'ToolBar1'
                EdgeInner = esNone
                EdgeOuter = esNone
                HotImages = imagelist2
                Images = imagelist1
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                object ListBut_UseSelection: TToolButton
                  Tag = 10
                  Left = 0
                  Top = 0
                  Caption = 'ListBut_UseSelection'
                  Down = True
                  ImageIndex = 24
                  Style = tbsCheck
                  OnClick = ListBut_UseSelectionClick
                end
                object ListBut_ApplyFullFilter: TToolButton
                  Tag = 11
                  Left = 23
                  Top = 0
                  Caption = 'ListBut_ApplyFullFilter'
                  Down = True
                  ImageIndex = 21
                  Style = tbsCheck
                  OnClick = ListBut_UseSelectionClick
                end
                object ListBut_UseUnitRef: TToolButton
                  Tag = 23
                  Left = 46
                  Top = 0
                  Caption = 'ListBut_UseUnitRef'
                  Down = True
                  ImageIndex = 11
                  Style = tbsCheck
                  OnClick = ListBut_UseSelectionClick
                end
                object ListBut_AutoRefresh: TToolButton
                  Tag = 12
                  Left = 69
                  Top = 0
                  Caption = 'ListBut_AutoRefresh'
                  Down = True
                  ImageIndex = 22
                  Style = tbsCheck
                end
                object ListBut_Security: TToolButton
                  Tag = 18
                  Left = 92
                  Top = 0
                  Caption = 'ListBut_Security'
                  Down = True
                  ImageIndex = 27
                  Style = tbsCheck
                end
                object ListBut_Refresh: TToolButton
                  Tag = 13
                  Left = 115
                  Top = 0
                  Caption = 'ListBut_Refresh'
                  ImageIndex = 23
                  OnClick = ListBut_RefreshClick
                end
              end
            end
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'Dispel Overview'
          ImageIndex = 28
          OnShow = TabSheet8Show
          ExplicitHeight = 629
          object WatchedEventTree: TVirtualStringTree
            Left = 174
            Top = 25
            Width = 611
            Height = 623
            Align = alClient
            ButtonStyle = bsTriangle
            CheckImageKind = ckFlat
            Color = clWhite
            Ctl3D = False
            Header.AutoSizeIndex = 2
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDblClickResize, hoDrag, hoShowSortGlyphs, hoVisible]
            Header.Style = hsPlates
            Indent = 20
            LineMode = lmBands
            ParentCtl3D = False
            ScrollBarOptions.AlwaysVisible = True
            ScrollBarOptions.ScrollBars = ssVertical
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toUseBlendedImages, toUseBlendedSelection]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnBeforeCellPaint = WatchedEventTreeBeforeCellPaint
            OnCollapsed = WatchedEventTreeExpanded
            OnCompareNodes = WatchedEventTreeCompareNodes
            OnExpanded = WatchedEventTreeExpanded
            OnFreeNode = WatchedEventTreeFreeNode
            OnGetText = WatchedEventTreeGetText
            OnPaintText = WatchedEventTreePaintText
            ExplicitHeight = 604
            Columns = <
              item
                Position = 0
                Width = 200
                WideText = 'Unit'
              end
              item
                Position = 1
                WideText = '##'
              end
              item
                Position = 2
                Width = 343
                WideText = 'Details'
              end>
          end
          object SideBar1: TNiceSideBar
            Left = 0
            Top = 25
            Width = 169
            Height = 623
            ItemStyle.NormalFont.Charset = DEFAULT_CHARSET
            ItemStyle.NormalFont.Color = clWindowText
            ItemStyle.NormalFont.Height = -11
            ItemStyle.NormalFont.Name = 'Arial'
            ItemStyle.NormalFont.Style = []
            ItemStyle.HoverFont.Charset = DEFAULT_CHARSET
            ItemStyle.HoverFont.Color = clWindowText
            ItemStyle.HoverFont.Height = -11
            ItemStyle.HoverFont.Name = 'Arial'
            ItemStyle.HoverFont.Style = [fsBold]
            ItemStyle.SelectedFont.Charset = DEFAULT_CHARSET
            ItemStyle.SelectedFont.Color = clWindowText
            ItemStyle.SelectedFont.Height = -11
            ItemStyle.SelectedFont.Name = 'Arial'
            ItemStyle.SelectedFont.Style = [fsBold]
            ItemStyle.HoverColor = clBtnFace
            ItemStyle.SelectedColor = clBtnFace
            ItemStyle.LineColor = clBtnFace
            SubItemStyle.NormalFont.Charset = DEFAULT_CHARSET
            SubItemStyle.NormalFont.Color = clWindowText
            SubItemStyle.NormalFont.Height = -11
            SubItemStyle.NormalFont.Name = 'Arial'
            SubItemStyle.NormalFont.Style = []
            SubItemStyle.HoverFont.Charset = DEFAULT_CHARSET
            SubItemStyle.HoverFont.Color = clMenuHighlight
            SubItemStyle.HoverFont.Height = -11
            SubItemStyle.HoverFont.Name = 'Arial'
            SubItemStyle.HoverFont.Style = []
            SubItemStyle.SelectedFont.Charset = DEFAULT_CHARSET
            SubItemStyle.SelectedFont.Color = clWindowText
            SubItemStyle.SelectedFont.Height = -11
            SubItemStyle.SelectedFont.Name = 'Arial'
            SubItemStyle.SelectedFont.Style = []
            SubItemStyle.HoverColor = clBtnHighlight
            SubItemStyle.LineColor = clBtnFace
            Bullets.HoverColor = clMenuHighlight
            Bullets.HoverPenColor = clMenuHighlight
            Items = <>
            ItemHeight = 18
            Margin = 0
            GroupSeparator = 0
            Indent = 0
            AlwaysExpand = True
            OnSelect = SideBar1Select
            BevelOuter = bvNone
            BorderStyle = bsNone
            ParentBackground = False
            ExplicitHeight = 604
          end
          object Panel15: TPanel
            Left = 169
            Top = 25
            Width = 5
            Height = 623
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 2
            ExplicitHeight = 604
          end
          object Panel17: TPanel
            Left = 0
            Top = 0
            Width = 785
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 3
          end
        end
      end
      object Panel25: TPanel
        Left = 0
        Top = 684
        Width = 793
        Height = 184
        Align = alBottom
        BevelOuter = bvNone
        BorderWidth = 4
        Caption = 'Panel25'
        TabOrder = 1
        ExplicitTop = 665
        object Panel24: TPanel
          Left = 4
          Top = 4
          Width = 785
          Height = 176
          Align = alClient
          BevelOuter = bvLowered
          Caption = 'Panel24'
          TabOrder = 0
          object Splitter5: TSplitter
            Left = 201
            Top = 1
            Height = 174
            AutoSnap = False
            Color = 12237498
            MinSize = 40
            ParentColor = False
          end
          object htmlstats: THtmlViewer
            Left = 1
            Top = 1
            Width = 200
            Height = 174
            TabOrder = 0
            Align = alLeft
            BorderStyle = htNone
            CharSet = DEFAULT_CHARSET
            DefBackground = 13421772
            DefFontName = 'Times New Roman'
            DefFontSize = 8
            DefPreFontName = 'Courier New'
            HistoryMaxCount = 0
            MarginWidth = 5
            NoSelect = False
            PrintMarginBottom = 2.000000000000000000
            PrintMarginLeft = 2.000000000000000000
            PrintMarginRight = 2.000000000000000000
            PrintMarginTop = 2.000000000000000000
            PrintScale = 1.000000000000000000
            QuirksMode = qmDetect
            ScrollBars = ssNone
            OnHotSpotClick = htmlstatsMenuHotSpotClick
          end
          object Panel10: TPanel
            Left = 204
            Top = 1
            Width = 580
            Height = 174
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel10'
            TabOrder = 1
            object htmlstatsMenu: THtmlViewer
              Left = 0
              Top = 0
              Width = 580
              Height = 41
              TabOrder = 0
              Align = alTop
              BorderStyle = htNone
              CharSet = DEFAULT_CHARSET
              DefBackground = 13421772
              DefFontName = 'Times New Roman'
              DefFontSize = 8
              DefPreFontName = 'Courier New'
              HistoryMaxCount = 0
              MarginWidth = 5
              NoSelect = False
              PrintMarginBottom = 2.000000000000000000
              PrintMarginLeft = 2.000000000000000000
              PrintMarginRight = 2.000000000000000000
              PrintMarginTop = 2.000000000000000000
              PrintScale = 1.000000000000000000
              QuirksMode = qmDetect
              ScrollBars = ssNone
              OnHotSpotClick = htmlstatsMenuHotSpotClick
            end
            object UnitStatTree: TVirtualStringTree
              Left = 0
              Top = 41
              Width = 580
              Height = 133
              Align = alClient
              BorderStyle = bsNone
              BorderWidth = 12
              Color = 13421772
              Colors.BorderColor = 13421772
              Colors.DisabledColor = 11184810
              Colors.GridLineColor = 11184810
              Colors.HeaderHotColor = 11184810
              Colors.TreeLineColor = 11184810
              Colors.UnfocusedSelectionColor = 11184810
              Colors.UnfocusedSelectionBorderColor = 11184810
              Ctl3D = True
              DefaultNodeHeight = 16
              Header.AutoSizeIndex = -1
              Header.Background = 13421772
              Header.DefaultHeight = 16
              Header.Font.Charset = DEFAULT_CHARSET
              Header.Font.Color = clWindowText
              Header.Font.Height = -11
              Header.Font.Name = 'Arial'
              Header.Font.Style = [fsBold]
              Header.Height = 18
              Header.MainColumn = -1
              Header.Options = [hoColumnResize, hoVisible]
              Header.SortDirection = sdDescending
              Header.Style = hsPlates
              HintAnimation = hatNone
              Indent = 0
              LineStyle = lsSolid
              ParentCtl3D = False
              ParentShowHint = False
              PopupMenu = SpellPopup
              SelectionBlendFactor = 40
              ShowHint = True
              TabOrder = 1
              TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
              TreeOptions.PaintOptions = [toPopupMode, toShowVertGridLines, toUseBlendedImages, toUseBlendedSelection]
              TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
              OnAdvancedHeaderDraw = UnitStatTreeAdvancedHeaderDraw
              OnBeforeCellPaint = UnitStatTreeBeforeCellPaint
              OnCollapsing = UnitStatTreeCollapsing
              OnColumnClick = UnitStatTreeColumnClick
              OnCompareNodes = UnitStatTreeCompareNodes
              OnContextPopup = UnitStatTreeContextPopup
              OnFreeNode = StatTreeFreeNode
              OnGetText = UnitStatTreeGetText
              OnPaintText = UnitStatTreePaintText
              OnHeaderClick = UnitStatTreeHeaderClick
              OnHeaderDrawQueryElements = UnitStatTreeHeaderDrawQueryElements
              OnMouseMove = UnitStatTreeMouseMove
              Columns = <>
            end
          end
        end
      end
    end
  end
  object TreeMenu: TPopupMenu
    OnPopup = TreeMenuPopup
    Left = 560
    Top = 112
    object SetStartGraph1: TMenuItem
      Caption = 'SetStartGraph'
      OnClick = SetStartGraph1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object filterSrcName: TMenuItem
      Caption = 'Toggle focus on:'
      OnClick = filterSrcNameClick
    end
    object filterDestName: TMenuItem
      Caption = 'Events for:'
      OnClick = filterDestNameClick
    end
    object FilterAroundEvents1: TMenuItem
      Caption = 'ShowAllAround'
      OnClick = FilterAroundEvents1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object EditSpell3: TMenuItem
      Caption = 'EditSpellParams'
      OnClick = EditSpell3Click
    end
    object CheckSpell1: TMenuItem
      Caption = 'CheckOnWeb [Spell]'
      OnClick = CheckSpell1Click
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'txt'
    Filter = 
      'Fichier Log (*.log , *.txt , *.lua, *.wcr)|*.log;*.txt;*.lua;*.w' +
      'cr'
    Left = 536
    Top = 152
  end
  object ImagePopUp: TPopupMenu
    Images = imagelist1
    OnPopup = ImagePopUpPopup
    Left = 368
    Top = 128
    object DetailsOnUnit1: TMenuItem
      Caption = 'Details ForUnit'
      SubMenuImages = imagelist1
      ImageIndex = 12
      OnClick = DetailsOnUnit1Click
    end
    object ShowOnlyUnit1: TMenuItem
      Caption = 'Toggle Focus'
      ImageIndex = 33
      OnClick = ShowOnlyUnit1Click
    end
    object ShowOnlyAllUnit1: TMenuItem
      Caption = 'Toggle focus for all'
      ImageIndex = 33
      OnClick = ShowOnlyAllUnit1Click
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object ShowOnlySpell1: TMenuItem
      Caption = 'ShowOnlySpell'
      OnClick = ShowOnlySpell1Click
    end
    object N17: TMenuItem
      Caption = '-'
    end
    object SetAuraWatch1: TMenuItem
      Caption = 'Set AuraWatch'
      OnClick = SetAuraWatch1Click
    end
    object SetAuraWatchUnit2: TMenuItem
      Caption = 'Set AuraWatchUnit'
      OnClick = SetAuraWatchUnit2Click
    end
    object RemoveAuraWatch1: TMenuItem
      Caption = 'Remove AuraWatch'
      OnClick = RemoveAuraWatch1Click
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object Reset1: TMenuItem
      Caption = 'Reset'
      object ResetSel2: TMenuItem
        Caption = 'Spell/Event selection'
        ImageIndex = 5
        OnClick = ResetSel2Click
      end
      object ResetSel1: TMenuItem
        Caption = 'Unit(s) Focus'
        ImageIndex = 13
        OnClick = ResetSel1Click
      end
      object ResetSel3: TMenuItem
        Caption = 'TimePeriod'
        ImageIndex = 6
        OnClick = ResetSel3Click
      end
      object ResetSel4: TMenuItem
        Caption = 'Marker'
        OnClick = ResetSel4Click
      end
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object ViewEventInList1: TMenuItem
      Caption = 'ViewEventInList'
      OnClick = ViewEventInList1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object UpdateUnit2: TMenuItem
      Caption = 'UnitOptions'
      ImageIndex = 11
      OnClick = UpdateUnit2Click
    end
    object UpdateUnitAff2: TMenuItem
      Caption = 'Aff Boss Opts'
      ImageIndex = 11
      OnClick = UpdateUnitAff2Click
    end
    object EditSpell1: TMenuItem
      Caption = 'EditSpellParams'
      ImageIndex = 11
      OnClick = EditSpell1Click
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object CheckUnitOnWeb1: TMenuItem
      Caption = 'CheckUnitOnWeb'
      ImageIndex = 26
      OnClick = CheckUnitOnWeb1Click
    end
    object ForcePlayerInRaid1: TMenuItem
      Caption = 'ForcePlayerInRaid'
      OnClick = ForcePlayerInRaid1Click
    end
    object CheckSpell2: TMenuItem
      Caption = 'Check Spell on WowHead'
      ImageIndex = 26
      OnClick = CheckSpell2Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object LoadLog1: TMenuItem
      Caption = 'LoadLog'
      ImageIndex = 17
      ShortCut = 16463
      OnClick = LoadLog1Click
    end
  end
  object UnitTreePopup: TPopupMenu
    AutoPopup = False
    Images = imagelist1
    OnPopup = UnitTreePopupPopup
    Left = 653
    Top = 188
    object Unit1: TMenuItem
      Caption = 'Unit'
      ImageIndex = 12
      OnClick = Unit1Click
    end
    object ToggleFocus1: TMenuItem
      Caption = 'ToggleFocus'
      ImageIndex = 33
      OnClick = ToggleFocus1Click
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object UncheckAllPlayers1: TMenuItem
      Caption = 'Uncheck All Players'
      OnClick = UncheckAllPlayers1Click
    end
    object ResetPlayerStates1: TMenuItem
      Caption = 'Reset Player States'
      OnClick = ResetPlayerStates1Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object EditUnitParams1: TMenuItem
      Caption = 'EditUnitParams'
      ImageIndex = 11
      OnClick = EditUnitParams1Click
    end
    object CheckOnWeb1: TMenuItem
      Caption = 'CheckUnitOnWeb'
      Visible = False
      OnClick = CheckOnWeb1Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object Options1: TMenuItem
      Caption = 'Options'
      ImageIndex = 30
      object AutosortListby1: TMenuItem
        Caption = 'Autosort List by'
        object Unittreesort0: TMenuItem
          AutoCheck = True
          Caption = 'Name'
          Checked = True
          RadioItem = True
          OnClick = Unittreesort0Click
        end
        object Unittreesort1: TMenuItem
          AutoCheck = True
          Caption = 'Class'
          RadioItem = True
          OnClick = Unittreesort0Click
        end
        object Unittreesort2: TMenuItem
          AutoCheck = True
          Caption = 'Role'
          RadioItem = True
          OnClick = Unittreesort0Click
        end
      end
      object GfxNoNpc: TMenuItem
        AutoCheck = True
        Caption = 'Don'#39't dynamically add NPC'
        OnClick = GfxNoNpcClick
      end
      object GfxNoPet: TMenuItem
        AutoCheck = True
        Caption = 'Don'#39't dynamically add Pet'
        Checked = True
        OnClick = GfxNoNpcClick
      end
      object GfxNoAffiliation: TMenuItem
        AutoCheck = True
        Caption = 'Don'#39't dynamically add AffiliatedNPC'
        Checked = True
        OnClick = GfxNoNpcClick
      end
      object GfxAlwaysBoss: TMenuItem
        AutoCheck = True
        Caption = 'Always add Boss Npc'
        Checked = True
        OnClick = GfxNoNpcClick
      end
      object GfxShowInactive: TMenuItem
        AutoCheck = True
        Caption = 'Show inactive raid player'
        OnClick = GfxNoNpcClick
      end
      object GfxNoExternal: TMenuItem
        AutoCheck = True
        Caption = 'Hide external player'
        Checked = True
        OnClick = GfxNoExternalClick
      end
      object treeOnlyInCombat1: TMenuItem
        AutoCheck = True
        Caption = 'ShowOnlyUnitInCombat'
        OnClick = treeOnlyInCombat1Click
      end
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object RegisteredUnits1: TMenuItem
      Caption = 'Registered Units'
      OnClick = RegisteredUnits1Click
    end
    object RegisteredSpells1: TMenuItem
      Caption = 'Registered Spells'
      OnClick = RegisteredSpells1Click
    end
  end
  object SpellPopup: TPopupMenu
    AutoPopup = False
    Images = imagelist1
    OnPopup = SpellPopupPopup
    Left = 541
    Top = 276
    object CheckAll1: TMenuItem
      Caption = 'Reset SpellDefaultSelection'
      ImageIndex = 5
      OnClick = CheckAll1Click
    end
    object Resetfullfilter2: TMenuItem
      Caption = 'Reset FullDefaultFilter'
      ImageIndex = 5
      OnClick = Resetfullfilter2Click
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object SetAuraWatch2: TMenuItem
      Caption = 'Set AuraWatch'
      OnClick = SetAuraWatch2Click
    end
    object SetAuraWatchUnit1: TMenuItem
      Caption = 'SetAuraWatchUnit'
      OnClick = SetAuraWatchUnit1Click
    end
    object RemoveAuraWatch2: TMenuItem
      Caption = 'RemoveAuraWatch'
      OnClick = RemoveAuraWatch1Click
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object EditSpell2: TMenuItem
      Caption = 'EditSpellParams'
      ImageIndex = 11
      OnClick = EditSpell2Click
    end
    object SpellInfo1: TMenuItem
      Caption = 'Info'
      ImageIndex = 26
      OnClick = SpellInfo1Click
    end
  end
  object EventPopUp: TPopupMenu
    Left = 581
    Top = 260
    object CheckAll2: TMenuItem
      Caption = 'Reset EventDefaultSelection'
      OnClick = CheckAll2Click
    end
    object ResetFullFilter3: TMenuItem
      Caption = 'Reset DefaultFilter'
      OnClick = ResetFullFilter3Click
    end
  end
  object Filterpopup: TPopupMenu
    Left = 468
    Top = 284
    object ResetSelection1: TMenuItem
      Caption = 'Reset TagDefaultFilter'
      OnClick = ResetSelection1Click
    end
    object Resetfullfilter1: TMenuItem
      Caption = 'ResetDefaultFilter'
      OnClick = Resetfullfilter1Click
    end
  end
  object MainMenu1: TMainMenu
    Left = 413
    Top = 69
    object File1: TMenuItem
      Caption = 'File'
      Visible = False
      object loadlog2: TMenuItem
        Caption = 'Load Log'
        ShortCut = 16463
        OnClick = LoadLog1Click
      end
      object Anon: TMenuItem
        Caption = 'Anon'
        ShortCut = 49217
        OnClick = AnonClick
      end
      object clipboard1: TMenuItem
        Caption = 'clipboard'
        ShortCut = 16451
        OnClick = clipboard1Click
      end
    end
  end
  object imagelist1: TImageList
    Left = 397
    Top = 189
    Bitmap = {
      494C01013C00CC00CC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000000001000001002000000000000000
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000077500E0077500E0077500E007B531400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000077500E0077500E0077500E0077500F00726123006D71380081571C008459
      2000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007750
      0E0077500E0077500E00745C1D006C753D0068824E00658E5D0061996A005EA3
      77008B5E2A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007750
      0E0077500E0071652800668956005FA175005DA97F005BAE850059B58E0057BB
      96008F612F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007750
      0E0072612300658B59005BAE850056BE990055C19E008F612F008F61300054C6
      A40054C6A4008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E00745B
      1C006A7C46005EA4790056BE9A008F6130008F61300054C6A40054C6A40054C6
      A40054C6A4008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000795111006E6E
      3400658C5A005BAD850055C29F008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007E5517006881
      4C00619B6D0059B68F0054C6A40054C6A40054C6A40054C6A40054C6A40054C6
      A40054C6A4008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008459
      20005DA97F0056C19E0054C6A40054C6A40054C6A40054C6A40054C6A40054C6
      A4008F6130000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000875C
      250059B58E0054C6A40054C6A40054C6A40054C6A40054C6A40054C6A40054C6
      A4008F6130000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F612F008F61300054C6A40054C6A40054C6A40054C6A4008F6130008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008F6130008F6130008F6130008F613000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000077500E0077500E007A53
      110081571C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000865B2300895D270000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007E55190082581E00855A2200875B2400885C2600000000000000
      000000000000000000000000000000000000000000000000000000000000875B
      24000000000000000000000000000000000077500E0077500E00645231004858
      6800865B23008A5E290000000000000000000000000000000000000000000000
      0000B5A99100DAD3C800000000008F612F008F6130000000000095576B009557
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000083591F008B5E2A008F6130008F6130008F6130008F6130008E602E000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000077500E0077500E005C553D003A5A7A00215E
      A6000D62C8009163320091633200000000000000000000000000000000000000
      0000E7E5E100000000000000000000000000000000000000000095576B009557
      6B0000000000000000000000000000000000000000000000000000000000C371
      7800C3717800C3717800C3717800C371780000000000C3717800C37178000000
      0000000000000000000000000000000000000000000000000000000000008359
      1F008D602D0000000000000000000000000000000000000000008F6130008E60
      2E000000000000000000000000000000000000000000895D270000000000885C
      26000000000080561B007C5315007A531100485868002C5D92008C5F2C000000
      00000064DF000064DF0091633200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C371
      7800C0374400C0374400C0374400C3717800C3717800C0374400C37178000000
      00000000000000000000000000000000000000000000000000007E551900895D
      2700000000000000000000000000000000000000000000000000000000008E60
      2E008F6130000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000855A22002C5D92000D62C800000000000000
      00000064DF000064DF009163320000000000000000000000000093671C00A768
      1A00000000000000000000000000000000000000000000000000000000000000
      00003A5A7A002C5D920000000000000000000000000000000000000000000000
      0000C3717800C0374400C0374400C0374400C0374400C3717800000000000000
      000000000000000000000000000000000000000000000000000081571C008C5F
      2B00000000000000000000000000000000000000000000000000000000008F61
      30008F6130000000000000000000000000000000000000000000000000008D60
      2D000000000000000000000000008E612D00906331000064DF000064DF000064
      DF000064DF009163320091633200000000000000000000000000A7681A00A768
      1A00000000000000000000000000000000000000000000000000000000000000
      00003A5A7A002C5D920000000000000000000000000000000000000000000000
      000000000000C3717800C0374400C0374400C0374400C3717800000000000000
      000000000000000000000000000000000000000000000000000082581E008B5E
      2A00000000000000000000000000000000000000000000000000000000008F61
      30008F6130000000000000000000000000000000000000000000000000008E60
      2E000000000000000000000000000000000090633100946737000064DF000064
      DF00916332009163320000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C3717800C0374400C0374400C0374400C0374400C37178000000
      000000000000000000000000000000000000000000000000000082581E00865B
      2300000000000000000000000000865B23000000000000000000000000008F61
      30008F6130000000000000000000000000000000000000000000000000008E60
      2E00000000000000000000000000000000000000000094673700946737009163
      32009163320000000000000000000000000000000000000000008BA75F008BA7
      5F00000000000000000000000000000000000000000000000000000000000000
      0000232BA800232BA80000000000000000000000000000000000000000000000
      0000C3717800C0374400C3717800C3717800C0374400C0374400C0374400C371
      780000000000000000000000000000000000000000000000000080561B008056
      1B0081571C0000000000855A22008A5D29000000000000000000000000008F61
      3000000000000000000000000000000000000000000000000000000000008E60
      2E00000000000000000000000000000000000000000000000000000000000000
      00008F61300000000000000000000000000000000000000000008BA75F008BA7
      5F00000000000000000000000000000000000000000000000000000000000000
      0000232BA800232BA80000000000000000000000000000000000000000000000
      0000C3717800C37178000000000000000000C3717800C0374400C0374400C037
      4400C37178000000000000000000000000000000000000000000000000007E55
      190082581E00885C26008D602D008F6130000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C3717800C0374400C037
      4400C37178000000000000000000000000000000000000000000000000000000
      0000875B24008F6130008F6130008F6130000000000000000000000000000000
      000000000000000000000000000000000000000000008C5F2B00000000008F61
      3000000000008F6130008F6130008F6130008F6130008F6130008F6130000000
      00008F613000000000008F613000000000000000000000000000000000000000
      00004284CE004284CE00000000000000000000000000000000006BC1D9009EE0
      F600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C3717800C037
      4400C3717800000000000000000000000000000000000000000000000000855A
      21008E602E008F6130008F6130008F6130000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004284CE004284CE00000000008D602D008F613000000000009EE0F6009EE0
      F600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C371
      7800C37178000000000000000000000000000000000000000000895D27008D60
      2D008F6130008F6130008F6130008F6130000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      3000000000000000000000000000000000000000000000000000000000000000
      00008F6130000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008F6130008F61300000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000077500E0077500E0077500F0076511200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000077500E007A521200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000078510F007C53150080561B0000000000000000007C53150080561B00875B
      240000000000000000000000000000000000000000000000000077500E007750
      0E0077500E0077500E0077500F00765112007651120076511200745C1D00696E
      500061847C0053AACA0000000000000000000000000000000000000000000000
      000077500E0077500E0077500E0076511200816026008C6E3B007E5B1E008558
      2400000000000000000000000000000000000000000000000000000000000000
      00000000000077500E00845C1D007E5519000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007A521200A9803C00855A2200000000000000000080561B00C49B52008D60
      2D0000000000000000000000000000000000000000000000000077500E007456
      1B006B6A460061847C005B8B8F0059939E0059939E0059939E0051A0BC0049B1
      E30046B7EF0046B7EF0000000000000000000000000000000000000000007750
      0E0077500E0077500F007E5B1E008C6E3B009A7E53009E886000A7987700A798
      77008A5D29000000000000000000000000000000000000000000000000000000
      00000000000077500E0089611900A9803C008459200000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007C531500C49B52008A5E2900000000000000000083572100E9BF76008F61
      3000000000000000000000000000000000000000000000000000705F2E006974
      590059939E0049B1E30046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF0046B7EF0046B7EF0000000000000000000000000000000000000000007750
      0E0077500E007A6028009E886000A7987700B5A99100B5A99100B5A99100BFBE
      B3008F6130000000000000000000000000000000000000000000000000000000
      00000000000077500E008F662900B1864F00CCA76100875B2400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000081591900D2AF75008F6130000000000000000000895D2700FFD48B008F61
      3000000000000000000000000000000000000000000000000000696E50005B8B
      8F0049B1E30046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF0046B7EF0046B7EF000000000000000000000000000000000077500E007750
      0F007A6028009E886000B5A99100BFBEB300BFBEB300BFBEB300BFBEB300BFBE
      B300BFBEB3008F61300000000000000000000000000000000000000000000000
      00000000000077500E009B712700C49B5200E9BF7600FFD48B008C5F2C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080561B00E9BF76008F61300000000000000000008B5E2A00FFD48B008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000232BA8000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007E5B
      1E0092764500B5A99100BFBEB300BFBEB300BFBEB300BFBEB300BFBEB300BFBE
      B300BFBEB3008F61300000000000000000000000000000000000000000000000
      00000000000077500E009A703400CCA76100FFD48B00FFD48B00FFD48B008F61
      3000000000000000000000000000000000000000000000000000000000000000
      000080561B00E9BF76008F61300000000000000000008B5E2A00FFD48B008F61
      3000000000000000000000000000000000000000000000000000000000004942
      6400232BA8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000765112008C6E
      3B009E886000B5A99100BFBEB300BFBEB300BFBEB300BFBEB300BFBEB300BFBE
      B300BFBEB3008F61300000000000000000000000000000000000000000000000
      00000000000078510F00A9803C00E9BF7600FFD48B00FFD48B00FFD48B008F61
      3000000000000000000000000000000000000000000000000000000000000000
      000080561B00E9BF76008F61300000000000000000008B5E2A00FFD48B008F61
      3000000000000000000000000000000000000000000000000000604C41004942
      6400232BA800232BA800232BA800232BA800232BA800232BA800000000000000
      00000000000000000000000000000000000000000000000000007B5516009A7E
      5300A7987700B5A99100BFBEB300BFBEB300BFBEB300BFBEB300BFBEB300BFBE
      B300BFBEB3008F61300000000000000000000000000000000000000000000000
      00000000000079511100C49B5200FFD48B00FFD48B00FFD48B008F6130000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007E551900E9BF76008F61300000000000000000008B5E2A00FFD48B008F61
      300000000000000000000000000000000000000000000000000049426400333B
      9100232BA800232BA800232BA800232BA800232BA800232BA800000000000000
      0000000000000000000000000000000000000000000000000000000000008558
      2400B5A99100BFBEB300BFBEB300BFBEB300BFBEB300BFBEB300BFBEB300BFBE
      B3008F6130000000000000000000000000000000000000000000000000000000
      0000000000007E551900E9BF7600FFD48B00FFD48B008F613000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000082581E00FFD48B008E602E0000000000000000008E602E00FFD48B008F61
      300000000000000000000000000000000000000000000000000000000000232B
      A800232BA8000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000875C
      2500B5A99100BFBEB300BFBEB300BFBEB300BFBEB300BFBEB300BFBEB300BFBE
      B3008F6130000000000000000000000000000000000000000000000000000000
      00000000000084592000FFD48B00FFD48B008F61300000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000875B2400FFD48B008F61300000000000000000008F613000FFD48B008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000232BA8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F612F008F613000BFBEB300BFBEB300BFBEB300BFBEB3008F6130008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000000000008C5F2B00FFD48B008F6130000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C5F2C00FFD48B008F61300000000000000000008F613000FFD48B008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008F6130008F6130008F6130008F613000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F6130008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F6130008F6130008F61300000000000000000008F6130008F6130008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007750
      0E0077500E0077500E0077500F0078510F0077500F0077500E0074561B006B6A
      460061847C0051A0BC000000000000000000000000000000000077500F007651
      120077500F0077500E00765112007651120077500F0077500E0074561B006B6A
      460061847C0051A0BC000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C4008F6130008F613000FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F613000000000000000000000000000000000000000
      000077500E0077500E0077500E0077500E0077500E007C54130081591900875B
      240000000000000000000000000000000000000000000000000077500E007456
      1B006B6A460061847C005B8B8F0059939E005B8B8F005B8B8F005B8B8F0051A0
      BC0046B7EF0046B7EF0000000000000000000000000000000000745C1D006D65
      3B00697459005B8B8F0059939E0059939E005B8B8F005B8B8F005B8B8F0051A0
      BC0046B7EF0046B7EF000000000000000000000000008F613000FF56C400FF56
      C400FF56C4008F613000FFD48B008F613000FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F613000000000000000000000000000000000000000
      000077500E0077500E0077500E00745C1D00577C4E003891860014D9D4008F61
      3000000000000000000000000000000000000000000000000000705F2E006974
      590059939E0049B1E30046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF0046B7EF0046B7EF0000000000000000000000000000000000647867005993
      9E0049B1E30046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF0046B7EF0046B7EF000000000000000000000000008F613000FF56C400FF56
      C4008F613000FFD48B00FFD48B008F6130008F6130008F6130008F6130008F61
      30008F613000FF56C4008F613000000000000000000000000000000000000000
      000077500E0077500E00666932004A8F690024AEAD0014D9D40000F3FD008F61
      3000000000000000000000000000000000000000000000000000696E50005B8B
      8F0049B1E30046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF0046B7EF0046B7EF000000000000000000000000000000000053AACA0046B7
      EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF0046B7EF0046B7EF000000000000000000000000008F613000FF56C4008F61
      3000FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD4
      8B008F613000FF56C4008F613000000000000000000000000000000000000000
      000077500E00666932004A8F690024AEAD0000F3FD0000F3FD0000F3FD008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000232BA800000000000000000000000000000000000000000000000000232B
      A800000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000232B
      A80000000000000000000000000000000000000000008F613000FF56C4008F61
      3000FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD4
      8B008F613000FF56C4008F613000000000000000000000000000000000000000
      00007A5311004A8F690024AEAD0000F3FD0000F3FD0000F3FD0000F3FD008F61
      3000000000000000000000000000000000000000000000000000000000004942
      6400232BA800000000000000000000000000000000000000000000000000232B
      A800232BA8000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000232B
      A800232BA800000000000000000000000000000000008F613000FF56C400FF56
      C4008F613000FFD48B00FFD48B008F6130008F6130008F6130008F6130008F61
      30008F613000FF56C4008F613000000000000000000000000000000000000000
      00007E57160024AEAD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD008F61
      3000000000000000000000000000000000000000000000000000604C41004942
      6400232BA800232BA800232BA800232BA800232BA800232BA800232BA800232B
      A800232BA800232BA80000000000000000000000000000000000000000000000
      00000000000000000000333B9100333B9100333B9100333B9100232BA800232B
      A800232BA800232BA8000000000000000000000000008F613000FF56C400FF56
      C400FF56C4008F613000FFD48B008F613000FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F613000000000000000000000000000000000000000
      00008459200014D9D40000F3FD0000F3FD0000F3FD0000F3FD0000F3FD008F61
      300000000000000000000000000000000000000000000000000049426400333B
      9100232BA800232BA800232BA800232BA800232BA800232BA800232BA800232B
      A800232BA800232BA80000000000000000000000000000000000000000000000
      00000000000000000000333B9100232BA800232BA800232BA800232BA800232B
      A800232BA800232BA8000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C4008F6130008F613000FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F613000000000000000000000000000000000000000
      00008C5F2C008F6130008F6130008F6130008F6130008F6130008F6130008F61
      300000000000000000000000000000000000000000000000000000000000232B
      A800232BA800000000000000000000000000000000000000000000000000232B
      A800232BA8000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000232B
      A800232BA800000000000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000232BA800000000000000000000000000000000000000000000000000232B
      A800000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000232B
      A80000000000000000000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F61300000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F61300000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F613000000000000000000077500E0077500E007750
      0E007D5417008357210000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F613000000000000000000077500E0077500E006452
      31003F437B00885C260000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F613000000000000000000077500E0072501700554F
      4E002D41A3008A5E290000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF008F6130008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF008F6130008F6130000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C4008F6130008F613000FF56C400FF56
      C400FF56C400FF56C4008F613000000000000000000077500E007B5314008357
      21008C5F2C008C5F2B008C5F2B008B5E2A000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF008F61300000F3FD008F6130000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F6130000AD7FF000AD7
      FF000AD7FF008F61300000F3FD008F6130000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C4008F613000FFD48B008F613000FF56
      C400FF56C400FF56C4008F613000000000000000000077500E00554F4E00333B
      91000D36DB000133FD000133FD008B5E2A000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF008F61
      30008F6130008F6130008F6130008F6130008F61300000F3FD0000F3FD008F61
      30000AD7FF000AD7FF008F61300000000000000000008F6130000AD7FF000AD7
      FF008F61300000F3FD0000F3FD008F6130008F6130008F6130008F6130008F61
      30008F6130000AD7FF008F61300000000000000000008F613000FF56C4008F61
      30008F6130008F6130008F6130008F6130008F613000FFD48B00FFD48B008F61
      3000FF56C400FF56C4008F613000000000000000000077500E00554F4E00333B
      91000D36DB000133FD000D36DB008A5D29000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF008F61
      300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD008F6130000AD7FF008F61300000000000000000008F6130000AD7FF008F61
      300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD008F6130000AD7FF008F61300000000000000000008F613000FF56C4008F61
      3000FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD4
      8B008F613000FF56C4008F613000000000000000000077500E007D5417008459
      20008D602D008F6130008E612D008A5D29008357210080561B007E5519008055
      1C0084592000000000000000000000000000000000008F6130000AD7FF008F61
      300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD008F6130000AD7FF008F61300000000000000000008F6130000AD7FF008F61
      300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD008F6130000AD7FF008F61300000000000000000008F613000FF56C4008F61
      3000FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD4
      8B008F613000FF56C4008F613000000000000000000077500F00554F4E00333B
      91000D36DB000133FD000133FD000D36DB002D41A300333B91003F437B00333B
      9100885C2600000000000000000000000000000000008F6130000AD7FF008F61
      30008F6130008F6130008F6130008F6130008F61300000F3FD0000F3FD008F61
      30000AD7FF000AD7FF008F61300000000000000000008F6130000AD7FF000AD7
      FF008F61300000F3FD0000F3FD008F6130008F6130008F6130008F6130008F61
      30008F6130000AD7FF008F61300000000000000000008F613000FF56C4008F61
      30008F6130008F6130008F6130008F6130008F613000FFD48B00FFD48B008F61
      3000FF56C400FF56C4008F613000000000000000000079511100554F4E00333B
      91000D36DB000133FD000133FD000D36DB001D3EC800233CB600233CB600233C
      B6008A5C2B00000000000000000000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF008F61300000F3FD008F6130000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F6130000AD7FF000AD7
      FF000AD7FF008F61300000F3FD008F6130000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C4008F613000FFD48B008F613000FF56
      C400FF56C400FF56C4008F61300000000000000000007D54170082581E00875B
      24008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008E602E0000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF008F6130008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF008F6130008F6130000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C4008F6130008F613000FF56C400FF56
      C400FF56C400FF56C4008F6130000000000000000000855A2200233CB6000133
      FD000133FD000133FD000133FD000133FD000133FD000133FD000133FD000133
      FD000133FD000133FD008F61300000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F61300000000000000000008C5F2C000133FD000133
      FD000133FD000133FD000133FD000133FD000133FD000133FD000133FD000133
      FD000133FD000133FD008F61300000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008F61300000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008F61300000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F61300000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F61300000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F61300000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007C541500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000077500E0077500E0077500F007D541700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000077500E0077500E0077500F007B551600000000000000
      0000000000000000000000000000000000000000000077500E0077500E007750
      0E007D5417008459200000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000795211000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000077500E0077500E00815919009E743900B78B5600815D20000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000077500E0077500E0077500E0092692D00B1864F0082581E000000
      0000000000000000000000000000000000000000000077500E0077500E007261
      23006D854600875B240000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000077500E007A53110000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000077500E0077500E008C632500A4794100C69B6800D2AF7500E0B688008A5E
      2900000000000000000000000000000000000000000000000000000000000000
      000077500E0077500E0077500E0090633100B78B5600CB9D6C00E0B688008A5E
      2900000000000000000000000000000000000000000077500E0078510F007073
      3300689E60008A5E290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000077500E0077500E0077500E009276450087521B0081571C000000
      0000000000000000000000000000000000000000000000000000000000007750
      0E00875F20009E74390000000000CB9D6C00E9C19300F4C89900FED7AF00FED7
      AF008F6130000000000000000000000000000000000000000000000000007750
      0E0077500E0077500E0087521B003A5A7A00215EA60090633100F4C89900FED7
      AF008F6130000000000000000000000000000000000077500E007B5314008357
      21008A5E29008C5F2C008B5E2A008B5E2A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000077500E0077500E0077500E00976C3F00A7987700A7987700B5A99100875B
      2400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000175FB60000000000F4C89900FED7AF00FED7AF00FED7
      AF008F6130000000000000000000000000000000000000000000000000007750
      0E0077500E007D5417002C5D9200175FB6000A5ADC000A5ADC0091633200FED7
      AF008F6130000000000000000000000000000000000077500E00726E2D006B90
      510064B77A0061C4880061C488008A5D29000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007750
      0E0077500E0077500E009A7E5300B5A99100BFBEB300CEC4B300CEC4B300CEC4
      B3008C5F2C0000000000000000000000000000000000000000006B5224006452
      3100485868002C5D9200175FB6001260C00000000000F4C89900FED7AF00FED7
      AF008F6130000000000000000000000000000000000000000000000000007750
      0E00845C1D0048586800215EA6000A5ADC000A5ADC000A5ADC000A5ADC00FED7
      AF008F6130000000000000000000000000000000000077500E00726E2D006B90
      510064B77A0061C4880064B77A00895D27000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007750
      0E007C5413009E886000B5A99100DAD3C800E0DCD500E7E5E100ECECEC00ECEC
      EC00ECECEC008F61300000000000000000000000000000000000554F4E004858
      68003A5A7A00215EA600175FB600215EA60000000000E0B68800FED7AF00FED7
      AF008F6130000000000000000000000000000000000000000000000000007750
      0E008F6629003A5A7A00175FB6000A5ADC000A5ADC000A5ADC000A5ADC00FED7
      AF008F6130000000000000000000000000000000000077500E007D5417008459
      20008C5F2C008F6130008E602E00895D2700845920007E5519007E5519008056
      1B0084592000000000000000000000000000000000000000000078510F008F66
      29009E886000B5A99100E0DCD500E7E5E100ECECEC00ECECEC00ECECEC00ECEC
      EC00ECECEC008F61300000000000000000000000000000000000000000000000
      000000000000000000002C5D920000000000C2956200D2AF7500FED7AF00FED7
      AF008F6130000000000000000000000000000000000000000000000000007750
      0E0092692D0085582400175FB6000A5ADC000A5ADC000A5ADC0091633200FED7
      AF008F6130000000000000000000000000000000000077500E00726E2D006B90
      510064B77A0061C4880064B77A0064B77A00689E60006C8B4C006C8B4C006B90
      5100885C260000000000000000000000000000000000000000007E551900A798
      7700BFBEB300E0DCD500ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECEC
      EC00ECECEC008F61300000000000000000000000000000000000000000007D54
      17009E743900AC80490000000000C2956200D2AF7500F4C89900FED7AF00FED7
      AF008F6130000000000000000000000000000000000000000000000000007A52
      12009E743900C5986600916332000A5ADC000A5ADC0091633200FED7AF00FED7
      AF008F6130000000000000000000000000000000000077500E00726E2D006B90
      510064B77A0061C4880061C4880064B77A005FA17500689E6000689E6000689E
      60008C5F2C00000000000000000000000000000000000000000000000000885C
      2600DAD3C800ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECEC
      EC008F6130000000000000000000000000000000000000000000000000008157
      1C00BC905C00D2AF7500E0B68800E0B68800FED7AF00FED7AF00FED7AF00FED7
      AF008F6130000000000000000000000000000000000000000000000000007E55
      1900BC905C00E0B68800E0B68800E9C19300FED7AF00FED7AF00FED7AF00FED7
      AF008F61300000000000000000000000000000000000795211007E551900855A
      22008F612F008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008E602E00000000000000000000000000000000000000
      00008E602E00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC008F61
      300000000000000000000000000000000000000000000000000000000000865B
      2300CB9D6C00E0B68800E0B68800E0B68800FED7AF00FED7AF00FED7AF00FED7
      AF008F613000000000000000000000000000000000000000000000000000875B
      2400D2AF7500E0B68800E0B68800E0B68800FED7AF00FED7AF00FED7AF00FED7
      AF008F613000000000000000000000000000000000007D541700689E600061C4
      880061C4880061C4880061C4880061C4880061C4880061C4880061C4880061C4
      880061C4880061C488008F613000000000000000000000000000000000000000
      0000000000008F6130008F6130008F6130008F6130008F6130008F6130000000
      0000000000000000000000000000000000000000000000000000000000008E61
      2D00916332009163320091633200916332009163320091633200916332009163
      32008A5C2B000000000000000000000000000000000000000000000000008F61
      2F00916332009163320091633200916332009163320091633200916332009163
      32008A5C2B00000000000000000000000000000000008459200064B77A0061C4
      880061C4880061C4880061C4880061C4880061C4880061C4880061C4880061C4
      880061C4880061C488008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C5F2C008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007750
      0E0077500E007C5415000000000000000000000000000000000077500E007750
      0E007E551700885C260000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007750
      0E0077500F0077500E0077500F0077500E0077500E0077500E007A521200855A
      21008C5F2C00000000000000000000000000000000000000000077500E007750
      0E0078510F007E55190000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007750
      0E008159190080561B000000000000000000000000000000000077500E009367
      1C00BD8E38008E612D0000000000000000000000000000000000554F4E00554F
      4E0048586800000000000000000000000000000000000000000000000000554F
      4E003A5A7A001260C00000000000000000000000000000000000000000007E57
      16007A6028007E6632005C553D00554F4E00485868002C5D92009EE0F6009EE0
      F600CB9D6C00000000000000000000000000000000000000000077500E007750
      0E008159190080561B0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007A53
      11007C54150080551C00916332007A60280077500F0077500E007A521200855A
      2100DAAD4E008F612F0000000000000000000000000000000000000000000000
      0000554F4E00000000000000000000000000000000000000000000000000554F
      4E00000000000000000000000000000000000000000000000000000000008C6E
      3B009E88600092A69B0092A69B00175FB6000164DD009EE0F600000000009EE0
      F600CB9D6C00000000000000000000000000000000000000000077500E007A53
      11007C5415008159190082581E0081571C0082581E0000000000000000000000
      000000000000000000000000000000000000000000000000000077500E008961
      1900835721006FA192006FA19200748267007976510079744D006A9284008C5F
      2B00E6B652008F61300000000000000000000000000000000000000000000000
      00006B522400000000000000000000000000000000000000000000000000604C
      4100000000000000000000000000000000000000000000000000000000000000
      0000B1864F00B78B56009EE0F6009EE0F6009EE0F60000000000CB9D6C00CB9D
      6C0000000000000000000000000000000000000000000000000077500E00875F
      200080561B00215EA600215EA6002C5D9200855A21000000000083591F000000
      000000000000000000000000000000000000000000000000000077500E009367
      1C0081571C0066AAAF0066AAAF0066AAAF006FA192006FA192006BC1D900976C
      3F00E6B652008F612F000000000000000000000000000000000077500F007750
      0E006B522400696E50006B6A4600705F2E0077500F0077500E00705F2E003A5A
      7A0053AACA0046B7EF0000000000000000000000000000000000000000000000
      00000000000000000000C29562009EE0F6009EE0F600CB9D6C00000000000000
      000000000000000000000000000000000000000000000000000077500E008C63
      250083591F00175FB6000D62C800175FB600895D270000000000875C25008B5E
      2A0000000000000000000000000000000000000000000000000077500E009367
      1C00845920006BC1D9006BC1D9008C5F2C008C5F2C006BC1D90060D6F400AC80
      4900E6B652008F61300000000000000000000000000000000000745C1D006B6A
      46003A5A7A0051A0BC0051A0BC0051A0BC0059939E0059939E0051A0BC000A5A
      DC0046B7EF0046B7EF0000000000000000000000000000000000000000000000
      0000000000000000000000000000C5986600CB9D6C0000000000000000000000
      000000000000000000000000000000000000000000000000000077500E008C63
      2500845920000D62C8000064DF008F6130008F6130008F6130008F6130008F61
      30008F613000000000000000000000000000000000000000000077500E009367
      1C0082581E006BC1D90060D6F4008F6130009E562E0060D6F40060D6F400976C
      3F00E9BF760094673700000000000000000000000000000000006B6A46006184
      7C001260C00046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF000A5A
      DC0046B7EF0046B7EF0000000000000000000000000000000000000000000000
      0000000000000000000000000000A4794100CB9D6C0000000000000000000000
      000000000000000000000000000000000000000000000000000077500E008C63
      2500845920000663D4000064DF008F6130008F6130008F6130008F6130008F61
      30008F613000000000000000000000000000000000000000000077500E009367
      1C0082581E006BC1D90060D6F40060D6F40060D6F40060D6F40060D6F4009063
      3100E6B65200976C3F00000000000000000000000000000000005B8B8F0053AA
      CA000A5ADC0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF000A5A
      DC0046B7EF0046B7EF0000000000000000000000000000000000000000000000
      0000000000000000000077500E00554F4E002C5D9200BC905C00000000000000
      000000000000000000000000000000000000000000000000000077500E008C63
      2500845920000463D8000064DF000064DF008F613000000000008F6130008F61
      3000000000000000000000000000000000000000000000000000795211009B71
      2700875F20008C5F2B008C5F2B008C5F2B008C5F2B008C5F2B008C5F2B008C5F
      2B00E6B652009467370000000000000000000000000000000000000000000000
      00000A5ADC000000000000000000000000000000000000000000000000000A5A
      DC00000000000000000000000000000000000000000000000000000000000000
      000077500E0077500E006B52240048586800215EA6001260C000BC905C00BC90
      5C0000000000000000000000000000000000000000000000000079521100966C
      3000875C25008F6130008F6130008F6130008F613000000000008F6130000000
      00000000000000000000000000000000000000000000000000007E551900BD8E
      3800DAAD4E00E6B65200E6B65200E6B65200E6B65200E6B65200E6B65200E6B6
      5200E6B65200976C3F0000000000000000000000000000000000000000000000
      00000A5ADC000000000000000000000000000000000000000000000000000A5A
      DC00000000000000000000000000000000000000000000000000000000007750
      0E006B522400554F4E002C5D92000064DF000164DD000064DF000064DF000064
      DF00CB9D6C0000000000000000000000000000000000000000007E551900AC80
      4900C89B6800CB9D6C00CB9D6C00CB9D6C008F61300000000000000000000000
      000000000000000000000000000000000000000000000000000084592000DAAD
      4E00E6B65200E6B65200E6B65200E6B65200E6B65200E6B65200E6B65200E6B6
      5200E6B6520094673700000000000000000000000000000000001360DE000A5A
      DC000A5ADC000000000000000000000000000000000000000000000000000A5A
      DC000A5ADC000A5ADC000000000000000000000000000000000000000000966C
      300092A69B009EE0F6009EE0F6009EE0F6009EE0F6009EE0F600000000009EE0
      F600CB9D6C00000000000000000000000000000000000000000084592000C295
      6200CB9D6C00CB9D6C00CB9D6C00CB9D6C008F61300000000000000000000000
      00000000000000000000000000000000000000000000000000008C5F2C008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008A5D
      29008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F61300000000000000000000000000000000000000000008C5F2C008F61
      30008F6130008F6130008F6130008F6130008F61300000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007750
      0E0077500E0077500E0077500E0077500E0077500E0077500E00815919009269
      2D00A87D4400C295620000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000077500E0077500E007750
      0E007D5417008357210000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000077500E0077500E007750
      0E007E551700855A210000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007750
      0E0077500E00795211007A5212007B5314007C5415007D54170082581E00885C
      26008E602E00CB9D6C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000077500E0077500E007E4C
      24008F4354008558240000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000077500E0077500E008961
      19005FA17500885C260000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007C5413008159
      1900875F200092692D009A70340082581E00855A2100B1864F00C2956200CB9D
      6C00CB9D6C00CB9D6C0000000000000000000000000000000000000000007750
      0E0077500E0077500E0077500E0077500E0077500E0077500E0078510F00875F
      20009E7439000000000000000000000000000000000077500E0077500F008747
      3D0095576B008A5D290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000077500E00765112009B71
      270066AAAF008A5E290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009E743900B1864F008A5D29008C5F2C00C89B6800CB9D6C000000
      000000000000000000000000000000000000000000000000000077500E007750
      0E0077500E007A52120085642C007C5413006452310064523100554F4E003A5A
      7A00215EA600C598660000000000000000000000000077500E007A5212008357
      210092542300916332008E602E008A5C2B000000000000000000000000000000
      0000000000000000000000000000000000000000000077500E007A5212007E5B
      1E0088672F0092692D008F6629008A5E29000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007E57
      16008F662900A87D4400B78B56008D602D008F613000CB9D6C00CB9D6C00CB9D
      6C00CB9D6C00CB9D6C000000000000000000000000000000000077500E007750
      0E00845C1D009A7E5300A7987700A798770081571C003A5A7A002C5D9200175F
      B6000064DF00CB9D6C0000000000000000000000000077500E009B712700BD8E
      3800E6B65200E6B65200E6B652008E602E000000000000000000000000000000
      0000000000000000000000000000000000000000000077500E005C553D003A5A
      7A00DAAD4E0060D6F40060D6F4008F6629000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007951
      11007E551900855824008B5E2A008E602E008F6130008F6130008F6130008F61
      30008F613000CB9D6C000000000000000000000000000000000077500E00815D
      20009E886000B5A99100DAD3C800DAD3C800DAD3C8008B5E2A000463D8000064
      DF000064DF00CB9D6C0000000000000000000000000077500E0093671C00BD8E
      3800E6B65200E6B65200E6B652008A5D29000000000000000000000000000000
      0000000000000000000000000000000000000000000077500E005C553D003A5A
      7A00DAAD4E0060D6F40060D6F4008C6325000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007951
      110092692D002C5D92000D62C8000463D8000064DF000064DF000064DF000064
      DF008F613000CB9D6C000000000000000000000000000000000077500E007B55
      160083591F00DAD3C800ECECEC008F6130008F6130008F6130000064DF000064
      DF000064DF00CB9D6C0000000000000000000000000077500E007E571600885C
      26008E602E008F6130008D602D00895D27008459200081571C0082581E008852
      1C00855A21000000000000000000000000000000000077500E007B5516008159
      1900816026008F6130008C5F2C00885A2900845920007E5716007E5517008159
      1900855A2100000000000000000000000000000000000000000077500E007B53
      140048586800B78B56000463D8000064DF000064DF000064DF000064DF000064
      DF008F613000CB9D6C00000000000000000000000000000000007A5212005C55
      3D0084592000DAD3C800ECECEC008F6130000064DF000064DF000064DF000064
      DF000064DF00CB9D6C000000000000000000000000007A531100604C41003A5A
      7A003860BD003062D4003062D4003860BD00435D9D0048586800485868003A5A
      7A00885C26000000000000000000000000000000000077500F005C553D003A5A
      7A00175FB600016AC500E6B65200DAAD4E00BD8E38006FA192005DA97F006FA1
      9200885C2600000000000000000000000000000000000000000078510F007C54
      15003A5A7A001260C000CB9D6C000064DF000064DF000064DF000064DF000064
      DF008F613000CB9D6C0000000000000000000000000000000000845C1D004858
      6800885C2600ECECEC00ECECEC00ECECEC008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000077500E00604C41004858
      68003860BD003062D4003062D4003860BD00435D9D00435D9D00435D9D00435D
      9D008A5E290000000000000000000000000000000000795111005C553D003A5A
      7A00175FB600016AC500E6B65200DAAD4E00C49B520068C4B50068C4B50068C4
      B5008A5E290000000000000000000000000000000000000000007A5212007C54
      13003A5A7A001260C0000064DF000064DF000064DF000064DF000064DF000064
      DF008F613000CB9D6C000000000000000000000000000000000092692D002C5D
      92000663D4008F613000ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECEC
      EC00ECECEC008F6130000000000000000000000000007952110080561B00875B
      24008F612F008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008E602E0000000000000000007D54170080551C00865B
      23008F612F008F6130008F6130008F61300091633200916332008E612D009269
      2D008C6E3B009A70340088672F00000000000000000000000000845C1D008056
      1B00215EA6000164DD000064DF000064DF000064DF000064DF00000000000064
      DF008F613000CB9D6C0000000000000000000000000000000000A87D44001260
      C0000064DF000064DF008F613000ECECEC00ECECEC00ECECEC00ECECEC00ECEC
      EC00ECECEC008F6130000000000000000000000000007E5519002D95520000C0
      7B0000C07B0000C07B0000C07B0000C07B0000C07B0000C07B0000C07B0000C0
      7B0000C07B0000C07B008F6130000000000000000000815D20002C5D9200016A
      C500016AC500016AC500016AC500016AC500E6B65200E6B65200E9BF760060D6
      F40060D6F40060D6F40090633100000000000000000000000000966C3000865B
      23000663D4000064DF000064DF000064DF000064DF000064DF000064DF000064
      DF008F613000CB9D6C000000000000000000000000000000000000000000CB9D
      6C00CB9D6C00CB9D6C00CB9D6C008F6130008F6130008F6130008F6130008F61
      30008F6130008F613000000000000000000000000000845920000DB46F0000C0
      7B0000C07B0000C07B0000C07B0000C07B0000C07B0000C07B0000C07B0000C0
      7B0000C07B0000C07B008F61300000000000000000008C5F2C00016AC500016A
      C500016AC500016AC500016AC500016AC500E6B65200E6B65200E6B6520060D6
      F40060D6F40060D6F4008F613000000000000000000000000000B1864F008C5F
      2C008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F613000CB9D6C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C5F2C008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F61300000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F613000000000000000000000000000C99B6A00CB9D
      6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D
      6C00CB9D6C00CB9D6C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000077500E004C33090000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000885C
      2600000000000000000000000000000000000000000000000000000000000000
      00008B5E2A000000000000000000000000000000000000000000000000000000
      0000000000000000000077500E007C5413009E7439008B5E2A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000554F
      4E00333B91000D36DB0000000000000000000000000000000000554F4E004942
      6400232BA8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000077500E00845C1D00AC8049008F612F00000000000000
      0000000000000000000000000000000000000000000000000000000000007750
      0E0077500E0077500E0077500E0077500E0077500E0077500E0065440C004C33
      0900201604000000000000000000000000000000000000000000000000004942
      64000D62C8000000000000000000000000000000000000000000000000003A5A
      7A000D36DB0000000000000000000000000000000000895D2700000000008A5E
      2900000000008D602D008F612F008F6130008F612F008E602E008E602E000000
      00008F612F00000000008F613000000000000000000000000000000000000000
      0000000000000000000077500E008F662900B78B56008F613000000000000000
      0000000000000000000000000000000000000000000000000000000000007750
      0E0077500E0077500E007E571600845C1D00845C1D008F6629009E743900B78B
      5600000000000000000000000000000000000000000000000000000000003F43
      7B000064DF000000000000000000000000000000000000000000000000002C5D
      92000D36DB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000077500E009A703400BC905C008F613000000000000000
      0000000000000000000000000000000000000000000000000000000000007750
      0E0077500E00845C1D0080561B0081571C0082581E00865B2300BC905C00CB9D
      6C0000000000000000000000000000000000000000000000000000000000333B
      91000064DF00000000000000000000000000000000000000000000000000215E
      A6000D36DB000000000000000000000000000000000000000000000000008E60
      2E00000000000000000000000000000000000000000000000000000000000000
      00008F6130000000000000000000000000000000000000000000000000000000
      00000000000077500E0077500E0082581E008B5E2A008F6130008E602E000000
      0000000000000000000000000000000000000000000000000000000000007750
      0E00845C1D009A703400885C26001260C0001260C0008E602E00CB9D6C00CB9D
      6C00000000000000000000000000000000000000000000000000000000002D41
      A3000164DD00000000000000000000000000000000000000000000000000215E
      A6000D36DB000000000000000000000000000000000000000000000000008F61
      2F00000000000000000000000000000000000000000000000000000000000000
      00008F6130000000000000000000000000000000000000000000000000000000
      000077500E0077500E0088672F00B5A99100DAD3C800E7E5E1008E602E008D60
      2D0000000000000000000000000000000000000000000000000000000000714C
      0D0092692D00AC8049008E602E000064DF000064DF008F613000CB9D6C00CB9D
      6C0000000000000000000000000000000000000000000000000000000000232B
      A8000064DF00000000000000000000000000000000000000000000000000215E
      A6000D36DB000000000000000000000000000000000000000000000000008E60
      2E00000000000000000000000000000000000000000000000000000000000000
      00008F6130000000000000000000000000000000000000000000000000007750
      0E0077500E0078510F009E886000CEC4B300E0DCD500ECECEC00ECECEC008F61
      30008F6130000000000000000000000000000000000000000000000000006544
      0C009E743900BC905C008F6130008F6130008F6130008F613000CB9D6C00CB9D
      6C0000000000000000000000000000000000000000000000000000000000333B
      91000064DF00000000000000000000000000000000000000000000000000215E
      A6000D36DB000000000000000000000000000000000000000000000000008E60
      2E00000000000000000000000000000000000000000000000000000000000000
      00008F6130000000000000000000000000000000000000000000000000007750
      0E0077500E0092764500B5A99100DAD3C800E7E5E100ECECEC00ECECEC00ECEC
      EC008F6130000000000000000000000000000000000000000000000000004C33
      0900AC804900CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D
      6C0000000000000000000000000000000000000000000000000000000000232B
      A8000064DF00000000000000000000000000000000000000000000000000215E
      A6000D36DB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007750
      0E008C6E3B00A7987700DAD3C800E7E5E100ECECEC00ECECEC00ECECEC00ECEC
      EC008F6130000000000000000000000000000000000000000000000000004C33
      0900181003000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000233C
      B6000064DF000000000000000000000000000000000000000000000000000D62
      C8000D36DB00000000000000000000000000000000008C5F2B00000000008F61
      3000000000008F6130008F6130008F6130008F6130008F6130008F6130000000
      00008F613000000000008F613000000000000000000000000000000000007D54
      1700A7987700CEC4B300E7E5E100ECECEC00ECECEC00ECECEC00ECECEC00ECEC
      EC008F6130000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000D36
      DB000064DF000000000000000000000000000000000000000000000000000064
      DF000D36DB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008258
      1E00875B2400E0DCD500ECECEC00ECECEC00ECECEC00ECECEC00ECECEC008F61
      30008F6130000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000D36
      DB000D36DB000D36DB00000000000000000000000000000000000D36DB000D36
      DB000D36DB000000000000000000000000000000000000000000000000008F61
      3000000000000000000000000000000000000000000000000000000000000000
      00008F6130000000000000000000000000000000000000000000000000000000
      00008B5E2A00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F6130008F6130008F6130008F6130008F6130008F6130000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005C553D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000077500E0077500E007A53
      110081571C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000554F4E002C5D920000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007E5519009A7034000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007E5519009A7034000000
      00000000000000000000000000000000000077500E0077500E00645231004858
      6800855A2100895D270000000000000000000000000082581E009E7439000000
      00000000000000000000000000000000000077500E0077500E0072501700554F
      4E002C5D92000064DF000064DF00000000000000000000000000000000007E55
      170080561B000000000000000000000000000000000000000000000000008459
      20008C5F2C0000000000000000000000000000000000BC905C0084592000AC80
      4900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BC905C0084592000A87D
      440000000000000000000000000077500E0077500F005C553D003A5A7A00215E
      A6001260C0008F613000916332000000000000000000D2AF7500895D2700AC80
      4900000000000000000000000000000000006B5224005C553D003A5A7A001260
      C0000064DF000064DF000064DF00000000000000000000000000000000008157
      1C0082581E0082581E000000000000000000000000000000000083591F008D60
      2D008F6130000000000000000000000000000000000000000000E0B688008A5E
      2900B1864F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0B68800865B
      2300A479410000000000000000007B5516005C553D003A5A7A00000000000000
      00000064DF000064DF0091633200000000000000000000000000E9C193008A5E
      2900AC8049000000000000000000000000000000000000000000000000000000
      00000064DF000064DF0000000000000000000000000000000000000000000000
      00008459200082581E007E551900000000000000000082581E008D602D008F61
      300000000000000000000000000000000000000000000000000000000000E0B6
      88008A5E290000000000855A2200855A21008459200084592000865B23000000
      000000000000000000000000000000000000000000000000000000000000E0B6
      8800875B24000000000081571C00835721002C5D92001260C000916332000000
      00000064DF000064DF009163320000000000000000000000000000000000E0B6
      88008A5E290000000000865B2300875B2400895D27008D602D00916332000000
      00000064DF000000000000000000000000000000000000000000000000000000
      00000000000080561B007E55190080561B0083591F008C5F2C008F6130000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008D602D00C99B6A00C99B6A00C99B6A00C5986600BC905C008E60
      2E00000000000000000000000000000000000000000000000000000000000000
      000000000000895D2700BC905C0094673700946737000064DF000064DF000064
      DF000064DF009163320091633200000000000000000000000000000000000000
      0000000000008D602D00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A009163
      3200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000081571C00875C25008E602E008F613000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000875B2400C99B6A00C99B6A00000000000000000000000000C99B6A00C99B
      6A00916332000000000000000000000000000000000000000000000000000000
      0000865B2300C2956200C99B6A000000000094673700946737000064DF000064
      DF00916332009163320000000000000000000000000000000000000000000000
      0000875B2400C99B6A00C99B6A00000000000000000000000000C99B6A00C99B
      6A00916332000000000000000000000000000000000000000000000000000000
      00000000000000000000855A22008F6130008F6130008F613000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000865B2300C99B6A000000000000000000000000000000000000000000C99B
      6A00916332000000000000000000000000000000000000000000000000000000
      0000865B2300C99B6A0000000000000000000000000094673700946737009163
      3200916332000000000000000000000000000000000000000000000000000000
      0000865B2300C99B6A000000000000000000000000000000000000000000C99B
      6A00916332000000000000000000000000000000000000000000000000000000
      000000000000845920008F612F008F6130008F6130008F6130008F6130000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000865B2300C99B6A000000000000000000000000000000000000000000C99B
      6A00916332000000000000000000000000000000000000000000000000000000
      0000855A2200C99B6A000000000000000000000000000000000000000000C99B
      6A00916332000000000000000000000000000000000000000000000000000000
      0000865B2300C99B6A000000000000000000000000000000000000000000C99B
      6A00916332000000000000000000000000000000000000000000000000000000
      0000845920008F6130008F61300000000000000000008F6130008F6130008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000865B2300C59866000000000000000000000000000000000000000000C99B
      6A00916332000000000000000000000000000000000000000000000000000000
      0000865B2300C59866000000000000000000000000000000000000000000C99B
      6A00916332000000000000000000000000000000000000000000000000000000
      0000865B2300C59866000000000000000000000000000000000000000000C99B
      6A0091633200000000000000000000000000000000000000000000000000855A
      22008F6130008F613000000000000000000000000000000000008F6130008F61
      30008F6130000000000000000000000000000000000000000000000000000000
      0000895D2700C2956200C89B6800000000000000000000000000BC905C00C99B
      6A00916332000000000000000000000000000000000000000000000000000000
      0000895D2700C2956200C99B6A00000000000000000000000000C99B6A00C99B
      6A00916332000000000000000000000000000000000000000000000000000000
      0000895D2700C2956200C89B6800000000000000000000000000BC905C00C99B
      6A00916332000000000000000000000000000000000000000000000000008F61
      2F008F6130000000000000000000000000000000000000000000000000008F61
      30008F6130000000000000000000000000000000000000000000000000000000
      00000000000090633100C99B6A00C99B6A00C99B6A00C99B6A00C99B6A009163
      3200000000000000000000000000000000000000000000000000000000000000
      00000000000090633100C99B6A00C99B6A00C99B6A00C99B6A00C99B6A009163
      3200000000000000000000000000000000000000000000000000000000000000
      00000000000090633100C99B6A00C99B6A00C99B6A00C99B6A00C99B6A009163
      3200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000091633200916332009163320091633200916332000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000091633200916332009163320091633200916332000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000091633200916332009163320091633200916332000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080561B00855A
      22008B5E2A008F6130000000000000000000000000000000000080561B008258
      1E00865B23008D602D000000000000000000000000000000000077500E007750
      0E0078510F007D5417000000000000000000000000000000000077500E007750
      0E007E551900875B2400000000000000000000000000966C30008F6629000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009E743900B1864F0000000000000000000000000077500E007750
      0E0077500E0077500E0077500E0077500E0077500E0077500E0078510F007C54
      150082581E000000000000000000000000000000000000000000875B24008E60
      2E00000000000000000000000000000000000000000000000000000000000000
      00008F6130008F6130000000000000000000000000000000000077500E007750
      0E00815919007E5519000000000000000000000000000000000077500E00875F
      2000AC8049008E602E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007750
      0E007952110081591900845C1D00845C1D00845C1D00875F200092692D00A479
      4100BC905C008F612F00000000000000000000000000000000008C5F2C000000
      00008F6130000000000000000000000000000000000000000000000000008F61
      3000000000008F6130000000000000000000000000000000000077500E007A53
      11007C54150080561B0092692D006B52240077500E0077500E0078510F008459
      2000C59866008F6130000000000000000000000000008F662900875F20008F66
      290092692D00966C300092692D0092692D0092692D008F6629008F6629009A70
      3400AC804900C2956200CB9D6C000000000000000000000000007B5314008C63
      25007D541700A87D4400B1864F00B1864F00B1864F00B78B5600D2AF7500F4C8
      9900F4C899008F613000000000000000000000000000000000008F6130000000
      0000000000008F613000000000000000000000000000000000008F6130000000
      0000000000008F6130000000000000000000000000000000000077500E00875F
      200081571C002C5D92003A5A7A0048586800554F4E00554F4E003A5A7A008E60
      2E00CB9D6C008F61300000000000000000000000000000000000A4794100895D
      27008D602D008F6130008F6130008F6130008F6130008F612F008F612F008F61
      30008F613000CB9D6C00000000000000000000000000000000007E5519007E55
      190080561B00C5986600D2AF7500D2AF7500E0B68800E9C19300F4C89900F4C8
      9900F4C899008F61300000000000000000000000000000000000000000000000
      000000000000000000008A5D290000000000000000008F612F00000000000000
      000000000000000000000000000000000000000000000000000077500E008C63
      250083591F00215EA600215EA6002C5D92002C5D92002C5D92001260C0008F61
      3000CB9D6C008F613000000000000000000000000000B1864F00BC905C008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F613000CB9D6C00CB9D6C00000000000000000000000000000000000000
      000080561B00C89B6800E0B68800E9C19300F4C89900F4C89900F4C89900CB9D
      6C008F6130000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008A5D29008F612F0000000000000000000000
      000000000000000000000000000000000000000000000000000077500E008C63
      250084592000175FB6000663D4008C5F2B008C5F2C000D62C8000064DF008F61
      3000CB9D6C008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007C531500B78B5600D2AF7500E9C19300F4C89900F4C89900CB9D6C00CB9D
      6C008F6130000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008F6130008F61300000000000000000000000
      000000000000000000000000000000000000000000000000000077500E008C63
      2500845920001260C0000064DF008F6130008F6130000064DF000064DF008F61
      3000CB9D6C008F613000000000000000000000000000AC804900B1864F000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CB9D6C00CB9D6C00000000000000000000000000000000007750
      0E007A521200B1864F00D2AF7500C5986600CB9D6C00CB9D6C00CB9D6C00CB9D
      6C008F6130000000000000000000000000000000000000000000000000000000
      000000000000000000008F61300000000000000000008F613000000000000000
      000000000000000000000000000000000000000000000000000077500E008C63
      2500845920001260C0000064DF000064DF000064DF000064DF000064DF008F61
      3000CB9D6C008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007750
      0E008C632500A4794100BC905C00C89B6800CB9D6C00CB9D6C00CB9D6C008F61
      30000000000000000000000000000000000000000000000000007E5519000000
      0000000000008F612F00000000000000000000000000000000008A5D29000000
      000000000000895D27000000000000000000000000000000000079521100966C
      3000875C25008F6130008F6130008F6130008F6130008F6130008F6130008F61
      3000CB9D6C008F6130000000000000000000000000009E743900966C30004858
      68003A5A7A003A5A7A003A5A7A003A5A7A003A5A7A00485868003A5A7A002C5D
      92001260C000CB9D6C00CB9D6C0000000000000000000000000077500E00845C
      1D0081571C008A5E29008F6130008F6130008F6130008F6130008F6130008F61
      30008F613000000000000000000000000000000000000000000082581E000000
      00008E602E00000000000000000000000000000000000000000000000000885C
      2600000000008F613000000000000000000000000000000000007E551900AC80
      4900C89B6800CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D
      6C00CB9D6C008F61300000000000000000000000000000000000AC804900175F
      B6000663D4000064DF000064DF000064DF000064DF000064DF000064DF000064
      DF000064DF00CB9D6C00000000000000000000000000000000007D541700B78B
      56008B5E2A00F4C89900F4C89900F4C89900F4C89900F4C89900F4C89900F4C8
      9900F4C899008F61300000000000000000000000000000000000875B24008F61
      3000000000000000000000000000000000000000000000000000000000000000
      00008F6130008F6130000000000000000000000000000000000084592000C295
      6200CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D
      6C00CB9D6C008F613000000000000000000000000000C2956200C99B6A00CB9D
      6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D
      6C00CB9D6C00CB9D6C00CB9D6C00000000000000000000000000855A2200E0B6
      8800F4C89900F4C89900F4C89900F4C89900F4C89900F4C89900F4C89900F4C8
      9900F4C899008F613000000000000000000000000000000000008F612F008F61
      30008F6130008F613000000000000000000000000000000000008B5E2A008F61
      30008F6130008F613000000000000000000000000000000000008C5F2C008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008D602D008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002D41A300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001D3EC800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000077500E0077500E0077500E0078510F00815919008F6629000000
      00000000000000000000000000000000000000000000000000002D41A3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001D3EC80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007E5517008056
      1B000000000000000000000000000000000000000000000000007C5415008459
      2000000000000000000000000000000000000000000000000000000000000000
      000077500E00795211007D5417007E55190080561B0081571C0082581E00A87D
      4400000000000000000000000000000000000000000000000000000000003F43
      7B00000000000000000000000000000000000000000000000000000000000000
      0000333B91000000000000000000000000000000000000000000855A2100895D
      27008C5F2C008F6130008F6130008F6130008F6130008D602D008B5E2A008B5E
      2A008A5E29008E602E000000000000000000000000000000000081571C00A479
      4100865B2300000000000000000000000000000000007D541700A4794100C598
      66008F6130000000000000000000000000000000000000000000000000007750
      0E007C531500855A21008A5D29008B5E2A008A5E29008A5D29008A5E29008B5E
      2A00BC905C000000000000000000000000000000000000000000000000000000
      0000604C4100000000000000000000000000000000000000000000000000554F
      4E000000000000000000000000000000000000000000000000008A5D29000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F6130000000000000000000000000000000000000000000885C
      2600BC905C008A5E2900000000000000000000000000865B2300CB9D6C00CB9D
      6C008F613000000000000000000000000000000000000000000077500E007A52
      1200855A210000000000000000008F6130008F6130008F6130008F6130008F61
      30008F613000C99B6A0000000000000000000000000000000000000000000000
      000000000000725017000000000000000000000000000000000077500E000000
      00000000000000000000000000000000000000000000000000008D602D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F61300000000000000000000000000000000000000000000000
      00008D602D00C59866008B5E2A000000000000000000000000008F6130008F61
      300000000000000000000000000000000000000000000000000077500E007D54
      1700895D27000000000000000000000000008F6130008F6130008F6130008F61
      30008F613000C99B6A000000000000000000000000000000000077500E007750
      0E0077500E00705F2E0064523100745B1C0074561B00765112006D653B006184
      7C0051A0BC0046B7EF00000000000000000000000000000000008E602E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F61300000000000000000000000000000000000000000000000
      0000000000008D602D00C59866008C5F2C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000795111008056
      1B008A5D29008F6130000000000000000000000000008F613000000000008F61
      30008F613000C99B6A000000000000000000000000000000000074561B006D65
      3B006478670059939E0051A0BC002D41A300333B910059939E0051A0BC0046B7
      EF0046B7EF0046B7EF0000000000000000000000000000000000895D27000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008E602E0000000000000000000000000000000000000000000000
      000000000000000000008C5F2B00C59866008F61300000000000000000000000
      0000000000000000000000000000000000000000000000000000815919008157
      1C008A5D29008F6130008F613000000000000000000000000000000000008F61
      30008F613000C99B6A0000000000000000000000000000000000696E50005B8B
      8F0053AACA0046B7EF0046B7EF001D3EC8000D36DB0046B7EF0046B7EF0046B7
      EF0046B7EF0046B7EF000000000000000000000000000000000082581E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008B5E2A0000000000000000000000000000000000000000000000
      00000000000000000000000000008E602E00CB9D6C008F613000000000000000
      00000000000000000000000000000000000000000000000000008C6325008359
      1F008A5E29008F6130008F6130008E602E000000000000000000000000008F61
      2F008F613000C99B6A000000000000000000000000000000000059939E0049B1
      E30046B7EF0046B7EF000D36DB0046B7EF0046B7EF000D36DB0046B7EF0046B7
      EF0046B7EF0046B7EF00000000000000000000000000000000007D5417000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008E602E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008F613000CB9D6C008F6130000000
      00000000000000000000000000000000000000000000000000009A703400865B
      23008C5F2C008F6130008F613000000000000000000000000000000000008F61
      30008F613000C99B6A0000000000000000000000000000000000000000000000
      0000000000000D36DB00000000000000000000000000000000000D36DB000000
      00000000000000000000000000000000000000000000000000007E5519008157
      1C0081571C0081571C0080561B007E5519007E5519007E55190080561B00865B
      23008D602D008F61300000000000000000000000000000000000000000000000
      00007D541700855A22000000000000000000000000008F613000CB9D6C008F61
      300000000000000000000000000000000000000000000000000000000000B78B
      56008E602E008F6130008F6130008F6130008E602E008E602E008F6130008F61
      3000C99B6A000000000000000000000000000000000000000000000000000000
      00000D36DB000000000000000000000000000000000000000000000000000D36
      DB0000000000000000000000000000000000000000000000000084592000895D
      27008D602D008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000000000007D54
      1700A4794100CA9C6B008F6130000000000000000000000000008F613000CB9D
      6C008F6130000000000000000000000000000000000000000000000000000000
      0000C99B6A008F6130008F6130008F6130008F6130008F6130008F613000C99B
      6A00000000000000000000000000000000000000000000000000000000000D36
      DB00000000000000000000000000000000000000000000000000000000000000
      00000D36DB0000000000000000000000000000000000000000008C5F2B008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130000000000000000000000000000000000000000000865B
      2300CB9D6C00CB9D6C008F613000000000000000000000000000000000008F61
      3000CB9D6C008F61300000000000000000000000000000000000000000000000
      000000000000C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A000000
      00000000000000000000000000000000000000000000000000000D36DB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000D36DB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F6130008F61300000000000000000000000000000000000000000000000
      00008F6130008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000D36DB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000D36DB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000077500E007851
      0F007A5212007C5315007D5417007D5417007D5417007C5415007D5417008056
      1B00845920008A5D29000000000000000000000000000000000077500E007750
      0E0077500E007B53140080561B0083591F008459200082581E0081571C008258
      1E00855A22008A5E29000000000000000000000000000000000077500E007750
      0E0077500E0078510F0079511100795211007A521200795211007B5314007D54
      1700845920008A5E290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000795111008F66
      29009E743900A87D4400AC804900AC804900B1864F00AC804900B1864F00B78B
      5600C29562008F6130000000000000000000000000000000000077500E007851
      0F007E551900AC804900C2956200C99B6A00C99B6A00C5986600BC905C00B78B
      5600C29562008F6130000000000000000000000000000000000077500E008258
      1E008F6629009A703400A4794100A87D4400A87D4400A4794100AC804900B78B
      5600C29562008F61300000000000000000000000000000000000000000000000
      00000000000077500E0077500E0077500E007E571600875F200092692D000000
      00000000000000000000000000000000000000000000000000007B5314009E74
      3900000000000000000000000000000000000000000000000000000000000000
      0000C99B6A008F6130000000000000000000000000000000000078510F008056
      1B00215EA6008F61300000000000000000000000000000000000000000000000
      0000C99B6A008F61300000000000000000000000000000000000795211009A70
      340000000000BC905C008F6130008F6130008F6130008E602E00C99B6A000000
      0000C99B6A008F61300000000000000000000000000000000000000000000000
      000077500E0077500E007C54150081571C0082581E0082581E0083591F00A479
      41000000000000000000000000000000000000000000000000007D541700A87D
      440000000000CCA76100CCA76100D2AF7500D7C17B00D7C17B00D7C17B000000
      0000C99B6A008F613000000000000000000000000000000000007E551700B78B
      56008F6130000064DF008F613000000000000000000000000000000000000000
      0000C99B6A008F613000000000000000000000000000000000007C541500AC80
      490000000000C99B6A008F61300000000000000000008F613000C99B6A000000
      0000C99B6A008F61300000000000000000000000000000000000000000007750
      0E0077500E0080561B008A5D29008E602E008C5F2C00895D2700875C2500885C
      2600B78B560000000000000000000000000000000000000000007E551900AC80
      490000000000D2AF7500AA573700D7C17B000000000000000000D7C17B000000
      0000C99B6A008F6130000000000000000000000000000000000082581E00C99B
      6A00000000008F6130000064DF008F6130000000000000000000000000000000
      0000C99B6A008F613000000000000000000000000000000000007E551700B186
      4F0000000000C99B6A008F61300000000000000000008F613000C99B6A000000
      0000C99B6A008F6130000000000000000000000000000000000077500E007750
      0E007D5417008B5E2A008F61300000000000000000008B5E2A008A5E29008C5F
      2C008F612F00C99B6A00000000000000000000000000000000007E551900AC80
      490000000000D2AF7500D7C17B00D7C17B00D7C17B00D7C17B00D7C17B000000
      0000C99B6A008F6130000000000000000000000000000000000084592000C99B
      6A0000000000000000008F6130000064DF008F6130000D62C800215EA600895D
      2700C99B6A008F613000000000000000000000000000000000007D541700AC80
      490000000000C99B6A008F61300000000000000000008B5E2A00C59866000000
      0000C99B6A008F6130000000000000000000000000000000000077500E007851
      0F00855A22008F6130008F6130000000000000000000885C2600895D27008F61
      2F008F613000C99B6A00000000000000000000000000000000007D541700A479
      410000000000D2AF7500AA573700D7C17B000000000000000000D7C17B000000
      0000C99B6A008F6130000000000000000000000000000000000083591F00C598
      66000000000000000000000000008F6130000064DF000000000000000000175F
      B6008F6130008F613000000000000000000000000000000000007B531400A479
      410000000000C29562008F6130000000000000000000865B2300B78B56000000
      0000C99B6A008F6130000000000000000000000000000000000077500E007D54
      17008A5D29008F6130008F613000000000000000000084592000875C25008F61
      30008F613000C99B6A00000000000000000000000000000000007C531500A479
      410000000000D2AF7500D7C17B00D7C17B00D7C17B00D2AF7500D2AF75000000
      0000C99B6A008F6130000000000000000000000000000000000080561B00B186
      4F000000000000000000000000000D62C8000000000000000000000000000000
      00000164DD008F613000000000000000000000000000000000007A5212009A70
      340000000000B1864F008A5D2900000000000000000081571C00AC8049000000
      0000C99B6A008F613000000000000000000000000000000000007E5716008056
      1B008B5E2A008F6130008F613000000000000000000081571C00875C25008F61
      30008F613000C99B6A00000000000000000000000000000000007A521200966C
      3000000000000000000000000000000000000000000000000000000000000000
      0000C99B6A008F613000000000000000000000000000000000007B531400966C
      30000000000000000000000000003A5A7A000000000000000000000000000000
      00000D62C8008F6130000000000000000000000000000000000078510F008F66
      290000000000AC804900885C2600865B230082581E0081571C00A87D44000000
      0000C99B6A008F613000000000000000000000000000000000008C6325008359
      1F008C5F2C008F6130008F6130008B5E2A0084592000845920008C5F2C008F61
      30008F613000C99B6A000000000000000000000000000000000078510F007D54
      170080561B0083591F00855A210083591F0082581E0081571C0082581E00885C
      26008F6130008F6130000000000000000000000000000000000078510F007B53
      14007C5415007E5519007E55190080561B004858680000000000000000003A5A
      7A008C5F2B008F6130000000000000000000000000000000000077500E007C54
      150081571C00855A2200885C2600000000000000000082581E00865B23008D60
      2D008F6130008F613000000000000000000000000000000000009A703400865B
      23008D602D008F6130008F61300000000000000000008C5F2C008F6130008F61
      30008F613000C99B6A0000000000000000000000000000000000795111009269
      2D00A4794100B1864F00B78B5600B78B5600B1864F00B1864F00B78B5600C99B
      6A00C99B6A008F61300000000000000000000000000000000000795111008F66
      29009A703400A4794100AC804900A87D4400845920004858680048586800875C
      2500C99B6A008F61300000000000000000000000000000000000795111009269
      2D00A87D4400B78B56008C5F2C008A5E2900885C2600885C2600C2956200C99B
      6A00C99B6A008F6130000000000000000000000000000000000000000000B78B
      56008E602E008F6130008F6130008F6130008F6130008F6130008F6130008F61
      3000C99B6A0000000000000000000000000000000000000000007E551700A479
      4100BC905C00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B
      6A00C99B6A008F613000000000000000000000000000000000007E551700A479
      4100B78B5600C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B
      6A00C99B6A008F613000000000000000000000000000000000007D541700A87D
      4400C2956200C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B
      6A00C99B6A008F61300000000000000000000000000000000000000000000000
      0000C99B6A008F6130008F6130008F6130008F6130008F6130008F613000C99B
      6A00000000000000000000000000000000000000000000000000845920008C5F
      2C008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000845920008C5F
      2C008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000845920008C5F
      2C008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000000000000000
      000000000000C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A000000
      00000000000000000000000000000000000000000000000000008C5F2C008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F613000000000000000000000000000000000008C5F2C008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F613000000000000000000000000000000000008C5F2C008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000049426400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001D3EC8000000000000000000333B9100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000233CB60000000000000000000000000077500F007A52
      12007D54170080561B0081571C0080561B0080561B007D5417007E5519008056
      1B00845920008A5E290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000049426400A479
      4100000000000000000000000000000000000000000000000000000000000000
      0000000000001D3EC80000000000000000000000000000000000494264000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000233CB600000000000000000000000000000000007B5314009E74
      3900B78B5600C5986600C99B6A00C2956200BC905C00B78B5600B78B5600B78B
      5600C29562008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C69B6800333B
      9100B1864F000000000000000000000000000000000000000000000000000000
      00002D41A300000000000000000000000000000000000000000000000000554F
      4E00333B9100233CB600000000000000000000000000000000006B522400554F
      4E002D41A30000000000000000000000000000000000000000007E551900B78B
      5600000000000000000000000000000000000000000000000000000000000000
      0000C99B6A008F61300000000000000000000000000000000000000000000000
      000077500E0077500E0077500E0077500E0078510F00795111007C5315008258
      1E0000000000000000000000000000000000000000000000000000000000E0B6
      88002D41A300AC80490000000000000000000000000000000000000000003F43
      7B00000000000000000000000000000000000000000000000000000000004942
      64002D41A3000000000000000000000000000000000000000000000000003F43
      7B000D36DB00000000000000000000000000000000000000000083591F00C99B
      6A00000000000064DF00000000000064DF000064DF000064DF000064DF000000
      0000C99B6A008F61300000000000000000000000000000000000000000000000
      000077500E0077500E0077500E006B5224005C553D004A79620038918600885C
      2600000000000000000000000000000000000000000000000000000000000000
      0000D2AF75003F437B00000000007E5517007E55170080561B0049426400895D
      2700000000000000000000000000000000000000000000000000000000004942
      6400175FB6000D36DB0000000000000000000000000000000000554F4E00215E
      A6000D36DB000000000000000000000000000000000000000000855A2100C99B
      6A00000000000000000000000000000000000000000000000000000000000000
      0000C99B6A008F61300000000000000000000000000000000000000000000000
      000077500E00725017005C6940004A7962003891860024AEAD0024AEAD008A5C
      2B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000003F437B00AC804900BC905C001D3EC800C5986600C99B
      6A00916332000000000000000000000000000000000000000000000000003F43
      7B000663D400000000000D36DB00000000000000000049426400000000000463
      D8000D36DB00000000000000000000000000000000000000000084592000C99B
      6A00000000000064DF00000000000D62C8001260C000175FB6001260C0000000
      0000C99B6A008F613000000000000000000000000000554F4E006B5224007651
      1200795111004A7962003891860024AEAD0001BBE80001BBE80001BBE8008F61
      30000049EB000049EB000049EB00000000000000000000000000000000000000
      00000000000080561B00AC8049000D36DB001D3EC8000000000000000000C99B
      6A00C99B6A009163320000000000000000000000000000000000000000003F43
      7B000663D40000000000000000000D36DB002D41A30000000000000000000064
      DF000D36DB00000000000000000000000000000000000000000081571C00BC90
      5C00000000000000000000000000000000000000000000000000000000000000
      0000C59866008F6130000000000000000000000000002D41A3003F437B004858
      680080551C0024AEAD0001BBE80001BBE80001BBE80001BBE80001BBE8008F61
      30000049EB000049EB000049EB00000000000000000000000000000000000000
      00000000000080561B00BC905C000D36DB000D36DB0000000000000000000000
      0000C99B6A009163320000000000000000000000000000000000000000003F43
      7B000164DD0000000000000000000D36DB001D3EC80000000000000000000064
      DF000D36DB0000000000000000000000000000000000000000007E551900AC80
      490000000000215EA600000000004858680048586800485868003A5A7A000000
      0000C29562008F61300000000000000000000000000000000000000000000000
      0000885C260001BBE80001BBE80001BBE80001BBE80001BBE80001BBE8008F61
      3000000000000000000000000000000000000000000000000000000000000000
      00000000000082581E001D3EC80000000000000000000D36DB00000000000000
      0000C99B6A009163320000000000000000000000000000000000000000003F43
      7B000064DF00000000000D36DB000000000000000000233CB600000000000064
      DF000D36DB0000000000000000000000000000000000000000007A5212009A70
      3400000000000000000000000000000000000000000000000000000000000000
      0000C29562008F61300000000000000000000000000000000000000000000000
      00008C5F2C0001BBE80001BBE80001BBE80001BBE80001BBE80001BBE8008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000000000003F437B00C89B68000000000000000000000000002D41A3000000
      0000C89B68009163320000000000000000000000000000000000000000003F43
      7B000064DF000D36DB00000000000000000000000000000000002D41A3000463
      D8000D36DB00000000000000000000000000000000000000000078510F007C54
      15007E5519007E5519007D5417007B5314007B5314007B5314007E551900865B
      23008F612F008F61300000000000000000000000000000000000000000000000
      00008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      3000000000000000000000000000000000000000000000000000000000000000
      00003F437B008D602D00C99B6A00C99B6A000000000000000000000000000D36
      DB00CB9D6C00916332000000000000000000000000000000000000000000232B
      A8000D36DB000000000000000000000000000000000000000000000000000D36
      DB000D36DB000000000000000000000000000000000000000000795211008F66
      29009E743900A87D4400AC804900A4794100A4794100A87D4400B1864F00C99B
      6A00C99B6A008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000233C
      B600000000000000000091633200C99B6A00C99B6A00C99B6A00C99B6A00CA9C
      6B000D36DB000000000000000000000000000000000000000000000000001D3E
      C8000064DF000000000000000000000000000000000000000000000000000164
      DD000D36DB0000000000000000000000000000000000000000007E551900A479
      4100BC905C00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B
      6A00C99B6A008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001D3EC8000000
      0000000000000000000000000000916332009163320091633200916332009163
      3200000000000D36DB00000000000000000000000000000000001D3EC8000D36
      DB000D36DB000D36DB00000000000000000000000000000000000D36DB000D36
      DB000D36DB000D36DB0000000000000000000000000000000000855A21008C5F
      2C008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000D36DB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000D36DB0000000000000000000D36DB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000D36DB000000000000000000000000008D602D008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009A7034009E743900A87D
      4400B1864F00BC905C00BC905C00B78B5600B1864F00A87D4400A4794100A87D
      4400B78B5600C5986600C99B6A000000000000000000000000007D5417007C54
      15007B5314007C5415007D5417007B5516007B5516007B5314007C5315007E55
      190081571C00130DD900000000000000000000000000000000007D5417007E55
      19007E5519007E5519007E5519007E55190080551C0080551C0080551C007E5B
      1E0083572100875A2800000000000000000000000000000000007D5417007D54
      17007D5417007E5519007E5519007E55190080551C0080551C0081571C008357
      210085582400875A280000000000000000000000000045630300386800003868
      0000386800000000000000000000000000000000000000000000000000003868
      00003868000038680000386800000000000000000000000000007E5519000000
      0000000000000000000000000000000000000000000000000000000000009E56
      2E000101FE000101FE00000000000000000000000000000000007D5417000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000875A2800000000000000000000000000000000007D5417000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000885A290000000000000000000000000000000000000000000000
      0000000000003868000000000000000000000000000000000000386800000000
      00000000000000000000000000000000000000000000000000007E5519000000
      000092764500AC8049009E886000BC905C00D2AF7500E9C1930000000000AA57
      3700000000008F613000000000000000000000000000000000007D5417000000
      00006B826C006A9284006A9284006A92840059939E0066AAAF0066AAAF006BC1
      D90000000000885A2900000000000000000000000000000000007D5417000000
      000061832C005995370061832C005995370059953700599537004DB0470045C1
      510000000000885A290000000000000000000000000000000000000000000000
      0000000000000000000045630300000000000000000038680000000000000000
      000000000000000000000000000000000000000000000000000082581E000000
      0000BC905C00D2AF7500E0B68800F4C89900FED7AF00FED7AF0000000000AA57
      3700000000008F61300000000000000000000000000000000000000000000000
      00000000000000000000000000000000000066AAAF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000059953700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000545D0600000000000000000038680000000000000000
      000000000000000000000000000000000000000000000000000082581E000000
      0000B78B560000000000E9C19300FED7AF00FED7AF00FED7AF0000000000AA57
      3700000000008F613000000000000000000000000000000000005C553D006452
      31005C553D0048586800485868003A5A7A00000000002C5D9200215EA6000D62
      C8000064DF000064DF0000000000000000000000000000000000625809006258
      090062580900625809000000000062580900545D0600545D0600456303000000
      0000386800003868000000000000000000000000000000000000000000000000
      0000000000000000000000000000545D06004563030000000000000000000000
      00000000000000000000000000000000000000000000000000007E5519000000
      0000000000009254230000000000FED7AF00FED7AF000000000000000000AA57
      3700000000008F613000000000000000000000000000000000007A5212000000
      0000706C420061847C006A9284002C5D9200000000002C5D920053AACA0046B7
      EF0000000000885A2900000000000000000000000000000000007B5314000000
      00006A6F21006258090000000000625809005995370059953700456303003868
      000000000000885A2900000000000000000000000000A47941009A7034009E74
      3900A87D4400B1864F00BC905C00C99B6A00C99B6A00C99B6A00C99B6A00C295
      6200C5986600C5986600C59866000000000000000000000000007D5417000000
      000088521C00925423009E562E000000000000000000AA57370000000000AA57
      3700000000008F613000000000000000000000000000000000007B5314000000
      0000697459006FA1920066AAAF00175FB600000000000D62C80060D6F40060D6
      F40000000000885A2900000000000000000000000000000000007B5314000000
      00006A6F2100545D0600545D0600545D06004DB0470045C1510045C1510045C1
      510000000000885A290000000000000000000000000045630300000000003868
      0000386800003868000038680000386800000000000000000000000000003868
      0000386800003868000038680000000000000000000000000000000000000000
      000088521C0092542300AA573700AA573700AA573700AA57370000000000AA57
      3700000000008F613000000000000000000000000000000000007B5314000000
      00006A92840053AACA006BC1D9000164DD000064DF000164DD0060D6F40046B7
      EF0000000000885A2900000000000000000000000000000000007D5417000000
      000061832C0059953700456303004DB0470045C1510045C1510045C1510045C1
      510000000000885A290000000000000000000000000000000000386800000000
      0000000000000000000000000000000000003868000000000000386800000000
      00000000000000000000000000000000000000000000000000007C5315008752
      1B0092542300F4C89900AA573700AA573700AA573700AA573700AA573700AA57
      3700000000008F613000000000000000000000000000000000007E5519000000
      000066AAAF0046B7EF0046B7EF0060D6F4000A5ADC0046B7EF0046B7EF0060D6
      F40000000000885A2900000000000000000000000000000000007E5519000000
      00005995370045C1510045C1510045C1510045C1510045C1510045C1510045C1
      510000000000885A290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000038680000000000000000
      0000000000000000000000000000000000000000000000000000925423009E56
      2E00AA573700FED7AF00FED7AF00FED7AF00FED7AF00AA573700AA573700AA57
      3700000000008F6130000000000000000000000000000000000081571C000000
      00006BC1D90060D6F40060D6F40060D6F40060D6F40060D6F40060D6F40060D6
      F40000000000885A29000000000000000000000000000000000081571C000000
      000045C1510045C1510045C1510045C1510045C1510045C1510045C1510045C1
      510000000000885A290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000875C25000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F61300000000000000000000000000000000000835721000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000885A290000000000000000000000000000000000835721000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000885A290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008E602E008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F61300000000000000000000000000000000000875A2800885A
      2900885A2900885A2900885A2900885A2900885A2900885A2900885A2900885A
      2900885A2900885A290000000000000000000000000000000000875A2800885A
      2900885A2900885A2900885A2900885A2900885A2900885A2900885A2900885A
      2900885A2900885A2900000000000000000000000000C2956200BC905C00C598
      6600C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B
      6A00C99B6A00C99B6A00C99B6A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000000100000100010000000000000800000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FC3FFFFFFFFFFFFFF00FFFFFFFFFFFFFE007FFFFFFFFFFFFE007FFFFFFFFFFFF
      C003FFFFFFFFFFFFC003FFFFFFFFFFFFC003FFFFFFFFFFFFC003FFFFFFFFFFFF
      E007FFFFFFFFFFFFE007FFFFFFFFFFFFF00FFFFFFFFFFFFFFC3FFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF87FE7FFFFF
      F83FEF03F24FFFFFF01FFE01F7CFE09FE7CFA811FFFFE01FCFE7FE31CFF3F03F
      CFE7EE01CFF3F83FCFE7EF03FFFFF81FCEE7EF87CFF3F00FC4EFEFF7CFF3F307
      E0FFFFFFFFFFFF87F0FFA815F3CFFFC7E0FFFFFFF24FFFE7C0FFEFF7FE7FFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFC3FF9FFF18FC003F00FF8FFF18FC003E007F87FF18FC003E007F83FF18F
      C003C003F81FF18FF7FFC003F80FF18FE7FFC003F80FF18FC03FC003F81FF18F
      C03FE007F83FF18FE7FFE007F87FF18FF7FFF00FF8FFF18FFFFFFC3FF9FFF18F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8001FFFFFFFFFFFF
      8001FFFFFFFFFFFF8001FFFFC003C0038001F00FC003C0038001F00FC003C003
      8001F00FC003C0038001F00FF7EFFFEF8001F00FE7E7FFE78001F00FC003FC03
      8001F00FC003FC038001F00FE7E7FFE78001FFFFF7EFFFEF8001FFFFFFFFFFFF
      8001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF800180018001
      83FF80018001800183FF80018001800183FF80018001800180FF800180018001
      80FF80018001800180FF80018001800180078001800180018007800180018001
      8007800180018001800180018001800180018001800180018001800180018001
      8001800180018001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FDFFFC3FFC3F83FFFEFFF81FF81F83FFFE7FF00FF00F83FFF81FE207E00780FF
      F00FFD07E00780FFE007C087E00780FFC003C087E0078007C003FD07E0078007
      C003E207E0078007E007E007E0078001F00FE007E0078001F81FE007E0078001
      FFFFFFFFFFFF8001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      C3C3FFFFE007C3FFC3C3C7E3E007C3FFC003F7EFE027C07FC003F7EFF04FC05F
      C003C003FC3FC04FC003C003FE7FC007C003C003FE7FC007C003C003FC3FC04F
      C003F7EFF00FC05FC003F7EFE007C07FC003C7E3E027C07FC003FFFFE007C07F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003FFFF
      83FF83FFC003FFFF83FF83FFC003E00783FF83FFF81FC00380FF80FFC003C003
      80FF80FFC003C00380FF80FFC003C00380078007C003C00380078007C003C003
      80078007C003C00380018001C023C00380018001C003E00380018001C003FFFF
      80018001C003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7FFFFF
      FFFFEFF7FC3FFFFFE3C7FFFFFC3FE007E7E7A815FC3FE007E7E7FFFFFC3FE007
      E7E7EFF7F81FE007E7E7EFF7F00FE007E7E7EFF7E007E007E7E7EFF7E007E007
      E7E7FFFFE007E007E7E7A815E007F3CFE7E7FFFFE007F3CFE3C7EFF7F00FF99F
      FFFFFFFFF81FFC3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFF87FFF3
      FFFF9FFF9F039F01E7E78FFF8E018F01E3C7C7FFC631C7F3F18FE41FE411E417
      F81FF80FF801F80FFC3FF1C7F103F1C7FC3FF3E7F387F3E7F81FF3E7F3E7F3E7
      F18FF3E7F3E7F3E7E3C7F1C7F1C7F1C7E7E7F80FF80FF80FFFFFFC1FFC1FFC1F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      C3C3C3C39FF9C007CFF3C3C3FFFFC003D7EBC0038001C003DBDBC003C003C003
      FDBFC0038001F007FE7FC003FFFFF007FE7FC0039FF9E007FDBFC003FFFFC00F
      DBDBC0038001C007D7EBC003C003C003CFF3C0038001C003C3C3C003FFFFC003
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFDFFFFFFFF
      F81FDFFBFFFFCFCFF00FEFF7C003C787E007F7EFDFFBE387C603FBDFDFFBF1CF
      C703C003DFFBF8FFC3A3C003DFFBFC7FC1E3C003DFFBFE3FC0E3C003DFFBFF1F
      C1E3FBDFC003F38FE007F7EFC003E1C7F00FEFF7C003E1E3F81FDFFBFFFFF3F3
      FFFFBFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003C003C003FFFF
      C003C003C003F81FCFF3C3F3C813F00FC813C1F3C993E007C8D3C8F3C993C183
      C813CC03C993C183C8D3CE63C993C183C813CEF3C993C183CFF3CEF3C813C003
      C003C063C183C183C003C003C003E007C003C003C003F00FC003C003C003F81F
      C003C003C003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFDBFFDC003
      FFFFCFFBDFFBC003FFFFC7F7E3C7CFF3F00FE3EFE7E7CA13F00FF20FE3C7CFF3
      F00FFC07E5A7CA138001F863E667CFF38001F873E667CA13F00FF9B3E5A7CFF3
      F00FF9D3E3C7C003F00FF0E3E7E7C003FFFFEC07E7E7C003FFFFDE0BC3C3C003
      FFFFBFFDBFFDC003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8001
      C003C003C00387E1DFE3DFFBDFFBFBDFD02BD00BD00BFDBFD02BFF7FFDFFFDBF
      D42BC083C213FE7FDA6BD08BD20B8001D1ABD08BD00BA0E1F02BD00BD00BDF5F
      C00BD00BD00BFFBFC00BD00BD00BFFFFDFFBDFFBDFFBFFFFC003C003C0038001
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object imagelist2: TImageList
    Left = 445
    Top = 189
    Bitmap = {
      494C01013C00CC00CC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000000001000001002000000000000000
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008F6130008F6130008F6130008F6130000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F6130008F61300000F3FD0000F3FD0000F3FD0000F3FD008F61
      30008F6130000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD0000F3FD008153220000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD0000F3FD007C4E1D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD008F6130008E60
      2F0000F3FD0000F3FD0072441300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      300000F3FD0000F3FD0000F3FD0000F3FD008F6130008F61300000F3FD0000F3
      FD0000F3FD0000F3FD006A3C0B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      300000F3FD0000F3FD0000F3FD0000F3FD008F6130008F6130008F6130008D5F
      2E00815322006F41100065370600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD0000F3FD0000F3FD0065370600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD0000F3FD006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000895B2A0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD0000F3FD006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B4D1C007648170000F3FD0000F3FD0000F3FD0000F3FD006537
      0600653706000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006B3D0C006537060065370600653706000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000091633200916332009163
      3200916332000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008F6130008F61300000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F6130008F6130008F6130008F6130008F613000000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      30000000000000000000000000000000000091633200916332000064DF000064
      DF00916332008B5D2C0000000000000000000000000000000000000000000000
      0000000000000000000000000000895B2A00895B2A0000000000915969009159
      6900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F6130008F613000835524007D4F1E0082542300895B2A008E602F000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000091633200916332000064DF000062DA000062
      DA000062DA00865827007B4D1C00000000000000000000000000000000000000
      000000000000BEBEBE0000000000000000000000000000000000915969009159
      690000000000000000000000000000000000000000000000000000000000A7D7
      FF00A7D7FF00A7D7FF00A7D7FF00A7D7FF0000000000A7D7FF00A7D7FF000000
      0000000000000000000000000000000000000000000000000000000000008F61
      3000895B2A0000000000000000000000000000000000000000008F6130008F61
      300000000000000000000000000000000000000000008F613000000000008F61
      3000000000008F6130008F613000916332000064DF00015DD0008254230000F3
      FD000060D600004CA80070421100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A7D7
      FF00379DF500379DF500379DF500A7D7FF00A7D7FF00379DF500A7D7FF000000
      00000000000000000000000000000000000000000000000000008F6130008F61
      3000000000000000000000000000000000000000000000000000000000008F61
      3000845625000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000916332000064DF00015DD00000F3FD0000F3
      FD000064DF000144960066380700000000000000000000000000AB6A1B00AB6A
      1B00000000000000000000000000000000000000000000000000000000000000
      00002669940027598A0000000000000000000000000000000000000000000000
      0000A7D7FF00379DF500379DF500379DF500379DF500A7D7FF00000000000000
      00000000000000000000000000000000000000000000000000008F613000885A
      2900000000000000000000000000000000000000000000000000000000008F61
      30007F5120000000000000000000000000000000000000000000000000008F61
      30000000000000000000000000008F6232008D603000015DD0000062DE000062
      DE000053B8006B3D0C0065370600000000000000000000000000AB6A1B009E61
      1600000000000000000000000000000000000000000000000000000000000000
      00002669940027598A0000000000000000000000000000000000000000000000
      000000000000A7D7FF00379DF500379DF500379DF500A7D7FF00000000000000
      00000000000000000000000000000000000000000000000000008F6130008A5C
      2B00000000000000000000000000000000000000000000000000000000008F61
      3000764817000000000000000000000000000000000000000000000000008F61
      3000000000000000000000000000000000008557260084562500004CA800004C
      A8006B3D0C006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A7D7FF00379DF500379DF500379DF500379DF500A7D7FF000000
      00000000000000000000000000000000000000000000000000008F6130008F61
      30000000000000000000000000008F6130000000000000000000000000008557
      26006F4110000000000000000000000000000000000000000000000000008F61
      3000000000000000000000000000000000000000000080522100754818006D3F
      0E006537060000000000000000000000000000000000000000008CAB63007795
      4E00000000000000000000000000000000000000000000000000000000000000
      00002608AC0021059F0000000000000000000000000000000000000000000000
      0000A7D7FF00379DF500A7D7FF00A7D7FF00379DF500379DF500379DF500A7D7
      FF000000000000000000000000000000000000000000000000008F6130008F61
      30008F613000000000008F6130008B5D2C000000000000000000000000007D4F
      1E00000000000000000000000000000000000000000000000000000000008E60
      2F00000000000000000000000000000000000000000000000000000000000000
      0000683A090000000000000000000000000000000000000000008CAB63007795
      4E00000000000000000000000000000000000000000000000000000000000000
      00002608AC0021059F0000000000000000000000000000000000000000000000
      0000A7D7FF00A7D7FF000000000000000000A7D7FF00379DF500379DF500379D
      F500A7D7FF000000000000000000000000000000000000000000000000008F61
      30008F6130008F6130008F6130007B4D1C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A7D7FF00379DF500379D
      F500A7D7FF000000000000000000000000000000000000000000000000000000
      00008F6130008F6130007D4F1E006A3C0B000000000000000000000000000000
      000000000000000000000000000000000000000000008F613000000000008F61
      3000000000008F6130008F6130008F6130008B5D2C00885A2900855726000000
      0000855726000000000085572600000000000000000000000000000000000000
      00003C83D4003C83D4000000000000000000000000000000000088ECFE0076DC
      E400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A7D7FF00379D
      F500A7D7FF000000000000000000000000000000000000000000000000008F61
      30008D5F2E007A4C1B00683A0900653706000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003C83D4003C83D400000000008F6130008F6130000000000063C1C9003F8C
      9200000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A7D7
      FF00A7D7FF0000000000000000000000000000000000000000008F6130008658
      2700754716006638070065370600653706000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008658
      2700000000000000000000000000000000000000000000000000000000000000
      0000845625000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000815322007C4E1D0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008F6130008F6130008F6130008F613000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F6130008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F6130008F6130008F61300000000000000000008F6130008F6130008E60
      2F0000000000000000000000000000000000000000000000000046B7EF0046B7
      EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF0046B7EF003CA4D60000000000000000000000000000000000000000000000
      00008F6130008F61300041A7FF0041A7FF0041A7FF0041A7FF008F6130008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000000000008F61300000F3FD008F6130000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD008759280000000000000000008F61300000F3FD007F51
      200000000000000000000000000000000000000000000000000046B7EF0046B7
      EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF003B9CC6001E64830000000000000000000000000000000000000000008F61
      300041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7
      FF00815322000000000000000000000000000000000000000000000000000000
      0000000000008F61300000F3FD0000F3FD00895B2A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD007B4D1C0000000000000000008F61300000F3FD007345
      140000000000000000000000000000000000000000000000000046B7EF0046B7
      EF0041ACE100328BB4002A7DA70026769C0026769C0026769C0026769C001E64
      83000D445F00012D420000000000000000000000000000000000000000008F61
      300041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7
      FF007C4E1D000000000000000000000000000000000000000000000000000000
      0000000000008F61300000F3FD0000F3FD0000F3FD00885A2900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD007547160000000000000000008F61300000F3FD006E40
      0F0000000000000000000000000000000000000000000000000046B7EF0041AC
      E10026769C000D445F0005364C0005364C0005364C00012D4200012D4200012D
      4200012D4200012D4200000000000000000000000000000000008F61300041A7
      FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7
      FF0041A7FF007244130000000000000000000000000000000000000000000000
      0000000000008F61300000F3FD0000F3FD0000F3FD0000F3FD00825423000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD007547160000000000000000008F61300000F3FD006E40
      0F00000000000000000000000000000000000000000000000000000000000000
      00001C26A2000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F61300041A7
      FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7
      FF0041A7FF006A3C0B0000000000000000000000000000000000000000000000
      0000000000008F61300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD007143
      1200000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD007547160000000000000000008F61300000F3FD006E40
      0F0000000000000000000000000000000000000000000000000000000000222C
      A900222CA9000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F61300041A7
      FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7
      FF0041A7FF006537060000000000000000000000000000000000000000000000
      0000000000008F61300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD006537
      0600000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD007547160000000000000000008F61300000F3FD006E40
      0F00000000000000000000000000000000000000000000000000222CA900222C
      A900222CA9001C26A200222CA900222CA9001C26A200131D9900000000000000
      00000000000000000000000000000000000000000000000000008F61300041A7
      FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7
      FF0041A7FF006537060000000000000000000000000000000000000000000000
      0000000000008F61300000F3FD0000F3FD0000F3FD0000F3FD00653706000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD007547160000000000000000008F61300000F3FD006E40
      0F00000000000000000000000000000000000000000000000000222CA900222C
      A900131D990008128C000D1791000D1791000D17910008128C00000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      300041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7
      FF00653706000000000000000000000000000000000000000000000000000000
      0000000000008F61300000F3FD0000F3FD0000F3FD0065370600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD007547160000000000000000008F61300000F3FD006E40
      0F0000000000000000000000000000000000000000000000000000000000131D
      9900030D86000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000895B
      2A0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7FF0041A7
      FF00653706000000000000000000000000000000000000000000000000000000
      0000000000008F61300000F3FD0000F3FD006537060000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD007143120000000000000000008F61300000F3FD006A3C
      0B00000000000000000000000000000000000000000000000000000000000000
      0000030D86000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B4D1C007648170041A7FF0041A7FF0041A7FF0041A7FF00653706006537
      0600000000000000000000000000000000000000000000000000000000000000
      0000000000008D5F2E0000F3FD00653706000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F61300000F3FD00693B0A0000000000000000008D5F2E0000F3FD006537
      0600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006B3D0C00653706006537060065370600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F512000693B0A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000825423006E400F006537060000000000000000007D4F1E006E400F006537
      0600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008C5E2D0000000000000000000033FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000033FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4007A4C1B000000000000000000000000000033FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000033FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4006D3F0E00000000000000000000000000000000000033
      FF00000000000000000000000000000000000000000000000000000000000000
      00000033FF00000000000000000000000000000000000000000046B7EF0046B7
      EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF0046B7EF003CA4D6000000000000000000000000000000000046B7EF0046B7
      EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF0046B7EF003CA4D6000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C4008F6130008F613000FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C40067390800000000000000000000000000000000000000
      00008F6130008F6130008F6130008F6130008F6130008F6130008F6130008C5E
      2D0000000000000000000000000000000000000000000000000046B7EF0046B7
      EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF003CA4D6001E6483000000000000000000000000000000000046B7EF0046B7
      EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7EF0046B7
      EF003CA4D6001E6483000000000000000000000000008F613000FF56C400FF56
      C400FF56C4008F613000FFD48B008F613000FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C40067390800000000000000000000000000000000000000
      00008F61300000F5FD0000F5FD0000F5FD0000F5FD0000F3FD0000EBF200784A
      190000000000000000000000000000000000000000000000000046B7EF0046B7
      EF0041ACE100328BB4002A7DA70026769C002A7DA700328BB4003B9CC6002A7D
      A700185A7800012D42000000000000000000000000000000000046B7EF0044B4
      EB00328BB40026769C0026769C0026769C002A7DA700328BB4003B9CC6002A7D
      A700185A7800012D42000000000000000000000000008F613000FF56C400FF56
      C4008F613000FFD48B00FFD48B008F6130008F6130008F6130008F6130008F61
      30008F613000FF56C40067390800000000000000000000000000000000000000
      00008F61300000F5FD0000F5FD0000F5FD0000F5FD0000F5FD0000A5AA006A3C
      0B0000000000000000000000000000000000000000000000000046B7EF0041AC
      E10026769C000D445F0005364C0005364C000D445F00185A7800266994001E64
      830005364C00012D420000000000000000000000000000000000328BB4001E64
      8300083A5200012D420005364C00083A52000D445F00185A7800266994001E64
      830005364C00012D42000000000000000000000000008F613000FF56C4008F61
      3000FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD4
      8B008F613000FF56C40067390800000000000000000000000000000000000000
      00008F61300000F5FD0000F5FD0000F5FD0000F5FD0000CDD400017E82006739
      0800000000000000000000000000000000000000000000000000000000000000
      00001C26A2000000000000000000000000000000000000000000000000001C26
      A200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001C26
      A20000000000000000000000000000000000000000008F613000FF56C4008F61
      3000FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD4
      8B008F613000FF56C40067390800000000000000000000000000000000000000
      00008F61300000F5FD0000F5FD0000F5FD0000F3FD0000CDD400017E82006739
      080000000000000000000000000000000000000000000000000000000000222C
      A900222CA900000000000000000000000000000000000000000000000000222C
      A90017219D000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000222C
      A90017219D00000000000000000000000000000000008F613000FF56C400FF56
      C4008F613000FFD48B00FFD48B008F6130008F6130008F6130008F6130008F61
      30008F613000FF56C40067390800000000000000000000000000000000000000
      00008F61300000F5FD0000EBF20000CDD40000CDD40000A5AA0001696C006537
      0600000000000000000000000000000000000000000000000000222CA900222C
      A900222CA9001C26A200222CA900222CA900222CA900222CA900222CA900222C
      A900131D990008128C0000000000000000000000000000000000000000000000
      00000000000000000000222CA900222CA900222CA900222CA900222CA900222C
      A900131D990008128C000000000000000000000000008F613000FF56C400FF56
      C400FF56C4008F613000FFD48B008F613000FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C40067390800000000000000000000000000000000000000
      00008F61300000CDD400018F930001696C0001696C0001696C00012D42006638
      0700000000000000000000000000000000000000000000000000222CA900222C
      A900131D990008128C000D1791000D17910017219D001C26A2001C26A2001721
      9D0008128C00030D860000000000000000000000000000000000000000000000
      00000000000000000000222CA9001C26A20017219D001C26A2001C26A2001721
      9D0008128C00030D86000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C4008F6130008F613000FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C40067390800000000000000000000000000000000000000
      0000875928007345140066380700653706006537060065370600653706006537
      060000000000000000000000000000000000000000000000000000000000131D
      9900030D86000000000000000000000000000000000000000000000000000812
      8C00030D86000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000812
      8C00030D8600000000000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C40065370600000000000000000000000000000000000031
      F600000000000000000000000000000000000000000000000000000000000000
      00000024B1000000000000000000000000000000000000000000000000000000
      0000030D86000000000000000000000000000000000000000000000000000812
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000812
      8C0000000000000000000000000000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C400653706000000000000000000000000000032FC000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000002EE40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F512000734514006739
      0800653706006537060065370600653706006537060065370600653706006537
      06006537060065370600653706000000000000000000002EE400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000002AD100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F61300000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F61300000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130008F61300000000000000000008F6130008F6130008F61
      30008F6130008D5F2E0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008153220000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF008153220000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4008153220000000000000000008F6130000033FF000033
      FF000033FF008456250000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF007446150000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF007446150000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4007446150000000000000000008F6130000033FF000033
      FF000031F6008355240000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF008F6130008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF006E400F0000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF008F6130008F6130000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF006E400F0000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C4008F6130008F613000FF56C400FF56
      C400FF56C400FF56C4006E400F0000000000000000008F6130008F6130008F61
      30008C5E2D008759280082542300805221000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF008F61300000F3FD008F6130000AD7
      FF000AD7FF000AD7FF006E400F0000000000000000008F6130000AD7FF000AD7
      FF000AD7FF008F61300000F3FD008F6130000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF006E400F0000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C4008F613000FFD48B008F613000FF56
      C400FF56C400FF56C4006E400F0000000000000000008F6130000033FF000033
      FF000033FF006DF1FF006DF1FF00805221000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF008F61
      30008F6130008F6130008F6130008F6130008F61300000F3FD0000F3FD008F61
      30000AD7FF000AD7FF006E400F0000000000000000008F6130000AD7FF000AD7
      FF008F61300000F3FD0000F3FD008F6130008F6130008F6130008F6130008F61
      30008F6130000AD7FF006E400F0000000000000000008F613000FF56C4008F61
      30008F6130008F6130008F6130008F6130008F613000FFD48B00FFD48B008F61
      3000FF56C400FF56C4006E400F0000000000000000008F6130000033FF000033
      FF000033FF006DF1FF006DF1FF00865827000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130000AD7FF008F61
      300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD008F6130000AD7FF006E400F0000000000000000008F6130000AD7FF008F61
      300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD008F6130000AD7FF006E400F0000000000000000008F613000FF56C4008F61
      3000FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD4
      8B008F613000FF56C4006E400F0000000000000000008F6130008F6130008F61
      30008F6130008E602F008C5E2D008E602F008F6130008F6130008F6130008F61
      30008D5F2E00000000000000000000000000000000008F6130000AD7FF008F61
      300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD008F6130000AD7FF006E400F0000000000000000008F6130000AD7FF008F61
      300000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3FD0000F3
      FD008F6130000AD7FF006E400F0000000000000000008F613000FF56C4008F61
      3000FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD48B00FFD4
      8B008F613000FF56C4006E400F0000000000000000008F6130000033FF000033
      FF000033FF000033FF000033FF000033FF000033FF000033FF000033FF000033
      FF0084562500000000000000000000000000000000008F6130000AD7FF008F61
      30008F6130008F6130008F6130008F6130008F61300000F3FD0000F3FD008F61
      30000AD7FF000AD7FF006E400F0000000000000000008F6130000AD7FF000AD7
      FF008F61300000F3FD0000F3FD008F6130008F6130008F6130008F6130008F61
      30008F6130000AD7FF006E400F0000000000000000008F613000FF56C4008F61
      30008F6130008F6130008F6130008F6130008F613000FFD48B00FFD48B008F61
      3000FF56C400FF56C4006E400F0000000000000000008F6130000033FF000033
      FF000033FF000033FF000033FF000033FF000033FF000033FF000033FF000031
      F60083552400000000000000000000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF008F61300000F3FD008F6130000AD7
      FF000AD7FF000AD7FF006E400F0000000000000000008F6130000AD7FF000AD7
      FF000AD7FF008F61300000F3FD008F6130000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF006E400F0000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C4008F613000FFD48B008F613000FF56
      C400FF56C400FF56C4006E400F0000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008E602F008C5E
      2D0087592800815322008557260000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF008F6130008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF006E400F0000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF008F6130008F6130000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF006E400F0000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C4008F6130008F613000FF56C400FF56
      C400FF56C400FF56C4006E400F0000000000000000008F6130000033FF000033
      FF000033FF000033FF000033FF000033FF000033FF000033FF006DF1FF006DF1
      FF006DF1FF006DF1FF007749180000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF00693B0A0000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF00693B0A0000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C400693B0A0000000000000000008F6130000033FF000033
      FF000033FF000033FF000033FF000033FF000033FF000033FF006DF1FF006DF1
      FF006DF1FF006DF1FF006638070000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF006537060000000000000000008F6130000AD7FF000AD7
      FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7FF000AD7
      FF000AD7FF000AD7FF006537060000000000000000008F613000FF56C400FF56
      C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56C400FF56
      C400FF56C400FF56C4006537060000000000000000007F512000734514006739
      0800653706006537060065370600653706006537060065370600653706006537
      060065370600653706006537060000000000000000007F5120008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F6130006537060000000000000000007F512000734514006739
      0800653706006537060065370600653706006537060065370600653706006537
      060065370600653706006537060000000000000000007F512000734514006739
      0800653706006537060065370600653706006537060065370600653706006537
      0600653706006537060065370600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008F613000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000090623100906231008F6130008F613000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000090623100906231008F6130008F613000000000000000
      000000000000000000000000000000000000000000008F6130008F6130008F61
      30008F6130008D5F2E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008F6130000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000926433006DF1FF006DF1FF006DF1FF006DF1FF008D5F2E000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000092643300E3B98C00E3B98C00FDD6AD00FDD6AD008D5F2E000000
      000000000000000000000000000000000000000000008F61300061C5890061C5
      890061C589008456250000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008F6130008F61300000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000906231006DF1FF00E3B98C006DF1FF006DF1FF006DF1FF006DF1FF008456
      2500000000000000000000000000000000000000000000000000000000000000
      000090623100E3B98C00E3B98C00E3B98C00FDD6AD00FDD6AD00EDC59C008456
      250000000000000000000000000000000000000000008F61300061C5890061C5
      89005BBD82008355240000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F6130008F613000ECECEC00ECECEC008F6130008F6130000000
      0000000000000000000000000000000000000000000000000000000000009264
      3300E3B98C00E3B98C0000000000D5AF86006DF1FF006DF1FF006DF1FF006DF1
      FF00774918000000000000000000000000000000000000000000000000009264
      3300E3B98C00E3B98C00916332006DF1FF006DF1FF0090623100EDC59C00C69C
      700077491800000000000000000000000000000000008F6130008F6130008F61
      30008C5E2D008759280082542300805221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F613000ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC008A5C
      2B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000062DE0000000000FDD6AD006DF1FF006DF1FF006DF1
      FF006E400F000000000000000000000000000000000000000000000000009264
      3300E3B98C00916332006DF1FF006DF1FF006DF1FF006DF1FF008A5C2B00A682
      5B006F411000000000000000000000000000000000008F61300061C5890061C5
      890061C589006DF1FF006DF1FF00805221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      3000ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00DADA
      DA008456250000000000000000000000000000000000000000000062DE000062
      DE000062DE000062DE000062DE000062DE0000000000FDD6AD006DF1FF006DF1
      FF00693B0A000000000000000000000000000000000000000000000000009264
      3300E3B98C006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF009C79
      5200693B0A00000000000000000000000000000000008F61300061C5890061C5
      890061C589006DF1FF006DF1FF00865827000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000ECEC
      EC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00CBCB
      CB009696960076481700000000000000000000000000000000000062DE000062
      DE000062DE000062DE000062DE000062DE0000000000FDD6AD006DF1FF006DF1
      FF00673908000000000000000000000000000000000000000000000000009264
      3300E3B98C006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF009C74
      4B0067390800000000000000000000000000000000008F6130008F6130008F61
      30008F6130008E602F008C5E2D008E602F008F6130008F6130008F6130008F61
      30008D5F2E0000000000000000000000000000000000000000008F613000ECEC
      EC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00ECECEC00DADADA00ADAD
      AD0060606000683A090000000000000000000000000000000000000000000000
      000000000000000000000062DE0000000000FDD6AD006DF1FF006DF1FF006DF1
      FF00673908000000000000000000000000000000000000000000000000009264
      3300E3B98C00916332006DF1FF006DF1FF006DF1FF006DF1FF00875928009C74
      4B0067390800000000000000000000000000000000008F61300061C5890061C5
      890061C5890061C5890061C5890061C5890061C5890061C5890061C5890061C5
      89008456250000000000000000000000000000000000000000008F613000ECEC
      EC00ECECEC00E9E9E900ECECEC00ECECEC00E9E9E900DADADA00ADADAD006060
      60002D2D2D006537060000000000000000000000000000000000000000009264
      3300E3B98C00E3B98C0000000000E3B98C006DF1FF006DF1FF006DF1FF006DF1
      FF00673908000000000000000000000000000000000000000000000000009264
      3300E3B98C00E3B98C00916332006DF1FF006DF1FF0091633200E3B98C009C74
      4B0067390800000000000000000000000000000000008F61300061C5890061C5
      890061C5890061C5890061C5890061C5890061C5890061C5890061C589005BBD
      8200835524000000000000000000000000000000000000000000000000008658
      2700BEBEBE00BEBEBE00BEBEBE00BEBEBE00BEBEBE0096969600606060002D2D
      2D00653706000000000000000000000000000000000000000000000000009264
      33006DF1FF006DF1FF00E3B98C006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF00653706000000000000000000000000000000000000000000000000009264
      3300E3B98C00E0B48500C69C7000C69C7000D5AF8600E0B48500B7946D00885E
      320065370600000000000000000000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008E602F008C5E
      2D00875928008153220085572600000000000000000000000000000000000000
      00007B4D1C00969696007373730073737300606060002D2D2D002D2D2D006537
      0600000000000000000000000000000000000000000000000000000000009264
      33006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF00653706000000000000000000000000000000000000000000000000009264
      3300C69C70009C744B00885E3200885E32008F673E008F673E007B532A006537
      060065370600000000000000000000000000000000008F61300061C5890061C5
      890061C5890061C5890061C5890061C5890061C5890061C589006DF1FF006DF1
      FF006DF1FF006DF1FF0077491800000000000000000000000000000000000000
      00000000000071431200693B0A00653706006537060065370600653706000000
      0000000000000000000000000000000000000000000000000000000000008658
      270075471600693B0A0065370600653706006537060065370600653706006537
      0600653706000000000000000000000000000000000000000000000000008658
      2700744615006739080065370600653706006537060065370600653706006537
      060065370600000000000000000000000000000000008F61300061C5890061C5
      890061C5890061C5890061C5890061C5890061C5890061C589006DF1FF006DF1
      FF006DF1FF006DF1FF0066380700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084562500734514006739
      0800653706006537060065370600653706006537060065370600653706006537
      0600653706006537060065370600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F6130008F61
      30008F6130008F613000000000000000000000000000000000008F6130008F61
      30008F6130008A5C2B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      3000885A290000000000000000000000000000000000000000008F6130008F61
      30008F6130008F61300000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000E4B6
      4C00E4B64C008F613000000000000000000000000000000000008F613000E4B6
      4C00E4B64C00794B1A0000000000000000000000000000000000000000000000
      00000A5ADD000A5ADD000A5ADD0000000000000000000A5ADD000A5ADD000A5A
      DD0000000000000000000000000000000000000000000000000000000000CB9D
      6C006DF1FF006DF1FF000064DF000064DF000064DF000064DF006DF1FF006DF1
      FF008658270000000000000000000000000000000000000000008F613000CB9D
      6C00CB9D6C008F61300000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000E4B6
      4C008F6130008F613000CB9D6C006DF1FF006DF1FF00CB9D6C008F6130008F61
      3000B58D33006B3D0C0000000000000000000000000000000000000000000000
      00000A5ADD000000000000000000000000000000000000000000000000000A5A
      DD0000000000000000000000000000000000000000000000000000000000CB9D
      6C006DF1FF006DF1FF006DF1FF000064DF000062DA006DF1FF006DF1FF00012D
      42006537060000000000000000000000000000000000000000008F613000CB9D
      6C008F6130008F6130008F6130008F6130008F61300000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000E4B6
      4C008F6130006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF008D5F
      2E00957222006739080000000000000000000000000000000000000000000000
      00000A5ADD000000000000000000000000000000000000000000000000000A5A
      DD00000000000000000000000000000000000000000000000000000000000000
      0000A1734200A17342006DF1FF006DF1FF006DF1FF006DF1FF00653706006537
      06000000000000000000000000000000000000000000000000008F613000CB9D
      6C008F6130006DF1FF006DF1FF006DF1FF008F613000000000008F6130000000
      00000000000000000000000000000000000000000000000000008F613000E4B6
      4C008F6130006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF00885A
      2900957222006638070000000000000000000000000000000000E4B64C00E4B6
      4C000A5ADD00E4B64C00E4B64C00E4B64C00E4B64C00E4B64C00E4B64C000A5A
      DD00DCAF4800B58D330000000000000000000000000000000000000000000000
      00000000000000000000B28453006DF1FF006DF1FF0065370600000000000000
      00000000000000000000000000000000000000000000000000008F613000CB9D
      6C008F6130006DF1FF006DF1FF006DF1FF008F613000000000008F6130008F61
      30000000000000000000000000000000000000000000000000008F613000E4B6
      4C008F6130006DF1FF006DF1FF008F6130008F6130006DF1FF006DF1FF008759
      2800957222006739080000000000000000000000000000000000E4B64C00E4B6
      4C000A5ADD00E4B64C00E4B64C00E4B64C00E4B64C00E4B64C00E4B64C000A5A
      DD00B58D330087651A0000000000000000000000000000000000000000000000
      0000000000000000000000000000CB9D6C009264330000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000CB9D
      6C008F6130006DF1FF006DF1FF00885A2900895B2A008F6130008F6130008153
      22007648170000000000000000000000000000000000000000008F613000E4B6
      4C008F6130006DF1FF006DF1FF008F6130008F6130006DF1FF006DF1FF00885A
      290087651A006638070000000000000000000000000000000000E4B64C00E4B6
      4C000158C600A6802B00A6802B00A6802B00A6802B00B58D3300B58D33000439
      990071520F00573C010000000000000000000000000000000000000000000000
      0000000000000000000000000000CB9D6C00BD905F0000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000CB9D
      6C008F6130006DF1FF006DF1FF00845625007D4F1E007D4F1E00774918006A3C
      0B006537060000000000000000000000000000000000000000008F613000E4B6
      4C008F6130006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF008759
      2800957222006739080000000000000000000000000000000000DCAF4800C39A
      3B00023B8800674A0A00573C0100573C0100674A0A00795A130087651A000230
      7400573C0100573C010000000000000000000000000000000000000000000000
      00000000000000000000CB9D6C000064DF000064DF00BD905F00000000000000
      00000000000000000000000000000000000000000000000000008F613000CB9D
      6C008F6130006DF1FF006DF1FF006DF1FF007143120000000000653706006537
      06000000000000000000000000000000000000000000000000008F613000E4B6
      4C008F6130008F6130008F6130008F6130008F6130008F6130008F6130008759
      280087651A00683A090000000000000000000000000000000000000000000000
      0000023B88000000000000000000000000000000000000000000000000000230
      7400000000000000000000000000000000000000000000000000000000000000
      0000CB9D6C00CB9D6C000064DF000064DF000064DF000064DF00CB9D6C00C597
      66000000000000000000000000000000000000000000000000008F613000CB9D
      6C008F6130008F61300087592800794B1A00693B0A0000000000653706000000
      00000000000000000000000000000000000000000000000000008F613000E4B6
      4C00DCAF4800C39A3B00C39A3B00C39A3B00C39A3B00C39A3B00C39A3B00A680
      2B00795A13006537060000000000000000000000000000000000000000000000
      00000748B3000000000000000000000000000000000000000000000000000230
      740000000000000000000000000000000000000000000000000000000000CB9D
      6C006DF1FF006DF1FF006DF1FF000064DF000060D6006DF1FF006DF1FF006DF1
      FF009567360000000000000000000000000000000000000000008F613000CB9D
      6C00C6986700B4865500A1734200805221006537060000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000C39A
      3B009572220087651A0087651A0087651A0087651A0087651A0087651A007152
      0F00573C01006537060000000000000000000000000000000000000000000000
      00000748B30004399900023B88000000000000000000015DD0000748B300023B
      880000000000000000000000000000000000000000000000000000000000CB9D
      6C006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF00693B0A0000000000000000000000000000000000000000008F613000B688
      57009567360085572600784A1900653706006537060000000000000000000000
      0000000000000000000000000000000000000000000000000000845625007345
      1400673908006537060065370600653706006537060065370600653706006537
      0600653706006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008658
      270076481700693B0A0065370600653706006537060065370600653706006537
      0600653706000000000000000000000000000000000000000000845625007345
      1400673908006537060065370600653706006537060000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CB9D6C00CB9D
      6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D
      6C00CB9D6C00B98B5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130008F6130008F61
      30008F6130008D5F2E0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130008F6130008F61
      30008F6130008D5F2E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CB9D6C008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      3000825423008A5C2B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F613000AB33A800AB33
      A800AB33A8008456250000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F613000006AC600E6B8
      5C0062F5FB008456250000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CB9D6C00CB9D
      6C00CB9D6C00CB9D6C00CB9D6C008F6130008F613000CB9D6C00BA8C5B00A173
      420083552400714312000000000000000000000000000000000000000000CB9D
      6C00CB9D6C008F6130008F613000CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D
      6C00CB9D6C00000000000000000000000000000000008F613000AB33A800AB33
      A800AB33A8008355240000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F613000006AC600E6B8
      5C0062F5FB008355240000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CB9D6C00CB9D6C008F6130008D5F2E00BB8D5C00B08251000000
      0000000000000000000000000000000000000000000000000000CB9D6C000064
      DF008F6130006DF1FF006DF1FF008F6130000064DF000064DF000064DF000064
      DF00015DD0009E703F000000000000000000000000008F6130008F6130008F61
      30008C5E2D008759280082542300805221000000000000000000000000000000
      000000000000000000000000000000000000000000008F6130008F6130008F61
      30008C5E2D008759280082542300805221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CB9D6C00CB9D
      6C00CB9D6C00CB9D6C00CB9D6C008F6130008E602F00C4966500C4966500BB8D
      5C00A67847008D5F2E0000000000000000000000000000000000CB9D6C008F61
      30006DF1FF006DF1FF006DF1FF006DF1FF008F6130000064DF000064DF000062
      DA00004CA800805221000000000000000000000000008F613000F7B95B00F7B9
      5B00F7B95B00F7B95B00F7B95B00805221000000000000000000000000000000
      000000000000000000000000000000000000000000008F613000006AC600006A
      C600E6B85C0062F5FB0062F5FB00805221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CB9D6C008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008D5F
      2E008052210085572600000000000000000000000000000000008F6130006DF1
      FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF008F6130000064DF000158
      C600023B88006E400F000000000000000000000000008F613000F7B95B00F7B9
      5B00F7B95B00F7B95B00F7B95B00865827000000000000000000000000000000
      000000000000000000000000000000000000000000008F613000006AC600006A
      C600E6B85C0062F5FB0062F5FB00865827000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CB9D6C008F61
      3000CB9D6C006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF007B4D1C0076481700000000000000000000000000000000008F6130008F61
      30008F6130006DF1FF006DF1FF008F6130008F6130008F6130000064DF000158
      C600023B8800693B0A000000000000000000000000008F6130008F6130008F61
      30008F6130008E602F008C5E2D008E602F008F6130008F6130008F6130008F61
      30008D5F2E00000000000000000000000000000000008F6130008F6130008F61
      30008F6130008E602F008C5E2D008E602F008F6130008F6130008F6130008F61
      30008D5F2E000000000000000000000000000000000000000000CB9D6C008F61
      30006DF1FF00CB9D6C006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF0075471600693B0A0000000000000000000000000000000000CB9D6C000064
      DF008F6130006DF1FF006DF1FF008F6130000064DF000064DF000064DF000158
      C600023B8800693B0A000000000000000000000000008F6130002E62D9002E62
      D9002E62D9002E62D9002E62D9002E62D9002E62D9002E62D9002E62D9002E62
      D90084562500000000000000000000000000000000008F613000006AC600006A
      C600006AC600006AC600E6B85C00E6B85C00E6B85C0062F5FB0062F5FB0062F5
      FB00845625000000000000000000000000000000000000000000CB9D6C008F61
      30006DF1FF006DF1FF00CB9D6C006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF00754716006A3C0B0000000000000000000000000000000000CB9D6C000064
      DF008F6130006DF1FF006DF1FF006DF1FF008F6130008F6130008F6130008759
      280075471600673908000000000000000000000000008F6130002E62D9002E62
      D9002E62D9002E62D9002E62D9002E62D9002E62D9002E62D9002E62D9002E62
      D90083552400000000000000000000000000000000008F613000006AC600006A
      C600006AC600006AC600E6B85C00E6B85C00E6B85C0062F5FB0062F5FB0062F5
      FB00835524000000000000000000000000000000000000000000CB9D6C008F61
      30006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF00774918006B3D0C0000000000000000000000000000000000CB9D6C000064
      DF000060D600855726006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF006DF1FF00653706000000000000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008E602F008C5E
      2D0087592800815322008557260000000000000000008F6130008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008E602F008C5E
      2D0087592800815322007C4E1D00000000000000000000000000CB9D6C008F61
      30006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF00000000006DF1
      FF007A4C1B006D3F0E0000000000000000000000000000000000CA9C6B000053
      B80001449600023B8800714312006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF006DF1FF00653706000000000000000000000000008F61300000C07B0000C0
      7B0000C07B0000C07B0000C07B0000C07B0000C07B0000C07B0000C07B0000C0
      7B0000C07B0000C07B007749180000000000000000008F613000006AC600006A
      C600006AC600006AC600006AC600006AC600E6B85C00E6B85C00E6B85C0062F5
      FB0062F5FB0062F5FB0070421100000000000000000000000000CB9D6C008F61
      30006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF00744615006638070000000000000000000000000000000000000000008F61
      3000724413006537060065370600653706006537060065370600653706006537
      060065370600653706000000000000000000000000008F61300000C07B0000C0
      7B0000C07B0000C07B0000C07B0000C07B0000C07B0000C07B0000C07B0000C0
      7B0000C07B0000C07B006638070000000000000000008F613000006AC600006A
      C600006AC600006AC600006AC600006AC600E6B85C00E6B85C00E6B85C0062F5
      FB0062F5FB0062F5FB0065370600000000000000000000000000CB9D6C008658
      2700794B1A007244130072441300724413007345140074461500774918007345
      1400673908006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084562500734514006739
      0800653706006537060065370600653706006537060065370600653706006537
      060065370600653706006537060000000000000000007F512000734514006739
      0800653706006537060065370600653706006537060065370600653706006537
      0600653706006537060065370600000000000000000000000000AE804F00885A
      29006B3D0C006537060065370600653706006537060065370600653706006537
      0600653706006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      3000000000000000000000000000000000000000000000000000000000000000
      00008F6130000000000000000000000000000000000000000000000000000000
      000000000000000000008F613000CB9D6C00CB9D6C007F512000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000002D
      DF00002DDF000028C30000000000000000000000000000000000002DDF00002D
      DF00002DDF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008F613000CB9D6C00C395640073451400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000008080800000000000000000000000000000000000000000000000000002D
      DF000062DA000000000000000000000000000000000000000000000000000064
      DF000028C300000000000000000000000000000000008F613000000000008F61
      3000000000008F6130008F6130008F6130008D5F2E008D5F2E008E602F000000
      00008F6130000000000087592800000000000000000000000000000000000000
      000000000000000000008F613000CB9D6C00B688570071431200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00C395
      640010101000000000000000000000000000000000000000000000000000002E
      E400004CA8000000000000000000000000000000000000000000000000000064
      DF000024B1000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008F613000CB9D6C00BD905F00794B1A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CB9D6C00CB9D6C008F6130008F6130008F6130008F613000CB9D6C009D6F
      3E002D2D2D00000000000000000000000000000000000000000000000000002D
      DF00014496000000000000000000000000000000000000000000000000000064
      DF000024B1000000000000000000000000000000000000000000000000008F61
      3000000000000000000000000000000000000000000000000000000000000000
      00008F6130000000000000000000000000000000000000000000000000000000
      0000000000008F6130008F6130008F6130008F61300084562500815322000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CB9D6C00CB9D6C008F6130006DF1FF006DF1FF008F613000B78958008D5F
      2E002D2D2D00000000000000000000000000000000000000000000000000002D
      DF00004CA8000000000000000000000000000000000000000000000000000064
      DF000024B1000000000000000000000000000000000000000000000000008F61
      3000000000000000000000000000000000000000000000000000000000000000
      00008F6130000000000000000000000000000000000000000000000000000000
      00008F6130008F6130006DF1FF006DF1FF006DF1FF006DF1FF00875928008355
      2400000000000000000000000000000000000000000000000000000000000000
      0000CB9D6C00CB9D6C008F6130006DF1FF006DF1FF008F613000B78958008D5F
      2E002D2D2D00000000000000000000000000000000000000000000000000002D
      DF00004CA8000000000000000000000000000000000000000000000000000064
      DF000024B1000000000000000000000000000000000000000000000000008F61
      3000000000000000000000000000000000000000000000000000000000000000
      00008F6130000000000000000000000000000000000000000000000000008F61
      30008F6130006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF007F51
      2000774918000000000000000000000000000000000000000000000000000000
      0000CB9D6C00CB9D6C00885A290087592800885A29008A5C2B00AE804F008658
      27002D2D2D00000000000000000000000000000000000000000000000000002D
      DF00004CA8000000000000000000000000000000000000000000000000000064
      DF000024B1000000000000000000000000000000000000000000000000008E60
      2F00000000000000000000000000000000000000000000000000000000000000
      00008C5E2D000000000000000000000000000000000000000000000000008F61
      30006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF006E400F000000000000000000000000000000000000000000000000000000
      0000CB9D6C00B3855400906231008C5E2D0097693800A67847009E703F00794B
      1A002D2D2D00000000000000000000000000000000000000000000000000002D
      DF00004CA8000000000000000000000000000000000000000000000000000064
      DF000024B1000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      30006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF00673908000000000000000000000000000000000000000000000000000000
      0000030303001A1A1A002D2D2D002D2D2D001A1A1A001A1A1A001A1A1A002D2D
      2D002D2D2D00000000000000000000000000000000000000000000000000002D
      DF00004CA8000000000000000000000000000000000000000000000000000064
      DF000526A500000000000000000000000000000000008F613000000000008F61
      3000000000008F6130008F6130008F6130008D5F2E008D5F2E008C5E2D000000
      00008B5D2C000000000085572600000000000000000000000000000000008F61
      30006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1
      FF00653706000000000000000000000000000000000000000000000000000000
      0000080808001A1A1A00000000000000000000000000000000001A1A1A002D2D
      2D0000000000000000000000000000000000000000000000000000000000002D
      DF00014496000000000000000000000000000000000000000000000000000062
      DA0004218B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008F61
      30008E602F0088ECFE0088ECFE006DF1FF006DF1FF006DF1FF006DF1FF006537
      0600653706000000000000000000000000000000000000000000000000000000
      0000080808001A1A1A00000000000000000000000000000000001A1A1A002D2D
      2D00000000000000000000000000000000000000000000000000000000000028
      C30004218B00021A770000000000000000000000000000000000002DDF000024
      B100021A77000000000000000000000000000000000000000000000000008658
      2700000000000000000000000000000000000000000000000000000000000000
      0000845625000000000000000000000000000000000000000000000000000000
      00008254230088ECFE0088ECFE0088ECFE006DF1FF006DF1FF006DF1FF006537
      0600000000000000000000000000000000000000000000000000000000000000
      00000000000010101000101010000000000000000000080808001A1A1A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000072441300693B0A00653706006537060065370600653706000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001010100010101000101010001A1A1A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000064DF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000091633200916332009163
      3200916332000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000064DF000064DF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000091633200C99B6A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000091633200C99B6A000000
      00000000000000000000000000000000000091633200916332000064DF000064
      DF00916332008C5E2D0000000000000000000000000091633200C99B6A000000
      0000000000000000000000000000000000000064DF000064DF000064DF000064
      DF000064DF000053B800023B8800000000000000000000000000000000008F61
      30008F6130000000000000000000000000000000000000000000000000008F61
      30008D5F2E0000000000000000000000000000000000FDD6AD008F613000C89A
      6900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDD6AD008F613000C89A
      690000000000000000000000000091633200916332000064DF000062DA000064
      DF000064DF00875928007D4F1E000000000000000000FDD6AD008F613000C89A
      6900000000000000000000000000000000000064DF000064DF000064DF000064
      DF000053B8000230740001255000000000000000000000000000000000008F61
      30008F6130008F613000000000000000000000000000000000008F6130008F61
      3000764817000000000000000000000000000000000000000000FDD6AD008E60
      2F00C79968000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDD6AD008E60
      2F00C99B6A000000000000000000916332000064DF000064DF006DF1FF006DF1
      FF000064DF00004CA80071431200000000000000000000000000FDD6AD008E60
      2F00C79968000000000000000000000000000000000000000000000000000000
      0000023074000125500000000000000000000000000000000000000000000000
      00008F6130008F6130008F61300000000000000000008F6130008F6130007042
      110000000000000000000000000000000000000000000000000000000000EDC5
      9C00916332000000000091633200916332009163320091633200916332000000
      000000000000000000000000000000000000000000000000000000000000EDC5
      9C00916332000000000091633200916332000064DF000062DA00916332006DF1
      FF000064DF00014496006638070000000000000000000000000000000000EDC5
      9C00916332000000000091633200916332009163320091633200916332000000
      0000023074000000000000000000000000000000000000000000000000000000
      0000000000008F6130008F6130008F6130008F6130008F613000724413000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000091633200C3956400AC7E4D00B0825100C7996800C99B6A008F61
      3000000000000000000000000000000000000000000000000000000000000000
      00000000000091633200C99B6A008D6030008A5C2B00015DD0000064DF000064
      DF000053B8006B3D0C0065370600000000000000000000000000000000000000
      00000000000091633200C2946300A6784700A6784700B7895800C49665008658
      2700000000000000000000000000000000000000000000000000000000000000
      000000000000000000008F6130008F6130008F613000794B1A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000091633200C0926100805221006DF1FF006DF1FF006DF1FF00C0926100C092
      61007F5120000000000000000000000000000000000000000000000000000000
      000091633200C3956400906231006DF1FF00794B1A00845625000158C6000053
      B800714312006537060000000000000000000000000000000000000000000000
      000091633200C0926100805221006DF1FF006DF1FF006DF1FF00BD905F00B688
      5700784A19000000000000000000000000000000000000000000000000000000
      000000000000000000008F6130008D5F2E007F51200075471600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000091633200AC7E4D006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF00C89A
      69007B4D1C000000000000000000000000000000000000000000000000000000
      000091633200B08251006DF1FF006DF1FF006DF1FF0080522100855828007C4E
      1D00673908000000000000000000000000000000000000000000000000000000
      000091633200AC7E4D006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF00C496
      6500794B1A000000000000000000000000000000000000000000000000000000
      0000000000008F6130008C5E2D007648170072441300794B1A00805221000000
      0000000000000000000000000000000000000000000000000000000000000000
      000091633200B48655006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF00C99B
      6A00794B1A000000000000000000000000000000000000000000000000000000
      000091633200B48655006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF00AA7C
      4B00693B0A000000000000000000000000000000000000000000000000000000
      000091633200B48655006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF00C99B
      6A00794B1A000000000000000000000000000000000000000000000000000000
      00008F6130008E602F007042110000000000000000007C4E1D00865827008456
      2500000000000000000000000000000000000000000000000000000000000000
      000091633200C99B6A006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF00C99B
      6A00734514000000000000000000000000000000000000000000000000000000
      000091633200C99B6A006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF00BD90
      5F006B3D0C000000000000000000000000000000000000000000000000000000
      000091633200C99B6A006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF00C99B
      6A00734514000000000000000000000000000000000000000000000000008F61
      30008C5E2D006F41100000000000000000000000000000000000805221007B4D
      1C00754716000000000000000000000000000000000000000000000000000000
      000091633200C99B6A00C89A69006DF1FF006DF1FF006DF1FF00C99B6A00AE80
      4F00693B0A000000000000000000000000000000000000000000000000000000
      000091633200C99B6A00C89A69006DF1FF006DF1FF006DF1FF00C99B6A00A173
      4200673908000000000000000000000000000000000000000000000000000000
      000091633200C99B6A00C89A69006DF1FF006DF1FF006DF1FF00C99B6A00AE80
      4F00693B0A00000000000000000000000000000000000000000000000000885A
      2900734514000000000000000000000000000000000000000000000000007244
      13006B3D0C000000000000000000000000000000000000000000000000000000
      0000000000008A5C2B00BB8D5C00C99B6A00C99B6A00C99B6A00AC7E4D006B3D
      0C00000000000000000000000000000000000000000000000000000000000000
      0000000000008A5C2B00BB8D5C00C99B6A00C99B6A00C99B6A00AC7E4D006B3D
      0C00000000000000000000000000000000000000000000000000000000000000
      0000000000008A5C2B00BB8D5C00C99B6A00C99B6A00C99B6A00AC7E4D006B3D
      0C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007A4C1B00774918007648170070421100673908000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007A4C1B00774918007648170070421100673908000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007A4C1B00774918007648170070421100673908000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F6130008F61
      30008F61300084562500000000000000000000000000000000008F6130008F61
      30008F6130008D5F2E00000000000000000000000000000000008F6130008F61
      30008F6130008F613000000000000000000000000000000000008F6130008F61
      30008F6130008A5C2B00000000000000000000000000CB9D6C00CB9D6C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CB9D6C00CB9D6C000000000000000000000000008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F61300000000000000000000000000000000000000000008F6130008E60
      2F00000000000000000000000000000000000000000000000000000000000000
      00008F6130007D4F1E00000000000000000000000000000000008F613000CB9D
      6C00CB9D6C008F613000000000000000000000000000000000008F613000CB9D
      6C00CB9D6C00794B1A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000F5C8
      9800F5C89800CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D
      6C00BB8D5C007B4D1C00000000000000000000000000000000008B5D2C000000
      0000774918000000000000000000000000000000000000000000000000008B5D
      2C000000000071431200000000000000000000000000000000008F613000CB9D
      6C008F6130008F613000CB9D6C006DF1FF006DF1FF00CB9D6C008F6130008F61
      3000AA7C4B006B3D0C00000000000000000000000000CB9D6C00CB9D6C00CB9D
      6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D6C00CB9D
      6C00CB9D6C00C79968009D6F3E000000000000000000000000008F613000F5C8
      98008F613000F5C89800F5C89800F5C89800F5C89800F5C89800F5C89800E0B4
      8500A17342006B3D0C0000000000000000000000000000000000805221000000
      00000000000085572600000000000000000000000000000000008E602F000000
      00000000000070421100000000000000000000000000000000008F613000CB9D
      6C008F6130006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF008E60
      2F00926433006739080000000000000000000000000000000000CB9D6C008F61
      30008F6130008E602F008F6130008F6130008F6130008F6130008F6130008F61
      30008759280097693800000000000000000000000000000000008F6130008F61
      30008F613000F5C89800F5C89800F5C89800F5C89800F5C89800E5B88800B284
      53006E400F006537060000000000000000000000000000000000000000000000
      000000000000000000008F61300000000000000000008F613000000000000000
      00000000000000000000000000000000000000000000000000008F613000CB9D
      6C008F6130006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF00895B
      2A008E602F0067390800000000000000000000000000CB9D6C00BB8D5C007648
      17006B3D0C00693B0A006A3C0B006A3C0B006A3C0B006A3C0B006B3D0C006D3F
      0E006E400F007648170074461500000000000000000000000000000000000000
      00008F613000F5C89800F5C89800F5C89800F5C89800F1C49400D5A878008A5C
      2B00653706000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008F6130008F61300000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000CB9D
      6C008F6130006DF1FF006DF1FF008F6130008F6130006DF1FF006DF1FF008759
      28008D5F2E006739080000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008F613000F5C89800F5C89800F5C89800F5C89800F1C49400AE804F007D4F
      1E00653706000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008D5F2E008153220000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000CB9D
      6C008F6130006DF1FF006DF1FF008F6130008F6130006DF1FF006DF1FF008759
      28008D5F2E0067390800000000000000000000000000CB9D6C00CB9D6C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0926100A1734200000000000000000000000000000000008F61
      30008F613000F5C89800F5C89800CB9D6C00CB9D6C00C5976600AA7C4B007D4F
      1E00653706000000000000000000000000000000000000000000000000000000
      000000000000000000008D5F2E0000000000000000007F512000000000000000
      00000000000000000000000000000000000000000000000000008F613000CB9D
      6C008F6130006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF006DF1FF008759
      28008D5F2E006739080000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000F5C8
      9800F5C89800CB9D6C00CB9D6C00CB9D6C00CB9D6C00C6986700B08251007648
      17000000000000000000000000000000000000000000000000008F6130000000
      0000000000008F613000000000000000000000000000000000008F6130000000
      0000000000008F613000000000000000000000000000000000008F613000CB9D
      6C008F6130008F6130008F6130008F6130008F6130008F6130008F6130008759
      28008D5F2E0067390800000000000000000000000000CB9D6C00CB9D6C000064
      DF000064DF000064DF000064DF000064DF000064DF000064DF000064DF000064
      DF000064DF00C79968009D6F3E000000000000000000000000008F613000F5C8
      98008F6130008F6130008F6130008F6130008F6130008D5F2E00895B2A008052
      21007749180000000000000000000000000000000000000000008F6130000000
      00008F6130000000000000000000000000000000000000000000000000008F61
      3000000000008D5F2E00000000000000000000000000000000008F613000CB9D
      6C00C6986700B4865500B4865500B4865500B4865500B4865500B4865500A173
      42007D4F1E006537060000000000000000000000000000000000CB9D6C000064
      DF000064DF000062DE000064DF000064DF000064DF000064DF000064DF000060
      D6000053B8008C5E2D00000000000000000000000000000000008F613000F5C8
      98008E602F00D5A87800D5A87800D5A87800D5A87800D5A87800D5A87800BB8D
      5C00A173420071431200000000000000000000000000000000008F6130008F61
      3000000000000000000000000000000000000000000000000000000000000000
      00008F6130007C4E1D00000000000000000000000000000000008F613000B688
      570095673600855726008557260085572600855726008557260085572600784A
      19006537060065370600000000000000000000000000C7996800A6784700885A
      2900754716007042110070421100704211007042110070421100704211006E40
      0F006638070065370600653706000000000000000000000000008F613000D5A8
      7800AA7C4B009163320091633200916332009163320092643300926535008759
      2800714414006537060000000000000000000000000000000000895B2A007A4C
      1B007143120071431200000000000000000000000000000000008F613000895B
      2A00794B1A006B3D0C0000000000000000000000000000000000845625007345
      1400673908006537060065370600653706006537060065370600653706006537
      0600653706006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000845625007345
      1400673908006537060065370600653706006537060065370600653706006537
      0600653706006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000163DD800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000163DD800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A000000
      0000000000000000000000000000000000000000000000000000163DD8000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000163DD80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F6130008F61
      30000000000000000000000000000000000000000000000000008F6130008F61
      3000000000000000000000000000000000000000000000000000000000000000
      0000C99B6A008F6130008F6130008F6130008F6130008F6130008F613000C395
      640000000000000000000000000000000000000000000000000000000000163D
      D800000000000000000000000000000000000000000000000000000000000000
      0000163DD80000000000000000000000000000000000000000008F6130008F61
      30008F6130008E602F008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008F613000000000000000000000000000000000008F6130006DF1
      FF008F613000000000000000000000000000000000008F6130006DF1FF006DF1
      FF00794B1A00000000000000000000000000000000000000000000000000C99B
      6A008F6130008E602F00865827008A5C2B008F6130008F6130008F6130008A5C
      2B00B08251000000000000000000000000000000000000000000000000000000
      0000163DD800000000000000000000000000000000000000000000000000163D
      D8000000000000000000000000000000000000000000000000008F6130000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008658270000000000000000000000000000000000000000008F61
      30006DF1FF008E602F000000000000000000000000008F6130006DF1FF006DF1
      FF00663807000000000000000000000000000000000000000000C99B6A008F61
      30008F6130006DF1FF006DF1FF007B4D1C008052210083552400885A29008759
      2800805221009264330000000000000000000000000000000000000000000000
      000000000000163DD80000000000000000000000000000000000163DD8000000
      00000000000000000000000000000000000000000000000000008F6130000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008658270000000000000000000000000000000000000000000000
      00008A5C2B006DF1FF008F613000000000000000000000000000764817006537
      0600000000000000000000000000000000000000000000000000C99B6A008F61
      3000895B2A006DF1FF006DF1FF006DF1FF007C4E1D007A4C1B00815322008557
      26007C4E1D007D4F1E000000000000000000000000000000000046B7EF0046B7
      EF0046B7EF0046B7EF00163DD80046B7EF0046B7EF00163DD80046B7EF0046B7
      EF0046B7EF00328BB400000000000000000000000000000000008D5F2E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008A5C2B0000000000000000000000000000000000000000000000
      000000000000895B2A006DF1FF008F6130000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C99B6A008F61
      30008E602F00805221006DF1FF006DF1FF006DF1FF007B4D1C006DF1FF00895B
      2A007D4F1E00744615000000000000000000000000000000000046B7EF0046B7
      EF0046B7EF0044B4EB0046B7EF00163DD800163DD80046B7EF0046B7EF0046B7
      EF00328BB400185A7800000000000000000000000000000000008F6130000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F61300000000000000000000000000000000000000000000000
      000000000000000000008C5E2D006DF1FF008D5F2E0000000000000000000000
      0000000000000000000000000000000000000000000000000000C99B6A008F61
      30008F61300085572600825423006DF1FF006DF1FF006DF1FF006DF1FF008F61
      300082542300704211000000000000000000000000000000000046B7EF0046B7
      EF003CA4D600328BB40026769C000526A5000F30B400328BB400328BB4002669
      94000D445F00012D4200000000000000000000000000000000008F6130000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008F61300000000000000000000000000000000000000000000000
      00000000000000000000000000008D5F2E006DF1FF008C5E2D00000000000000
      0000000000000000000000000000000000000000000000000000C99B6A008F61
      30008F6130008658270080522100815322006DF1FF006DF1FF006DF1FF008F61
      300080522100673908000000000000000000000000000000000041ACE1002A7D
      A700185A780005364C00021A7700012D420005364C00021A77000D445F00012D
      4200012D4200012D4200000000000000000000000000000000008F6130000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008E602F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008A5C2B006DF1FF008E602F000000
      0000000000000000000000000000000000000000000000000000C99B6A008F61
      30008E602F00895B2A00855726006DF1FF006DF1FF006DF1FF006DF1FF008F61
      3000734514006537060000000000000000000000000000000000000000000000
      000000000000021A770000000000000000000000000000000000021A77000000
      00000000000000000000000000000000000000000000000000008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130007F51200000000000000000000000000000000000000000000000
      00008F6130008F613000000000000000000000000000895B2A006DF1FF008D5F
      2E0000000000000000000000000000000000000000000000000000000000B486
      55008557260085572600865827008D5F2E008F6130008F6130008F6130007D4F
      1E00653706000000000000000000000000000000000000000000000000000000
      000007249A000000000000000000000000000000000000000000000000000724
      9A000000000000000000000000000000000000000000000000008F6130008F61
      30008F6130008D5F2E008F6130008F6130008F6130008F6130008F613000895B
      2A00794B1A006B3D0C0000000000000000000000000000000000000000008F61
      30006DF1FF006DF1FF00794B1A00000000000000000000000000895B2A006DF1
      FF00865827000000000000000000000000000000000000000000000000000000
      0000A17342007A4C1B00794B1A007D4F1E008254230080522100724413006537
      0600000000000000000000000000000000000000000000000000000000001236
      C400000000000000000000000000000000000000000000000000000000000000
      00001236C400000000000000000000000000000000000000000086582700784A
      19006D3F0E00693B0A006A3C0B006A3C0B006A3C0B006A3C0B00693B0A006638
      0700653706006537060000000000000000000000000000000000000000008F61
      30006DF1FF006DF1FF0065370600000000000000000000000000000000008254
      23006DF1FF007547160000000000000000000000000000000000000000000000
      00000000000084562500724413006A3C0B006739080065370600653706000000
      0000000000000000000000000000000000000000000000000000163DD8000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000153BD10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000744615006537060000000000000000000000000000000000000000000000
      0000724413006B3D0C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000153BD100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000F30B400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008B5D2C00000000000000000000000000000000008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008B5D2C00000000000000000000000000000000008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008B5D2C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F613000C99B
      6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B
      6A00C99B6A007D4F1E00000000000000000000000000000000008F6130008F61
      30008F613000C99B6A00B4865500A67847009E703F00A6784700C0926100C99B
      6A00C99B6A007D4F1E00000000000000000000000000000000008F613000C99B
      6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B
      6A00C09261007B4D1C0000000000000000000000000000000000000000000000
      000000000000C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A000000
      00000000000000000000000000000000000000000000000000008F613000C99B
      6A00000000000000000000000000000000000000000000000000000000006DF1
      FF00B385540073451400000000000000000000000000000000008F6130008F61
      30000062DA007D4F1E0000000000000000000000000000000000000000000000
      0000BB8D5C0075471600000000000000000000000000000000008F613000C99B
      6A0000000000B98B5A00815322007F5120008052210085572600B38554000000
      0000A17342007244130000000000000000000000000000000000000000000000
      0000C99B6A008F6130008F6130008F6130008F6130008F6130008F613000C597
      66000000000000000000000000000000000000000000000000008F613000C99B
      6A0000000000D7C17B00D7C17B00D7C17B00C4AF6A00C4AF6A00D7C17B006DF1
      FF00B789580073451400000000000000000000000000000000008F613000C496
      65007B4D1C00023B8800784A1900000000000000000000000000000000000000
      0000C99B6A0076481700000000000000000000000000000000008F613000C99B
      6A0000000000A6784700754716006DF1FF006DF1FF0081532200AC7E4D000000
      0000A1734200704211000000000000000000000000000000000000000000C99B
      6A008F6130008F613000845625007D4F1E00875928008F6130008F6130008D5F
      2E00B082510000000000000000000000000000000000000000008F613000C99B
      6A0000000000D7C17B00AA573700D7C17B000000000000000000D7C17B006DF1
      FF00C294630075471600000000000000000000000000000000008F613000AE80
      4F0000000000774918000053B800895B2A000000000000000000000000000000
      0000C99B6A00784A1900000000000000000000000000000000008F613000C99B
      6A0000000000AE804F00784A19006DF1FF006DF1FF008F613000C59766000000
      0000AE804F007446150000000000000000000000000000000000C99B6A008F61
      30008F613000855726006F4110006DF1FF006DF1FF008F6130008F6130008E60
      2F007F51200091633200000000000000000000000000000000008F613000C99B
      6A0000000000D7C17B00D7C17B00C4AF6A00A48F4D00C4AF6A00D7C17B006DF1
      FF00C395640076481700000000000000000000000000000000008F613000A173
      4200000000000000000086582700015DD000855726000064DF000064DF008F61
      3000C99B6A0075471600000000000000000000000000000000008F613000C99B
      6A0000000000BA8C5B00805221006DF1FF006DF1FF008F613000C99B6A000000
      0000B48655007547160000000000000000000000000000000000C99B6A008F61
      30008F6130007B4D1C006E400F006DF1FF006DF1FF008F6130008F6130008F61
      30007A4C1B007B4D1C00000000000000000000000000000000008F613000C99B
      6A0000000000D7C17B00A14E2E00A48F4D00000000006DF1FF00D7C17B006DF1
      FF00C294630076481700000000000000000000000000000000008F613000AC7E
      4D0000000000000000000000000085572600023B88006DF1FF006DF1FF000064
      DF008C5E2D0072441300000000000000000000000000000000008F613000C99B
      6A0000000000C5976600885A29006DF1FF006DF1FF008F613000C99B6A000000
      0000B78958007648170000000000000000000000000000000000C99B6A008F61
      30008F6130007B4D1C00754716006DF1FF006DF1FF008F6130008F6130008F61
      3000764817006E400F00000000000000000000000000000000008F613000C99B
      6A0000000000D7C17B00C4AF6A00B29C5900B29C5900C4AF6A00D7C17B006DF1
      FF00C99B6A0077491800000000000000000000000000000000008F613000C698
      67000000000000000000000000000064DF006DF1FF006DF1FF006DF1FF006DF1
      FF000064DF0073451400000000000000000000000000000000008F613000C99B
      6A0000000000C99B6A008F6130006DF1FF006DF1FF008F613000C99B6A000000
      0000BB8D5C007547160000000000000000000000000000000000C99B6A008F61
      30008F613000805221007D4F1E006DF1FF006DF1FF008F6130008F6130008C5E
      2D007345140065370600000000000000000000000000000000008F613000C99B
      6A00000000000000000000000000000000006DF1FF006DF1FF006DF1FF006DF1
      FF00C99B6A0076481700000000000000000000000000000000008F613000C99B
      6A000000000000000000000000000064DF006DF1FF006DF1FF006DF1FF006DF1
      FF000064DF0076481700000000000000000000000000000000008F613000C99B
      6A0000000000C99B6A008F6130008F6130008F6130008F613000C99B6A000000
      0000BB8D5C007446150000000000000000000000000000000000C99B6A008F61
      30008F61300084562500835524008F6130008F6130008F6130008F6130008456
      25006B3D0C0065370600000000000000000000000000000000008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008D5F2E0072441300000000000000000000000000000000008F6130008F61
      30008F6130008F6130008F6130008F6130000064DF006DF1FF006DF1FF000064
      DF008F61300075471600000000000000000000000000000000008F6130008F61
      30008F6130008F6130008F6130006DF1FF006DF1FF008F6130008F6130008F61
      3000855726007042110000000000000000000000000000000000C99B6A008F61
      30008D5F2E00885A29008A5C2B006DF1FF006DF1FF008F6130008F6130007547
      16006537060065370600000000000000000000000000000000008F613000C99B
      6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B
      6A00AA7C4B006B3D0C00000000000000000000000000000000008F613000C99B
      6A00C99B6A00C99B6A00C99B6A00C99B6A008F6130000064DF000064DF008F61
      3000C49665006F411000000000000000000000000000000000008F613000C99B
      6A00C99B6A00C99B6A008F6130008F6130008F6130008F613000C99B6A00C99B
      6A009E703F006B3D0C000000000000000000000000000000000000000000B486
      55008557260085572600885A29008F6130008F6130008F6130007A4C1B006537
      06006537060000000000000000000000000000000000000000008F613000C99B
      6A00C99B6A00C4966500C7996800C99B6A00C99B6A00C99B6A00C89A6900B284
      5300885A290065370600000000000000000000000000000000008F613000C99B
      6A00C99B6A00C3956400C4966500C4966500C89A6900C99B6A00C99B6A00C99B
      6A009567360066380700000000000000000000000000000000008F613000C99B
      6A00C99B6A00B98B5A00BD905F00C5976600C99B6A00C99B6A00C3956400AA7C
      4B00835524006537060000000000000000000000000000000000000000000000
      0000A17342007A4C1B00794B1A007A4C1B007A4C1B0072441300653706006537
      06000000000000000000000000000000000000000000000000008F6130008658
      2700794B1A007244130072441300724413007244130072441300724413006D3F
      0E006537060065370600000000000000000000000000000000008F6130008658
      2700794B1A007244130072441300734514007446150076481700774918007143
      12006537060065370600000000000000000000000000000000008F6130008658
      2700794B1A007345140074461500764817007749180076481700744615006E40
      0F00653706006537060000000000000000000000000000000000000000000000
      0000000000008456250072441300693B0A006537060065370600653706000000
      0000000000000000000000000000000000000000000000000000845625007345
      1400673908006537060065370600653706006537060065370600653706006537
      0600653706006537060000000000000000000000000000000000845625007345
      1400673908006537060065370600653706006537060065370600653706006537
      0600653706006537060000000000000000000000000000000000845625007345
      1400673908006537060065370600653706006537060065370600653706006537
      0600653706006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000163DD800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000163DD8000000000000000000163DD800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000163DD8000000000000000000000000008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130008B5D2C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000163DD800C99B
      6A00000000000000000000000000000000000000000000000000000000000000
      000000000000163DD80000000000000000000000000000000000163DD8000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000163DD800000000000000000000000000000000008F613000C99B
      6A00C2946300B0825100BA8C5B00C4966500C5976600C89A6900C99B6A00C99B
      6A00C89A69007D4F1E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDD6AD00163D
      D800C99B6A000000000000000000000000000000000000000000000000000000
      0000163DD800000000000000000000000000000000000000000000000000163D
      D800002DDF00002AD10000000000000000000000000000000000002DDF00002D
      DF00163DD80000000000000000000000000000000000000000008F613000C092
      6100000000000000000000000000000000000000000000000000000000006DF1
      FF00B38554007446150000000000000000000000000000000000000000000000
      00008F6130008F6130008F6130008F6130008F6130008F6130008E602F008B5D
      2C0000000000000000000000000000000000000000000000000000000000F4CC
      A300153BD100C99B6A000000000000000000000000000000000000000000163D
      D80000000000000000000000000000000000000000000000000000000000002D
      DF00163DD800000000000000000000000000000000000000000000000000163D
      D8000028C30000000000000000000000000000000000000000008F613000AA7C
      4B0000000000023B8800000000000158C6000053B8000053B8000158C6006DF1
      FF00B98B5A007446150000000000000000000000000000000000000000000000
      00008F61300000BAE90000BAE90000BAE90000BAE90000BAE90000BAE900885A
      2900000000000000000000000000000000000000000000000000000000000000
      0000F0C89F00163DD80000000000916332009163320090623100163DD8009163
      320000000000000000000000000000000000000000000000000000000000002D
      DF00015DD0000526A50000000000000000000000000000000000163DD8000062
      DE0007249A0000000000000000000000000000000000000000008F613000B284
      53000000000000000000000000000000000000000000000000006DF1FF006DF1
      FF00C99B6A00784A190000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000163DD800C99B6A00C99B6A00153BD100C0926100C496
      6500885A2900000000000000000000000000000000000000000000000000002D
      DF000158C600000000001236C4000000000000000000163DD800000000000064
      DF0007249A0000000000000000000000000000000000000000008F613000B486
      5500000000000053B800000000000064DF000064DF000064DF000064DF006DF1
      FF00C99B6A007A4C1B000000000000000000000000000049EB000049EB000049
      EB000049EB000049EB000049EB000049EB000049EB000048E7000047E4000048
      E7000047E4000043D500003CC000000000000000000000000000000000000000
      00000000000091633200C99B6A001236C40004218B000000000000000000BA8C
      5B00B98B5A007D4F1E000000000000000000000000000000000000000000002D
      DF00015DD0000000000000000000163DD800163DD80000000000000000000064
      DF0007249A0000000000000000000000000000000000000000008F613000BD90
      5F0000000000000000000000000000000000000000006DF1FF006DF1FF006DF1
      FF00C99B6A007A4C1B000000000000000000000000000049EB000049EB000048
      E7000049EB000049EB000049EB000049EB000049EB000047E4000043D500003A
      B9000439990004218B0002307400000000000000000000000000000000000000
      00000000000091633200C99B6A0004218B00021A770000000000000000000000
      0000C79968007A4C1B000000000000000000000000000000000000000000002D
      DF000060D60000000000000000001236C4001236C40000000000000000000062
      DE000526A50000000000000000000000000000000000000000008F613000C99B
      6A00000000000064DF00000000000064DF000064DF000064DF000064DF006DF1
      FF00C99B6A007A4C1B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000916332001236C40000000000000000000F30B400000000000000
      0000C99B6A00784A19000000000000000000000000000000000000000000002D
      DF00015DD0000000000007249A000000000000000000163DD800000000000062
      DE000526A50000000000000000000000000000000000000000008F613000C99B
      6A00000000000000000000000000000000006DF1FF006DF1FF006DF1FF006DF1
      FF00C99B6A007749180000000000000000000000000000000000000000000000
      00008E602F0000BAE90000A6CF00009CC300009CC300008CAF00016B85006B3D
      0C00000000000000000000000000000000000000000000000000000000000000
      000000000000163DD800C0926100000000000000000000000000163DD8000000
      0000C99B6A00734514000000000000000000000000000000000000000000002D
      DF000158C60004218B0000000000000000000000000000000000163DD8000064
      DF000526A50000000000000000000000000000000000000000008F6130008F61
      30008F6130008F6130008F6130008F6130008F6130008F6130008F6130008F61
      30008F6130007345140000000000000000000000000000000000000000000000
      0000885A29007F5120007648170072441300724413006F4110006A3C0B006739
      0800000000000000000000000000000000000000000000000000000000000000
      0000163DD80091633200C0926100C0926100000000000000000000000000163D
      D800AE804F006D3F0E000000000000000000000000000000000000000000002D
      DF000F30B400000000000000000000000000000000000000000000000000163D
      D8000526A50000000000000000000000000000000000000000008F613000C99B
      6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B
      6A00AA7C4B006B3D0C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000163D
      D800000000000000000083552400B4865500C7996800C99B6A00C99B6A00AA7C
      4B0004218B00000000000000000000000000000000000000000000000000163D
      D800023B88000000000000000000000000000000000000000000000000000062
      DA000526A50000000000000000000000000000000000000000008F613000C99B
      6A00C99B6A00C4966500C7996800C99B6A00C99B6A00C99B6A00C89A6900B284
      5300885A29006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000163DD8000000
      0000000000000000000000000000794B1A007648170074461500704211006A3C
      0B0000000000021A770000000000000000000000000000000000163DD8000024
      B100021A7700021A770000000000000000000000000000000000002CDB000024
      B10004218B0004218B00000000000000000000000000000000008F6130008658
      2700794B1A007244130072441300724413007244130072441300724413006D3F
      0E00653706006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000153BD100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000526A5000000000000000000153BD100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000007249A00000000000000000000000000845625007345
      1400673908006537060065370600653706006537060065370600653706006537
      0600653706006537060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C99B6A00C99B6A00C99B
      6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B6A00C99B
      6A00C99B6A00C99B6A00B08251000000000000000000000000008F6130008F61
      30008F6130008F6130008F6130008F6130008F613000885A2900885A2900885A
      2900885A29000000F60000000000000000000000000000000000885A2900885A
      2900885A2900885A2900885A2900885A2900885A2900885A2900885A2900885A
      2900885A29008557260000000000000000000000000000000000885A2900885A
      2900885A2900885A2900885A2900885A2900885A2900885A2900885A2900885A
      2900885A2900855726000000000000000000000000003768000033610000305A
      0000305A00000000000000000000000000000000000000000000000000003361
      0000305A00002C5201002C5201000000000000000000000000008F6130000000
      000000000000000000000000000000000000000000000000000000000000AA57
      37000000F6000000CD0000000000000000000000000000000000885A29000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B4D1C0000000000000000000000000000000000885A29000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B4D1C0000000000000000000000000000000000000000000000
      000000000000305A000000000000000000000000000000000000305A00000000
      00000000000000000000000000000000000000000000000000008F6130000000
      0000FBD9B300FBD9B300FBD9B300FBD9B300FBD9B300FBD9B30000000000A754
      3400000000007345140000000000000000000000000000000000885A29000000
      000059C9F10059C9F10059C9F10059C9F10059C9F10059C9F10059C9F10054C1
      E80000000000794B1A0000000000000000000000000000000000885A29000000
      000045C1520045C1520045C1520045C1520045C1520045C1520045C152003BB0
      470000000000794B1A0000000000000000000000000000000000000000000000
      0000000000000000000037680000000000000000000037680000000000000000
      00000000000000000000000000000000000000000000000000008F6130000000
      0000FBD9B300FBD9B300FBD9B300FBD9B300E3B98C00B7946D0000000000A14E
      2E00000000007547160000000000000000000000000000000000000000000000
      00000000000000000000000000000000000059C9F10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000045C15200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000037680000000000000000000037680000000000000000
      00000000000000000000000000000000000000000000000000008F6130000000
      0000FBD9B30000000000FBD9B300D5AF8600B7946D009C79520000000000A451
      3100000000007B4D1C00000000000000000000000000000000000064DF000064
      DF000064DF000064DF000064DF000064DF00000000000064DF000064DF000064
      DF000158C600004CA80000000000000000000000000000000000376800003768
      0000376800003768000000000000376800003768000037680000376800000000
      0000376800003361000000000000000000000000000000000000000000000000
      0000000000000000000000000000376800003768000000000000000000000000
      00000000000000000000000000000000000000000000000000008F6130000000
      000000000000AA57370000000000D5AF8600B7946D000000000000000000AA57
      3700000000007D4F1E0000000000000000000000000000000000885A29000000
      000059C9F10059C9F10059C9F1000064DF00000000000064DF0059C9F1004DB3
      D800000000007446150000000000000000000000000000000000885A29000000
      000045C1520037680000000000003768000045C1520045C15200376800003361
      000000000000794B1A00000000000000000000000000C99B6A00C99B6A00C99B
      6A00C99B6A00C99B6A00C99B6A00C2946300B0825100B7895800C99B6A00C99B
      6A00C99B6A00C99B6A00BB8D5C000000000000000000000000008F6130000000
      0000AA573700AA573700AA5737000000000000000000A754340000000000AA57
      3700000000007D4F1E0000000000000000000000000000000000885A29000000
      000059C9F10059C9F10059C9F1000062DA00000000000062DA0059C9F100328B
      B400000000007244130000000000000000000000000000000000885A29000000
      000045C1520037680000376800003768000045C1520045C152003BB047002B93
      3500000000007547160000000000000000000000000037680000000000003361
      0000305A0000305A00002C5201002C5201000000000000000000000000003361
      0000305A00002C5201002C520100000000000000000000000000000000000000
      0000AA573700AA573700AA573700AA573700AA573700AA57370000000000A754
      3400000000007C4E1D0000000000000000000000000000000000885A29000000
      000059C9F10059C9F10054C1E800015DD0000062DA000060D6003B9CC6001E64
      8300000000007042110000000000000000000000000000000000885A29000000
      000045C1520045C152003361000045C152003BB047002B9335001F7E2900176F
      2000000000007143120000000000000000000000000000000000305A00000000
      0000000000000000000000000000000000002C520100000000002C5201000000
      0000000000000000000000000000000000000000000000000000AA573700AA57
      3700AA573700FDD6AD00A14E2E00A14E2E00A4513100A14E2E00A14E2E00A14E
      2E00000000007C4E1D0000000000000000000000000000000000885A29000000
      000059C9F10050B9DF003B9CC600328BB4000053B800328BB400266994001E64
      8300000000007446150000000000000000000000000000000000885A29000000
      000045C1520045C152003BB047002B9335002B9335001F7E2900176F2000176F
      2000000000007446150000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000305A0000000000000000
      0000000000000000000000000000000000000000000000000000AA573700AA57
      3700A14E2E00A6825B009C7952009C795200A6825B0094412100944121009845
      2500000000007A4C1B0000000000000000000000000000000000885A29000000
      000050B9DF00328BB40026769C001E6483001E648300185A7800185A78001E64
      8300000000007547160000000000000000000000000000000000885A29000000
      00003BB047002B9335001F7E2900176F2000176F200013681B0013681B00176F
      2000000000007547160000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F6130000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007648170000000000000000000000000000000000885A29000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007244130000000000000000000000000000000000885A29000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007244130000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000855726007749
      1800714312007042110072441300724413007244130072441300744615007547
      1600734514007042110000000000000000000000000000000000845625007B4D
      1C00764817007244130072441300704211007042110070421100714312007345
      1400714312006E400F0000000000000000000000000000000000845625007B4D
      1C00764817007244130072441300704211007042110070421100714312007345
      1400714312006E400F00000000000000000000000000C99B6A00C99B6A00C99B
      6A00C99B6A00C99B6A00C99B6A00C89A6900C5976600C3956400C3956400C597
      6600C2946300BA8C5B00AE804F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000000100000100010000000000000800000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FE1FFFFFFFFFFFFFF807FFFFFFFFFFFFF003FFFFFFFFFFFFF003FFFFFFFFFFFF
      E001FFFFFFFFFFFFE001FFFFFFFFFFFFE001FFFFFFFFFFFFE001FFFFFFFFFFFF
      F003FFFFFFFFFFFFF003FFFFFFFFFFFFF807FFFFFFFFFFFFFE1FFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF87FE7FFFFF
      F83FEF03FE4FFFFFF01FFE01FBCFE09FE7CFA801FFFFE01FCFE7FE01CFF3F03F
      CFE7EE01CFF3F83FCFE7EF03FFFFF81FCEE7EF87CFF3F00FC4EFEFF7CFF3F307
      E0FFFFFFFFFFFF87F0FFA815F3CFFFC7E0FFFFFFF24FFFE7C0FFEFF7FE7FFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFC3FF9FFF18FC003F00FF8FFF18FC003E007F87FF18FC003E007F83FF18F
      C003C003F81FF18FF7FFC003F80FF18FE7FFC003F80FF18FC03FC003F81FF18F
      C03FE007F83FF18FE7FFE007F87FF18FF7FFF00FF8FFF18FFFFFFC3FF9FFF18F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8001BFFDFFFFFFFF
      8001DFFBFFFFFFFF8001EFF7C003C0038001F00FC003C0038001F00FC003C003
      8001F00FC003C0038001F00FF7EFFFEF8001F00FE7E7FFE78001F00FC003FC03
      8001F00FC003FC038001F00FE7E7FFE78001EFF7F7EFFFEF8001DFFBFFFFFFFF
      8001BFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF800180018001
      83FF80018001800183FF80018001800183FF80018001800180FF800180018001
      80FF80018001800180FF80018001800180078001800180018007800180018001
      8007800180018001800180018001800180018001800180018001800180018001
      8001800180018001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FDFFFC3FFC3F83FFFEFFF81FF81F83FFFE7FF00FF00F83FFF81FE207E00780FF
      F00FFD07E00780FFE007C087E00780FFC003C087E0078007C003FD07E0078007
      C003E207E0078007E007E007E0078001F00FE007E0078001F81FE007E0078001
      FFFFFFFFFFFF8001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      C3C3FFFFE007C3FFC3C3F18FE007C3FFC003F7EFE007C07FC003F7EFF00FC05F
      C003C003FC3FC04FC003C003FE7FC007C003C003FE7FC007C003C003FC3FC04F
      C003F7EFF00FC05FC003F7EFE007C07FC003F18FE007C07FC003FFFFE007C07F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003FFFF
      83FF83FFC003FFFF83FF83FFC003E00783FF83FFF81FC00380FF80FFC003C003
      80FF80FFC003C00380FF80FFC003C00380078007C003C00380078007C003C003
      80078007C003C00380018001C023C00380018001C003E00380018001C003FFFF
      80018001C003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7FFFFF
      FFFFEFF7FC3FFFFFE3C7FFFFFC3FE007E7E7A815FC3FE007E7E7FFFFFC3FE007
      E7E7EFF7F81FE007E7E7EFF7F00FE007E7E7EFF7E007E007E7E7EFF7E007E007
      E7E7FFFFE007E007E7E7A815E007F3CFE7E7FFFFE007F3CFE3C7EFF7F00FF99F
      FFFFFFFFF81FFC3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFF87FFF3
      FFFF9FFF9F039F01E7E78FFF8E018F01E3C7C7FFC601C7F3F18FE41FE401E417
      F81FF80FF801F80FFC3FF007F003F007FC3FF007F007F007F81FF007F007F007
      F18FF007F007F007E3C7F007F007F007E7E7F80FF80FF80FFFFFFC1FFC1FFC1F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      C3C3C3C39FF9C007CFF3C3C3FFFFC003D7EBC0038001C003DBDBC003C003C003
      FDBFC0038001F007FE7FC003FFFFF007FE7FC0039FF9E007FDBFC003FFFFC00F
      DBDBC0038001C007D7EBC003C003C003CFF3C0038001C003C3C3C003FFFFC003
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFDFFFFFFFF
      F81FDFFBFFFFCFCFF00FEFF7C003C787E007F7EFDFFBE387C003FBDFDFFBF1CF
      C003C003DFFBF8FFC003C003DFFBFC7FC003C003DFFBFE3FC003C003DFFBFF1F
      C003FBDFC003F38FE007F7EFC003E1C7F00FEFF7C003E1E3F81FDFFBFFFFF3F3
      FFFFBFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003C003C003FFFF
      C003C003C003F81FCFE3C3F3C813F00FC803C1F3C813E007C8C3C8F3C813C003
      C803CC03C813C003C883CE03C813C003C803CE03C813C003CF03CE03C813C003
      C003C003C003C003C003C003C003E007C003C003C003F00FC003C003C003F81F
      C003C003C003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFDBFFDC003
      FFFFCFFBDFFBC003FFFFC7F7E3C7CFE3F00FE3EFE7E7CA03F00FF20FE3C7CFC3
      FFFFFC07E5A7CA038001F863E667CF838001F873E667CA03FFFFF9B3E5A7CF03
      F00FF9D3E3C7C003F00FF0E3E7E7C003FFFFEC07E7E7C003FFFFDE0BC3C3C003
      FFFFBFFDBFFDC003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8001
      C003C003C00387E1DFE3DFFBDFFBFBDFD02BD00BD00BFDBFD02BFF7FFDFFFDBF
      D42BC083C213FE7FDA6BD08BD20B8001D1ABD08BD00BA0E1F02BD00BD00BDF5F
      C00BD00BD00BFFBFC00BD00BD00BFFFFDFFBDFFBDFFBFFFFC003C003C0038001
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupFilter: TPopupMenu
    OnPopup = PopupFilterPopup
    Left = 622
    Top = 272
    object ResetFilter1: TMenuItem
      Caption = 'Reset DefaultFilter'
      OnClick = ResetFilter1Click
    end
    object SaveFilter1: TMenuItem
      Caption = 'Save Filter'
      OnClick = SaveFilter1Click
    end
    object RenameFilter1: TMenuItem
      Caption = 'Rename Filter'
      OnClick = RenameFilter1Click
    end
    object DeleteFilter1: TMenuItem
      Caption = 'Delete Filter'
      OnClick = DeleteFilter1Click
    end
  end
  object StatPopup: TPopupMenu
    AutoPopup = False
    Images = imagelist1
    OnPopup = StatPopupPopup
    Left = 612
    Top = 116
    object Stat_SetFocus: TMenuItem
      Caption = 'Toggle focus'
      ImageIndex = 33
      OnClick = Stat_SetFocusClick
    end
    object CheckUnitOnWeb2: TMenuItem
      Caption = 'CheckUnitOnWeb'
      ImageIndex = 26
      OnClick = CheckUnitOnWeb2Click
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object ResetFullFilter4: TMenuItem
      Caption = 'Reset FullFilter'
      ImageIndex = 5
      OnClick = ResetFullFilter4Click
    end
    object ResetFocus4: TMenuItem
      Caption = 'Reset Focus'
      ImageIndex = 13
      OnClick = gfx_ResetFocusClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object ExpandAll1: TMenuItem
      Caption = 'ExpandAll'
      OnClick = ExpandAll1Click
    end
    object CollapseAll1: TMenuItem
      Caption = 'CollapseAll'
      OnClick = CollapseAll1Click
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.wcr'
    Filter = 'WcrLog (*.wcr) | *.wcr'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 541
    Top = 190
  end
  object HintTimer: TTimer
    Interval = 500
    OnTimer = HintTimerTimer
    Left = 573
    Top = 62
  end
  object ChatPopup: TPopupMenu
    Left = 292
    Top = 268
    object BlackList1: TMenuItem
      Caption = 'send to BlackList'
      OnClick = BlackList1Click
    end
    object ApplyBlackList1: TMenuItem
      Caption = 'ApplyBlackList'
      OnClick = ApplyBlackList1Click
    end
  end
  object BlPopup: TPopupMenu
    Left = 653
    Top = 118
    object DeleteEntry1: TMenuItem
      Caption = 'DeleteEntry'
      OnClick = DeleteEntry1Click
    end
    object ClearList1: TMenuItem
      Caption = 'ClearList'
      OnClick = ClearList1Click
    end
  end
  object LiveUpdateTimer: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = LiveUpdateTimerTimer
    Left = 524
    Top = 60
  end
  object MenuCompare: TPopupMenu
    Left = 373
    Top = 256
    object AddRaidGfx1: TMenuItem
      Caption = 'AddRaidLine'
      OnClick = AddRaidGfx1Click
    end
    object EditLine1: TMenuItem
      Caption = 'EditLine'
      OnClick = EditLine1Click
    end
    object Supprimer1: TMenuItem
      Caption = 'Remove'
      OnClick = Supprimer1Click
    end
    object Clear1: TMenuItem
      Caption = 'ClearList'
      OnClick = Clear1Click
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object Load1: TMenuItem
      Caption = 'Load'
      OnClick = Load1Click
    end
    object Save1: TMenuItem
      Caption = 'Save'
      OnClick = Save1Click
    end
  end
  object LoadMenu1: TPopupMenu
    Images = imagelist1
    Left = 461
    Top = 118
    object LoadLog3: TMenuItem
      Caption = 'LoadLog'
      ImageIndex = 17
      OnClick = LoadLog3Click
    end
    object LoadLiveLog1: TMenuItem
      Caption = 'LoadLiveLog'
      ImageIndex = 17
      OnClick = LoadLiveLog1Click
    end
    object N15: TMenuItem
      Caption = '-'
    end
    object LogIndex: TMenuItem
      Caption = 'LogIndex'
      ImageIndex = 17
      OnClick = LogIndexClick
    end
  end
  object menu_detailmode: TPopupMenu
    Images = imagelist1
    OnPopup = menu_detailmodePopup
    Left = 101
    Top = 174
    object gfxDetail0: TMenuItem
      AutoCheck = True
      Caption = 'View List'
      Checked = True
      ImageIndex = 12
      RadioItem = True
      ShortCut = 112
      OnClick = gfxDetail1Click
    end
    object gfxDetail1: TMenuItem
      AutoCheck = True
      Caption = 'Event Out'
      ImageIndex = 41
      RadioItem = True
      ShortCut = 113
      OnClick = gfxDetail1Click
    end
    object gfxDetail2: TMenuItem
      AutoCheck = True
      Caption = 'Event In'
      ImageIndex = 42
      RadioItem = True
      ShortCut = 114
      OnClick = gfxDetail1Click
    end
    object gfxDetail3: TMenuItem
      AutoCheck = True
      Caption = 'Aura Casted'
      ImageIndex = 43
      RadioItem = True
      ShortCut = 115
      OnClick = gfxDetail1Click
    end
    object gfxDetail4: TMenuItem
      AutoCheck = True
      Caption = 'Aura Gained'
      ImageIndex = 44
      RadioItem = True
      ShortCut = 116
      OnClick = gfxDetail1Click
    end
  end
  object ActionList1: TActionList
    Left = 30
    Top = 62
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 113
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = 'Action2'
      ShortCut = 114
      OnExecute = Action2Execute
    end
    object Action3: TAction
      Caption = 'Action3'
      ShortCut = 115
      OnExecute = Action3Execute
    end
    object Action4: TAction
      Caption = 'Action4'
      ShortCut = 116
      OnExecute = Action4Execute
    end
    object Action5: TAction
      Caption = 'Action5'
      ShortCut = 112
      OnExecute = Action5Execute
    end
    object Action6: TAction
      Caption = 'Action6'
      SecondaryShortCuts.Strings = (
        'i')
      OnExecute = Action6Execute
    end
    object Action7: TAction
      Caption = 'Action7'
      SecondaryShortCuts.Strings = (
        'l')
      OnExecute = Action7Execute
    end
  end
  object menu_focusmode: TPopupMenu
    Images = imagelist1
    Left = 102
    Top = 238
    object focusmode01: TMenuItem
      Caption = 'FocusMode: Source-Dest events'
      ImageIndex = 46
      OnClick = focusmode01Click
    end
    object focusmode11: TMenuItem
      Caption = 'FocusMode: Source events'
      ImageIndex = 47
      OnClick = focusmode01Click
    end
    object focusmode21: TMenuItem
      Caption = 'FocusMode: Dest events'
      ImageIndex = 48
      OnClick = focusmode01Click
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    OnIdle = ApplicationEvents1Idle
    Left = 94
    Top = 62
  end
  object imagelist3: TImageList
    Left = 494
    Top = 190
  end
  object replayTimer: TTimer
    Enabled = False
    Interval = 20
    OnTimer = replayTimerTimer
    Left = 208
    Top = 96
  end
  object replayPopup: TPopupMenu
    Left = 392
    Top = 408
    object play111: TMenuItem
      Tag = 100
      Caption = 'play 1:1'
      RadioItem = True
      OnClick = play111Click
    end
    object play211: TMenuItem
      Tag = 50
      Caption = 'play 2:1'
      RadioItem = True
      OnClick = play111Click
    end
    object playx41: TMenuItem
      Tag = 20
      Caption = 'play 5:1'
      Checked = True
      RadioItem = True
      OnClick = play111Click
    end
    object playx101: TMenuItem
      Tag = 10
      Caption = 'play 10:1'
      RadioItem = True
      OnClick = play111Click
    end
  end
  object replayPopupRotate: TPopupMenu
    Left = 472
    Top = 408
    object rotate01: TMenuItem
      Tag = 90
      Caption = 'rotate: 0'
      Checked = True
      RadioItem = True
      OnClick = rotate01Click
    end
    object rotate901: TMenuItem
      Tag = 180
      Caption = 'rotate: 90'
      RadioItem = True
      OnClick = rotate01Click
    end
    object rotate1801: TMenuItem
      Tag = 270
      Caption = 'rotate: 180'
      RadioItem = True
      OnClick = rotate01Click
    end
    object rotate2701: TMenuItem
      Caption = 'rotate: 270'
      RadioItem = True
      OnClick = rotate01Click
    end
  end
end
