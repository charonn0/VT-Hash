#tag Window
Begin Window CommentWindow
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   False
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   1.1e+2
   ImplicitInstance=   True
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
   Placement       =   0
   Resizeable      =   True
   Title           =   "VirusTotal Community - Comment On This Result"
   Visible         =   True
   Width           =   3.31e+2
   Begin TextArea TextArea1
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
      Height          =   76
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   ""
      Left            =   0
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   0
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   331
   End
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Submit"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   165
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   82
      Underline       =   ""
      Visible         =   True
      Width           =   80
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
      Left            =   85
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
      Top             =   82
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
   Begin Canvas VoteSafe
      AcceptFocus     =   True
      AcceptTabs      =   True
      AutoDeactivate  =   True
      Backdrop        =   ""
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   19
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   6
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   82
      UseFocusRing    =   True
      Visible         =   True
      Width           =   22
   End
   Begin Canvas VoteDangerous
      AcceptFocus     =   True
      AcceptTabs      =   True
      AutoDeactivate  =   True
      Backdrop        =   ""
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   19
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   32
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   82
      UseFocusRing    =   True
      Visible         =   True
      Width           =   22
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function GetComment(X As Integer, Y As Integer) As String
		  Me.Left = X
		  Me.Top = Y - 0.5 * Me.Height
		  Me.ShowModal
		  Return Comment
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetMalwareVote()
		  Dim comment As String = TextArea1.Text
		  Dim caretpos As Integer = TextArea1.SelStart
		  While InStr(comment, "#malware ") > 0
		    comment = Replace(comment, "#malware ", "")
		  Wend
		  
		  While InStr(comment, "#goodware ") > 0
		    comment = Replace(comment, "#goodware ", "")
		  Wend
		  
		  Select Case VoteState
		  Case 1 ' safe
		    TextArea1.Text = "#goodware " + comment
		    VoteSafe.HelpTag = "Remove safe tag"
		    VoteDangerous.HelpTag = "Tag this file as dangerous"
		  Case 2 ' bad
		    TextArea1.Text = "#malware " + comment
		    VoteSafe.HelpTag = "Tag this file as safe"
		    VoteDangerous.HelpTag = "Remove dangerous tag"
		  Else ' no vote
		    TextArea1.Text = comment
		    VoteSafe.HelpTag = "Tag this file as safe"
		    VoteDangerous.HelpTag = "Tag this file as dangerous"
		  End Select
		  If caretpos > TextArea1.Text.Len Then caretpos = TextArea1.Text.Len
		  TextArea1.SelStart = caretpos
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Comment As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected VBOver As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected VoteState As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		VSOver As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events TextArea1
	#tag Event
		Sub TextChange()
		  Dim t1, t2 As Integer
		  t1 = Instr(Me.Text, "#goodware ")
		  t2 = Instr(Me.Text, "#malware ")
		  If t2 = 0 And t1 > 0 Then
		    VoteState = 1
		  ElseIf t1 = 0 And t2 > 0 Then
		    VoteState = 2
		  Else
		    VoteState = 0
		  End If
		  VoteDangerous.Invalidate(True)
		  VoteSafe.Invalidate(True)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  If TextArea1.Text.Trim <> "" Then
		    Comment = TextArea1.Text.Trim + EndOfLine + VTHash.GetConfig("CommentSignature").Trim
		  Else
		    Comment = ""
		  End If
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  Comment = ""
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VoteSafe
	#tag Event
		Sub Paint(g As Graphics)
		  If VSOver Or VoteState = 1 Then
		    g.DrawPicture(greenshield, 0, 0)
		  Else
		    g.DrawPicture(graygreenshield, 0, 0)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  #pragma Unused X
		  #pragma Unused Y
		  Me.Invalidate(True)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  VSOver = True
		  Me.Invalidate(True)
		  Me.MouseCursor = System.Cursors.FingerPointer
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  VSOver = False
		  Me.Invalidate(True)
		  Me.MouseCursor = System.Cursors.StandardPointer
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  #pragma Unused X
		  #pragma Unused Y
		  If VoteState = 1 Then
		    VoteState = 0 ' no vote
		  Else
		    VoteState = 1 ' 1 = vote safe
		  End If
		  SetMalwareVote()
		  Me.Invalidate(True)
		  VoteDangerous.Invalidate(True)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.HelpTag = "Tag this file as safe"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VoteDangerous
	#tag Event
		Sub Paint(g As Graphics)
		  If VBOver Or VoteState = 2 Then
		    g.DrawPicture(redshield, 0, 0)
		  Else
		    g.DrawPicture(grayredshield, 0, 0)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  #pragma Unused X
		  #pragma Unused Y
		  Me.Invalidate(True)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  VBOver = True
		  Me.Invalidate(True)
		  Me.MouseCursor = System.Cursors.FingerPointer
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  VBOver = False
		  Me.Invalidate(True)
		  Me.MouseCursor = System.Cursors.StandardPointer
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  #pragma Unused X
		  #pragma Unused Y
		  If VoteState = 2 Then
		    VoteState = 0 ' no vote
		  Else
		    VoteState = 2 ' 2 = vote bad
		  End If
		  SetMalwareVote()
		  Me.Invalidate(True)
		  VoteSafe.Invalidate(True)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.HelpTag = "Tag this file as dangerous"
		End Sub
	#tag EndEvent
#tag EndEvents
