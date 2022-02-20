#tag Window
Begin Window TridResultWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
   HasFullScreenButton=   False
   Height          =   113
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
   Resizeable      =   True
   Title           =   "Trid Says"
   Visible         =   True
   Width           =   348
   Begin PrettyListBox TridResultList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "80%,*"
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
      Height          =   113
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Guess	Certainty"
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
      Width           =   348
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
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
      Left            =   103
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
      Top             =   -57
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub ShowResult(Results() As TridLib.FileType, File As FolderItem, ParentWindow As Window)
		  TridResultList.DeleteAllRows
		  Self.Title = "TrID Analysis of " + File.Name
		  If UBound(Results) > -1 Then
		    Dim total As Integer
		    For i As Integer = 0 To UBound(Results)
		      Dim rs As TridLib.FileType = Results(i)
		      TridResultList.AddRow("(" + rs.Extension + ")" + rs.Description)
		      TridResultList.RowTag(TridResultList.LastIndex) = rs
		      total = total + rs.Points
		    Next
		    For i As Integer = 0 To TridResultList.ListCount - 1
		      Dim rs As TridLib.FileType = TridResultList.RowTag(i)
		      TridResultList.Cell(i, 1) = Format(rs.Points * 100 / total, "##0.0#") + "%"
		    Next
		  Else
		    TridResultList.AddRow("Unknown (plain text?)", "100%")
		  End If
		  
		  
		  Dim ScreenNumber As Integer = 0
		  If ParentWindow <> Nil Then ScreenNumber = ScreenFromXY(parentWindow.Left, ParentWindow.Top)
		  ShowCentered(Me, ScreenNumber)
		  Me.ShowModal
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events TridResultList
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
#tag Events CancelBtn
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
