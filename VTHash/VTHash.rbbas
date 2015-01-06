#tag Module
Protected Module VTHash
	#tag Method, Flags = &h0
		Function AddComment(ResourceID As String, APIKey As String, Comment As String) As JSONItem
		  Dim frm As New MultipartForm
		  frm.Element("apikey") = APIKey
		  frm.Element("resource") = ResourceID
		  frm.Element("comment") = Comment
		  Return SendRequest(RequestType.Comment, frm)
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
		Function GetReport(ResourceID As String, APIKey As String, Type As RequestType) As JSONItem
		  Dim frm As New MultipartForm
		  frm.Element("apikey") = APIKey
		  
		  Select Case Type
		  Case RequestType.FileReport
		    frm.Element("resource") = ResourceID
		  Case VTHash.RequestType.URLReport
		    frm.Element("url") = ResourceID
		  Case RequestType.IPReport
		    frm.Element("ip") = ResourceID
		  Case RequestType.DomainReport
		    frm.Element("domain") = ResourceID
		  End Select
		  Return SendRequest(Type, frm)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlatformString() As String
		  //Returns a human-readable string corresponding to the version, SKU, service pack, and architecture of
		  //the currently running version of Windows.
		  //e.g. "Windows 7 Ultimate x64 Service Pack 1"
		  
		  #If TargetWin32 Then
		    Return "(VT Hash Check " + VTHash.version + "; U; Win32 " + Str(Win32.OSVersion.BuildNumber) + ")"
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RegExFind(Extends source As String, pattern As String) As String()
		  //Returns a string array of all subexpressions
		  
		  Dim rg as New RegEx
		  Dim myMatch as RegExMatch
		  Dim ret() As String
		  rg.SearchPattern = pattern
		  myMatch=rg.search(source)
		  If myMatch <> Nil Then
		    For i As Integer = 0 To myMatch.SubExpressionCount - 1
		      ret.Append(myMatch.SubExpressionString(i))
		    Next
		  End If
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequestRescan(ResourceID As String, APIKey As String) As JSONItem
		  Dim frm As New MultipartForm
		  frm.Element("resource") = ResourceID
		  frm.Element("apikey") = APIKey
		  Return SendRequest(RequestType.Rescan, frm)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResponseHandler(Sender As VTSession, ResponseObject As JSONItem, HTTPStatus As Integer)
		  #pragma Unused Sender
		  If HTTPStatus = 200 And ResponseObject <> Nil Then
		    Output = ResponseObject
		  Else
		    Output = Nil
		  End If
		  Waiting = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveSettings()
		  Dim s As New JSONItem
		  s.Value("Use SHA1") = algorithm <> Win32.Crypto.CALG_MD5
		  s.Value("Autosave Results") = autosave
		  s.Value("Default Save Format") = defaultFormat
		  If autosavePath <> Nil Then
		    s.Value("Default Save Directory") = autosavePath.AbsolutePath
		  Else
		    s.Value("Default Save Directory") = SpecialFolder.ApplicationData.Child("Boredom Software").Child("VT Hash").Child("scans").AbsolutePath
		  End If
		  s.Value("API Key") = VTAPIKey
		  s.Value("Search Engine") = SearchEngineName
		  s.Value("Search URL") = SearchEngineURL
		  s.Value("Comment Signature") = CommentSignature.Trim
		  s.Compact = False
		  Dim t As String = s.ToString
		  Dim tos As TextOutputStream
		  Dim f As FolderItem = SpecialFolder.ApplicationData.Child("Boredom Software")
		  If Not f.Exists Then
		    f.CreateAsFolder()
		  End If
		  f = f.Child("VT Hash")
		  If Not f.Exists Then
		    f.CreateAsFolder()
		  End If
		  f = f.Child("config.dat")
		  tos = tos.Create(f)
		  tos.Write(t)
		  tos.Close
		End Sub
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
		Function SearchEngineSet() As Boolean
		  Return SearchEngineName.Trim <> "" And SearchEngineURL.Trim <> ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest(Type As RequestType, Form As MultipartForm) As JSONItem
		  If Sock = Nil Then
		    Sock = New VTSession
		    AddHandler Sock.Response, AddressOf ResponseHandler
		    'AddHandler Sock.Connected, AddressOf ConnectedHandler
		    'AddHandler Sock.HeadersReceived, AddressOf HeadersReceivedHandler
		    'AddHandler Sock.Error, AddressOf VTHash.ErrorHandler
		  End If
		  Dim content As String = Form.ToString
		  Dim t As New ContentType("multipart/form-data; boundary=" + Form.Boundary)
		  Sock.SetRequestHeader("User-Agent", "RB-VTAPI/" + Format(AgentVersion, "#0.0#") + " " + VTHash.PlatformString)
		  Sock.SetPostContent(content, t.ToString)
		  
		  '#if DebugBuild Then
		  'Dim apiurl As String = System.GetNetworkInterface(0).IPAddress
		  '#else
		  Dim apiurl As String = "www.virustotal.com"
		  '#endif
		  
		  Waiting = True
		  Select Case Type
		  Case RequestType.Comment
		    Sock.SendRequest("POST", apiurl + VT_Put_Comment)
		  Case RequestType.DomainReport
		    Sock.SendRequest("POST", apiurl + VT_Get_Domain)
		  Case RequestType.FileReport
		    Sock.SendRequest("POST", apiurl + VT_Get_File)
		  Case RequestType.FileSubmit
		    Sock.SendRequest("POST", apiurl + VT_Submit_File)
		  Case RequestType.IPReport
		    Sock.SendRequest("POST", apiurl + VT_Get_IP)
		  Case RequestType.Rescan
		    Sock.SendRequest("POST", apiurl + VT_Rescan_File)
		  Case RequestType.URLReport
		    Sock.SendRequest("POST", apiurl + VT_Get_URL)
		  End Select
		  While Waiting
		    App.DoEvents
		  Wend
		  
		  Return Output
		End Function
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
		  
		  #If TargetWin32 Then
		    Dim param As String = "/select, """ + f.AbsolutePath + """"
		    Soft Declare Sub ShellExecuteW Lib "Shell32" (hwnd As Integer, op As WString, file As WString, params As WString, directory As Integer, _
		    cmd As Integer)
		    
		    Const SW_SHOW = 5
		    ShellExecuteW(0, "open", "explorer", param, 0, SW_SHOW)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatusCodeText(StatusCode As Integer) As String
		  Select Case StatusCode
		  Case 100
		    Return "Continue"
		  Case 101
		    Return "Switching Protocols"
		  Case 102
		    Return "Processing"
		  Case 200
		    Return "OK"
		  Case 201
		    Return "Created"
		  Case 202
		    Return "Accepted"
		  Case 203
		    Return "Non-Authoritative"
		  Case 204
		    Return "No Content"
		  Case 205
		    Return "Reset Content"
		  Case 206
		    Return "Partial Content"
		  Case 207
		    Return "Multi-Status"
		  Case 208
		    Return "Already Reported"
		  Case 209
		    Return "IM Used"
		  Case 300
		    Return "Multiple Choices"
		  Case 301
		    Return "Moved Permanently"
		  Case 302
		    Return "Found"
		  Case 303
		    Return "See Other"
		  Case 304
		    Return "Not Modified"
		  Case 305
		    Return "Use Proxy"
		  Case 306
		    Return "Switch Proxy"
		  Case 307
		    Return "Temporary Redirect"
		  Case 308
		    Return "Permanent Redirect"
		  Case 400
		    Return "Bad Request"
		  Case 401
		    Return "Unauthorized"
		  Case 402
		    Return "Payment Required"
		  Case 403
		    Return "Forbidden"
		  Case 404
		    Return "Not Found"
		  Case 405
		    Return "Method Not Allowed"
		  Case 406
		    Return "Not Acceptable"
		  Case 407
		    Return "Proxy Authentication Required"
		  Case 408
		    Return "Request Timeout"
		  Case 409
		    Return "Conflict"
		  Case 410
		    Return "Gone"
		  Case 411
		    Return "Length Required"
		  Case 412
		    Return "Precondition Failed"
		  Case 413
		    Return "Request Entity Too Large"
		  Case 414
		    Return "Request-URI Too Long"
		  Case 415
		    Return "Unsupported Media Type"
		  Case 416
		    Return "Requested Range Not Satisfiable"
		  Case 417
		    Return "Expectation Failed"
		  Case 418
		    Return "I'm A Teapot"
		  Case 420
		    Return "Enhance Your Calm"
		  Case 422
		    Return "Unprocessable Entity"
		  Case 423
		    Return "Locked"
		  Case 424
		    Return "Failed Dependency or Method Failure"
		  Case 425
		    Return "Unordered Collection"
		  Case 426
		    Return "Upgrade Required"
		  Case 428
		    Return "Precondition Required"
		  Case 429
		    Return "Too Many Requests"
		  Case 431
		    Return "Request Header Fields Too Large"
		  Case 444
		    Return "No Response"
		  Case 449
		    Return "Retry With"
		  Case 450
		    Return "Blocked by Windows Parental Controls"
		  Case 451
		    Return "Unavailable For Legal Reasons"
		  Case 499
		    Return "Client Closed Request"
		  Case 500
		    Return "Internal Server Error"
		  Case 501
		    Return "Not Implemented"
		  Case 502
		    Return "Bad Gateway"
		  Case 503
		    Return "Service Unavailabe"
		  Case 504
		    Return "Gateway Timeout"
		  Case 505
		    Return "HTTP Version Not Supported"
		  Case 506
		    Return "Variant Also Negotiates"
		  Case 507
		    Return "Insufficient Storage"
		  Case 508
		    Return "Loop Detected"
		  Case 509
		    Return "Bandwidth Limit Exceeded"
		  Case 510
		    Return "Not Extended"
		  Case 511
		    Return "Network Authentication Required"
		  Case 598
		    Return "Network Read Timeout"
		  Case 599
		    Return "Network Connect Timeout"
		  Else
		    Return "Not HTTP"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubmitFile(File As FolderItem, APIKey As String) As JSONItem
		  Dim frm As New MultipartForm
		  frm.Element("apikey") = APIKey
		  frm.Element("file") = File
		  Return SendRequest(RequestType.FileSubmit, frm)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Timezone() As String
		  //This function returns a string representing the name of the current time zone. e.g. "EST" or "Pacific Daylight Time." This name
		  //is localized and may be up to 32 characters long.
		  //On error, returns an empty string.
		  
		  #If TargetWin32 Then
		    Declare Function GetTimeZoneInformation Lib "Kernel32" (ByRef TZInfo As Win32.Utils.TIME_ZONE_INFORMATION) As Integer
		    
		    Const daylightSavingsOn = 2
		    Const daylightSavingsOff = 1
		    Const daylightSavingsUnknown = 0
		    Const invalidTimeZone = &hFFFFFFFF
		    
		    Dim TZInfo As Win32.Utils.TIME_ZONE_INFORMATION
		    Dim dlsStatus As Integer = GetTimeZoneInformation(TZInfo)
		    
		    If dlsStatus = daylightSavingsOn Or dlsStatus = daylightSavingsOff Or dlsStatus = daylightSavingsUnknown Then
		      Return TZInfo.StandardName
		    Else
		      Return ""
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Trid(f As FolderItem) As Dictionary
		  If f.Directory Then Return New Dictionary("That is a directory":100)
		  Dim g As FolderItem = SpecialFolder.Temporary.Child("trid.exe")
		  Dim d As FolderItem = SpecialFolder.Temporary.Child("triddefs.trd")
		  Dim tos As TextOutputStream
		  tos = tos.Create(g)
		  tos.Write(trid1)
		  tos.Close
		  tos = tos.Create(d)
		  tos.Write(triddefs)
		  tos.Close
		  
		  Dim sh As New Shell
		  Dim ret As Dictionary
		  sh.Execute(g.ShellPath + " " + f.ShellPath)
		  Dim search() As String = sh.Result.Split(EndOfLine)
		  Dim pattern As String = "([+-]?\d*\.\d+)(?![-+0-9\.])(%)(\s+)(.*)\((\d*)"
		  For i As Integer = 0 To UBound(search)
		    Dim res() As String = search(i).RegExFind(pattern)
		    If UBound(res) > -1 Then
		      If ret = Nil Then ret = New Dictionary
		      ret.Value(res(4)) = Val(res(1))
		    End If
		  Next
		  
		  Return ret
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		algorithm As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		autosave As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mautosavePath = Nil Then
			    mautosavePath = SpecialFolder.ApplicationData.Child("Boredom Software").Child("VT Hash").Child("scans")
			    If Not mautosavePath.Exists Then mautosavePath.CreateAsFolder
			  End If
			  return mautosavePath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mautosavePath = value
			End Set
		#tag EndSetter
		autosavePath As FolderItem
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		cancel As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		CommentSignature As String
	#tag EndProperty

	#tag Property, Flags = &h0
		defaultFormat As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		errorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h0
		fileData As String
	#tag EndProperty

	#tag Property, Flags = &h0
		LastResponseCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LastResponseVerbose As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mautosavePath As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mversion As Double = 1.48
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Output As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h0
		ResultWindows() As resultWindow
	#tag EndProperty

	#tag Property, Flags = &h0
		SearchEngineName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SearchEngineURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Sock As VTSession
	#tag EndProperty

	#tag Property, Flags = &h0
		toBeHashed As FolderItem
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Format(mversion, "0.0#")
			End Get
		#tag EndGetter
		version As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		VTAPIKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Waiting As Boolean
	#tag EndProperty


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
			Name="algorithm"
			Group="Behavior"
			InitialValue="""""MD5"""""
			Type="Integer"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="autosave"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="cancel"
			Group="Behavior"
			InitialValue="false"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CommentSignature"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultFormat"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="errorMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="fileData"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastResponseCode"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastResponseVerbose"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="PROCESS_QUERY_LIMITED_INFORMATION"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SearchEngineName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SearchEngineURL"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
		#tag ViewProperty
			Name="version"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="VTAPIKey"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
