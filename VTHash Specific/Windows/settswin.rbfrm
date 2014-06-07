#tag Window
Begin Window settswin
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   False
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   3.82e+2
   ImplicitInstance=   True
   LiveResize      =   True
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
   Width           =   3.5e+2
   Begin GroupBox GroupBox1
      AutoDeactivate  =   True
      Bold            =   ""
      Caption         =   "Log Results"
      Enabled         =   False
      Height          =   99
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   7
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   26
      Underline       =   ""
      Visible         =   True
      Width           =   337
      Begin TextField LogFile
         AcceptTabs      =   ""
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &hFFFFFF
         Bold            =   ""
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   ""
         Left            =   18
         LimitText       =   0
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Mask            =   ""
         Password        =   ""
         ReadOnly        =   ""
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   54
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   248
      End
      Begin ComboBox LogType
         AutoComplete    =   False
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         InitialValue    =   "Save As Plain Text\r\nSave As CSV\r\nSave As Original JSON\r\nSave As Unpacked JSON"
         Italic          =   ""
         Left            =   18
         ListIndex       =   0
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   88
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   163
      End
      Begin PushButton PushButton1
         AutoDeactivate  =   True
         Bold            =   ""
         ButtonStyle     =   0
         Cancel          =   ""
         Caption         =   "Browse..."
         Default         =   ""
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox1"
         Italic          =   ""
         Left            =   271
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   54
         Underline       =   ""
         Visible         =   True
         Width           =   63
      End
   End
   Begin CheckBox autolog
      AutoDeactivate  =   True
      Bold            =   ""
      Caption         =   "Save all logs"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   18
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      State           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   2
      Underline       =   ""
      Value           =   False
      Visible         =   True
      Width           =   89
   End
   Begin CheckBox sha
      AutoDeactivate  =   True
      Bold            =   ""
      Caption         =   "Use SHA1"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   252
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      State           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   2
      Underline       =   ""
      Value           =   False
      Visible         =   True
      Width           =   79
   End
   Begin PushButton PushButton2
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   264
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
      TextSize        =   0
      TextUnit        =   0
      Top             =   351
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin PushButton PushButton3
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   177
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   351
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin PushButton PushButton5
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "About"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   5
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   351
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin GroupBox GroupBox2
      AutoDeactivate  =   True
      Bold            =   ""
      Caption         =   "Virus Total"
      Enabled         =   True
      Height          =   119
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   7
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   137
      Underline       =   ""
      Visible         =   True
      Width           =   335
      Begin Canvas Canvas1
         AcceptFocus     =   ""
         AcceptTabs      =   ""
         AutoDeactivate  =   True
         Backdrop        =   ""
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox2"
         Left            =   315
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Top             =   159
         UseFocusRing    =   True
         Visible         =   True
         Width           =   16
      End
      Begin Label Label2
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   68
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox2"
         Italic          =   ""
         Left            =   7
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Multiline       =   True
         Scope           =   0
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Comment Signature (optional): "
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   188
         Transparent     =   True
         Underline       =   ""
         Visible         =   True
         Width           =   69
      End
   End
   Begin TextField APIText
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   16777215
      Bold            =   ""
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   ""
      Left            =   88
      LimitText       =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Mask            =   ""
      Password        =   ""
      ReadOnly        =   ""
      Scope           =   0
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   159
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   224
   End
   Begin Label Label1
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   7
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "API Key:"
      TextAlign       =   2
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   159
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   69
   End
   Begin TextArea CommentSig
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &hFFFFFF
      Bold            =   ""
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   52
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   ""
      Left            =   88
      LimitText       =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   187
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   243
   End
   Begin GroupBox GroupBox3
      AutoDeactivate  =   True
      Bold            =   ""
      Caption         =   "Search Engine"
      Enabled         =   True
      Height          =   91
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   7
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   259
      Underline       =   ""
      Visible         =   True
      Width           =   337
      Begin TextField SearchURL
         AcceptTabs      =   ""
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &hFFFFFF
         Bold            =   ""
         Border          =   True
         CueText         =   "http://example.com/?q=%PARAMETER%"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox3"
         Italic          =   ""
         Left            =   88
         LimitText       =   0
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Mask            =   ""
         Password        =   ""
         ReadOnly        =   ""
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "https://encrypted.google.com/search?q=%PARAMETER%"
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   286
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   243
      End
      Begin TextField SearchDisplayName
         AcceptTabs      =   ""
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &hFFFFFF
         Bold            =   ""
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox3"
         Italic          =   ""
         Left            =   88
         LimitText       =   0
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Mask            =   ""
         Password        =   ""
         ReadOnly        =   ""
         Scope           =   0
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Google"
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   310
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   243
      End
      Begin Label Label3
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox3"
         Italic          =   ""
         Left            =   7
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
         Text            =   "URL:"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   288
         Transparent     =   False
         Underline       =   ""
         Visible         =   True
         Width           =   68
      End
      Begin Label Label4
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "GroupBox3"
         Italic          =   ""
         Left            =   7
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Name:"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   311
         Transparent     =   False
         Underline       =   ""
         Visible         =   True
         Width           =   68
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  sha.Value = (algorithm <> ALG_MD5)
		  autolog.Value = autosave
		  If autosavePath <> Nil Then
		    LogFile.Text = autosavePath.AbsolutePath
		  End If
		  LogType.ListIndex = defaultFormat
		  APIText.Text = VTAPIKey
		  CommentSig.Text = CommentSignature
		  SearchDisplayName.Text = SearchEngineName
		  SearchURL.Text = SearchEngineURL
		  
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h21
		Private KeyValid As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NewSearchName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private NewSearchURL As String
	#tag EndProperty


	#tag Constant, Name = eicarhash, Type = String, Dynamic = False, Default = \"44D88612FEA8A8F36DE82E1278ABB02F", Scope = Protected
	#tag EndConstant


