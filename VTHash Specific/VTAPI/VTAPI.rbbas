#tag Module
Protected Module VTAPI
	#tag Method, Flags = &h0
		Function AddComment(ResourceID As String, APIKey As String, Comment As String) As JSONItem
		  Dim frm As New MultipartForm
		  frm.Element("apikey") = APIKey
		  frm.Element("resource") = ResourceID
		  frm.Element("comment") = Comment
		  Return SendRequest(RequestType.Comment, frm)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ConnectedHandler(Sender As VTSession)
		  Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CRLF() As String
		  Return EndOfLine.Windows
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ErrorHandler(Sender As VTSession, code As Integer)
		  Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetReport(ResourceID As String, APIKey As String, Type As RequestType) As JSONItem
		  Dim frm As New MultipartForm
		  frm.Element("apikey") = APIKey
		  
		  Select Case Type
		  Case RequestType.FileReport
		    frm.Element("resource") = ResourceID
		  Case VTAPI.RequestType.URLReport
		    frm.Element("url") = ResourceID
		  Case RequestType.IPReport
		    frm.Element("ip") = ResourceID
		  Case RequestType.DomainReport
		    frm.Element("domain") = ResourceID
		  End Select
		  Return SendRequest(Type, frm)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HeadersReceivedHandler(Sender As VTSession, headers As InternetHeaders, code As Integer)
		  Break
		End Sub
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

	#tag Method, Flags = &h21
		Private Function SendRequest(Type As RequestType, Form As MultipartForm) As JSONItem
		  If Sock = Nil Then 
		    Sock = New VTSession
		    AddHandler Sock.Response, AddressOf ResponseHandler
		    AddHandler Sock.Connected, AddressOf ConnectedHandler
		    AddHandler Sock.HeadersReceived, AddressOf HeadersReceivedHandler
		    AddHandler Sock.Error, AddressOf VTAPI.ErrorHandler
		  End If
		  Dim content As String = Form.ToString
		  Dim t As New ContentType("multipart/form-data; boundary=" + Form.Boundary)
		  Sock.SetRequestHeader("User-Agent", "RB-VTAPI/" + VTHash.version + " " + VTHash.PlatformString)
		  Sock.SetPostContent(content, t.ToString)
		  
		  Waiting = True
		  Select Case Type
		  Case RequestType.Comment
		    Sock.SendRequest("POST", "www.virustotal.com" + VT_Put_Comment)
		  Case RequestType.DomainReport
		    Sock.SendRequest("POST", "www.virustotal.com" + VT_Get_Domain)
		  Case RequestType.FileReport
		    Sock.SendRequest("POST", "www.virustotal.com" + VT_Get_File)
		  Case RequestType.FileSubmit
		    Sock.SendRequest("POST", "www.virustotal.com" + VT_Submit_File)
		  Case RequestType.IPReport
		    Sock.SendRequest("POST", "www.virustotal.com" + VT_Get_IP)
		  Case RequestType.Rescan
		    Sock.SendRequest("POST", "www.virustotal.com" + VT_Rescan_File)
		  Case RequestType.URLReport
		    Sock.SendRequest("POST", "www.virustotal.com" + VT_Get_URL)
		  End Select
		  While Waiting
		    App.DoEvents
		  Wend
		  
		  Return Output
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


	#tag Property, Flags = &h0
		LastResponseCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LastResponseVerbose As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Output As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Sock As VTSession
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Waiting As Boolean
	#tag EndProperty


	#tag Constant, Name = AgentVersion, Type = Double, Dynamic = False, Default = \"2.0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RESOURCE_FOUND, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOURCE_INVALID, Type = Double, Dynamic = False, Default = \"-1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOURCE_NOT_FOUND, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOURCE_PENDING, Type = Double, Dynamic = False, Default = \"-2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESPONSE_INVALID, Type = Double, Dynamic = False, Default = \"255", Scope = Protected
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


	#tag Enum, Name = RequestType, Type = Integer, Flags = &h1
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
