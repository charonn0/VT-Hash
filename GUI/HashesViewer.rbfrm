#tag Window
Begin Window HashesViewer
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   3.01e+2
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
   Placement       =   0
   Resizeable      =   True
   Title           =   "Additional hashes"
   Visible         =   True
   Width           =   4.17e+2
   Begin Listbox Listbox1
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   3
      ColumnsResizable=   ""
      ColumnWidths    =   "5%, 30%"
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
      Height          =   290
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
      Width           =   417
      _ScrollWidth    =   -1
   End
   Begin Thread HashThread
      Height          =   32
      Index           =   -2147483648
      Left            =   492
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
      Left            =   492
      LockedInPosition=   False
      Mode            =   2
      Period          =   50
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   44
      Width           =   32
   End
   Begin ProgressBar ProgressBar1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   8
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Maximum         =   100
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   293
      Value           =   0
      Visible         =   True
      Width           =   417
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub ShowHashes(Data As BinaryStream)
		  mLock = New Semaphore
		  BytesTotal = 0
		  BytesProcessed = 0
		  ListBox1.DeleteAllRows
		  
		  ListBox1.AddRow("", "MD5", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_MD5
		  BytesTotal = BytesTotal + Data.Length
		  
		  ListBox1.AddRow("", "MD4", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_MD4
		  BytesTotal = BytesTotal + Data.Length
		  
		  ListBox1.AddRow("", "MD2", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_MD2
		  BytesTotal = BytesTotal + Data.Length
		  
		  'ListBox1.AddRow("", "CRC32", "Pending")
		  'ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_
		  'BytesTotal = BytesTotal + Data.Length
		  
		  'ListBox1.AddRow("", "Adler32", "Pending")
		  'ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_
		  'BytesTotal = BytesTotal + Data.Length
		  
		  ListBox1.AddRow("", "SHA1", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_SHA1
		  BytesTotal = BytesTotal + Data.Length
		  
		  ListBox1.AddRow("", "SHA256", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_SHA256
		  BytesTotal = BytesTotal + Data.Length
		  
		  ListBox1.AddRow("", "SHA384", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_SHA384
		  BytesTotal = BytesTotal + Data.Length
		  
		  ListBox1.AddRow("", "SHA512", "Pending")
		  ListBox1.CellTag(ListBox1.LastIndex, 0) = Win32.Crypto.CALG_SHA512
		  BytesTotal = BytesTotal + Data.Length
		  
		  DataStream = Data
		  Me.Show()
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private BytesProcessed As Int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private BytesTotal As Int64
	#tag EndProperty

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
		      Dim chunk As MemoryBlock = DataStream.Read(chunksz)
		      h.Process(chunk)
		      BytesProcessed = BytesProcessed + chunk.Size
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
		        For i As Integer = 0 To Listbox1.ListCount - 1
		          If Listbox1.CellTag(i, 0) = mCurrentAlg Then
		            Listbox1.Cell(i, 2) = EncodeHex(mHashValue)
		            Exit For
		          End If
		        Next
		      End If
		      
		      For i As Integer = 0 To Listbox1.ListCount - 1
		        If Listbox1.Cell(i, 2) = "Pending" Then
		          mCurrentAlg = Listbox1.CellTag(i, 0)
		          mHashValue = ""
		          Exit For
		        ElseIf i = Listbox1.ListCount - 1 Then
		          Me.Mode = Timer.ModeOff
		        End If
		      Next
		      HashThread.Run
		    Catch Err As ThreadAlreadyRunningException
		      Me.Mode = Timer.ModeOff
		    Finally
		      mLock.Release
		    End Try
		  Else
		    ProgressBar1.value = Ceil(BytesProcessed * 100 / BytesTotal)
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
