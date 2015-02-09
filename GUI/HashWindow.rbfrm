#tag Window
Begin Window HashWindow
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   6.4e+1
   ImplicitInstance=   False
   LiveResize      =   True
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
   Resizeable      =   False
   Title           =   "Calculating hash..."
   Visible         =   True
   Width           =   3.43e+2
   Begin Label StaticText1
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
      Left            =   2
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
      Text            =   "File:"
      TextAlign       =   2
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   0
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   49
   End
   Begin Label HashName
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
      Left            =   2
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
      Text            =   "SHA512:"
      TextAlign       =   2
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   14
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   49
   End
   Begin Label PathText
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
      Left            =   57
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
      Text            =   "Z:\\My Folder\\MySubFolder\\MyFile.exe"
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   0
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   286
   End
   Begin Label HashText
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
      Left            =   57
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
      Text            =   00000000000000000000000000000000000000000000000000000000000000000000
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   14
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   279
   End
   Begin ProgressBar HashProgress
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   12
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   2
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Maximum         =   5
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   32
      Value           =   0
      Visible         =   True
      Width           =   341
   End
   Begin PushButton CancelButton
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   True
      Enabled         =   True
      Height          =   18
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   131
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
      TextSize        =   11
      TextUnit        =   0
      Top             =   46
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin LinkLabel VersionText
      ActiveColor     =   "&cFF0000"
      AltText         =   ""
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Draggable       =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      HilightColor    =   "&c00FFFF"
      HoverPeriod     =   250
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   3
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Multiline       =   ""
      ResetPeriod     =   1000
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      Text            =   "Version 0.86"
      TextAlign       =   0
      TextColor       =   8421504
      TextFont        =   "System"
      TextSize        =   9
      TextUnit        =   0
      Top             =   46
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   86
   End
   Begin Thread Hasher
      Height          =   32
      Index           =   -2147483648
      Left            =   425
      LockedInPosition=   False
      Priority        =   5
      Scope           =   0
      StackSize       =   0
      TabPanelIndex   =   0
      Top             =   -31
      Width           =   32
   End
   Begin VTHash.VTSession VTSocket
      APIKey          =   ""
      CertificateFile =   ""
      CertificatePassword=   ""
      CertificateRejectionFile=   ""
      ConnectionType  =   3
      Height          =   32
      Index           =   -2147483648
      Left            =   425
      LockedInPosition=   False
      Scope           =   1
      Secure          =   True
      TabPanelIndex   =   0
      Top             =   0
      Width           =   32
   End
   Begin Timer GUITimer
      Height          =   32
      Index           =   -2147483648
      Left            =   462
      LockedInPosition=   False
      Mode            =   0
      Period          =   1
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   2
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub ProcessFile(File As FolderItem)
		  mTargetFile = File
		  Hasher.Run
		  Me.Show
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private HashPercent As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTargetFile As FolderItem
	#tag EndProperty


#tag EndWindowCode

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
		    Quit()
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
		    GUITimer.Mode = Timer.ModeSingle
		  Wend
		  bs.Close
		  mHash = ConvertEncoding(Win32.Crypto.EncodeHex(hp.Value).Uppercase, Encodings.UTF8)
		  GUITimer.Mode = Timer.ModeSingle
		  App.YieldToNextThread
		  VTSocket.APIKey = VTHash.GetConfig("APIKey")
		  VTSocket.GetReport(mHash, VTHash.RequestType.FileReport)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VTSocket
	#tag Event
		Sub Response(ResponseObject As JSONItem, HTTPStatus As Integer)
		  If HTTPStatus = 200 And ResponseObject <> Nil Then
		    Dim rw As New ResultWindow
		    Dim v As New VTHash.Results(ResponseObject, mTargetFile)
		    v.HashValue = mHash
		    rw.ShowResult(v)
		    Self.Close
		  Else
		    Break
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(code as integer)
		  Break
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GUITimer
	#tag Event
		Sub Action()
		  PathText.Text = mTargetFile.AbsolutePath
		  HashText.Text = mHash
		  HashProgress.Value = HashPercent
		End Sub
	#tag EndEvent
#tag EndEvents
