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
      TabIndex        =   0
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
      TabIndex        =   1
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
      TabIndex        =   3
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
      Cancel          =   ""
      Caption         =   "Cancel"
      Default         =   ""
      Enabled         =   True
      Height          =   18
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   101
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   4
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
      TabIndex        =   5
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
      TabIndex        =   6
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
      Left            =   177
      LockedInPosition=   False
      Mode            =   2
      Period          =   300
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   94
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
		  If algorithm = "SHA1" Then
		    StaticText2.Text = "SHA1:"
		  end If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub getKey()
		  Timer2.Mode = Timer.ModeOff
		  
		  If VTAPIKey = "" Then
		    VTAPIKey = editAPI.ShowMe
		    If VTAPIKey = "" Then
		      Quit(1)
		    Else
		      SaveSettings()
		    End If
		  end if
		Exception err As NilObjectException
		  VTAPIKey = editAPI.ShowMe
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub initiate()
		  If useSSL Then
		    Dim sendPoster As New SSLposter
		    sendIt(sendPoster)
		  Else
		    Dim sendPoster As New poster
		    sendIt(sendPoster)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isValidFile() As Boolean
		  If toBeHashed.AbsolutePath = App.ExecutableFile.Parent.AbsolutePath Then
		    Self.Visible = False
		    settswin.ShowMe
		    'Call MsgBox("You Must Specify A File.", 16, "File Read Error")
		    Return False
		  End If
		  path.Text = pretifyPath(toBeHashed.AbsolutePath)
		  If toBeHashed.Directory Then
		    Call MsgBox("Target Is A Directory.", 16, "File Read Error")
		    Return False
		  End If
		  Select Case toBeHashed.isFound
		  Case FILE_NOT_FOUND
		    Call MsgBox("File Does Not Exist", 16, "File Read Error")
		    Return False
		  Case ERROR_OTHER
		    Call MsgBox("Unknown Error While Reading File", 16, "File Read Error")
		    Return False
		  Case ACCESS_DENIED
		    Call MsgBox("Could Not Open The File. Access Was Denied.", 16, "File Read Error")
		    Return False
		  End Select
		  if toBeHashed.Length > 33554432 then
		    Call MsgBox("File Exceeds 32MB and therefore will not be found in Virus Total's Database.", 16, "File Too Large")
		    #If Not DebugBuild Then
		      Return False
		    #Else
		      Return True
		    #endif
		  End if
		  
		  Return True
		  
		Exception err As NilObjectException
		  Call MsgBox("File Does Not Exist", 16, "File Not Found")
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendIt(sock As poster)
		  
		  if isValidFile = False Then
		    self.Close
		  else
		    If VTAPIKey = "" Then getKey()
		    
		    dim makeHash As  new hasher
		    
		    Select Case algorithm
		    case "MD5"
		      theHash = makeHash.hashIt(toBeHashed, "MD5")
		    case "SHA1"
		      'StaticText2.Text = "SHA1"
		      theHash = makeHash.hashIt(toBeHashed, "SHA1")
		    else
		      MsgBox("Unknown algorithm specified!")
		      self.Close
		    end Select
		    
		    path.Text = pretifyPath(toBeHashed.AbsolutePath)
		    checkSum.Text = theHash
		    sock.sendTheHash(theHash)
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub sendIt(sock As SSLPoster)
		  if isValidFile = False Then
		    self.Close
		  else
		    if VTAPIKey = "" Then getKey()
		    
		    dim makeHash As  new hasher
		    
		    Select Case algorithm
		    case "MD5"
		      theHash = makeHash.hashIt(toBeHashed, "MD5")
		    case "SHA1"
		      StaticText2.Text = "SHA1"
		      theHash = makeHash.hashIt(toBeHashed, "SHA1")
		    else
		      MsgBox("Unknown algorithm specified!")
		      self.Close
		    end Select
		    
		    path.Text = pretifyPath(toBeHashed.AbsolutePath)
		    checkSum.Text = theHash
		    sock.sendTheHash(theHash)
		    
		  end if
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events PushButton1
	#tag Event
		Sub Action()
		  cancel = True
		  self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Timer1
	#tag Event
		Sub Action()
		  If DebugBuild Then Return
		  if aboutSwitch = True then
		    self.Hide
		    about.Show
		  else
		    initiate()
		  end if
		  
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
		  case "Sending Hash"
		    self.Title = "Sending Hash."
		  case "Sending Hash."
		    self.Title = "Sending Hash.."
		  case "Sending Hash.."
		    self.Title = "Sending Hash..."
		  case "Uh Oh!"
		    me.Mode = me.ModeOff
		  else
		    self.Title = "Sending Hash"
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
