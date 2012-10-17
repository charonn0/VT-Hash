#tag Window
Begin Window about
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   140
   ImplicitInstance=   True
   LiveResize      =   False
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   2
   Resizeable      =   True
   Title           =   "About VT Hash Check"
   Visible         =   True
   Width           =   402
   Begin Canvas Canvas1
      AcceptFocus     =   ""
      AcceptTabs      =   ""
      AutoDeactivate  =   True
      Backdrop        =   261013503
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   85
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   2
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   2
      UseFocusRing    =   True
      Visible         =   True
      Width           =   90
   End
   Begin Label StaticText1
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   43
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   97
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "Ariel"
      TextSize        =   25
      TextUnit        =   0
      Top             =   2
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   319
   End
   Begin Label StaticText2
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   63
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   97
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Multiline       =   True
      Scope           =   0
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Copyright ©2009-11 Boredom Software, All Rights Reserved.\r\n\r\nBoredom Software is not affiliated with VirusTotal.com, though we use their service a great deal and recommend it highly. :-)"
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   45
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   305
   End
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "OK"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   161
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   107
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin Label StaticText3
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   "Visit Virus Total"
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   11
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "www.virustotal.com"
      TextAlign       =   0
      TextColor       =   255
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   107
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   104
   End
   Begin Label StaticText4
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   "Visit Boredomsoft"
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   284
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "www.boredomsoft.org"
      TextAlign       =   0
      TextColor       =   255
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   107
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   112
   End
End
#tag EndWindow

#tag WindowCode
#tag EndWindowCode

#tag Events StaticText1
	#tag Event
		Sub Open()
		  me.Text = "VT Hash Check " + version
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  Window1.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StaticText3
	#tag Event
		Sub MouseEnter()
		  me.MouseCursor = System.Cursors.FingerPointer
		  me.Underline = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  me.MouseCursor = System.Cursors.StandardPointer
		  me.Underline = False
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  ShowURL("http://www.virustotal.com")
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events StaticText4
	#tag Event
		Sub MouseEnter()
		  me.MouseCursor = System.Cursors.FingerPointer
		  me.Underline = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  me.MouseCursor = System.Cursors.StandardPointer
		  me.Underline = False
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  ShowURL("http://www.boredomsoft.org")
		End Function
	#tag EndEvent
#tag EndEvents
