#tag Module
Protected Module Errors
	#tag Method, Flags = &h1
		Protected Function Name(CURLCODE As Integer) As String
		  Select Case CURLCODE
		  Case OK
		    Return "CURLE_OK"
		  Case UNSUPPORTED_PROTOCOL
		    Return "CURLE_UNSUPPORTED_PROTOCOL"
		  Case FAILED_INIT
		    Return "CURLE_FAILED_INIT"
		  Case URL_MALFORMAT
		    Return "CURLE_URL_MALFORMAT"
		  Case NOT_BUILT_IN
		    Return "CURLE_NOT_BUILT_IN"
		  Case COULDNT_RESOLVE_PROXY
		    Return "CURLE_COULDNT_RESOLVE_PROXY"
		  Case COULDNT_RESOLVE_HOST
		    Return "CURLE_COULDNT_RESOLVE_HOST"
		  Case COULDNT_CONNECT
		    Return "CURLE_COULDNT_CONNECT"
		  Case FTP_WEIRD_SERVER_REPLY
		    Return "CURLE_FTP_WEIRD_SERVER_REPLY"
		  Case FTP_ACCESS_DENIED
		    Return "CURLE_FTP_ACCESS_DENIED"
		  Case FTP_ACCEPT_FAILED
		    Return "CURLE_FTP_ACCEPT_FAILED"
		  Case FTP_WEIRD_PASS_REPLY
		    Return "CURLE_FTP_WEIRD_PASS_REPLY"
		  Case FTP_ACCEPT_TIMEOUT
		    Return "CURLE_FTP_ACCEPT_TIMEOUT"
		  Case FTP_WEIRD_PASV_REPLY
		    Return "CURLE_FTP_WEIRD_PASV_REPLY"
		  Case FTP_WEIRD_227_FORMAT
		    Return "CURLE_FTP_WEIRD_227_FORMAT"
		  Case FTP_CANT_GET_HOST
		    Return "CURLE_FTP_CANT_GET_HOST"
		  Case HTTP2
		    Return "CURLE_HTTP2"
		  Case FTP_COULDNT_SET_BINARY
		    Return "CURLE_FTP_COULDNT_SET_BINARY"
		  Case PARTIAL_FILE
		    Return "CURLE_PARTIAL_FILE"
		  Case FTP_COULDNT_RETR_FILE
		    Return "CURLE_FTP_COULDNT_RETR_FILE"
		  Case FTP_WRITE_ERROR
		    Return "CURLE_FTP_WRITE_ERROR"
		  Case FTP_QUOTE_ERROR
		    Return "CURLE_FTP_QUOTE_ERROR"
		  Case HTTP_RETURNED_ERROR
		    Return "CURLE_HTTP_RETURNED_ERROR"
		  Case WRITE_ERROR
		    Return "CURLE_WRITE_ERROR"
		  Case MALFORMAT_USER
		    Return "CURLE_MALFORMAT_USER"
		  Case UPLOAD_FAILED
		    Return "CURLE_UPLOAD_FAILED"
		  Case READ_ERROR
		    Return "CURLE_READ_ERROR"
		  Case OUT_OF_MEMORY
		    Return "CURLE_OUT_OF_MEMORY"
		  Case OPERATION_TIMEDOUT
		    Return "CURLE_OPERATION_TIMEDOUT"
		  Case FTP_COULDNT_SET_ASCII
		    Return "CURLE_FTP_COULDNT_SET_ASCII"
		  Case FTP_PORT_FAILED
		    Return "CURLE_FTP_PORT_FAILED"
		  Case FTP_COULDNT_USE_REST
		    Return "CURLE_FTP_COULDNT_USE_REST"
		  Case FTP_COULDNT_GET_SIZE
		    Return "CURLE_FTP_COULDNT_GET_SIZE"
		  Case HTTP_RANGE_ERROR
		    Return "CURLE_HTTP_RANGE_ERROR"
		  Case HTTP_POST_ERROR
		    Return "CURLE_HTTP_POST_ERROR"
		  Case SSL_CONNECT_ERROR
		    Return "CURLE_SSL_CONNECT_ERROR"
		  Case BAD_DOWNLOAD_RESUME
		    Return "CURLE_BAD_DOWNLOAD_RESUME"
		  Case FILE_COULDNT_READ_FILE
		    Return "CURLE_FILE_COULDNT_READ_FILE"
		  Case LDAP_CANNOT_BIND
		    Return "CURLE_LDAP_CANNOT_BIND"
		  Case LDAP_SEARCH_FAILED
		    Return "CURLE_LDAP_SEARCH_FAILED"
		  Case LIBRARY_NOT_FOUND
		    Return "CURLE_LIBRARY_NOT_FOUND"
		  Case FUNCTION_NOT_FOUND
		    Return "CURLE_FUNCTION_NOT_FOUND"
		  Case ABORTED_BY_CALLBACK
		    Return "CURLE_ABORTED_BY_CALLBACK"
		  Case BAD_FUNCTION_ARGUMENT
		    Return "CURLE_BAD_FUNCTION_ARGUMENT"
		  Case BAD_CALLING_ORDER
		    Return "CURLE_BAD_CALLING_ORDER"
		  Case INTERFACE_FAILED
		    Return "CURLE_INTERFACE_FAILED"
		  Case BAD_PASSWORD_ENTERED
		    Return "CURLE_BAD_PASSWORD_ENTERED"
		  Case TOO_MANY_REDIRECTS
		    Return "CURLE_TOO_MANY_REDIRECTS"
		  Case UNKNOWN_OPTION
		    Return "CURLE_UNKNOWN_OPTION"
		  Case TELNET_OPTION_SYNTAX
		    Return "CURLE_TELNET_OPTION_SYNTAX"
		  Case OBSOLETE
		    Return "CURLE_OBSOLETE"
		  Case PEER_FAILED_VERIFICATION
		    Return "CURLE_PEER_FAILED_VERIFICATION"
		  Case GOT_NOTHING
		    Return "CURLE_GOT_NOTHING"
		  Case SSL_ENGINE_NOT_FOUND
		    Return "CURLE_SSL_ENGINE_NOT_FOUND"
		  Case SSL_ENGINE_SET_FAILED
		    Return "CURLE_SSL_ENGINE_SET_FAILED"
		  Case SEND_ERROR
		    Return "CURLE_SEND_ERROR"
		  Case RECV_ERROR
		    Return "CURLE_RECV_ERROR"
		  Case SHARE_IN_USE
		    Return "CURLE_SHARE_IN_USE"
		  Case SSL_CERTPROBLEM
		    Return "CURLE_SSL_CERTPROBLEM"
		  Case SSL_CIPHER
		    Return "CURLE_SSL_CIPHER"
		  Case SSL_CACERT
		    Return "CURLE_SSL_CACERT"
		  Case BAD_CONTENT_ENCODING
		    Return "CURLE_BAD_CONTENT_ENCODING"
		  Case LDAP_INVALID_URL
		    Return "CURLE_LDAP_INVALID_URL"
		  Case FILESIZE_EXCEEDED
		    Return "CURLE_FILESIZE_EXCEEDED"
		  Case FTP_SSL_FAILED
		    Return "CURLE_FTP_SSL_FAILED"
		  Case SEND_FAIL_REWIND
		    Return "CURLE_SEND_FAIL_REWIND"
		  Case SSL_ENGINE_INIT_FAILED
		    Return "CURLE_SSL_ENGINE_INIT_FAILED"
		  Case LOGIN_DENIED
		    Return "CURLE_LOGIN_DENIED"
		  Case TFTP_NOT_FOUND
		    Return "CURLE_TFTP_NOT_FOUND"
		  Case TFTP_PERM
		    Return "CURLE_TFTP_PERM"
		  Case TFTP_ILLEGAL
		    Return "CURLE_TFTP_ILLEGAL"
		  Case TFTP_UNKNOWN_ID
		    Return "CURLE_TFTP_UNKNOWNID"
		  Case REMOTE_FILE_EXISTS
		    Return "CURLE_REMOTE_FILE_EXISTS"
		  Case TFTP_NO_SUCH_USER
		    Return "CURLE_TFTP_NO_SUCH_USER"
		  Case CONV_FAILED
		    Return "CURLE_CONV_FAILED"
		  Case CONV_REQUIRED
		    Return "CURLE_CONV_REQUIRED"
		  Case SSL_CACERT_BAD_FILE
		    Return "CURLE_SSL_CACERT_BAD_FILE"
		  Case REMOTE_FILE_NOT_FOUND
		    Return "CURLE_REMOTE_FILE_NOT_FOUND"
		  Case SSH
		    Return "CURLE_SSH"
		  Case SSL_SHUTDOWN_FAILED
		    Return "CURLE_SSL_SHUTDOWN_FAILED"
		  Case AGAIN
		    Return "CURLE_AGAIN"
		  Case SSL_CRL_BAD_FILE
		    Return "CURLE_SSL_CRL_BADFILE"
		  Case SSL_ISSUER_ERROR
		    Return "CURLE_SSL_ISSUER_ERROR"
		  Case FTP_PRET_FAILED
		    Return "CURLE_FTP_PRET_FAILED"
		  Case RTSP_CSEQ_ERROR
		    Return "CURLE_RTSP_CSEQ_ERROR"
		  Case RTSP_SESSION_ERROR
		    Return "CURLE_RTSP_SESSION_ERROR"
		  Case FTP_BAD_FILE_LIST
		    Return "CURLE_FTP_BAD_FILE_LIST"
		  Case CHUNK_FAILED
		    Return "CURLE_CHUNK_FAILED"
		  Case NO_CONNECTION_AVAILABLE
		    Return "CURLE_NO_CONNECTION_AVAILABLE"
		  Case SSL_PINNEDPUBKEYNOTMATCH
		    Return "CURLE_SSL_PINNEDPUBKEYNOTMATCH"
		  Case Is < -2
		    Dim s As String = WrapperErrorName(CURLCODE)
		    If s <> "" Then Return s
		  End Select
		  Return "UNKNOWN_CURL_CODE"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function WrapperErrorName(CURLCODE As Integer) As String
		  Select Case CURLCODE
		  Case INIT_FAILED
		    Return "INIT_FAILED"
		    
		  Case FEATURE_UNAVAILABLE
		    Return "FEATURE_UNAVAILABLE"
		    
		  Case NOT_INITIALIZED
		    Return "NOT_INITIALIZED"
		    
		  Case CALL_LOOP_DETECTED
		    Return "CALL_LOOP_DETECTED"
		    
		  Case NO_COOKIEJAR ' deprecated
		    Return "NO_COOKIEJAR"
		    
		  Case INVALID_LOCAL_FILE
		    Return "INVALID_LOCAL_FILE"
		    
		  Case INVALID_STATE
		    Return "INVALID_STATE"
		    
		  Case MIME_ADD_FAILED
		    Return "MIME_ADD_FAILED"
		    
		  Case MIME_OWNER_MISSING
		    Return "MIME_OWNER_MISSING"
		    
		  Case MIME_MANUAL_ONLY
		    Return "MIME_MANUAL_ONLY"
		    
		  Case HEADER_INDEX_OUT_OF_BOUNDS
		    Return "HEADER_INDEX_OUT_OF_BOUNDS"
		    
		  Case REQUEST_INDEX_OUT_OF_BOUNDS
		    Return "REQUEST_INDEX_OUT_OF_BOUNDS"
		    
		  End Select
		End Function
	#tag EndMethod


	#tag Constant, Name = ABORTED_BY_CALLBACK, Type = Double, Dynamic = False, Default = \"42", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AGAIN, Type = Double, Dynamic = False, Default = \"81", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BAD_CALLING_ORDER, Type = Double, Dynamic = False, Default = \"44", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BAD_CONTENT_ENCODING, Type = Double, Dynamic = False, Default = \"61", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BAD_DOWNLOAD_RESUME, Type = Double, Dynamic = False, Default = \"36", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BAD_FUNCTION_ARGUMENT, Type = Double, Dynamic = False, Default = \"43", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BAD_PASSWORD_ENTERED, Type = Double, Dynamic = False, Default = \"46", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALL_LOOP_DETECTED, Type = Double, Dynamic = False, Default = \"-6", Scope = Protected
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

	#tag Constant, Name = FTP_ACCEPT_FAILED, Type = Double, Dynamic = False, Default = \"10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_ACCEPT_TIMEOUT, Type = Double, Dynamic = False, Default = \"12", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_ACCESS_DENIED, Type = Double, Dynamic = False, Default = \"9", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_BAD_FILE_LIST, Type = Double, Dynamic = False, Default = \"87", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_CANT_GET_HOST, Type = Double, Dynamic = False, Default = \"15", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_COULDNT_GET_SIZE, Type = Double, Dynamic = False, Default = \"32", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_COULDNT_RETR_FILE, Type = Double, Dynamic = False, Default = \"19", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_COULDNT_SET_ASCII, Type = Double, Dynamic = False, Default = \"29", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_COULDNT_SET_BINARY, Type = Double, Dynamic = False, Default = \"17", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_COULDNT_USE_REST, Type = Double, Dynamic = False, Default = \"31", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_COULDN_SET_TYPE, Type = Double, Dynamic = False, Default = \"17", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_PORT_FAILED, Type = Double, Dynamic = False, Default = \"30", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_PRET_FAILED, Type = Double, Dynamic = False, Default = \"84", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_QUOTE_ERROR, Type = Double, Dynamic = False, Default = \"21", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_SSL_FAILED, Type = Double, Dynamic = False, Default = \"64", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_WEIRD_227_FORMAT, Type = Double, Dynamic = False, Default = \"14", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_WEIRD_PASS_REPLY, Type = Double, Dynamic = False, Default = \"11", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_WEIRD_PASV_REPLY, Type = Double, Dynamic = False, Default = \"13", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_WEIRD_SERVER_REPLY, Type = Double, Dynamic = False, Default = \"8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_WRITE_ERROR, Type = Double, Dynamic = False, Default = \"20", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FUNCTION_NOT_FOUND, Type = Double, Dynamic = False, Default = \"41", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GOT_NOTHING, Type = Double, Dynamic = False, Default = \"52", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HEADER_INDEX_OUT_OF_BOUNDS, Type = Double, Dynamic = False, Default = \"-13", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTP2, Type = Double, Dynamic = False, Default = \"16", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTP_POST_ERROR, Type = Double, Dynamic = False, Default = \"34", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTP_RANGE_ERROR, Type = Double, Dynamic = False, Default = \"33", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTP_RETURNED_ERROR, Type = Double, Dynamic = False, Default = \"22", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INIT_FAILED, Type = Double, Dynamic = False, Default = \"-3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INTERFACE_FAILED, Type = Double, Dynamic = False, Default = \"45", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INVALID_LOCAL_FILE, Type = Double, Dynamic = False, Default = \"-8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INVALID_STATE, Type = Double, Dynamic = False, Default = \"-9", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LDAP_CANNOT_BIND, Type = Double, Dynamic = False, Default = \"38", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LDAP_INVALID_URL, Type = Double, Dynamic = False, Default = \"62", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LDAP_SEARCH_FAILED, Type = Double, Dynamic = False, Default = \"39", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LIBRARY_NOT_FOUND, Type = Double, Dynamic = False, Default = \"40", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LOGIN_DENIED, Type = Double, Dynamic = False, Default = \"67", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MALFORMAT_USER, Type = Double, Dynamic = False, Default = \"24", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MIME_ADD_FAILED, Type = Double, Dynamic = False, Default = \"-10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MIME_MANUAL_ONLY, Type = Double, Dynamic = False, Default = \"-12", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MIME_OWNER_MISSING, Type = Double, Dynamic = False, Default = \"-11", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NOT_BUILT_IN, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NOT_INITIALIZED, Type = Double, Dynamic = False, Default = \"-5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NO_CONNECTION_AVAILABLE, Type = Double, Dynamic = False, Default = \"89", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NO_COOKIEJAR, Type = Double, Dynamic = False, Default = \"-7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NO_TARGET, Type = Double, Dynamic = False, Default = \"-2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OBSOLETE, Type = Double, Dynamic = False, Default = \"50", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OK, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OPERATION_TIMEDOUT, Type = Double, Dynamic = False, Default = \"28", Scope = Protected
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

	#tag Constant, Name = READ_ERROR, Type = Double, Dynamic = False, Default = \"26", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RECV_ERROR, Type = Double, Dynamic = False, Default = \"56", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REMOTE_ACCESS_DENIED, Type = Double, Dynamic = False, Default = \"9", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REMOTE_DISK_FULL, Type = Double, Dynamic = False, Default = \"70", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REMOTE_FILE_EXISTS, Type = Double, Dynamic = False, Default = \"73", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REMOTE_FILE_NOT_FOUND, Type = Double, Dynamic = False, Default = \"78", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REQUEST_INDEX_OUT_OF_BOUNDS, Type = Double, Dynamic = False, Default = \"-14", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RTSP_CSEQ_ERROR, Type = Double, Dynamic = False, Default = \"85", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RTSP_SESSION_ERROR, Type = Double, Dynamic = False, Default = \"86", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SEND_ERROR, Type = Double, Dynamic = False, Default = \"55", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SEND_FAIL_REWIND, Type = Double, Dynamic = False, Default = \"65", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SETOPT_OPTION_SYNTAX, Type = Double, Dynamic = False, Default = \"49", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SHARE_IN_USE, Type = Double, Dynamic = False, Default = \"57", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSH, Type = Double, Dynamic = False, Default = \"79", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CACERT, Type = Double, Dynamic = False, Default = \"60", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CACERT_BAD_FILE, Type = Double, Dynamic = False, Default = \"77", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CERTPROBLEM, Type = Double, Dynamic = False, Default = \"58", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CIPHER, Type = Double, Dynamic = False, Default = \"59", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CONNECT_ERROR, Type = Double, Dynamic = False, Default = \"35", Scope = Protected
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

	#tag Constant, Name = SSL_PINNEDPUBKEYNOTMATCH, Type = Double, Dynamic = False, Default = \"90", Scope = Protected
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

	#tag Constant, Name = WRITE_ERROR, Type = Double, Dynamic = False, Default = \"23", Scope = Protected
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
