#tag Window
Begin Window HashesViewer
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   HasFullScreenButton=   False
   Height          =   131
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Additional hashes"
   Visible         =   True
   Width           =   464
   Begin PrettyListBox HashResultList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   3
      ColumnsResizable=   False
      ColumnWidths    =   "0%, 15%"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   131
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   " 	Algorithm	Value"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   464
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Thread HashThread
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   0
      StackSize       =   0
      TabPanelIndex   =   0
   End
   Begin Timer HashTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   50
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin PushButton CancelBtn
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   203
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   -54
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h1
		Protected Function CompareHash(Hash As String) As Integer
		  For i As Integer = 0 To HashResultList.ListCount - 1
		    If HashResultList.Cell(i, 2) = Hash Then Return i
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowHashes(Data As BinaryStream, ParentWindow As Window)
		  mLock = New Semaphore
		  HashResultList.DeleteAllRows
		  
		  HashResultList.AddRow("", "MD5", "Pending")
		  HashResultList.CellTag(HashResultList.LastIndex, 0) = Win32.Crypto.CALG_MD5
		  
		  HashResultList.AddRow("", "MD4", "Pending")
		  HashResultList.CellTag(HashResultList.LastIndex, 0) = Win32.Crypto.CALG_MD4
		  
		  HashResultList.AddRow("", "MD2", "Pending")
		  HashResultList.CellTag(HashResultList.LastIndex, 0) = Win32.Crypto.CALG_MD2
		  
		  'HashResultList.AddRow("", "CRC32", "Pending")
		  'HashResultList.CellTag(HashResultList.LastIndex, 0) = Win32.Crypto.CALG_
		  
		  'HashResultList.AddRow("", "Adler32", "Pending")
		  'HashResultList.CellTag(HashResultList.LastIndex, 0) = Win32.Crypto.CALG_
		  
		  HashResultList.AddRow("", "SHA1", "Pending")
		  HashResultList.CellTag(HashResultList.LastIndex, 0) = Win32.Crypto.CALG_SHA1
		  
		  If Win32.KernelVersion >= 6.0 Then
		    HashResultList.AddRow("", "SHA256", "Pending")
		    HashResultList.CellTag(HashResultList.LastIndex, 0) = Win32.Crypto.CALG_SHA256
		    HashResultList.AddRow("", "SHA384", "Pending")
		    HashResultList.CellTag(HashResultList.LastIndex, 0) = Win32.Crypto.CALG_SHA384
		    
		    HashResultList.AddRow("", "SHA512", "Pending")
		    HashResultList.CellTag(HashResultList.LastIndex, 0) = Win32.Crypto.CALG_SHA512
		  End If
		  
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


#tag EndWindowCode

#tag Events HashResultList
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
		  
		  Try
		    Dim h As New Win32.Crypto.HashProcessor(mCurrentAlg)
		    DataStream.Position = 0
		    While Not DataStream.EOF
		      h.Process(DataStream.Read(chunksz))
		    Wend
		    mHashValue = h.Value
		  Finally
		    mLock.Release
		  End Try
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HashTimer
	#tag Event
		Sub Action()
		  If mLock.TrySignal Then
		    Try
		      If mCurrentAlg > 0 Then
		        For i As Integer = 0 To HashResultList.ListCount - 1
		          If HashResultList.CellTag(i, 0) = mCurrentAlg Then
		            HashResultList.Cell(i, 2) = EncodeHex(mHashValue)
		            Exit For
		          End If
		        Next
		      End If
		      
		      For i As Integer = 0 To HashResultList.ListCount - 1
		        If HashResultList.Cell(i, 2) = "Pending" Then
		          mCurrentAlg = HashResultList.CellTag(i, 0)
		          mHashValue = ""
		          HashResultList.Cell(i, 2) = "Calculating..."
		          Exit For
		        ElseIf i = HashResultList.ListCount - 1 Then
		          Me.Mode = Timer.ModeOff
		        End If
		      Next
		      HashThread.Run
		    Catch Err As ThreadAlreadyRunningException
		      Me.Mode = Timer.ModeOff
		    Finally
		      mLock.Release
		    End Try
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CancelBtn
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
