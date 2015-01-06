#tag Module
Protected Module Shell32
	#tag ExternalMethod, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Declare Function ExtractIconEx Lib "Shell32" Alias "ExtractIconExW" (ResourceFile As WString, Index As Integer, largeIco As Ptr, smallIco As Ptr, Icons As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function FindExecutable Lib "Shell32" Alias "FindExecutableW" (file As WString, directory As WString, result As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function IsUserAnAdmin Lib "Shell32" () As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function PathIsSlow Lib "Shell32" Alias "PathIsSlowW" (path As WString, attribs As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function PathResolve Lib "Shell32" (path As Ptr, startDir As Ptr, flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function PickIconDlg Lib "Shell32" (ParentWindow As Integer, resource As Ptr, resourceLen As Integer, ByRef Index As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function ShellAbout Lib "Shell32" Alias "ShellAboutW" (HWND As Integer, msgString As WString, otherStuff As WString, hIcon As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function ShellExecute Lib "Shell32" Alias "ShellExecuteW" (HWND As Integer, op As WString, file As WString, params As WString, directory As WString, cmd As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Declare Function Shell_NotifyIcon Lib "Shell32" Alias "Shell_NotifyIconW" (Message As Integer, Data As Win32 . GUI . NOTIFYICONDATA) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Declare Function SHGetFileInfo Lib "Shell32" Alias "SHGetFileInfoW" (FilePath As WString, Attribs As Integer, ByRef info As Win32 . GUI . SHFILEINFO, infoSize As Integer, flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Declare Sub SHGetSettings Lib "Shell32" (ByRef flagStruct As Win32 . GUI . SHELLFLAGSTATE, flags As Integer)
	#tag EndExternalMethod


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
