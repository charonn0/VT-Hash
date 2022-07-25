#tag Class
Protected Class OptionIterator
	#tag Method, Flags = &h0
		Sub Constructor()
		  ' Enumerate all known options.
		  
		  If Not System.IsFunctionAvailable("curl_easy_option_next", cURLLib) Then
		    mDataStore = FakeDataStore
		    
		  Else
		    mPrev = curl_easy_option_next(Nil)
		    If mPrev = Nil Then
		      Dim err As New cURLException(Nil)
		      err.ErrorNumber = libcURL.Errors.INIT_FAILED
		      err.Message = libcURL.FormatError(err.ErrorNumber)
		      Raise err
		    End If
		    
		  End If
		  mIndex = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Session As libcURL.EasyHandle)
		  ' Enumerate the options that have been set on a specific instance of EasyHandle
		  
		  Const SECRET_INTERNAL_FLAG = &hFEF1F0F9
		  mDataStore = Session.GetOption(SECRET_INTERNAL_FLAG, Session)
		  mIndex = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  ' Returns the total number of options being enumerated
		  
		  If mDataStore <> Nil Then
		    Return mDataStore.Count
		  Else
		    If mPrev = Nil Then Return 0
		    Dim lastp As Ptr = mPrev
		    Dim lasti As Integer = mIndex
		    Do Until Not Me.MoveNext()
		    Loop
		    Dim c As Integer = mIndex + 1
		    mIndex = lasti
		    mPrev = lastp
		    Return c
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MoveNext() As Boolean
		  ' Advances the iterator to the next option in the list. Returns True until there are no further options.
		  
		  If mDataStore = Nil Then
		    mPrev = curl_easy_option_next(mPrev)
		    If mPrev = Nil Then Return False
		    
		  Else
		    If mIndex >= mDataStore.Count - 1 Then Return False
		    
		  End If
		  
		  mIndex = mIndex + 1
		  Return True
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mIndex
			End Get
		#tag EndGetter
		CurrentIndex As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mDataStore <> Nil Then
			    Dim optnum As Integer = mDataStore.Key(mIndex)
			    Return optnum
			  ElseIf mPrev <> Nil Then
			    Dim opt As curl_easyoption = mPrev.curl_easyoption
			    Return New OptionInfoCreator(opt)
			  End If
			End Get
		#tag EndGetter
		CurrentOption As libcURL.Opts.OptionInfo
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Static store As Dictionary
			  If store = Nil Then store = New Dictionary(ABSTRACT_UNIX_SOCKET:Nil, ACCEPTTIMEOUT_MS:60000, ACCEPT_ENCODING:Nil, ADDRESS_SCOPE:0, _
			  ALTSVC:Nil, ALTSVC_CTRL:0, APPEND:False, AUTOREFERER:False, AWS_SIGV4:Nil, BUFFERSIZE:2097152, CAINFO:Nil, CAPATH:Nil, CAINFO_BLOB:Nil, _
			  CERTINFO:0,CHUNK_BGN_FUNCTION:Nil, CHUNK_DATA:Nil, CHUNK_END_FUNCTION:Nil, CLOSESOCKETDATA:Nil, CLOSESOCKETFUNCTION:Nil, CONNECTTIMEOUT:300, _
			  CONNECTTIMEOUT_MS:300000, CONNECT_ONLY:False, CONNECT_TO:Nil, CONV_FROM_NETWORK_FUNCTION:Nil, CONV_FROM_UTF8_FUNCTION:Nil, _
			  CONV_TO_NETWORK_FUNCTION:Nil, COOKIE:Nil, COOKIEFILE:Nil, COOKIEJAR:Nil, COOKIELIST:Nil, COOKIESESSION:False, COPYPOSTFIELDS:Nil, _
			  CRLF:0, CRLFILE:Nil, CURLU:Nil, CUSTOMREQUEST:Nil, DEBUGDATA:Nil, DEBUGFUNCTION:Nil, DEFAULT_PROTOCOL:Nil, DIRLISTONLY:False, _
			  DISALLOW_USERNAME_IN_URL:False, DNS_CACHE_TIMEOUT:60, DNS_INTERFACE:Nil, DNS_LOCAL_IP4:Nil, DNS_LOCAL_IP6:Nil, DNS_SERVERS:Nil, _
			  DNS_SHUFFLE_ADDRESSES:False, DNS_USE_GLOBAL_CACHE:False, DOH_URL:Nil, EGDSOCKET:Nil, ERRORBUFFER:Nil, EXPECT_100_TIMEOUT_MS:1000, _
			  FAILONERROR:False, FILETIME:False, FNMATCH_DATA:Nil, FNMATCH_FUNCTION:Nil, FOLLOWLOCATION:False, FORBID_REUSE:False, _
			  FRESH_CONNECT:False, FTPPORT:Nil, FTPSSLAUTH:0, FTP_ACCOUNT:Nil, FTP_ALTERNATIVE_TO_USER:Nil, FTP_CREATE_MISSING_DIRS:False, _
			  FTP_FILEMETHOD:1, FTP_RESPONSE_TIMEOUT:0, FTP_SKIP_PASV_IP:False, FTP_SSL_CCC:0, FTP_USE_EPRT:False, FTP_USE_EPSV:True, _
			  FTP_USE_PRET:False, GSSAPI_DELEGATION:0, HAPPY_EYEBALLS_TIMEOUT_MS:200, HAPROXYPROTOCOL:False, HEADER:False, HEADERDATA:Nil, _
			  HEADERFUNCTION:Nil, HEADEROPT:0, HTTP09_ALLOWED:False, HTTP200ALIASES:Nil, HTTPAUTH:1, HTTPGET:False, HTTPHEADER:Nil, HTTPPOST:Nil, _
			  HTTPPROXYTUNNEL:False, HTTP_CONTENT_DECODING:True, HTTP_TRANSFER_DECODING:True, HTTP_VERSION:2, IGNORE_CONTENT_LENGTH:False, _
			  INFILESIZE:0, INFILESIZE_LARGE:0, NETINTERFACE:Nil, INTERLEAVEDATA:Nil, INTERLEAVEFUNCTION:Nil, IOCTLDATA:Nil, IOCTLFUNCTION:Nil, _
			  IPRESOLVE:0, ISSUERCERT:Nil, ISSUERCERT_BLOB:Nil, KEEP_SENDING_ON_ERROR:False, KEYPASSWD:Nil, KRBLEVEL:Nil, LOCALPORT:0, _
			  LOCALPORTRANGE:1, LOGIN_OPTIONS:Nil, LOW_SPEED_LIMIT:0, LOW_SPEED_TIME:0, MAIL_AUTH:Nil, MAIL_FROM:Nil, MAIL_RCPT:Nil, _
			  MAIL_RCPT_ALLLOWFAILS:False, MAXAGE_CONN:118, MAXCONNECTS:5, MAXFILESIZE:0, MAXFILESIZE_LARGE:0, MAXREDIRS:-1, _
			  MAX_RECV_SPEED_LARGE:0, MAX_SEND_SPEED_LARGE:0, MIME_OPTIONS:0, MIMEPOST:Nil, NETRC:0, NETRC_FILE:Nil, NEW_DIRECTORY_PERMS:493, _
			  NEW_FILE_PERMS:420, NOBODY:False, NOPROGRESS:True, NOPROXY:Nil, NOSIGNAL:False, OPENSOCKETDATA:Nil, OPENSOCKETFUNCTION:Nil, _
			  PASSWORD:Nil, PATH_AS_IS:False, PINNEDPUBLICKEY:Nil, PIPEWAIT:False, PORT:0, POST:False, POSTFIELDS:Nil, POSTFIELDSIZE:-1, _
			  POSTFIELDSIZE_LARGE:-1, POSTQUOTE:Nil, POSTREDIR:0, PREREQDATA:Nil, PREREQFUNCTION:Nil, PREQUOTE:Nil, PRE_PROXY:Nil, PRIVATE_:Nil, _
			  PROGRESSDATA:Nil, PROGRESSFUNCTION:Nil, PROTOCOLS:0, PROXY:Nil, PROXYAUTH:1, PROXYHEADER:Nil, PROXYPASSWORD:Nil, PROXYPORT:0, _
			  PROXYTYPE:0, PROXYUSERNAME:Nil, PROXYUSERPWD:Nil, PROXY_CAINFO:Nil, PROXY_CAPATH:Nil, PROXY_CRLFILE:Nil, PROXY_ISSUERCERT:Nil, _
			  PROXY_ISSUERCERT_BLOB:Nil, PROXY_KEYPASSWD:Nil, PROXY_PINNEDPUBLICKEY:Nil, PROXY_SERVICE_NAME:Nil, PROXY_SSLCERT:Nil, _
			  PROXY_SSLCERTTYPE:"PEM", PROXY_SSLCERT_BLOB:Nil, PROXY_SSLKEY:Nil, PROXY_SSLKEYTYPE:Nil, PROXY_SSLKEY_BLOB:Nil, PROXY_SSLVERSION:0, _
			  PROXY_SSL_CIPHER_LIST:Nil, PROXY_SSL_OPTIONS:0, PROXY_SSL_VERIFYHOST:2, PROXY_SSL_VERIFYPEER:1, PROXY_TLS13_CIPHERS:Nil, _
			  PROXY_TLSAUTH_PASSWORD:Nil, PROXY_TLSAUTH_TYPE:Nil, PROXY_TLSAUTH_USERNAME:Nil, PROXY_TRANSFER_MODE:False, PUT:False, QUOTE:Nil, _
			  RANDOM_FILE:Nil, RANGE:Nil, READDATA:Nil, READFUNCTION:Nil, REDIR_PROTOCOLS:15, REFERER:Nil, REQUEST_TARGET:Nil, RESOLVE:Nil, _
			  RESOLVER_START_DATA:Nil, RESOLVER_START_FUNCTION:Nil, RESUME_FROM:0, RESUME_FROM_LARGE:0, RTSP_CLIENT_CSEQ:0, RTSP_REQUEST:0, _
			  RTSP_SERVER_CSEQ:0, RTSP_SESSION_ID:Nil, RTSP_STREAM_URI:"'*'", RTSP_TRANSPORT:Nil, SASL_AUTHZID:Nil, SASL_IR:False, SEEKDATA:Nil, _
			  SEEKFUNCTION:Nil, SERVICE_NAME:Nil, SHARE:Nil, SOCKOPTDATA:Nil, SOCKOPTFUNCTION:Nil, SOCKS5_AUTH:1, SOCKS5_GSSAPI_NEC:False, _
			  SOCKS5_GSSAPI_SERVICE:Nil, SSH_AUTH_TYPES:0, SSH_COMPRESSION:False, SSH_HOST_PUBLIC_KEY_MD5:Nil, SSH_KEYDATA:Nil, SSH_KEYFUNCTION:Nil, _
			  SSH_KNOWNHOSTS:Nil, SSH_PRIVATE_KEYFILE:Nil, SSH_PUBLIC_KEYFILE:Nil, SSLCERT:Nil, SSLCERTTYPE:"PEM", SSLCERT_BLOB:Nil, SSLENGINE:Nil, _
			  SSLENGINE_DEFAULT:False, SSLKEY:Nil, SSLKEYTYPE:"PEM", SSLKEY_BLOB:Nil, SSLVERSION:0, SSL_CIPHER_LIST:Nil, SSL_CTX_DATA:Nil, _
			  SSL_CTX_FUNCTION:Nil, SSL_EC_CURVES:"", SSL_ENABLE_ALPN:True, SSL_ENABLE_NPN:True, SSL_FALSESTART:False, SSL_OPTIONS:0, _
			  SSL_SESSIONID_CACHE:True, SSL_VERIFYHOST:2, SSL_VERIFYPEER:True, SSL_VERIFYSTATUS:False, STDERR:Nil, STREAM_DEPENDS:Nil, _
			  STREAM_DEPENDS_E:Nil, STREAM_WEIGHT:16, SUPPRESS_CONNECT_HEADERS:False, TCP_FASTOPEN:False, TCP_KEEPALIVE:False, TCP_KEEPIDLE:60, _
			  TCP_KEEPINTVL:60, TCP_NODELAY:True, TELNETOPTIONS:Nil, TFTP_BLKSIZE:512, TFTP_NO_OPTIONS:False, TIMECONDITION:0, TIMEOUT:0, _
			  TIMEOUT_MS:0, TIMEVALUE:0, TIMEVALUE_LARGE:0, TLS13_CIPHERS:Nil, TLSAUTH_PASSWORD:Nil, TLSAUTH_TYPE:Nil, TLSAUTH_USERNAME:Nil, _
			  TRAILERDATA:Nil, TRAILERFUNCTION:Nil, TRANSFERTEXT:0, TRANSFER_ENCODING:False, UNIX_SOCKET_PATH:0, UNRESTRICTED_AUTH:False, _
			  UPKEEP_INTERVAL_MS:60000, UPLOAD:False, UPLOAD_BUFFERSIZE:65535, URL:Nil, USERAGENT:Nil, USERNAME:Nil, USERPWD:Nil, USE_SSL:0, _
			  VERBOSE:False, WILDCARDMATCH:False, WRITEDATA:Nil, WRITEFUNCTION:Nil, XFERINFODATA:Nil, XFERINFOFUNCTION:Nil, XOAUTH2_BEARER:Nil)
			  
			  Return store
			End Get
		#tag EndGetter
		Private Shared FakeDataStore As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  ' internal use. Returns True if the binding is emulating the option iterator interface.
			  If mDataStore = Nil Then Return False
			  Return mDataStore Is FakeDataStore
			End Get
		#tag EndGetter
		Protected IsFake As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  ' internal use. Returns True if using the OptionDumper interface to read a session's options.
			  If mDataStore = Nil Then Return False
			  Return Not IsFake
			End Get
		#tag EndGetter
		Protected IsSession As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDataStore As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrev As Ptr
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
