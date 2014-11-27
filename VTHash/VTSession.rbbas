#tag Class
Protected Class VTSession
Inherits HTTPSecureSocket
	#tag Event
		Sub PageReceived(url as string, httpStatus as integer, headers as internetHeaders, content as string)
		  #pragma Unused url
		  #pragma Unused headers
		  
		  If httpStatus = 200 Then
		    Try
		      RaiseEvent Response(New JSONItem(content.Trim), httpStatus)
		    Catch Err As JSONException
		      RaiseEvent Response(Nil, httpStatus)
		    End Try
		  Else
		    RaiseEvent Response(Nil, httpStatus)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function SendProgress(bytesSent as Integer, bytesLeft as Integer) As Boolean
		  Return RaiseEvent SendProgress(bytesSent, bytesLeft)
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddComment(ResourceID As String, Comment As String)
		  'ResourceID is either a file hash or a URL
		  'Comment is the text of the comment to post.
		  
		  Dim frm As New MultipartForm
		  frm.Element("apikey") = APIKey
		  frm.Element("resource") = ResourceID
		  frm.Element("comment") = Comment
		  SendRequest(RequestType.Comment, frm)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetReport(ResourceID As String, Type As VTHash.RequestType)
		  'ResourceID is either a file hash or a URL
		  'Report type is a member of the RequestType Enum. e.g. VTHash.RequestType.FileReport
		  
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
		  SendRequest(Type, frm)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequestRescan(ResourceID As String)
		  'ResourceID is either a file hash or a URL
		  
		  Dim frm As New MultipartForm
		  frm.Element("resource") = ResourceID
		  frm.Element("apikey") = APIKey
		  SendRequest(RequestType.Rescan, frm)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendRequest(Type As RequestType, Request As MultipartForm)
		  Dim APIURL As String = "www.virustotal.com"
		  Dim HTTPVerb As String = "POST"
		  Dim content As String
		  content = Request.ToString
		  Dim t As New ContentType("multipart/form-data; boundary=" + Request.Boundary)
		  Me.SetRequestHeader("User-Agent", "RB-VTAPI/" + Format(VTHash.AgentVersion, "#0.0#") + " " + VTHash.PlatformString)
		  Me.SetPostContent(Content, t.ToString)
		  
		  Select Case Type
		  Case RequestType.Comment
		    APIURL = APIURL + VT_Put_Comment
		  Case RequestType.DomainReport
		    #pragma Warning "Fix me" ' RB doesn't send the post content with GET
		    HTTPVerb = "GET"
		    APIURL = APIURL + VT_Get_Domain
		  Case RequestType.FileReport
		    APIURL = APIURL + VT_Get_File
		  Case RequestType.FileSubmit
		    APIURL = APIURL + VT_Submit_File
		  Case RequestType.IPReport
		    #pragma Warning "Fix me" ' RB doesn't send the post content with GET
		    HTTPVerb = "GET"
		    APIURL = APIURL + VT_Get_IP
		  Case RequestType.Rescan
		    APIURL = APIURL + VT_Rescan_File
		  Case RequestType.URLReport
		    APIURL = APIURL + VT_Get_URL
		  Else
		    Raise New RuntimeException
		  End Select
		  
		  Super.SendRequest(HTTPVerb, APIURL)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubmitFile(File As FolderItem)
		  Dim frm As New MultipartForm
		  frm.Element("apikey") = APIKey
		  frm.Element("file") = File
		  SendRequest(RequestType.FileSubmit, frm)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Response(ResponseObject As JSONItem, HTTPStatus As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SendProgress(BytesSent As Integer, BytesLeft As Integer) As Boolean
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
			Name="CertificateFile"
			Visible=true
			Group="Behavior"
			Type="FolderItem"
			InheritedFrom="HTTPSecureSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CertificatePassword"
			Visible=true
			Group="Behavior"
			Type="String"
			InheritedFrom="HTTPSecureSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CertificateRejectionFile"
			Visible=true
			Group="Behavior"
			Type="FolderItem"
			InheritedFrom="HTTPSecureSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConnectionType"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="Integer"
			InheritedFrom="HTTPSecureSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			InheritedFrom="SSLSocket"
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
			Name="Secure"
			Visible=true
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="HTTPSecureSocket"
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
	#tag EndViewBehavior
End Class
#tag EndClass
