#tag Class
Protected Class OptionInfo
	#tag Method, Flags = &h1
		Protected Sub Constructor(Option As curl_easyoption)
		  mOpt = Option
		  Call GetOptionFirstVersion(OptionNumber, mMinMajor, mMinMinor, mMinPatch)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function GetOptionByName(Name As String) As Int32
		  Name = Replace(Name, "CURLOPT_", "")
		  Name = Replace(Name, "libcURL.Opts.", "")
		  Select Case Name
		  Case "ABSTRACT_UNIX_SOCKET"
		    Return ABSTRACT_UNIX_SOCKET
		  Case "ACCEPTTIMEOUT_MS"
		    Return ACCEPTTIMEOUT_MS
		  Case "ACCEPT_ENCODING"
		    Return ACCEPT_ENCODING
		  Case "ADDRESS_SCOPE"
		    Return ADDRESS_SCOPE
		  Case "ALTSVC"
		    Return ALTSVC
		  Case "ALTSVC_CTRL"
		    Return ALTSVC_CTRL
		  Case "APPEND"
		    Return APPEND
		  Case "AUTOREFERER"
		    Return AUTOREFERER
		  Case "AWS_SIGV4"
		    Return AWS_SIGV4
		  Case "BUFFERSIZE"
		    Return BUFFERSIZE
		  Case "CAINFO"
		    Return CAINFO
		  Case "CAPATH"
		    Return CAPATH
		  Case "CAINFO_BLOB"
		    Return CAINFO_BLOB
		  Case "CERTINFO"
		    Return CERTINFO
		  Case "CHUNK_BGN_FUNCTION"
		    Return CHUNK_BGN_FUNCTION
		  Case "CHUNK_DATA"
		    Return CHUNK_DATA
		  Case "CHUNK_END_FUNCTION"
		    Return CHUNK_END_FUNCTION
		  Case "CLOSESOCKETDATA"
		    Return CLOSESOCKETDATA
		  Case "CLOSESOCKETFUNCTION"
		    Return CLOSESOCKETFUNCTION
		  Case "CONNECTTIMEOUT"
		    Return CONNECTTIMEOUT
		  Case "CONNECTTIMEOUT_MS"
		    Return CONNECTTIMEOUT_MS
		  Case "CONNECT_ONLY"
		    Return CONNECT_ONLY
		  Case "CONNECT_TO"
		    Return CONNECT_TO
		  Case "CONV_FROM_NETWORK_FUNCTION"
		    Return CONV_FROM_NETWORK_FUNCTION
		  Case "CONV_FROM_UTF8_FUNCTION"
		    Return CONV_FROM_UTF8_FUNCTION
		  Case "CONV_TO_NETWORK_FUNCTION"
		    Return CONV_TO_NETWORK_FUNCTION
		  Case "COOKIE"
		    Return COOKIE
		  Case "COOKIEFILE"
		    Return COOKIEFILE
		  Case "COOKIEJAR"
		    Return COOKIEJAR
		  Case "COOKIELIST"
		    Return COOKIELIST
		  Case "COOKIESESSION"
		    Return COOKIESESSION
		  Case "COPYPOSTFIELDS"
		    Return COPYPOSTFIELDS
		  Case "CRLF"
		    Return CRLF
		  Case "CRLFILE"
		    Return CRLFILE
		  Case "CURLU"
		    Return CURLU
		  Case "CUSTOMREQUEST"
		    Return CUSTOMREQUEST
		  Case "DEBUGDATA"
		    Return DEBUGDATA
		  Case "DEBUGFUNCTION"
		    Return DEBUGFUNCTION
		  Case "DEFAULT_PROTOCOL"
		    Return DEFAULT_PROTOCOL
		  Case "DIRLISTONLY"
		    Return DIRLISTONLY
		  Case "DISALLOW_USERNAME_IN_URL"
		    Return DISALLOW_USERNAME_IN_URL
		  Case "DNS_CACHE_TIMEOUT"
		    Return DNS_CACHE_TIMEOUT
		  Case "DNS_INTERFACE"
		    Return DNS_INTERFACE
		  Case "DNS_LOCAL_IP4"
		    Return DNS_LOCAL_IP4
		  Case "DNS_LOCAL_IP6"
		    Return DNS_LOCAL_IP6
		  Case "DNS_SERVERS"
		    Return DNS_SERVERS
		  Case "DNS_SHUFFLE_ADDRESSES"
		    Return DNS_SHUFFLE_ADDRESSES
		  Case "DNS_USE_GLOBAL_CACHE"
		    Return DNS_USE_GLOBAL_CACHE
		  Case "DOH_SSL_VERIFYHOST"
		    Return DOH_SSL_VERIFYHOST
		  Case "DOH_SSL_VERIFYPEER"
		    Return DOH_SSL_VERIFYPEER
		  Case "DOH_SSL_VERIFYSTATUS"
		    Return DOH_SSL_VERIFYSTATUS
		  Case "DOH_URL"
		    Return DOH_URL
		  Case "EGDSOCKET"
		    Return EGDSOCKET
		  Case "ERRORBUFFER"
		    Return ERRORBUFFER
		  Case "EXPECT_100_TIMEOUT_MS"
		    Return EXPECT_100_TIMEOUT_MS
		  Case "FAILONERROR"
		    Return FAILONERROR
		  Case "FILETIME"
		    Return FILETIME
		  Case "FNMATCH_DATA"
		    Return FNMATCH_DATA
		  Case "FNMATCH_FUNCTION"
		    Return FNMATCH_FUNCTION
		  Case "FOLLOWLOCATION"
		    Return FOLLOWLOCATION
		  Case "FORBID_REUSE"
		    Return FORBID_REUSE
		  Case "FRESH_CONNECT"
		    Return FRESH_CONNECT
		  Case "FTPPORT"
		    Return FTPPORT
		  Case "FTPSSLAUTH"
		    Return FTPSSLAUTH
		  Case "FTP_ACCOUNT"
		    Return FTP_ACCOUNT
		  Case "FTP_ALTERNATIVE_TO_USER"
		    Return FTP_ALTERNATIVE_TO_USER
		  Case "FTP_CREATE_MISSING_DIRS"
		    Return FTP_CREATE_MISSING_DIRS
		  Case "FTP_FILEMETHOD"
		    Return FTP_FILEMETHOD
		  Case "FTP_RESPONSE_TIMEOUT"
		    Return FTP_RESPONSE_TIMEOUT
		  Case "FTP_SKIP_PASV_IP"
		    Return FTP_SKIP_PASV_IP
		  Case "FTP_SSL_CCC"
		    Return FTP_SSL_CCC
		  Case "FTP_USE_EPRT"
		    Return FTP_USE_EPRT
		  Case "FTP_USE_EPSV"
		    Return FTP_USE_EPSV
		  Case "FTP_USE_PRET"
		    Return FTP_USE_PRET
		  Case "GSSAPI_DELEGATION"
		    Return GSSAPI_DELEGATION
		  Case "HAPPY_EYEBALLS_TIMEOUT_MS"
		    Return HAPPY_EYEBALLS_TIMEOUT_MS
		  Case "HAPROXYPROTOCOL"
		    Return HAPROXYPROTOCOL
		  Case "HEADER"
		    Return HEADER
		  Case "HEADERDATA"
		    Return HEADERDATA
		  Case "HEADERFUNCTION"
		    Return HEADERFUNCTION
		  Case "HEADEROPT"
		    Return HEADEROPT
		  Case "HSTS"
		    Return HSTS
		  Case "HSTSREADDATA"
		    Return HSTSREADDATA
		  Case "HSTSREADFUNCTION"
		    Return HSTSREADFUNCTION
		  Case "HSTSWRITEDATA"
		    Return HSTSWRITEDATA
		  Case "HSTSWRITEFUNCTION"
		    Return HSTSWRITEFUNCTION
		  Case "HSTS_CTRL"
		    Return HSTS_CTRL
		  Case "HTTP09_ALLOWED"
		    Return HTTP09_ALLOWED
		  Case "HTTP200ALIASES"
		    Return HTTP200ALIASES
		  Case "HTTPAUTH"
		    Return HTTPAUTH
		  Case "HTTPGET"
		    Return HTTPGET
		  Case "HTTPHEADER"
		    Return HTTPHEADER
		  Case "HTTPPOST"
		    Return HTTPPOST
		  Case "HTTPPROXYTUNNEL"
		    Return HTTPPROXYTUNNEL
		  Case "HTTPVERSION"
		    Return HTTPVERSION
		  Case "HTTP_CONTENT_DECODING"
		    Return HTTP_CONTENT_DECODING
		  Case "HTTP_TRANSFER_DECODING"
		    Return HTTP_TRANSFER_DECODING
		  Case "HTTP_VERSION"
		    Return HTTP_VERSION
		  Case "IGNORE_CONTENT_LENGTH"
		    Return IGNORE_CONTENT_LENGTH
		  Case "INFILESIZE"
		    Return INFILESIZE
		  Case "INFILESIZE_LARGE"
		    Return INFILESIZE_LARGE
		  Case "INTERLEAVEDATA"
		    Return INTERLEAVEDATA
		  Case "INTERLEAVEFUNCTION"
		    Return INTERLEAVEFUNCTION
		  Case "IOCTLDATA"
		    Return IOCTLDATA
		  Case "IOCTLFUNCTION"
		    Return IOCTLFUNCTION
		  Case "IPRESOLVE"
		    Return IPRESOLVE
		  Case "ISSUERCERT"
		    Return ISSUERCERT
		  Case "ISSUERCERT_BLOB"
		    Return ISSUERCERT_BLOB
		  Case "KEEP_SENDING_ON_ERROR"
		    Return KEEP_SENDING_ON_ERROR
		  Case "KEYPASSWD"
		    Return KEYPASSWD
		  Case "KRBLEVEL"
		    Return KRBLEVEL
		  Case "LOCALPORT"
		    Return LOCALPORT
		  Case "LOCALPORTRANGE"
		    Return LOCALPORTRANGE
		  Case "LOGIN_OPTIONS"
		    Return LOGIN_OPTIONS
		  Case "LOW_SPEED_LIMIT"
		    Return LOW_SPEED_LIMIT
		  Case "LOW_SPEED_TIME"
		    Return LOW_SPEED_TIME
		  Case "MAIL_AUTH"
		    Return MAIL_AUTH
		  Case "MAIL_FROM"
		    Return MAIL_FROM
		  Case "MAIL_RCPT"
		    Return MAIL_RCPT
		  Case "MAIL_RCPT_ALLLOWFAILS"
		    Return MAIL_RCPT_ALLLOWFAILS
		  Case "MAXAGE_CONN"
		    Return MAXAGE_CONN
		  Case "MAXCONNECTS"
		    Return MAXCONNECTS
		  Case "MAXFILESIZE"
		    Return MAXFILESIZE
		  Case "MAXFILESIZE_LARGE"
		    Return MAXFILESIZE_LARGE
		  Case "MAXREDIRS"
		    Return MAXREDIRS
		  Case "MAXLIFETIME_CONN"
		    Return MAXLIFETIME_CONN
		  Case "MAX_RECV_SPEED_LARGE"
		    Return MAX_RECV_SPEED_LARGE
		  Case "MAX_SEND_SPEED_LARGE"
		    Return MAX_SEND_SPEED_LARGE
		  Case "MIME_OPTIONS"
		    Return MIME_OPTIONS
		  Case "MIMEPOST"
		    Return MIMEPOST
		  Case "NETINTERFACE", "INTERFACE"
		    Return NETINTERFACE
		  Case "NETRC"
		    Return NETRC
		  Case "NETRC_FILE"
		    Return NETRC_FILE
		  Case "NEW_DIRECTORY_PERMS"
		    Return NEW_DIRECTORY_PERMS
		  Case "NEW_FILE_PERMS"
		    Return NEW_FILE_PERMS
		  Case "NOBODY"
		    Return NOBODY
		  Case "NOPROGRESS"
		    Return NOPROGRESS
		  Case "NOPROXY"
		    Return NOPROXY
		  Case "NOSIGNAL"
		    Return NOSIGNAL
		  Case "OPENSOCKETDATA"
		    Return OPENSOCKETDATA
		  Case "OPENSOCKETFUNCTION"
		    Return OPENSOCKETFUNCTION
		  Case "PASSWORD"
		    Return PASSWORD
		  Case "PATH_AS_IS"
		    Return PATH_AS_IS
		  Case "PINNEDPUBLICKEY"
		    Return PINNEDPUBLICKEY
		  Case "PIPELINING_SERVER_BL"
		    Return PIPELINING_SERVER_BL
		  Case "PIPELINING_SITE_BL"
		    Return PIPELINING_SITE_BL
		  Case "PIPEWAIT"
		    Return PIPEWAIT
		  Case "PORT"
		    Return PORT
		  Case "POST"
		    Return POST
		  Case "POSTFIELDS"
		    Return POSTFIELDS
		  Case "POSTFIELDSIZE"
		    Return POSTFIELDSIZE
		  Case "POSTFIELDSIZE_LARGE"
		    Return POSTFIELDSIZE_LARGE
		  Case "POSTQUOTE"
		    Return POSTQUOTE
		  Case "POSTREDIR"
		    Return POSTREDIR
		  Case "PREREQDATA"
		    Return PREREQDATA
		  Case "PREREQFUNCTION"
		    Return PREREQFUNCTION
		  Case "PREQUOTE"
		    Return PREQUOTE
		  Case "PRE_PROXY"
		    Return PRE_PROXY
		  Case "PRIVATE_"
		    Return PRIVATE_
		  Case "PROGRESSDATA"
		    Return PROGRESSDATA
		  Case "PROGRESSFUNCTION"
		    Return PROGRESSFUNCTION
		  Case "PROTOCOLS"
		    Return PROTOCOLS
		  Case "PROTOCOLS_STR"
		    Return PROTOCOLS_STR
		  Case "PROXY"
		    Return PROXY
		  Case "PROXYAUTH"
		    Return PROXYAUTH
		  Case "PROXYHEADER"
		    Return PROXYHEADER
		  Case "PROXYPASSWORD"
		    Return PROXYPASSWORD
		  Case "PROXYPORT"
		    Return PROXYPORT
		  Case "PROXYTYPE"
		    Return PROXYTYPE
		  Case "PROXYUSERNAME"
		    Return PROXYUSERNAME
		  Case "PROXYUSERPWD"
		    Return PROXYUSERPWD
		  Case "PROXY_CAINFO"
		    Return PROXY_CAINFO
		  Case "PROXY_CAINFO_BLOB"
		    Return PROXY_CAINFO_BLOB
		  Case "PROXY_CAPATH"
		    Return PROXY_CAPATH
		  Case "PROXY_CRLFILE"
		    Return PROXY_CRLFILE
		  Case "PROXY_ISSUERCERT"
		    Return PROXY_ISSUERCERT
		  Case "PROXY_ISSUERCERT_BLOB"
		    Return PROXY_ISSUERCERT_BLOB
		  Case "PROXY_KEYPASSWD"
		    Return PROXY_KEYPASSWD
		  Case "PROXY_PINNEDPUBLICKEY"
		    Return PROXY_PINNEDPUBLICKEY
		  Case "PROXY_SERVICE_NAME"
		    Return PROXY_SERVICE_NAME
		  Case "PROXY_SSLCERT"
		    Return PROXY_SSLCERT
		  Case "PROXY_SSLCERTTYPE"
		    Return PROXY_SSLCERTTYPE
		  Case "PROXY_SSLCERT_BLOB"
		    Return PROXY_SSLCERT_BLOB
		  Case "PROXY_SSLKEY"
		    Return PROXY_SSLKEY
		  Case "PROXY_SSLKEYTYPE"
		    Return PROXY_SSLKEYTYPE
		  Case "PROXY_SSLKEY_BLOB"
		    Return PROXY_SSLKEY_BLOB
		  Case "PROXY_SSLVERSION"
		    Return PROXY_SSLVERSION
		  Case "PROXY_SSL_CIPHER_LIST"
		    Return PROXY_SSL_CIPHER_LIST
		  Case "PROXY_SSL_OPTIONS"
		    Return PROXY_SSL_OPTIONS
		  Case "PROXY_SSL_VERIFYHOST"
		    Return PROXY_SSL_VERIFYHOST
		  Case "PROXY_SSL_VERIFYPEER"
		    Return PROXY_SSL_VERIFYPEER
		  Case "PROXY_TLS13_CIPHERS"
		    Return PROXY_TLS13_CIPHERS
		  Case "PROXY_TLSAUTH_PASSWORD"
		    Return PROXY_TLSAUTH_PASSWORD
		  Case "PROXY_TLSAUTH_TYPE"
		    Return PROXY_TLSAUTH_TYPE
		  Case "PROXY_TLSAUTH_USERNAME"
		    Return PROXY_TLSAUTH_USERNAME
		  Case "PROXY_TRANSFER_MODE"
		    Return PROXY_TRANSFER_MODE
		  Case "PUT"
		    Return PUT
		  Case "QUOTE"
		    Return QUOTE
		  Case "RANDOM_FILE"
		    Return RANDOM_FILE
		  Case "RANGE"
		    Return RANGE
		  Case "READDATA"
		    Return READDATA
		  Case "READFUNCTION"
		    Return READFUNCTION
		  Case "REDIR_PROTOCOLS"
		    Return REDIR_PROTOCOLS
		  Case "REDIR_PROTOCOLS_STR"
		    Return REDIR_PROTOCOLS_STR
		  Case "REFERER"
		    Return REFERER
		  Case "REQUEST_TARGET"
		    Return REQUEST_TARGET
		  Case "RESOLVE"
		    Return RESOLVE
		  Case "RESOLVER_START_DATA"
		    Return RESOLVER_START_DATA
		  Case "RESOLVER_START_FUNCTION"
		    Return RESOLVER_START_FUNCTION
		  Case "RESUME_FROM"
		    Return RESUME_FROM
		  Case "RESUME_FROM_LARGE"
		    Return RESUME_FROM_LARGE
		  Case "RTSP_CLIENT_CSEQ"
		    Return RTSP_CLIENT_CSEQ
		  Case "RTSP_REQUEST"
		    Return RTSP_REQUEST
		  Case "RTSP_SERVER_CSEQ"
		    Return RTSP_SERVER_CSEQ
		  Case "RTSP_SESSION_ID"
		    Return RTSP_SESSION_ID
		  Case "RTSP_STREAM_URI"
		    Return RTSP_STREAM_URI
		  Case "RTSP_TRANSPORT"
		    Return RTSP_TRANSPORT
		  Case "SASL_AUTHZID"
		    Return SASL_AUTHZID
		  Case "SASL_IR"
		    Return SASL_IR
		  Case "SEEKDATA"
		    Return SEEKDATA
		  Case "SEEKFUNCTION"
		    Return SEEKFUNCTION
		  Case "SERVICE_NAME"
		    Return SERVICE_NAME
		  Case "SHARE"
		    Return SHARE
		  Case "SHOPT_LOCKFUNC"
		    Return SHOPT_LOCKFUNC
		  Case "SHOPT_UNLOCKFUNC"
		    Return SHOPT_UNLOCKFUNC
		  Case "SHOPT_USERDATA"
		    Return SHOPT_USERDATA
		  Case "SOCKOPTDATA"
		    Return SOCKOPTDATA
		  Case "SOCKOPTFUNCTION"
		    Return SOCKOPTFUNCTION
		  Case "SOCKS5_AUTH"
		    Return SOCKS5_AUTH
		  Case "SOCKS5_GSSAPI_NEC"
		    Return SOCKS5_GSSAPI_NEC
		  Case "SOCKS5_GSSAPI_SERVICE"
		    Return SOCKS5_GSSAPI_SERVICE
		  Case "SSH_AUTH_TYPES"
		    Return SSH_AUTH_TYPES
		  Case "SSH_COMPRESSION"
		    Return SSH_COMPRESSION
		  Case "SSH_HOST_PUBLIC_KEY_MD5"
		    Return SSH_HOST_PUBLIC_KEY_MD5
		  Case "SSH_HOST_PUBLIC_KEY_SHA256"
		    Return SSH_HOST_PUBLIC_KEY_SHA256
		  Case "SSH_HOSTKEYDATA"
		    Return SSH_HOSTKEYDATA
		  Case "SSH_HOSTKEYFUNCTION"
		    Return SSH_HOSTKEYFUNCTION
		  Case "SSH_KEYDATA"
		    Return SSH_KEYDATA
		  Case "SSH_KEYFUNCTION"
		    Return SSH_KEYFUNCTION
		  Case "SSH_KNOWNHOSTS"
		    Return SSH_KNOWNHOSTS
		  Case "SSH_PRIVATE_KEYFILE"
		    Return SSH_PRIVATE_KEYFILE
		  Case "SSH_PUBLIC_KEYFILE"
		    Return SSH_PUBLIC_KEYFILE
		  Case "SSLCERT"
		    Return SSLCERT
		  Case "SSLCERTTYPE"
		    Return SSLCERTTYPE
		  Case "SSLCERT_BLOB"
		    Return SSLCERT_BLOB
		  Case "SSLENGINE"
		    Return SSLENGINE
		  Case "SSLENGINE_DEFAULT"
		    Return SSLENGINE_DEFAULT
		  Case "SSLKEY"
		    Return SSLKEY
		  Case "SSLKEYTYPE"
		    Return SSLKEYTYPE
		  Case "SSLKEY_BLOB"
		    Return SSLKEY_BLOB
		  Case "SSLVERSION"
		    Return SSLVERSION
		  Case "SSL_CIPHER_LIST"
		    Return SSL_CIPHER_LIST
		  Case "SSL_CTX_DATA"
		    Return SSL_CTX_DATA
		  Case "SSL_CTX_FUNCTION"
		    Return SSL_CTX_FUNCTION
		  Case "SSL_EC_CURVES"
		    Return SSL_EC_CURVES
		  Case "SSL_ENABLE_ALPN"
		    Return SSL_ENABLE_ALPN
		  Case "SSL_ENABLE_NPN"
		    Return SSL_ENABLE_NPN
		  Case "SSL_FALSESTART"
		    Return SSL_FALSESTART
		  Case "SSL_OPTIONS"
		    Return SSL_OPTIONS
		  Case "SSL_SESSIONID_CACHE"
		    Return SSL_SESSIONID_CACHE
		  Case "SSL_VERIFYHOST"
		    Return SSL_VERIFYHOST
		  Case "SSL_VERIFYPEER"
		    Return SSL_VERIFYPEER
		  Case "SSL_VERIFYSTATUS"
		    Return SSL_VERIFYSTATUS
		  Case "STDERR"
		    Return STDERR
		  Case "STREAM_DEPENDS"
		    Return STREAM_DEPENDS
		  Case "STREAM_DEPENDS_E"
		    Return STREAM_DEPENDS_E
		  Case "STREAM_WEIGHT"
		    Return STREAM_WEIGHT
		  Case "SUPPRESS_CONNECT_HEADERS"
		    Return SUPPRESS_CONNECT_HEADERS
		  Case "TCP_FASTOPEN"
		    Return TCP_FASTOPEN
		  Case "TCP_KEEPALIVE"
		    Return TCP_KEEPALIVE
		  Case "TCP_KEEPIDLE"
		    Return TCP_KEEPIDLE
		  Case "TCP_KEEPINTVL"
		    Return TCP_KEEPINTVL
		  Case "TCP_NODELAY"
		    Return TCP_NODELAY
		  Case "TELNETOPTIONS"
		    Return TELNETOPTIONS
		  Case "TFTP_BLKSIZE"
		    Return TFTP_BLKSIZE
		  Case "TFTP_NO_OPTIONS"
		    Return TFTP_NO_OPTIONS
		  Case "TIMECONDITION"
		    Return TIMECONDITION
		  Case "TIMEOUT"
		    Return TIMEOUT
		  Case "TIMEOUT_MS"
		    Return TIMEOUT_MS
		  Case "TIMEVALUE"
		    Return TIMEVALUE
		  Case "TIMEVALUE_LARGE"
		    Return TIMEVALUE_LARGE
		  Case "TLS13_CIPHERS"
		    Return TLS13_CIPHERS
		  Case "TLSAUTH_PASSWORD"
		    Return TLSAUTH_PASSWORD
		  Case "TLSAUTH_TYPE"
		    Return TLSAUTH_TYPE
		  Case "TLSAUTH_USERNAME"
		    Return TLSAUTH_USERNAME
		  Case "TRAILERDATA"
		    Return TRAILERDATA
		  Case "TRAILERFUNCTION"
		    Return TRAILERFUNCTION
		  Case "TRANSFERTEXT"
		    Return TRANSFERTEXT
		  Case "TRANSFER_ENCODING"
		    Return TRANSFER_ENCODING
		  Case "UNIX_SOCKET_PATH"
		    Return UNIX_SOCKET_PATH
		  Case "UNRESTRICTED_AUTH"
		    Return UNRESTRICTED_AUTH
		  Case "UPKEEP_INTERVAL_MS"
		    Return UPKEEP_INTERVAL_MS
		  Case "UPLOAD"
		    Return UPLOAD
		  Case "UPLOAD_BUFFERSIZE"
		    Return UPLOAD_BUFFERSIZE
		  Case "URL"
		    Return URL
		  Case "USERAGENT"
		    Return USERAGENT
		  Case "USERNAME"
		    Return USERNAME
		  Case "USERPWD"
		    Return USERPWD
		  Case "USE_SSL"
		    Return USE_SSL
		  Case "VERBOSE"
		    Return VERBOSE
		  Case "WILDCARDMATCH"
		    Return WILDCARDMATCH
		  Case "WRITEDATA"
		    Return WRITEDATA
		  Case "WRITEFUNCTION"
		    Return WRITEFUNCTION
		  Case "WS_OPTIONS"
		    Return WS_OPTIONS
		  Case "XFERINFODATA"
		    Return XFERINFODATA
		  Case "XFERINFOFUNCTION"
		    Return XFERINFOFUNCTION
		  Case "XOAUTH2_BEARER"
		    Return XOAUTH2_BEARER
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function GetOptionDefault(OptionID As Int32) As Variant
		  Select Case OptionID
		  Case ABSTRACT_UNIX_SOCKET
		    Return Nil
		  Case ACCEPTTIMEOUT_MS
		    Return 60000
		  Case ACCEPT_ENCODING
		    Return Nil
		  Case ADDRESS_SCOPE
		    Return 0
		  Case ALTSVC
		    Return Nil
		  Case ALTSVC_CTRL
		    Return 0
		  Case APPEND
		    Return 0
		  Case AUTOREFERER
		    Return 0
		  Case AWS_SIGV4
		    Return Nil
		  Case BUFFERSIZE
		    Return EasyHandle.CURL_MAX_WRITE_SIZE
		  Case CAINFO
		    Return Nil
		  Case CAPATH
		    Return Nil
		  Case CAINFO_BLOB
		    Return Nil
		  Case CERTINFO
		    Return 0
		  Case CHUNK_BGN_FUNCTION
		    Return Nil
		  Case CHUNK_DATA
		    Return Nil
		  Case CHUNK_END_FUNCTION
		    Return Nil
		  Case CLOSESOCKETDATA
		    Return Nil
		  Case CLOSESOCKETFUNCTION
		    Return Nil
		  Case CONNECTTIMEOUT
		    Return 300
		  Case CONNECTTIMEOUT_MS
		    Return 300000
		  Case CONNECT_ONLY
		    Return 0
		  Case CONNECT_TO
		    Return Nil
		  Case CONV_FROM_NETWORK_FUNCTION
		    Return Nil
		  Case CONV_FROM_UTF8_FUNCTION
		    Return Nil
		  Case CONV_TO_NETWORK_FUNCTION
		    Return Nil
		  Case COOKIE
		    Return Nil
		  Case COOKIEFILE
		    Return Nil
		  Case COOKIEJAR
		    Return Nil
		  Case COOKIELIST
		    Return Nil
		  Case COOKIESESSION
		    Return 0
		  Case COPYPOSTFIELDS
		    Return Nil
		  Case CRLF
		    Return 0
		  Case CRLFILE
		    Return Nil
		  Case CURLU
		    Return Nil
		  Case CUSTOMREQUEST
		    Return Nil
		  Case DEBUGDATA
		    Return Nil
		  Case DEBUGFUNCTION
		    Return Nil
		  Case DEFAULT_PROTOCOL
		    Return Nil
		  Case DIRLISTONLY
		    Return 0
		  Case DISALLOW_USERNAME_IN_URL
		    Return 0
		  Case DNS_CACHE_TIMEOUT
		    Return 60
		  Case DNS_INTERFACE
		    Return Nil
		  Case DNS_LOCAL_IP4
		    Return Nil
		  Case DNS_LOCAL_IP6
		    Return Nil
		  Case DNS_SERVERS
		    Return Nil
		  Case DNS_SHUFFLE_ADDRESSES
		    Return 0
		  Case DNS_USE_GLOBAL_CACHE
		    Return 0
		  Case DOH_SSL_VERIFYHOST
		    Return 2
		  Case DOH_SSL_VERIFYPEER
		    Return 1
		  Case DOH_SSL_VERIFYSTATUS
		    Return 0
		  Case DOH_URL
		    Return Nil
		  Case EGDSOCKET
		    Return Nil
		  Case ERRORBUFFER
		    Return Nil
		  Case EXPECT_100_TIMEOUT_MS
		    Return 1000
		  Case FAILONERROR
		    Return 0
		  Case FILETIME
		    Return 0
		  Case FNMATCH_DATA
		    Return Nil
		  Case FNMATCH_FUNCTION
		    Return Nil
		  Case FOLLOWLOCATION
		    Return 0
		  Case FORBID_REUSE
		    Return 0
		  Case FRESH_CONNECT
		    Return 0
		  Case FTPPORT
		    Return Nil
		  Case FTPSSLAUTH
		    Return 0
		  Case FTP_ACCOUNT
		    Return Nil
		  Case FTP_ALTERNATIVE_TO_USER
		    Return Nil
		  Case FTP_CREATE_MISSING_DIRS
		    Return 0
		  Case FTP_FILEMETHOD
		    Return CWDMethod.Multi
		  Case FTP_RESPONSE_TIMEOUT
		    Return 0
		  Case FTP_SKIP_PASV_IP
		    Return 0
		  Case FTP_SSL_CCC
		    Return 0
		  Case FTP_USE_EPRT
		    Return 0
		  Case FTP_USE_EPSV
		    Return 1
		  Case FTP_USE_PRET
		    Return 0
		  Case GSSAPI_DELEGATION
		    Return 0
		  Case HAPPY_EYEBALLS_TIMEOUT_MS
		    Return 200
		  Case HAPROXYPROTOCOL
		    Return 0
		  Case HEADER
		    Return 0
		  Case HEADERDATA
		    Return Nil
		  Case HEADERFUNCTION
		    Return Nil
		  Case HEADEROPT
		    Const CURLHEADER_UNIFIED = 0
		    Const CURLHEADER_SEPARATE = 1
		    If libcURL.Version.IsAtLeast(7, 42, 1) Then
		      Return CURLHEADER_UNIFIED
		    Else
		      Return CURLHEADER_SEPARATE
		    End If
		  Case HSTS
		    Return Nil
		  Case HSTSREADDATA
		    Return Nil
		  Case HSTSREADFUNCTION
		    Return Nil
		  Case HSTSWRITEDATA
		    Return Nil
		  Case HSTSWRITEFUNCTION
		    Return Nil
		  Case HSTS_CTRL
		    Return 0
		  Case HTTP09_ALLOWED
		    Return 0
		  Case HTTP200ALIASES
		    Return Nil
		  Case HTTPAUTH
		    Return CURLAUTH.BASIC
		  Case HTTPGET
		    Return 0
		  Case HTTPHEADER
		    Return Nil
		  Case HTTPPOST
		    Return Nil
		  Case HTTPPROXYTUNNEL
		    Return 0
		  Case HTTP_CONTENT_DECODING
		    Return 1
		  Case HTTP_TRANSFER_DECODING
		    Return 1
		  Case HTTP_VERSION
		    If libcURL.Version.IsAtLeast(7, 62, 0) And libcURL.IsFeatureAvailable(libcURL.FeatureType.HTTP2) Then
		      Return libcURL.HTTPVersion.HTTP2TLS
		    Else
		      Return libcURL.HTTPVersion.HTTP1_1
		    End If
		  Case IGNORE_CONTENT_LENGTH
		    Return 0
		  Case INFILESIZE
		    Return 0
		  Case INFILESIZE_LARGE
		    Return 0
		  Case NETINTERFACE
		    Return Nil
		  Case INTERLEAVEDATA
		    Return Nil
		  Case INTERLEAVEFUNCTION
		    Return Nil
		  Case IOCTLDATA
		    Return Nil
		  Case IOCTLFUNCTION
		    Return Nil
		  Case IPRESOLVE
		    Return libcURL.IPVersion.Whatever
		  Case ISSUERCERT
		    Return Nil
		  Case ISSUERCERT_BLOB
		    Return Nil
		  Case KEEP_SENDING_ON_ERROR
		    Return 0
		  Case KEYPASSWD
		    Return Nil
		  Case KRBLEVEL
		    Return Nil
		  Case LOCALPORT
		    Return 0
		  Case LOCALPORTRANGE
		    Return 1
		  Case LOGIN_OPTIONS
		    Return Nil
		  Case LOW_SPEED_LIMIT
		    Return 0
		  Case LOW_SPEED_TIME
		    Return 0
		  Case MAIL_AUTH
		    Return Nil
		  Case MAIL_FROM
		    Return Nil
		  Case MAIL_RCPT
		    Return Nil
		  Case MAIL_RCPT_ALLLOWFAILS
		    Return 0
		  Case MAXAGE_CONN
		    Return 118
		  Case MAXCONNECTS
		    Return 5
		  Case MAXFILESIZE
		    Return 0
		  Case MAXFILESIZE_LARGE
		    Return 0
		  Case MAXREDIRS
		    Return -1
		  Case MAXLIFETIME_CONN
		    Return 0
		  Case MAX_RECV_SPEED_LARGE
		    Return 0
		  Case MAX_SEND_SPEED_LARGE
		    Return 0
		  Case MIME_OPTIONS
		    Return 0
		  Case NETRC
		    Return 0
		  Case NETRC_FILE
		    Return Nil
		  Case NEW_DIRECTORY_PERMS
		    Return &o0755
		  Case NEW_FILE_PERMS
		    Return &o0644
		  Case NOBODY
		    Return 0
		  Case NOPROGRESS
		    Return 1
		  Case NOPROXY
		    Return Nil
		  Case NOSIGNAL
		    Return 0
		  Case OPENSOCKETDATA
		    Return Nil
		  Case OPENSOCKETFUNCTION
		    Return Nil
		  Case PASSWORD
		    Return Nil
		  Case PATH_AS_IS
		    Return 0
		  Case PINNEDPUBLICKEY
		    Return Nil
		  Case PIPEWAIT
		    Return 0
		  Case PORT
		    Return 0
		  Case POST
		    Return 0
		  Case POSTFIELDS
		    Return Nil
		  Case POSTFIELDSIZE
		    Return -1
		  Case POSTFIELDSIZE_LARGE
		    Return -1
		  Case POSTQUOTE
		    Return Nil
		  Case POSTREDIR
		    Return 0
		  Case PREREQDATA
		    Return Nil
		  Case PREREQFUNCTION
		    Return Nil
		  Case PREQUOTE
		    Return Nil
		  Case PRE_PROXY
		    Return Nil
		  Case PRIVATE_
		    Return Nil
		  Case PROGRESSDATA
		    Return Nil
		  Case PROGRESSFUNCTION
		    Return Nil
		  Case PROTOCOLS
		    Return 0
		  Case PROTOCOLS_STR
		    Return ""
		  Case PROXY
		    Return Nil
		  Case PROXYAUTH
		    Return CURLAUTH.BASIC
		  Case PROXYHEADER
		    Return Nil
		  Case PROXYPASSWORD
		    Return Nil
		  Case PROXYPORT
		    Return 0
		  Case PROXYTYPE
		    Return libcURL.ProxyType.HTTP
		  Case PROXYUSERNAME
		    Return Nil
		  Case PROXYUSERPWD
		    Return Nil
		  Case PROXY_CAINFO
		    Return Nil
		  Case PROXY_CAINFO_BLOB
		    Return Nil
		  Case PROXY_CAPATH
		    Return Nil
		  Case PROXY_CRLFILE
		    Return Nil
		  Case PROXY_ISSUERCERT
		    Return Nil
		  Case PROXY_ISSUERCERT_BLOB
		    Return Nil
		  Case PROXY_KEYPASSWD
		    Return Nil
		  Case PROXY_PINNEDPUBLICKEY
		    Return Nil
		  Case PROXY_SERVICE_NAME
		    Return Nil
		  Case PROXY_SSLCERT
		    Return Nil
		  Case PROXY_SSLCERTTYPE
		    Return "PEM"
		  Case PROXY_SSLCERT_BLOB
		    Return Nil
		  Case PROXY_SSLKEY
		    Return Nil
		  Case PROXY_SSLKEY_BLOB
		    Return Nil
		  Case PROXY_SSLVERSION
		    Return libcURL.SSLVersion.Default
		  Case PROXY_SSL_CIPHER_LIST
		    Return Nil
		  Case PROXY_SSL_OPTIONS
		    Return 0
		  Case PROXY_SSL_VERIFYHOST
		    Return 2
		  Case PROXY_SSL_VERIFYPEER
		    Return 1
		  Case PROXY_TLS13_CIPHERS
		    Return Nil
		  Case PROXY_TLSAUTH_PASSWORD
		    Return Nil
		  Case PROXY_TLSAUTH_TYPE
		    Return Nil
		  Case PROXY_TLSAUTH_USERNAME
		    Return Nil
		  Case PROXY_TRANSFER_MODE
		    Return 0
		  Case PUT
		    Return 0
		  Case QUOTE
		    Return Nil
		  Case RANDOM_FILE
		    Return Nil
		  Case RANGE
		    Return Nil
		  Case READDATA
		    Return Nil
		  Case READFUNCTION
		    Return Nil
		  Case REDIR_PROTOCOLS
		    Return libcURL.Protocols.HTTP Or libcURL.Protocols.HTTPS Or libcURL.Protocols.FTP Or libcURL.Protocols.FTPS
		  Case REDIR_PROTOCOLS_STR
		    Return "http,https,ftp,ftps"
		  Case REFERER
		    Return Nil
		  Case REQUEST_TARGET
		    Return Nil
		  Case RESOLVE
		    Return Nil
		  Case RESOLVER_START_DATA
		    Return Nil
		  Case RESOLVER_START_FUNCTION
		    Return Nil
		  Case RESUME_FROM
		    Return 0
		  Case RESUME_FROM_LARGE
		    Return 0
		  Case RTSP_CLIENT_CSEQ
		    Return 0
		  Case RTSP_REQUEST
		    Return 0
		  Case RTSP_SERVER_CSEQ
		    Return 0
		  Case RTSP_SESSION_ID
		    Return Nil
		  Case RTSP_STREAM_URI
		    Return "'*'"
		  Case RTSP_TRANSPORT
		    Return Nil
		  Case SASL_AUTHZID
		    Return Nil
		  Case SASL_IR
		    Return 0
		  Case SEEKDATA
		    Return Nil
		  Case SEEKFUNCTION
		    Return Nil
		  Case SERVICE_NAME
		    Return Nil
		  Case SHARE
		    Return Nil
		  Case SOCKOPTDATA
		    Return Nil
		  Case SOCKOPTFUNCTION
		    Return Nil
		  Case SOCKS5_AUTH
		    Return CURLAUTH.BASIC
		  Case SOCKS5_GSSAPI_NEC
		    Return 0
		  Case SOCKS5_GSSAPI_SERVICE
		    Return Nil
		  Case SSH_AUTH_TYPES
		    Return 0
		  Case SSH_COMPRESSION
		    Return 0
		  Case SSH_HOST_PUBLIC_KEY_MD5
		    Return Nil
		  Case SSH_HOST_PUBLIC_KEY_SHA256
		    Return Nil
		  Case SSH_HOSTKEYDATA
		    Return Nil
		  Case SSH_HOSTKEYFUNCTION
		    Return Nil
		  Case SSH_KEYDATA
		    Return Nil
		  Case SSH_KEYFUNCTION
		    Return Nil
		  Case SSH_KNOWNHOSTS
		    Return Nil
		  Case SSH_PRIVATE_KEYFILE
		    Return Nil
		  Case SSH_PUBLIC_KEYFILE
		    Return Nil
		  Case SSLCERT
		    Return Nil
		  Case SSLCERTTYPE
		    Return "PEM"
		  Case SSLCERT_BLOB
		    Return Nil
		  Case SSLENGINE
		    Return Nil
		  Case SSLENGINE_DEFAULT
		    Return 0
		  Case SSLKEY
		    Return Nil
		  Case SSLKEYTYPE
		    Return "PEM"
		  Case SSLKEY_BLOB
		    Return Nil
		  Case SSLVERSION
		    Return libcURL.SSLVersion.Default
		  Case SSL_CIPHER_LIST
		    Return Nil
		  Case SSL_CTX_DATA
		    Return Nil
		  Case SSL_CTX_FUNCTION
		    Return Nil
		  Case SSL_EC_CURVES
		    Return ""
		  Case SSL_ENABLE_ALPN
		    Return 1
		  Case SSL_ENABLE_NPN
		    Return 1
		  Case SSL_FALSESTART
		    Return 0
		  Case SSL_OPTIONS
		    Return 0
		  Case SSL_SESSIONID_CACHE
		    Return 1
		  Case SSL_VERIFYHOST
		    Return 2
		  Case SSL_VERIFYPEER
		    Return 1
		  Case SSL_VERIFYSTATUS
		    Return 0
		  Case STDERR
		    Return Nil
		  Case STREAM_DEPENDS
		    Return Nil
		  Case STREAM_DEPENDS_E
		    Return Nil
		  Case STREAM_WEIGHT
		    Return 16
		  Case SUPPRESS_CONNECT_HEADERS
		    Return 0
		  Case TCP_FASTOPEN
		    Return 0
		  Case TCP_KEEPALIVE
		    Return 0
		  Case TCP_KEEPIDLE
		    Return 60
		  Case TCP_KEEPINTVL
		    Return 60
		  Case TCP_NODELAY
		    Return 1
		  Case TELNETOPTIONS
		    Return Nil
		  Case TFTP_BLKSIZE
		    Return 512
		  Case TFTP_NO_OPTIONS
		    Return 0
		  Case TIMECONDITION
		    Return 0
		  Case TIMEOUT
		    Return 0
		  Case TIMEOUT_MS
		    Return 0
		  Case TIMEVALUE
		    Return 0
		  Case TIMEVALUE_LARGE
		    Return 0
		  Case TLS13_CIPHERS
		    Return Nil
		  Case TLSAUTH_PASSWORD
		    Return Nil
		  Case TLSAUTH_TYPE
		    Return Nil
		  Case TLSAUTH_USERNAME
		    Return Nil
		  Case TRAILERDATA
		    Return Nil
		  Case TRAILERFUNCTION
		    Return Nil
		  Case TRANSFERTEXT
		    Return 0
		  Case TRANSFER_ENCODING
		    Return 0
		  Case UNIX_SOCKET_PATH
		    Return 0
		  Case UNRESTRICTED_AUTH
		    Return 0
		  Case UPKEEP_INTERVAL_MS
		    Return 60000
		  Case UPLOAD
		    Return 0
		  Case UPLOAD_BUFFERSIZE
		    Return 65535
		  Case URL
		    Return Nil
		  Case USERAGENT
		    Return Nil
		  Case USERNAME
		    Return Nil
		  Case USERPWD
		    Return Nil
		  Case USE_SSL
		    Return libcURL.ConnectionType.NoSSL
		  Case VERBOSE
		    Return 0
		  Case WRITEDATA
		    Return Nil
		  Case WRITEFUNCTION
		    Return Nil
		  Case WS_OPTIONS
		    Return 0
		  Case XFERINFODATA
		    Return Nil
		  Case XFERINFOFUNCTION
		    Return Nil
		  Case XOAUTH2_BEARER
		    Return Nil
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function GetOptionFirstVersion(OptionID As Int32, ByRef Major As Integer, ByRef Minor As Integer, ByRef Patch As Integer) As Boolean
		  Dim tmp As String
		  Select Case OptionID
		  Case ABSTRACT_UNIX_SOCKET
		    tmp = "7.53.0"
		  Case ACCEPTTIMEOUT_MS
		    tmp = "7.24.0"
		  Case ACCEPT_ENCODING
		    tmp = "7.21.6"
		  Case ADDRESS_SCOPE
		    tmp = "7.19.0"
		  Case ALTSVC
		    tmp = "7.64.1"
		  Case ALTSVC_CTRL
		    tmp = "7.64.1"
		  Case APPEND
		    tmp = "7.17.0"
		  Case AUTOREFERER
		    tmp = "7.1"
		  Case BUFFERSIZE
		    tmp = "7.10"
		  Case CAINFO
		    tmp = "7.4.2"
		  Case CAINFO_BLOB
		    tmp = "7.77.0"
		  Case CAPATH
		    tmp = "7.9.8"
		  Case CERTINFO
		    tmp = "7.19.1"
		  Case CHUNK_BGN_FUNCTION
		    tmp = "7.21.0"
		  Case CHUNK_DATA
		    tmp = "7.21.0"
		  Case CHUNK_END_FUNCTION
		    tmp = "7.21.0"
		  Case CLOSESOCKETDATA
		    tmp = "7.21.7"
		  Case CLOSESOCKETFUNCTION
		    tmp = "7.21.7"
		  Case CONNECTTIMEOUT
		    tmp = "7.7"
		  Case CONNECTTIMEOUT_MS
		    tmp = "7.16.2"
		  Case CONNECT_ONLY
		    tmp = "7.15.2"
		  Case CONNECT_TO
		    tmp = "7.49.0"
		  Case CONV_FROM_NETWORK_FUNCTION
		    tmp = "7.15.4"
		  Case CONV_FROM_UTF8_FUNCTION
		    tmp = "7.15.4"
		  Case CONV_TO_NETWORK_FUNCTION
		    tmp = "7.15.4"
		  Case COOKIE
		    tmp = "7.1"
		  Case COOKIEFILE
		    tmp = "7.1"
		  Case COOKIEJAR
		    tmp = "7.9"
		  Case COOKIELIST
		    tmp = "7.14.1"
		  Case COOKIESESSION
		    tmp = "7.9.7"
		  Case COPYPOSTFIELDS
		    tmp = "7.17.1"
		  Case CRLF
		    tmp = "7.1"
		  Case CRLFILE
		    tmp = "7.19.0"
		  Case CURLU
		    tmp = "7.63.0"
		  Case CUSTOMREQUEST
		    tmp = "7.1"
		  Case DEBUGDATA
		    tmp = "7.9.6"
		  Case DEBUGFUNCTION
		    tmp = "7.9.6"
		  Case DEFAULT_PROTOCOL
		    tmp = "7.45.0"
		  Case DIRLISTONLY
		    tmp = "7.17.0"
		  Case DISALLOW_USERNAME_IN_URL
		    tmp = "7.61.0"
		  Case DNS_CACHE_TIMEOUT
		    tmp = "7.9.3"
		  Case DNS_INTERFACE
		    tmp = "7.33.0"
		  Case DNS_LOCAL_IP4
		    tmp = "7.33.0"
		  Case DNS_LOCAL_IP6
		    tmp = "7.33.0"
		  Case DNS_SERVERS
		    tmp = "7.24.0"
		  Case DNS_SHUFFLE_ADDRESSES
		    tmp = "7.60.0"
		  Case DNS_USE_GLOBAL_CACHE
		    tmp = "7.9.3"
		  Case DOH_SSL_VERIFYHOST
		    tmp = "7.76.0"
		  Case DOH_SSL_VERIFYPEER
		    tmp = "7.76.0"
		  Case DOH_SSL_VERIFYSTATUS
		    tmp = "7.76.0"
		  Case DOH_URL
		    tmp = "7.62.0"
		  Case EGDSOCKET
		    tmp = "7.7"
		  Case ERRORBUFFER
		    tmp = "7.1"
		  Case EXPECT_100_TIMEOUT_MS
		    tmp = "7.36.0"
		  Case FAILONERROR
		    tmp = "7.1"
		  Case FILETIME
		    tmp = "7.5"
		  Case FNMATCH_DATA
		    tmp = "7.21.0"
		  Case FNMATCH_FUNCTION
		    tmp = "7.21.0"
		  Case FOLLOWLOCATION
		    tmp = "7.1"
		  Case FORBID_REUSE
		    tmp = "7.7"
		  Case FRESH_CONNECT
		    tmp = "7.7"
		  Case FTPPORT
		    tmp = "7.1"
		  Case FTPSSLAUTH
		    tmp = "7.12.2"
		  Case FTP_ACCOUNT
		    tmp = "7.13.0"
		  Case FTP_ALTERNATIVE_TO_USER
		    tmp = "7.15.5"
		  Case FTP_CREATE_MISSING_DIRS
		    tmp = "7.10.7"
		  Case FTP_FILEMETHOD
		    tmp = "7.15.1"
		  Case FTP_RESPONSE_TIMEOUT
		    tmp = "7.10.8"
		  Case FTP_SKIP_PASV_IP
		    tmp = "7.15.0"
		  Case FTP_SSL_CCC
		    tmp = "7.16.1"
		  Case FTP_USE_EPRT
		    tmp = "7.10.5"
		  Case FTP_USE_EPSV
		    tmp = "7.9.2"
		  Case FTP_USE_PRET
		    tmp = "7.20.0"
		  Case GSSAPI_DELEGATION
		    tmp = "7.22.0"
		  Case HAPPY_EYEBALLS_TIMEOUT_MS
		    tmp = "7.59.0"
		  Case HAPROXYPROTOCOL
		    tmp = "7.60.0"
		  Case HEADER
		    tmp = "7.1"
		  Case HEADERDATA
		    tmp = "7.10"
		  Case HEADERFUNCTION
		    tmp = "7.7.2"
		  Case HEADEROPT
		    tmp = "7.37.0"
		  Case HSTS
		    tmp = "7.74.0"
		  Case HSTS_CTRL
		    tmp = "7.74.0"
		  Case HSTSREADDATA
		    tmp = "7.74.0"
		  Case HSTSREADFUNCTION
		    tmp = "7.74.0"
		  Case HSTSWRITEDATA
		    tmp = "7.74.0"
		  Case HSTSWRITEFUNCTION
		    tmp = "7.74.0"
		  Case HTTP09_ALLOWED
		    tmp = "7.64.0"
		  Case HTTP200ALIASES
		    tmp = "7.10.3"
		  Case HTTPAUTH
		    tmp = "7.10.6"
		  Case HTTPGET
		    tmp = "7.8.1"
		  Case HTTPHEADER
		    tmp = "7.1"
		  Case HTTPPOST
		    tmp = "7.1"
		  Case HTTPPROXYTUNNEL
		    tmp = "7.3"
		  Case HTTP_CONTENT_DECODING
		    tmp = "7.16.2"
		  Case HTTP_TRANSFER_DECODING
		    tmp = "7.16.2"
		  Case HTTP_VERSION
		    tmp = "7.9.1"
		  Case IGNORE_CONTENT_LENGTH
		    tmp = "7.14.1"
		  Case INFILESIZE
		    tmp = "7.1"
		  Case INFILESIZE_LARGE
		    tmp = "7.11.0"
		  Case NETINTERFACE ' actual name is INTERFACE, but that's a reserved word
		    tmp = "7.3"
		  Case INTERLEAVEDATA
		    tmp = "7.20.0"
		  Case INTERLEAVEFUNCTION
		    tmp = "7.20.0"
		  Case IOCTLDATA
		    tmp = "7.12.3"
		  Case IOCTLFUNCTION
		    tmp = "7.12.3"
		  Case IPRESOLVE
		    tmp = "7.10.8"
		  Case ISSUERCERT
		    tmp = "7.19.0"
		  Case ISSUERCERT_BLOB
		    tmp = "7.71.0"
		  Case KEEP_SENDING_ON_ERROR
		    tmp = "7.51.0"
		  Case KEYPASSWD
		    tmp = "7.17.0"
		  Case KRBLEVEL
		    tmp = "7.16.4"
		  Case LOCALPORT
		    tmp = "7.15.2"
		  Case LOCALPORTRANGE
		    tmp = "7.15.2"
		  Case LOGIN_OPTIONS
		    tmp = "7.34.0"
		  Case LOW_SPEED_LIMIT
		    tmp = "7.1"
		  Case LOW_SPEED_TIME
		    tmp = "7.1"
		  Case MAIL_AUTH
		    tmp = "7.25.0"
		  Case MAIL_FROM
		    tmp = "7.20.0"
		  Case MAIL_RCPT
		    tmp = "7.20.0"
		  Case MAIL_RCPT_ALLLOWFAILS
		    tmp = "7.69.0"
		  Case MAXAGE_CONN
		    tmp = "7.65.0"
		  Case MAXCONNECTS
		    tmp = "7.7"
		  Case MAXFILESIZE
		    tmp = "7.10.8"
		  Case MAXFILESIZE_LARGE
		    tmp = "7.11.0"
		  Case MAXLIFETIME_CONN
		    tmp = "7.80.0"
		  Case MAXREDIRS
		    tmp = "7.5"
		  Case MAX_RECV_SPEED_LARGE
		    tmp = "7.15.5"
		  Case MAX_SEND_SPEED_LARGE
		    tmp = "7.15.5"
		  Case MIMEPOST
		    tmp = "7.56.0"
		  Case MIME_OPTIONS
		    tmp = "7.81.0"
		  Case NETRC
		    tmp = "7.1"
		  Case NETRC_FILE
		    tmp = "7.11.0"
		  Case NEW_DIRECTORY_PERMS
		    tmp = "7.16.4"
		  Case NEW_FILE_PERMS
		    tmp = "7.16.4"
		  Case NOBODY
		    tmp = "7.1"
		  Case NOPROGRESS
		    tmp = "7.1"
		  Case NOPROXY
		    tmp = "7.19.4"
		  Case NOSIGNAL
		    tmp = "7.10"
		  Case OPENSOCKETDATA
		    tmp = "7.17.1"
		  Case OPENSOCKETFUNCTION
		    tmp = "7.17.1"
		  Case PASSWORD
		    tmp = "7.19.1"
		  Case PATH_AS_IS
		    tmp = "7.42.0"
		  Case PINNEDPUBLICKEY
		    tmp = "7.39.0"
		  Case PIPEWAIT
		    tmp = "7.43.0"
		  Case PORT
		    tmp = "7.1"
		  Case POST
		    tmp = "7.1"
		  Case POSTFIELDS
		    tmp = "7.1"
		  Case POSTFIELDSIZE
		    tmp = "7.2"
		  Case POSTFIELDSIZE_LARGE
		    tmp = "7.11.1"
		  Case POSTQUOTE
		    tmp = "7.1"
		  Case POSTREDIR
		    tmp = "7.19.1"
		  Case PREQUOTE
		    tmp = "7.9.5"
		  Case PREREQDATA
		    tmp = "7.80.0"
		  Case PREREQFUNCTION
		    tmp = "7.80.0"
		  Case PRE_PROXY
		    tmp = "7.52.0"
		  Case PRIVATE_
		    tmp = "7.10.3"
		  Case PROGRESSDATA
		    tmp = "7.1"
		  Case PROGRESSFUNCTION
		    tmp = "7.1"
		  Case PROTOCOLS
		    tmp = "7.19.4"
		  Case PROTOCOLS_STR
		    tmp = "7.85.0"
		  Case PROXY
		    tmp = "7.1"
		  Case PROXYAUTH
		    tmp = "7.10.7"
		  Case PROXYHEADER
		    tmp = "7.37.0"
		  Case PROXYPASSWORD
		    tmp = "7.19.1"
		  Case PROXYPORT
		    tmp = "7.1"
		  Case PROXYTYPE
		    tmp = "7.10"
		  Case PROXYUSERNAME
		    tmp = "7.19.1"
		  Case PROXYUSERPWD
		    tmp = "7.1"
		  Case PROXY_CAINFO
		    tmp = "7.52.0"
		  Case PROXY_CAINFO_BLOB
		    tmp = "7.77.0"
		  Case PROXY_CAPATH
		    tmp = "7.52.0"
		  Case PROXY_CRLFILE
		    tmp = "7.52.0"
		  Case PROXY_ISSUERCERT
		    tmp = "7.71.0"
		  Case PROXY_ISSUERCERT_BLOB
		    tmp = "7.71.0"
		  Case PROXY_KEYPASSWD
		    tmp = "7.52.0"
		  Case PROXY_PINNEDPUBLICKEY
		    tmp = "7.52.0"
		  Case PROXY_SERVICE_NAME
		    tmp = "7.43.0"
		  Case PROXY_SSLCERT
		    tmp = "7.52.0"
		  Case PROXY_SSLCERTTYPE
		    tmp = "7.52.0"
		  Case PROXY_SSLCERT_BLOB
		    tmp = "7.71.0"
		  Case PROXY_SSLKEY
		    tmp = "7.52.0"
		  Case PROXY_SSLKEYTYPE
		    tmp = "7.52.0"
		  Case PROXY_SSLKEY_BLOB
		    tmp = "7.71.0"
		  Case PROXY_SSLVERSION
		    tmp = "7.52.0"
		  Case PROXY_SSL_CIPHER_LIST
		    tmp = "7.52.0"
		  Case PROXY_SSL_OPTIONS
		    tmp = "7.52.0"
		  Case PROXY_SSL_VERIFYHOST
		    tmp = "7.52.0"
		  Case PROXY_SSL_VERIFYPEER
		    tmp = "7.52.0"
		  Case PROXY_TLS13_CIPHERS
		    tmp = "7.61.0"
		  Case PROXY_TLSAUTH_PASSWORD
		    tmp = "7.52.0"
		  Case PROXY_TLSAUTH_TYPE
		    tmp = "7.52.0"
		  Case PROXY_TLSAUTH_USERNAME
		    tmp = "7.52.0"
		  Case PROXY_TRANSFER_MODE
		    tmp = "7.18.0"
		  Case PUT
		    tmp = "7.1"
		  Case QUOTE
		    tmp = "7.1"
		  Case RANDOM_FILE
		    tmp = "7.7"
		  Case RANGE
		    tmp = "7.1"
		  Case READDATA
		    tmp = "7.9.7"
		  Case READFUNCTION
		    tmp = "7.1"
		  Case REDIR_PROTOCOLS
		    tmp = "7.19.4"
		  Case REDIR_PROTOCOLS_STR
		    tmp = "7.85.0"
		  Case REFERER
		    tmp = "7.1"
		  Case REQUEST_TARGET
		    tmp = "7.55.0"
		  Case RESOLVE
		    tmp = "7.21.3"
		  Case RESOLVER_START_DATA
		    tmp = "7.59.0"
		  Case RESOLVER_START_FUNCTION
		    tmp = "7.59.0"
		  Case RESUME_FROM
		    tmp = "7.1"
		  Case RESUME_FROM_LARGE
		    tmp = "7.11.0"
		  Case RTSP_CLIENT_CSEQ
		    tmp = "7.20.0"
		  Case RTSP_REQUEST
		    tmp = "7.20.0"
		  Case RTSP_SERVER_CSEQ
		    tmp = "7.20.0"
		  Case RTSP_SESSION_ID
		    tmp = "7.20.0"
		  Case RTSP_STREAM_URI
		    tmp = "7.20.0"
		  Case RTSP_TRANSPORT
		    tmp = "7.20.0"
		  Case SASL_AUTHZID
		    tmp = "7.66.0"
		  Case SASL_IR
		    tmp = "7.31.0"
		  Case SEEKDATA
		    tmp = "7.18.0"
		  Case SEEKFUNCTION
		    tmp = "7.18.0"
		  Case SERVICE_NAME
		    tmp = "7.43.0"
		  Case SHARE
		    tmp = "7.10"
		  Case SOCKOPTDATA
		    tmp = "7.16.0"
		  Case SOCKOPTFUNCTION
		    tmp = "7.16.0"
		  Case SOCKS5_AUTH
		    tmp = "7.55.0"
		  Case SOCKS5_GSSAPI_NEC
		    tmp = "7.19.4"
		  Case SOCKS5_GSSAPI_SERVICE
		    tmp = "7.19.4"
		  Case SSH_AUTH_TYPES
		    tmp = "7.16.1"
		  Case SSH_COMPRESSION
		    tmp = "7.56.0"
		  Case SSH_HOST_PUBLIC_KEY_MD5
		    tmp = "7.17.1"
		  Case SSH_HOST_PUBLIC_KEY_SHA256
		    tmp = "7.80.0"
		  Case SSH_HOSTKEYDATA
		    tmp = "7.84.0"
		  Case SSH_HOSTKEYFUNCTION
		    tmp = "7.84.0"
		  Case SSH_KEYDATA
		    tmp = "7.19.6"
		  Case SSH_KEYFUNCTION
		    tmp = "7.19.6"
		  Case SSH_KNOWNHOSTS
		    tmp = "7.19.6"
		  Case SSH_PRIVATE_KEYFILE
		    tmp = "7.16.1"
		  Case SSH_PUBLIC_KEYFILE
		    tmp = "7.16.1"
		  Case SSLCERT
		    tmp = "7.1"
		  Case SSLCERTTYPE
		    tmp = "7.9.3"
		  Case SSLCERT_BLOB
		    tmp = "7.71.0"
		  Case SSLENGINE
		    tmp = "7.9.3"
		  Case SSLENGINE_DEFAULT
		    tmp = "7.9.3"
		  Case SSLKEY
		    tmp = "7.9.3"
		  Case SSLKEYTYPE
		    tmp = "7.9.3"
		  Case SSLKEY_BLOB
		    tmp = "7.71.0"
		  Case SSLVERSION
		    tmp = "7.1"
		  Case SSL_CIPHER_LIST
		    tmp = "7.9"
		  Case SSL_CTX_DATA
		    tmp = "7.10.6"
		  Case SSL_CTX_FUNCTION
		    tmp = "7.10.6"
		  Case SSL_EC_CURVES
		    tmp = "7.73.0"
		  Case SSL_ENABLE_ALPN
		    tmp = "7.36.0"
		  Case SSL_ENABLE_NPN
		    tmp = "7.36.0"
		  Case SSL_FALSESTART
		    tmp = "7.42.0"
		  Case SSL_OPTIONS
		    tmp = "7.25.0"
		  Case SSL_SESSIONID_CACHE
		    tmp = "7.16.0"
		  Case SSL_VERIFYHOST
		    tmp = "7.8.1"
		  Case SSL_VERIFYPEER
		    tmp = "7.4.2"
		  Case SSL_VERIFYSTATUS
		    tmp = "7.41.0"
		  Case STDERR
		    tmp = "7.1"
		  Case STREAM_DEPENDS
		    tmp = "7.46.0"
		  Case STREAM_DEPENDS_E
		    tmp = "7.46.0"
		  Case STREAM_WEIGHT
		    tmp = "7.46.0"
		  Case SUPPRESS_CONNECT_HEADERS
		    tmp = "7.54.0"
		  Case TCP_FASTOPEN
		    tmp = "7.49.0"
		  Case TCP_KEEPALIVE
		    tmp = "7.25.0"
		  Case TCP_KEEPIDLE
		    tmp = "7.25.0"
		  Case TCP_KEEPINTVL
		    tmp = "7.25.0"
		  Case TCP_NODELAY
		    tmp = "7.11.2"
		  Case TELNETOPTIONS
		    tmp = "7.7"
		  Case TFTP_BLKSIZE
		    tmp = "7.19.4"
		  Case TFTP_NO_OPTIONS
		    tmp = "7.48.0"
		  Case TIMECONDITION
		    tmp = "7.1"
		  Case TIMEOUT
		    tmp = "7.1"
		  Case TIMEOUT_MS
		    tmp = "7.16.2"
		  Case TIMEVALUE
		    tmp = "7.1"
		  Case TIMEVALUE_LARGE
		    tmp = "7.59.0"
		  Case TLS13_CIPHERS
		    tmp = "7.61.0"
		  Case TLSAUTH_PASSWORD
		    tmp = "7.21.4"
		  Case TLSAUTH_TYPE
		    tmp = "7.21.4"
		  Case TLSAUTH_USERNAME
		    tmp = "7.21.4"
		  Case TRAILERDATA
		    tmp = "7.64.0"
		  Case TRAILERFUNCTION
		    tmp = "7.64.0"
		  Case TRANSFERTEXT
		    tmp = "7.1.1"
		  Case TRANSFER_ENCODING
		    tmp = "7.21.6"
		  Case UNIX_SOCKET_PATH
		    tmp = "7.40.0"
		  Case UNRESTRICTED_AUTH
		    tmp = "7.10.4"
		  Case UPKEEP_INTERVAL_MS
		    tmp = "7.62.0"
		  Case UPLOAD
		    tmp = "7.1"
		  Case UPLOAD_BUFFERSIZE
		    tmp = "7.62.0"
		  Case URL
		    tmp = "7.1"
		  Case USERAGENT
		    tmp = "7.1"
		  Case USERNAME
		    tmp = "7.19.1"
		  Case USERPWD
		    tmp = "7.1"
		  Case USE_SSL
		    tmp = "7.17.0"
		  Case AWS_SIGV4
		    tmp = "7.75.0"
		  Case VERBOSE
		    tmp = "7.1"
		  Case WILDCARDMATCH
		    tmp = "7.21.0"
		  Case WRITEDATA
		    tmp = "7.9.7"
		  Case WRITEFUNCTION
		    tmp = "7.1"
		  Case WS_OPTIONS
		    tmp = "7.86.0"
		  Case XFERINFODATA
		    tmp = "7.32.0"
		  Case XFERINFOFUNCTION
		    tmp = "7.32.0"
		  Case XOAUTH2_BEARER
		    tmp = "7.33.0"
		  End Select
		  If tmp <> "" Then
		    Major = Val(NthField(tmp, ".", 1))
		    Minor = Val(NthField(tmp, ".", 2))
		    Patch = Val(NthField(tmp, ".", 3))
		    Return True
		  Else
		    Major = -1
		    Minor = -1
		    Patch = -1
		    Return False
		  End If
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function GetOptionName(OptionID As Int32) As String
		  Select Case OptionID
		  Case ABSTRACT_UNIX_SOCKET
		    Return "ABSTRACT_UNIX_SOCKET"
		  Case ACCEPTTIMEOUT_MS
		    Return "ACCEPTTIMEOUT_MS"
		  Case ACCEPT_ENCODING
		    Return "ACCEPT_ENCODING"
		  Case ADDRESS_SCOPE
		    Return "ADDRESS_SCOPE"
		  Case ALTSVC
		    Return "ALTSVC"
		  Case ALTSVC_CTRL
		    Return "ALTSVC_CTRL"
		  Case APPEND
		    Return "APPEND"
		  Case AUTOREFERER
		    Return "AUTOREFERER"
		  Case AWS_SIGV4
		    Return "AWS_SIGV4"
		  Case BUFFERSIZE
		    Return "BUFFERSIZE"
		  Case CAINFO
		    Return "CAINFO"
		  Case CAPATH
		    Return "CAPATH"
		  Case CAINFO_BLOB
		    Return "CAINFO_BLOB"
		  Case CERTINFO
		    Return "CERTINFO"
		  Case CHUNK_BGN_FUNCTION
		    Return "CHUNK_BGN_FUNCTION"
		  Case CHUNK_DATA
		    Return "CHUNK_DATA"
		  Case CHUNK_END_FUNCTION
		    Return "CHUNK_END_FUNCTION"
		  Case CLOSESOCKETDATA
		    Return "CLOSESOCKETDATA"
		  Case CLOSESOCKETFUNCTION
		    Return "CLOSESOCKETFUNCTION"
		  Case CONNECTTIMEOUT
		    Return "CONNECTTIMEOUT"
		  Case CONNECTTIMEOUT_MS
		    Return "CONNECTTIMEOUT_MS"
		  Case CONNECT_ONLY
		    Return "CONNECT_ONLY"
		  Case CONNECT_TO
		    Return "CONNECT_TO"
		  Case CONV_FROM_NETWORK_FUNCTION
		    Return "CONV_FROM_NETWORK_FUNCTION"
		  Case CONV_FROM_UTF8_FUNCTION
		    Return "CONV_FROM_UTF8_FUNCTION"
		  Case CONV_TO_NETWORK_FUNCTION
		    Return "CONV_TO_NETWORK_FUNCTION"
		  Case COOKIE
		    Return "COOKIE"
		  Case COOKIEFILE
		    Return "COOKIEFILE"
		  Case COOKIEJAR
		    Return "COOKIEJAR"
		  Case COOKIELIST
		    Return "COOKIELIST"
		  Case COOKIESESSION
		    Return "COOKIESESSION"
		  Case COPYPOSTFIELDS
		    Return "COPYPOSTFIELDS"
		  Case CRLF
		    Return "CRLF"
		  Case CRLFILE
		    Return "CRLFILE"
		  Case CURLU
		    Return "CURLU"
		  Case CUSTOMREQUEST
		    Return "CUSTOMREQUEST"
		  Case DEBUGDATA
		    Return "DEBUGDATA"
		  Case DEBUGFUNCTION
		    Return "DEBUGFUNCTION"
		  Case DEFAULT_PROTOCOL
		    Return "DEFAULT_PROTOCOL"
		  Case DIRLISTONLY
		    Return "DIRLISTONLY"
		  Case DISALLOW_USERNAME_IN_URL
		    Return "DISALLOW_USERNAME_IN_URL"
		  Case DNS_CACHE_TIMEOUT
		    Return "DNS_CACHE_TIMEOUT"
		  Case DNS_INTERFACE
		    Return "DNS_INTERFACE"
		  Case DNS_LOCAL_IP4
		    Return "DNS_LOCAL_IP4"
		  Case DNS_LOCAL_IP6
		    Return "DNS_LOCAL_IP6"
		  Case DNS_SERVERS
		    Return "DNS_SERVERS"
		  Case DNS_SHUFFLE_ADDRESSES
		    Return "DNS_SHUFFLE_ADDRESSES"
		  Case DNS_USE_GLOBAL_CACHE
		    Return "DNS_USE_GLOBAL_CACHE"
		  Case DOH_SSL_VERIFYHOST
		    Return "DOH_SSL_VERIFYHOST"
		  Case DOH_SSL_VERIFYPEER
		    Return "DOH_SSL_VERIFYPEER"
		  Case DOH_SSL_VERIFYSTATUS
		    Return "DOH_SSL_VERIFYSTATUS"
		  Case DOH_URL
		    Return "DOH_URL"
		  Case EGDSOCKET
		    Return "EGDSOCKET"
		  Case ERRORBUFFER
		    Return "ERRORBUFFER"
		  Case EXPECT_100_TIMEOUT_MS
		    Return "EXPECT_100_TIMEOUT_MS"
		  Case FAILONERROR
		    Return "FAILONERROR"
		  Case FILETIME
		    Return "FILETIME"
		  Case FNMATCH_DATA
		    Return "FNMATCH_DATA"
		  Case FNMATCH_FUNCTION
		    Return "FNMATCH_FUNCTION"
		  Case FOLLOWLOCATION
		    Return "FOLLOWLOCATION"
		  Case FORBID_REUSE
		    Return "FORBID_REUSE"
		  Case FRESH_CONNECT
		    Return "FRESH_CONNECT"
		  Case FTPPORT
		    Return "FTPPORT"
		  Case FTPSSLAUTH
		    Return "FTPSSLAUTH"
		  Case FTP_ACCOUNT
		    Return "FTP_ACCOUNT"
		  Case FTP_ALTERNATIVE_TO_USER
		    Return "FTP_ALTERNATIVE_TO_USER"
		  Case FTP_CREATE_MISSING_DIRS
		    Return "FTP_CREATE_MISSING_DIRS"
		  Case FTP_FILEMETHOD
		    Return "FTP_FILEMETHOD"
		  Case FTP_RESPONSE_TIMEOUT
		    Return "FTP_RESPONSE_TIMEOUT"
		  Case FTP_SKIP_PASV_IP
		    Return "FTP_SKIP_PASV_IP"
		  Case FTP_SSL_CCC
		    Return "FTP_SSL_CCC"
		  Case FTP_USE_EPRT
		    Return "FTP_USE_EPRT"
		  Case FTP_USE_EPSV
		    Return "FTP_USE_EPSV"
		  Case FTP_USE_PRET
		    Return "FTP_USE_PRET"
		  Case GSSAPI_DELEGATION
		    Return "GSSAPI_DELEGATION"
		  Case HAPPY_EYEBALLS_TIMEOUT_MS
		    Return "HAPPY_EYEBALLS_TIMEOUT_MS"
		  Case HAPROXYPROTOCOL
		    Return "HAPROXYPROTOCOL"
		  Case HEADER
		    Return "HEADER"
		  Case HEADERDATA
		    Return "HEADERDATA"
		  Case HEADERFUNCTION
		    Return "HEADERFUNCTION"
		  Case HEADEROPT
		    Return "HEADEROPT"
		  Case HSTS
		    Return "HSTS"
		  Case HSTSREADDATA
		    Return "HSTSREADDATA"
		  Case HSTSREADFUNCTION
		    Return "HSTSREADFUNCTION"
		  Case HSTSWRITEDATA
		    Return "HSTSWRITEDATA"
		  Case HSTSWRITEFUNCTION
		    Return "HSTSWRITEFUNCTION"
		  Case HSTS_CTRL
		    Return "HSTS_CTRL"
		  Case HTTP09_ALLOWED
		    Return "HTTP09_ALLOWED"
		  Case HTTP200ALIASES
		    Return "HTTP200ALIASES"
		  Case HTTPAUTH
		    Return "HTTPAUTH"
		  Case HTTPGET
		    Return "HTTPGET"
		  Case HTTPHEADER
		    Return "HTTPHEADER"
		  Case HTTPPOST
		    Return "HTTPPOST"
		  Case HTTPPROXYTUNNEL
		    Return "HTTPPROXYTUNNEL"
		  Case HTTPVERSION
		    Return "HTTPVERSION"
		  Case HTTP_CONTENT_DECODING
		    Return "HTTP_CONTENT_DECODING"
		  Case HTTP_TRANSFER_DECODING
		    Return "HTTP_TRANSFER_DECODING"
		  Case HTTP_VERSION
		    Return "HTTP_VERSION"
		  Case IGNORE_CONTENT_LENGTH
		    Return "IGNORE_CONTENT_LENGTH"
		  Case INFILESIZE
		    Return "INFILESIZE"
		  Case INFILESIZE_LARGE
		    Return "INFILESIZE_LARGE"
		  Case INTERLEAVEDATA
		    Return "INTERLEAVEDATA"
		  Case INTERLEAVEFUNCTION
		    Return "INTERLEAVEFUNCTION"
		  Case IOCTLDATA
		    Return "IOCTLDATA"
		  Case IOCTLFUNCTION
		    Return "IOCTLFUNCTION"
		  Case IPRESOLVE
		    Return "IPRESOLVE"
		  Case ISSUERCERT
		    Return "ISSUERCERT"
		  Case ISSUERCERT_BLOB
		    Return "ISSUERCERT_BLOB"
		  Case KEEP_SENDING_ON_ERROR
		    Return "KEEP_SENDING_ON_ERROR"
		  Case KEYPASSWD
		    Return "KEYPASSWD"
		  Case KRBLEVEL
		    Return "KRBLEVEL"
		  Case LOCALPORT
		    Return "LOCALPORT"
		  Case LOCALPORTRANGE
		    Return "LOCALPORTRANGE"
		  Case LOGIN_OPTIONS
		    Return "LOGIN_OPTIONS"
		  Case LOW_SPEED_LIMIT
		    Return "LOW_SPEED_LIMIT"
		  Case LOW_SPEED_TIME
		    Return "LOW_SPEED_TIME"
		  Case MAIL_AUTH
		    Return "MAIL_AUTH"
		  Case MAIL_FROM
		    Return "MAIL_FROM"
		  Case MAIL_RCPT
		    Return "MAIL_RCPT"
		  Case MAIL_RCPT_ALLLOWFAILS
		    Return "MAIL_RCPT_ALLLOWFAILS"
		  Case MAXAGE_CONN
		    Return "MAXAGE_CONN"
		  Case MAXCONNECTS
		    Return "MAXCONNECTS"
		  Case MAXFILESIZE
		    Return "MAXFILESIZE"
		  Case MAXFILESIZE_LARGE
		    Return "MAXFILESIZE_LARGE"
		  Case MAXREDIRS
		    Return "MAXREDIRS"
		  Case MAXLIFETIME_CONN
		    Return "MAXLIFETIME_CONN"
		  Case MAX_RECV_SPEED_LARGE
		    Return "MAX_RECV_SPEED_LARGE"
		  Case MAX_SEND_SPEED_LARGE
		    Return "MAX_SEND_SPEED_LARGE"
		  Case MIME_OPTIONS
		    Return "MIME_OPTIONS"
		  Case MIMEPOST
		    Return "MIMEPOST"
		  Case NETINTERFACE
		    Return "INTERFACE"
		  Case NETRC
		    Return "NETRC"
		  Case NETRC_FILE
		    Return "NETRC_FILE"
		  Case NEW_DIRECTORY_PERMS
		    Return "NEW_DIRECTORY_PERMS"
		  Case NEW_FILE_PERMS
		    Return "NEW_FILE_PERMS"
		  Case NOBODY
		    Return "NOBODY"
		  Case NOPROGRESS
		    Return "NOPROGRESS"
		  Case NOPROXY
		    Return "NOPROXY"
		  Case NOSIGNAL
		    Return "NOSIGNAL"
		  Case OPENSOCKETDATA
		    Return "OPENSOCKETDATA"
		  Case OPENSOCKETFUNCTION
		    Return "OPENSOCKETFUNCTION"
		  Case PASSWORD
		    Return "PASSWORD"
		  Case PATH_AS_IS
		    Return "PATH_AS_IS"
		  Case PINNEDPUBLICKEY
		    Return "PINNEDPUBLICKEY"
		  Case PIPELINING_SERVER_BL
		    Return "PIPELINING_SERVER_BL"
		  Case PIPELINING_SITE_BL
		    Return "PIPELINING_SITE_BL"
		  Case PIPEWAIT
		    Return "PIPEWAIT"
		  Case PORT
		    Return "PORT"
		  Case POST
		    Return "POST"
		  Case POSTFIELDS
		    Return "POSTFIELDS"
		  Case POSTFIELDSIZE
		    Return "POSTFIELDSIZE"
		  Case POSTFIELDSIZE_LARGE
		    Return "POSTFIELDSIZE_LARGE"
		  Case POSTQUOTE
		    Return "POSTQUOTE"
		  Case POSTREDIR
		    Return "POSTREDIR"
		  Case PREREQDATA
		    Return "PREREQDATA"
		  Case PREREQFUNCTION
		    Return "PREREQFUNCTION"
		  Case PREQUOTE
		    Return "PREQUOTE"
		  Case PRE_PROXY
		    Return "PRE_PROXY"
		  Case PRIVATE_
		    Return "PRIVATE_"
		  Case PROGRESSDATA
		    Return "XFERINFODATA"
		  Case PROGRESSFUNCTION
		    Return "XFERINFOFUNCTION"
		  Case PROTOCOLS
		    Return "PROTOCOLS"
		  Case PROTOCOLS_STR
		    Return "PROTOCOLS_STR"
		  Case PROXY
		    Return "PROXY"
		  Case PROXYAUTH
		    Return "PROXYAUTH"
		  Case PROXYHEADER
		    Return "PROXYHEADER"
		  Case PROXYPASSWORD
		    Return "PROXYPASSWORD"
		  Case PROXYPORT
		    Return "PROXYPORT"
		  Case PROXYTYPE
		    Return "PROXYTYPE"
		  Case PROXYUSERNAME
		    Return "PROXYUSERNAME"
		  Case PROXYUSERPWD
		    Return "PROXYUSERPWD"
		  Case PROXY_CAINFO
		    Return "PROXY_CAINFO"
		  Case PROXY_CAINFO_BLOB
		    Return "PROXY_CAINFO_BLOB"
		  Case PROXY_CAPATH
		    Return "PROXY_CAPATH"
		  Case PROXY_CRLFILE
		    Return "PROXY_CRLFILE"
		  Case PROXY_ISSUERCERT
		    Return "PROXY_ISSUERCERT"
		  Case PROXY_ISSUERCERT_BLOB
		    Return "PROXY_ISSUERCERT_BLOB"
		  Case PROXY_KEYPASSWD
		    Return "PROXY_KEYPASSWD"
		  Case PROXY_PINNEDPUBLICKEY
		    Return "PROXY_PINNEDPUBLICKEY"
		  Case PROXY_SERVICE_NAME
		    Return "PROXY_SERVICE_NAME"
		  Case PROXY_SSLCERT
		    Return "PROXY_SSLCERT"
		  Case PROXY_SSLCERTTYPE
		    Return "PROXY_SSLCERTTYPE"
		  Case PROXY_SSLCERT_BLOB
		    Return "PROXY_SSLCERT_BLOB"
		  Case PROXY_SSLKEY
		    Return "PROXY_SSLKEY"
		  Case PROXY_SSLKEYTYPE
		    Return "PROXY_SSLKEYTYPE"
		  Case PROXY_SSLKEY_BLOB
		    Return "PROXY_SSLKEY_BLOB"
		  Case PROXY_SSLVERSION
		    Return "PROXY_SSLVERSION"
		  Case PROXY_SSL_CIPHER_LIST
		    Return "PROXY_SSL_CIPHER_LIST"
		  Case PROXY_SSL_OPTIONS
		    Return "PROXY_SSL_OPTIONS"
		  Case PROXY_SSL_VERIFYHOST
		    Return "PROXY_SSL_VERIFYHOST"
		  Case PROXY_SSL_VERIFYPEER
		    Return "PROXY_SSL_VERIFYPEER"
		  Case PROXY_TLS13_CIPHERS
		    Return "PROXY_TLS13_CIPHERS"
		  Case PROXY_TLSAUTH_PASSWORD
		    Return "PROXY_TLSAUTH_PASSWORD"
		  Case PROXY_TLSAUTH_TYPE
		    Return "PROXY_TLSAUTH_TYPE"
		  Case PROXY_TLSAUTH_USERNAME
		    Return "PROXY_TLSAUTH_USERNAME"
		  Case PROXY_TRANSFER_MODE
		    Return "PROXY_TRANSFER_MODE"
		  Case PUT
		    Return "PUT"
		  Case QUOTE
		    Return "QUOTE"
		  Case RANDOM_FILE
		    Return "RANDOM_FILE"
		  Case RANGE
		    Return "RANGE"
		  Case READDATA
		    Return "READDATA"
		  Case READFUNCTION
		    Return "READFUNCTION"
		  Case REDIR_PROTOCOLS
		    Return "REDIR_PROTOCOLS"
		  Case REDIR_PROTOCOLS_STR
		    Return "REDIR_PROTOCOLS_STR"
		  Case REFERER
		    Return "REFERER"
		  Case REQUEST_TARGET
		    Return "REQUEST_TARGET"
		  Case RESOLVE
		    Return "RESOLVE"
		  Case RESOLVER_START_DATA
		    Return "RESOLVER_START_DATA"
		  Case RESOLVER_START_FUNCTION
		    Return "RESOLVER_START_FUNCTION"
		  Case RESUME_FROM
		    Return "RESUME_FROM"
		  Case RESUME_FROM_LARGE
		    Return "RESUME_FROM_LARGE"
		  Case RTSP_CLIENT_CSEQ
		    Return "RTSP_CLIENT_CSEQ"
		  Case RTSP_REQUEST
		    Return "RTSP_REQUEST"
		  Case RTSP_SERVER_CSEQ
		    Return "RTSP_SERVER_CSEQ"
		  Case RTSP_SESSION_ID
		    Return "RTSP_SESSION_ID"
		  Case RTSP_STREAM_URI
		    Return "RTSP_STREAM_URI"
		  Case RTSP_TRANSPORT
		    Return "RTSP_TRANSPORT"
		  Case SASL_AUTHZID
		    Return "SASL_AUTHZID"
		  Case SASL_IR
		    Return "SASL_IR"
		  Case SEEKDATA
		    Return "SEEKDATA"
		  Case SEEKFUNCTION
		    Return "SEEKFUNCTION"
		  Case SERVICE_NAME
		    Return "SERVICE_NAME"
		  Case SHARE
		    Return "SHARE"
		  Case SHOPT_LOCKFUNC
		    Return "SHOPT_LOCKFUNC"
		  Case SHOPT_UNLOCKFUNC
		    Return "SHOPT_UNLOCKFUNC"
		  Case SHOPT_USERDATA
		    Return "SHOPT_USERDATA"
		  Case SOCKOPTDATA
		    Return "SOCKOPTDATA"
		  Case SOCKOPTFUNCTION
		    Return "SOCKOPTFUNCTION"
		  Case SOCKS5_AUTH
		    Return "SOCKS5_AUTH"
		  Case SOCKS5_GSSAPI_NEC
		    Return "SOCKS5_GSSAPI_NEC"
		  Case SOCKS5_GSSAPI_SERVICE
		    Return "SOCKS5_GSSAPI_SERVICE"
		  Case SSH_AUTH_TYPES
		    Return "SSH_AUTH_TYPES"
		  Case SSH_COMPRESSION
		    Return "SSH_COMPRESSION"
		  Case SSH_HOST_PUBLIC_KEY_MD5
		    Return "SSH_HOST_PUBLIC_KEY_MD5"
		  Case SSH_HOST_PUBLIC_KEY_SHA256
		    Return "SSH_HOST_PUBLIC_KEY_SHA256"
		  Case SSH_HOSTKEYDATA
		    Return "SSH_HOSTKEYDATA"
		  Case SSH_HOSTKEYFUNCTION
		    Return "SSH_HOSTKEYFUNCTION"
		  Case SSH_KEYDATA
		    Return "SSH_KEYDATA"
		  Case SSH_KEYFUNCTION
		    Return "SSH_KEYFUNCTION"
		  Case SSH_KNOWNHOSTS
		    Return "SSH_KNOWNHOSTS"
		  Case SSH_PRIVATE_KEYFILE
		    Return "SSH_PRIVATE_KEYFILE"
		  Case SSH_PUBLIC_KEYFILE
		    Return "SSH_PUBLIC_KEYFILE"
		  Case SSLCERT
		    Return "SSLCERT"
		  Case SSLCERTTYPE
		    Return "SSLCERTTYPE"
		  Case SSLCERT_BLOB
		    Return "SSLCERT_BLOB"
		  Case SSLENGINE
		    Return "SSLENGINE"
		  Case SSLENGINE_DEFAULT
		    Return "SSLENGINE_DEFAULT"
		  Case SSLKEY
		    Return "SSLKEY"
		  Case SSLKEYTYPE
		    Return "SSLKEYTYPE"
		  Case SSLKEY_BLOB
		    Return "SSLKEY_BLOB"
		  Case SSLVERSION
		    Return "SSLVERSION"
		  Case SSL_CIPHER_LIST
		    Return "SSL_CIPHER_LIST"
		  Case SSL_CTX_DATA
		    Return "SSL_CTX_DATA"
		  Case SSL_CTX_FUNCTION
		    Return "SSL_CTX_FUNCTION"
		  Case SSL_EC_CURVES
		    Return "SSL_EC_CURVES"
		  Case SSL_ENABLE_ALPN
		    Return "SSL_ENABLE_ALPN"
		  Case SSL_ENABLE_NPN
		    Return "SSL_ENABLE_NPN"
		  Case SSL_FALSESTART
		    Return "SSL_FALSESTART"
		  Case SSL_OPTIONS
		    Return "SSL_OPTIONS"
		  Case SSL_SESSIONID_CACHE
		    Return "SSL_SESSIONID_CACHE"
		  Case SSL_VERIFYHOST
		    Return "SSL_VERIFYHOST"
		  Case SSL_VERIFYPEER
		    Return "SSL_VERIFYPEER"
		  Case SSL_VERIFYSTATUS
		    Return "SSL_VERIFYSTATUS"
		  Case STDERR
		    Return "STDERR"
		  Case STREAM_DEPENDS
		    Return "STREAM_DEPENDS"
		  Case STREAM_DEPENDS_E
		    Return "STREAM_DEPENDS_E"
		  Case STREAM_WEIGHT
		    Return "STREAM_WEIGHT"
		  Case SUPPRESS_CONNECT_HEADERS
		    Return "SUPPRESS_CONNECT_HEADERS"
		  Case TCP_FASTOPEN
		    Return "TCP_FASTOPEN"
		  Case TCP_KEEPALIVE
		    Return "TCP_KEEPALIVE"
		  Case TCP_KEEPIDLE
		    Return "TCP_KEEPIDLE"
		  Case TCP_KEEPINTVL
		    Return "TCP_KEEPINTVL"
		  Case TCP_NODELAY
		    Return "TCP_NODELAY"
		  Case TELNETOPTIONS
		    Return "TELNETOPTIONS"
		  Case TFTP_BLKSIZE
		    Return "TFTP_BLKSIZE"
		  Case TFTP_NO_OPTIONS
		    Return "TFTP_NO_OPTIONS"
		  Case TIMECONDITION
		    Return "TIMECONDITION"
		  Case TIMEOUT
		    Return "TIMEOUT"
		  Case TIMEOUT_MS
		    Return "TIMEOUT_MS"
		  Case TIMEVALUE
		    Return "TIMEVALUE"
		  Case TIMEVALUE_LARGE
		    Return "TIMEVALUE_LARGE"
		  Case TLS13_CIPHERS
		    Return "TLS13_CIPHERS"
		  Case TLSAUTH_PASSWORD
		    Return "TLSAUTH_PASSWORD"
		  Case TLSAUTH_TYPE
		    Return "TLSAUTH_TYPE"
		  Case TLSAUTH_USERNAME
		    Return "TLSAUTH_USERNAME"
		  Case TRAILERDATA
		    Return "TRAILERDATA"
		  Case TRAILERFUNCTION
		    Return "TRAILERFUNCTION"
		  Case TRANSFERTEXT
		    Return "TRANSFERTEXT"
		  Case TRANSFER_ENCODING
		    Return "TRANSFER_ENCODING"
		  Case UNIX_SOCKET_PATH
		    Return "UNIX_SOCKET_PATH"
		  Case UNRESTRICTED_AUTH
		    Return "UNRESTRICTED_AUTH"
		  Case UPKEEP_INTERVAL_MS
		    Return "UPKEEP_INTERVAL_MS"
		  Case UPLOAD
		    Return "UPLOAD"
		  Case UPLOAD_BUFFERSIZE
		    Return "UPLOAD_BUFFERSIZE"
		  Case URL
		    Return "URL"
		  Case USERAGENT
		    Return "USERAGENT"
		  Case USERNAME
		    Return "USERNAME"
		  Case USERPWD
		    Return "USERPWD"
		  Case USE_SSL
		    Return "USE_SSL"
		  Case VERBOSE
		    Return "VERBOSE"
		  Case WILDCARDMATCH
		    Return "WILDCARDMATCH"
		  Case WRITEDATA
		    Return "WRITEDATA"
		  Case WRITEFUNCTION
		    Return "WRITEFUNCTION"
		  Case WS_OPTIONS
		    Return "WS_OPTIONS"
		  Case XFERINFODATA
		    Return "XFERINFODATA"
		  Case XFERINFOFUNCTION
		    Return "XFERINFOFUNCTION"
		  Case XOAUTH2_BEARER
		    Return "XOAUTH2_BEARER"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function GetOptionType(OptionID As Int32) As OptionType
		  Select Case OptionID
		  Case ABSTRACT_UNIX_SOCKET
		    Return OptionType.String
		  Case ACCEPTTIMEOUT_MS
		    Return OptionType.Number
		  Case ACCEPT_ENCODING
		    Return OptionType.String
		  Case ADDRESS_SCOPE
		    Return OptionType.Number
		  Case ALTSVC
		    Return OptionType.String
		  Case ALTSVC_CTRL
		    Return OptionType.Number
		  Case APPEND
		    Return OptionType.Number
		  Case AUTOREFERER
		    Return OptionType.Number
		  Case AWS_SIGV4
		    Return OptionType.String
		  Case BUFFERSIZE
		    Return OptionType.Number
		  Case CAINFO
		    Return OptionType.String
		  Case CAPATH
		    Return OptionType.String
		  Case CAINFO_BLOB
		    Return OptionType.Ptr
		  Case CERTINFO
		    Return OptionType.Number
		  Case CHUNK_BGN_FUNCTION
		    Return OptionType.Subroutine
		  Case CHUNK_DATA
		    Return OptionType.Opaque
		  Case CHUNK_END_FUNCTION
		    Return OptionType.Subroutine
		  Case CLOSESOCKETDATA
		    Return OptionType.Opaque
		  Case CLOSESOCKETFUNCTION
		    Return OptionType.Subroutine
		  Case CONNECTTIMEOUT
		    Return OptionType.Number
		  Case CONNECTTIMEOUT_MS
		    Return OptionType.Number
		  Case CONNECT_ONLY
		    Return OptionType.Number
		  Case CONNECT_TO
		    Return OptionType.List
		  Case CONV_FROM_NETWORK_FUNCTION
		    Return OptionType.Subroutine
		  Case CONV_FROM_UTF8_FUNCTION
		    Return OptionType.Subroutine
		  Case CONV_TO_NETWORK_FUNCTION
		    Return OptionType.Subroutine
		  Case COOKIE
		    Return OptionType.String
		  Case COOKIEFILE
		    Return OptionType.String
		  Case COOKIEJAR
		    Return OptionType.String
		  Case COOKIELIST
		    Return OptionType.String
		  Case COOKIESESSION
		    Return OptionType.Number
		  Case COPYPOSTFIELDS
		    Return OptionType.Ptr
		  Case CRLF
		    Return OptionType.Number
		  Case CRLFILE
		    Return OptionType.String
		  Case CURLU
		    Return OptionType.Ptr
		  Case CUSTOMREQUEST
		    Return OptionType.String
		  Case DEBUGDATA
		    Return OptionType.Opaque
		  Case DEBUGFUNCTION
		    Return OptionType.Subroutine
		  Case DEFAULT_PROTOCOL
		    Return OptionType.String
		  Case DIRLISTONLY
		    Return OptionType.Number
		  Case DISALLOW_USERNAME_IN_URL
		    Return OptionType.Number
		  Case DNS_CACHE_TIMEOUT
		    Return OptionType.Number
		  Case DNS_INTERFACE
		    Return OptionType.String
		  Case DNS_LOCAL_IP4
		    Return OptionType.String
		  Case DNS_LOCAL_IP6
		    Return OptionType.String
		  Case DNS_SERVERS
		    Return OptionType.String
		  Case DNS_SHUFFLE_ADDRESSES
		    Return OptionType.Number
		  Case DNS_USE_GLOBAL_CACHE
		    Return OptionType.Number
		  Case DOH_SSL_VERIFYHOST
		    Return OptionType.Number
		  Case DOH_SSL_VERIFYPEER
		    Return OptionType.Number
		  Case DOH_SSL_VERIFYSTATUS
		    Return OptionType.Number
		  Case DOH_URL
		    Return OptionType.String
		  Case EGDSOCKET
		    Return OptionType.String
		  Case ACCEPT_ENCODING
		    Return OptionType.String
		  Case ERRORBUFFER
		    Return OptionType.Ptr
		  Case EXPECT_100_TIMEOUT_MS
		    Return OptionType.Number
		  Case FAILONERROR
		    Return OptionType.Number
		  Case WRITEDATA
		    Return OptionType.Opaque
		  Case FILETIME
		    Return OptionType.Number
		  Case FNMATCH_DATA
		    Return OptionType.Opaque
		  Case FNMATCH_FUNCTION
		    Return OptionType.Subroutine
		  Case FOLLOWLOCATION
		    Return OptionType.Number
		  Case FORBID_REUSE
		    Return OptionType.Number
		  Case FRESH_CONNECT
		    Return OptionType.Number
		  Case APPEND
		    Return OptionType.Number
		  Case DIRLISTONLY
		    Return OptionType.Number
		  Case FTPPORT
		    Return OptionType.String
		  Case FTPSSLAUTH
		    Return OptionType.Bitmask
		  Case FTP_ACCOUNT
		    Return OptionType.String
		  Case FTP_ALTERNATIVE_TO_USER
		    Return OptionType.String
		  Case FTP_CREATE_MISSING_DIRS
		    Return OptionType.Number
		  Case FTP_FILEMETHOD
		    Return OptionType.Bitmask
		  Case FTP_RESPONSE_TIMEOUT
		    Return OptionType.Number
		  Case FTP_SKIP_PASV_IP
		    Return OptionType.Number
		  Case USE_SSL
		    Return OptionType.Bitmask
		  Case FTP_SSL_CCC
		    Return OptionType.Number
		  Case FTP_USE_EPRT
		    Return OptionType.Number
		  Case FTP_USE_EPSV
		    Return OptionType.Number
		  Case FTP_USE_PRET
		    Return OptionType.Number
		  Case GSSAPI_DELEGATION
		    Return OptionType.Bitmask
		  Case HAPPY_EYEBALLS_TIMEOUT_MS
		    Return OptionType.Number
		  Case HAPROXYPROTOCOL
		    Return OptionType.Number
		  Case HEADER
		    Return OptionType.Number
		  Case HEADERDATA
		    Return OptionType.Opaque
		  Case HEADERFUNCTION
		    Return OptionType.Subroutine
		  Case HEADEROPT
		    Return OptionType.Bitmask
		  Case HSTS
		    Return OptionType.String
		  Case HSTSREADDATA
		    Return OptionType.Opaque
		  Case HSTSREADFUNCTION
		    Return OptionType.Subroutine
		  Case HSTSWRITEDATA
		    Return OptionType.Opaque
		  Case HSTSWRITEFUNCTION
		    Return OptionType.Subroutine
		  Case HSTS_CTRL
		    Return OptionType.Bitmask
		  Case HTTP09_ALLOWED
		    Return OptionType.Number
		  Case HTTP200ALIASES
		    Return OptionType.List
		  Case HTTPAUTH
		    Return OptionType.Bitmask
		  Case HTTPGET
		    Return OptionType.Number
		  Case HTTPHEADER
		    Return OptionType.List
		  Case HTTPPOST
		    Return OptionType.Ptr
		  Case HTTPPROXYTUNNEL
		    Return OptionType.Number
		  Case HTTP_CONTENT_DECODING
		    Return OptionType.Number
		  Case HTTP_TRANSFER_DECODING
		    Return OptionType.Number
		  Case HTTP_VERSION
		    Return OptionType.Bitmask
		  Case IGNORE_CONTENT_LENGTH
		    Return OptionType.Number
		  Case READDATA
		    Return OptionType.Opaque
		  Case INFILESIZE
		    Return OptionType.Number
		  Case INFILESIZE_LARGE
		    Return OptionType.LargeNumber
		  Case NETINTERFACE
		    Return OptionType.String
		  Case INTERLEAVEDATA
		    Return OptionType.Opaque
		  Case INTERLEAVEFUNCTION
		    Return OptionType.Subroutine
		  Case IOCTLDATA
		    Return OptionType.Opaque
		  Case IOCTLFUNCTION
		    Return OptionType.Subroutine
		  Case IPRESOLVE
		    Return OptionType.Bitmask
		  Case ISSUERCERT
		    Return OptionType.String
		  Case ISSUERCERT_BLOB
		    Return OptionType.Blob
		  Case KEEP_SENDING_ON_ERROR
		    Return OptionType.Number
		  Case KEYPASSWD
		    Return OptionType.String
		  Case KRBLEVEL
		    Return OptionType.String
		  Case KRBLEVEL
		    Return OptionType.String
		  Case LOCALPORT
		    Return OptionType.Number
		  Case LOCALPORTRANGE
		    Return OptionType.Number
		  Case LOGIN_OPTIONS
		    Return OptionType.String
		  Case LOW_SPEED_LIMIT
		    Return OptionType.Number
		  Case LOW_SPEED_TIME
		    Return OptionType.Number
		  Case MAIL_AUTH
		    Return OptionType.String
		  Case MAIL_FROM
		    Return OptionType.String
		  Case MAIL_RCPT
		    Return OptionType.List
		  Case MAIL_RCPT_ALLLOWFAILS
		    Return OptionType.Number
		  Case MAXAGE_CONN
		    Return OptionType.Number
		  Case MAXCONNECTS
		    Return OptionType.Number
		  Case MAXFILESIZE
		    Return OptionType.Number
		  Case MAXFILESIZE_LARGE
		    Return OptionType.LargeNumber
		  Case MAXREDIRS
		    Return OptionType.Number
		  Case MAXLIFETIME_CONN
		    Return OptionType.Number
		  Case MAX_RECV_SPEED_LARGE
		    Return OptionType.LargeNumber
		  Case MAX_SEND_SPEED_LARGE
		    Return OptionType.LargeNumber
		  Case MIME_OPTIONS
		    Return OptionType.Bitmask
		  Case MIMEPOST
		    Return OptionType.Ptr
		  Case NETRC
		    Return OptionType.Bitmask
		  Case NETRC_FILE
		    Return OptionType.String
		  Case NEW_DIRECTORY_PERMS
		    Return OptionType.Number
		  Case NEW_FILE_PERMS
		    Return OptionType.Number
		  Case NOBODY
		    Return OptionType.Number
		  Case NOPROGRESS
		    Return OptionType.Number
		  Case NOPROXY
		    Return OptionType.String
		  Case NOSIGNAL
		    Return OptionType.Number
		  Case OPENSOCKETDATA
		    Return OptionType.Opaque
		  Case OPENSOCKETFUNCTION
		    Return OptionType.Subroutine
		  Case PASSWORD
		    Return OptionType.String
		  Case PATH_AS_IS
		    Return OptionType.Number
		  Case PINNEDPUBLICKEY
		    Return OptionType.String
		  Case PIPEWAIT
		    Return OptionType.Number
		  Case PORT
		    Return OptionType.Number
		  Case POST
		    Return OptionType.Number
		  Case POSTREDIR
		    Return OptionType.Bitmask
		  Case POSTFIELDS
		    Return OptionType.Ptr
		  Case POSTFIELDSIZE
		    Return OptionType.Number
		  Case POSTFIELDSIZE_LARGE
		    Return OptionType.LargeNumber
		  Case POSTQUOTE
		    Return OptionType.List
		  Case POSTREDIR
		    Return OptionType.Bitmask
		  Case PREREQDATA
		    Return OptionType.Opaque
		  Case PREREQFUNCTION
		    Return OptionType.Subroutine
		  Case PREQUOTE
		    Return OptionType.List
		  Case PRE_PROXY
		    Return OptionType.String
		  Case PRIVATE_
		    Return OptionType.Ptr
		  Case XFERINFODATA
		    Return OptionType.Opaque
		  Case PROGRESSFUNCTION
		    Return OptionType.Subroutine
		  Case PROTOCOLS
		    Return OptionType.Number
		  Case PROTOCOLS_STR
		    Return OptionType.String
		  Case PROXY
		    Return OptionType.String
		  Case PROXYAUTH
		    Return OptionType.Bitmask
		  Case PROXYHEADER
		    Return OptionType.List
		  Case PROXYPASSWORD
		    Return OptionType.String
		  Case PROXYPORT
		    Return OptionType.Number
		  Case PROXYTYPE
		    Return OptionType.Bitmask
		  Case PROXYUSERNAME
		    Return OptionType.String
		  Case PROXYUSERPWD
		    Return OptionType.String
		  Case PROXY_CAINFO
		    Return OptionType.String
		  Case PROXY_CAINFO_BLOB
		    Return OptionType.Blob
		  Case PROXY_CAPATH
		    Return OptionType.String
		  Case PROXY_CRLFILE
		    Return OptionType.String
		  Case PROXY_ISSUERCERT
		    Return OptionType.String
		  Case PROXY_ISSUERCERT_BLOB
		    Return OptionType.Blob
		  Case PROXY_KEYPASSWD
		    Return OptionType.String
		  Case PROXY_PINNEDPUBLICKEY
		    Return OptionType.String
		  Case PROXY_SERVICE_NAME
		    Return OptionType.String
		  Case PROXY_SSLCERT
		    Return OptionType.String
		  Case PROXY_SSLCERTTYPE
		    Return OptionType.String
		  Case PROXY_SSLCERT_BLOB
		    Return OptionType.Blob
		  Case PROXY_SSLKEY
		    Return OptionType.String
		  Case PROXY_SSLKEYTYPE
		    Return OptionType.String
		  Case PROXY_SSLKEY_BLOB
		    Return OptionType.Blob
		  Case PROXY_SSLVERSION
		    Return OptionType.Bitmask
		  Case PROXY_SSL_CIPHER_LIST
		    Return OptionType.String
		  Case PROXY_SSL_OPTIONS
		    Return OptionType.Number
		  Case PROXY_SSL_VERIFYHOST
		    Return OptionType.Number
		  Case PROXY_SSL_VERIFYPEER
		    Return OptionType.Number
		  Case PROXY_TLS13_CIPHERS
		    Return OptionType.String
		  Case PROXY_TLSAUTH_PASSWORD
		    Return OptionType.String
		  Case PROXY_TLSAUTH_TYPE
		    Return OptionType.String
		  Case PROXY_TLSAUTH_USERNAME
		    Return OptionType.String
		  Case PROXY_TRANSFER_MODE
		    Return OptionType.Number
		  Case PUT
		    Return OptionType.Number
		  Case QUOTE
		    Return OptionType.List
		  Case RANDOM_FILE
		    Return OptionType.String
		  Case RANGE
		    Return OptionType.String
		  Case READDATA
		    Return OptionType.Opaque
		  Case READFUNCTION
		    Return OptionType.Subroutine
		  Case REDIR_PROTOCOLS
		    Return OptionType.Number
		  Case REDIR_PROTOCOLS_STR
		    Return OptionType.String
		  Case REFERER
		    Return OptionType.String
		  Case REQUEST_TARGET
		    Return OptionType.String
		  Case RESOLVE
		    Return OptionType.List
		  Case RESOLVER_START_DATA
		    Return OptionType.Opaque
		  Case RESOLVER_START_FUNCTION
		    Return OptionType.Subroutine
		  Case RESUME_FROM
		    Return OptionType.Number
		  Case RESUME_FROM_LARGE
		    Return OptionType.LargeNumber
		  Case HTTPHEADER
		    Return OptionType.List
		  Case RTSP_CLIENT_CSEQ
		    Return OptionType.Number
		  Case RTSP_REQUEST
		    Return OptionType.Bitmask
		  Case RTSP_SERVER_CSEQ
		    Return OptionType.Number
		  Case RTSP_SESSION_ID
		    Return OptionType.String
		  Case RTSP_STREAM_URI
		    Return OptionType.String
		  Case RTSP_TRANSPORT
		    Return OptionType.String
		  Case SASL_AUTHZID
		    Return OptionType.String
		  Case SASL_IR
		    Return OptionType.Number
		  Case SEEKDATA
		    Return OptionType.Opaque
		  Case SEEKFUNCTION
		    Return OptionType.Subroutine
		  Case FTP_RESPONSE_TIMEOUT
		    Return OptionType.Number
		  Case SERVICE_NAME
		    Return OptionType.String
		  Case SHARE
		    Return OptionType.Ptr
		  Case SOCKOPTDATA
		    Return OptionType.Opaque
		  Case SOCKOPTFUNCTION
		    Return OptionType.Subroutine
		  Case SOCKS5_AUTH
		    Return OptionType.Number
		  Case SOCKS5_GSSAPI_NEC
		    Return OptionType.Number
		  Case SOCKS5_GSSAPI_SERVICE
		    Return OptionType.String
		  Case SSH_AUTH_TYPES
		    Return OptionType.Bitmask
		  Case SSH_COMPRESSION
		    Return OptionType.Number
		  Case SSH_HOST_PUBLIC_KEY_MD5
		    Return OptionType.String
		  Case SSH_HOST_PUBLIC_KEY_SHA256
		    Return OptionType.String
		  Case SSH_HOSTKEYDATA
		    Return OptionType.Opaque
		  Case SSH_HOSTKEYFUNCTION
		    Return OptionType.Subroutine
		  Case SSH_KEYDATA
		    Return OptionType.Opaque
		  Case SSH_KEYFUNCTION
		    Return OptionType.Subroutine
		  Case SSH_KNOWNHOSTS
		    Return OptionType.String
		  Case SSH_PRIVATE_KEYFILE
		    Return OptionType.String
		  Case SSH_PUBLIC_KEYFILE
		    Return OptionType.String
		  Case SSLCERT
		    Return OptionType.String
		  Case KEYPASSWD
		    Return OptionType.String
		  Case SSLCERTTYPE
		    Return OptionType.String
		  Case SSLCERT_BLOB
		    Return OptionType.Blob
		  Case SSLENGINE
		    Return OptionType.String
		  Case SSLENGINE_DEFAULT
		    Return OptionType.Number
		  Case SSLKEY
		    Return OptionType.String
		  Case KEYPASSWD
		    Return OptionType.String
		  Case SSLKEYTYPE
		    Return OptionType.String
		  Case SSLKEY_BLOB
		    Return OptionType.Blob
		  Case SSLVERSION
		    Return OptionType.Bitmask
		  Case SSL_CIPHER_LIST
		    Return OptionType.String
		  Case SSL_CTX_DATA
		    Return OptionType.Opaque
		  Case SSL_CTX_FUNCTION
		    Return OptionType.Subroutine
		  Case SSL_EC_CURVES
		    Return OptionType.String
		  Case SSL_ENABLE_ALPN
		    Return OptionType.Number
		  Case SSL_ENABLE_NPN
		    Return OptionType.Number
		  Case SSL_FALSESTART
		    Return OptionType.Number
		  Case SSL_OPTIONS
		    Return OptionType.Bitmask
		  Case SSL_SESSIONID_CACHE
		    Return OptionType.Number
		  Case SSL_VERIFYHOST
		    Return OptionType.Number
		  Case SSL_VERIFYPEER
		    Return OptionType.Number
		  Case SSL_VERIFYSTATUS
		    Return OptionType.Number
		  Case STDERR
		    Return OptionType.Ptr
		  Case STREAM_DEPENDS
		    Return OptionType.Ptr
		  Case STREAM_DEPENDS_E
		    Return OptionType.Ptr
		  Case STREAM_WEIGHT
		    Return OptionType.Number
		  Case SUPPRESS_CONNECT_HEADERS
		    Return OptionType.Number
		  Case TCP_FASTOPEN
		    Return OptionType.Number
		  Case TCP_KEEPALIVE
		    Return OptionType.Number
		  Case TCP_KEEPIDLE
		    Return OptionType.Number
		  Case TCP_KEEPINTVL
		    Return OptionType.Number
		  Case TCP_NODELAY
		    Return OptionType.Number
		  Case TELNETOPTIONS
		    Return OptionType.List
		  Case TFTP_BLKSIZE
		    Return OptionType.Number
		  Case TFTP_NO_OPTIONS
		    Return OptionType.Number
		  Case TIMECONDITION
		    Return OptionType.Bitmask
		  Case TIMEOUT
		    Return OptionType.Number
		  Case TIMEOUT_MS
		    Return OptionType.Number
		  Case TIMEVALUE
		    Return OptionType.Number
		  Case TIMEVALUE_LARGE
		    Return OptionType.LargeNumber
		  Case TLS13_CIPHERS
		    Return OptionType.String
		  Case TLSAUTH_PASSWORD
		    Return OptionType.String
		  Case TLSAUTH_TYPE
		    Return OptionType.String
		  Case TLSAUTH_USERNAME
		    Return OptionType.String
		  Case TRAILERDATA
		    Return OptionType.Opaque
		  Case TRAILERFUNCTION
		    Return OptionType.Subroutine
		  Case TRANSFERTEXT
		    Return OptionType.Number
		  Case TRANSFER_ENCODING
		    Return OptionType.Number
		  Case UNIX_SOCKET_PATH
		    Return OptionType.String
		  Case UNRESTRICTED_AUTH
		    Return OptionType.Number
		  Case UPKEEP_INTERVAL_MS
		    Return OptionType.Number
		  Case UPLOAD
		    Return OptionType.Number
		  Case UPLOAD_BUFFERSIZE
		    Return OptionType.Number
		  Case URL
		    Return OptionType.String
		  Case USERAGENT
		    Return OptionType.String
		  Case USERNAME
		    Return OptionType.String
		  Case USERPWD
		    Return OptionType.String
		  Case USE_SSL
		    Return OptionType.Bitmask
		  Case VERBOSE
		    Return OptionType.Number
		  Case WILDCARDMATCH
		    Return OptionType.Number
		  Case WRITEDATA
		    Return OptionType.Opaque
		  Case WRITEFUNCTION
		    Return OptionType.Subroutine
		  Case WS_OPTIONS
		    Return OptionType.Bitmask
		  Case HEADERDATA
		    Return OptionType.Opaque
		  Case XFERINFODATA
		    Return OptionType.Opaque
		  Case XFERINFOFUNCTION
		    Return OptionType.Subroutine
		  Case XOAUTH2_BEARER
		    Return OptionType.String
		    
		  Else
		    Return OptionType.Unknown
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function IsBooleanOption(OptionID As Int32) As Boolean
		  Select Case OptionID
		  Case APPEND, AUTOREFERER, CONNECT_ONLY, COOKIESESSION, DIRLISTONLY, DISALLOW_USERNAME_IN_URL, DNS_SHUFFLE_ADDRESSES, _
		    DNS_USE_GLOBAL_CACHE, FAILONERROR, FILETIME, FOLLOWLOCATION, FORBID_REUSE, FRESH_CONNECT, FTP_CREATE_MISSING_DIRS, _
		    FTP_SKIP_PASV_IP, FTP_USE_EPRT, FTP_USE_EPSV, FTP_USE_PRET, HAPROXYPROTOCOL, HEADER, HTTP09_ALLOWED, HTTPGET, HTTPPROXYTUNNEL, _
		    HTTP_CONTENT_DECODING, HTTP_TRANSFER_DECODING, IGNORE_CONTENT_LENGTH, KEEP_SENDING_ON_ERROR, MAIL_RCPT_ALLLOWFAILS, NOBODY, _
		    NOPROGRESS, NOSIGNAL, PATH_AS_IS, PIPEWAIT, POST, PROXY_TRANSFER_MODE, PUT, SASL_IR, SOCKS5_GSSAPI_NEC, SSH_COMPRESSION, _
		    SSLENGINE_DEFAULT, SSL_ENABLE_ALPN, SSL_ENABLE_NPN, SSL_FALSESTART, SSL_SESSIONID_CACHE, SSL_VERIFYPEER, SSL_VERIFYSTATUS, _
		    SUPPRESS_CONNECT_HEADERS, TCP_FASTOPEN, TCP_KEEPALIVE, TCP_NODELAY, TFTP_NO_OPTIONS, TRANSFER_ENCODING, TRANSFERTEXT, _
		    UNRESTRICTED_AUTH, UPLOAD, VERBOSE, WILDCARDMATCH
		    Return True
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsSet(Session As libcURL.EasyHandle) As Boolean
		  ' Returns True if the option represented by this OptionInfo instance has
		  ' been modified on the given instance of EasyHandle.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.IsSet
		  
		  Return Me.Value(Session) <> Me.DefaultValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherOpt As libcURL.Opts.OptionInfo) As Integer
		  ' Compares this OptionInfo to another OptionInfo. OptionInfo instances are considered equal if
		  ' they represent the same option number. Since the OptionInfo class automatically converts
		  ' from an Int32, you can compare an instance of OptionInfo to a literal number using this method.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.Operator_Compare
		  
		  If OtherOpt Is Nil Then Return 1 Else Return Sign(OptionNumber - OtherOpt.OptionNumber)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Int32
		  ' This method overloads the conversion operator (=) allowing direct conversion to an Int32.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.Operator_Convert
		  
		  Return OptionNumber
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(OptionID As Int32)
		  ' This method overloads the conversion operator (=) allowing direct conversion from an Int32.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.Operator_Convert
		  
		  If Not libcURL.IsAvailable Then Raise New PlatformNotSupportedException
		  If System.IsFunctionAvailable("curl_easy_option_by_id", cURLLib) Then
		    Dim opt As Ptr = curl_easy_option_by_id(OptionID)
		    If opt <> Nil Then
		      Me.Constructor(opt.curl_easyoption)
		    Else
		      Dim err As New cURLException(Nil)
		      err.ErrorNumber = -libcURL.Errors.UNKNOWN_OPTION
		      err.Message = "Invalid option ID number."
		      Raise err
		    End If
		  Else
		    mOpt.Option = OptionID
		    mOpt.Type = GetOptionType(OptionID)
		    If Not GetOptionFirstVersion(OptionNumber, mMinMajor, mMinMinor, mMinPatch) Then
		      Dim err As New cURLException(Nil)
		      err.ErrorNumber = -libcURL.Errors.UNKNOWN_OPTION
		      err.Message = "Invalid option ID number."
		      Raise err
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Name As String)
		  ' This method overloads the conversion operator (=) allowing direct conversion from
		  ' the name or alias of an option number.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.Operator_Convert
		  
		  If Not libcURL.IsAvailable Then Raise New PlatformNotSupportedException
		  Name = Replace(Name, "CURLOPT_", "")
		  Name = Replace(Name, "libcURL.Opts.", "")
		  Name = Name.Uppercase()
		  If System.IsFunctionAvailable("curl_easy_option_by_name", cURLLib) Then
		    Dim opt As Ptr = curl_easy_option_by_name(Name)
		    If opt <> Nil Then
		      Me.Constructor(opt.curl_easyoption)
		    Else
		      Dim err As New cURLException(Nil)
		      err.ErrorNumber = -libcURL.Errors.UNKNOWN_OPTION
		      err.Message = "Invalid option name or alias."
		      Raise err
		    End If
		  Else
		    mOpt.Option = GetOptionByName(Name)
		    mOpt.Type = GetOptionType(OptionNumber)
		    If Not GetOptionFirstVersion(OptionNumber, mMinMajor, mMinMinor, mMinPatch) Then
		      Dim err As New cURLException(Nil)
		      err.ErrorNumber = -libcURL.Errors.UNKNOWN_OPTION
		      err.Message = "Invalid option name or alias."
		      Raise err
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(Session As libcURL.EasyHandle) As String
		  ' A string representation, if one is available, of the current value of the option number
		  ' for the specified EasyHandle.
		  ' This method is useful for displaying values to the user. If no string representation
		  ' can be provided, for example if the option hasn't been set, then an empty string is returned.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.StringValue
		  
		  Select Case Me.Type
		  Case OptionType.Bitmask, OptionType.LargeNumber, OptionType.Number
		    #If Target64Bit Then
		      Dim i As Int64 = Me.Value(Session).Int64Value
		    #Else
		      Dim i As Int32 = Me.Value(Session).Int32Value
		    #EndIf
		    If i <> 0 Then Return Str(i)
		    
		  Case OptionType.List
		    Dim l As ListPtr = Me.Value(Session)
		    If l <> Nil Then
		      Dim s As String
		      For i As Integer = 0 To l.Count - 1
		        s = s + """" + l.Item(i) + """"
		        If i < l.Count - 1 Then s = s + ","
		      Next
		      Return s
		    End If
		    
		    
		  Case OptionType.Opaque, OptionType.Ptr
		    Dim p As Ptr = Me.Value(Session).PtrValue
		    If p = Nil Then Return ""
		    If Me.Type = OptionType.Ptr Then
		      Try
		        Dim mb As MemoryBlock = p
		        Return mb.CString(0)
		      Catch
		      End Try
		    End If
		    Return "0x" + Hex(Integer(p))
		    
		    
		  Case OptionType.String
		    Return Me.Value(Session).StringValue
		    
		  Case OptionType.Subroutine
		    If Me.Value(Session) <> Nil Then
		      Select Case Me
		      Case libcURL.Opts.CHUNK_BGN_FUNCTION
		        Return "FTPWildCard.ChunkBeginCallback"
		      Case libcURL.Opts.CHUNK_END_FUNCTION
		        Return "FTPWildCard.ChunkEndCallback"
		      Case libcURL.Opts.DEBUGFUNCTION
		        Return "EasyHandle.DebugCallback"
		      Case libcURL.Opts.SEEKFUNCTION
		        Return "EasyHandle.SeekCallback"
		      Case libcURL.Opts.XFERINFOFUNCTION, libcURL.Opts.PROGRESSFUNCTION
		        Return "EasyHandle.ProgressCallback"
		      Case libcURL.Opts.WRITEFUNCTION
		        Return "EasyHandle.WriteCallback"
		      Case libcURL.Opts.READFUNCTION
		        Return "EasyHandle.ReadCallback"
		      Case libcURL.Opts.HEADERFUNCTION
		        Return "EasyHandle.HeaderCallback"
		      Case libcURL.Opts.PREREQFUNCTION
		        Return "EasyHandle.InitRequestCallback"
		      End Select
		      
		    End If
		    
		  Case OptionType.Boolean
		    If Me.Value(Session).BooleanValue Then Return "True" Else Return "False"
		    
		  End Select
		  
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Session As libcURL.EasyHandle) As Variant
		  ' Returns the current value of the option for the specified EasyHandle.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.Value
		  
		  Return Session.GetOption(OptionNumber)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Session As libcURL.EasyHandle, Assigns NewValue As Variant)
		  ' Sets a new value for the option on the specified EasyHandle.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.Value
		  
		  Call Session.SetOption(OptionNumber, NewValue)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The alias under which the option is known in Xojo. e.g. "libcURL.Opts.CUSTOMREQUEST"
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.BindingAlias
			  
			  Dim nm As String = GetOptionName(OptionNumber)
			  If nm = "INTERFACE" Then nm = "NETINTERFACE"
			  If nm <> "" Then nm = "libcURL.Opts." + nm
			  Return nm
			End Get
		#tag EndGetter
		BindingAlias As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The default value for this option. Typically a variation of 0, nil, "", etc.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.DefaultValue
			  
			  Dim v As Variant = GetOptionDefault(OptionNumber)
			  If IsBooleanOption(OptionNumber) Then Return v.BooleanValue
			  Return v
			End Get
		#tag EndGetter
		DefaultValue As Variant
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The URL to the documentation for this option on the libcurl website.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.DocumentationURL
			  
			  If Name <> "" And Not IsDeprecated Then Return "https://curl.haxx.se/libcurl/c/" + LibraryAlias + ".html"
			End Get
		#tag EndGetter
		DocumentationURL As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' This property is True if this option is available at runtime.
			  '
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.IsAvailable
			  
			  If mMinMajor = 0 Then Return True
			  If mMinMajor = -1 Then Return False
			  Return libcURL.Version.IsAtLeast(mMinMajor, mMinMinor, mMinPatch)
			End Get
		#tag EndGetter
		IsAvailable As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' This property is True if this option has been deprecated.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.IsDeprecated
			  
			  return mOpt.Flags = CURLOT_FLAG_ALIAS
			End Get
		#tag EndGetter
		IsDeprecated As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' This property is True if this option may safely be set to Nil.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.IsNullable
			  
			  return DefaultValue Is Nil
			End Get
		#tag EndGetter
		IsNullable As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The alias under which the option is known in libcURL (and elsewhere). e.g. "CURLOPT_CUSTOMREQUEST"
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.LibraryAlias
			  
			  Dim nm As String = GetOptionName(OptionNumber)
			  If nm <> "" Then nm = "CURLOPT_" + nm
			  Return nm
			End Get
		#tag EndGetter
		LibraryAlias As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a string containing the first libcurl version that supports this
			  ' option, if known. For example, "7.15.9".
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.MinimumVersion
			  
			  If mMinMajor = 0 Then Return ""
			  Return Str(mMinMajor) + "." + Str(mMinMinor) + "." + Str(mMinPatch)
			End Get
		#tag EndGetter
		MinimumVersion As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mMinMajor As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinMinor As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMinPatch As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOpt As curl_easyoption
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The name of the option without prefixes. e.g. "CUSTOMREQUEST"
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.Name
			  
			  Dim mb As MemoryBlock = mOpt.Name
			  If mb <> Nil Then
			    Return mb.CString(0)
			  Else
			    Return GetOptionName(OptionNumber)
			  End If
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The numeric value of the option.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.OptionNumber
			  
			  Return mOpt.Option
			End Get
		#tag EndGetter
		OptionNumber As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The datatype for values of this option. e.g. OptionType.String
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts.OptionInfo.Type
			  
			  If IsBooleanOption(OptionNumber) Then Return OptionType.Boolean
			  Return mOpt.Type
			End Get
		#tag EndGetter
		Type As libcURL.OptionType
	#tag EndComputedProperty


	#tag Constant, Name = CURLOT_FLAG_ALIAS, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant


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
			Name="BindingAlias"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DocumentationURL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsAvailable"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsDeprecated"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsNullable"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LibraryAlias"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="OptionNumber"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Int32"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
