#tag Window
Begin Window SuggestionBox
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   2.59e+2
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   1731862527
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Suggestion Box"
   Visible         =   True
   Width           =   4.27e+2
   Begin HTTPSocket Socket
      Address         =   ""
      BytesAvailable  =   0
      BytesLeftToSend =   0
      Enabled         =   True
      Height          =   32
      Index           =   -2147483648
      IsConnected     =   0
      Left            =   437
      LockedInPosition=   False
      Port            =   0
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   -15
      Visible         =   True
      Width           =   32
      yield           =   0
   End
   Begin PagePanel PagePanel1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   259
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Value           =   0
      Visible         =   True
      Width           =   425
      Begin Label Label1
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   48
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   ""
         Left            =   4
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   0
         Selectable      =   True
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Feedback, bug reports, praise, and criticisms are gratefully accepted. In addition to your comment, anonymous data about your computer will also be shared. Provide an e-mail address if you would like a reply."
         TextAlign       =   0
         TextColor       =   0
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   1
         Transparent     =   True
         Underline       =   ""
         Visible         =   True
         Width           =   419
      End
      Begin TextArea CommentText
         AcceptTabs      =   ""
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   True
         BackColor       =   16777215
         Bold            =   ""
         Border          =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   145
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   ""
         Left            =   4
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
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   0
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   87
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   419
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
         InitialParent   =   "PagePanel1"
         Italic          =   ""
         Left            =   327
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   236
         Underline       =   ""
         Visible         =   True
         Width           =   80
      End
      Begin LinkLabel CommentShowData
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
         InitialParent   =   "PagePanel1"
         Italic          =   ""
         Left            =   4
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Multiline       =   ""
         ResetPeriod     =   1000
         Scope           =   0
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "What is being shared?"
         TextAlign       =   0
         TextColor       =   &h000000FF
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   237
         Transparent     =   True
         Underline       =   ""
         Visible         =   True
         Width           =   152
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
         InitialParent   =   "PagePanel1"
         Italic          =   ""
         Left            =   241
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   236
         Underline       =   ""
         Visible         =   True
         Width           =   80
      End
      Begin TextField CommentName
         AcceptTabs      =   ""
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &hFFFFFF
         Bold            =   ""
         Border          =   True
         CueText         =   "Mysterious Stranger"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   ""
         Left            =   59
         LimitText       =   0
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Mask            =   ""
         Password        =   ""
         ReadOnly        =   ""
         Scope           =   0
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   61
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   148
      End
      Begin Label Label3
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
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
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Name:"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   61
         Transparent     =   False
         Underline       =   ""
         Visible         =   True
         Width           =   45
      End
      Begin TextField CommentAddress
         AcceptTabs      =   ""
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &hFFFFFF
         Bold            =   ""
         Border          =   True
         CueText         =   "root@example.net"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   ""
         Left            =   259
         LimitText       =   0
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Mask            =   ""
         Password        =   ""
         ReadOnly        =   ""
         Scope           =   0
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   ""
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   61
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   148
      End
      Begin Label Label4
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   ""
         Left            =   209
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   ""
         LockTop         =   True
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "e-mail:"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   61
         Transparent     =   False
         Underline       =   ""
         Visible         =   True
         Width           =   45
      End
      Begin LinkLabel ExtraInfoBack
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
         InitialParent   =   "PagePanel1"
         Italic          =   ""
         Left            =   4
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Multiline       =   ""
         ResetPeriod     =   1000
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Go Back"
         TextAlign       =   0
         TextColor       =   &h000000FF
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   237
         Transparent     =   True
         Underline       =   ""
         Visible         =   True
         Width           =   152
      End
      Begin PrettyListBox ExtraInfoView
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   ""
         Border          =   True
         ColumnCount     =   2
         ColumnsResizable=   True
         ColumnWidths    =   ""
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         Enabled         =   True
         EnableDrag      =   ""
         EnableDragReorder=   ""
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   -1
         Height          =   232
         HelpTag         =   ""
         Hierarchical    =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         InitialValue    =   "Key	Value"
         Italic          =   ""
         Left            =   4
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   ""
         Scope           =   0
         ScrollbarHorizontal=   ""
         ScrollBarVertical=   True
         SelectionType   =   0
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   6
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   419
         _ScrollWidth    =   -1
      End
      Begin PushButton PushButton3
         AutoDeactivate  =   True
         Bold            =   ""
         ButtonStyle     =   0
         Cancel          =   ""
         Caption         =   "Include File"
         Default         =   ""
         Enabled         =   True
         Height          =   18
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   ""
         Left            =   324
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   239
         Underline       =   ""
         Visible         =   True
         Width           =   95
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  PopulateInfo()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub PopulateExtraInfo()
		  ExtraInfoView.DeleteAllRows
		  If ExtraData.Count > 0 Then
		    For Each Key As String In ExtraData.Keys
		      If VarType(ExtraData.Value(Key)) = Variant.TypeString Then
		        Dim s As String = ExtraData.Value(Key)
		        ExtraInfoView.AddRow(Key, s)
		        ExtraInfoView.RowTag(ExtraInfoView.LastIndex) = s
		      ElseIf ExtraData.Value(Key) IsA FolderItem Then
		        Dim f As FolderItem = ExtraData.Value(Key)
		        ExtraInfoView.AddRow(Key, f.AbsolutePath)
		        ExtraInfoView.RowTag(ExtraInfoView.LastIndex) = f
		      End If
		    Next
		  Else
		    ExtraInfoView.AddRow("No additional data included")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PopulateInfo()
		  Dim OS As String = "Unknown"
		  Dim bits As String = "x32"
		  If Win32.Is64BitOS Then bits = "x64"
		  OS = "WinNT " + Str(Win32.OSVersion.MajorVersion) + "." + Str(Win32.OSVersion.MinorVersion) + "(" + Win32.OSVersion.ServicePackName + ")" + bits
		  Dim d As New Date
		  ExtraData.Value("Date") = d.SQLDateTime
		  ExtraData.Value("Version") = VTHash.VersionString
		  'ExtraData.Value("Algorithm") = "0x" + Hex(VTHash.GetConfig("Algorithm"))
		  ExtraData.Value("OS") = OS
		  Dim tmp As FolderItem = SpecialFolder.Temporary.Child("anonymized_config.dat")
		  Dim bs As BinaryStream = BinaryStream.Create(tmp, True)
		  Dim f As FolderItem = VTHash.Config.RootFile
		  VTHash.Config.Close
		  VTHash.Config = Nil
		  Dim ins As BinaryStream = BinaryStream.Open(f, False)
		  bs.Write(ins.Read(ins.Length))
		  bs.Close
		  ins.Close
		  Dim anon As PrefStore = PrefStore.Open(tmp)
		  Call anon.Delete("APIKey")
		  anon.Close
		  anon = Nil
		  ExtraData.Value("User's config.dat") = tmp
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowData(ParamArray FormElements() As Pair)
		  For Each p As Pair In FormElements
		    ExtraData.Value(p.Left) = p.Right
		  Next
		  Me.ShowModal
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mExtraData = Nil Then mExtraData = New Dictionary
			  return mExtraData
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mExtraData = value
			End Set
		#tag EndSetter
		ExtraData As Dictionary
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mExtraData As Dictionary
	#tag EndProperty


