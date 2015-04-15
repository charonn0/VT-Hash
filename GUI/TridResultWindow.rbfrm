#tag Window
Begin Window TridResultWindow
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
   Begin PrettyListBox Listbox1
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
		Sub ShowResult(Results() As TridLib.FileType, File As FolderItem, ParentWindow As Window)
		  Listbox1.DeleteAllRows
		  Self.Title = "TrID Analysis of " + File.Name
		  If UBound(Results) > -1 Then
		    Dim total As Integer
		    For i As Integer = 0 To UBound(Results)
		      Dim rs As TridLib.FileType = Results(i)
		      Listbox1.AddRow("(" + rs.Extension + ")" + rs.Description)
		      Listbox1.RowTag(Listbox1.LastIndex) = rs
		      total = total + rs.Points
		    Next
		    For i As Integer = 0 To Listbox1.ListCount - 1
		      Dim rs As TridLib.FileType = Listbox1.RowTag(i)
		      Listbox1.Cell(i, 1) = Format(rs.Points * 100 / total, "##0.0#") + "%"
		    Next
		  Else
		    Listbox1.AddRow("Unknown (plain text?)", "100%")
		  End If
		  
		  Dim ScreenNumber As Integer = ScreenFromXY(parentWindow.Left, ParentWindow.Top)
		  ShowCentered(Me, ScreenNumber)
		  
		  Me.ShowModal
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events Listbox1
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  Dim tridtype As String = Me.Cell(Me.RowFromXY(X, Y), 0).Trim
		  If tridtype <> "" Then
		    Dim cp As New MenuItem("Copy to clipboard")
		    Dim se As New MenuItem("Search " + VTHash.GetConfig("SearchEngineName"))
		    se.Tag = tridtype
		    cp.Tag = tridtype
		    base.Append(cp)
		    If VTHash.GetConfig("SearchEngineName") <> "" Then base.Append(se)
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
		    ShowURL(Replace(VTHash.GetConfig("SearchEngineURL"), "%PARAMETER%", hitItem.Tag))
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
