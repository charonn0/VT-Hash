#tag Class
Protected Class SSLPoster
Inherits HTTPSecureSocket
	#tag Event
		Sub Error(code as integer)
		  dim theMessage As Integer
		  Select Case code
		  case 100
		    theMessage = MsgBox("Winsock Driver Error" + EndOfLine + "Could Not Open The Socket", 16, "Socket Error 100")
		  case 102
		    if not retry then
		      theMessage = MsgBox("Connection Lost" + EndOfLine + "Remote Host Ended The Session", 16, "Socket Error 101")
		    end if
		  case 103
		    theMessage = MsgBox("Server Could Be Resolved." + EndOfLine + "Are You Connected To The Internet?", 16, "Socket Error 103")
		  case 105
		    theMessage = MsgBox("Port In Use" + EndOfLine + "Could Not Bind To The Specified Port", 16, "Socket Error 105")
		  case 106
		    theMessage = MsgBox("Invalid State For Required Action" + EndOfLine + "The Socket Could Not Perform The Requested Action At This Time", 16, "Socket Error 106")
		  case 107
		    theMessage = MsgBox("Invalid Port" + EndOfLine + "Port Numer Is Out Of Range Or Restricted", 16, "Socket Error 107")
		  case 108
		    theMessage = MsgBox("Out Of Memory" + EndOfLine + "Insufficient Available Memory TO Proceed", 16, "Socket Error 108")
		  else
		    theMessage = MsgBox("Unknown TCP Error." + EndOfLine + "Error was: " + str(code), 16, "Unknown Error")
		  end select
		  
		  Window1.Close
		  self.Close
		End Sub
	#tag EndEvent

	#tag Event
		Sub HeadersReceived(headers as internetHeaders, httpStatus as integer)
		  if not cancel then
		    if httpStatus <> 200 then
		      unexpectedResponse(HTTPStatus)
		    end if
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub PageReceived(url as string, httpStatus as integer, headers as internetHeaders, content as string)
		  parseResponse(content)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub sendTheHash(hash As String)
		  if not cancel  then
		    dim formData As New Dictionary
		    formData.Value("resource") = hash
		    formData.Value("key") = VTAPIKey
		    me.SetFormData(formData)
		    me.SetRequestHeader("User-Agent", "VTHash/" + version + " (Not at all like Mozilla)")
		    Window1.ProgressBar1.Value = 5
		    me.Post("https://www.virustotal.com/vtapi/v2/file/report")
		  else
		    self.Close
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub unexpectedResponse(error As Integer)
		  Select Case error
		  Case 204
		    Call MsgBox("You have exceeded the maximum number of requests permitted by VirusTotal." + EndOfLine + "Wait 10 minutes and try again.", 16, "Request Rate Limit Exceeded!")
		    Quit(1)
		  Case 403
		    If MsgBox("Your Virus Total API key is invalid or was refused by Virus Total for some other reason." + EndOfLine + "Click OK to edit your API key or Cancel to quit.", 17, "Invalid API Key") = 1 Then
		      settswin.ShowMe
		    End If
		  Else
		    Call MsgBox("VirusTotal returned an undefined error (" + StatusCodeText(error) + ") rather than a scan report." + EndOfLine + "Please try again later.", 16, "Unknown Error")
		  End Select
		  
		  self.Close
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		mode As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		redirect As String
	#tag EndProperty

	#tag Property, Flags = &h0
		retry As Boolean = False
	#tag EndProperty


	#tag ViewBehavior
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
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mode"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="redirect"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="retry"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
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
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InheritedFrom="TCPSocket"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
