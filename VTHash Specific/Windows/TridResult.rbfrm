#tag Window
Begin Window TridResult
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   1.13e+2
   ImplicitInstance=   False
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
   Placement       =   1
   Resizeable      =   True
   Title           =   "Trid Says"
   Visible         =   True
   Width           =   3.48e+2
   Begin Listbox Listbox1
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   2
      ColumnsResizable=   ""
      ColumnWidths    =   "80%,*"
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
      Height          =   113
      HelpTag         =   ""
      Hierarchical    =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Guess	Certainty"
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
      Width           =   348
      _ScrollWidth    =   -1
   End
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Untitled"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   103
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
      Top             =   -57
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub ShowResult(Results As Dictionary)
		  Listbox1.DeleteAllRows
		  If Results <> Nil Then
		    For Each key As String in Results.Keys
		      Listbox1.AddRow(key, Str(Results.Value(key).Int32Value) + "%")
		    Next
		  Else
		    Listbox1.AddRow("Unknown (plain text?)", "100%")
		  End If
		  Me.ShowModal
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events Listbox1
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  '#pragma Unused column
		  ''g.ForeColor = &c00800000
		  ''g.FillRect(0, 0, g.Width, g.Height)
		  'If row <= Me.LastIndex Then
		  'Dim perc As Integer = Me.RowTag(row)
		  'g.foreColor= &cE6E6E600
		  'Dim w As Integer = perc * g.Width \ 100
		  '
		  'g.FillRect(0, 0, w, g.height)
		  'End If
		  ''Return True
		  
		  #pragma Unused column
		  #pragma Unused row
		  g.foreColor= &cD8D8D800
		  g.FillRect 0,0,g.width,g.height
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  Dim tridtype As String = Me.Cell(Me.RowFromXY(X, Y), 0).Trim
		  If tridtype <> "" Then
		    Dim cp As New MenuItem("Copy to clipboard")
		    Dim se As New MenuItem("Search " + SearchEngineName)
		    se.Tag = tridtype
		    cp.Tag = tridtype
		    base.Append(cp)
		    base.Append(se)
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  Select Case hitItem.Text.Left(5)
		  Case "Copy "
		    Dim cb As New Clipboard
		    cb.Text = hitItem.Tag
		  Case "Searc"
		    ShowURL(Replace(SearchEngineURL, "%PARAMETER%", hitItem.Tag))
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
