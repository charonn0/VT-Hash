#tag Window
Begin Window SettingsWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   HasFullScreenButton=   False
   Height          =   552
   ImplicitInstance=   True
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   1399283711
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   1
   Resizeable      =   False
   Title           =   "VT Hash Check - Settings"
   Visible         =   True
   Width           =   432
   Begin GroupBox ResultsSettingsGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Results"
      Enabled         =   True
      Height          =   223
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   5
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   178
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   419
      Begin GroupBox LogResultsGrp
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Save logs to"
         Enabled         =   False
         Height          =   60
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ResultsSettingsGroup"
         Italic          =   False
         Left            =   17
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   222
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   399
         Begin TextField LogFile
            AcceptTabs      =   False
            Alignment       =   0
            AutoDeactivate  =   True
            AutomaticallyCheckSpelling=   False
            BackColor       =   &cFFFFFF00
            Bold            =   False
            Border          =   True
            CueText         =   ""
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Format          =   ""
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "LogResultsGrp"
            Italic          =   False
            Left            =   28
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   True
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   0
            TabIndex        =   0
            TabPanelIndex   =   0
            TabStop         =   True
            Text            =   ""
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   250
            Transparent     =   False
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   285
         End
         Begin PushButton BrowseBtn
            AutoDeactivate  =   True
            Bold            =   False
            ButtonStyle     =   0
            Cancel          =   False
            Caption         =   "Browse..."
            Default         =   False
            Enabled         =   True
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "LogResultsGrp"
            Italic          =   False
            Left            =   343
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   0
            TabIndex        =   2
            TabPanelIndex   =   0
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   250
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   63
         End
      End
      Begin ComboBox ResultsSortSelect
         AutoComplete    =   False
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "ResultsSettingsGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   62
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   197
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   145
      End
      Begin Label ResultsSortLbl
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ResultsSettingsGroup"
         Italic          =   False
         Left            =   17
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Sort:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   198
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   42
      End
      Begin GroupBox SearchEngineSettingsGroup
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Search engine"
         Enabled         =   True
         Height          =   110
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ResultsSettingsGroup"
         Italic          =   False
         Left            =   17
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   284
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   399
         Begin TextField SearchURL
            AcceptTabs      =   False
            Alignment       =   0
            AutoDeactivate  =   True
            AutomaticallyCheckSpelling=   False
            BackColor       =   &cFFFFFF00
            Bold            =   False
            Border          =   True
            CueText         =   "http://example.com/?q=%PARAMETER%"
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Format          =   ""
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "SearchEngineSettingsGroup"
            Italic          =   False
            Left            =   98
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   0
            TabIndex        =   1
            TabPanelIndex   =   0
            TabStop         =   True
            Text            =   "https://encrypted.google.com/search?q=%PARAMETER%"
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   310
            Transparent     =   False
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   311
         End
         Begin TextField SearchDisplayName
            AcceptTabs      =   False
            Alignment       =   0
            AutoDeactivate  =   True
            AutomaticallyCheckSpelling=   False
            BackColor       =   &cFFFFFF00
            Bold            =   False
            Border          =   True
            CueText         =   ""
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Format          =   ""
            Height          =   22
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "SearchEngineSettingsGroup"
            Italic          =   False
            Left            =   98
            LimitText       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Mask            =   ""
            Password        =   False
            ReadOnly        =   False
            Scope           =   0
            TabIndex        =   3
            TabPanelIndex   =   0
            TabStop         =   True
            Text            =   "Google"
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   334
            Transparent     =   False
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   311
         End
         Begin Label URLLbl
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "SearchEngineSettingsGroup"
            Italic          =   False
            Left            =   26
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   0
            Selectable      =   False
            TabIndex        =   0
            TabPanelIndex   =   0
            TabStop         =   True
            Text            =   "URL:"
            TextAlign       =   2
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   312
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   67
         End
         Begin Label NameLbl
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "SearchEngineSettingsGroup"
            Italic          =   False
            Left            =   26
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   0
            Selectable      =   False
            TabIndex        =   2
            TabPanelIndex   =   0
            TabStop         =   True
            Text            =   "Name:"
            TextAlign       =   2
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   335
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   67
         End
         Begin ComboBox PresetMnu
            AutoComplete    =   False
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Hint            =   ""
            Index           =   -2147483648
            InitialParent   =   "SearchEngineSettingsGroup"
            InitialValue    =   "\r\nGoogle\r\nYahoo\r\nBing\r\nDuckDuckGo\r\nBaidu\r\n"
            Italic          =   False
            Left            =   98
            ListIndex       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   0
            TabIndex        =   5
            TabPanelIndex   =   0
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   358
            Transparent     =   False
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   311
         End
         Begin Label PresetLbl
            AutoDeactivate  =   True
            Bold            =   False
            DataField       =   ""
            DataSource      =   ""
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "SearchEngineSettingsGroup"
            Italic          =   False
            Left            =   26
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Multiline       =   False
            Scope           =   0
            Selectable      =   False
            TabIndex        =   4
            TabPanelIndex   =   0
            TabStop         =   True
            Text            =   "Preset:"
            TextAlign       =   2
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   358
            Transparent     =   True
            Underline       =   False
            Visible         =   True
            Width           =   67
         End
      End
      Begin Label ResultsSaveLbl
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ResultsSettingsGroup"
         Italic          =   False
         Left            =   212
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Save:"
         TextAlign       =   3
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   198
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   42
      End
      Begin ComboBox LogType
         AutoComplete    =   False
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "ResultsSettingsGroup"
         InitialValue    =   "Do not save\r\nSave As Plain Text\r\nSave As CSV\r\nSave As Original JSON\r\nSave As Unpacked JSON"
         Italic          =   False
         Left            =   256
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   197
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   145
      End
   End
   Begin PushButton SaveChangesBtn
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   352
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   531
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton CancelChangesBtn
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   265
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   531
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton AboutBtn
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "About..."
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   5
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   531
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   85
   End
   Begin VTHash.VTSession VTSession1
      APIKey          =   ""
      HTTPVersion     =   ""
      Index           =   -2147483648
      IsSSLCertOK     =   False
      LockedInPosition=   False
      Password        =   ""
      Scope           =   1
      TabPanelIndex   =   0
      Username        =   ""
      Yield           =   True
   End
   Begin GroupBox VTSettingsGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "VirusTotal.com"
      Enabled         =   True
      Height          =   175
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   5
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   419
      Begin Label CommentSigLbl
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   68
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "VTSettingsGroup"
         Italic          =   False
         Left            =   5
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   0
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Comment Signature (optional): "
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   53
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   69
      End
      Begin TextArea CommentSig
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   True
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   52
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "VTSettingsGroup"
         Italic          =   False
         Left            =   86
         LimitText       =   0
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   0
         ScrollbarHorizontal=   False
         ScrollbarVertical=   True
         Styled          =   True
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   52
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         UseFocusRing    =   True
         Visible         =   True
         Width           =   330
      End
      Begin TextField APIText
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "VTSettingsGroup"
         Italic          =   False
         Left            =   86
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   24
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   311
      End
      Begin Label APIKeyLbl
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "VTSettingsGroup"
         Italic          =   False
         Left            =   5
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "API Key:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   24
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   69
      End
      Begin PopupMenu AlgSelect
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "VTSettingsGroup"
         InitialValue    =   ""
         Italic          =   False
         Left            =   281
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   107
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   135
      End
      Begin Label AlgLbl
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "VTSettingsGroup"
         Italic          =   False
         Left            =   190
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Algorithm:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   109
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   88
      End
      Begin CheckBox UploadUnknown
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Permit file upload"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "VTSettingsGroup"
         Italic          =   False
         Left            =   15
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   125
         Transparent     =   True
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   130
      End
      Begin CheckBox UseSSL
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Use SSL/TLS"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "VTSettingsGroup"
         Italic          =   False
         Left            =   15
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   106
         Transparent     =   True
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   100
      End
      Begin CheckBox ConfirmLargeUploadChkBx
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Confirm large uploads"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "VTSettingsGroup"
         Italic          =   False
         Left            =   15
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   144
         Transparent     =   True
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   185
      End
      Begin Canvas TestIcon
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         Height          =   16
         HelpTag         =   "Test API Key"
         Index           =   -2147483648
         InitialParent   =   "VTSettingsGroup"
         Left            =   399
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Top             =   27
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   16
      End
   End
   Begin GroupBox ProxySettingsGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Proxy (Optional)"
      Enabled         =   True
      Height          =   122
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   5
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   403
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   419
      Begin Label Label9
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ProxySettingsGroup"
         Italic          =   False
         Left            =   183
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Type:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   443
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   68
      End
      Begin TextField ProxyServer
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "IP or Hostname"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ProxySettingsGroup"
         Italic          =   False
         Left            =   102
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   419
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   315
      End
      Begin ComboBox ProxyTypes
         AutoComplete    =   False
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   32
         HelpTag         =   ""
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "ProxySettingsGroup"
         InitialValue    =   "HTTP\r\nHTTP 1.0\r\nSocks 4\r\nSocks 4A\r\nSocks 5\r\nSocks 5A"
         Italic          =   False
         Left            =   257
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   442
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   160
      End
      Begin TextField ProxyPort
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ProxySettingsGroup"
         Italic          =   False
         Left            =   102
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "1080"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   443
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   76
      End
      Begin TextField ProxyUsername
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ProxySettingsGroup"
         Italic          =   False
         Left            =   101
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   467
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   315
      End
      Begin TextField ProxyPassword
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ProxySettingsGroup"
         Italic          =   False
         Left            =   101
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   True
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   490
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   315
      End
      Begin Label ProxyLbl
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ProxySettingsGroup"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Server:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   419
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   87
      End
      Begin Label ProxyPortLbl
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ProxySettingsGroup"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Port:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   443
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   87
      End
      Begin Label ProxyUserLbl
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ProxySettingsGroup"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Username:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   467
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   86
      End
      Begin Label ProxyPassLbl
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "ProxySettingsGroup"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Password:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   490
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   86
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  mKonami = mKonami + Str(Asc(key))
		  
		  If InStr(mKonami, "30303131282928299897") > 0 Then
		    mKonami = ""
		    mKonamiCount = mKonamiCount + 1
		    Select Case mKonamiCount
		    Case 1
		      Call MsgBox("There are no easter eggs in this program.", 16, "Do not do that again")
		    Case 2
		      Call MsgBox("I wasn't kidding, there are no easter eggs in this program.", 16, "Did I stutter?")
		    Case 3
		      Call MsgBox("Won't somebody please think of the children!?", 16, "Think of them!")
		    Else
		      If mKonamiCount Mod 2 = 0 Then
		        Call MsgBox("I can't take much more of this!", 16, "No more!")
		      Else
		        Call MsgBox("Oh, wait. Yes, I can.", 16, "Whoops")
		      End If
		    End Select
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  AlgSelect.AddRow("MD5")
		  AlgSelect.AddRow("SHA1")
		  If Win32.KernelVersion >= 6.0 Then AlgSelect.AddRow("SHA256")
		  Select Case VTHash.GetConfig("Algorithm")
		  Case Win32.Crypto.CALG_MD5
		    AlgSelect.ListIndex = 0
		  Case Win32.Crypto.CALG_SHA1
		    AlgSelect.ListIndex = 1
		  Case Win32.Crypto.CALG_SHA256
		    If Win32.KernelVersion >= 6.0 Then
		      AlgSelect.ListIndex = 2
		    Else
		      AlgSelect.ListIndex = 1
		    End If
		  Else
		    If Win32.KernelVersion >= 6.0 Then
		      AlgSelect.ListIndex = 2 ' default to sha256
		    Else
		      AlgSelect.ListIndex = 1 ' XP doesn't support sha256
		    End If
		  End Select
		  
		  If VTHash.GetConfig("AutoSave") Then
		    LogType.ListIndex = VTHash.GetConfig("DefaultFormat")  + 1
		  Else
		    LogType.ListIndex = 0
		  End If
		  If VTHash.GetConfig("AutosavePath") <> Nil Then
		    LogFile.Text = FolderItem(VTHash.GetConfig("AutosavePath")).NativePath
		  End If
		  
		  APIText.Text = VTHash.GetConfig("APIKey")
		  CommentSig.Text = VTHash.GetConfig("CommentSignature")
		  SearchDisplayName.Text = VTHash.GetConfig("SearchEngineName")
		  SearchURL.Text = VTHash.GetConfig("SearchEngineURL")
		  UseSSL.Value = VTHash.GetConfig("UseSSL")
		  
		  If HasConfig("PermitUploads") Then
		    UploadUnknown.Value = VTHash.GetConfig("PermitUploads")
		  Else
		    UploadUnknown.Value = True
		  End If
		  
		  If HasConfig("ConfirmLargeUploads") Then
		    ConfirmLargeUploadChkBx.Value = VTHash.GetConfig("ConfirmLargeUploads")
		  Else
		    ConfirmLargeUploadChkBx.Value = True
		  End If
		  
		  If HasConfig("SortType") Then
		    SortDir = VTHash.GetConfig("SortDirection")
		    SortType = VTHash.GetConfig("SortType")
		  Else
		    SortDir = Listbox.SortAscending
		    SortType = -1
		  End If
		  
		  ResultsSortSelect.AddRow("Do not sort")
		  ResultsSortSelect.AddRow("By scanner name")
		  ResultsSortSelect.AddRow("By scanner name (reverse)")
		  ResultsSortSelect.AddRow("By scan result")
		  ResultsSortSelect.AddRow("By scan result (reverse)")
		  
		  Select Case True
		  Case SortType = -1
		    ResultsSortSelect.ListIndex = 0
		  Case SortDir = Listbox.SortAscending And SortType = SORT_SCANNER
		    ResultsSortSelect.ListIndex = 1
		  Case SortDir = Listbox.SortDescending And SortType = SORT_SCANNER
		    ResultsSortSelect.ListIndex = 2
		  Case SortDir = Listbox.SortAscending And SortType = SORT_RESULT
		    ResultsSortSelect.ListIndex = 3
		  Case SortDir = Listbox.SortDescending And SortType = SORT_RESULT
		    ResultsSortSelect.ListIndex = 4
		  End Select
		  
		  If VTHash.HasConfig("ProxyType") Then
		    mProxyType = libcURL.ProxyType(VTHash.GetConfig("ProxyType").Int32Value)
		    ProxyServer.Text = VTHash.GetConfig("ProxyAddress")
		    Select Case mProxyType
		    Case libcURL.ProxyType.HTTP
		      ProxyTypes.ListIndex = 0
		    Case libcURL.ProxyType.HTTP1_0
		      ProxyTypes.ListIndex = 1
		    Case libcURL.ProxyType.SOCKS4
		      ProxyTypes.ListIndex = 2
		    Case libcURL.ProxyType.SOCKS4A
		      ProxyTypes.ListIndex = 3
		    Case libcURL.ProxyType.SOCKS5
		      ProxyTypes.ListIndex = 4
		    Case libcURL.ProxyType.SOCKS5_HOSTNAME
		      ProxyTypes.ListIndex = 5
		    End Select
		    ProxyPort.Text = Str(VTHash.GetConfig("ProxyPort"), "#####")
		    ProxyUsername.Text = VTHash.GetConfig("ProxyUsername")
		    ProxyPassword.Text = VTHash.GetConfig("ProxyPassword")
		  End If
		  
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h21
		Private KeyValid As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKonami As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKonamiCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProxyType As libcURL.ProxyType
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWaiter As WaitWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NewSearchName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NewSearchURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SortDir As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SortType As Integer = -1
	#tag EndProperty


	#tag Constant, Name = eicarhash, Type = String, Dynamic = False, Default = \"44D88612FEA8A8F36DE82E1278ABB02F", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SORT_RESULT, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SORT_SCANNER, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events BrowseBtn
	#tag Event
		Sub Action()
		  Dim f As FolderItem = SelectFolder()
		  If f <> Nil Then
		    LogFile.Text = f.NativePath
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultsSortSelect
	#tag Event
		Sub Change()
		  Select Case Me.ListIndex
		  Case 0
		    SortType = -1
		    SortDir = Listbox.SortNone
		  Case 1
		    SortType = SORT_SCANNER
		    SortDir = Listbox.SortAscending
		  Case 2
		    SortType = SORT_SCANNER
		    SortDir = Listbox.SortDescending
		  Case 3
		    SortType = SORT_RESULT
		    SortDir = Listbox.SortAscending
		  Case 4
		    SortType = SORT_RESULT
		    SortDir = Listbox.SortDescending
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PresetMnu
	#tag Event
		Sub Change()
		  SearchDisplayName.Text = Me.Text
		  Select Case Me.Text
		  Case "Google"
		    SearchURL.Text = "https://encrypted.google.com/search?q=%PARAMETER%"
		  Case "Yahoo"
		    SearchURL.Text = "https://search.yahoo.com/search?p=%PARAMETER%"
		  Case "Bing"
		    SearchURL.Text = "https://www.bing.com/search?q=%PARAMETER%"
		  Case "DuckDuckGo"
		    SearchURL.Text = "https://duckduckgo.com/?q=%PARAMETER%"
		  Case "Baidu"
		    SearchURL.Text = "https://www.baidu.com/s?wd=%PARAMETER%"
		  Else
		    SearchURL.Text = ""
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LogType
	#tag Event
		Sub Change()
		  If Me.ListIndex = 0 Then
		    LogResultsGrp.Enabled = False
		  Else
		    LogResultsGrp.Enabled = True
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SaveChangesBtn
	#tag Event
		Sub Action()
		  If KeyValid Then
		    VTHash.SetConfig("APIKey", APIText.Text)
		  Else
		    If MsgBox("The API key is invalid.", 49 + 256, "VT Hash Check - Wrong key length") = 1 Then
		      Self.Close
		    Else
		      Return
		    End If
		  End If
		  
		  If SearchDisplayName.Text.Trim <> "" And SearchURL.Text.Trim <> "" Then
		    VTHash.SetConfig("SearchEngineName", SearchDisplayName.Text.Trim)
		    VTHash.SetConfig("SearchEngineURL", SearchURL.Text.Trim)
		  Else
		    VTHash.SetConfig("SearchEngineName", "")
		    VTHash.SetConfig("SearchEngineURL", "")
		  End If
		  
		  Select Case AlgSelect.Text
		  Case "SHA1"
		    VTHash.SetConfig("Algorithm", Win32.Crypto.CALG_SHA1)
		  Case "SHA256"
		    VTHash.SetConfig("Algorithm", Win32.Crypto.CALG_SHA256)
		  Case "MD5"
		    VTHash.SetConfig("Algorithm", Win32.Crypto.CALG_MD5)
		  Else
		    VTHash.SetConfig("Algorithm", Win32.Crypto.CALG_MD5)
		  End Select
		  
		  Dim isAutoSave As Boolean
		  Select Case LogType.Text
		  Case "Do not save"
		    isAutoSave = False
		  Case "Save As Plain Text"
		    isAutoSave = True
		    VTHash.SetConfig("DefaultFormat", 0)
		  Case "Save As CSV"
		    isAutoSave = True
		    VTHash.SetConfig("DefaultFormat", 1)
		  Case "Save As Original JSON"
		    isAutoSave = True
		    VTHash.SetConfig("DefaultFormat", 2)
		  Case "Save As Unpacked JSON"
		    isAutoSave = True
		    VTHash.SetConfig("DefaultFormat", 3)
		  End Select
		  VTHash.SetConfig("AutoSave", isAutoSave)
		  If isAutoSave Then
		    Dim gf As FolderItem = GetFolderItem(LogFile.Text)
		    If Not gf.Exists Then
		      gf.CreateAsFolder
		    End If
		    VTHash.SetConfig("AutoSavePath", gf)
		  End If
		  VTHash.SetConfig("CommentSignature", CommentSig.Text)
		  VTHash.SetConfig("UseSSL", UseSSL.Value)
		  VTHash.SetConfig("PermitUploads", UploadUnknown.Value)
		  VTHash.SetConfig("ConfirmLargeUploads", ConfirmLargeUploadChkBx.Value)
		  VTHash.SetConfig("SortDirection", SortDir)
		  VTHash.SetConfig("SortType", SortType)
		  
		  'If nic.ListIndex > -1 And nic.RowTag(nic.ListIndex) IsA NetworkInterface Then
		  'Dim ip As String = NetworkInterface(nic.RowTag(nic.ListIndex)).IPAddress
		  'VTHash.SetConfig("NetworkInterface", ip)
		  'End If
		  VTHash.SetConfig("ProxyAddress", ProxyServer.Text)
		  VTHash.SetConfig("ProxyUsername", ProxyUsername.Text)
		  VTHash.SetConfig("ProxyPassword", ProxyPassword.Text)
		  VTHash.SetConfig("ProxyType", Integer(mProxyType))
		  VTHash.SetConfig("ProxyPort", Val(ProxyPort.Text))
		  Close()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelChangesBtn
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AboutBtn
	#tag Event
		Sub Action()
		  AboutWindow.ShowModal
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VTSession1
	#tag Event
		Sub Response(ResponseObject As JSONItem, HTTPStatus As Integer)
		  #pragma Unused HTTPStatus
		  mWaiter.Close
		  mWaiter = Nil
		  If ResponseObject <> Nil And ResponseObject.HasName("total") Then
		    MsgBox("API key test succeeded.")
		  ElseIf ResponseObject <> Nil Then
		    MsgBox("API key test failed." + EndOfLine + "Response code: " + _
		    ResponseObject.Value("response_code") + EndOfLine + "Message: " + ResponseObject.Value("verbose_msg"))
		  Else
		    MsgBox("API key test failed.")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(cURLCode As Integer)
		  mWaiter.Close
		  mWaiter = Nil
		  
		  If Me.GetStatusCode  = 0 Then
		    VTHash.HandleCurlError(Me, cURLCode)
		  Else
		    Call MsgBox("API key test failed. (HTTP" + Str(Me.GetStatusCode, "000") +")", 16, "VT Hash Check - Invalid API key")
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events APIText
	#tag Event
		Sub TextChange()
		  if me.Text.Len <> 64 Then
		    KeyValid = False
		  Else
		    KeyValid = True
		  end if
		  TestIcon.Invalidate(False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  If VTHash.GetConfig("APIKey").StringValue <> "" Then Me.Text = VTHash.GetConfig("APIKey").StringValue
		  if VTHash.GetConfig("APIKey").StringValue.Len <> 64 Then
		    KeyValid = False
		  Else
		    KeyValid = True
		  end if
		  TestIcon.Invalidate(False)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TestIcon
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma Unused areas
		  If KeyValid Then
		    g.DrawPicture(icon_validation_good, 0, 0)
		    Me.HelpTag = "Test API Key"
		  Else
		    g.DrawPicture(icon_validation_fail, 0, 0)
		    Me.HelpTag = "Invalid API Key"
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  Me.MouseCursor = System.Cursors.FingerPointer
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  Me.MouseCursor = System.Cursors.StandardPointer
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  If Not KeyValid Then
		    ShowURL("https://www.virustotal.com/en/faq/#virustotal-api")
		  ElseIf MsgBox("Would you like to send a test request to virustotal.com?", 4 + 32, "VT Hash Check - Test API key now?") = 6 Then
		    VTSession1.APIKey = APIText.Text
		    VTSession1.GetReport(eicarhash, VTHash.RequestType.FileReport)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  #pragma Unused X
		  #pragma Unused Y
		  mWaiter = New WaitWindow
		  mWaiter.ShowWithin(Self)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ProxyTypes
	#tag Event
		Sub Change()
		  Select Case Me.Text
		  Case "Socks 4"
		    mProxyType = libcURL.ProxyType.SOCKS4
		  Case "Socks 4A"
		    mProxyType = libcURL.ProxyType.SOCKS4A
		  Case "Socks 5"
		    mProxyType = libcURL.ProxyType.SOCKS5
		  Case "Socks 5A"
		    mProxyType = libcURL.ProxyType.SOCKS5_HOSTNAME
		  Case "HTTP"
		    mProxyType = libcURL.ProxyType.HTTP
		  Case "HTTP 1.0"
		    mProxyType = libcURL.ProxyType.HTTP1_0
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
