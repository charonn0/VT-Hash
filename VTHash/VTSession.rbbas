#tag Class
Protected Class VTSession
Inherits libcURL.cURLClient
	#tag Event
		Sub TransferComplete(BytesRead As Integer, BytesWritten As Integer)
		  #pragma Unused BytesRead
		  #pragma Unused BytesWritten
		  Dim responseobj As JSONItem
		  If Me.GetStatusCode = 200 Then
		    responseobj = New JSONItem(Me.GetDownloadedData)
		    RaiseEvent Response(responseobj, 200)
		  Else
		    RaiseEvent Response(Nil, Me.GetStatusCode)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddComment(ResourceID As String, Comment As String)
		  'ResourceID is either a file hash or a URL
		  'Comment is the text of the comment to post.
		  
		  Dim frm As New Dictionary
		  frm.Value("apikey") = APIKey
		  frm.Value("resource") = ResourceID
		  frm.Value("comment") = Comment
		  Me.RequestHeaders.RemoveHeader("Expect")
		  SendRequest(RequestType.Comment, frm)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  // Constructor() -- From cURLManager
		  Super.Constructor()
		  EasyItem.Verbose = VTHash.CurlVerbose
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetReport(ResourceID As String, Type As VTHash.RequestType)
		  'ResourceID is either a file hash or a URL
		  'Report type is a member of the RequestType Enum. e.g. VTHash.RequestType.FileReport
		  
		  Dim frm As New Dictionary
		  frm.Value("apikey") = APIKey
		  
		  Select Case Type
		  Case RequestType.FileReport
		    frm.Value("resource") = ResourceID
		  Case VTHash.RequestType.URLReport
		    frm.Value("url") = ResourceID
		  Case RequestType.IPReport
		    frm.Value("ip") = ResourceID
		  Case RequestType.DomainReport
		    frm.Value("domain") = ResourceID
		  End Select
		  Me.RequestHeaders.RemoveHeader("Expect")
		  SendRequest(Type, frm)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequestRescan(ResourceID As String)
		  'ResourceID is either a file hash or a URL
		  
		  Dim frm As New Dictionary
		  frm.Value("resource") = ResourceID
		  frm.Value("apikey") = APIKey
		  Me.RequestHeaders.RemoveHeader("Expect")
		  SendRequest(RequestType.Rescan, frm)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendRequest(Type As RequestType, Request As libcURL.MultipartForm)
		  Me.EasyItem.UseErrorBuffer = True
		  Me.EasyItem.Secure = App.Secure
		  Me.EasyItem.CA_ListFile = libcURL.Default_CA_File
		  If VTHash.HasConfig("ProxyAddress") Then
		    Me.Proxy.Address = VTHash.GetConfig("ProxyAddress")
		    Me.Proxy.Port = VTHash.GetConfig("ProxyPort")
		    Me.Proxy.Username = VTHash.GetConfig("ProxyUsername")
		    Me.Proxy.Password = VTHash.GetConfig("ProxyPassword")
		    Me.Proxy.Type = libcURL.ProxyType(VTHash.GetConfig("ProxyType").Int32Value)
		    'Me.ProxyEngine.ServiceName = VTHash.GetConfig("ProxyName")
		  End If
		  
		  'If VTHash.HasConfig("NetworkInterface") Then
		  'Dim n As NetworkInterface
		  'For i As Integer = 0 To System.NetworkInterfaceCount - 1
		  'n = System.GetNetworkInterface(i)
		  'If n.IPAddress = VTHash.GetConfig("NetworkInterface") Then
		  'Exit For
		  'Else
		  'n = Nil
		  'End If
		  'Next
		  'If n <> Nil Then Me.EasyItem.NetworkInterface = n
		  'End If
		  
		  
		  Dim APIURL As String
		  If VTHash.GetConfig("UseSSL") Then
		    APIURL = "https://www.virustotal.com"
		  Else
		    APIURL = "http://www.virustotal.com"
		  End If
		  
		  Dim HTTPVerb As String = "POST"
		  Me.EasyItem.UserAgent = VTHash.UserAgent
		  Select Case Type
		  Case RequestType.Comment
		    APIURL = APIURL + VT_Put_Comment
		  Case RequestType.DomainReport
		    HTTPVerb = "GET"
		    APIURL = APIURL + VT_Get_Domain
		  Case RequestType.FileReport
		    APIURL = APIURL + VT_Get_File
		  Case RequestType.FileSubmit
		    APIURL = APIURL + VT_Submit_File
		  Case RequestType.IPReport
		    HTTPVerb = "GET"
		    APIURL = APIURL + VT_Get_IP
		  Case RequestType.Rescan
		    APIURL = APIURL + VT_Rescan_File
		  Case RequestType.URLReport
		    APIURL = APIURL + VT_Get_URL
		  Else
		    Raise New RuntimeException
		  End Select
		  
		  If HTTPVerb = "POST" Then
		    Me.Post(APIURL, Request)
		  ElseIf HTTPVerb = "GET" Then
		    Me.EasyItem.SetFormData(Request)
		    Me.Get(APIURL)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubmitFile(File As FolderItem)
		  Dim frm As New libcURL.MultipartForm
		  Call frm.AddElement("apikey", APIKey)
		  Dim bs As BinaryStream = BinaryStream.Open(File)
		  Call frm.AddElement("file", bs, bs.Length, File.Name)
		  Me.RequestHeaders.SetHeader("Expect", "100-Continue")
		  SendRequest(RequestType.FileSubmit, frm)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Response(ResponseObject As JSONItem, HTTPStatus As Integer)
	#tag EndHook


	#tag Property, Flags = &h0
		APIKey As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="APIKey"
			Visible=true
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsSSLCertOK"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.cURLManager"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Password"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="libcURL.cURLManager"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="SSLSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Username"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="libcURL.cURLManager"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Yield"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="libcURL.cURLManager"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
