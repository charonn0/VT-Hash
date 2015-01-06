#tag Module
Protected Module GUI
	#tag CompatibilityFlags = TargetHasGUI
	#tag Method, Flags = &h1
		Protected Function CaptureRect(X As Integer, Y As Integer, Width As Integer, Height As Integer) As Picture
		  'Performs a screen capture on the specified on-screen rectangle. All screen contents in that
		  'rectangle will be captured as they appear to the user on screen.
		  If Width = 0 Or Height = 0 Then Return Nil
		  Dim screenCap As Picture
		  
		  #If TargetWin32 Then
		    screenCap = New Picture(Width, Height, 24)
		    Dim deskHWND As Integer = Win32.Libs.User32.GetDesktopWindow()
		    Dim deskHDC As Integer = Win32.Libs.User32.GetDC(deskHWND)
		    Call Win32.Libs.GDI32.BitBlt(screenCap.Graphics.Handle(Graphics.HandleTypeHDC), 0, 0, Width, Height, DeskHDC, X, Y, SRCCOPY Or CAPTUREBLT)
		    Call Win32.Libs.User32.ReleaseDC(DeskHWND, deskHDC)
		  #Endif
		  
		  Return screenCap
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExtractIcon(Resource as FolderItem, Index As Integer, pixSize As Integer = 32) As Picture
		  //Extracts the specified Icon resource into a RB Picture. Returns Nil on error.
		  //Icons are located in EXE, DLL, etc. type files, and are referenced by their index.
		  
		  #If TargetWin32 Then
		    Dim theIcon As Picture = New Picture(pixsize, pixsize, 32)
		    theIcon.Transparent = 1
		    
		    Dim largeIco As New MemoryBlock(4)
		    Try
		      Call Win32.Libs.Shell32.ExtractIconEx(resource.AbsolutePath, Index, largeIco, Nil, 1)
		      Call Win32.Libs.User32.DrawIconEx(theIcon.Graphics.Handle(Graphics.HandleTypeHDC), 0, 0, largeIco.Int32Value(0), pixsize, pixsize, 0, 0, &h3)
		    Catch
		      Call Win32.Libs.User32.DestroyIcon(largeIco.Int32Value(0))
		      Return Nil
		    End Try
		    Call Win32.Libs.User32.DestroyIcon(largeIco.Int32Value(0))
		    Return theIcon
		  #endif
		  
		Exception
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Function FindFirstWindow(WindowName As String, WindowClass As String = "") As WindowRef
		  #If TargetWin32 Then
		    Dim HWND, err as integer
		    Dim mbclass, mbname As MemoryBlock
		    mbclass = WindowClass
		    mbname = WindowName
		    HWND = Win32.Libs.User32.FindWindow(mbname, mbclass)
		    err = Win32.LastError
		    If err = 0 Then Return New WindowRef(HWND)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Function FindNextWindow(FindRef As WindowRef) As WindowRef
		  #If TargetWin32 Then
		    Dim HWND, err as integer
		    HWND = Win32.Libs.User32.GetWindow(FindRef.Handle, GW_HWNDNEXT)
		    err = Win32.LastError
		    If err = 0 Then Return New WindowRef(HWND)
		  #endif
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Function GetDesktopWindow() As WindowRef
		  #If TargetWin32 Then
		    Dim HWND As Integer = Win32.Libs.User32.GetDesktopWindow
		    Return New WindowRef(HWND)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HBITMAP(hMap As Integer) As Picture
		  Dim szm As New MemoryBlock(28)
		  If Win32.Libs.GDI32.GetObject(hMap, 28, szm) > 0 Then
		    Dim p As New Picture(szm.Int32Value(4), szm.Int32Value(8), 32)
		    Dim dsthDC, srcDC As Integer
		    dsthDC = p.Graphics.Handle(1)
		    srcDC = Win32.Libs.GDI32.CreateCompatibleDC(dsthDC)
		    Call Win32.Libs.GDI32.SelectObject(srcDC, hMap)
		    Call Win32.Libs.GDI32.BitBlt(dsthDC, 0, 0, p.Width, p.Height, srcDC, 0, 0, SRCCOPY)
		    Return p
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HBITMAP(p As Picture) As Integer
		  Dim pp As New Picture(p.Width, p.Height, 32)
		  Dim srcDC As Integer = pp.Graphics.Handle(1)
		  Dim bmp As Integer = Win32.Libs.GDI32.CreateCompatibleBitmap(srcDC, p.Width, p.Height)
		  Dim dstDC As Integer = Win32.Libs.GDI32.CreateCompatibleDC(srcDC)
		  Call Win32.Libs.GDI32.SelectObject(dstDC, bmp)
		  Call Win32.Libs.GDI32.BitBlt(dstDC, 0, 0, p.Width, p.Height, srcDC, 0, 0, SRCCOPY)
		  Return bmp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Function ListWindows(PartialTitle As String = "") As WindowRef()
		  #If TargetWin32 Then
		    Dim wins() As WindowRef
		    Dim ret as integer
		    ret = Win32.Libs.User32.FindWindow(Nil, Nil)
		    Dim hidden() As String = Split("MSCTFIME UI,Default IME,Jump List,Start Menu,Start,Program Manager", ",")
		    while ret > 0
		      Dim pw As New WindowRef(ret)
		      If pw.Text.Trim <> "" And hidden.IndexOf(pw.Text.Trim) <= -1 And pw.Visible Then
		        If PartialTitle.Trim = "" Or InStr(pw.Text, PartialTitle) > 0 Then
		          wins.Append(pw)
		        End If
		      End If
		      ret = Win32.Libs.User32.GetWindow(ret, GW_HWNDNEXT)
		    wend
		    Return wins
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Function LoadFontFile(FontFile As FolderItem) As Boolean
		  Dim flags As Integer = FR_PRIVATE
		  #If TargetWin32 Then
		    Return Win32.Libs.GDI32.AddFontResourceEx(FontFile.AbsolutePath, flags, 0) > 0
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MoveWindow(HWND As Integer, Left As Integer, Top As Integer, Width As Integer, Height As Integer, Repaint As Boolean = False) As Boolean
		  Return Win32.Libs.User32.MoveWindow(HWND, Left, Top, Width, Height, Repaint)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Function Pixel(X As Integer, Y As Integer) As Color
		  // This method replaces System.Pixel which has been removed from RB as of RS2012R2
		  
		  Dim p As Picture = CaptureRect(X, Y, 2, 2)
		  If p <> Nil Then
		    Return p.RGBSurface.Pixel(1, 1)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PostMessage(Recipient As Win32.Win32Object, Message As Integer, WParam As Ptr, LParam As Ptr) As Boolean
		  'Posts the Window Message to the target window's message queue and returns immediately
		  #If TargetWin32 Then
		    Return Win32.Libs.User32.PostMessage(Recipient.Handle, Message, WParam, LParam)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ScreenToClient(ScreenPoint As Realbasic.Point, HWND As Integer) As REALbasic.Point
		  Dim p As Win32.GUI.POINT
		  p.X = ScreenPoint.X
		  p.Y = ScreenPoint.Y
		  If Not Win32.Libs.User32.ScreenToClient(HWND, p) Then
		    p.X = -1
		    p.Y = -1
		  End If
		  Return New REALbasic.Point(p.X, p.Y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SendMessage(Recipient As Win32.Win32Object, Message As Integer, WParam As Ptr, LParam As Ptr) As Integer
		  'Sends the Window Message to the target window and waits for a response
		  #If TargetWin32 Then
		    Return Win32.Libs.User32.SendMessage(Recipient.Handle, Message, WParam, LParam)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetWindowStyle(HWND As Integer, flag As Integer, Assigns b As Boolean)
		  #If TargetWin32 Then
		    Dim oldFlags as Integer
		    Dim newFlags as Integer
		    
		    oldFlags = Win32.Libs.User32.GetWindowLong(HWND, GWL_STYLE)
		    
		    If Not b Then
		      newFlags = BitAnd(oldFlags, Bitwise.OnesComplement(flag))
		    Else
		      newFlags = BitOr(oldFlags, flag)
		    End
		    
		    Call Win32.Libs.User32.SetWindowLong(HWND, GWL_STYLE, newFlags)
		    Call Win32.Libs.User32.SetWindowPos(HWND, 0, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE + SWP_NOZORDER + SWP_FRAMECHANGED)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetWindowStyleEx(HWND As Integer, flag As Integer, Assigns b As Boolean)
		  #If TargetWin32 Then
		    Dim oldFlags as Integer
		    Dim newFlags as Integer
		    
		    oldFlags = Win32.Libs.User32.GetWindowLong(HWND, GWL_EXSTYLE)
		    
		    If Not b Then
		      newFlags = BitAnd(oldFlags, Bitwise.OnesComplement(flag)) 'turn off
		    Else
		      newFlags = BitOr(oldFlags, flag)  'turn on
		    End
		    
		    Call Win32.Libs.User32.SetWindowLong(HWND, GWL_EXSTYLE, newFlags)
		    Call Win32.Libs.User32.SetWindowPos(HWND, 0, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE + SWP_NOZORDER + SWP_FRAMECHANGED)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ShellExecute(Target As String, Parameters As String = "", Operation As String = "open", WorkingDirectory As String = "", ParentWindow As Integer = 0, ShowCommand As Integer = SW_SHOW) As Boolean
		  #If TargetWin32 Then
		    If WorkingDirectory = "" Then WorkingDirectory = Win32.IO.CurrentDirectory.AbsolutePath
		    Return Win32.Libs.Shell32.ShellExecute(ParentWindow, Operation, Target, Parameters, WorkingDirectory, ShowCommand) > 32
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TestWindowStyle(HWND As Integer, flag As Integer) As Boolean
		  #if TargetWin32
		    Dim oldFlags as Integer
		    oldFlags = Win32.Libs.User32.GetWindowLong(HWND, GWL_STYLE)
		    
		    Return BitAnd(oldFlags, flag) = flag
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TestWindowStyleEx(HWND As Integer, flag As Integer) As Boolean
		  #if TargetWin32
		    Dim oldFlags as Integer
		    oldFlags = Win32.Libs.User32.GetWindowLong(HWND, GWL_EXSTYLE)
		    
		    Return BitAnd(oldFlags, flag) = flag
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Function UnloadFontFile(FontFile As FolderItem) As Boolean
		  Dim flags As Integer = FR_PRIVATE
		  #If TargetWin32 Then
		    Return Win32.Libs.GDI32.RemoveFontResourceEx(FontFile.AbsolutePath, flags, 0)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Function WindowFromXY(X As Integer, Y As Integer) As WindowRef
		  #If TargetWin32 Then
		    Dim p As Win32.GUI.POINT
		    p.X = X
		    p.Y = Y
		    Dim hwnd As Integer = Win32.Libs.User32.WindowFromPoint(p)
		    If hwnd > 0 Then
		      If Win32.Libs.User32.ChildWindowFromPoint(hwnd, p) > 0 Then
		        hwnd = Win32.Libs.User32.ChildWindowFromPoint(hwnd, p)
		      End If
		    End If
		    Return New WindowRef(hwnd)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WS_EX_PALETTEWINDOW() As Integer
		  Return WS_EX_WINDOWEDGE Or WS_EX_TOOLWINDOW Or WS_EX_TOPMOST
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1, CompatibilityFlags =               TargetHasGUI
		#tag Getter
			Get
			  ' Returns a Rectangle within which the mouse cursor is currently allowed move.
			  #If TargetWin32 Then
			    Dim r As Win32.GUI.RECT
			    If Win32.Libs.User32.GetClipCursor(r) Then
			      Return New REALbasic.Rect(r.left, r.top, r.right - r.left, r.bottom - r.top)
			    End If
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Pass a Rectangle whose dimensions the mouse cursor should be confined within.
			  ' Passing NIL will remove any restrictions imposed by previous calls.
			  ' Only works as long as your app is frontmost
			  ' See: http://msdn.microsoft.com/en-us/library/ms648383.aspx
			  ' Call Win32.LastError to determine whether this method succeeded (LastError=0).
			  
			  #If TargetWin32 Then
			    Dim r As Win32.GUI.RECT
			    If value <> Nil Then
			      r.top = value.Top
			      r.left = value.Left
			      r.bottom = value.Bottom
			      r.right = value.Right
			    End If
			    Call Win32.Libs.User32.ClipCursor(r)
			  #endif
			End Set
		#tag EndSetter
		Protected CursorConfinementArea As REALbasic.Rect
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, CompatibilityFlags =               TargetHasGUI
		#tag Getter
			Get
			  ' Vista and newer. Returns true if desktop composition is enabled.
			  #If TargetWin32 Then
			    If System.IsFunctionAvailable("DwmIsCompositionEnabled", "Dwmapi") Then
			      Dim isenabled As Boolean
			      If Win32.Libs.Dwmapi.DwmIsCompositionEnabled(isenabled) = S_OK Then
			        Return isenabled
			      End If
			    End If
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Vista and newer. Temporarily disableds Aero glass and other eye candy. This is system-wide, so use sparingly and
			  ' make sure you revert when your app exits.
			  #If TargetWin32 Then
			    If System.IsFunctionAvailable("DwmEnableComposition", "Dwmapi") Then
			      If value Then
			        Call Win32.Libs.Dwmapi.DwmEnableComposition(1)
			      Else
			        Call Win32.Libs.Dwmapi.DwmEnableComposition(0)
			      End If
			    End If
			  #endif
			End Set
		#tag EndSetter
		Protected DesktopComposition As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = CAPTUREBLT, Type = Double, Dynamic = False, Default = \"&h40000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FR_PRIVATE, Type = Double, Dynamic = False, Default = \"&h10", Scope = Private
	#tag EndConstant

	#tag Constant, Name = GWL_EXSTYLE, Type = Double, Dynamic = False, Default = \"-20", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GWL_STYLE, Type = Double, Dynamic = False, Default = \"-16", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GWL_WNDPROC, Type = Double, Dynamic = False, Default = \"-4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GW_HWNDNEXT, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GW_HWNDPREV, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GW_OWNER, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RB_FOREMOST_WINDOW_HWND, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SWP_ASYNCWINDOWPOS, Type = Double, Dynamic = False, Default = \"&h4000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SWP_FRAMECHANGED, Type = Double, Dynamic = False, Default = \"&h20", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SWP_NOACTIVATE, Type = Double, Dynamic = False, Default = \"&h0010", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SWP_NOMOVE, Type = Double, Dynamic = False, Default = \"&h2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SWP_NOSIZE, Type = Double, Dynamic = False, Default = \"&h1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SWP_NOZORDER, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SW_FORCEMINIMIZE, Type = Double, Dynamic = False, Default = \"11", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SW_HIDE, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SW_MAXIMIZE, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SW_MINIMIZE, Type = Double, Dynamic = False, Default = \"6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SW_RESTORE, Type = Double, Dynamic = False, Default = \"9", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SW_SHOW, Type = Double, Dynamic = False, Default = \"5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SW_SHOWDEFAULT, Type = Double, Dynamic = False, Default = \"10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SW_SHOWMAXIMIZED, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SW_SHOWMINIMIZED, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SW_SHOWNORMAL, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_CHANGECBCHAIN, Type = Double, Dynamic = False, Default = \"&h030D", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_CLIPBOARDUPDATE, Type = Double, Dynamic = False, Default = \"&h031D", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_CLOSE, Type = Double, Dynamic = False, Default = \"&h10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_CREATE, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_DRAWCLIPBOARD, Type = Double, Dynamic = False, Default = \"&h0308", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_GETMINMAXINFO, Type = Double, Dynamic = False, Default = \"&h0024", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_GETTEXT, Type = Double, Dynamic = False, Default = \"&h000D", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_MOUSEWHEEL, Type = Double, Dynamic = False, Default = \"&h020A", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_NCCALCSIZE, Type = Double, Dynamic = False, Default = \"&h0083", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_NCCREATE, Type = Double, Dynamic = False, Default = \"&h0081", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_PRINT, Type = Double, Dynamic = False, Default = \"&h0317", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_SETICON, Type = Double, Dynamic = False, Default = \"&h0080", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_SETTEXT, Type = Double, Dynamic = False, Default = \"&h000C", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WM_USER, Type = Double, Dynamic = False, Default = \"&h0400", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WS_CHILD, Type = Double, Dynamic = False, Default = \"&h40000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WS_EX_LAYERED, Type = Double, Dynamic = False, Default = \"&h80000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WS_EX_NOREDIRECTIONBITMAP, Type = Double, Dynamic = False, Default = \"&h00200000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WS_EX_TOOLWINDOW, Type = Double, Dynamic = False, Default = \"&h00000080", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WS_EX_TOPMOST, Type = Double, Dynamic = False, Default = \"&h00000008", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WS_EX_WINDOWEDGE, Type = Double, Dynamic = False, Default = \"&h00000100", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WS_VISIBLE, Type = Double, Dynamic = False, Default = \"&h10000000", Scope = Protected
	#tag EndConstant


	#tag Structure, Name = CURSORINFO, Flags = &h1
		cbSize As Integer
		  Flags As Integer
		  hIcon As Integer
		Hotspot As POINT
	#tag EndStructure

	#tag Structure, Name = DWM_THUMBNAIL_PROPERTIES, Flags = &h1
		flags As Integer
		  Destination As Win32.GUI.RECT
		  Source As Win32.GUI.RECT
		  Opacity As Byte
		  Visible As Boolean
		SourceClientAreaOnly As Boolean
	#tag EndStructure

	#tag Structure, Name = FLASHWINFO, Flags = &h1
		cbSize As UInt32
		  HWND As Integer
		  Flags As Integer
		  Count As UInt32
		Timeout As Integer
	#tag EndStructure

	#tag Structure, Name = MARGINS, Flags = &h1
		LeftWidth As Integer
		  RightWidth As Integer
		  TopHeight As Integer
		BottomHeight As Integer
	#tag EndStructure

	#tag Structure, Name = NOTIFYICONDATA, Flags = &h1
		sSize As Integer
		  WindowHandle As Integer
		  uID As UInt32
		  Flags As UInt32
		  CallbackMessage As UInt32
		  IconHandle As Integer
		  ToolTip As String*64
		  State As Integer
		  StateMask As Integer
		  BalloonText As String*256
		  Timeout_Version_Union As UInt32
		  BalloonTitle As String*64
		  InfoFlags As Integer
		  GUIDitem As Win32.Utils.GUID
		BalloonIconHandle As Integer
	#tag EndStructure

	#tag Structure, Name = POINT, Flags = &h1
		X As Integer
		Y As Integer
	#tag EndStructure

	#tag Structure, Name = RECT, Flags = &h1
		left As Integer
		  top As Integer
		  right As Integer
		bottom As Integer
	#tag EndStructure

	#tag Structure, Name = SHELLFLAGSTATE, Flags = &h1
		ShowAllObjects As Boolean
		  ShowExtensions As Boolean
		  NoConfirmRecycle As Boolean
		  ShowSystemFiles As Boolean
		  ShowCompColor As Boolean
		  DoubleClickInWebView As Boolean
		  DesktopHTML As Boolean
		  Win95Classic As Boolean
		  DontPrettyPath As Boolean
		  ShowAttribColor As Boolean
		  MapNetDrvBtn As Boolean
		  ShowInfoTip As Boolean
		  HideIcons As Boolean
		  AutoCheckSelect As Boolean
		  IconsOnly As Boolean
		RestFlags As UInt32
	#tag EndStructure

	#tag Structure, Name = SHFILEINFO, Flags = &h1
		hIcon As Integer
		  IconIndex As Int32
		  attribs As Integer
		  displayName As WString*260
		TypeName As WString*80
	#tag EndStructure

	#tag Structure, Name = WINDOWINFO, Flags = &h1
		cbSize As Integer
		  WindowArea As Win32.GUI.RECT
		  ClientArea As Win32.GUI.RECT
		  Style As Integer
		  ExStyle As Integer
		  WindowStatus As Integer
		  cxWindowBorders As Integer
		  cyWindowBorders As Integer
		  Atom As UInt16
		CreatorVersion As UInt16
	#tag EndStructure

	#tag Structure, Name = WINDOWPLACEMENT, Flags = &h1
		Length As Integer
		  Flags As Integer
		  ShowCmd As Integer
		  MinPosition As POINT
		  MaxPosition As POINT
		NormalPosition As RECT
	#tag EndStructure

	#tag Structure, Name = WNDCLASS, Flags = &h1
		Style As UInt32
		  WndProc As Ptr
		  ClsExtra As Integer
		  WndExtra As Integer
		  Instance As Integer
		  Icon As Integer
		  Cursor As Integer
		  Brush As Integer
		  MenuName As Ptr
		ClassName As Ptr
	#tag EndStructure

	#tag Structure, Name = WNDCLASSEX, Flags = &h1
		cbSize As Integer
		  Style As UInt32
		  WndProc As Ptr
		  ClsExtra As Integer
		  WndExtra As Integer
		  Instance As Integer
		  Icon As Integer
		  Cursor As Integer
		  Brush As Integer
		  MenuName As Ptr
		  ClassName As Ptr
		IconSm As Integer
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
