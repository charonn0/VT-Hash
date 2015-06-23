#tag Module
Protected Module Errors
	#tag Method, Flags = &h1
		Protected Function Name(CURLCODE As Integer) As String
		  Static names() As String = Array("CURLE_OK", "CURLE_UNSUPPORTED_PROTOCOL", "CURLE_FAILED_INIT", "CURLE_URL_MALFORMAT", _
		  "CURLE_NOT_BUILT_IN", "CURLE_COULDNT_RESOLVE_PROXY", "CURLE_COULDNT_RESOLVE_HOST", "CURLE_COULDNT_CONNECT", _
		  "CURLE_FTP_WEIRD_SERVER_REPLY", "CURLE_FTP_ACCESS_DENIED", "CURLE_FTP_USER_PASSWORD_INCORRECT", "CURLE_FTP_WEIRD_PASS_REPLY", _
		  "CURLE_FTP_ACCEPT_TIMEOUT", "CURLE_FTP_WEIRD_PASV_REPLY", "CURLE_FTP_WEIRD_227_FORMAT", "CURLE_FTP_CANT_GET_HOST", _
		  "CURLE_FTP_CANT_RECONNECT", "CURLE_FTP_COULDNT_SET_BINARY", "CURLE_PARTIAL_FILE", "CURLE_FTP_COULDNT_RETR_FILE", "CURLE_FTP_WRITE_ERROR", _
		  "CURLE_FTP_QUOTE_ERROR", "CURLE_HTTP_RETURNED_ERROR", "CURLE_WRITE_ERROR", "CURLE_MALFORMAT_USER", "CURLE_UPLOAD_FAILED", "CURLE_READ_ERROR", _
		  "CURLE_OUT_OF_MEMORY", "CURLE_OPERATION_TIMEDOUT", "CURLE_FTP_COULDNT_SET_ASCII", "CURLE_FTP_PORT_FAILED", "CURLE_FTP_COULDNT_USE_REST", _
		  "CURLE_FTP_COULDNT_GET_SIZE", "CURLE_HTTP_RANGE_ERROR", "CURLE_HTTP_POST_ERROR", "CURLE_SSL_CONNECT_ERROR", "CURLE_BAD_DOWNLOAD_RESUME", _
		  "CURLE_FILE_COULDNT_READ_FILE", "CURLE_LDAP_CANNOT_BIND", "CURLE_LDAP_SEARCH_FAILED", "CURLE_LIBRARY_NOT_FOUND", "CURLE_FUNCTION_NOT_FOUND", _
		  "CURLE_ABORTED_BY_CALLBACK", "CURLE_BAD_FUNCTION_ARGUMENT", "CURLE_BAD_CALLING_ORDER", "CURLE_INTERFACE_FAILED", "CURLE_BAD_PASSWORD_ENTERED", _
		  "CURLE_TOO_MANY_REDIRECTS ", "CURLE_UNKNOWN_OPTION", "CURLE_TELNET_OPTION_SYNTAX ", "CURLE_OBSOLETE", "CURLE_SSL_PEER_CERTIFICATE", _
		  "CURLE_GOT_NOTHING", "CURLE_SSL_ENGINE_NOTFOUND", "CURLE_SSL_ENGINE_SETFAILED", "CURLE_SEND_ERROR", "CURLE_RECV_ERROR", "CURLE_SHARE_IN_USE", _
		  "CURLE_SSL_CERTPROBLEM", "CURLE_SSL_CIPHER", "CURLE_SSL_CACERT", "CURLE_BAD_CONTENT_ENCODING", "CURLE_LDAP_INVALID_URL", "CURLE_FILESIZE_EXCEEDED", _
		  "CURLE_FTP_SSL_FAILED", "CURLE_SEND_FAIL_REWIND", "CURLE_SSL_ENGINE_INITFAILED", "CURLE_LOGIN_DENIED", "CURLE_TFTP_NOTFOUND", "CURLE_TFTP_PERM", _
		  "CURLE_TFTP_DISKFULL", "CURLE_TFTP_ILLEGAL", "CURLE_TFTP_UNKNOWNID", "CURLE_TFTP_EXISTS", "CURLE_TFTP_NOSUCHUSER", "CURLE_CONV_FAILED", _
		  "CURLE_CONV_REQD", "CURLE_SSL_CACERT_BADFILE", "CURLE_REMOTE_FILE_NOT_FOUND", "CURLE_SSH", "CURLE_SSL_SHUTDOWN_FAILED", "CURL_LAST", _
		  "CURLE_SSL_CRL_BADFILE", "CURLE_SSL_ISSUER_ERROR", "CURLE_FTP_PRET_FAILED", "CURLE_RTSP_CSEQ_ERROR", "CURLE_RTSP_SESSION_ERROR", _
		  "CURLE_FTP_BAD_FILE_LIST", "CURLE_CHUNK_FAILED", "CURLE_NO_CONNECTION_AVAILABLE")
		  Static bound As Integer = UBound(names)
		  If CURLCODE <= bound And CURLCODE > -1 Then
		    Return names(CURLCODE)
		  Else
		    Return "UNKNOWN_CURL_CODE"
		  End If
		End Function
	#tag EndMethod


	#tag Constant, Name = ABORTED_BY_CALLBACK, Type = Double, Dynamic = False, Default = \"42", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AGAIN, Type = Double, Dynamic = False, Default = \"81", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BAD_CONTENT_ENCODING, Type = Double, Dynamic = False, Default = \"61", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BAD_DOWNLOAD_RESUME, Type = Double, Dynamic = False, Default = \"36", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BAD_FUNCTION_ARGUMENT, Type = Double, Dynamic = False, Default = \"43", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CHUNK_FAILED, Type = Double, Dynamic = False, Default = \"88", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CONV_FAILED, Type = Double, Dynamic = False, Default = \"75", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CONV_REQUIRED, Type = Double, Dynamic = False, Default = \"76", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = COULDNT_CONNECT, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = COULDNT_RESOLVE_HOST, Type = Double, Dynamic = False, Default = \"6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = COULDNT_RESOLVE_PROXY, Type = Double, Dynamic = False, Default = \"5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FAILED_INIT, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FEATURE_UNAVAILABLE, Type = Double, Dynamic = False, Default = \"-4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILESIZE_EXCEEDED, Type = Double, Dynamic = False, Default = \"63", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_COULDNT_READ_FILE, Type = Double, Dynamic = False, Default = \"37", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_BAD_FILE_LIST, Type = Double, Dynamic = False, Default = \"87", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_CANT_GET_HOST, Type = Double, Dynamic = False, Default = \"15", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_COULDNT_RETR_FILE, Type = Double, Dynamic = False, Default = \"19", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_COULDNT_USE_REST, Type = Double, Dynamic = False, Default = \"31", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_COULDN_SET_TYPE, Type = Double, Dynamic = False, Default = \"17", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_PORT_FAILED, Type = Double, Dynamic = False, Default = \"30", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_PRET_FAILED, Type = Double, Dynamic = False, Default = \"84", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_WEIRD_227_FORMAT, Type = Double, Dynamic = False, Default = \"14", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_WEIRD_PASS_REPLY, Type = Double, Dynamic = False, Default = \"11", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_WEIRD_PASV_REPLY, Type = Double, Dynamic = False, Default = \"13", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_WEIRD_SERVER_REPLY, Type = Double, Dynamic = False, Default = \"8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FUNCTION_NOT_FOUND, Type = Double, Dynamic = False, Default = \"41", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GOT_NOTHING, Type = Double, Dynamic = False, Default = \"52", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTP_POST, Type = Double, Dynamic = False, Default = \"34", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTP_RETURNED_ERROR, Type = Double, Dynamic = False, Default = \"22", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INIT_FAILED, Type = Double, Dynamic = False, Default = \"-3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INTERFACE_FAILED, Type = Double, Dynamic = False, Default = \"45", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LDAP_CANNOT_BIND, Type = Double, Dynamic = False, Default = \"38", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LDAP_INVALID_URL, Type = Double, Dynamic = False, Default = \"62", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LDAP_SEARCH_FAILED, Type = Double, Dynamic = False, Default = \"39", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LOGIN_DENIED, Type = Double, Dynamic = False, Default = \"67", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NOT_BUILT_IN, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NO_TARGET, Type = Double, Dynamic = False, Default = \"-2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OK, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OUT_OF_MEMORY, Type = Double, Dynamic = False, Default = \"27", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PARTIAL_FILE, Type = Double, Dynamic = False, Default = \"18", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PEER_FAILED_VERIFICATION, Type = Double, Dynamic = False, Default = \"51", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QUOTE, Type = Double, Dynamic = False, Default = \"21", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RANGE, Type = Double, Dynamic = False, Default = \"33", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = READ, Type = Double, Dynamic = False, Default = \"26", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RECV, Type = Double, Dynamic = False, Default = \"56", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REMOTE_ACCESS_DENIED, Type = Double, Dynamic = False, Default = \"9", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REMOTE_DISK_FULL, Type = Double, Dynamic = False, Default = \"70", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REMOTE_FILE_EXISTS, Type = Double, Dynamic = False, Default = \"73", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REMOTE_FILE_NOT_FOUND, Type = Double, Dynamic = False, Default = \"78", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RTSP_CSEQ_ERROR, Type = Double, Dynamic = False, Default = \"85", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RTSP_SESSION, Type = Double, Dynamic = False, Default = \"86", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SEND, Type = Double, Dynamic = False, Default = \"55", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SEND_FAIL_REWIND, Type = Double, Dynamic = False, Default = \"65", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSH, Type = Double, Dynamic = False, Default = \"79", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CACERT_BAD_FILE, Type = Double, Dynamic = False, Default = \"77", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CA_CERT, Type = Double, Dynamic = False, Default = \"60", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CERT_PROBLEM, Type = Double, Dynamic = False, Default = \"58", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CIPHER, Type = Double, Dynamic = False, Default = \"59", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CONNECT, Type = Double, Dynamic = False, Default = \"35", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CRL_BAD_FILE, Type = Double, Dynamic = False, Default = \"82", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_ENGINE_INIT_FAILED, Type = Double, Dynamic = False, Default = \"66", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_ENGINE_NOT_FOUND, Type = Double, Dynamic = False, Default = \"53", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_ENGINE_SET_FAILED, Type = Double, Dynamic = False, Default = \"54", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_ISSUER_ERROR, Type = Double, Dynamic = False, Default = \"83", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_SHUTDOWN_FAILED, Type = Double, Dynamic = False, Default = \"80", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TELNET_OPTION_SYNTAX, Type = Double, Dynamic = False, Default = \"49", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TFTP_ILLEGAL, Type = Double, Dynamic = False, Default = \"71", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TFTP_NOT_FOUND, Type = Double, Dynamic = False, Default = \"68", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TFTP_NO_SUCH_USER, Type = Double, Dynamic = False, Default = \"74", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TFTP_PERM, Type = Double, Dynamic = False, Default = \"69", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TFTP_UNKNOWN_ID, Type = Double, Dynamic = False, Default = \"72", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TIMEOUT, Type = Double, Dynamic = False, Default = \"28", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TOO_MANY_REDIRECTS, Type = Double, Dynamic = False, Default = \"47", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UNKNOWN_OPTION, Type = Double, Dynamic = False, Default = \"48", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UNSUPPORTED_PROTOCOL, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UPLOAD_FAILED, Type = Double, Dynamic = False, Default = \"25", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = URL_MALFORMAT, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = USE_SSL_FAILED, Type = Double, Dynamic = False, Default = \"64", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WRITE, Type = Double, Dynamic = False, Default = \"23", Scope = Protected
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
