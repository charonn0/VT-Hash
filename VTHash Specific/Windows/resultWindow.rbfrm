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
      Caption         =   "Full Results"
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
      Height          =   32
      Index           =   -2147483648
      Left            =   -141
      LockedInPosition=   False
      Mode            =   0
      Period          =   2500
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   -6
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
			Dim sock As New HTTPSecureSocket
			
			Dim results As JSONItem = VTAPI.RequestRescan(theresults.Value("resource"), VTAPIKey)
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


	#tag Method, Flags = &h0
		Function saveAs(mode As Integer, f As FolderItem = Nil) As FolderItem
		  Dim d As New Date
		  If f = Nil Then f = GetSaveFolderItem(FileTypes1.All, toBeHashed.Name + "_" + Format(d.TotalSeconds, "#######0000000"))
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
		    tos.WriteLine("Report Date: " + theresults.Value("scan_date"))
		    tos.WriteLine("")
		    For i As Integer = 0 To Me.ListBox1.LastIndex
		      tos.WriteLine(Me.ListBox1.Cell(i, 0) + " " + Me.ListBox1.Cell(i, 1) + ": " + Chr(9) + Me.ListBox1.Cell(i, 2))
		    Next
		  Case Mode_Org_JSON
		    tos = tos.Create(f)
		    tos.Write(theresults.ToString)
		  Case Mode_Unp_JSON
		    tos = tos.Create(f)
		    theresults.Compact = False
		    Dim tmp As String = theresults.ToString
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
		Sub showList(results As JSONItem)
		  'Me.Title = pretifyPath(toBeHashed.AbsolutePath, 60)
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
		  ProgBar1.Text = Str(positives) + " of " + Str(total) + " found threats; Last Scan: " + lastScan  ' (" + Format(positives * 100 / total, "##0.00") + "%)
		  If autosave Then
		    Try
		      Dim d As New Date
		      Dim f As FolderItem = autosavePath.Child(toBeHashed.Name + "_" + Format(d.TotalSeconds, "#######0000000"))
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
		  FileHash.Text = TheHash
		  FilePath.Text = toBeHashed.AbsolutePath
		  ProgBar1.value = positives * 100 / total
		  ProgBar1.HelpTag = Format(positives * 100 / total, "##0.00") + "% dangerous"
		  HashType.Text = algorithm + ":"
		  Me.ShowModal
		  Quit()
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		permalink As String
	#tag EndProperty

	#tag Property, Flags = &h0
		savedAs As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		theresults As JSONItem
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
		  'Return True
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  If Me.Cell(Me.ListIndex, 2) <> "" Then ShowURL("https://encrypted.google.com/search?q=" + Me.Cell(Me.ListIndex, 2))
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  Dim cp As New MenuItem("Copy to clipboard")
		  base.Append(cp)
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  Select Case hitItem.Text
		  Case "Copy to clipboard"
		    Dim cb As New Clipboard
		    cb.Text = Me.Cell(Me.ListIndex, 0) + " " + Me.Cell(Me.ListIndex, 1) + " " + Me.Cell(Me.ListIndex, 2)
		  End Select
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
		  Dim s As String = Trid(toBeHashed)
		  waitplease.Close
		  Call MsgBox(s, 64, "Trid Says:")
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
		  toBeHashed.ShowInExplorer()
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events LinkLabel1
	#tag Event
		Sub Action()
		  Dim comment As String = CommentWindow.GetComment(System.MouseX, System. MouseY)
		  If comment <> "" Then
		    Dim js As JSONItem = VTAPI.AddComment(TheHash, VTAPIKey, comment)
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
