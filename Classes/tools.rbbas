#tag Module
Protected Module tools
	#tag ExternalMethod, Flags = &h0
		Declare Function FindExecutable Lib "Shell32" Alias "FindExecutableW" (file As WString, directory As WString, result As Ptr) As Integer
	#tag EndExternalMethod

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
		Function isFound(Extends f As FolderItem) As Integer
		  Declare Function CloseHandle Lib "Kernel32"(HWND As Integer) As Boolean
		  Declare Function CreateFileW Lib "Kernel32"(name As WString, access As Integer, sharemode As Integer, SecAtrribs As Integer, _
		  CreateDisp As Integer, flags As Integer, template As Integer) As Integer
		  
		  Dim HWND As Integer = CreateFileW(f.AbsolutePath, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0)
		  If HWND = -1 Then
		    HWND = GetLastError()
		    Select Case HWND
		    Case 5
		      Return ACCESS_DENIED
		    Case 2
		      Return FILE_NOT_FOUND
		    Else
		      Return ERROR_OTHER
		    End Select
		    
		  Else
		    Call CloseHandle(HWND)
		    Return ERROR_NO_ERROR
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MD5Hash(target As FolderItem, sizeCutoff As UInt64 = 52428800, readSize As Integer = 4096) As String
		  //If the target is less than sizeCutoff in bytes (default is 50MB) this function uses the MD5() function to hash the file
		  //If greater than sizeCutoff this function processes the file through the MD5Digest function. MD5Digest is preferable when
		  //hashing large files since the entire file will not be loaded into memory at once. This prevents OutOfMemoryException's and
		  //other bad things.
		  //If using MD5Digest, the readSize parameter dictates how much of the file to read at a time. Default is 4096 bytes
		  //Returns the Hex representation of the hash
		  //
		  //See Win32Crypto.Hash for additional hashing functionality
		  
		  Dim s As String
		  If target.Length < sizeCutoff Then
		    Dim tis As TextInputStream
		    tis = tis.Open(target)
		    s = tis.ReadAll
		    tis.Close
		    s = StringToHex(MD5(s))
		  Else
		    Dim bs As BinaryStream
		    bs = bs.Open(target)
		    Dim m5 As New MD5Digest
		    While Not bs.EOF
		      s = bs.Read(readSize)
		      m5.Process(s)
		    Wend
		    bs.Close
		    s = StringToHex(m5.Value)
		  End If
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub parseResponse(js As JSONItem)
		  'Dim js As New JSONItem(content)
		  Select Case js.Value("response_code")
		  Case 0  //Not Found
		    If MsgBox("Hash Not Found!" + EndOfLine + "Would you like to upload this file?", 36, "File Not In Database") <> 6 Then
		      Quit(0)
		    else
		      'ShowURL("http://www.virustotal.com/")
		      'Quit(0)
		      Dim response As JSONItem = VTAPI.SubmitFile(toBeHashed, VTAPIKey)
		      Break
		      
		    end if
		  Case -2  //Still Processing
		    Call MsgBox("This file has been uploaded to VirusTotal but is still being processed." + EndOfLine + "Please try again later.", 36, "File Not Yet Processed")
		    Quit(0)
		  Case 1 //Found and ready to go
		    resultWindows.Append(New resultWindow)
		    resultWindows(0).showList(js)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pretifyPath(path As String, tolen As Integer = 45) As String
		  if path.Len < 45 then
		    Return path
		  else
		    dim shortPath, snip As String
		    dim start As Integer
		    shortPath = path
		    
		    While shortPath.len > tolen
		      start = shortPath.Len / 3
		      snip = mid(shortPath, start, 5)
		      shortPath = Replace(shortPath, snip, "...")
		    Wend
		    Return shortPath
		  end if
		  
		Exception err
		  Return path
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
		Function StringToHex(src as string) As string
		  //Hexify a string of binary data, e.g. from RB's built-in MD5 function
		  
		  Dim hexvalue As Integer
		  Dim hexedInt As String
		  
		  For i As Integer = 1 To LenB(src)
		    hexvalue = AscB(MidB(src, i, 1))
		    hexedInt = hexedInt + RightB("00" + Hex(hexvalue), 2)
		  next
		  
		  Return LeftB(hexedInt, LenB(hexedInt))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Timezone() As String
		  //This function returns a string representing the name of the current time zone. e.g. "EST" or "Pacific Daylight Time." This name
		  //is localized and may be up to 32 characters long.
		  //On error, returns an empty string.
		  
		  #If TargetWin32 Then
		    Declare Function GetTimeZoneInformation Lib "Kernel32" (ByRef TZInfo As TIME_ZONE_INFORMATION) As Integer
		    
		    Const daylightSavingsOn = 2
		    Const daylightSavingsOff = 1
		    Const daylightSavingsUnknown = 0
		    Const invalidTimeZone = &hFFFFFFFF
		    
		    Dim TZInfo As TIME_ZONE_INFORMATION
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
		Function Tokenize(ByVal Input As String) As String()
		  //Returns a String array containing the space-delimited members of the Input string.
		  //Like `String.Split(" ")` but honoring quotes; good for command line arguments and other parsing.
		  //For example, this string:
		  '                     MyApp.exe --foo "C:\My Dir\"
		  //Would become:
		  '                     s(0) = MyApp.exe
		  '                     s(1) = --foo
		  '                     s(2) = "C:\My Dir\"
		  
		  
		  #If TargetWin32 Then
		    Declare Function PathGetArgsW Lib "Shlwapi" (path As WString) As WString
		    Dim ret() As String
		    Dim cmdLine As String = Input
		    While cmdLine.Len > 0
		      Dim tmp As String
		      Dim args As String = PathGetArgsW(cmdLine)
		      If Len(args) = 0 Then
		        tmp = ReplaceAll(cmdLine.Trim, Chr(34), "")
		        ret.Append(tmp)
		        Exit While
		      Else
		        tmp = Left(cmdLine, cmdLine.Len - args.Len).Trim
		        tmp = ReplaceAll(tmp, Chr(34), "")
		        ret.Append(tmp)
		        cmdLine = args
		      End If
		    Wend
		    Return ret
		  #endif
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Trid(f As FolderItem) As String
		  If f.Directory Then Return "That is a directory."
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
		  Dim ret As String = "Filetype not known (plain text?)"
		  sh.Execute("""" + g.AbsolutePath + """" + " """ + f.AbsolutePath + """")
		  Dim search() As String = sh.Result.Split(EndOfLine)
		  Dim pattern As String = "([+-]?\d*\.\d+)(?![-+0-9\.])(%)(\s+)(.*)\((\d*)"
		  For i As Integer = 0 To UBound(search)
		    Dim res() As String = search(i).RegExFind(pattern)
		    If UBound(res) > -1 Then
		      ret = res(4)
		      Exit
		    End If
		  Next
		  
		  Return ret
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ResultWindows() As resultWindow
	#tag EndProperty


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