#tag EndWindowCode

#tag Events PushButton1
	#tag Event
		Sub Action()
		  Dim f As FolderItem = SelectFolder()
		  If f <> Nil Then
		    LogFile.Text = f.AbsolutePath
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events autolog
	#tag Event
		Sub Action()
		  GroupBox1.Enabled = Me.Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  If KeyValid Then
		    VTAPIKey = APIText.Text
		  Else
		    If MsgBox("The API key is invalid.", 49 + 256, "Wrong key length") = 1 Then
		      Self.Close
		    Else
		      Return
		    End If
		  End If
		  
		  If SearchDisplayName.Text.Trim <> "" And SearchURL.Text.Trim <> "" Then
		    SearchEngineName = SearchDisplayName.Text.Trim
		    SearchEngineURL = SearchURL.Text.Trim
		  Else
		    'If MsgBox("Disable search feature?", 4 + 32, "No Search Engine Set") <> 6 Then
		    'Return
		    'Else
		    SearchEngineName = ""
		    SearchEngineURL = ""
		    'End If
		  End If
		  
		  If sha.Value Then
		    algorithm = ALG_SHA1
		  Else
		    algorithm = ALG_MD5
		  End If
		  autosave = autolog.Value
		  defaultFormat = LogType.ListIndex
		  If autolog.Value Then
		    autosavePath = GetFolderItem(LogFile.Text)
		    If Not autosavePath.Exists Then
		      autosavePath.CreateAsFolder
		    End If
		  Else
		    autosavePath = SpecialFolder.ApplicationData.Child("Boredom Software").Child("VT Hash").Child("scans")
		  End If
		  CommentSignature = CommentSig.Text
		  SaveSettings()
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
#tag Events PushButton5
	#tag Event
		Sub Action()
		  about.Show
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Canvas1
	#tag Event
		Sub Paint(g As Graphics)
		  If KeyValid Then
		    g.DrawPicture(icon_validation_good, 0, 0)
		  Else
		    g.DrawPicture(icon_validation_fail, 0, 0)
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
		  If Not KeyValid Then
		    ShowURL("https://www.virustotal.com/en/faq/#virustotal-api")
		  ElseIf MsgBox("Would you like to send a test request to virustotal.com?", 4 + 32, "Test API key now?") = 6 Then
		    Dim js As JSONItem = VTAPI.GetReport(eicarhash, APIText.Text, VTAPI.RequestType.FileReport)
		    If js <> Nil And js.HasName("total") Then
		      MsgBox("API key test succeeded.")
		    Else
		      MsgBox("API key test failed." + EndOfLine + "Response code: " + Str(VTAPI.LastResponseCode) + EndOfLine + "Message: " + VTAPI.LastResponseVerbose)
		    End If
		    
		  End If
		End Function
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
		  Canvas1.Invalidate(False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  If VTAPIKey.Trim <> "" Then Me.Text = VTAPIKey.Trim
		  if VTAPIKey.Trim.Len <> 64 Then
		    KeyValid = False
		  Else
		    KeyValid = True
		  end if
		  Canvas1.Invalidate(False)
		End Sub
	#tag EndEvent
#tag EndEvents
