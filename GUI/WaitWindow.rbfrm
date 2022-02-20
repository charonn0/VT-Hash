#tag Window
Begin Window WaitWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   4
   FullScreen      =   False
   HasBackColor    =   False
   HasFullScreenButton=   False
   Height          =   64
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
   Title           =   "Deep Thoughts"
   Visible         =   True
   Width           =   160
   Begin Label Label1
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   64
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Thinking..."
      TextAlign       =   1
      TextColor       =   &c000000
      TextFont        =   "System"
      TextSize        =   24.0
      TextUnit        =   0
      Top             =   0
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   160
      Begin ProgressWheel ProgressWheel1
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   16
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "Label1"
         Left            =   9
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Top             =   28
         Transparent     =   True
         Visible         =   True
         Width           =   16
      End
      Begin ProgressBar ProgressBar1
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   8
         HelpTag         =   ""
         Indeterminate   =   False
         Index           =   -2147483648
         InitialParent   =   "Label1"
         Left            =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         Maximum         =   0
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   "True"
         Top             =   56
         Transparent     =   True
         Value           =   0.0
         Visible         =   True
         Width           =   160
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  mTaskBar = New TaskBar(Self)
		  mTaskBar.SetProgressState(TaskBar.TaskBarStates.Indeterminate)
		  mTaskBar.SetProgressValue(50, 100)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub SetProgress(Value As Integer, Max As Integer)
		  If Self.Visible Then
		    ProgressBar1.Maximum = 100
		    ProgressBar1.Value = Value * 100 / Max
		    mTaskBar.SetProgressState(TaskBar.TaskBarStates.Normal)
		    mTaskBar.SetProgressValue(Value, Max)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowWithin(parentWindow As Window, facing As Integer = - 1)
		  Super.ShowWithin(parentWindow, facing)
		  Dim w, h As Integer
		  w = parentWindow.Left + (0.25 * Me.Width) + (0.25 * parentWindow.Width)
		  h = parentWindow.Top + (0.25 * Me.Height) + (0.25 * parentWindow.Height)
		  Me.Left = w
		  Me.Top = h
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mTaskBar As TaskBar
	#tag EndProperty


#tag EndWindowCode