#tag EndWindowCode

#tag Events Socket
	#tag Event
		Sub Error(code as integer)
		  WaitWindow.Close
		  If code <> 102 Then Call MsgBox("Your comment was not submitted, please try again later.", 16, "Error " + Str(code))
		End Sub
	#tag EndEvent
	#tag Event
		Sub PageReceived(url as string, httpStatus as integer, headers as internetHeaders, content as string)
		  WaitWindow.Close
		  If httpStatus = 200 Then
		    Call MsgBox("Your comment was submitted successfully.", 64, "Comment submitted")
		    Self.Close
		  Else
		    Call MsgBox("Your comment was not submitted, please try again later.", 16, "HTTP Error " + Str(httpStatus))
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  If CommentText.Text.Trim = "" And Not ExtraData.HasKey("Exception") Then
		    Call MsgBox("Please enter a comment", 16, "Missing Information")
		    Return
		  End If
		  
		  Dim email As String
		  ' formsubmityXuvQY4boredomsoft.org
		  Dim d() As Integer = Array(102, 111, 114, 109, 115, 117, 98, 109, 105, 116, 121, _
		  88, 117, 118, 81, 89, 52, 98, 111, 114, 101, 100, 111, 109, 115, 111, 102, 116, _
		  46, 111, 114, 103)
		  For i As Integer = 0 To UBound(d)
		    email = email + Chr(d(i))
		  Next
		  
		  Dim form As New VTHash.MultipartForm
		  form.Element("env_report") = "REMOTE_HOST,REMOTE_ADDR,HTTP_USER_AGENT,AUTH_TYPE,REMOTE_USER"
		  form.Element("recipients") = email
		  'form.Element("required") = "Comment:Your comment"
		  form.Element("subject") = "Comment on " + VTHash.UserAgent
		  form.Element("Comment") = CommentText.Text
		  If CommentName.Text <> "" Then form.Element("realname") = CommentName.Text
		  If CommentAddress.Text <> "" Then form.Element("email") = CommentAddress.Text
		  For Each key As String In ExtraData.Keys
		    form.Element(key) = ExtraData.Value(key)
		  Next
		  Socket.SetPostContent(form.ToString, form.Type.ToString)
		  Socket.SetRequestHeader("User-Agent", VTHash.UserAgent)
		  WaitWindow.ShowWithin(Self)
		  
		  'http://www.boredomsoft.org/formsubmit.php
		  d = Array(104, 116, 116, 112, 58, 47, 47, 119, 119, 119, 46, 98, 111, 114, 101, _
		  100, 111, 109, 115, 111, 102, 116, 46, 111, 114, 103, 47, 102, 111, 114, 109, 115, 117, 98, _
		  109, 105, 116, 46, 112, 104, 112)
		  Dim URL As String
		  For i As Integer = 0 To UBound(d)
		    URL = URL + Chr(d(i))
		  Next
		  Socket.Post(URL)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CommentShowData
	#tag Event
		Sub Action()
		  PopulateExtraInfo()
		  PagePanel1.Value = 1
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ExtraInfoBack
	#tag Event
		Sub Action()
		  PagePanel1.Value = 0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ExtraInfoView
	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  #pragma Unused x
		  #pragma Unused y
		  If column <> 1 Then Return False
		  If row > -1 And row < Me.ListCount Then
		    Select Case Me.RowTag(row)
		    Case Is = Nil
		      
		    Case IsA FolderItem
		      If Not Me.Selected(row) Then g.ForeColor = &c0000FF00
		      g.Underline = True
		      
		    End Select
		  End If
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  Dim row, column As Integer
		  row = Me.RowFromXY(X, Y)
		  column = Me.ColumnFromXY(X, Y)
		  If column <> 1 Then Return
		  If row > -1 And row < Me.ListCount And Me.RowTag(row) <> Nil Then
		    If Me.RowTag(row) IsA FolderItem Then
		      Me.MouseCursor = System.Cursors.FingerPointer
		      Return
		    End If
		  End If
		  Me.MouseCursor = System.Cursors.StandardPointer
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  Dim r, c As Integer
		  c = Me.ColumnFromXY(x, y)
		  r = Me.RowFromXY(x, y)
		  If r < 0 Or c < 0 Then Return False
		  Dim iseditable As Boolean = Me.Cell(r, 0) <> "Exception" And Not mExtraData.Value(Me.Cell(r, 0)) IsA FolderItem
		  Return iseditable And r < Me.ListCount And r > -1 And c = 1
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  Dim row, column As Integer
		  row = Me.RowFromXY(X, Y)
		  column = Me.ColumnFromXY(X, Y)
		  If column <> 1 Then Return
		  If row > -1 And row < Me.ListCount And Me.RowTag(row) <> Nil Then
		    If Me.RowTag(row) IsA FolderItem Then
		      Dim f As FolderItem = Me.RowTag(row)
		      f.ShowInExplorer
		    Else
		      Me.CellType(row, column) = Listbox.TypeEditable
		      Me.EditCell(row, column)
		    End If
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Dim name, value As String
		  name = Me.Cell(row, 0)
		  value = Me.Cell(row, 1)
		  ExtraData.Value(name) = value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton3
	#tag Event
		Sub Action()
		  Dim f As FolderItem = GetOpenFolderItem("")
		  If f = Nil Then Return
		  Dim name As String = "file"
		  Dim j As Integer
		  Do Until Not ExtraData.HasKey(name)
		    j = j + 1
		    name = "file" + Str(j)
		  Loop
		  ExtraData.Value(name) = f
		  PopulateExtraInfo()
		End Sub
	#tag EndEvent
#tag EndEvents
