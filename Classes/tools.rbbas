#tag Module
Protected Module tools
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
		Function pretifyPath(path As String) As String
		  if path.Len < 45 then
		    Return path
		  else
		    dim shortPath, snip As String
		    dim start As Integer
		    shortPath = path
		    
		    While shortPath.len > 45
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
