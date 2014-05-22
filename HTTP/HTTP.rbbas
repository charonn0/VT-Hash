#tag Module
Protected Module HTTP
	#tag Method, Flags = &h0
		Function CRLF() As String
		  Return EndOfLine.Windows
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DateString(d As Date) As String
		  Dim dt As String
		  d.GMTOffset = 0
		  Select Case d.DayOfWeek
		  Case 1
		    dt = dt + "Sun, "
		  Case 2
		    dt = dt + "Mon, "
		  Case 3
		    dt = dt + "Tue, "
		  Case 4
		    dt = dt + "Wed, "
		  Case 5
		    dt = dt + "Thu, "
		  Case 6
		    dt = dt + "Fri, "
		  Case 7
		    dt = dt + "Sat, "
		  End Select
		  
		  dt = dt  + Format(d.Day, "00") + " "
		  
		  Select Case d.Month
		  Case 1
		    dt = dt + "Jan "
		  Case 2
		    dt = dt + "Feb "
		  Case 3
		    dt = dt + "Mar "
		  Case 4
		    dt = dt + "Apr "
		  Case 5
		    dt = dt + "May "
		  Case 6
		    dt = dt + "Jun "
		  Case 7
		    dt = dt + "Jul "
		  Case 8
		    dt = dt + "Aug "
		  Case 9
		    dt = dt + "Sep "
		  Case 10
		    dt = dt + "Oct "
		  Case 11
		    dt = dt + "Nov "
		  Case 12
		    dt = dt + "Dec "
		  End Select
		  
		  dt = dt  + Format(d.Year, "0000") + " " + Format(d.Hour, "00") + ":" + Format(d.Minute, "00") + ":" + Format(d.Second, "00") + " GMT"
		  Return dt
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DateString(Data As String) As Date
		  
		  'Sat, 29 Oct 1994 19:43:31 GMT
		  Data = ReplaceAll(Data, "-", " ")
		  Dim d As Date
		  Dim members() As String = Split(Data, " ")
		  If UBound(members) = 5 Then
		    Dim dom, mon, year, h, m, s, tz As Integer
		    
		    dom = Val(members(1))
		    
		    Select Case members(2)
		    Case "Jan"
		      mon = 1
		    Case "Feb"
		      mon = 2
		    Case "Mar"
		      mon = 3
		    Case "Apr"
		      mon = 4
		    Case "May"
		      mon = 5
		    Case "Jun"
		      mon = 6
		    Case "Jul"
		      mon = 7
		    Case "Aug"
		      mon = 8
		    Case "Sep"
		      mon = 9
		    Case "Oct"
		      mon = 10
		    Case "Nov"
		      mon = 11
		    Case "Dec"
		      mon = 12
		    End Select
		    
		    year = Val(members(3))
		    
		    Dim time As String = members(4)
		    h = Val(NthField(time, ":", 1))
		    m = Val(NthField(time, ":", 2))
		    s = Val(NthField(time, ":", 3))
		    tz = Val(members(5))
		    
		    
		    
		    d = New Date(year, mon, dom, h, m, s, tz)
		  End If
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatBytes(bytes As UInt64, precision As Integer = 2) As String
		  'Converts raw byte counts into SI formatted strings. 1KB = 1024 bytes.
		  'Optionally pass an integer representing the number of decimal places to return. The default is two decimal places. You may specify
		  'between 0 and 16 decimal places. Specifying more than 16 will append extra zeros to make up the length. Passing 0
		  'shows no decimal places and no decimal point.
		  
		  Const kilo = 1024
		  Static mega As UInt64 = kilo * kilo
		  Static giga As UInt64 = kilo * mega
		  Static tera As UInt64 = kilo * giga
		  Static peta As UInt64 = kilo * tera
		  Static exab As UInt64 = kilo * peta
		  
		  Dim suffix, precisionZeros As String
		  Dim strBytes As Double
		  
		  
		  If bytes < kilo Then
		    strbytes = bytes
		    suffix = "bytes"
		  ElseIf bytes >= kilo And bytes < mega Then
		    strbytes = bytes / kilo
		    suffix = "KB"
		  ElseIf bytes >= mega And bytes < giga Then
		    strbytes = bytes / mega
		    suffix = "MB"
		  ElseIf bytes >= giga And bytes < tera Then
		    strbytes = bytes / giga
		    suffix = "GB"
		  ElseIf bytes >= tera And bytes < peta Then
		    strbytes = bytes / tera
		    suffix = "TB"
		  ElseIf bytes >= tera And bytes < exab Then
		    strbytes = bytes / peta
		    suffix = "PB"
		  ElseIf bytes >= exab Then
		    strbytes = bytes / exab
		    suffix = "EB"
		  End If
		  
		  
		  While precisionZeros.Len < precision
		    precisionZeros = precisionZeros + "0"
		  Wend
		  If precisionZeros.Trim <> "" Then precisionZeros = "." + precisionZeros
		  
		  Return Format(strBytes, "#,###0" + precisionZeros) + suffix
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatSocketError(ErrorCode As Integer) As String
		  Dim err As String = "socket error " + Str(ErrorCode)
		  Select Case ErrorCode
		  Case 102
		    err = err + ": Disconnected."
		  Case 100
		    err = err + ": Could not create a socket!"
		  Case 103
		    err = err + ": Connection timed out."
		  Case 105
		    err = err + ": That port number is already in use."
		  Case 106
		    err = err + ": Socket is not ready for that command."
		  Case 107
		    err = err + ": Could not bind to port."
		  Case 108
		    err = err + ": Out of memory."
		  Else
		    err = err + ": System error code."
		  End Select
		  
		  Return err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatStatus(Code As Integer) As String
		  Select Case Code
		  Case 100
		    Return "Continue"
		    
		  Case 101
		    Return "Switching Protocols"
		    
		  Case 102
		    Return "Processing"
		    
		  Case 200
		    Return "OK"
		    
		  Case 201
		    Return "Created"
		    
		  Case 202
		    Return "Accepted"
		    
		  Case 203
		    Return "Non-Authoritative Information"
		    
		  Case 204
		    Return "No Content"
		    
		  Case 205
		    Return "Reset Content"
		    
		  Case 206
		    Return "Partial Content"
		    
		  Case 207
		    Return "Multi-Status"
		    
		  Case 208
		    Return "Already Reported"
		    
		    
		  Case 226
		    Return "IM Used"
		    
		  Case 300
		    Return "Multiple Choices"
		    
		  Case 301
		    Return "Moved Permanently"
		    
		  Case 302
		    Return "Found"
		    
		  Case 303
		    Return "See Other"
		    
		  Case 304
		    Return "Not Modified"
		    
		  Case 305
		    Return "Use Proxy"
		    
		  Case 306
		    Return "Switch Proxy"
		    
		  Case 307
		    Return "Temporary Redirect"
		    
		  Case 308 ' https://tools.ietf.org/html/draft-reschke-http-status-308-07
		    Return "Permanent Redirect"
		    
		  Case 400
		    Return "Bad Request"
		    
		  Case 401
		    Return "Unauthorized"
		    
		  Case 403
		    Return "Forbidden"
		    
		  Case 404
		    Return "Not Found"
		    
		  Case 405
		    Return "Method Not Allowed"
		    
		  Case 406
		    Return "Not Acceptable"
		    
		  Case 407
		    Return "Proxy Authentication Required"
		    
		  Case 408
		    Return "Request Timeout"
		    
		  Case 409
		    Return "Conflict"
		    
		  Case 410
		    Return "Gone"
		    
		  Case 411
		    Return "Length Required"
		    
		  Case 412
		    Return "Precondition Failed"
		    
		  Case 413
		    Return "Request Entity Too Large"
		    
		  Case 414
		    Return "Request-URI Too Long"
		    
		  Case 415
		    Return "Unsupported Media Type"
		    
		  Case 416
		    Return "Requested Range Not Satisfiable"
		    
		  Case 417
		    Return "Expectation Failed"
		    
		  Case 418
		    Return "I'm a teapot" ' https://tools.ietf.org/html/rfc2324
		    
		  Case 420
		    Return "Enhance Your Calm" 'Nonstandard, from Twitter API
		    
		  Case 422
		    Return "Unprocessable Entity"
		    
		  Case 423
		    Return "Locked"
		    
		  Case 424
		    Return "Failed Dependency"
		    
		  Case 425
		    Return "Unordered Collection" 'Draft, https://tools.ietf.org/html/rfc3648
		    
		  Case 426
		    Return "Upgrade Required"
		    
		  Case 428
		    Return "Precondition Required"
		    
		  Case 429
		    Return "Too Many Requests"
		    
		  Case 431
		    Return "Request Header Fields Too Large"
		    
		  Case 444
		    Return "No Response" 'Nginx
		    
		  Case 449
		    Return "Retry With" 'Nonstandard, from Microsoft http://msdn.microsoft.com/en-us/library/dd891478.aspx
		    
		  Case 450
		    Return "Blocked By Windows Parental Controls" 'Nonstandard, from Microsoft
		    
		  Case 451
		    Return "Unavailable For Legal Reasons" 'Draft, https://tools.ietf.org/html/draft-tbray-http-legally-restricted-status-00
		    
		  Case 494
		    Return "Request Header Too Large" 'nginx
		    
		  Case 495
		    Return "Cert Error" 'nginx
		    
		  Case 496
		    Return "No Cert" 'nginx
		    
		  Case 497
		    Return "HTTP to HTTPS" 'nginx
		    
		  Case 499
		    Return "Client Closed Request" 'nginx
		    
		  Case 500
		    Return "Internal Server Error"
		    
		  Case 501
		    Return "Not Implemented"
		    
		  Case 502
		    Return "Bad Gateway"
		    
		  Case 503
		    Return "Service Unavailable"
		    
		  Case 504
		    Return "Gateway Timeout"
		    
		  Case 505
		    Return "HTTP Version Not Supported"
		    
		  Case 506
		    Return "Variant Also Negotiates" 'WEBDAV https://tools.ietf.org/html/rfc2295
		    
		  Case 507
		    Return "Insufficient Storage" 'WEBDAV https://tools.ietf.org/html/rfc4918
		    
		  Case 508
		    Return "Loop Detected" 'WEBDAV https://tools.ietf.org/html/rfc5842
		    
		  Case 509
		    Return "Bandwidth Limit Exceeded" 'Apache, others
		    
		  Case 510
		    Return "Not Extended"  'https://tools.ietf.org/html/rfc2774
		    
		  Case 511
		    Return "Network Authentication Required" 'https://tools.ietf.org/html/rfc6585
		    
		  Else
		    Return "Unknown Status Code"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReplyString(Code As Integer, ProtoVer As Single = 1.1) As String
		  'Returns the properly formatted HTTP response line for a given HTTP status code.
		  'e.g. HTTP.ReplyString(404) = "HTTP/1.1 404 Not Found"
		  
		  Return "HTTP/" + Format(ProtoVer, "0.0") + " " + Str(Code) + " " + HTTP.FormatStatus(code)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URLDecodeForm(urlencodedform As String) As Dictionary
		  Dim items() As String = Split(urlencodedform.Trim, "&")
		  Dim form As New Dictionary
		  Dim dcount As Integer = UBound(items)
		  For i As Integer = 0 To dcount
		    form.Value(DecodeURLComponent(NthField(items(i), "=", 1))) = DecodeURLComponent(NthField(items(i), "=", 2))
		  Next
		  
		  Return form
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URLEncodeForm(PostData As Dictionary) As String
		  Dim data() As String
		  For Each key As String in PostData.Keys
		    data.Append(EncodeURLComponent(Key) + "=" + EncodeURLComponent(PostData.Value(key)))
		  Next
		  Return Join(data, "&")
		End Function
	#tag EndMethod


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
