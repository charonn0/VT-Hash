#tag Window
Begin Window SettingsWindow
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   False
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   1.86e+2
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   165
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   165
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
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   165
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin TabPanel TabPanel1
      AutoDeactivate  =   True
      Bold            =   ""
      Enabled         =   True
      Height          =   160
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Panels          =   ""
      Scope           =   0
      SmallTabs       =   ""
      TabDefinition   =   "Virus Total\rResult Logs\rSearch Engine"
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   0
      Underline       =   ""
      Value           =   0
      Visible         =   True
      Width           =   344
      Begin Label Label2
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   68
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   10
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Multiline       =   True
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         Text            =   "Comment Signature (optional): "
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   62
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
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   91
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
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   61
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   243
      End
      Begin Canvas Canvas1
         AcceptFocus     =   ""
         AcceptTabs      =   ""
         AutoDeactivate  =   True
         Backdrop        =   ""
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         Height          =   16
         HelpTag         =   "Test API Key"
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Left            =   318
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Top             =   33
         UseFocusRing    =   True
         Visible         =   True
         Width           =   16
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
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   91
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
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   0
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   33
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
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   10
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   1
         Text            =   "API Key:"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   33
         Transparent     =   True
         Underline       =   ""
         Visible         =   True
         Width           =   69
      End
      Begin PopupMenu AlgSelect
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         InitialValue    =   ""
         Italic          =   ""
         Left            =   217
         ListIndex       =   0
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   125
         Underline       =   ""
         Visible         =   True
         Width           =   117
      End
      Begin Label Label5
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   126
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   1
         Text            =   "Algorithm:"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   127
         Transparent     =   True
         Underline       =   ""
         Visible         =   True
         Width           =   88
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
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   11
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   11
         TextUnit        =   0
         Top             =   31
         Underline       =   ""
         Value           =   False
         Visible         =   True
         Width           =   89
      End
      Begin GroupBox GroupBox1
         AutoDeactivate  =   True
         Bold            =   ""
         Caption         =   "Log Results"
         Enabled         =   False
         Height          =   99
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   7
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   2
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   50
         Underline       =   ""
         Visible         =   True
         Width           =   327
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
            TabPanelIndex   =   2
            TabStop         =   True
            Text            =   ""
            TextColor       =   &h000000
            TextFont        =   "System"
            TextSize        =   0
            TextUnit        =   0
            Top             =   78
            Underline       =   ""
            UseFocusRing    =   True
            Visible         =   True
            Width           =   239
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
            TabPanelIndex   =   2
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0
            TextUnit        =   0
            Top             =   112
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
            Left            =   261
            LockBottom      =   ""
            LockedInPosition=   False
            LockLeft        =   True
            LockRight       =   ""
            LockTop         =   True
            Scope           =   0
            TabIndex        =   2
            TabPanelIndex   =   2
            TabStop         =   True
            TextFont        =   "System"
            TextSize        =   0
            TextUnit        =   0
            Top             =   78
            Underline       =   ""
            Visible         =   True
            Width           =   63
         End
      End
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
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   91
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
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "https://encrypted.google.com/search?q=%PARAMETER%"
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   39
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
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   91
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
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Google"
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   63
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
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   10
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   3
         Text            =   "URL:"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   41
         Transparent     =   True
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
         InitialParent   =   "TabPanel1"
         Italic          =   ""
         Left            =   10
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   3
         Text            =   "Name:"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   64
         Transparent     =   True
         Underline       =   ""
         Visible         =   True
         Width           =   68
      End
   End
   Begin VTHash.VTSession VTSession1
      APIKey          =   ""
      CertificateFile =   ""
      CertificatePassword=   ""
      CertificateRejectionFile=   ""
      ConnectionType  =   3
      Height          =   32
      Index           =   -2147483648
      Left            =   364
      LockedInPosition=   False
      Scope           =   1
      Secure          =   True
      TabPanelIndex   =   0
      Top             =   23
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  AlgSelect.AddRow("MD5")
		  AlgSelect.AddRow("SHA1")
		  AlgSelect.AddRow("SHA256")
		  Select Case VTHash.GetConfig("Algorithm")
		  Case Win32.Crypto.CALG_MD5
		    AlgSelect.ListIndex = 0
		  Case Win32.Crypto.CALG_SHA1
		    AlgSelect.ListIndex = 1
		  Case Win32.Crypto.CALG_SHA256
		    AlgSelect.ListIndex = 2
		  Else
		    AlgSelect.ListIndex = 0
		  End Select
		  autolog.Value = VTHash.GetConfig("AutoSave")
		  If VTHash.GetConfig("AutosavePath") <> Nil Then
		    LogFile.Text = FolderItem(VTHash.GetConfig("AutosavePath")).AbsolutePath
		    LogType.ListIndex = VTHash.GetConfig("DefaultFormat")
		  End If
		  APIText.Text = VTHash.GetConfig("APIKey")
		  CommentSig.Text = VTHash.GetConfig("CommentSignature")
		  SearchDisplayName.Text = VTHash.GetConfig("SearchEngineName")
		  SearchURL.Text = VTHash.GetConfig("SearchEngineURL")
		  
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

#tag Events PushButton2
	#tag Event
		Sub Action()
		  If KeyValid Then
		    VTHash.SetConfig("APIKey", APIText.Text)
		  Else
		    If MsgBox("The API key is invalid.", 49 + 256, "Wrong key length") = 1 Then
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
		  AboutWindow.Show
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Canvas1
	#tag Event
		Sub Paint(g As Graphics)
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
		  If Not KeyValid Then
		    ShowURL("https://www.virustotal.com/en/faq/#virustotal-api")
		  ElseIf MsgBox("Would you like to send a test request to virustotal.com?", 4 + 32, "Test API key now?") = 6 Then
		    VTSession1.APIKey = APIText.Text
		    VTSession1.GetReport(eicarhash, VTHash.RequestType.FileReport)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  WaitWindow.ShowWithin(Self)
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
		  Canvas1.Invalidate(False)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  If VTHash.GetConfig("APIKey").Trim <> "" Then Me.Text = VTHash.GetConfig("APIKey").Trim
		  if VTHash.GetConfig("APIKey").Trim.Len <> 64 Then
		    KeyValid = False
		  Else
		    KeyValid = True
		  end if
		  Canvas1.Invalidate(False)
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
#tag Events VTSession1
	#tag Event
		Sub Response(ResponseObject As JSONItem, HTTPStatus As Integer)
		  WaitWindow.Close
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
		Sub Error(code as integer)
		  Break
		  
		End Sub
	#tag EndEvent
#tag EndEvents
