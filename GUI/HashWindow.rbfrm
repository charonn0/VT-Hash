#tag Window
Begin Window HashWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   HasFullScreenButton=   False
   Height          =   72
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   2
   Resizeable      =   False
   Title           =   "Calculating hash..."
   Visible         =   True
   Width           =   319
   Begin TextField HashText
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   False
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   18
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   57
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "00000000000000000000000000000000000000000000000000000000000000000000"
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   11.0
      TextUnit        =   0
      Top             =   17
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   262
   End
   Begin Label StaticText1
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   2
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "File:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   11.0
      TextUnit        =   0
      Top             =   -3
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   49
   End
   Begin Label HashName
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   2
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
      Text            =   "SHA512:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   11.0
      TextUnit        =   0
      Top             =   14
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   49
   End
   Begin Label PathText
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   57
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
      Text            =   "Z:\\My Folder\\MySubFolder\\MyFile.exe"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   11.0
      TextUnit        =   0
      Top             =   -3
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   262
   End
   Begin PushButton CancelButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   True
      Enabled         =   True
      Height          =   18
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   120
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
      TextSize        =   11.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin LinkLabel VersionText
      ActiveColor     =   &cFF000000
      AltText         =   ""
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Draggable       =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      HilightColor    =   &c00FFFF00
      HoverPeriod     =   250
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   3
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      ResetPeriod     =   1000
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Version 0.86"
      TextAlign       =   0
      TextColor       =   &c80808000
      TextFont        =   "System"
      TextSize        =   9.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   True
      Underline       =   False
      URL             =   ""
      Visible         =   True
      Width           =   86
   End
   Begin Thread Hasher
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   0
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin Timer HashGUITimer
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   1
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin Timer SubmitterGUITimer
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   1
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin ProgressBar HashProgress
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   12
      HelpTag         =   ""
      Indeterminate   =   False
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   2
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Maximum         =   5
      Scope           =   0
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   39
      Transparent     =   True
      Value           =   0.0
      Visible         =   True
      Width           =   317
   End
   Begin Timer ErrorTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   1
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin Timer SubmitTimer
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   1
      Scope           =   0
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  If Hasher.State <> Thread.NotRunning Then Hasher.Kill()
		  ErrorTimer.Mode = Timer.ModeOff
		  HashGUITimer.Mode = Timer.ModeOff
		  SubmitterGUITimer.Mode = Timer.ModeOff
		  SubmitTimer.Mode = Timer.ModeOff
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub ProcessFile(File As FolderItem)
		  mTargetFile = File
		  PathText.Text = mTargetFile.NativePath.Shorten
		  Me.Show
		  Hasher.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub VTSocketErrorHandler(Sender As VTHash.VTSession, cURLCode As Integer)
		  VTHash.HandleCurlError(Sender, cURLCode)
		  Self.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub VTSocketResponseHandler(Sender As VTHash.VTSession, ResponseObject As JSONItem, HTTPStatus As Integer)
		  #pragma Unused Sender
		  Select Case True
		  Case HTTPStatus = 200 And ResponseObject <> Nil
		    Dim rw As New ResultWindow
		    Dim v As New VTHash.Results(ResponseObject, mTargetFile)
		    v.HashValue = mHash
		    rw.ShowResult(v)
		    Self.Close
		  Case HTTPStatus <> 200
		    Select Case HTTPStatus
		    Case 204
		      Call MsgBox("Virus Total refused to accept your query at this time. Please try again in a few minutes.", 16, "VT Hash Check - Rate limit exceeded")
		    Case 403
		      Call MsgBox("Your Virus Total account is not allowed to perform that action." + Str(HTTPStatus), 16, "VT Hash Check - Access denied")
		    Else
		      Call MsgBox("Virus Total responded with HTTP " + Str(HTTPStatus), 16, "VT Hash Check - HTTP error")
		    End Select
		  Else
		    Call MsgBox("Invalid response from Virus Total.", 16, "VT Hash Check - Parse error")
		  End Select
		  Self.Close
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private HashPercent As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private VTSocket As VTHash.VTSession
	#tag EndProperty


