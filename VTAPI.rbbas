#tag Module
Protected Module VTAPI
	#tag Method, Flags = &h1
		Protected Function CreateSock() As HTTPSecureSocket
		  Dim sock As New HTTPSecureSocket
		  Sock.SetRequestHeader("User-Agent", "VTHash/" + version + " (Not at all like Mozilla)")
		  AddHandler sock.SendProgress, AddressOf UploadProgressHandler
		  AddHandler sock.SendComplete, AddressOf UploadCompleteHandler
		  Return sock
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CRLF() As String
		  Return Encodings.ASCII.Chr(13) + Encodings.ASCII.Chr(10)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Encode_multipart_formdata(Fields() As String, Values() As Variant, Boundary As String = "----------ThIs_Is_tHe_Boundary_$") As String
		  Dim content As String
		  for i As Integer = 0 To Ubound(fields)
		    Content = Content + "--" + Boundary + CRLF
		    If VarType(Values(i)) = Variant.TypeString Then
		      Content = Content + "Content-Disposition: form-data; name=""" + Fields(i) + """" + CRLF + CRLF
		      Content = Values(i) + CRLF
		    Else
		      Dim f As FolderItem = Values(i)
		      Dim bs As BinaryStream
		      Dim data As String
		      bs = bs.Open(f, False)
		      data = bs.Read(bs.Length)
		      bs.Close
		      Content = Content + "Content-Disposition: form-data; name=""file""; filename=""" + f.Name + """" + CRLF + CRLF
		      Content = Content + data + CRLF
		    End If
		  next
		  content = content + "--" + Boundary + "--" + CRLF + CRLF
		  
		  return content
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetReport(Hash As String, APIKey As String, ReportType As String = "resource") As JSONItem
		  Dim js As New JSONItem
		  js.Value(ReportType) = Hash
		  js.Value("apikey") = VTAPIKey
		  Return SendRequest(Report_URL, js)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequestRescan(ResourceID As String, APIKey As String) As JSONItem
		  Dim js As New JSONItem
		  js.Value("resource") =ResourceID
		  js.Value("apikey") = APIKey
		  Return SendRequest(Rescan_URL, js)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SendRequest(URL As String, Request As JSONItem, VTSock As HTTPSecureSocket = Nil) As JSONItem
		  If VTSock = Nil Then VTSock = New HTTPSecureSocket
		  VTSock.Secure = useSSL
		  dim formData As New Dictionary
		  For Each Name As String In Request.Names
		    formData.Value(Name) = Request.Value(Name)
		  Next
		  VTSock.SetFormData(formData)
		  Window1.ProgressBar1.Value = 5
		  Dim s As String = VTSock.Post(URL, 5)
		  Return New JSONItem(s)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubmitFile(File As FolderItem, APIKey As String) As JSONItem
		  Window1.ProgressBar1.Maximum = 100
		  Window1.ProgressBar1.Value = 0
		  Window1.TitleText = "Uploading File"
		  Const  BOUNDARY = "----------ThIs_Is_tHe_bouNdaRY_$"
		  Dim js As New JSONItem
		  Dim sock As New HTTPSecureSocket
		  
		  'js.Value("file") = File.Name
		  js.Value("apikey") = VTAPIKey
		  
		  Dim s As String = "Content-Disposition: form-data; name=""file""; filename=""" + File.Name + """"
		  Dim keys() As String
		  Dim values() As Variant
		  keys.Append(File.Name)
		  values.Append(File)
		  sock.SetPostContent(Encode_multipart_formdata(Keys, values), "multipart/form-data; boundary=----------ThIs_Is_tHe_Boundary_$")
		  Return VTAPI.SendRequest(Submit_URL, js, sock)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UploadCompleteHandler(Sender As HTTPSecureSocket, UserAborted As Boolean)
		  Window1.ProgressBar1.value = Window1.ProgressBar1.Maximum
		  Window1.TitleText = "Upload Complete"
		  MsgBox("Your file has been uploaded and a scan has been queued." + EndOfLine + "Please check back later for scan results.")
		  Quit(0)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function UploadProgressHandler(Sender As HTTPSecureSocket, BytesSent as Integer, BytesLeft as Integer) As Boolean
		  Window1.ProgressBar1.value = BytesSent * 100 \ BytesLeft
		End Function
	#tag EndMethod


	#tag Constant, Name = Report_URL, Type = String, Dynamic = False, Default = \"www.virustotal.com/vtapi/v2/file/report", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Rescan_URL, Type = String, Dynamic = False, Default = \"www.virustotal.com/vtapi/v2/file/rescan", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Submit_URL, Type = String, Dynamic = False, Default = \"www.virustotal.com/vtapi/v2/file/scan", Scope = Public
	#tag EndConstant

	#tag Constant, Name = URLReport_URL, Type = String, Dynamic = False, Default = \"www.virustotal.com/vtapi/v2/url/scan", Scope = Public
	#tag EndConstant


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
