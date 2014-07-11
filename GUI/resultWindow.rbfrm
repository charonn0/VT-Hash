#tag Window
Begin Window resultWindow
   BackColor       =   14211288
   Backdrop        =   ""
   CloseButton     =   False
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   5.05e+2
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   800
   MenuBar         =   10858495
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   False
   MinWidth        =   491
   Placement       =   2
   Resizeable      =   True
   Title           =   "Virus Total Report"
   Visible         =   True
   Width           =   4.96e+2
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
      Height          =   399
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
      Width           =   496
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
   Begin PushButton PushButton2
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "&Full Results"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   253
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
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
   Begin LinkLabel saved
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
      InitialParent   =   ""
      Italic          =   ""
      Left            =   391
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   ""
      ResetPeriod     =   1000
      Scope           =   0
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
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
   Begin Timer TridTimer
      Enabled         =   True
      Height          =   32
      Index           =   -2147483648
      Left            =   -141
      LockedInPosition=   False
      Mode            =   0
      Period          =   2500
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   -6
      Visible         =   True
      Width           =   32
   End
   Begin ProgBar ProgBar1
      AcceptFocus     =   ""
      AcceptTabs      =   ""
      AutoDeactivate  =   True
      barColor        =   &h0000FF00
      barWell         =   "&cC0C0C0"
      bold            =   False
      boxColor        =   "&c000000"
      DoubleBuffer    =   ""
      Enabled         =   True
      EraseBackground =   ""
      gradientEnd     =   &h00004000
      hasBox          =   True
      hasGradient     =   True
      hasText         =   True
      Height          =   26
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      italic          =   False
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      maximum         =   100
      Scope           =   0
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      textColor       =   "&c000000"
      textFont        =   "System"
      textFormat      =   "###.0\\%"
      textSize        =   0
      Top             =   0
      underline       =   False
      UseFocusRing    =   True
      value           =   ""
      Visible         =   True
      Width           =   495
   End
   Begin TextField FilePath
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &hFFFFFF
      Bold            =   ""
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   ""
      Left            =   49
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Mask            =   ""
      Password        =   ""
      ReadOnly        =   True
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   429
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   427
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
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Path:"
      TextAlign       =   2
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   428
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   47
   End
   Begin TextField FileHash
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &hFFFFFF
      Bold            =   ""
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   ""
      Left            =   49
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Mask            =   ""
      Password        =   ""
      ReadOnly        =   True
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   451
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   443
   End
   Begin Label HashType
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
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Hash:"
      TextAlign       =   2
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   450
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   47
   End
   Begin Canvas Canvas1
      AcceptFocus     =   ""
      AcceptTabs      =   ""
      AutoDeactivate  =   True
      Backdrop        =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   16
      HelpTag         =   "Open parent directory"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   477
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   431
      UseFocusRing    =   True
      Visible         =   True
      Width           =   16
   End
   Begin LinkLabel LinkLabel1
      ActiveColor     =   "&cFF0000"
      AltText         =   ""
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Draggable       =   False
      Enabled         =   True
      Height          =   20
      HilightColor    =   "&c00FFFF"
      HoverPeriod     =   250
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   4
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Multiline       =   ""
      ResetPeriod     =   1000
      Scope           =   0
      Selectable      =   ""
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Add a comment..."
      TextAlign       =   0
      TextColor       =   "&c0000FF"
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   484
      Transparent     =   True
      Underline       =   ""
      Visible         =   True
      Width           =   109
   End
End
#tag EndWindow

