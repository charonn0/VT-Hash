#tag Module
Protected Module tools
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
		Sub parseResponse(content As String)
		  Dim js As New JSONItem(content)
		  
		  Select Case js.Value("response_code")
		  Case 0  //Not Found
		    If MsgBox("Hash Not Found!" + EndOfLine + "Would you like to upload this file?", 36, "File Not In Database") <> 6 Then
		      Quit(0)
		    else
		      ShowURL("http://www.virustotal.com/")
		      Quit(0)
		    end if
		  Case -2  //Still Processing
		    Call MsgBox("This file has been uploaded to VirusTotal but is still being processed." + EndOfLine + "Please try again later.", 36, "File Not Yet Processed")
		    Quit(0)
		  Case 1 //Found and ready to go
		    resultWindow.showList(js)
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
		Function saveAs(mode As Integer, f As FolderItem = Nil) As FolderItem
		  Dim d As New Date
		  If f = Nil Then f = GetSaveFolderItem(FileTypes1.All, toBeHashed.Name + "_" + Format(d.TotalSeconds, "#######0000000"))
		  'If Not f.Exists Then f.CreateAsFolder
		  If f = Nil Then Return Nil
		  If f.Directory Then
		    resultWindow.saved.Text = "Invalid Save Path"
		    resultWindow.saved.TextColor = &cFF0000
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
		    For i As Integer = 0 To resultWindow.ListBox1.LastIndex
		      tos.WriteLine(resultWindow.ListBox1.Cell(i, 0) + " " + resultWindow.ListBox1.Cell(i, 1) + ": " + Chr(9) + resultWindow.ListBox1.Cell(i, 2))
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
		    For i As Integer = 0 To resultWindow.ListBox1.LastIndex
		      tos.WriteLine(resultWindow.ListBox1.Cell(i, 0) + "," + resultWindow.ListBox1.Cell(i, 1) + "," + resultWindow.ListBox1.Cell(i, 2))
		    Next
		  End Select
		  tos.Close
		  Return f
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

	#tag Method, Flags = &h1
		Protected Function Timezone() As String
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
