#tag Window
Begin Window HashesViewer
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   1.31e+2
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
   Placement       =   0
   Resizeable      =   True
   Title           =   "Additional hashes"
   Visible         =   True
   Width           =   4.64e+2
   Begin PrettyListBox Listbox1
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   3
      ColumnsResizable=   ""
      ColumnWidths    =   "0%, 15%"
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
      Height          =   131
      HelpTag         =   ""
      Hierarchical    =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   " 	Algorithm	Value"
      Italic          =   ""
      Left            =   0
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   0
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   464
      _ScrollWidth    =   -1
   End
   Begin Thread HashThread
      Height          =   32
      Index           =   -2147483648
      Left            =   599
      LockedInPosition=   False
      Priority        =   5
      Scope           =   0
      StackSize       =   0
      TabPanelIndex   =   0
      Top             =   0
      Width           =   32
   End
   Begin Timer HashTimer
      Height          =   32
      Index           =   -2147483648
      Left            =   599
      LockedInPosition=   False
      Mode            =   2
      Period          =   50
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   44
      Width           =   32
   End
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Untitled"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   203
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
      Top             =   -54
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h1
		Protected Function CompareHash(Hash As String) As Integer
		  For i As Integer = 0 To Listbox1.ListCount - 1
		    If Listbox1.Cell(i, 2) = Hash Then Return i
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowHashes(Data As BinaryStream, ParentWindow As Window)
		  mLock = New Semaphore
		  ListBox1.DeleteAllRows
		  
		  ListBox1.AddRow("", "MD5", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_MD5
		  
		  ListBox1.AddRow("", "MD4", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_MD4
		  
		  ListBox1.AddRow("", "MD2", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_MD2
		  
		  'ListBox1.AddRow("", "CRC32", "Pending")
		  'ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_
		  
		  'ListBox1.AddRow("", "Adler32", "Pending")
		  'ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_
		  
		  ListBox1.AddRow("", "SHA1", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_SHA1
		  
		  ListBox1.AddRow("", "SHA256", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_SHA256
		  
		  ListBox1.AddRow("", "SHA384", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_SHA384
		  
		  ListBox1.AddRow("", "SHA512", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_SHA512
		  
		  DataStream = Data
		  Me.Show()
		  If ParentWindow <> Nil Then
		    Dim ScreenNumber As Integer = ScreenFromXY(parentWindow.Left, ParentWindow.Top)
		    ShowCentered(Me, ScreenNumber)
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private DataStream As BinaryStream
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentAlg As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHashValue As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLock As Semaphore
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProcessors() As Win32.Crypto.HashProcessor
	#tag EndProperty


#tag EndWindowCode

#tag Events Listbox1
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  Dim row As Integer = Me.RowFromXY(X, Y)
		  Dim ret As Boolean
		  If row > -1 And row = Me.ListIndex Then
		    Dim h As String = Me.Cell(row, 2)
		    Dim cp As New MenuItem("Copy to clipboard")
		    cp.Tag = h
		    base.Append(cp)
		    ret = True
		  End If
		  Dim cp As New Clipboard
		  If cp.TextAvailable Then
		    Dim m As New MenuItem("Compare to clipboard contents.")
		    m.Tag = cp.Text
		    base.Append(m)
		    ret = True
		  End If
		  Return ret
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  Select Case hitItem.Text
		  Case "Copy to clipboard"
		    Dim cp As New Clipboard
		    cp.Text = hitItem.Tag
		    Return True
		    
		  Case "Compare to clipboard contents."
		    Dim r As Integer = CompareHash(hitItem.Tag)
		    If r > -1 Then
		      Call MsgBox("Matches: " + Me.Cell(r, 1), 64, "Match found")
		    Else
		      Call MsgBox("No hashes match", 64, "No Matches")
		    End If
		    Return True
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.AcceptTextDrop
		End Sub
	#tag EndEvent
	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  #pragma Unused action
		  If obj.TextAvailable Then
		    Dim r As Integer = CompareHash(obj.Text)
		    If r > -1 Then
		      Call MsgBox("Matches: " + Me.Cell(r, 1), 64, "Match found")
		    Else
		      Call MsgBox("No hashes match", 64, "No Matches")
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HashThread
	#tag Event
		Sub Run()
		  While Not mLock.TrySignal
		    App.YieldToNextThread
		  Wend
		  Dim chunksz As Integer
		  If DataStream.Length > 1024 * 1024 Then chunksz = 1024 * 1024 Else chunksz = 4 * 1024
		  
		  ReDim mProcessors(-1)
		  For i As Integer = 0 To Listbox1.ListCount - 1
		    mProcessors.Append(New Win32.Crypto.HashProcessor(Listbox1.CellTag(i, 0).Int32Value))
		  Next
		  Try
		    DataStream.Position = 0
		    While Not DataStream.EOF
		      Dim data As MemoryBlock = DataStream.Read(chunksz)
		      For i As Integer = 0 To UBound(mProcessors)
		        mProcessors(i).Process(data)
		      Next
		    Wend
		  Finally
		    mLock.Release
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HashTimer
	#tag Event
		Sub Action()
		  If UBound(mProcessors) > -1 Then
		    If mLock.TrySignal Then
		      Try
		        For i As Integer = 0 To Listbox1.ListCount - 1
		          If Listbox1.CellTag(i, 0) = mProcessors(i).Algorithm Then
		            Listbox1.Cell(i, 2) = EncodeHex(mProcessors(i).Value)
		          End If
		        Next
		      Finally
		        mLock.Release
		      End Try
		    End If
		    Me.Mode = Timer.ModeOff
		  ElseIf mLock.TrySignal Then
		    mLock.Release
		    HashThread.Run
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