#tag WindowCode
	#tag MenuHandler
		Function AboutMenu() As Boolean Handles AboutMenu.Action
			about.ShowModal
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function csvmenu() As Boolean Handles csvmenu.Action
			savedAs = saveAs(Mode_CSV)
			saved.Visible = (savedAs <> Nil)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function jsonmenu() As Boolean Handles jsonmenu.Action
			savedAs = saveAs(Mode_Org_JSON)
			saved.Visible = (savedAs <> Nil)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function OpenFileMenu() As Boolean Handles OpenFileMenu.Action
			If MsgBox("Are you sure you want to run this file?", 52, "Execution Confirmation") = 6 Then
			toBeHashed.Launch
			End If
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function RescanMenu() As Boolean Handles RescanMenu.Action
			waitplease.ShowWithin(Self)
			waitplease.Refresh()
			
			Dim results As JSONItem = VTHash.RequestRescan(VTResult.Resource, VTAPIKey)
			waitplease.Close
			If results = Nil Then
			Call MsgBox("Response was empty. Try again later.", 16, "Probably not my fault")
			Else
			If results.Value("response_code").IntegerValue = 1 Then
			Call MsgBox("Your request was accepted and added to the queue.", 64, "Rescan Accepted")
			Else
			Call MsgBox("VirusTotal said: " + results.Value("response_code").StringValue, 16, "Rescan Error")
			End If
			End If
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function SettsMenu() As Boolean Handles SettsMenu.Action
			settswin.Show
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function textmenu() As Boolean Handles textmenu.Action
			savedAs = saveAs(Mode_Text)
			saved.Visible = (savedAs <> Nil)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function tridmenu() As Boolean Handles tridmenu.Action
			waitplease.ShowWithin(Self)
			waitplease.Refresh()
			TridTimer.Mode = Timer.ModeSingle
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function unpackedmenu() As Boolean Handles unpackedmenu.Action
			savedAs = saveAs(Mode_Unp_JSON)
			saved.Visible = (savedAs <> Nil)
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub DoAutoSave()
		  If autosave Then
		    Try
		      Dim d As New Date
		      Dim f As FolderItem = autosavePath.Child(VTResult.TargetFile.Name + "_" + Format(d.TotalSeconds, "#######0000000"))
		      Dim bs As BinaryStream
		      bs = BinaryStream.Create(f, True)
		      bs.Close
		      savedAs = saveAs(defaultFormat, f)
		      saved.Visible = True
		    Catch err
		      Dim t as Introspection.TypeInfo = Introspection.GetType(err)
		      System.DebugLog("VT Hash: Unable to save report! (" + CurrentMethodName + "->" + t.Name + ")")
		    End Try
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function saveAs(mode As Integer, f As FolderItem = Nil) As FolderItem
		  Dim d As New Date
		  If f = Nil Then
		    Dim filter As String
		    Select Case mode
		    Case Mode_CSV
		      filter = FileTypes1.CommaSeparatedValues
		    Case Mode_Org_JSON, Mode_Unp_JSON
		      filter = FileTypes1.JavascriptObjectNotation
		    Case Mode_Text
		      filter = FileTypes1.Text
		    End Select
		    f = GetSaveFolderItem(filter, toBeHashed.Name + "_" + Format(d.TotalSeconds, "#######0000000"))
		  End If
		  'If Not f.Exists Then f.CreateAsFolder
		  If f = Nil Then Return Nil
		  If f.Directory Then
		    Me.saved.Text = "Invalid Save Path"
		    Me.saved.TextColor = &cFF0000
		    Return Nil
		  End If
		  
		  Dim tos As TextOutputStream
		  
		  Select Case Mode
		  Case Mode_Text
		    tos = tos.Create(f)
		    tos.WriteLine("VirusTotal Scan Results")
		    tos.WriteLine("Report retrieved: " + d.ShortDate + "; " + d.ShortTime + " " + Timezone)
		    tos.WriteLine("Report Date: " + VTResult.ScanDate.SQLDateTime)
		    tos.WriteLine("")
		    For i As Integer = 0 To Me.ListBox1.LastIndex
		      tos.WriteLine(Me.ListBox1.Cell(i, 0) + " " + Me.ListBox1.Cell(i, 1) + ": " + Chr(9) + Me.ListBox1.Cell(i, 2))
		    Next
		  Case Mode_Org_JSON
		    tos = tos.Create(f)
		    VTResult.Compact = True
		    tos.Write(VTResult.ToString)
		  Case Mode_Unp_JSON
		    tos = tos.Create(f)
		    VTResult.Compact = False
		    Dim tmp As String = VTResult.ToString
		    tos.Write(tmp)
		  Case Mode_CSV
		    tos = tos.Create(f)
		    For i As Integer = 0 To Me.ListBox1.LastIndex
		      tos.WriteLine(Me.ListBox1.Cell(i, 0) + "," + Me.ListBox1.Cell(i, 1) + "," + Me.ListBox1.Cell(i, 2))
		    Next
		  End Select
		  tos.Close
		  Return f
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showList(result As Results)
		  Select Case result.ResponseCode
		  Case VT_Code_OK
		    
		    VTResult = result
		    
		    For i As Integer = 1 To VTResult.ResultCount - 1
		      If VTResult.ScannerResult(i).Trim <> "" Then
		        ListBox1.AddRow(VTResult.ScannerName(i), VTResult.ScannerVersion(i), VTResult.ScannerResult(i))
		        ListBox1.RowPicture(ListBox1.LastIndex) = warn
		        Listbox1.CellBold(ListBox1.LastIndex, 2) = True
		        Listbox1.RowTag(Listbox1.LastIndex) = True
		      Else
		        ListBox1.AddRow(VTResult.ScannerName(i), VTResult.ScannerVersion(i), "")
		        ListBox1.RowPicture(ListBox1.LastIndex) = clear
		        Listbox1.RowTag(Listbox1.LastIndex) = False
		      End If
		    Next
		    
		    ProgBar1.Text = Str(VTResult.ThreatCount) + " of " + Str(VTResult.ResultCount) + " found threats; Last Scan: " _
		    + VTResult.ScanDate.ShortDate + " " + VTResult.ScanDate.ShortTime
		    
		    FileHash.Text = VTResult.HashValue
		    If VTResult.TargetFile <> Nil Then
		      FilePath.Text = VTResult.TargetFile.AbsolutePath
		    Else
		      FilePath.Text = "No File!?"
		    End If
		    ProgBar1.value = VTResult.ThreatCount * 100 / VTResult.ResultCount
		    ProgBar1.HelpTag = Format(VTResult.ThreatCount * 100 / VTResult.ResultCount, "##0.00") + "% dangerous"
		    Select Case VTResult.Algorithm
		    Case Results.ALG_MD5
		      HashType.Text = "MD5:"
		    Case Results.ALG_SHA1
		      HashType.Text = "SHA1:"
		    End Select
		    
		    DoAutosave()
		    
		    Me.ShowModal
		    Quit()
		  Case VT_Code_Not_Found
		    If result.TargetFile.Length >= 32 * 1024 * 1024 Then
		      Select Case MsgBox(_
		        "That file is not present in Virus Total's database. Additionally, the file exceeds 32MB which is the default limit for uploading via the API." + EndOfLine + _
		        "Some users do not have this limit, would you like to attempt to upload anyway?", 48 + 3, "File too large for API")
		      Case 6 ' Yes
		        Dim ul As New FileSubmit
		        Self.Hide
		        ul.SubmitFile(Self, Result.TargetFile, VTAPIKey)
		      Case 7 ' No
		        If MsgBox("Would you like to open virustotal.com in your default browser in order to upload this file manually?", 4 + 32, "Open browser?") = 6 Then
		          ShowURL("https://www.virustotal.com/")
		          Quit()
		        Else
		          Quit()
		        End If
		      Case 2 ' Cancel
		        Quit()
		      End Select
		    ElseIf MsgBox("That file is not present in Virus Total's database. Would you like to upload this file?", 52, "Not found") = 6 Then
		      Dim ul As New FileSubmit
		      Self.Hide
		      ul.SubmitFile(Self, Result.TargetFile, VTAPIKey)
		      'ShowURL("https://www.virustotal.com/")
		    Else
		      Quit(0)
		    End If
		    'Quit()
		  Case VT_Code_Still_Proccessing
		    Call MsgBox("That file is still waiting to be analyzed. Please try again later.", 64, "Still processing")
		    Quit()
		    
		  End Select
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		savedAs As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		VTResult As Results
	#tag EndProperty


