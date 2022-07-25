#tag Class
Protected Class InfoType
	#tag Method, Flags = &h1
		Protected Sub Constructor(InfoNumber As Integer)
		  mNumber = InfoNumber
		  Call GetInfoFirstVersion(mNumber, mMinMajor, mMinMinor, mMinPatch)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function GetInfoByName(Name As String) As Int32
		  Name = Replace(Name, "CURLINFO_", "")
		  Name = Replace(Name, "libcURL.Info.", "")
		  Select Case Name
		  Case "ACTIVESOCKET"
		    Return ACTIVESOCKET
		  Case "APPCONNECT_TIME"
		    Return APPCONNECT_TIME
		  Case "APPCONNECT_TIME_T"
		    Return APPCONNECT_TIME_T
		  Case "CERTINFO"
		    Return CERTINFO
		  Case "CONDITION_UNMET"
		    Return CONDITION_UNMET
		  Case "CONNECT_TIME"
		    Return CONNECT_TIME
		  Case "CONNECT_TIME_T"
		    Return CONNECT_TIME_T
		  Case "CONTENT_LENGTH_DOWNLOAD"
		    Return CONTENT_LENGTH_DOWNLOAD
		  Case "CONTENT_LENGTH_DOWNLOAD_T"
		    Return CONTENT_LENGTH_DOWNLOAD_T
		  Case "CONTENT_LENGTH_UPLOAD"
		    Return CONTENT_LENGTH_UPLOAD
		  Case "CONTENT_LENGTH_UPLOAD_T"
		    Return CONTENT_LENGTH_UPLOAD_T
		  Case "CONTENT_TYPE"
		    Return CONTENT_TYPE
		  Case "COOKIELIST"
		    Return COOKIELIST
		  Case "EFFECTIVE_METHOD"
		    Return EFFECTIVE_METHOD
		  Case "EFFECTIVE_URL"
		    Return EFFECTIVE_URL
		  Case "FILETIME"
		    Return FILETIME
		  Case "FILETIME_T"
		    Return FILETIME_T
		  Case "FTP_ENTRY_PATH"
		    Return FTP_ENTRY_PATH
		  Case "HEADER_SIZE"
		    Return HEADER_SIZE
		  Case "HTTPAUTH_AVAIL"
		    Return HTTPAUTH_AVAIL
		  Case "HTTP_CONNECTCODE"
		    Return HTTP_CONNECTCODE
		  Case "HTTP_VERSION"
		    Return HTTP_VERSION
		  Case "LASTSOCKET"
		    Return LASTSOCKET
		  Case "LOCAL_IP"
		    Return LOCAL_IP
		  Case "LOCAL_PORT"
		    Return LOCAL_PORT
		  Case "NAMELOOKUP_TIME"
		    Return NAMELOOKUP_TIME
		  Case "NAMELOOKUP_TIME_T"
		    Return NAMELOOKUP_TIME_T
		  Case "NUM_CONNECTS"
		    Return NUM_CONNECTS
		  Case "OS_ERRNO"
		    Return OS_ERRNO
		  Case "PRETRANSFER_TIME"
		    Return PRETRANSFER_TIME
		  Case "PRETRANSFER_TIME_T"
		    Return PRETRANSFER_TIME_T
		  Case "PRIMARY_IP"
		    Return PRIMARY_IP
		  Case "PRIMARY_PORT"
		    Return PRIMARY_PORT
		  Case "PRIVATE"
		    Return PRIVATE_
		  Case "PROTOCOL"
		    Return PROTOCOL
		  Case "PROXYAUTH_AVAIL"
		    Return PROXYAUTH_AVAIL
		  Case "PROXY_ERROR"
		    Return PROXY_ERROR
		  Case "PROXY_SSL_VERIFYRESULT"
		    Return PROXY_SSL_VERIFYRESULT
		  Case "REDIRECT_COUNT"
		    Return REDIRECT_COUNT
		  Case "REDIRECT_TIME"
		    Return REDIRECT_TIME
		  Case "REDIRECT_TIME_T"
		    Return REDIRECT_TIME_T
		  Case "REDIRECT_URL"
		    Return REDIRECT_URL
		  Case "REFERER"
		    Return REFERER
		  Case "REQUEST_SIZE"
		    Return REQUEST_SIZE
		  Case "RESPONSE_CODE"
		    Return RESPONSE_CODE
		  Case "RETRY_AFTER"
		    Return RETRY_AFTER
		  Case "RTSP_CLIENT_CSEQ"
		    Return RTSP_CLIENT_CSEQ
		  Case "RTSP_CSEQ_RECV"
		    Return RTSP_CSEQ_RECV
		  Case "RTSP_SERVER_CSEQ"
		    Return RTSP_SERVER_CSEQ
		  Case "RTSP_SESSION_ID"
		    Return RTSP_SESSION_ID
		  Case "SCHEME"
		    Return SCHEME
		  Case "SIZE_DOWNLOAD"
		    Return SIZE_DOWNLOAD
		  Case "SIZE_DOWNLOAD_T"
		    Return SIZE_DOWNLOAD_T
		  Case "SIZE_UPLOAD"
		    Return SIZE_UPLOAD
		  Case "SIZE_UPLOAD_T"
		    Return SIZE_UPLOAD_T
		  Case "SPEED_DOWNLOAD"
		    Return SPEED_DOWNLOAD
		  Case "SPEED_DOWNLOAD_T"
		    Return SPEED_DOWNLOAD_T
		  Case "SPEED_UPLOAD"
		    Return SPEED_UPLOAD
		  Case "SPEED_UPLOAD_T"
		    Return SPEED_UPLOAD_T
		  Case "SSL_ENGINES"
		    Return SSL_ENGINES
		  Case "SSL_VERIFYRESULT"
		    Return SSL_VERIFYRESULT
		  Case "STARTTRANSFER_TIME"
		    Return STARTTRANSFER_TIME
		  Case "STARTTRANSFER_TIME_T"
		    Return STARTTRANSFER_TIME_T
		  Case "TLS_SESSION"
		    Return TLS_SESSION
		  Case "TLS_SSL_PTR"
		    Return TLS_SSL_PTR
		  Case "TOTAL_TIME"
		    Return TOTAL_TIME
		  Case "TOTAL_TIME_T"
		    Return TOTAL_TIME_T
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function GetInfoFirstVersion(InfoNumber As Int32, ByRef Major As Integer, ByRef Minor As Integer, ByRef Patch As Integer) As Boolean
		  Dim tmp As String
		  Select Case InfoNumber
		  Case ACTIVESOCKET
		    tmp = "7.45.0"
		  Case APPCONNECT_TIME
		    tmp = "7.19.0"
		  Case APPCONNECT_TIME_T
		    tmp = "7.61.0"
		  Case CERTINFO
		    tmp = "7.19.1"
		  Case CONDITION_UNMET
		    tmp = "7.19.4"
		  Case CONNECT_TIME
		    tmp = "7.4.1"
		  Case CONNECT_TIME_T
		    tmp = "7.61.0"
		  Case CONTENT_LENGTH_DOWNLOAD
		    tmp = "7.6.1"
		  Case CONTENT_LENGTH_DOWNLOAD_T
		    tmp = "7.55.0"
		  Case CONTENT_LENGTH_UPLOAD
		    tmp = "7.6.1"
		  Case CONTENT_LENGTH_UPLOAD_T
		    tmp = "7.55.0"
		  Case CONTENT_TYPE
		    tmp = "7.9.4"
		  Case COOKIELIST
		    tmp = "7.14.1"
		  Case EFFECTIVE_METHOD
		    tmp = "7.72.0"
		  Case EFFECTIVE_URL
		    tmp = "7.4"
		  Case FILETIME
		    tmp = "7.5"
		  Case FILETIME_T
		    tmp = "7.59.0"
		  Case FTP_ENTRY_PATH
		    tmp = "7.15.4"
		  Case HEADER_SIZE
		    tmp = "7.4.1"
		  Case HTTPAUTH_AVAIL
		    tmp = "7.10.8"
		  Case HTTP_CONNECTCODE
		    tmp = "7.10.7"
		  Case HTTP_VERSION
		    tmp = "7.50.0"
		  Case LASTSOCKET
		    tmp = "7.15.2"
		  Case LOCAL_IP
		    tmp = "7.21.0"
		  Case LOCAL_PORT
		    tmp = "7.21.0"
		  Case NAMELOOKUP_TIME
		    tmp = "7.4.1"
		  Case NAMELOOKUP_TIME_T
		    tmp = "7.61.0"
		  Case NUM_CONNECTS
		    tmp = "7.12.3"
		  Case OS_ERRNO
		    tmp = "7.12.2"
		  Case PRETRANSFER_TIME
		    tmp = "7.4.1"
		  Case PRETRANSFER_TIME_T
		    tmp = "7.61.0"
		  Case PRIMARY_IP
		    tmp = "7.19.0"
		  Case PRIMARY_PORT
		    tmp = "7.21.0"
		  Case PRIVATE_
		    tmp = "7.10.3"
		  Case PROTOCOL
		    tmp = "7.52.0"
		  Case PROXYAUTH_AVAIL
		    tmp = "7.10.8"
		  Case PROXY_ERROR
		    tmp = "7.73.0"
		  Case PROXY_SSL_VERIFYRESULT
		    tmp = "7.52.0"
		  Case REDIRECT_COUNT
		    tmp = "7.9.7"
		  Case REDIRECT_TIME
		    tmp = "7.9.7"
		  Case REDIRECT_TIME_T
		    tmp = "7.61.0"
		  Case REDIRECT_URL
		    tmp = "7.18.2"
		  Case REFERER
		    tmp = "7.76.0"
		  Case REQUEST_SIZE
		    tmp = "7.4.1"
		  Case RESPONSE_CODE
		    tmp = "7.10.8"
		  Case RETRY_AFTER
		    tmp = "7.66.0"
		  Case RTSP_CLIENT_CSEQ
		    tmp = "7.20.0"
		  Case RTSP_CSEQ_RECV
		    tmp = "7.20.0"
		  Case RTSP_SERVER_CSEQ
		    tmp = "7.20.0"
		  Case RTSP_SESSION_ID
		    tmp = "7.20.0"
		  Case SCHEME
		    tmp = "7.52.0"
		  Case SIZE_DOWNLOAD
		    tmp = "7.4.1"
		  Case SIZE_DOWNLOAD_T
		    tmp = "7.55.0"
		  Case SIZE_UPLOAD
		    tmp = "7.4.1"
		  Case SIZE_UPLOAD_T
		    tmp = "7.55.0"
		  Case SPEED_DOWNLOAD
		    tmp = "7.4.1"
		  Case SPEED_DOWNLOAD_T
		    tmp = "7.55.0"
		  Case SPEED_UPLOAD
		    tmp = "7.4.1"
		  Case SPEED_UPLOAD_T
		    tmp = "7.55.0"
		  Case SSL_ENGINES
		    tmp = "7.12.3"
		  Case SSL_VERIFYRESULT
		    tmp = "7.5"
		  Case STARTTRANSFER_TIME
		    tmp = "7.9.2"
		  Case STARTTRANSFER_TIME_T
		    tmp = "7.61.0"
		  Case TLS_SESSION
		    tmp = "7.34.0"
		  Case TLS_SSL_PTR
		    tmp = "7.48.0"
		  Case TOTAL_TIME
		    tmp = "7.4.1"
		  Case TOTAL_TIME_T
		    tmp = "7.61.0"
		  End Select
		  If tmp = "" Then Return False
		  Major = Val(NthField(tmp, ".", 1))
		  Minor = Val(NthField(tmp, ".", 2))
		  Patch = Val(NthField(tmp, ".", 3))
		  Return True
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function GetInfoName(InfoNumber As Int32) As String
		  Select Case InfoNumber
		  Case ACTIVESOCKET
		    Return "ACTIVESOCKET"
		  Case APPCONNECT_TIME
		    Return "APPCONNECT_TIME"
		  Case APPCONNECT_TIME
		    Return "APPCONNECT_TIME"
		  Case APPCONNECT_TIME_T
		    Return "APPCONNECT_TIME_T"
		  Case APPCONNECT_TIME_T
		    Return "APPCONNECT_TIME_T"
		  Case CERTINFO
		    Return "CERTINFO"
		  Case CONDITION_UNMET
		    Return "CONDITION_UNMET"
		  Case CONNECT_TIME
		    Return "CONNECT_TIME"
		  Case CONNECT_TIME
		    Return "CONNECT_TIME"
		  Case CONNECT_TIME_T
		    Return "CONNECT_TIME_T"
		  Case CONNECT_TIME_T
		    Return "CONNECT_TIME_T"
		  Case CONTENT_LENGTH_DOWNLOAD
		    Return "CONTENT_LENGTH_DOWNLOAD"
		  Case CONTENT_LENGTH_DOWNLOAD_T
		    Return "CONTENT_LENGTH_DOWNLOAD_T"
		  Case CONTENT_LENGTH_UPLOAD
		    Return "CONTENT_LENGTH_UPLOAD"
		  Case CONTENT_LENGTH_UPLOAD_T
		    Return "CONTENT_LENGTH_UPLOAD_T"
		  Case CONTENT_TYPE
		    Return "CONTENT_TYPE"
		  Case COOKIELIST
		    Return "COOKIELIST"
		  Case EFFECTIVE_METHOD
		    Return "EFFECTIVE_METHOD"
		  Case EFFECTIVE_URL
		    Return "EFFECTIVE_URL"
		  Case FILETIME
		    Return "FILETIME"
		  Case FILETIME_T
		    Return "FILETIME_T"
		  Case FTP_ENTRY_PATH
		    Return "FTP_ENTRY_PATH"
		  Case HEADER_SIZE
		    Return "HEADER_SIZE"
		  Case HTTPAUTH_AVAIL
		    Return "HTTPAUTH_AVAIL"
		  Case HTTP_CONNECTCODE
		    Return "HTTP_CONNECTCODE"
		  Case HTTP_VERSION
		    Return "HTTP_VERSION"
		  Case LASTSOCKET
		    Return "LASTSOCKET"
		  Case LOCAL_IP
		    Return "LOCAL_IP"
		  Case LOCAL_PORT
		    Return "LOCAL_PORT"
		  Case NAMELOOKUP_TIME
		    Return "NAMELOOKUP_TIME"
		  Case NAMELOOKUP_TIME
		    Return "NAMELOOKUP_TIME"
		  Case NAMELOOKUP_TIME_T
		    Return "NAMELOOKUP_TIME_T"
		  Case NAMELOOKUP_TIME_T
		    Return "NAMELOOKUP_TIME_T"
		  Case NUM_CONNECTS
		    Return "NUM_CONNECTS"
		  Case OS_ERRNO
		    Return "OS_ERRNO"
		  Case PRETRANSFER_TIME
		    Return "PRETRANSFER_TIME"
		  Case PRETRANSFER_TIME
		    Return "PRETRANSFER_TIME"
		  Case PRETRANSFER_TIME_T
		    Return "PRETRANSFER_TIME_T"
		  Case PRETRANSFER_TIME_T
		    Return "PRETRANSFER_TIME_T"
		  Case PRIMARY_IP
		    Return "PRIMARY_IP"
		  Case PRIMARY_PORT
		    Return "PRIMARY_PORT"
		  Case PRIVATE_
		    Return "PRIVATE"
		  Case PROTOCOL
		    Return "PROTOCOL"
		  Case PROXYAUTH_AVAIL
		    Return "PROXYAUTH_AVAIL"
		  Case PROXY_ERROR
		    Return "PROXY_ERROR"
		  Case PROXY_SSL_VERIFYRESULT
		    Return "PROXY_SSL_VERIFYRESULT"
		  Case REDIRECT_COUNT
		    Return "REDIRECT_COUNT"
		  Case REDIRECT_TIME
		    Return "REDIRECT_TIME"
		  Case REDIRECT_TIME
		    Return "REDIRECT_TIME"
		  Case REDIRECT_TIME_T
		    Return "REDIRECT_TIME_T"
		  Case REDIRECT_TIME_T
		    Return "REDIRECT_TIME_T"
		  Case REDIRECT_URL
		    Return "REDIRECT_URL"
		  Case REFERER
		    Return "REFERER"
		  Case REQUEST_SIZE
		    Return "REQUEST_SIZE"
		  Case RESPONSE_CODE
		    Return "RESPONSE_CODE"
		  Case RETRY_AFTER
		    Return "RETRY_AFTER"
		  Case RTSP_CLIENT_CSEQ
		    Return "RTSP_CLIENT_CSEQ"
		  Case RTSP_CSEQ_RECV
		    Return "RTSP_CSEQ_RECV"
		  Case RTSP_SERVER_CSEQ
		    Return "RTSP_SERVER_CSEQ"
		  Case RTSP_SESSION_ID
		    Return "RTSP_SESSION_ID"
		  Case SCHEME
		    Return "SCHEME"
		  Case SIZE_DOWNLOAD
		    Return "SIZE_DOWNLOAD"
		  Case SIZE_DOWNLOAD_T
		    Return "SIZE_DOWNLOAD_T"
		  Case SIZE_UPLOAD
		    Return "SIZE_UPLOAD"
		  Case SIZE_UPLOAD_T
		    Return "SIZE_UPLOAD_T"
		  Case SPEED_DOWNLOAD
		    Return "SPEED_DOWNLOAD"
		  Case SPEED_DOWNLOAD_T
		    Return "SPEED_DOWNLOAD_T"
		  Case SPEED_UPLOAD
		    Return "SPEED_UPLOAD"
		  Case SPEED_UPLOAD_T
		    Return "SPEED_UPLOAD_T"
		  Case SSL_ENGINES
		    Return "SSL_ENGINES"
		  Case SSL_VERIFYRESULT
		    Return "SSL_VERIFYRESULT"
		  Case STARTTRANSFER_TIME
		    Return "STARTTRANSFER_TIME"
		  Case STARTTRANSFER_TIME
		    Return "STARTTRANSFER_TIME"
		  Case STARTTRANSFER_TIME_T
		    Return "STARTTRANSFER_TIME_T"
		  Case STARTTRANSFER_TIME_T
		    Return "STARTTRANSFER_TIME_T"
		  Case TLS_SESSION
		    Return "TLS_SESSION"
		  Case TLS_SSL_PTR
		    Return "TLS_SSL_PTR"
		  Case TOTAL_TIME
		    Return "TOTAL_TIME"
		  Case TOTAL_TIME
		    Return "TOTAL_TIME"
		  Case TOTAL_TIME_T
		    Return "TOTAL_TIME_T"
		  Case TOTAL_TIME_T
		    Return "TOTAL_TIME_T"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function GetInfoType(InfoNumber As Integer) As Integer
		  Select Case InfoNumber
		  Case libcURL.Info.EFFECTIVE_URL, libcURL.Info.REDIRECT_URL, libcURL.Info.CONTENT_TYPE, libcURL.Info.PRIVATE_, libcURL.Info.PRIMARY_IP, _
		    libcURL.Info.LOCAL_IP, libcURL.Info.FTP_ENTRY_PATH, libcURL.Info.RTSP_SESSION_ID, libcURL.Info.SCHEME, libcURL.Info.EFFECTIVE_METHOD, _
		    libcURL.Info.REFERER
		    Return Variant.TypeString
		    
		  Case libcURL.Info.RESPONSE_CODE, libcURL.Info.HTTP_CONNECTCODE, libcURL.Info.REDIRECT_COUNT, libcURL.Info.HEADER_SIZE, _
		    libcURL.Info.REQUEST_SIZE, libcURL.Info.SSL_VERIFYRESULT, libcURL.Info.OS_ERRNO, _
		    libcURL.Info.NUM_CONNECTS, libcURL.Info.PRIMARY_PORT, libcURL.Info.LOCAL_PORT, libcURL.Info.LASTSOCKET, libcURL.Info.CONDITION_UNMET, _
		    libcURL.Info.RTSP_CLIENT_CSEQ, libcURL.Info.RTSP_SERVER_CSEQ, libcURL.Info.RTSP_CSEQ_RECV, libcURL.Info.HTTP_VERSION, libcURL.Info.PROTOCOL, _
		    libcURL.Info.PROXY_SSL_VERIFYRESULT, libcURL.Info.ACTIVESOCKET
		    Return Variant.TypeInteger
		    
		  Case libcURL.Info.PROXY_ERROR
		    Return Variant.TypeInteger
		    
		  Case libcURL.Info.FILETIME
		    Return Variant.TypeDate
		    
		  Case libcurl.Info.PROXYAUTH_AVAIL, libcURL.Info.HTTPAUTH_AVAIL
		    Return Variant.TypeInteger
		    
		  Case libcURL.Info.TOTAL_TIME, libcURL.Info.NAMELOOKUP_TIME, libcURL.Info.CONNECT_TIME, libcURL.Info.APPCONNECT_TIME, libcURL.Info.PRETRANSFER_TIME, _
		    libcURL.Info.STARTTRANSFER_TIME, libcURL.Info.REDIRECT_TIME, libcURL.Info.SIZE_DOWNLOAD, libcURL.Info.SIZE_UPLOAD, libcURL.Info.SPEED_DOWNLOAD, _
		    libcURL.Info.SPEED_UPLOAD, libcURL.Info.CONTENT_LENGTH_UPLOAD, libcURL.Info.CONTENT_LENGTH_DOWNLOAD
		    Return Variant.TypeDouble
		    
		  Case libcURL.Info.TOTAL_TIME_T, libcURL.Info.NAMELOOKUP_TIME_T, libcURL.Info.CONNECT_TIME_T, libcURL.Info.APPCONNECT_TIME_T, _
		    libcURL.Info.PRETRANSFER_TIME_T, libcURL.Info.STARTTRANSFER_TIME_T, libcURL.Info.REDIRECT_TIME_T, libcURL.Info.SIZE_DOWNLOAD_T, _
		    libcURL.Info.SIZE_UPLOAD_T, libcURL.Info.SPEED_DOWNLOAD_T, libcURL.Info.SPEED_UPLOAD_T, libcURL.Info.CONTENT_LENGTH_UPLOAD_T, _
		    libcURL.Info.CONTENT_LENGTH_DOWNLOAD_T
		    Return Variant.TypeLong
		    
		  Case libcURL.Info.SSL_ENGINES, libcURL.Info.COOKIELIST
		    Return Variant.TypeArray
		    
		  Else
		    Return Variant.TypeNil
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherInfo As libcURL.Info.InfoType) As Integer
		  ' Compares this InfoType to another InfoType. InfoType instances are considered equal if
		  ' they represent the same info type number. Since the InfoType class automatically converts
		  ' from an Int32, you can compare an instance of InfoType to a literal number using this method.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.Operator_Compare
		  
		  If OtherInfo Is Nil Then Return 1 Else Return Sign(Number - OtherInfo.Number)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Int32
		  ' This method overloads the conversion operator (=) allowing direct conversion to an Int32.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.Operator_Convert
		  
		  Return Number
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(InfoID As Int32)
		  ' This method overloads the conversion operator (=) allowing direct conversion from an Int32.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.Operator_Convert
		  
		  Me.Constructor(InfoID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Name As String)
		  ' This method overloads the conversion operator (=) allowing direct conversion from
		  ' the name or alias of an infotype.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.Operator_Convert
		  
		  Me.Constructor(GetInfoByName(Name))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(Session As libcURL.EasyHandle) As String
		  ' A string representation, if one is available, of the current value of the infotype
		  ' for the specified EasyHandle.
		  ' This method is useful for displaying values to the user. If no string representation
		  ' can be provided, for example if the option hasn't been set, then an empty string is returned.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.StringValue
		  
		  Me.Constructor(GetInfoByName(Name))
		  
		  
		  Dim mb As MemoryBlock
		  
		  Select Case Number
		    ' strings
		  Case libcURL.Info.EFFECTIVE_URL, libcURL.Info.REDIRECT_URL, libcURL.Info.CONTENT_TYPE, libcURL.Info.PRIVATE_, libcURL.Info.PRIMARY_IP, _
		    libcURL.Info.LOCAL_IP, libcURL.Info.FTP_ENTRY_PATH, libcURL.Info.RTSP_SESSION_ID, libcURL.Info.SCHEME, libcURL.Info.EFFECTIVE_METHOD, _
		    libcURL.Info.REFERER
		    #If Target32Bit Then
		      mb = New MemoryBlock(4)
		    #Else
		      mb = New MemoryBlock(8)
		    #Endif
		    If Session.GetInfo(Number, mb) Then
		      mb = mb.Ptr(0)
		      If mb <> Nil Then Return mb.CString(0)
		    End If
		    
		    ' Int32s
		  Case libcURL.Info.RESPONSE_CODE, libcURL.Info.HTTP_CONNECTCODE, libcURL.Info.REDIRECT_COUNT, libcURL.Info.HEADER_SIZE, _
		    libcURL.Info.REQUEST_SIZE, libcURL.Info.SSL_VERIFYRESULT, libcURL.Info.OS_ERRNO, _
		    libcURL.Info.NUM_CONNECTS, libcURL.Info.PRIMARY_PORT, libcURL.Info.LOCAL_PORT, libcURL.Info.LASTSOCKET, libcURL.Info.CONDITION_UNMET, _
		    libcURL.Info.RTSP_CLIENT_CSEQ, libcURL.Info.RTSP_SERVER_CSEQ, libcURL.Info.RTSP_CSEQ_RECV, libcURL.Info.HTTP_VERSION, libcURL.Info.PROTOCOL, _
		    libcURL.Info.PROXY_SSL_VERIFYRESULT, libcURL.Info.ACTIVESOCKET
		    mb = New MemoryBlock(4)
		    If Session.GetInfo(Number, mb) Then Return Str(mb.Int32Value(0))
		    
		  Case libcURL.Info.PROXY_ERROR
		    mb = New MemoryBlock(4)
		    If Session.GetInfo(Number, mb) Then Return Str(mb.Int32Value(0))
		    
		    ' dates
		  Case libcURL.Info.FILETIME
		    mb = New MemoryBlock(4)
		    If Session.GetInfo(Number, mb) Then
		      Dim t As Int32 = mb.Int32Value(0)
		      If t >= 0 Then
		        Dim d As New Date(1970, 1, 1, 0, 0, 0, 0.0) 'UNIX epoch
		        d.TotalSeconds = d.TotalSeconds + t
		        Return libcURL.ParseDate(d)
		      End If
		    End If
		    
		    ' HTTPAuthMethods
		  Case libcurl.Info.PROXYAUTH_AVAIL, libcURL.Info.HTTPAUTH_AVAIL
		    mb = New MemoryBlock(4)
		    If Session.GetInfo(Number, mb) Then
		      Dim h As libcURL.HTTPAuthMethods = mb.Int32Value(0)
		      Dim i As Integer = h.Mask
		      Return Str(i)
		    End If
		    
		    ' Doubles
		  Case libcURL.Info.TOTAL_TIME, libcURL.Info.NAMELOOKUP_TIME, libcURL.Info.CONNECT_TIME, libcURL.Info.APPCONNECT_TIME, libcURL.Info.PRETRANSFER_TIME, _
		    libcURL.Info.STARTTRANSFER_TIME, libcURL.Info.REDIRECT_TIME, libcURL.Info.SIZE_DOWNLOAD, libcURL.Info.SIZE_UPLOAD, libcURL.Info.SPEED_DOWNLOAD, _
		    libcURL.Info.SPEED_UPLOAD, libcURL.Info.CONTENT_LENGTH_UPLOAD, libcURL.Info.CONTENT_LENGTH_DOWNLOAD
		    mb = New MemoryBlock(8)
		    If Session.GetInfo(Number, mb) Then Return Format(mb.DoubleValue(0), "-###,###,##0.0#####")
		    
		    ' Int64s
		  Case libcURL.Info.TOTAL_TIME_T, libcURL.Info.NAMELOOKUP_TIME_T, libcURL.Info.CONNECT_TIME_T, libcURL.Info.APPCONNECT_TIME_T, _
		    libcURL.Info.PRETRANSFER_TIME_T, libcURL.Info.STARTTRANSFER_TIME_T, libcURL.Info.REDIRECT_TIME_T, libcURL.Info.SIZE_DOWNLOAD_T, _
		    libcURL.Info.SIZE_UPLOAD_T, libcURL.Info.SPEED_DOWNLOAD_T, libcURL.Info.SPEED_UPLOAD_T, libcURL.Info.CONTENT_LENGTH_UPLOAD_T, _
		    libcURL.Info.CONTENT_LENGTH_DOWNLOAD_T
		    mb = New MemoryBlock(8)
		    If Session.GetInfo(Number, mb) Then Return Str(mb.Int64Value(0))
		    
		    ' ListPtrs
		  Case libcURL.Info.SSL_ENGINES, libcURL.Info.COOKIELIST
		    #If Target32Bit Then
		      mb = New MemoryBlock(4)
		    #Else
		      mb = New MemoryBlock(8)
		    #Endif
		    If Session.GetInfo(Number, mb) And mb.Ptr(0) <> Nil Then
		      Dim l As New ListPtr(mb.Ptr(0))
		      Return Join(l, EndOfLine)
		    End If
		    
		  Else
		    Return ""
		  End Select
		  
		  Exception
		    Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Session As libcURL.EasyHandle) As Variant
		  ' Returns the current value of the infotype for the specified EasyHandle.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.Value
		  
		  Return Session.GetInfo(Number)
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The alias under which the infotype is known in Xojo. e.g. "libcURL.Info.EFFECTIVE_METHOD"
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.BindingAlias
			  
			  Dim nm As String = GetInfoName(Number)
			  If nm <> "" Then nm = "libcURL.Info." + nm
			  Return nm
			End Get
		#tag EndGetter
		BindingAlias As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The URL to the documentation for this infotype on the libcurl website.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.DocumentationURL
			  
			  If Name <> "" And Not IsDeprecated Then Return "https://curl.haxx.se/libcurl/c/" + LibraryAlias + ".html"
			End Get
		#tag EndGetter
		DocumentationURL As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' This property is True if this infotype is available at runtime.
			  '
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.IsAvailable
			  
			  If mMinMajor = 0 Then Return True
			  Return libcURL.Version.IsAtLeast(mMinMajor, mMinMinor, mMinPatch)
			End Get
		#tag EndGetter
		IsAvailable As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' This property is True if this infotype has been deprecated.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.IsDeprecated
			  
			  Select Case Number
			  Case SIZE_UPLOAD, SIZE_DOWNLOAD, SPEED_DOWNLOAD, SPEED_UPLOAD, CONTENT_LENGTH_DOWNLOAD, CONTENT_LENGTH_UPLOAD
			    Return libcURL.Version.IsAtLeast(7, 55, 0)
			  Case TLS_SESSION
			    Return libcURL.Version.IsAtLeast(7, 48, 0)
			  End Select
			End Get
		#tag EndGetter
		IsDeprecated As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The alias under which the infotype is known in libcURL (and elsewhere). e.g. "CURLINFO_EFFECTIVE_METHOD"
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.LibraryAlias
			  
			  Dim nm As String = GetInfoName(Number)
			  If nm <> "" Then nm = "CURLINFO_" + nm
			  Return nm
			End Get
		#tag EndGetter
		LibraryAlias As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a string containing the first libcurl version that supports this
			  ' infotype, if known. For example, "7.15.9".
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.MinimumVersion
			  
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
		Private mNumber As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The name of the infotype without prefixes. e.g. "EFFECTIVE_METHOD"
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.Name
			  
			  Return GetInfoName(Number)
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The numeric value of the infotype.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.Number
			  
			  Return mNumber
			End Get
		#tag EndGetter
		Number As Int32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the infotype is deprecated then this will hold a reference to another
			  ' InfoType for the replacement infotype. If there is no replacement then
			  ' this value is Nil.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.Replacement
			  
			  If Not IsDeprecated Then Return Nil
			  Select Case Number
			  Case SIZE_UPLOAD
			    Return SIZE_UPLOAD_T
			  Case SIZE_DOWNLOAD
			    Return SIZE_DOWNLOAD_T
			  Case SPEED_DOWNLOAD
			    Return SPEED_DOWNLOAD_T
			  CAse SPEED_UPLOAD
			    Return SPEED_UPLOAD_T
			  Case CONTENT_LENGTH_DOWNLOAD
			    Return CONTENT_LENGTH_DOWNLOAD_T
			  Case CONTENT_LENGTH_UPLOAD
			    Return CONTENT_LENGTH_UPLOAD_T
			  Case TLS_SESSION
			    Return TLS_SSL_PTR
			  End Select
			End Get
		#tag EndGetter
		Replacement As libcURL.Info.InfoType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The Xojo datatype for values of this infotype. e.g. Variant.TypeString.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Info.InfoType.Type
			  
			  Return GetInfoType(Number)
			End Get
		#tag EndGetter
		Type As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
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
			Name="Number"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Int32"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
