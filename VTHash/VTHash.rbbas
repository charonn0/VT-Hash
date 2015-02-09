#tag Module
Protected Module VTHash
	#tag Method, Flags = &h1
		Protected Function ConvertOldConfig(OldConfigFile As FolderItem) As PrefStore
		  OldConfigFile.CopyFileTo(OldConfigFile.Parent.Child(OldConfigFile.Name + ".bak"))
		  OldConfigFile.Delete
		  Dim bs As BinaryStream = BinaryStream.Open(OldConfigFile.Parent.Child(OldConfigFile.Name + ".bak"))
		  Dim data As String = bs.Read(bs.Length)
		  bs.Close
		  Dim js As JSONItem
		  Try
		    js = New JSONItem(data)
		  Catch
		    Return Nil
		  End Try
		  Dim newprefs As PrefStore = PrefStore.Create(OldConfigFile)
		  
		  If js.HasName("Search Engine") And js.HasName("Search URL") Then
		    newprefs.SetValue("SearchEngineName") = js.Value("Search Engine").StringValue
		    newprefs.SetValue("SearchEngineURL") = js.Value("Search URL").StringValue
		  Else
		    newprefs.SetValue("SearchEngineName") = "Google"
		    newprefs.SetValue("SearchEngineURL") = "https://encrypted.google.com/search?q=%PARAMETER%"
		  End If
		  
		  If js.Value("Use SHA1").BooleanValue Then
		    newprefs.SetValue("Algorithm") = Win32.Crypto.CALG_SHA1
		  Else
		    newprefs.SetValue("Algorithm") = Win32.Crypto.CALG_MD5
		  End If
		  
		  Dim g As FolderItem = GetFolderItem(js.Value("Default Save Directory"))
		  If g <> Nil Then
		    newprefs.SetValue("AutoSavePath") = g
		    newprefs.SetValue("AutoSave") = True
		    newprefs.SetValue("DefaultFormat") = js.Value("Default Save Format").Int32Value
		  Else
		    newprefs.SetValue("AutoSavePath") = Nil
		    newprefs.SetValue("AutoSave") = False
		    newprefs.SetValue("DefaultFormat") = Mode_Org_JSON
		  End If
		  newprefs.SetValue("APIKey") = js.Value("API Key")
		  
		  If js.HasName("Comment Signature") Then
		    newprefs.SetValue("CommentSignature") = js.Value("Comment Signature")
		  Else
		    newprefs.SetValue("CommentSignature") = ""
		  End If
		  
		  Return newprefs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CRLF() As String
		  Return EndOfLine.Windows
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FormatBytes(bytes As UInt64, precision As Integer = 2) As String
		  //Converts raw byte counts into SI formatted strings. 1KB = 1024 bytes.
		  //Optionally pass an integer representing the number of decimal places to return. The default is two decimal places. You may specify
		  //between 0 and 16 decimal places. Specifying more than 16 will append extra zeros to make up the length. Passing 0
		  //shows no decimal places and no decimal point.
		  
		  Const kilo = 1024
		  Static mega As UInt64 = kilo * kilo
		  Static giga As UInt64 = kilo * mega
		  Static tera As UInt64 = kilo * giga
		  Static peta As UInt64 = kilo * tera
		  Static exab As UInt64 = kilo * peta
		  
		  Dim suffix, precisionZeros As String
		  Dim strBytes As Double
		  
		  
		  If bytes < kilo Then
		    strbytes = bytes
		    suffix = "bytes"
		  ElseIf bytes >= kilo And bytes < mega Then
		    strbytes = bytes / kilo
		    suffix = "KB"
		  ElseIf bytes >= mega And bytes < giga Then
		    strbytes = bytes / mega
		    suffix = "MB"
		  ElseIf bytes >= giga And bytes < tera Then
		    strbytes = bytes / giga
		    suffix = "GB"
		  ElseIf bytes >= tera And bytes < peta Then
		    strbytes = bytes / tera
		    suffix = "TB"
		  ElseIf bytes >= tera And bytes < exab Then
		    strbytes = bytes / peta
		    suffix = "PB"
		  ElseIf bytes >= exab Then
		    strbytes = bytes / exab
		    suffix = "EB"
		  End If
		  
		  
		  While precisionZeros.Len < precision
		    precisionZeros = precisionZeros + "0"
		  Wend
		  If precisionZeros.Trim <> "" Then precisionZeros = "." + precisionZeros
		  
		  Return Format(strBytes, "#,###0" + precisionZeros) + " " + suffix
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConfig(ConfigName As String) As Variant
		  Return Config.GetValue(ConfigName)
		Exception
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlatformString() As String
		  //Returns a human-readable string corresponding to the version, SKU, service pack, and architecture of
		  //the currently running version of Windows.
		  //e.g. "Windows 7 Ultimate x64 Service Pack 1"
		  
		  #If TargetWin32 Then
		    Return "(VT Hash Check " + VTHash.VersionString + "; U; Win32 " + Str(Win32.OSVersion.BuildNumber) + ")"
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScreenFromXY(X As Integer, Y As Integer) As Integer
		  Dim rect As New REALbasic.Rect
		  Dim pt As New REALbasic.Point
		  pt.X = X
		  pt.Y = Y
		  For i As Integer = 0 To ScreenCount - 1
		    rect.Top = Screen(i).Top
		    rect.Left = Screen(i).Left
		    rect.Width = Screen(i).Width
		    rect.Height = Screen(i).Height
		    If rect.Contains(pt) Then
		      Return i
		    End If
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetConfig(ConfigName As String, NewValue As Variant)
		  Config.SetValue(ConfigName) = NewValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Shorten(Extends data As String, maxLength As Integer = 45) As String
		  //Replaces characters from the middle of a string with a single ellipsis ("...") until data.Len is less than the specified length.
		  //Useful for showing long paths by omitting the middle part of the data, though not limited to this use.
		  
		  If data.Len <= maxLength then
		    Return data
		  Else
		    Dim shortdata, snip As String
		    Dim start As Integer
		    shortdata = data
		    
		    While shortdata.len > maxLength
		      start = shortdata.Len / 3
		      snip = mid(shortdata, start, 5)
		      shortdata = Replace(shortdata, snip, "...")
		    Wend
		    Return shortdata
		  End If
		  
		Exception err
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowCentered(Win As Window, ScreenNumber As Integer = 0)
		  ' Shows the passed window centered on the specified Screen.
		  If Win = Nil Then Win = Window(0)
		  Dim X, Y As Integer
		  X = (0.5 * Screen(ScreenNumber).Width) - (0.5 * Win.Width)
		  Y = (0.5 * Screen(ScreenNumber).Height) - (0.5 * Win.Height)
		  win.Show
		  If Screen(ScreenNumber).Top > Screen(0).Height - 1 Then
		    Y = Y + Screen(ScreenNumber).Height
		  End If
		  If Screen(ScreenNumber).Left > Screen(0).Width - 1 Then
		    X = X + Screen(ScreenNumber).Width
		  End If
		  win.Left = X
		  win.Top = Y
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowInExplorer(extends f As FolderItem)
		  //Shows the file in Windows Explorer
		  
		  Dim sh As New Shell
		  sh.Execute("explorer.exe /select, """ + f.AbsolutePath + """")
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If mConfig = Nil Then
			    Dim f As FolderItem = App.DataFolder.Child("config.dat")
			    If f.Exists Then
			      Dim bs As BinaryStream = BinaryStream.Open(f)
			      Dim isvalid As Boolean = (bs.Read(4) = "VFSv")
			      bs.Close
			      If isvalid Then
			        mConfig = PrefStore.Open(f)
			      ElseIf MsgBox( _
			        "Your configuration file must be converted to the new format." + EndOfLine + _
			        "If for any reason this operation fails, your original configuration file is backed up to: " + _
			        f.AbsolutePath + ".bak", 1 + 48, "Old-style config file detected") = 1 Then
			        mConfig = ConvertOldConfig(f)
			      Else
			        App.mIsQuitting = True
			        Quit()
			      End If
			    Else
			      mConfig = PrefStore.Create(f)
			    End If
			  End If
			  Return mConfig
			End Get
		#tag EndGetter
		Protected Config As PrefStore
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mConfig As PrefStore
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Dim dbg As String
			  If DebugBuild Then dbg = " (debug)"
			  Return Format(VTHash.Version, "0.0#") + dbg
			End Get
		#tag EndGetter
		Protected VersionString As String
	#tag EndComputedProperty


	#tag Constant, Name = AgentVersion, Type = Double, Dynamic = False, Default = \"2.0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Mode_CSV, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Mode_Org_JSON, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Mode_Text, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Mode_Unp_JSON, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Version, Type = Double, Dynamic = False, Default = \"1.49", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = VT_Code_Not_Found, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Code_OK, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Code_Still_Proccessing, Type = Double, Dynamic = False, Default = \"-2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Get_Domain, Type = String, Dynamic = False, Default = \"/vtapi/v2/domain/report", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Get_File, Type = String, Dynamic = False, Default = \"/vtapi/v2/file/report", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Get_IP, Type = String, Dynamic = False, Default = \"/vtapi/v2/ip-address/report", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Get_URL, Type = String, Dynamic = False, Default = \"/vtapi/v2/url/scan", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Put_Comment, Type = String, Dynamic = False, Default = \"/vtapi/v2/comments/put", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Rescan_File, Type = String, Dynamic = False, Default = \"/vtapi/v2/file/rescan", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Submit_File, Type = String, Dynamic = False, Default = \"/vtapi/v2/file/scan", Scope = Public
	#tag EndConstant


	#tag Enum, Name = RequestType, Flags = &h1
		FileReport
		  URLReport
		  DomainReport
		  IPReport
		  FileSubmit
		  Comment
		Rescan
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
