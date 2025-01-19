#tag Window
Begin Window FileSubmitWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   HasFullScreenButton=   False
   Height          =   110
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   1
   Resizeable      =   False
   Title           =   "Upload File"
   Visible         =   True
   Width           =   349
   Begin ProgressBar UploadProgressBar
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   10
      HelpTag         =   ""
      Indeterminate   =   False
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   14
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Maximum         =   100
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   23
      Transparent     =   True
      Value           =   0.0
      Visible         =   True
      Width           =   315
   End
   Begin Label StatusLbl
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
      Left            =   10
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Uploading to VirusTotal.com..."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   1
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   329
   End
   Begin LinkLabel Permalink
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
      Left            =   14
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      ResetPeriod     =   1000
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Permalink to results"
      TextAlign       =   1
      TextColor       =   &c0000FF00
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   61
      Transparent     =   True
      Underline       =   False
      URL             =   ""
      Visible         =   False
      Width           =   315
   End
   Begin PushButton CancelBtn
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
      Left            =   174
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   82
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   82
   End
   Begin Label PercentagesLbl
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   14
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "%0 of %0 bytes sent"
      TextAlign       =   0
      TextColor       =   &c80808000
      TextFont        =   "System"
      TextSize        =   10.0
      TextUnit        =   0
      Top             =   33
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   315
   End
   Begin VTHash.VTSession Socket
      APIKey          =   ""
      Enabled         =   True
      HTTPVersion     =   ""
      Index           =   -2147483648
      IsSSLCertOK     =   False
      LockedInPosition=   False
      Password        =   ""
      Scope           =   0
      TabPanelIndex   =   0
      Username        =   ""
      Yield           =   True
   End
   Begin Timer GUITimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   250
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin PushButton PauseButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Pause"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   87
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
      Top             =   82
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   82
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  mTaskBar = New TaskBar(Self)
		  mTaskBar.SetProgressState(TaskBar.TaskBarStates.Normal)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Function ETA(Total As UInt64, Current As UInt64, BPS As Double) As String
		  Dim remaining As UInt64 = Total - Current
		  Dim secs As Double = remaining / BPS
		  Return FormatTime(secs * 1000, True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FormatTime(Milliseconds As Int64, FractionalSeconds As Boolean = False) As String
		  ' Formats the period of time denoted by Milliseconds as HH:MM:SS. If FractionalSeconds is true then fractions of a second are included.
		  
		  Dim hours As Integer = (Milliseconds / (1000 * 60 * 60))
		  Dim minutes As Integer = (Milliseconds / (1000 * 60)) Mod 60
		  Dim seconds As Integer = (Milliseconds / 1000) Mod 60
		  Dim frac As Integer  = Milliseconds Mod 1000
		  Dim out As String
		  If hours > 0 Then
		    out = Str(hours) + ":" + Format(minutes, "00") + ":"
		  Else
		    out = out + Format(minutes, "#0") + ":"
		  End If
		  If FractionalSeconds Then
		    out = out + Format(seconds + (frac / 1000), "00.00")
		  Else
		    out = out + Format(seconds, "00")
		  End If
		  Return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubmitFile(parentWindow As Window, File As FolderItem, APIKey As String)
		  Dim ScreenNumber As Integer = ScreenFromXY(parentWindow.Left, ParentWindow.Top)
		  ShowCentered(Me, ScreenNumber)
		  TargetFile = File
		  fLength = TargetFile.Length
		  'Socket.Yield = True
		  Socket.APIKey = APIKey
		  Socket.SubmitFile(File)
		  Self.Title = "Submitting '" + TargetFile.Name + "'"
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected fLength As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInfoCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPercentDone As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTaskBar As TaskBar
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Output As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PermaURL As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TargetFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected tTotal As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events Permalink
	#tag Event
		Sub Action()
		  ShowURL(PermaURL)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelBtn
	#tag Event
		Sub Action()
		  'If Me.Caption = "Cancel" Then
		  'Socket.Disconnect
		  'End If
		  'Self.Close
		  If Not Socket.IsTransferComplete Then
		    Call Socket.EasyHandle.Pause
		    If MsgBox("Are you sure you want to cancel the upload?", 48 + 4, "Please confirm") <> 6 Then
		      Call Socket.EasyHandle.Resume
		      Return
		    End If
		  End If
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Socket
	#tag Event
		Sub Response(ResponseObject As JSONItem, HTTPStatus As Integer)
		  GUITimer.Mode = Timer.ModeOff
		  If HTTPStatus = 200 And ResponseObject <> Nil Then
		    If ResponseObject.Value("response_code") = VT_Code_OK Then
		      Dim id As String = ResponseObject.Value("resource")
		      PermaURL = "https://www.virustotal.com/gui/file/" + id + "/detection/" + ResponseObject.Value("permalink")
		      Permalink.Visible = True
		      Permalink.URL = PermaURL
		      StatusLbl.Text = "Upload complete."
		    Else
		      StatusLbl.Text = "Upload error."
		      MsgBox("Virus Total says: (" + Str(ResponseObject.Value("response_code").Int32Value) + ") " + ResponseObject.Value("verbose_msg"))
		    End If
		  Else
		    StatusLbl.Text = "Upload error."
		    MsgBox("Error: " + Str(HTTPStatus) + ".")
		  End If
		  CancelBtn.Caption = "Close"
		  PauseButton.Enabled = False
		  UploadProgressBar.Value = UploadProgressBar.Maximum
		End Sub
	#tag EndEvent
	#tag Event
		Function Progress(dlTotal As Int64, dlNow As Int64, ulTotal As Int64, ulNow As Int64) As Boolean
		  #pragma Unused dlnow
		  #pragma Unused dlTotal
		  mPercentDone = ulNow * 100 \ ultotal
		  Dim speed As Double = Me.GetInfo(libcURL.Info.SPEED_UPLOAD)
		  mInfoCaption = FormatBytes(ulNow) + " of " + FormatBytes(ultotal) + " sent (" + FormatBytes(speed) + "/s) " + ETA(ulTotal, ulNow, speed) + " remaining"
		End Function
	#tag EndEvent
	#tag Event
		Sub Error(cURLCode As Integer)
		  GUITimer.Mode = Timer.ModeOff
		  VTHash.HandleCurlError(Me, cURLCode)
		  Self.Close()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GUITimer
	#tag Event
		Sub Action()
		  If Right(StatusLbl.Text, 3) = "..." Then
		    StatusLbl.Text = Left(StatusLbl.Text, StatusLbl.Text.Len - 3)
		  ElseIf Right(StatusLbl.Text, 2) = ".." Then
		    StatusLbl.Text = StatusLbl.Text + "."
		  ElseIf Right(StatusLbl.Text, 1) = "." Then
		    StatusLbl.Text = StatusLbl.Text + "."
		  End If
		  PercentagesLbl.Text = mInfoCaption
		  UploadProgressBar.Value = mPercentDone
		  mTaskBar.SetProgressValue(mPercentDone, 100)
		  If UploadProgressBar.Value >= UploadProgressBar.Maximum Then
		    StatusLbl.Text = "Awaiting response..."
		  Else
		    StatusLbl.Text = "Sending file..."
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PauseButton
	#tag Event
		Sub Action()
		  If Me.Caption = "Pause" Then
		    Call Socket.EasyHandle.Pause
		    Me.Caption = "Resume"
		    Self.Title = "Submitting '" + TargetFile.Name + "' - Paused"
		    GUITimer.Mode = Timer.ModeOff
		    mTaskBar.SetProgressState(TaskBar.TaskBarStates.Paused)
		  Else
		    Call Socket.EasyHandle.Resume
		    Me.Caption = "Pause"
		    Self.Title = "Submitting '" + TargetFile.Name + "'"
		    GUITimer.Mode = Timer.ModeMultiple
		    mTaskBar.SetProgressState(TaskBar.TaskBarStates.Normal)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