#tag EndWindowCode

#tag Events HashText
	#tag Event
		Sub Open()
		  Me.Text = "Calculating..."
		End Sub
	#tag EndEvent
	#tag Event
		Sub GotFocus()
		  Me.SelectAll
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HashName
	#tag Event
		Sub Open()
		  Select Case VTHash.GetConfig("Algorithm")
		  Case Win32.Crypto.CALG_MD5
		    Me.Text = "MD5:"
		  Case Win32.Crypto.CALG_SHA1
		    Me.Text = "SHA1:"
		  Case Win32.Crypto.CALG_SHA256
		    Me.Text = "SHA256:"
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelButton
	#tag Event
		Sub Action()
		  If MsgBox("Cancel this operation?", 52, "VT Hash Check - Confirmation") = 6 Then
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VersionText
	#tag Event
		Sub Open()
		  me.Text = "Version " + VTHash.VersionString
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Hasher
	#tag Event
		Sub Run()
		  App.YieldToNextThread
		  Dim bs As BinaryStream
		  Dim a As Integer = VTHash.GetConfig("Algorithm")
		  Dim hp As New Win32.Crypto.HashProcessor(a)
		  bs = bs.Open(mTargetFile)
		  Dim chunksz As Integer
		  If bs.Length > 1024 * 1024 Then chunksz = 1024 * 1024 Else chunksz = 4 * 1024
		  While Not bs.EOF
		    App.YieldToNextThread
		    hp.Process(bs.Read(chunksz))
		    HashPercent = bs.Position * 100 / bs.Length
		    HashGUITimer.Mode = Timer.ModeSingle
		    App.YieldToNextThread
		  Wend
		  bs.Close
		  mHash = ConvertEncoding(Win32.Crypto.EncodeHex(hp.Value).Uppercase, Encodings.UTF8)
		  HashGUITimer.Mode = Timer.ModeSingle
		  SubmitTimer.Mode = Timer.ModeSingle
		  
		  Exception Err As IOException
		    mErrorMessage = "Unable to open the target file: "
		    If Err.ErrorNumber <> 0 Then
		      mErrorMessage = mErrorMessage + Win32.FormatError(Err.ErrorNumber) + "(" + Str(Err.ErrorNumber) + ")"
		    Else
		      mErrorMessage = "Unknown error."
		    End If
		    mError = Nil
		    ErrorTimer.Mode = Timer.ModeSingle
		    
		  Exception Err 'As Win32.Win32Exception
		    mError = Err
		    ErrorTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HashGUITimer
	#tag Event
		Sub Action()
		  If mHash <> "" Then HashText.Text = mHash
		  HashText.Invalidate(False)
		  HashProgress.Value = HashPercent
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SubmitterGUITimer
	#tag Event
		Sub Action()
		  HashProgress.Value = HashPercent
		  Self.Title = "Sending to Virus Total..."
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ErrorTimer
	#tag Event
		Sub Action()
		  If mError = Nil Then
		    Call MsgBox(mErrorMessage, 16, "VT Hash Check - File Error")
		    App.mIsQuitting = True
		    Quit()
		  Else
		    App.mIsQuitting = True
		    Self.Visible = False
		    Call ErrorWindow.ShowException(mError)
		    Quit()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SubmitTimer
	#tag Event
		Sub Action()
		  VTSocket = New VTHash.VTSession()
		  AddHandler VTSocket.Error, WeakAddressOf VTSocketErrorHandler
		  AddHandler VTSocket.Response, WeakAddressOf VTSocketResponseHandler
		  VTSocket.APIKey = VTHash.GetConfig("APIKey")
		  VTSocket.GetReport(mHash, VTHash.RequestType.FileReport)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