#tag EndWindowCode

#tag Events Listbox1
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  #pragma Unused column
		  If row <= Me.LastIndex Then
		    If Me.RowTag(row) = True Then
		      g.foreColor= &cFF808000
		    else
		      g.foreColor= &cD8D8D800
		    end if
		    g.FillRect 0,0,g.width,g.height
		  End If
		  'Return True
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  If Me.Cell(Me.ListIndex, 2) <> "" And SearchEngineSet Then
		    Dim url As String = Replace(SearchEngineURL, "%PARAMETER%", Me.Cell(Me.ListIndex, 2))
		    ShowURL(url)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  Dim infection As String = Me.Cell(Me.RowFromXY(X, Y), 2).Trim
		  If infection <> "" Then
		    Dim cp As New MenuItem("Copy to clipboard")
		    Dim se As New MenuItem("Search " + SearchEngineName)
		    'Dim ch As New MenuItem("Change search engine...")
		    se.Tag = infection
		    cp.Tag = infection
		    base.Append(cp)
		    If SearchEngineSet Then base.Append(se)
		    'base.Append(ch)
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
		    'Case "Chang"
		    'Dim nm, url As String
		    'nm = SearchEngineName
		    'url = SearchEngineURL
		    'If SearchSetting.GetURL(nm, url) Then
		    'SearchEngineName = nm
		    'SearchEngineURL = url
		    'VTHash.SaveSettings()
		    'End If
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  Me.ColumnSortDirection(1) = 0
		  Me.HeaderType(1) = Listbox.HeaderTypes.NotSortable
		  Me.ColumnSortDirection(2) = -1
		End Sub
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  If column = 2 Then
		    Dim c1, c2 As String
		    c1 = Me.Cell(row1, 2)
		    c2 = Me.Cell(row2, 2)
		    If c1.Trim <> "" And c2.Trim = "" Then
		      result = 1
		      Return True
		    ElseIf c1.Trim = "" And c2.Trim <> "" Then
		      result = -1
		      Return True
		    ElseIf c1.Trim <> "" And c2.Trim <> "" Then
		      result = StrComp(c1, c2, 0)
		      Return True
		    Else
		      result = 0
		      Return True
		    End If
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  'Dim row, column As Integer
		  'row = Me.RowFromXY(X, Y)
		  'column = Me.ColumnFromXY(X, Y)
		  'If column = 2 And Row <= Me.ListCount - 1 And SearchEngineSet Then
		  'If Me.RowTag(row).BooleanValue Then
		  'Me.MouseCursor = System.Cursors.FingerPointer
		  'Else
		  'Me.MouseCursor = System.Cursors.StandardPointer
		  'End If
		  'Else
		  'Me.MouseCursor = System.Cursors.StandardPointer
		  'End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  'If column = 2 And Row <= Me.ListCount - 1 And SearchEngineSet Then
		  'If Me.RowTag(row).BooleanValue Then
		  ''g.ForeColor = &c64646400
		  'g.Underline = True
		  'End If
		  'End If
		End Function
	#tag EndEvent
	#tag Event
		Function CellClick(row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  'If IsContextualClick Then Return True
		  'If Not SearchEngineSet Then Return False
		  'If column = 2 And Row <= Me.ListCount - 1 Then
		  'If Me.RowTag(row).BooleanValue Then
		  'Dim infection As String = Me.Cell(row, column).Trim
		  'ShowURL(Replace(SearchEngineURL, "%PARAMETER%", infection))
		  'End If
		  'End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events closeButton
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  ShowURL(VTResult.Permalink)
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
		Sub MouseExit()
		  If Me.Visible Then
		    Me.MouseCursor = System.Cursors.StandardPointer
		    Me.Underline = False
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  savedAs.ShowInExplorer()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TridTimer
	#tag Event
		Sub Action()
		  Dim s As Dictionary = Trid(toBeHashed)
		  waitplease.Close
		  Dim tridwin As New TridResult
		  tridwin.ShowResult(s, Self)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Canvas1
	#tag Event
		Sub Paint(g As Graphics)
		  g.DrawPicture(explore, 0, 0)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  Me.MouseCursor = System.Cursors.FingerPointer
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  Me.MouseCursor = System.Cursors.StandardPointer
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  toBeHashed.ShowInExplorer()
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events LinkLabel1
	#tag Event
		Sub Action()
		  Dim comment As String = CommentWindow.GetComment(System.MouseX, System. MouseY)
		  If comment <> "" Then
		    waitplease.ShowWithin(Self)
		    waitplease.Refresh()
		    Dim js As JSONItem = VTHash.AddComment(VTResult.Resource, VTAPIKey, comment)
		    waitplease.Close
		    If js <> Nil Then
		      MsgBox(js.Value("verbose_msg"))
		    Else
		      MsgBox("Invalid response from Virus Total.")
		    End If
		    
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  If Me.Visible Then
		    Me.MouseCursor = System.Cursors.FingerPointer
		    Me.Underline = True
		  End If
		End Sub
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
