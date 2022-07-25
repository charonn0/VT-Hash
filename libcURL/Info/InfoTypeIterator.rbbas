#tag Class
Protected Class InfoTypeIterator
	#tag Method, Flags = &h0
		Sub Constructor()
		  ' Enumerate all known info types.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoTypeIterator.Constructor
		  
		  If UBound(AllTypes) = -1 Then
		    Dim all() As Integer = Array( _
		    ACTIVESOCKET, APPCONNECT_TIME, APPCONNECT_TIME_T, CERTINFO, CONDITION_UNMET, CONNECT_TIME, _
		    CONNECT_TIME_T, CONTENT_LENGTH_DOWNLOAD, CONTENT_LENGTH_DOWNLOAD_T, CONTENT_LENGTH_UPLOAD, _
		    CONTENT_LENGTH_UPLOAD_T, CONTENT_TYPE, COOKIELIST, EFFECTIVE_METHOD, EFFECTIVE_URL, FILETIME, _
		    FILETIME_T, FTP_ENTRY_PATH, HEADER_SIZE,  HTTPAUTH_AVAIL, HTTP_CONNECTCODE, HTTP_VERSION, _
		    LASTSOCKET, LOCAL_IP, LOCAL_PORT, NAMELOOKUP_TIME, NAMELOOKUP_TIME_T, NUM_CONNECTS, OS_ERRNO, _
		    PRETRANSFER_TIME, PRETRANSFER_TIME_T, PRIMARY_IP, PRIMARY_PORT, PRIVATE_, PROTOCOL, PROXYAUTH_AVAIL, _
		    PROXY_ERROR, PROXY_SSL_VERIFYRESULT, REDIRECT_COUNT, REDIRECT_TIME, REDIRECT_TIME_T, REDIRECT_URL, _
		    REFERER, REQUEST_SIZE, RESPONSE_CODE, RETRY_AFTER, RTSP_CLIENT_CSEQ, RTSP_CSEQ_RECV, RTSP_SERVER_CSEQ, _
		    RTSP_SESSION_ID, SCHEME, SIZE_DOWNLOAD, SIZE_DOWNLOAD_T, SIZE_UPLOAD, SIZE_UPLOAD_T, SPEED_DOWNLOAD, _
		    SPEED_DOWNLOAD_T, SPEED_UPLOAD, SPEED_UPLOAD_T, SSL_ENGINES, SSL_VERIFYRESULT, STARTTRANSFER_TIME,  _
		    STARTTRANSFER_TIME_T, TLS_SESSION, TLS_SSL_PTR, TOTAL_TIME, TOTAL_TIME_T)
		    For i As Integer = 0 To UBound(all)
		      AllTypes.Append(all(i))
		    Next
		  End If
		  
		  mIndex = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  ' Returns the total number of info types known.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoTypeIterator.Count
		  
		  Return UBound(AllTypes) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  ' Advances the iterator to the next info type in the list. Returns True
		  ' until there are no further types.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoTypeIterator.MoveNext
		  
		  If mIndex < UBound(AllTypes) Then
		    mIndex = mIndex + 1
		    Return True
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared AllTypes() As libcURL.Info.InfoType
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The index of the current infotype in the list.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoTypeIterator.CurrentIndex
			  
			  Return mIndex
			End Get
		#tag EndGetter
		CurrentIndex As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The current InfoType object in the list.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoTypeIterator.CurrentInfoType
			  
			  Return AllTypes(mIndex)
			End Get
		#tag EndGetter
		CurrentInfoType As libcURL.Info.InfoType
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mIndex As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="CurrentIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
