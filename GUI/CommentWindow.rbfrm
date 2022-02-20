#tag Window
Begin Window CommentWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   HasFullScreenButton=   False
   Height          =   110
   ImplicitInstance=   True
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
   Placement       =   0
   Resizeable      =   True
   Title           =   "VirusTotal Community - Comment On This Result"
   Visible         =   True
   Width           =   331
   Begin TextArea CommentTextArea
      AcceptTabs      =   True
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   76
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   0
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Transparent     =   True
      Underline       =   False
      UnicodeMode     =   0
      UseFocusRing    =   True
      Visible         =   True
      Width           =   331
   End
   Begin PushButton SubmitBtn
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Submit"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   165
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   82
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
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
      Left            =   85
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
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
      Width           =   80
   End
   Begin Canvas VoteSafe
      AcceptFocus     =   True
      AcceptTabs      =   True
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      Height          =   19
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   6
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   82
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   22
   End
   Begin Canvas VoteDangerous
      AcceptFocus     =   True
      AcceptTabs      =   True
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   True
      Enabled         =   True
      Height          =   19
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   32
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   82
      Transparent     =   True
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
		  Dim comment As String = CommentTextArea.Text
		  Dim caretpos As Integer = CommentTextArea.SelStart
		  While InStr(comment, "#malware ") > 0
		    comment = Replace(comment, "#malware ", "")
		  Wend
		  
		  While InStr(comment, "#goodware ") > 0
		    comment = Replace(comment, "#goodware ", "")
		  Wend
		  
		  Select Case VoteState
		  Case 1 ' safe
		    CommentTextArea.Text = "#goodware " + comment
		    VoteSafe.HelpTag = "Remove safe tag"
		    VoteDangerous.HelpTag = "Tag this file as dangerous"
		  Case 2 ' bad
		    CommentTextArea.Text = "#malware " + comment
		    VoteSafe.HelpTag = "Tag this file as safe"
		    VoteDangerous.HelpTag = "Remove dangerous tag"
		  Else ' no vote
		    CommentTextArea.Text = comment
		    VoteSafe.HelpTag = "Tag this file as safe"
		    VoteDangerous.HelpTag = "Tag this file as dangerous"
		  End Select
		  If caretpos > CommentTextArea.Text.Len Then caretpos = CommentTextArea.Text.Len
		  CommentTextArea.SelStart = caretpos
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

#tag Events CommentTextArea
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
#tag Events SubmitBtn
	#tag Event
		Sub Action()
		  If CommentTextArea.Text.Trim <> "" Then
		    Comment = Trim(CommentTextArea.Text) + EndOfLine + VTHash.GetConfig("CommentSignature")
		  Else
		    Comment = ""
		  End If
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelBtn
	#tag Event
		Sub Action()
		  Comment = ""
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events VoteSafe
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #pragma Unused areas
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
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #pragma Unused areas
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
