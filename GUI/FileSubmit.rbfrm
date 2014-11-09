#tag Window
Begin Window FileSubmit
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   False
   Composite       =   False
   Frame           =   0
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
   Width           =   3.49e+2
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
      Top             =   23
      Value           =   0
      Visible         =   True
      Width           =   315
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
      LockRight       =   True
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
      Width           =   329
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
      LockRight       =   True
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
      Width           =   315
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
      Left            =   114
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
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
      Width           =   115
   End
   Begin VTHash.VTSession Socket
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
   Begin Label Percentages
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   23
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   14
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      Text            =   "%0 of %0 bytes sent"
      TextAlign       =   0
      TextColor       =   &h00808080
      TextFont        =   "System"
      TextSize        =   10
      TextUnit        =   0
      Top             =   33
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   315
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Function CreateURLShortcut(URL As String, ShortcutName As String, IconResource As FolderItem = Nil, IconIndex As Integer = - 1) As FolderItem
		  #pragma BreakOnExceptions Off
		  //Creates a shortcut (.url file) in the users %TEMP% directory named ShortcutName and pointing to URL. Returns
		  //a FolderItem corresponding to the shortcut file. You must move the returned Shortcut file to the desired directory.
		  //On error, returns Nil.
		  //You may optionally pass an IconResource and IconIndex. The IconResource is a Windows resource file that has icon resources,
		  //for example EXE, DLL, SYS, ICO, and CUR files. The IconIndex parameter is the index of the icon in the IconResource file.
		  
		  
		  #If TargetWin32 Then
		    Dim lnkObj As OLEObject
		    Dim scriptShell As New OLEObject("Wscript.shell")
		    
		    If scriptShell <> Nil then
		      lnkObj = scriptShell.CreateShortcut(SpecialFolder.Temporary.AbsolutePath + ShortcutName + ".url")
		      If lnkObj <> Nil then
		        lnkObj.TargetPath = URL
		        lnkObj.Save
		        
		        Dim optionalparams As String
		        
		        If IconResource <> Nil Then optionalparams = "IconFile=" + IconResource.AbsolutePath + EndOfLine.Windows + _
		        "IconIndex=" + Str(IconIndex) + EndOfLine
		        
		        If optionalparams.Trim <> "" Then
		          Dim tos As TextOutputStream
		          tos = tos.Append(SpecialFolder.Temporary.TrueChild(ShortcutName + ".url"))
		          tos.Write(optionalparams)
		          tos.Close
		        End If
		        
		        Return SpecialFolder.Temporary.TrueChild(ShortcutName + ".url")
		      End If
		    End If
		  #endif
		  
		Exception OLEException
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubmitFile(parentWindow As Window, File As FolderItem, APIKey As String)
		  Socket.APIKey = APIKey
		  Socket.SubmitFile(File)
		  TargetFile = File
		  fLength = TargetFile.Length
		  Dim ScreenNumber As Integer = ScreenFromXY(parentWindow.Left, ParentWindow.Top)
		  ShowCentered(Me, ScreenNumber)
		  Me.ShowModal
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected fLength As Integer
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
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  '#pragma Unused X
		  '#pragma Unused Y
		  'Dim copylink As New MenuItem("Copy link")
		  'Dim openlink As New MenuItem("Open link")
		  ''Dim makeshortcut As New MenuItem("Create desktop shortcut")
		  '
		  'base.Append(copylink)
		  'base.Append(openlink)
		  ''base.Append(makeshortcut)AX
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  'Select Case hitItem.Text
		  'Case "Copy link"
		  'Dim cp As New Clipboard
		  'cp.SetText(Me.URL)
		  'Return True
		  '
		  'Case "Create desktop shortcut"
		  'Dim shortcut As FolderItem = CreateURLShortcut(Me.URL, Me.Text)
		  'If shortcut <> Nil Then shortcut.MoveFileTo(SpecialFolder.Desktop)
		  '
		  'Return True
		  '
		  '
		  'Case "Open link"
		  'ShowURL(Me.URL)
		  'Return True
		  '
		  'End Select
		End Function
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
		Sub Error(code as integer)
		  Percentages.Text = ""
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
		  tTotal = tTotal + bytesSent
		  'Dim snt As Integer = TargetFile.Length - bytesLeft
		  ProgressBar1.Value = tTotal * 100 \ fLength
		  Percentages.Text = FormatBytes(tTotal) + " of " + FormatBytes(fLength) + " bytes sent"
		  If ProgressBar1.Value >= ProgressBar1.Maximum Then
		    Label1.Text = "Awaiting response..."
		  Else
		    Label1.Text = "Sending file..."
		  End If
		  '11App.YieldToNextThread
		End Function
	#tag EndEvent
	#tag Event
		Sub Response(ResponseObject As JSONItem, HTTPStatus As Integer)
		  If HTTPStatus = 200 And ResponseObject <> Nil Then
		    If ResponseObject.Value("response_code") = VT_Code_OK Then
		      PermaURL = ResponseObject.Value("permalink")
		      Permalink.Visible = True
		      Permalink.URL = PermaURL
		      Label1.Text = "Upload complete."
		    Else
		      Label1.Text = "Upload error."
		      MsgBox("Virus Total says: (" + Str(ResponseObject.Value("response_code").Int32Value) + ") " + ResponseObject.Value("verbose_msg"))
		    End If
		  Else
		    Label1.Text = "Upload error."
		    MsgBox("Error: " + Str(HTTPStatus) + ".")
		  End If
		  PushButton1.Caption = "Close"
		  ProgressBar1.Value = ProgressBar1.Maximum
		End Sub
	#tag EndEvent
#tag EndEvents
