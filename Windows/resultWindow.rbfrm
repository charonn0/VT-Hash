#tag Window
Begin Window resultWindow
   BackColor       =   14211288
   Backdrop        =   ""
   CloseButton     =   False
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   505
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   800
   MenuBar         =   1895413759
   MenuBarVisible  =   True
   MinHeight       =   100
   MinimizeButton  =   False
   MinWidth        =   491
   Placement       =   2
   Resizeable      =   True
   Title           =   "Virus Total Report"
   Visible         =   True
   Width           =   491
   Begin Listbox Listbox1
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   3
      ColumnsResizable=   ""
      ColumnWidths    =   "40%, 20%, 40%"
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
      Height          =   453
      HelpTag         =   ""
      Hierarchical    =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Scanner	Version	Result"
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
      Top             =   26
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   491
      _ScrollWidth    =   -1
   End
   Begin PushButton closeButton
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Close"
      Default         =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   117
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
      TextSize        =   0
      TextUnit        =   0
      Top             =   482
      Underline       =   ""
      Visible         =   True
      Width           =   126
   End
   Begin PushButton PushButton2
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Full Results"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   248
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   482
      Underline       =   ""
      Visible         =   True
      Width           =   126
   End
   Begin Label Label1
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
      Left            =   7
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
      Text            =   "0 reporting; 0 reported threats"
      TextAlign       =   0
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   11
      TextUnit        =   0
      Top             =   0
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   381
   End
   Begin Label saved
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
      Left            =   386
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      Text            =   "Report Saved"
      TextAlign       =   2
      TextColor       =   255
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   483
      Transparent     =   True
      Underline       =   ""
      Visible         =   False
      Width           =   101
   End
End
#tag EndWindow

#tag WindowCode
	#tag MenuHandler
		Function csvmenu() As Boolean Handles csvmenu.Action
			savedAs = saveAs(Mode_CSV)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function jsonmenu() As Boolean Handles jsonmenu.Action
			savedAs = saveAs(Mode_Org_JSON)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function textmenu() As Boolean Handles textmenu.Action
			savedAs = saveAs(Mode_Text)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function unpackedmenu() As Boolean Handles unpackedmenu.Action
			savedAs = saveAs(Mode_Unp_JSON)
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub showList(results As JSONItem)
		  Me.Show
		  Me.Title = pretifyPath(toBeHashed.AbsolutePath)
		  theresults = results
		  permalink = results.Value("permalink")
		  Dim resCount, threatCount As Integer
		  Dim detection As JSONItem = results.Child("scans")
		  Dim lastScan As String = results.Value("scan_date")
		  For i As Integer = 1 To detection.Count - 1
		    Dim isThreat As Boolean
		    Dim scanner, scannerVersion, scanResult As String
		    scanner = detection.Name(i)
		    scannerVersion = detection.Child(scanner).Value("version")
		    scanResult = detection.Child(scanner).Value("result")
		    If detection.Child(scanner).Value("detected") = "true" Then
		      ListBox1.AddRow(scanner, scannerVersion, scanResult)
		      ListBox1.RowPicture(ListBox1.LastIndex) = warn
		      Listbox1.CellBold(ListBox1.LastIndex, 2) = True
		      Listbox1.RowTag(Listbox1.LastIndex) = True
		    Else
		      ListBox1.AddRow(scanner, scannerVersion, "")
		      ListBox1.RowPicture(ListBox1.LastIndex) = clear
		      Listbox1.RowTag(Listbox1.LastIndex) = False
		    End If
		  Next
		  Dim total, positives As Integer
		  total = results.Value("total")
		  positives = results.Value("positives")
		  Label1.Text = Str(positives) + " of " + Str(total) + " (" + Format(positives * 100 / total, "##0.00") + "%) found threats; Last Scan: " + lastScan
		  If autosave Then
		    savedAs = saveAs(defaultFormat)
		    saved.Visible = True
		  End If
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		permalink As String
	#tag EndProperty

	#tag Property, Flags = &h0
		savedAs As FolderItem
	#tag EndProperty


#tag EndWindowCode

#tag Events Listbox1
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  If row <= Me.LastIndex Then
		    If Me.RowTag(row) = True Then
		      g.foreColor= &cFF808000
		    else
		      g.foreColor= &cD8D8D800
		    end if
		    g.FillRect 0,0,g.width,g.height
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  If Me.Cell(Me.ListIndex, 2) <> "" Then ShowURL("https://encrypted.google.com/search?q=" + Me.Cell(Me.ListIndex, 2))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events closeButton
	#tag Event
		Sub Action()
		  Quit(0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  ShowURL(permalink)
		  Quit(0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events saved
	#tag Event
		Sub MouseEnter()
		  If Me.Visible Then 
		    Me.MouseCursor = System.Cursors.FingerPointer
		    Me.Underline = True
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  If Me.Visible And Me.Text = "Report Saved" Then savedAs.Launch
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  If Me.Visible Then
		    Me.MouseCursor = System.Cursors.StandardPointer
		    Me.Underline = False
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
