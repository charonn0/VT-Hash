#tag Module
Protected Module Opts
	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_option_by_id Lib cURLLib (OptionID As Integer) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_option_by_name Lib cURLLib (Name As CString) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_option_next Lib cURLLib (Previous As Ptr) As Ptr
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function IsOptionAvailable(OptionNumber As Integer) As Boolean
		  If Not libcURL.IsAvailable Then Return False
		  Dim iter As New OptionIterator()
		  Do
		    If iter.CurrentOption = OptionNumber Then
		      Dim opt As OptionInfo = OptionNumber
		      Dim e As New EasyHandle
		      Select Case opt.Type
		      Case OptionType.Bitmask, OptionType.LargeNumber, OptionType.Number
		        If Not e.SetOption(opt, 1) Then Return False
		        Return opt.Value(e) = 1
		      Case OptionType.Blob, OptionType.List, OptionType.Opaque, OptionType.Ptr, OptionType.Subroutine
		        If Not e.SetOption(opt, Nil) Then Return False
		        Return opt.Value(e) = Nil
		      Case OptionType.String
		        If Not e.SetOption(opt, "") Then Return False
		        Return opt.Value(e) = ""
		      End Select
		    End If
		  Loop Until Not iter.MoveNext()
		  
		  Exception
		    Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsOptionAvailable(OptionName As String) As Boolean
		  Dim opt As OptionInfo = OptionName
		  If opt.OptionNumber = 0 Then Return False
		  Return IsOptionAvailable(opt)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function OptionTypeName(Type As libcURL.OptionType) As String
		  Select Case Type
		  Case OptionType.Bitmask
		    Return "Bitmask"
		  Case OptionType.Blob
		    Return "Blob"
		  Case OptionType.LargeNumber
		    Return "Large number"
		  Case OptionType.List
		    Return "List"
		  Case OptionType.Number
		    Return "Number"
		  Case OptionType.Opaque
		    Return "Opaque"
		  Case OptionType.Ptr
		    Return "Ptr"
		  Case OptionType.String
		    Return "String"
		  Case OptionType.Subroutine
		    Return "Subroutine"
		  Case OptionType.Boolean ' added by the binding
		    Return "Boolean"
		  Else
		    Return "Unknown"
		  End Select
		End Function
	#tag EndMethod


	#tag Constant, Name = ABSTRACT_UNIX_SOCKET, Type = Double, Dynamic = False, Default = \"10264", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ACCEPTTIMEOUT_MS, Type = Double, Dynamic = False, Default = \"212", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ACCEPT_ENCODING, Type = Double, Dynamic = False, Default = \"10102", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ADDRESS_SCOPE, Type = Double, Dynamic = False, Default = \"171", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ALTSVC, Type = Double, Dynamic = False, Default = \"10287", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ALTSVC_CTRL, Type = Double, Dynamic = False, Default = \"286", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = APPEND, Type = Double, Dynamic = False, Default = \"50", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AUTOREFERER, Type = Double, Dynamic = False, Default = \"58", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = AWS_SIGV4, Type = Double, Dynamic = False, Default = \"10305", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BUFFERSIZE, Type = Double, Dynamic = False, Default = \"98", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CAINFO, Type = Double, Dynamic = False, Default = \"10065", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CAINFO_BLOB, Type = Double, Dynamic = False, Default = \"40309", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CAPATH, Type = Double, Dynamic = False, Default = \"10097", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CERTINFO, Type = Double, Dynamic = False, Default = \"172", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CHUNK_BGN_FUNCTION, Type = Double, Dynamic = False, Default = \"20198", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CHUNK_DATA, Type = Double, Dynamic = False, Default = \"10201", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CHUNK_END_FUNCTION, Type = Double, Dynamic = False, Default = \"20199", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CLOSESOCKETDATA, Type = Double, Dynamic = False, Default = \"10209", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CLOSESOCKETFUNCTION, Type = Double, Dynamic = False, Default = \"20208", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CONNECTTIMEOUT, Type = Double, Dynamic = False, Default = \"78", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CONNECTTIMEOUT_MS, Type = Double, Dynamic = False, Default = \"156", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CONNECT_ONLY, Type = Double, Dynamic = False, Default = \"141", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CONNECT_TO, Type = Double, Dynamic = False, Default = \"10243", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CONV_FROM_NETWORK_FUNCTION, Type = Double, Dynamic = False, Default = \"20142", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CONV_FROM_UTF8_FUNCTION, Type = Double, Dynamic = False, Default = \"20144", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CONV_TO_NETWORK_FUNCTION, Type = Double, Dynamic = False, Default = \"20143", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = COOKIE, Type = Double, Dynamic = False, Default = \"10022", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = COOKIEFILE, Type = Double, Dynamic = False, Default = \"10031", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = COOKIEJAR, Type = Double, Dynamic = False, Default = \"10082", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = COOKIELIST, Type = Double, Dynamic = False, Default = \"10135", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = COOKIESESSION, Type = Double, Dynamic = False, Default = \"96", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = COPYPOSTFIELDS, Type = Double, Dynamic = False, Default = \"10165", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRLF, Type = Double, Dynamic = False, Default = \"27", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRLFILE, Type = Double, Dynamic = False, Default = \"10169", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLU, Type = Double, Dynamic = False, Default = \"10282", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CUSTOMREQUEST, Type = Double, Dynamic = False, Default = \"10036", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DEBUGDATA, Type = Double, Dynamic = False, Default = \"10095", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DEBUGFUNCTION, Type = Double, Dynamic = False, Default = \"20094", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DEFAULT_PROTOCOL, Type = Double, Dynamic = False, Default = \"10238", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DIRLISTONLY, Type = Double, Dynamic = False, Default = \"48", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DISALLOW_USERNAME_IN_URL, Type = Double, Dynamic = False, Default = \"278", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DNS_CACHE_TIMEOUT, Type = Double, Dynamic = False, Default = \"92", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DNS_INTERFACE, Type = Double, Dynamic = False, Default = \"10221", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DNS_LOCAL_IP4, Type = Double, Dynamic = False, Default = \"10222", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DNS_LOCAL_IP6, Type = Double, Dynamic = False, Default = \"10223", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DNS_SERVERS, Type = Double, Dynamic = False, Default = \"10211", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DNS_SHUFFLE_ADDRESSES, Type = Double, Dynamic = False, Default = \"275", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DNS_USE_GLOBAL_CACHE, Type = Double, Dynamic = False, Default = \"91", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DOH_SSL_VERIFYHOST, Type = Double, Dynamic = False, Default = \"307", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DOH_SSL_VERIFYPEER, Type = Double, Dynamic = False, Default = \"306", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DOH_SSL_VERIFYSTATUS, Type = Double, Dynamic = False, Default = \"308", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = DOH_URL, Type = Double, Dynamic = False, Default = \"10279", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = EGDSOCKET, Type = Double, Dynamic = False, Default = \"10077", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ERRORBUFFER, Type = Double, Dynamic = False, Default = \"10010", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = EXPECT_100_TIMEOUT_MS, Type = Double, Dynamic = False, Default = \"227", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FAILONERROR, Type = Double, Dynamic = False, Default = \"45", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILETIME, Type = Double, Dynamic = False, Default = \"69", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FNMATCH_DATA, Type = Double, Dynamic = False, Default = \"10202", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FNMATCH_FUNCTION, Type = Double, Dynamic = False, Default = \"20200", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FOLLOWLOCATION, Type = Double, Dynamic = False, Default = \"52", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FORBID_REUSE, Type = Double, Dynamic = False, Default = \"75", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FRESH_CONNECT, Type = Double, Dynamic = False, Default = \"74", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTPPORT, Type = Double, Dynamic = False, Default = \"10017", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTPSSLAUTH, Type = Double, Dynamic = False, Default = \"129", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_ACCOUNT, Type = Double, Dynamic = False, Default = \"10134", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_ALTERNATIVE_TO_USER, Type = Double, Dynamic = False, Default = \"10147", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_CREATE_MISSING_DIRS, Type = Double, Dynamic = False, Default = \"110", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_FILEMETHOD, Type = Double, Dynamic = False, Default = \"138", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_RESPONSE_TIMEOUT, Type = Double, Dynamic = False, Default = \"112", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_SKIP_PASV_IP, Type = Double, Dynamic = False, Default = \"137", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_SSL_CCC, Type = Double, Dynamic = False, Default = \"154", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_USE_EPRT, Type = Double, Dynamic = False, Default = \"106", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_USE_EPSV, Type = Double, Dynamic = False, Default = \"85", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FTP_USE_PRET, Type = Double, Dynamic = False, Default = \"188", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GSSAPI_DELEGATION, Type = Double, Dynamic = False, Default = \"210", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HAPPY_EYEBALLS_TIMEOUT_MS, Type = Double, Dynamic = False, Default = \"271", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HAPROXYPROTOCOL, Type = Double, Dynamic = False, Default = \"274", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HEADER, Type = Double, Dynamic = False, Default = \"42", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HEADERDATA, Type = Double, Dynamic = False, Default = \"10029", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HEADERFUNCTION, Type = Double, Dynamic = False, Default = \"20079", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HEADEROPT, Type = Double, Dynamic = False, Default = \"229", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HSTS, Type = Double, Dynamic = False, Default = \"10300", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HSTSREADDATA, Type = Double, Dynamic = False, Default = \"10302", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HSTSREADFUNCTION, Type = Double, Dynamic = False, Default = \"20301", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HSTSWRITEDATA, Type = Double, Dynamic = False, Default = \"10304", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HSTSWRITEFUNCTION, Type = Double, Dynamic = False, Default = \"20303", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HSTS_CTRL, Type = Double, Dynamic = False, Default = \"299", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTP09_ALLOWED, Type = Double, Dynamic = False, Default = \"285", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTP200ALIASES, Type = Double, Dynamic = False, Default = \"10104", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTPAUTH, Type = Double, Dynamic = False, Default = \"107", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTPGET, Type = Double, Dynamic = False, Default = \"80", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTPHEADER, Type = Double, Dynamic = False, Default = \"10023", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTPPOST, Type = Double, Dynamic = False, Default = \"10024", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTPPROXYTUNNEL, Type = Double, Dynamic = False, Default = \"61", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTPVERSION, Type = Double, Dynamic = False, Default = \"84", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTP_CONTENT_DECODING, Type = Double, Dynamic = False, Default = \"158", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTP_TRANSFER_DECODING, Type = Double, Dynamic = False, Default = \"157", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HTTP_VERSION, Type = Double, Dynamic = False, Default = \"84", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = IGNORE_CONTENT_LENGTH, Type = Double, Dynamic = False, Default = \"136", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INFILESIZE, Type = Double, Dynamic = False, Default = \"14", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INFILESIZE_LARGE, Type = Double, Dynamic = False, Default = \"30115", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INTERLEAVEDATA, Type = Double, Dynamic = False, Default = \"10195", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = INTERLEAVEFUNCTION, Type = Double, Dynamic = False, Default = \"20196", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = IOCTLDATA, Type = Double, Dynamic = False, Default = \"10131", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = IOCTLFUNCTION, Type = Double, Dynamic = False, Default = \"20130", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = IPRESOLVE, Type = Double, Dynamic = False, Default = \"113", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ISSUERCERT, Type = Double, Dynamic = False, Default = \"10170", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ISSUERCERT_BLOB, Type = Double, Dynamic = False, Default = \"40295", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = KEEP_SENDING_ON_ERROR, Type = Double, Dynamic = False, Default = \"245", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = KEYPASSWD, Type = Double, Dynamic = False, Default = \"10026", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = KRBLEVEL, Type = Double, Dynamic = False, Default = \"10063", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LOCALPORT, Type = Double, Dynamic = False, Default = \"139", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LOCALPORTRANGE, Type = Double, Dynamic = False, Default = \"140", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LOGIN_OPTIONS, Type = Double, Dynamic = False, Default = \"10224", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LOW_SPEED_LIMIT, Type = Double, Dynamic = False, Default = \"19", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LOW_SPEED_TIME, Type = Double, Dynamic = False, Default = \"20", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAIL_AUTH, Type = Double, Dynamic = False, Default = \"10217", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAIL_FROM, Type = Double, Dynamic = False, Default = \"10186", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAIL_RCPT, Type = Double, Dynamic = False, Default = \"10187", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAIL_RCPT_ALLLOWFAILS, Type = Double, Dynamic = False, Default = \"290", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAXAGE_CONN, Type = Double, Dynamic = False, Default = \"288", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAXCONNECTS, Type = Double, Dynamic = False, Default = \"71", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAXFILESIZE, Type = Double, Dynamic = False, Default = \"114", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAXFILESIZE_LARGE, Type = Double, Dynamic = False, Default = \"30117", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAXLIFETIME_CONN, Type = Double, Dynamic = False, Default = \"314", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAXREDIRS, Type = Double, Dynamic = False, Default = \"68", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAX_RECV_SPEED_LARGE, Type = Double, Dynamic = False, Default = \"30146", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAX_SEND_SPEED_LARGE, Type = Double, Dynamic = False, Default = \"30145", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MIMEPOST, Type = Double, Dynamic = False, Default = \"10269", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MIME_OPTIONS, Type = Double, Dynamic = False, Default = \"315", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NETINTERFACE, Type = Double, Dynamic = False, Default = \"10062", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NETRC, Type = Double, Dynamic = False, Default = \"51", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NETRC_FILE, Type = Double, Dynamic = False, Default = \"10118", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NEW_DIRECTORY_PERMS, Type = Double, Dynamic = False, Default = \"160", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NEW_FILE_PERMS, Type = Double, Dynamic = False, Default = \"159", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NOBODY, Type = Double, Dynamic = False, Default = \"44", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NOPROGRESS, Type = Double, Dynamic = False, Default = \"43", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NOPROXY, Type = Double, Dynamic = False, Default = \"10177", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = NOSIGNAL, Type = Double, Dynamic = False, Default = \"99", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OPENSOCKETDATA, Type = Double, Dynamic = False, Default = \"10164", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = OPENSOCKETFUNCTION, Type = Double, Dynamic = False, Default = \"20163", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PASSWORD, Type = Double, Dynamic = False, Default = \"10174", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PATH_AS_IS, Type = Double, Dynamic = False, Default = \"234", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PINNEDPUBLICKEY, Type = Double, Dynamic = False, Default = \"10230", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PIPELINING_SERVER_BL, Type = Double, Dynamic = False, Default = \"10012", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PIPELINING_SITE_BL, Type = Double, Dynamic = False, Default = \"10011", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PIPEWAIT, Type = Double, Dynamic = False, Default = \"237", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PORT, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = POST, Type = Double, Dynamic = False, Default = \"47", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = POSTFIELDS, Type = Double, Dynamic = False, Default = \"10015", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = POSTFIELDSIZE, Type = Double, Dynamic = False, Default = \"60", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = POSTFIELDSIZE_LARGE, Type = Double, Dynamic = False, Default = \"30120", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = POSTQUOTE, Type = Double, Dynamic = False, Default = \"10039", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = POSTREDIR, Type = Double, Dynamic = False, Default = \"161", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PREQUOTE, Type = Double, Dynamic = False, Default = \"10093", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PREREQDATA, Type = Double, Dynamic = False, Default = \"10313", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PREREQFUNCTION, Type = Double, Dynamic = False, Default = \"20312", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PRE_PROXY, Type = Double, Dynamic = False, Default = \"10262", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PRIVATE_, Type = Double, Dynamic = False, Default = \"10103", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROGRESSDATA, Type = Double, Dynamic = False, Default = \"10057", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROGRESSFUNCTION, Type = Double, Dynamic = False, Default = \"20056", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROTOCOLS, Type = Double, Dynamic = False, Default = \"181", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY, Type = Double, Dynamic = False, Default = \"10004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYAUTH, Type = Double, Dynamic = False, Default = \"111", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYHEADER, Type = Double, Dynamic = False, Default = \"10228", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYPASSWORD, Type = Double, Dynamic = False, Default = \"10176", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYPORT, Type = Double, Dynamic = False, Default = \"59", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYTYPE, Type = Double, Dynamic = False, Default = \"101", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYUSERNAME, Type = Double, Dynamic = False, Default = \"10175", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYUSERPWD, Type = Double, Dynamic = False, Default = \"10006", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_CAINFO, Type = Double, Dynamic = False, Default = \"10246", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_CAINFO_BLOB, Type = Double, Dynamic = False, Default = \"40310", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_CAPATH, Type = Double, Dynamic = False, Default = \"10247", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_CRLFILE, Type = Double, Dynamic = False, Default = \"10260", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_ISSUERCERT, Type = Double, Dynamic = False, Default = \"10296", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_ISSUERCERT_BLOB, Type = Double, Dynamic = False, Default = \"40297", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_KEYPASSWD, Type = Double, Dynamic = False, Default = \"10258", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_PINNEDPUBLICKEY, Type = Double, Dynamic = False, Default = \"10263", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SERVICE_NAME, Type = Double, Dynamic = False, Default = \"10235", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SSLCERT, Type = Double, Dynamic = False, Default = \"10254", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SSLCERTTYPE, Type = Double, Dynamic = False, Default = \"10255", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SSLCERT_BLOB, Type = Double, Dynamic = False, Default = \"40293", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SSLKEY, Type = Double, Dynamic = False, Default = \"10256", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SSLKEYTYPE, Type = Double, Dynamic = False, Default = \"10257", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SSLKEY_BLOB, Type = Double, Dynamic = False, Default = \"40294", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SSLVERSION, Type = Double, Dynamic = False, Default = \"250", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SSL_CIPHER_LIST, Type = Double, Dynamic = False, Default = \"10259", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SSL_OPTIONS, Type = Double, Dynamic = False, Default = \"261", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SSL_VERIFYHOST, Type = Double, Dynamic = False, Default = \"249", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_SSL_VERIFYPEER, Type = Double, Dynamic = False, Default = \"248", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_TLS13_CIPHERS, Type = Double, Dynamic = False, Default = \"10277", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_TLSAUTH_PASSWORD, Type = Double, Dynamic = False, Default = \"10252", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_TLSAUTH_TYPE, Type = Double, Dynamic = False, Default = \"10253", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_TLSAUTH_USERNAME, Type = Double, Dynamic = False, Default = \"10251", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXY_TRANSFER_MODE, Type = Double, Dynamic = False, Default = \"166", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PUT, Type = Double, Dynamic = False, Default = \"54", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = QUOTE, Type = Double, Dynamic = False, Default = \"10028", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RANDOM_FILE, Type = Double, Dynamic = False, Default = \"10076", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RANGE, Type = Double, Dynamic = False, Default = \"10007", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = READDATA, Type = Double, Dynamic = False, Default = \"10009", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = READFUNCTION, Type = Double, Dynamic = False, Default = \"20012", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REDIR_PROTOCOLS, Type = Double, Dynamic = False, Default = \"182", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REFERER, Type = Double, Dynamic = False, Default = \"10016", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REQUEST_TARGET, Type = Double, Dynamic = False, Default = \"10266", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOLVE, Type = Double, Dynamic = False, Default = \"10203", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOLVER_START_DATA, Type = Double, Dynamic = False, Default = \"10273", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOLVER_START_FUNCTION, Type = Double, Dynamic = False, Default = \"20272", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESUME_FROM, Type = Double, Dynamic = False, Default = \"21", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESUME_FROM_LARGE, Type = Double, Dynamic = False, Default = \"30116", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RTSP_CLIENT_CSEQ, Type = Double, Dynamic = False, Default = \"193", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RTSP_REQUEST, Type = Double, Dynamic = False, Default = \"189", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RTSP_SERVER_CSEQ, Type = Double, Dynamic = False, Default = \"194", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RTSP_SESSION_ID, Type = Double, Dynamic = False, Default = \"10190", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RTSP_STREAM_URI, Type = Double, Dynamic = False, Default = \"10191", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RTSP_TRANSPORT, Type = Double, Dynamic = False, Default = \"10192", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SASL_AUTHZID, Type = Double, Dynamic = False, Default = \"10289", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SASL_IR, Type = Double, Dynamic = False, Default = \"218", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SEEKDATA, Type = Double, Dynamic = False, Default = \"10168", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SEEKFUNCTION, Type = Double, Dynamic = False, Default = \"20167", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SERVICE_NAME, Type = Double, Dynamic = False, Default = \"10236", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SHARE, Type = Double, Dynamic = False, Default = \"10100", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SHOPT_LOCKFUNC, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SHOPT_UNLOCKFUNC, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SHOPT_USERDATA, Type = Double, Dynamic = False, Default = \"5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SOCKOPTDATA, Type = Double, Dynamic = False, Default = \"10149", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SOCKOPTFUNCTION, Type = Double, Dynamic = False, Default = \"20148", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SOCKS5_AUTH, Type = Double, Dynamic = False, Default = \"267", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SOCKS5_GSSAPI_NEC, Type = Double, Dynamic = False, Default = \"180", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SOCKS5_GSSAPI_SERVICE, Type = Double, Dynamic = False, Default = \"10179", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSH_AUTH_TYPES, Type = Double, Dynamic = False, Default = \"151", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSH_COMPRESSION, Type = Double, Dynamic = False, Default = \"268", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSH_HOST_PUBLIC_KEY_MD5, Type = Double, Dynamic = False, Default = \"10162", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSH_HOST_PUBLIC_KEY_SHA256, Type = Double, Dynamic = False, Default = \"10311", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSH_KEYDATA, Type = Double, Dynamic = False, Default = \"10185", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSH_KEYFUNCTION, Type = Double, Dynamic = False, Default = \"20184", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSH_KNOWNHOSTS, Type = Double, Dynamic = False, Default = \"10183", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSH_PRIVATE_KEYFILE, Type = Double, Dynamic = False, Default = \"10153", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSH_PUBLIC_KEYFILE, Type = Double, Dynamic = False, Default = \"10152", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSLCERT, Type = Double, Dynamic = False, Default = \"10025", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSLCERTTYPE, Type = Double, Dynamic = False, Default = \"10086", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSLCERT_BLOB, Type = Double, Dynamic = False, Default = \"40291", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSLENGINE, Type = Double, Dynamic = False, Default = \"10089", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSLENGINE_DEFAULT, Type = Double, Dynamic = False, Default = \"90", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSLKEY, Type = Double, Dynamic = False, Default = \"10087", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSLKEYTYPE, Type = Double, Dynamic = False, Default = \"10088", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSLKEY_BLOB, Type = Double, Dynamic = False, Default = \"40292", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSLVERSION, Type = Double, Dynamic = False, Default = \"32", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CIPHER_LIST, Type = Double, Dynamic = False, Default = \"10083", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CTX_DATA, Type = Double, Dynamic = False, Default = \"10109", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_CTX_FUNCTION, Type = Double, Dynamic = False, Default = \"20108", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_EC_CURVES, Type = Double, Dynamic = False, Default = \"10298", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_ENABLE_ALPN, Type = Double, Dynamic = False, Default = \"226", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_ENABLE_NPN, Type = Double, Dynamic = False, Default = \"225", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_FALSESTART, Type = Double, Dynamic = False, Default = \"233", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_OPTIONS, Type = Double, Dynamic = False, Default = \"216", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_SESSIONID_CACHE, Type = Double, Dynamic = False, Default = \"150", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_VERIFYHOST, Type = Double, Dynamic = False, Default = \"81", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_VERIFYPEER, Type = Double, Dynamic = False, Default = \"64", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SSL_VERIFYSTATUS, Type = Double, Dynamic = False, Default = \"232", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STDERR, Type = Double, Dynamic = False, Default = \"10037", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STREAM_DEPENDS, Type = Double, Dynamic = False, Default = \"10240", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STREAM_DEPENDS_E, Type = Double, Dynamic = False, Default = \"10241", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STREAM_WEIGHT, Type = Double, Dynamic = False, Default = \"239", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SUPPRESS_CONNECT_HEADERS, Type = Double, Dynamic = False, Default = \"265", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TCP_FASTOPEN, Type = Double, Dynamic = False, Default = \"244", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TCP_KEEPALIVE, Type = Double, Dynamic = False, Default = \"213", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TCP_KEEPIDLE, Type = Double, Dynamic = False, Default = \"214", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TCP_KEEPINTVL, Type = Double, Dynamic = False, Default = \"215", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TCP_NODELAY, Type = Double, Dynamic = False, Default = \"121", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TELNETOPTIONS, Type = Double, Dynamic = False, Default = \"10070", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TFTP_BLKSIZE, Type = Double, Dynamic = False, Default = \"178", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TFTP_NO_OPTIONS, Type = Double, Dynamic = False, Default = \"242", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TIMECONDITION, Type = Double, Dynamic = False, Default = \"33", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TIMEOUT, Type = Double, Dynamic = False, Default = \"13", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TIMEOUT_MS, Type = Double, Dynamic = False, Default = \"155", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TIMEVALUE, Type = Double, Dynamic = False, Default = \"34", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TIMEVALUE_LARGE, Type = Double, Dynamic = False, Default = \"30270", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TLS13_CIPHERS, Type = Double, Dynamic = False, Default = \"10276", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TLSAUTH_PASSWORD, Type = Double, Dynamic = False, Default = \"10205", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TLSAUTH_TYPE, Type = Double, Dynamic = False, Default = \"10206", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TLSAUTH_USERNAME, Type = Double, Dynamic = False, Default = \"10204", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRAILERDATA, Type = Double, Dynamic = False, Default = \"10284", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRAILERFUNCTION, Type = Double, Dynamic = False, Default = \"20283", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRANSFERTEXT, Type = Double, Dynamic = False, Default = \"53", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRANSFER_ENCODING, Type = Double, Dynamic = False, Default = \"207", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UNIX_SOCKET_PATH, Type = Double, Dynamic = False, Default = \"10231", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UNRESTRICTED_AUTH, Type = Double, Dynamic = False, Default = \"105", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UPKEEP_INTERVAL_MS, Type = Double, Dynamic = False, Default = \"281", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UPLOAD, Type = Double, Dynamic = False, Default = \"46", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = UPLOAD_BUFFERSIZE, Type = Double, Dynamic = False, Default = \"280", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = URL, Type = Double, Dynamic = False, Default = \"10002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = USERAGENT, Type = Double, Dynamic = False, Default = \"10018", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = USERNAME, Type = Double, Dynamic = False, Default = \"10173", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = USERPWD, Type = Double, Dynamic = False, Default = \"10005", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = USE_SSL, Type = Double, Dynamic = False, Default = \"119", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = USE_SSL_ALL, Type = Double, Dynamic = False, Default = \"3", Scope = Protected, Attributes = \"deprecated \x3D "libcURL.ConnectionType""
	#tag EndConstant

	#tag Constant, Name = USE_SSL_CONTROL, Type = Double, Dynamic = False, Default = \"2", Scope = Protected, Attributes = \"deprecated \x3D "libcURL.ConnectionType""
	#tag EndConstant

	#tag Constant, Name = USE_SSL_NONE, Type = Double, Dynamic = False, Default = \"0", Scope = Protected, Attributes = \"deprecated \x3D "libcURL.ConnectionType""
	#tag EndConstant

	#tag Constant, Name = USE_SSL_TRY, Type = Double, Dynamic = False, Default = \"1", Scope = Protected, Attributes = \"deprecated \x3D "libcURL.ConnectionType""
	#tag EndConstant

	#tag Constant, Name = VERBOSE, Type = Double, Dynamic = False, Default = \"41", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WILDCARDMATCH, Type = Double, Dynamic = False, Default = \"197", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WRITEDATA, Type = Double, Dynamic = False, Default = \"10001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = WRITEFUNCTION, Type = Double, Dynamic = False, Default = \"20011", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = XFERINFODATA, Type = Double, Dynamic = False, Default = \"10057", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = XFERINFOFUNCTION, Type = Double, Dynamic = False, Default = \"20219", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = XOAUTH2_BEARER, Type = Double, Dynamic = False, Default = \"10220", Scope = Protected
	#tag EndConstant


	#tag Structure, Name = curl_easyoption, Flags = &h21, Attributes = \"StructureAlignment \x3D 1"
		Name As Ptr
		  Option As Int32
		  Type As OptionType
		Flags As UInt32
	#tag EndStructure


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
