#tag Window
Begin Window SettingsWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   1.98e+2
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
   Begin PushButton PushButton2
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
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   177
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin PushButton PushButton3
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
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   177
      Underline       =   ""
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   177
      Underline       =   ""
      Visible         =   True
      Width           =   85
   End
   Begin TabPanel TabPanel1
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   172
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Panels          =   ""
      Scope           =   0
      SmallTabs       =   False
      TabDefinition   =   "Virus Total\rResults Sort\rResult Logs\rSearch Engine\rNetwork\rIgnored"
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Underline       =   ""
      Value           =   0
      Visible         =   True
      Width           =   432
      Begin Label CommentSigLbl
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   68
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         Text            =   "Comment Signature (optional): "
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   62
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   91
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
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   61
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         UseFocusRing    =   True
         Visible         =   True
         Width           =   330
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
         InitialParent   =   "TabPanel1"
         Left            =   412
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   33
         Transparent     =   True
         UseFocusRing    =   True
         Visible         =   True
         Width           =   16
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   91
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
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   33
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   1
         Text            =   "API Key:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   33
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
         InitialParent   =   "TabPanel1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   286
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   125
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   195
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   1
         Text            =   "Algorithm:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   127
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   88
      End
      Begin CheckBox autolog
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Save all logs"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   11
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   11.0
         TextUnit        =   0
         Top             =   31
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   89
      End
      Begin GroupBox LogResultsGrp
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Log Results"
         Enabled         =   False
         Height          =   99
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   7
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   3
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   50
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   345
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
            Left            =   18
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
            TabPanelIndex   =   3
            TabStop         =   True
            Text            =   ""
            TextColor       =   &c00000000
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   78
            Transparent     =   False
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   254
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
            InitialParent   =   "LogResultsGrp"
            InitialValue    =   "Save As Plain Text\r\nSave As CSV\r\nSave As Original JSON\r\nSave As Unpacked JSON"
            Italic          =   False
            Left            =   18
            ListIndex       =   0
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   0
            TabIndex        =   1
            TabPanelIndex   =   3
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   112
            Transparent     =   False
            Underline       =   False
            UseFocusRing    =   True
            Visible         =   True
            Width           =   163
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
            Left            =   279
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   False
            LockRight       =   True
            LockTop         =   True
            Scope           =   0
            TabIndex        =   2
            TabPanelIndex   =   3
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   78
            Transparent     =   False
            Underline       =   False
            Visible         =   True
            Width           =   63
         End
      End
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   91
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
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "https://encrypted.google.com/search?q=%PARAMETER%"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   39
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   261
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   91
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
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   "Google"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   63
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   261
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   4
         Text            =   "URL:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   41
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   68
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   4
         Text            =   "Name:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   64
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   68
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
         InitialParent   =   "TabPanel1"
         InitialValue    =   "\r\nGoogle\r\nYahoo\r\nBing\r\nDuckDuckGo\r\nBaidu\r\n"
         Italic          =   False
         Left            =   91
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   4
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   90
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   261
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   4
         Text            =   "Preset:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   90
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   68
      End
      Begin GroupBox SortDirGrp
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Sort direction"
         Enabled         =   False
         Height          =   120
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   218
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   2
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   29
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   160
         Begin RadioButton SortDirection1
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Ascending (0->1)"
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "SortDirGrp"
            Italic          =   False
            Left            =   233
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   0
            TabIndex        =   0
            TabPanelIndex   =   2
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   51
            Transparent     =   False
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   137
         End
         Begin RadioButton SortDirection2
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Descending (1->0)"
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "SortDirGrp"
            Italic          =   False
            Left            =   233
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   0
            TabIndex        =   1
            TabPanelIndex   =   2
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   97
            Transparent     =   False
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   137
         End
      End
      Begin GroupBox SortByGrp
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Sort by"
         Enabled         =   True
         Height          =   120
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   54
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   2
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   29
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   160
         Begin RadioButton SortType3
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Do not sort"
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "SortByGrp"
            Italic          =   False
            Left            =   69
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   0
            TabIndex        =   2
            TabPanelIndex   =   2
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   115
            Transparent     =   False
            Underline       =   False
            Value           =   True
            Visible         =   True
            Width           =   100
         End
         Begin RadioButton SortType2
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Scan result"
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "SortByGrp"
            Italic          =   False
            Left            =   69
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   0
            TabIndex        =   1
            TabPanelIndex   =   2
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   83
            Transparent     =   False
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   100
         End
         Begin RadioButton SortType1
            AutoDeactivate  =   True
            Bold            =   False
            Caption         =   "Scanner name"
            Enabled         =   True
            Height          =   20
            HelpTag         =   ""
            Index           =   -2147483648
            InitialParent   =   "SortByGrp"
            Italic          =   False
            Left            =   69
            LockBottom      =   False
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   False
            LockTop         =   True
            Scope           =   0
            TabIndex        =   0
            TabPanelIndex   =   2
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0.0
            TextUnit        =   0
            Top             =   51
            Transparent     =   False
            Underline       =   False
            Value           =   False
            Visible         =   True
            Width           =   137
         End
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   135
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   130
      End
      Begin Label Label9
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   189
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   9
         TabPanelIndex   =   5
         Text            =   "Proxy type:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   65
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   68
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   16
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   8
         TabPanelIndex   =   5
         Text            =   "Proxy server:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   41
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   106
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   128
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
         TabIndex        =   0
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   41
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   220
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
         InitialParent   =   "TabPanel1"
         InitialValue    =   "HTTP\r\nHTTP 1.0\r\nSocks 4\r\nSocks 4A\r\nSocks 5\r\nSocks 5A"
         Italic          =   False
         Left            =   263
         ListIndex       =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   5
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   64
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   85
      End
      Begin CheckBox UseSSL
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Use SSL"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   115
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   100
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   16
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   7
         TabPanelIndex   =   5
         Text            =   "Proxy Port:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   65
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   106
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   128
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
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   "1080"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   65
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   56
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   127
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
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   89
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   220
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   16
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   5
         Text            =   "Proxy User:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   89
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   105
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   16
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   5
         Text            =   "Proxy Password:"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   112
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   105
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
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   127
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
         TabIndex        =   4
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   112
         Transparent     =   False
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   220
      End
      Begin CheckBox ConfirmLargeUploadChkBx
         AutoDeactivate  =   True
         Bold            =   ""
         Caption         =   "Confirm large uploads"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   20
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   152
         Underline       =   ""
         Value           =   False
         Visible         =   True
         Width           =   185
      End
   End
   Begin VTHash.VTSession VTSession1
      APIKey          =   ""
      Height          =   32
      Index           =   -2147483648
      IsSSLCertOK     =   ""
      Left            =   376
      LockedInPosition=   False
      Password        =   ""
      Scope           =   1
      TabPanelIndex   =   0
      Top             =   22
      Width           =   32
      Yield           =   True
   End
   Begin ComboBox nic
      AutoComplete    =   False
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Height          =   32
      HelpTag         =   ""
      Hint            =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   124
      ListIndex       =   0
      LockBottom      =   True
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
      Top             =   -58
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   False
      Width           =   220
   End
   Begin Label Label7
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
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
      TabIndex        =   5
      TabPanelIndex   =   0
      Text            =   "Network interface:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   -58
      Transparent     =   True
      Underline       =   False
      Visible         =   False
      Width           =   106
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
		  autolog.Value = VTHash.GetConfig("AutoSave")
		  If VTHash.GetConfig("AutosavePath") <> Nil Then
		    LogFile.Text = FolderItem(VTHash.GetConfig("AutosavePath")).NativePath
		    LogType.ListIndex = VTHash.GetConfig("DefaultFormat")
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
		  If SortDir = Listbox.SortDescending Then
		    SortDirection2.Value = True
		  Else
		    SortDirection1.Value = True
		  End If
		  
		  Select Case SortType
		  Case SORT_SCANNER
		    SortType1.Value = True
		  Case SORT_RESULT
		    SortType2.Value = True
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

