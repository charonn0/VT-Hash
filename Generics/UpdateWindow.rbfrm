#tag Window
Begin Window UpdateWindow
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   114
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
   Title           =   "Check for updates"
   Visible         =   True
   Width           =   416
   Begin ProgressBar ProgressBar1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   10
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   14
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Maximum         =   100
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   50
      Value           =   0
      Visible         =   True
      Width           =   388
   End
   Begin Label Status
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   62
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      Text            =   "Ready."
      TextAlign       =   0
      TextColor       =   32768
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   9
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   256
   End
   Begin Label Status1
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
      Left            =   14
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
      Text            =   "Status:"
      TextAlign       =   2
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   9
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   43
   End
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Check"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   168
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   90
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin HTTPSocket Sock
      Address         =   ""
      BytesAvailable  =   0
      BytesLeftToSend =   0
      Height          =   32
      Index           =   -2147483648
      IsConnected     =   0
      Left            =   377
      LockedInPosition=   False
      Port            =   0
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   80
      Width           =   32
      yield           =   0
   End
   Begin Canvas UpdateIcon
      AcceptFocus     =   ""
      AcceptTabs      =   ""
      AutoDeactivate  =   True
      Backdrop        =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   48
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   368
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      UseFocusRing    =   True
      Visible         =   True
      Width           =   48
   End
   Begin ProgressBar ProgressBar2
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   10
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   14
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Maximum         =   100
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   69
      Value           =   0
      Visible         =   True
      Width           =   388
   End
   Begin Timer GetTimer
      Height          =   32
      Index           =   -2147483648
      Left            =   304
      LockedInPosition=   False
      Mode            =   0
      Period          =   250
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   80
      Width           =   32
   End
   Begin PushButton PushButton2
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   223
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
      Top             =   -46
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin Label CurrentAction
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   19
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
      Text            =   ""
      TextAlign       =   0
      TextColor       =   8421504
      TextFont        =   "System"
      TextSize        =   10
      TextUnit        =   0
      Top             =   28
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   273
   End
   Begin Label CurrentAction1
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   296
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      Text            =   ""
      TextAlign       =   0
      TextColor       =   8421504
      TextFont        =   "System"
      TextSize        =   10
      TextUnit        =   0
      Top             =   28
      Transparent     =   False
      Underline       =   ""
      Visible         =   False
      Width           =   69
   End
   Begin Timer SpeedTimer
      Height          =   32
      Index           =   -2147483648
      Left            =   341
      LockedInPosition=   False
      Mode            =   0
      Period          =   1000
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   80
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  If Sock.IsConnected Or UBound(Files) > -1 Then
		    If appQuitting Or MsgBox("Abort update?", 52, "A download is in progress") = 6 Then
		      Self.Reset()
		    Else
		      Return True
		    End If
		  End If
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CheckNow(UpdateURL As String, CurrentVersion As Double) As FolderItem
		  UpdateAddress = UpdateURL
		  Me.CurrentVersion = CurrentVersion
		  Self.ShowModal
		  Return DownloadDirectory
		  
		Exception err
		  If err IsA EndException Or Err IsA ThreadEndException Then Raise Err
		  
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ConvertIcon(data As String) As Picture
		  //Decodes the data part of a data: URI
		  data = DecodeBase64(data)
		  Return Picture.FromData(data)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FormatBytes(bytes As UInt64, precision As Integer = 2) As String
		  //Converts raw byte counts into SI formatted strings. 1KB = 1024 bytes.
		  //Optionally pass an integer representing the number of decimal places to return. The default is two decimal places. You may specify
		  //between 0 and 16 decimal places. Specifying more than 16 will append extra zeros to make up the length. Passing 0
		  //shows no decimal places and no decimal point.
		  
		  Const kilo = 1024
		  Static mega As UInt64 = kilo * kilo
		  Static giga As UInt64 = kilo * mega
		  Static tera As UInt64 = kilo * giga
		  Static peta As UInt64 = kilo * tera
		  Static exab As UInt64 = kilo * peta
		  
		  Dim suffix, precisionZeros As String
		  Dim strBytes As Double
		  
		  
		  If bytes < kilo Then
		    strbytes = bytes
		    suffix = "bytes"
		  ElseIf bytes >= kilo And bytes < mega Then
		    strbytes = bytes / kilo
		    suffix = "KB"
		  ElseIf bytes >= mega And bytes < giga Then
		    strbytes = bytes / mega
		    suffix = "MB"
		  ElseIf bytes >= giga And bytes < tera Then
		    strbytes = bytes / giga
		    suffix = "GB"
		  ElseIf bytes >= tera And bytes < peta Then
		    strbytes = bytes / tera
		    suffix = "TB"
		  ElseIf bytes >= tera And bytes < exab Then
		    strbytes = bytes / peta
		    suffix = "PB"
		  ElseIf bytes >= exab Then
		    strbytes = bytes / exab
		    suffix = "EB"
		  End If
		  
		  
		  While precisionZeros.Len < precision
		    precisionZeros = precisionZeros + "0"
		  Wend
		  If precisionZeros.Trim <> "" Then precisionZeros = "." + precisionZeros
		  
		  Return Format(strBytes, "#,###0" + precisionZeros) + " " + suffix
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleOptionalValues(js As JSONItem)
		  If js.HasName("Icon") Then
		    Me.Icon = ConvertIcon(js.Value("Icon"))
		    UpdateIcon.Invalidate(True)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Reset(Error As Boolean = False)
		  Sock.Close
		  If DownloadDirectory <> Nil Then
		    For i As Integer = DownloadDirectory.Count DownTo 1
		      DownloadDirectory.Item(i).Delete
		    Next
		    DownloadDirectory.Delete
		  End If
		  DownloadDirectory = Nil
		  If Not Error Then
		    UpdateInfo = Nil
		    Self.Icon = Nil
		    BaseAddress = ""
		    ReDim Files(-1)
		    SocketMode = Mode_Checking
		    TempFile = Nil
		    ProgressBar1.Value = 0
		    ProgressBar2.Value = 0
		    PushButton1.Enabled = True
		    PushButton1.Caption = "Check"
		    CurrentAction.Text = ""
		    Status.Text = "Ready"
		    Status.TextColor = OKColor
		  Else
		    SocketMode = Mode_Error
		    PushButton1.Enabled = True
		    PushButton1.Caption = "Check"
		    CurrentAction.Text = "Error while downloading"
		    Status.Text = "Download error (" + Format(ProgressBar2.Value, "###,##0") + "/" + Format(ProgressBar2.Maximum, "###,##0") + ")"
		    Status.TextColor = ErrorColor
		  End If
		  GetTimer.Mode = Timer.ModeOff
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RunUpdate(UpdateItem As JSONItem) As FolderItem
		  ReDim Files(-1)
		  UpdateInfo = UpdateItem
		  BaseAddress = UpdateInfo.Value("BaseURL")
		  LatestVersion = UpdateInfo.Value("Version")
		  HandleOptionalValues(UpdateInfo)
		  Status.Text = "An update package is available."
		  Status.TextColor = UpdateAvailColor
		  If MsgBox("A newer version is available. Would you like the download this update now?", 36, "An update is available.") = 6 Then
		    Dim items As JSONItem = UpdateInfo.Child("files")
		    DownloadDirectory = SpecialFolder.Temporary.Child(App.ExecutableFile.Name + "_Update")
		    DownloadDirectory.CreateAsFolder
		    Dim i As Integer
		    For i = 0 To items.Count - 1
		      Files.Append(items(i))
		    Next
		    ProgressBar2.Maximum = i
		    SocketMode = Mode_Downloading
		    GetTimer.Mode = Timer.ModeSingle
		    PushButton1.Caption = "Cancel"
		    Me.ShowModal
		    
		  Else
		    Status.Text = "Upgrade was cancelled."
		    Status.TextColor = ErrorColor
		    Self.Reset
		    PushButton1.Caption = "Check"
		  End If
		  
		  Return DownloadDirectory
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function Shorten(data As String, maxLength As Integer = 45) As String
		  //Replaces characters from the middle of a string with a single ellipsis ("...") until data.Len is less than the specified length.
		  //Useful for showing long paths by omitting the middle part of the data, though not limited to this use.
		  
		  If data.Len <= maxLength then
		    Return data
		  Else
		    Dim shortdata, snip As String
		    Dim start As Integer
		    shortdata = data
		    
		    While shortdata.len > maxLength
		      start = shortdata.Len / 3
		      snip = mid(shortdata, start, 5)
		      shortdata = Replace(shortdata, snip, "...")
		    Wend
		    Return shortdata
		  End If
		  
		Exception err
		  Return data
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		BaseAddress As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private BytesDownloaded As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private CurrentFile As String
	#tag EndProperty

	#tag Property, Flags = &h0
		CurrentVersion As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		DownloadDirectory As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		Failed() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Files() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Icon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastMS As UInt64
	#tag EndProperty

	#tag Property, Flags = &h0
		LatestVersion As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SocketMode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private TempFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		UpdateAddress As String
	#tag EndProperty

	#tag Property, Flags = &h0
		UpdateInfo As JSONItem
	#tag EndProperty


	#tag Constant, Name = ErrorColor, Type = Color, Dynamic = False, Default = \"&c80000000", Scope = Private
	#tag EndConstant

	#tag Constant, Name = Mode_Checking, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = Mode_Downloading, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = Mode_Error, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NetColor, Type = Color, Dynamic = False, Default = \"&c0000FF00", Scope = Private
	#tag EndConstant

	#tag Constant, Name = OKColor, Type = Color, Dynamic = False, Default = \"&c00800000", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UpdateAvailColor, Type = Color, Dynamic = False, Default = \"&cFF804000", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events PushButton1
	#tag Event
		Sub Action()
		  If Me.Caption = "Check" Then
		    Me.Enabled = False
		    If Sock.IsConnected Then Sock.Close
		    Me.Caption = "Checking..."
		    CurrentAction.Text = "Checking..."
		    Sock.Get(UpdateAddress)
		    SocketMode = Mode_Checking
		  ElseIf Me.Caption = "Cancel" Then
		    If MsgBox("Abort update?", 52, "A download is in progress") = 6 Then
		      Self.Reset()
		      Self.Close
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Sock
	#tag Event
		Sub ReceiveProgress(bytesReceived as integer, totalBytes as integer, newData as string)
		  #pragma Unused newData
		  If SocketMode <> Mode_Error Then
		    Dim url As String = BaseAddress + CurrentFile
		    If url.Trim <> "" Then
		      CurrentAction.Text = "Getting " + Shorten(url)
		    Else
		      CurrentAction.Text = ""
		    End If
		    Status.Text = "Downloading update package (" + Format(ProgressBar2.Value, "###,##0") + "/" + Format(ProgressBar2.Maximum, "###,##0") + ")"
		    Status.TextColor = NetColor
		    ProgressBar1.Value = bytesReceived * 100 / totalBytes
		    BytesDownloaded = BytesDownloaded + bytesReceived
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub PageReceived(url as string, httpStatus as integer, headers as internetHeaders, content as string)
		  #pragma Unused url
		  #pragma Unused httpStatus
		  #pragma Unused headers
		  ProgressBar1.Value = 100
		  Select Case SocketMode
		  Case Mode_Checking
		    UpdateInfo = New JSONItem(content)
		    BaseAddress = UpdateInfo.Value("BaseURL")
		    LatestVersion = UpdateInfo.Value("Version")
		    HandleOptionalValues(UpdateInfo)
		    If LatestVersion > Currentversion Then
		      Status.Text = "An update package is available."
		      Status.TextColor = UpdateAvailColor
		      If MsgBox("A newer version is available. Would you like the download this update now?", 36, "An update is available.") = 6 Then
		        Dim items As JSONItem = UpdateInfo.Child("files")
		        DownloadDirectory = SpecialFolder.Temporary.Child(App.ExecutableFile.Name + "_Update")
		        DownloadDirectory.CreateAsFolder
		        Dim i As Integer
		        For i = 0 To items.Count - 1
		          Files.Append(items(i))
		        Next
		        ProgressBar2.Maximum = i
		        SocketMode = Mode_Downloading
		        GetTimer.Mode = Timer.ModeSingle
		        
		        
		      Else
		        Status.Text = "Upgrade was cancelled."
		        Status.TextColor = ErrorColor
		        Self.Reset
		        PushButton1.Caption = "Check"
		      End If
		    Else
		      Self.Reset
		      Status.Text = "No new versions available."
		      Status.TextColor = OKColor
		      Call MsgBox("There are no newer versions available.", 64, "You have the latest version")
		    End If
		    
		  Case Mode_Downloading
		    
		    Dim bs As BinaryStream
		    If TempFile = Nil Then TempFile = GetTemporaryFolderItem()
		    bs = bs.Create(TempFile, True)
		    bs.Write(content)
		    bs.Close
		    TempFile.MoveFileTo(DownloadDirectory)
		    GetTimer.Mode = Timer.ModeSingle
		    
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub HeadersReceived(headers as internetHeaders, httpStatus as integer)
		  Select Case httpStatus
		  Case 200
		    ProgressBar1.Value = 0
		    CurrentAction.Text = "Data incoming..."
		  Case 301, 302
		    ProgressBar1.Value = 0
		    CurrentAction.Text = "Following redirect..."
		    Me.Get(headers.CommaSeparatedValues("Location"))
		  Else
		    Reset(True)
		    Status.Text = "File skipped: HTTP error " + Str(httpStatus)
		    Status.TextColor = ErrorColor
		    CurrentAction.Text = "Error while downloading."
		    
		    
		  End Select
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(code as integer)
		  Self.Reset
		  Status.Text = "Socket error: " + Str(code)
		  Status.TextColor = ErrorColor
		  CurrentAction.Text = "Error while updating."
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub DownloadComplete(url as string, httpStatus as integer, headers as internetHeaders, file as folderItem)
		  #pragma Unused url
		  #pragma Unused httpStatus
		  #pragma Unused headers
		  #pragma Unused file
		  Status.Text = "Download complete."
		  Status.TextColor = OKColor
		  CurrentAction.Text = ""
		End Sub
	#tag EndEvent
	#tag Event
		Sub Connected()
		  CurrentAction.Text = "Connected to update server " + Shorten(Me.Address)
		  SpeedTimer.Mode = Timer.ModeMultiple
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UpdateIcon
	#tag Event
		Sub Paint(g As Graphics)
		  If Self.Icon <> Nil Then
		    g.DrawPicture(Self.Icon, 0, 0, g.Width, g.Height, 0, 0, Self.Icon.Width, Self.Icon.Height)
		  Else
		    g.ClearRect(0, 0, g.Width, g.Height)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GetTimer
	#tag Event
		Sub Action()
		  PushButton1.Enabled = True
		  PushButton1.Caption = "Cancel"
		  If UBound(Files) <= -1 Then
		    Me.Mode = Me.ModeOff
		    If MsgBox("Download complete. Would you like to apply this update now?", 36, "An update is ready to be applied.") = 6 Then
		      Self.Close
		    Else
		      Self.Reset()
		      Status.Text = "Upgrade was cancelled."
		      Status.TextColor = ErrorColor
		      PushButton1.Caption = "Check"
		    End If
		    Return
		  End If
		  
		  TempFile = GetTemporaryFolderItem()
		  CurrentFile = Files(0)
		  files.Remove(0)
		  TempFile.Name = NthField(CurrentFile, "/", CountFields(CurrentFile, "/"))
		  ProgressBar2.Value = ProgressBar2.Value + 1
		  Dim url As String = BaseAddress + CurrentFile
		  Sock.Get(url)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  If Sock.IsConnected Or UBound(Files) > -1 Then
		    If MsgBox("Abort update?", 52, "A download is in progress") = 6 Then
		      Self.Reset()
		      Self.Close()
		    End If
		  Else
		    Self.Close()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SpeedTimer
	#tag Event
		Sub Action()
		  Dim seconds As UInt64 = Microseconds - LastMS
		  seconds = seconds / 1000000
		  CurrentAction1.Text = FormatBytes(BytesDownloaded / seconds) + "/s"
		  LastMS = Microseconds
		  BytesDownloaded = 0
		End Sub
	#tag EndEvent
#tag EndEvents
