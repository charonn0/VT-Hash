#tag Window
Begin Window Window1
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   64
   ImplicitInstance=   True
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
   Title           =   "Sending Hash"
   Visible         =   True
   Width           =   301
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
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   0
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   23
   End
   Begin Label StaticText2
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
      Text            =   "MD5:"
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   14
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   30
   End
   Begin Label path
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
      Left            =   28
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
      Text            =   ""
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   0
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   271
   End
   Begin Label checkSum
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
      Left            =   37
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
      Text            =   ""
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   14
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   262
   End
   Begin ProgressBar ProgressBar1
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
      Width           =   297
   End
   Begin PushButton PushButton1
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
      Left            =   110
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
   Begin ProgressWheel ProgressWheel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   16
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   283
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   46
      Visible         =   True
      Width           =   16
   End
   Begin Label StaticText3
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
      Left            =   3
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
   Begin Timer Timer2
      Height          =   32
      Index           =   -2147483648
      Left            =   408
      LockedInPosition=   False
      Mode            =   2
      Period          =   300
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   -6
      Width           =   32
   End
   Begin Timer Timer1
      Height          =   32
      Index           =   -2147483648
      Left            =   364
      LockedInPosition=   False
      Mode            =   1
      Period          =   100
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   -6
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  about.Close
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  If algorithm = ALG_SHA1 Then
		    StaticText2.Text = "SHA1:"
		  end If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub getKey()
		  Timer2.Mode = Timer.ModeOff
		  
		  If VTAPIKey = "" Then
		    MsgBox("No API key found. Please enter your API key into the settings window.")
		    settswin.ShowModal
		    If VTAPIKey = "" Then
		      Quit(1)
		    Else
		      SaveSettings()
		    End If
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub initiate()
		  ProgressBar1.Value = 1
		  isValidFile()
		  Me.TitleText = toBeHashed.Name
		  If VTAPIKey = "" Then getKey()
		  ProgressBar1.Value = 2
		  Dim job As VTJob
		  Select Case algorithm
		  Case ALG_MD5
		    job = New VTJob(toBeHashed, Results.ALG_MD5)
		  Case ALG_SHA1
		    job = New VTJob(toBeHashed, Results.ALG_SHA1)
		  End Select
		  ProgressBar1.Value = 4
		  path.Text = toBeHashed.AbsolutePath.Shorten
		  checkSum.Text = Job.Hash
		  Job.GetResults()
		  ProgressBar1.Value = 5
		  resultWindows.Append(New resultWindow)
		  Self.Close
		  resultWindows(0).showList(Job.Response)
		  
		Exception Err As NilObjectException
		  Call MsgBox("VirusTotal.com supplied an invalid response. Please try again in a few minutes.", 16, "Illegal response format!")
		  Quit(1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub isValidFile()
		  If toBeHashed = Nil Or toBeHashed.AbsolutePath = App.ExecutableFile.AbsolutePath Then
		    Self.Visible = False
		    settswin.ShowModal
		    Quit(0)
		  End If
		  path.Text = toBeHashed.AbsolutePath.Shorten
		  If toBeHashed.Directory Then
		    Call MsgBox("Target Is A Directory.", 16, "File Read Error")
		    Quit(1)
		  End If
		  Select Case toBeHashed.isFound
		  Case FILE_NOT_FOUND
		    Call MsgBox("The file could not be found", 16, "File Read Error")
		    Quit(1)
		  Case ERROR_OTHER
		    Call MsgBox("Unknown error while attempting to read or open the file", 16, "File Read Error")
		    Quit(1)
		  Case ACCESS_DENIED
		    Call MsgBox("Unable to open the file: access is denied.", 16, "File Read Error")
		    Quit(1)
		  End Select
		  if toBeHashed.Length > 67108864 then
		    Call MsgBox("The file is larger than 64MB and therefore will not be found in Virus Total's Database.", 16, "File Too Large")
		    Quit(1)
		  End if
		  
		Exception err As NilObjectException
		  Call MsgBox("File does not exist", 16, "File Not Found")
		  Quit(1)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		TitleText As String
	#tag EndProperty


#tag EndWindowCode

#tag Events PushButton1
	#tag Event
		Sub Action()
		  If MsgBox("Cancel this operation?", 52, "VT Hash Check - Confirmation") = 6 Then
		    Quit()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StaticText3
	#tag Event
		Sub Open()
		  me.Text = "Version " + version
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Timer2
	#tag Event
		Sub Action()
		  Select Case Self.Title
		  case TitleText + ""
		    self.Title = TitleText + "."
		  case TitleText + "."
		    self.Title = TitleText + ".."
		  case TitleText + ".."
		    self.Title = TitleText + "..."
		  case "Uh Oh!"
		    me.Mode = me.ModeOff
		  else
		    self.Title = TitleText + ""
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Timer1
	#tag Event
		Sub Action()
		  initiate()
		  
		End Sub
	#tag EndEvent
#tag EndEvents
