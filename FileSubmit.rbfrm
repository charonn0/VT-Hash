#tag Window
Begin Window FileSubmit
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   False
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   9.9e+1
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   1
   Resizeable      =   False
   Title           =   "Upload File"
   Visible         =   True
   Width           =   2.48e+2
   Begin ProgressBar ProgressBar1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   14
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Maximum         =   100
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   23
      Value           =   0
      Visible         =   True
      Width           =   214
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
      Left            =   10
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      Text            =   "Uploading to VirusTotal.com..."
      TextAlign       =   0
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   1
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   228
   End
   Begin LinkLabel Permalink
      ActiveColor     =   "&cFF0000"
      AltText         =   ""
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Draggable       =   False
      Enabled         =   True
      Height          =   20
      HilightColor    =   "&c00FFFF"
      HoverPeriod     =   250
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   14
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Multiline       =   False
      ResetPeriod     =   1000
      Scope           =   0
      Selectable      =   ""
      TabIndex        =   1
      TabPanelIndex   =   0
      Text            =   "Permalink to results"
      TextAlign       =   1
      TextColor       =   "&c0000FF"
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   45
      Transparent     =   True
      Underline       =   ""
      Visible         =   False
      Width           =   214
   End
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Cancel"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   81
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
      Top             =   68
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin SSLSocket Socket
      CertificateFile =   ""
      CertificatePassword=   ""
      CertificateRejectionFile=   ""
      ConnectionType  =   2
      Height          =   32
      Index           =   -2147483648
      Left            =   277
      LockedInPosition=   False
      Scope           =   0
      Secure          =   ""
      TabPanelIndex   =   0
      Top             =   -21
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub SubmitFile(f As FolderItem)
		  TargetFile = f
		  Socket.Address = "www.virustotal.com"
		  Socket.Port = 443
		  Socket.Secure = True
		  'Socket.ConnectionType = SSLSocket.TLSv1
		  Socket.Connect
		  Me.Show'Modal
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Formsz As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Pause As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PermaURL As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TargetFile As FolderItem
	#tag EndProperty


#tag EndWindowCode

#tag Events Permalink
	#tag Event
		Sub Action()
		  ShowURL(PermaURL)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  'If Me.Caption = "Cancel" Then
		  'Socket.Disconnect
		  'End If
		  'Self.Close
		  If Socket.IsConnected And MsgBox("Are you sure you want to cancel the upload?", 48 + 4, "Please confirm") <> 6 Then
		    Return
		  End If
		  Quit
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Socket
	#tag Event
		Sub Connected()
		  Dim m As New HTTP.MultipartForm
		  m.Element("file") = TargetFile
		  m.Element("apikey") = VTAPIKey
		  Dim content, type As String
		  content = m.ToString
		  Dim t As New HTTP.ContentType("multipart/form-data; boundary=" + m.Boundary)
		  Dim h As New InternetHeaders
		  Dim data As MemoryBlock = m.ToString
		  h.AppendHeader("Content-Type", t.ToString)
		  h.AppendHeader("Content-Length", Str(Data.Size))
		  h.AppendHeader("Host", "www.virustotal.com")
		  h.AppendHeader("Connection", "close")
		  h.AppendHeader("User-Agent", "RB-VTAPI/" + VTHash.version + " " + VTHash.PlatformString)
		  Dim req As String = "POST /vtapi/v2/file/scan HTTP/1.0" + CRLF + h.Source + CRLF + CRLF + Data.StringValue(0, Data.Size)
		  Formsz = Data.Size
		  Me.Write(req)
		  'Me.Flush
		End Sub
	#tag EndEvent
	#tag Event
		Sub DataAvailable()
		  'Dim s As String = Me.ReadAll
		  'Break
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error()
		  If Me.LastErrorCode = 102 Then
		    Dim raw As String = Me.ReadAll
		    Dim body As Integer = InStr(raw, CRLF + CRLF)
		    Dim MessageBody As String = Right(raw, raw.Len - body)
		    raw = Replace(raw, MessageBody, "").Trim
		    Dim line As String
		    line = NthField(raw, CRLF, 1)
		    raw = Replace(raw, line + CRLF, "")
		    raw = Replace(raw, MessageBody, "")
		    'Dim Headers As New HTTPHeaders(raw)
		    dim StatusCode As Integer = Val(NthField(line, " ", 2))
		    If StatusCode = 200 Then
		      Dim js As New JSONItem(MessageBody.Trim)
		      If js.Value("response_code") = VT_Code_OK Then
		        PermaURL = js.Value("permalink")
		        Permalink.Visible = True
		        Permalink.URL = PermaURL
		        Label1.Text = "Upload complete."
		      Else
		        Label1.Text = "Upload error."
		        MsgBox("Virus Total says: (" + Str(js.Value("response_code").Int32Value) + ") " + js.Value("verbose_msg"))
		      End If
		    Else
		      Label1.Text = "Upload error."
		      MsgBox("HTTP error.")
		    End If
		  Else
		    Label1.Text = "Upload error."
		    MsgBox("Socket error")
		  End If
		  PushButton1.Caption = "Close"
		End Sub
	#tag EndEvent
	#tag Event
		Function SendProgress(bytesSent as Integer, bytesLeft as Integer) As Boolean
		  While Pause
		    App.YieldToNextThread
		  Wend
		  Dim snt As Integer = Formsz - bytesLeft
		  ProgressBar1.Value = snt * 100 / Formsz
		  App.YieldToNextThread
		End Function
	#tag EndEvent
	#tag Event
		Sub SendComplete(UserAborted As Boolean)
		  Label1.Text = "Awaiting reply..."
		End Sub
	#tag EndEvent
#tag EndEvents