#tag Events PushButton2
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
		  VTHash.SetConfig("AutoSave", autolog.Value)
		  VTHash.SetConfig("DefaultFormat", LogType.ListIndex)
		  Dim gf As FolderItem = GetFolderItem(LogFile.Text)
		  If Not gf.Exists Then
		    gf.CreateAsFolder
		  End If
		  VTHash.SetConfig("AutoSavePath", gf)
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
#tag Events PushButton3
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
#tag Events autolog
	#tag Event
		Sub Action()
		  LogResultsGrp.Enabled = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
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
#tag Events SortDirection1
	#tag Event
		Sub Action()
		  SortDir = Listbox.SortAscending
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SortDirection2
	#tag Event
		Sub Action()
		  SortDir = Listbox.SortDescending
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SortType3
	#tag Event
		Sub Action()
		  SortDirGrp.Enabled = Not Me.Value
		  SortType = Listbox.SortNone
		  SortDirection1.Caption = "Ascending (0->1)"
		  SortDirection2.Caption = "Descending (1->0)"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SortType2
	#tag Event
		Sub Action()
		  SortDirGrp.Enabled = Me.Value
		  SortType = SORT_RESULT
		  SortDirection1.Caption = "Negative on top"
		  SortDirection2.Caption = "Positive on top"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SortType1
	#tag Event
		Sub Action()
		  SortDirGrp.Enabled = Me.Value
		  SortType = SORT_SCANNER
		  SortDirection1.Caption = "Alphabetical"
		  SortDirection2.Caption = "Reverse Alphabetical"
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
#tag Events nic
	#tag Event
		Sub Open()
		  'Dim ip As String
		  'If VTHash.HasConfig("NetworkInterface") Then ip = VTHash.GetConfig("NetworkInterface")
		  '
		  'For i As Integer = 0 To System.NetworkInterfaceCount - 1
		  'Dim n As NetworkInterface = System.GetNetworkInterface(i)
		  'If n.IPAddress <> "0.0.0.0" Then
		  'Me.AddRow(n.IPAddress)
		  'Me.RowTag(i) = n
		  'If n.IPAddress = ip Then Me.ListIndex = i
		  'End If
		  'Next
		  '
		  
		End Sub
	#tag EndEvent
#tag EndEvents
