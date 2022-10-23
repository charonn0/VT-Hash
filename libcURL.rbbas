#tag Module
Protected Module libcURL
	#tag Method, Flags = &h21
		Private Function AbsolutePath_(Extends f As FolderItem) As String
		  #If RBVersion > 2019 Then
		    Return f.NativePath
		  #Else
		    Return f.AbsolutePath
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CompareDomains(Hostname1 As String, Hostname2 As String, Optional EasyItem As libcURL.EasyHandle) As Boolean
		  ' Compares Hostname1 and Hostname2 to determine whether they belong to the same subdomain.
		  ' For example 'api.example.com' matches 'example.com' and 'api.example.com' but not 'www.example.com'
		  ' libcurl needs a curl_easy handle to URLdecode data. If EasyItem is not Nil, then the EasyItem is 
		  ' used; otherwise a new EasyHandle is constructed.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CompareDomains
		  ' https://github.com/charonn0/RB-libcURL/wiki/HTTP-Cookies-Example#domain-name-matching
		  
		  Dim tmp() As String = Split(Hostname1, ".")
		  Dim h1() As String
		  For i As Integer = 0 To UBound(tmp)
		    If tmp(i).Trim = "" Then Continue
		    h1.Insert(0, URLDecode(tmp(i), EasyItem))
		  Next
		  
		  tmp = Split(Hostname2, ".")
		  Dim h2() As String
		  For i As Integer = 0 To UBound(tmp)
		    If tmp(i).Trim = "" Then Continue
		    h2.Insert(0, URLDecode(tmp(i), EasyItem))
		  Next
		  
		  Dim count As Integer = Min(h1.Ubound, h2.Ubound)
		  For i As Integer = 0 To count
		    If StrComp(h1(i), h2(i), 0) <> 0 Then Return False
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_easy_cleanup Lib cURLLib (EasyHandle As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_duphandle Lib cURLLib (EasyHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_escape Lib cURLLib (EasyHandle As Integer, CharBuffer As Ptr, Length As Integer) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_getinfo Lib cURLLib (EasyHandle As Integer, InfoCode As Integer, Buffer As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_header Lib cURLLib (EasyHandle As Integer, Name As CString, Index As UInt32, Origin As UInt32, Request As Int32, ByRef HeadersStruct As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_init Lib cURLLib () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_nextheader Lib cURLLib (EasyHandle As Integer, Origin As UInt32, Request As Integer, PrevHeadersStruct As Ptr) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_pause Lib cURLLib (EasyHandle As Integer, Mask As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_perform Lib cURLLib (EasyHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_recv Lib cURLLib (EasyHandle As Integer, Buffer As Ptr, BytesToRead As Integer, ByRef BytesRead As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_easy_reset Lib cURLLib (EasyHandle As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_send Lib cURLLib (EasyHandle As Integer, Buffer As Ptr, BytesToWrite As Integer, ByRef BytesWritten As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_setopt Lib cURLLib (EasyHandle As Integer, Option As Integer, Value As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_setopt_blob Lib cURLLib Alias "curl_easy_setopt" (EasyHandle As Integer, Option As Integer, ByRef Value As curl_blob) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_setopt_long Lib cURLLib Alias "curl_easy_setopt" (EasyHandle As Integer, Option As Integer, Value As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_strerror Lib cURLLib (EasyError As Integer) As CString
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_unescape Lib cURLLib (EasyHandle As Integer, char As Ptr, Length As Integer, ByRef OutLength As Integer) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_upkeep Lib cURLLib (EasyHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_formadd Lib cURLLib (ByRef FirstItem As Integer, ByRef LastItem As Ptr, Option As Integer, Value As Ptr, Option1 As Integer, Value1 As Ptr, Option2 As Integer, Value2 As Ptr, Option3 As Integer, Value3 As Ptr, Option4 As Integer, Value4 As Ptr, Option5 As Integer, Value5 As Ptr, Option6 As Integer, Value6 As Ptr, Option7 As Integer, Value7 As Ptr, Option8 As Integer, Value8 As Ptr, Option9 As Integer, Value9 As Ptr, Option10 As Integer, Value10 As Ptr, FinalOption As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_formfree Lib cURLLib (curlform As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_formget Lib cURLLib (First As Integer, UserData As Integer, Callback As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_free Lib cURLLib (char As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_getdate Lib cURLLib (DateString As CString, Reserved As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_global_cleanup Lib cURLLib ()
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_global_init Lib cURLLib (flags As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_global_sslset Lib cURLLib (ID As SSLBackEnd, Name As CString, ByRef Avail As Ptr) As Integer
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function curl_infoname(MessageType As libcURL.curl_infotype) As String
		  ' Returns the name of the specified curl_infotype
		  
		  Select Case MessageType
		  Case libcURL.curl_infotype.data_in
		    Return "Data In"
		  Case libcURL.curl_infotype.data_out
		    Return "Data Out"
		  Case libcURL.curl_infotype.header_in
		    Return "Header In"
		  Case libcURL.curl_infotype.header_out
		    Return "Header Out"
		  Case libcURL.curl_infotype.info_end
		    Return "Info End"
		  Case libcURL.curl_infotype.ssl_in
		    Return "SSL In"
		  Case libcURL.curl_infotype.ssl_out
		    Return "SSL Out"
		  Case libcURL.curl_infotype.text
		    Return "Text"
		  Case libcURL.curl_infotype.RB_libcURL ' debug message from the wrapper
		    Return "RB-libcURL"
		  End Select
		  
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_mime_addpart Lib cURLLib (MIME As Integer) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_mime_data Lib cURLLib (MIMEPart As Ptr, Data As Ptr, DataSize As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_mime_data_cb Lib cURLLib (MIMEPart As Ptr, DataSize As Int64, ReadCallback As Ptr, SeekCallback As Ptr, FreeCallback As Ptr, UserData As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_mime_encoder Lib cURLLib (MIMEPart As Ptr, Encoding As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_mime_filedata Lib cURLLib (MIMEPart As Ptr, FilePath As CString) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_mime_filename Lib cURLLib (MIMEPart As Ptr, FileName As CString) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_mime_free Lib cURLLib (MIME As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_mime_headers Lib cURLLib (MIMEPart As Ptr, HeaderList As Integer, TakeOwnership As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_mime_init Lib cURLLib (EasyHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_mime_name Lib cURLLib (MIMEPart As Ptr, Name As Ptr, NameSize As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_mime_subparts Lib cURLLib (MIMEPart As Ptr, SubParts As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_mime_type Lib cURLLib (MIMEPart As Ptr, Type As CString) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_add_handle Lib cURLLib (MultiHandle As Integer, EasyHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_cleanup Lib cURLLib (MultiHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_info_read Lib cURLLib (MultiHandle As Integer, ByRef MsgCount As Integer) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_init Lib cURLLib () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_perform Lib cURLLib (MultiHandle As Integer, ByRef ActiveCount As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_remove_handle Lib cURLLib (MultiHandle As Integer, EasyHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_setopt Lib cURLLib (MultiHandle As Integer, Option As Integer, Value As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_strerror Lib cURLLib (errNo As Integer) As CString
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_timeout Lib cURLLib (MultiHandle As Integer, ByRef Timeout As timeval) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_share_cleanup Lib cURLLib (ShareHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_share_init Lib cURLLib () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_share_setopt Lib cURLLib (ShareHandle As Integer, Option As Integer, Value As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_share_strerror Lib cURLLib (errNo As Integer) As CString
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_slist_append Lib cURLLib (sList As Ptr, Data As CString) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_slist_free_all Lib cURLLib (sList As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_url Lib cURLLib () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_url_cleanup Lib cURLLib (URL As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_url_dup Lib cURLLib (URL As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_url_get Lib cURLLib (URL As Integer, Part As URLPart, ByRef Content As Ptr, Flags As UInt32) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_url_set Lib cURLLib (URL As Integer, Part As URLPart, Content As Ptr, Flags As UInt32) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_url_strerror Lib cURLLib (CURLUCode As Int32) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_version Lib cURLLib () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_version_info Lib cURLLib (Version As Integer) As Ptr
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function Default_CA_File() As FolderItem
		  ' For SSL/TLS connections we must specify a file with a list of acceptable certificate authorities to verify the peer with.
		  ' This method dumps the default CA list for Mozilla products (included as DEFAULT_CA_INFO_PEM) into a temp file and
		  ' returns it. The DEFAULT_CA_INFO_PEM file is subject to the terms of the Mozilla Public License 2.0
		  '
		  ' To generate an updated CA file use one of these two scripts:
		  '    VBScript: https://github.com/bagder/curl/blob/master/lib/mk-ca-bundle.vbs
		  '        perl: https://github.com/bagder/curl/blob/master/lib/mk-ca-bundle.pl
		  '
		  ' Or download daily-generated list files from the curl project here: https://curl.haxx.se/docs/caextract.html
		  
		  Static CA_File As FolderItem
		  If CA_File = Nil Then
		    CA_File = GetTemporaryFolderItem()
		    Dim bs As BinaryStream = BinaryStream.Open(CA_File, True)
		    bs.Write(DEFAULT_CA_INFO_PEM)
		    bs.Close
		  End If
		  Return CA_File
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EnumSSLBackends() As libcURL.SSLBackEnd()
		  ' Returns an array of available SSL backends.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_global_sslset.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EnumSSLBackends
		  
		  Dim ret() As SSLBackEnd
		  If Not System.IsFunctionAvailable("curl_global_sslset", cURLLib) Then Return ret
		  
		  Dim p As Ptr
		  Dim err As Integer = curl_global_sslset(SSLBackEnd.Ignore, Nil, p)
		  If err <> CURLSSLSET_UNKNOWN_BACKEND Then
		    Dim ex As New cURLException(Nil)
		    ex.ErrorNumber = err
		    Select Case err
		    Case CURLSSLSET_TOO_LATE
		      ex.Message = "The SSL backend has already been initialized and cannot be changed."
		    Case CURLSSLSET_NO_BACKENDS
		      ex.Message = "The installed version of libcurl was built without SSL support."
		    Else
		      ex.Message = "Unknown error while enumerating SSL backends."
		    End Select
		    Raise ex
		  End If
		  If p = Nil Then Return ret
		  Dim mb As MemoryBlock = p.CString(0)
		  For i As Integer = 0 To mb.Size - 1
		    Dim j As Integer = mb.Int8Value(i)
		    Dim v As SSLBackEnd = SSLBackEnd(j)
		    ret.Append(v)
		  Next
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatError(cURLError As Integer, Encoding As TextEncoding = Nil) As String
		  ' Translates libcurl error numbers to messages
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_strerror.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.FormatError
		  
		  If Not libcURL.IsAvailable Then Return "libcURL is not available or is an unsupported version."
		  Dim msg As String = curl_easy_strerror(cURLError)
		  If Encoding <> Nil Then
		    Return ConvertEncoding(msg, Encoding)
		  Else
		    Return DefineEncoding(msg, Encodings.ASCII)
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatMultiError(cURLMultiError As Integer, Encoding As TextEncoding = Nil) As String
		  ' Translates libcurl multi error numbers to messages
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_multi_strerror.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.FormatMultiError
		  
		  If Not libcURL.IsAvailable Then Return "libcURL is not available or is an unsupported version."
		  Dim msg As String = curl_multi_strerror(cURLMultiError)
		  If Encoding <> Nil Then
		    Return ConvertEncoding(msg, Encoding)
		  Else
		    Return DefineEncoding(msg, Encodings.ASCII)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatShareError(cURLShareError As Integer, Encoding As TextEncoding = Nil) As String
		  ' Translates libcurl share error numbers to messages
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_share_strerror.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.FormatShareError
		  
		  If Not libcURL.IsAvailable Then Return "libcURL is not available or is an unsupported version."
		  Dim msg As String = curl_share_strerror(cURLShareError)
		  If Encoding <> Nil Then
		    Return ConvertEncoding(msg, Encoding)
		  Else
		    Return DefineEncoding(msg, Encodings.ASCII)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatURLError(cURLURLError As Integer, Encoding As TextEncoding = Nil) As String
		  ' Translates libcurl URL API error numbers to messages
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_url_strerror.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.FormatURLError
		  
		  Dim msg As String
		  
		  If libcURL.Version.IsAtLeast(7, 80, 0) Then
		    Dim mb As MemoryBlock = curl_url_strerror(cURLURLError)
		    If mb <> Nil Then msg = mb.CString(0)
		  Else
		    Select Case cURLURLError
		    Case URLParser.CURLUE_BAD_HANDLE
		      msg = "An invalid CURLU pointer was passed as argument."
		    Case URLParser.CURLUE_BAD_PARTPOINTER
		      msg = "An invalid 'part' argument was passed as argument."
		    Case URLParser.CURLUE_MALFORMED_INPUT
		      msg = "A malformed input was passed to a URL API function."
		    Case URLParser.CURLUE_BAD_PORT_NUMBER
		      msg = "The port number was not a decimal number between 0 and 65535."
		    Case URLParser.CURLUE_UNSUPPORTED_SCHEME
		      msg = "This libcurl build does not support the given URL scheme."
		    Case URLParser.CURLUE_URLDECODE
		      msg = "URL decode error, most likely because of rubbish in the input."
		    Case URLParser.CURLUE_OUT_OF_MEMORY
		      msg = "A memory function failed."
		    Case URLParser.CURLUE_USER_NOT_ALLOWED
		      msg = "Credentials was passed in the URL when prohibited."
		    Case URLParser.CURLUE_UNKNOWN_PART
		      msg = "An unknown part ID was passed to a URL API function."
		    Case URLParser.CURLUE_NO_SCHEME
		      msg = "There is no scheme part in the URL."
		    Case URLParser.CURLUE_NO_USER
		      msg = "There is no user part in the URL."
		    Case URLParser.CURLUE_NO_PASSWORD
		      msg = "There is no password part in the URL."
		    Case URLParser.CURLUE_NO_OPTIONS
		      msg = "There is no options part in the URL."
		    Case URLParser.CURLUE_NO_HOST
		      msg = "There is no host part in the URL."
		    Case URLParser.CURLUE_NO_PORT
		      msg = "There is no port part in the URL."
		    Case URLParser.CURLUE_NO_QUERY
		      msg = "There is no query part in the URL."
		    Case URLParser.CURLUE_NO_FRAGMENT
		      msg = "There is no fragment part in the URL."
		    Case URLParser.CURLUE_NO_ZONEID
		      msg = "There is no zoneid set in the URL."
		    Case URLParser.CURLUE_BAD_FILE_URL
		      msg = "The file:// URL is invalid."
		    Case URLParser.CURLUE_BAD_FRAGMENT
		      msg = "The fragment part of the URL contained bad or invalid characters."
		    Case URLParser.CURLUE_BAD_HOSTNAME
		      msg = "The hostname contained bad or invalid characters."
		    Case URLParser.CURLUE_BAD_IPV6
		      msg = "The IPv6 address hostname contained bad or invalid characters."
		    Case URLParser.CURLUE_BAD_LOGIN
		      msg = "The login part of the URL contained bad or invalid characters."
		    Case URLParser.CURLUE_BAD_PASSWORD
		      msg = "The password part of the URL contained bad or invalid characters."
		    Case URLParser.CURLUE_BAD_PATH
		      msg = "The path part of the URL contained bad or invalid characters."
		    Case URLParser.CURLUE_BAD_QUERY
		      msg = "The query part of the URL contained bad or invalid characters."
		    Case URLParser.CURLUE_BAD_SCHEME
		      msg = "The scheme part of the URL contained bad or invalid characters."
		    Case URLParser.CURLUE_BAD_SLASHES
		      msg = "The URL contained an invalid number of slashes."
		    Case URLParser.CURLUE_BAD_USER
		      msg = "The user part of the URL contained bad or invalid characters."
		    Else
		      msg = "Unknown error while parsing a URL"
		    End Select
		  End If
		  
		  If Encoding <> Nil Then
		    Return ConvertEncoding(msg, Encoding)
		  Else
		    Return DefineEncoding(msg, Encodings.ASCII)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsAvailable() As Boolean
		  ' Returns True if libcURL is available and at least version 7.15.2. Prior versions require that curl_global_init and
		  ' curl_global_cleanup be called only once each, which we aren't doing.
		  Const MinMajor = 7
		  Const MinMinor = 15
		  Const MinPatch = 2
		  
		  Static available As Boolean = libcURL.Version.IsAtLeast(MinMajor, MinMinor, MinPatch)
		  Return available
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsFeatureAvailable(Feature As libcURL.FeatureType) As Boolean
		  ' Returns True if libcURL is available and the requested feature is available.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.IsFeatureAvailable
		  
		  Return IsAvailable() And BitAnd(libcURL.Version.Features, CType(Feature, Integer)) = CType(Feature, Integer)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsProtocolAvailable(ParamArray Schemes() As String) As Boolean
		  ' Returns True if libcURL is available and supports the protocol specified by the Scheme (e.g. "https", "ftp")
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.IsProtocolAvailable
		  
		  Dim s() As String = libcURL.Version.Protocols()
		  If libcURL.IsFeatureAvailable(FeatureType.HTTP2) Then s.Append("http2")
		  For Each p As String In Schemes
		    If s.IndexOf(p.Lowercase) = -1 Then Return False
		  Next
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MimeType(File As FolderItem) As String
		  Select Case NthField(File.Name, ".", CountFields(File.Name, "."))
		  Case "ez"
		    Return "application/andrew-inset"
		  Case "aw"
		    Return "application/applixware"
		  Case "atom"
		    Return "application/atom+xml"
		  Case "atomcat"
		    Return "application/atomcat+xml"
		  Case "atomsvc"
		    Return "application/atomsvc+xml"
		  Case "ccxml"
		    Return "application/ccxml+xml"
		  Case "cdmia"
		    Return "application/cdmi-capability"
		  Case "cdmic"
		    Return "application/cdmi-container"
		  Case "cdmid"
		    Return "application/cdmi-domain"
		  Case "cdmio"
		    Return "application/cdmi-object"
		  Case "cdmiq"
		    Return "application/cdmi-queue"
		  Case "cu"
		    Return "application/cu-seeme"
		  Case "davmount"
		    Return "application/davmount+xml"
		  Case "daa"
		    Return "application/x-daa"
		  Case "dssc"
		    Return "application/dssc+der"
		  Case "xdssc"
		    Return "application/dssc+xml"
		  Case "ecma"
		    Return "application/ecmascript"
		  Case "emma"
		    Return "application/emma+xml"
		  Case "epub"
		    Return "application/epub+zip"
		  Case "exi"
		    Return "application/exi"
		  Case "pfr"
		    Return "application/font-tdpfr"
		  Case "stk"
		    Return "application/hyperstudio"
		  Case "ipfix"
		    Return "application/ipfix"
		  Case "jar"
		    Return "application/java-archive"
		  Case "ser"
		    Return "application/java-serialized-object"
		  Case "class"
		    Return "application/java-vm"
		  Case "js"
		    Return "application/javascript"
		  Case "json"
		    Return "application/json"
		  Case "lostxml"
		    Return "application/lost+xml"
		  Case "hqx"
		    Return "application/mac-binhex40"
		  Case "cpt"
		    Return "application/mac-compactpro"
		  Case "mads"
		    Return "application/mads+xml"
		  Case "mrc"
		    Return "application/marc"
		  Case "mrcx"
		    Return "application/marcxml+xml"
		  Case "ma", "nb", "mb"
		    Return "application/mathematica"
		  Case "mathml"
		    Return "application/mathml+xml"
		  Case "mbox"
		    Return "application/mbox"
		  Case "mscml"
		    Return "application/mediaservercontrol+xml"
		  Case "meta4"
		    Return "application/metalink4+xml"
		  Case "mets"
		    Return "application/mets+xml"
		  Case "mods"
		    Return "application/mods+xml"
		  Case "m21"
		    Return "application/mp21"
		  Case "mp21"
		    Return "application/mp21"
		  Case "mp4s"
		    Return "application/mp4"
		  Case "doc"
		    Return "application/msword"
		  Case "dot"
		    Return "application/msword"
		  Case "mxf"
		    Return "application/mxf"
		  Case "asc", "sig"
		    Return "application/pgp-signature"
		  Case "prf"
		    Return "application/pics-rules"
		  Case "p10"
		    Return "application/pkcs10"
		  Case "p7m"
		    Return "application/pkcs7-mime"
		  Case "p7c"
		    Return "application/pkcs7-mime"
		  Case "p7s"
		    Return "application/pkcs7-signature"
		  Case "p8"
		    Return "application/pkcs8"
		  Case "ac"
		    Return "application/pkix-attr-cert"
		  Case "cer"
		    Return "application/pkix-cert"
		  Case "crl"
		    Return "application/pkix-crl"
		  Case "pkipath"
		    Return "application/pkix-pkipath"
		  Case "pki"
		    Return "application/pkixcmp"
		  Case "pls"
		    Return "application/pls+xml"
		  Case "ai", "eps", "ps"
		    Return "application/postscript"
		  Case "cww"
		    Return "application/prs.cww"
		  Case "pskcxml"
		    Return "application/pskc+xml"
		  Case "rdf"
		    Return "application/rdf+xml"
		  Case "rif"
		    Return "application/reginfo+xml"
		  Case "rnc"
		    Return "application/relax-ng-compact-syntax"
		  Case "rl"
		    Return "application/resource-lists+xml"
		  Case "rld"
		    Return "application/resource-lists-diff+xml"
		  Case "rs"
		    Return "application/rls-services+xml"
		  Case "rsd"
		    Return "application/rsd+xml"
		  Case "rss"
		    Return "application/rss+xml"
		  Case "rtf"
		    Return "application/rtf"
		  Case "sbml"
		    Return "application/sbml+xml"
		  Case "scq"
		    Return "application/scvp-cv-request"
		  Case "scs"
		    Return "application/scvp-cv-response"
		  Case "spq"
		    Return "application/scvp-vp-request"
		  Case "spp"
		    Return "application/scvp-vp-response"
		  Case "sdp"
		    Return "application/sdp"
		  Case "setpay"
		    Return "application/set-payment-initiation"
		  Case "setreg"
		    Return "application/set-registration-initiation"
		  Case "shf"
		    Return "application/shf+xml"
		  Case "smi", "smil"
		    Return "application/smil+xml"
		  Case "rq"
		    Return "application/sparql-query"
		  Case "srx"
		    Return "application/sparql-results+xml"
		  Case "gram"
		    Return "application/srgs"
		  Case "grxml"
		    Return "application/srgs+xml"
		  Case "sru"
		    Return "application/sru+xml"
		  Case "ssml"
		    Return "application/ssml+xml"
		  Case "tei"
		    Return "application/tei+xml"
		  Case "teicorpus"
		    Return "application/tei+xml"
		  Case "tfi"
		    Return "application/thraud+xml"
		  Case "tsd"
		    Return "application/timestamped-data"
		  Case "plb"
		    Return "application/vnd.3gpp.pic-bw-large"
		  Case "psb"
		    Return "application/vnd.3gpp.pic-bw-small"
		  Case "pvb"
		    Return "application/vnd.3gpp.pic-bw-var"
		  Case "tcap"
		    Return "application/vnd.3gpp2.tcap"
		  Case "pwn"
		    Return "application/vnd.3m.post-it-notes"
		  Case "aso"
		    Return "application/vnd.accpac.simply.aso"
		  Case "imp"
		    Return "application/vnd.accpac.simply.imp"
		  Case "acu"
		    Return "application/vnd.acucobol"
		  Case "atc"
		    Return "application/vnd.acucorp"
		  Case "acutc"
		    Return "application/vnd.acucorp"
		  Case "air"
		    Return "application/vnd.adobe.air-application-installer-package+zip"
		  Case "fxp"
		    Return "application/vnd.adobe.fxp"
		  Case "fxpl"
		    Return "application/vnd.adobe.fxp"
		  Case "xdp"
		    Return "application/vnd.adobe.xdp+xml"
		  Case "xfdf"
		    Return "application/vnd.adobe.xfdf"
		  Case "ahead"
		    Return "application/vnd.ahead.space"
		  Case "azf"
		    Return "application/vnd.airzip.filesecure.azf"
		  Case "azs"
		    Return "application/vnd.airzip.filesecure.azs"
		  Case "azw"
		    Return "application/vnd.amazon.ebook"
		  Case "acc"
		    Return "application/vnd.americandynamics.acc"
		  Case "ami"
		    Return "application/vnd.amiga.ami"
		  Case "apk"
		    Return "application/vnd.android.package-archive"
		  Case "cii"
		    Return "application/vnd.anser-web-certificate-issue-initiation"
		  Case "fti"
		    Return "application/vnd.anser-web-funds-transfer-initiation"
		  Case "atx"
		    Return "application/vnd.antix.game-component"
		  Case "mpkg"
		    Return "application/vnd.apple.installer+xml"
		  Case "m3u8"
		    Return "application/vnd.apple.mpegurl"
		  Case "swi"
		    Return "application/vnd.aristanetworks.swi"
		  Case "aep"
		    Return "application/vnd.audiograph"
		  Case "mpm"
		    Return "application/vnd.blueice.multipass"
		  Case "bmi"
		    Return "application/vnd.bmi"
		  Case "rep"
		    Return "application/vnd.businessobjects"
		  Case "cdxml"
		    Return "application/vnd.chemdraw+xml"
		  Case "mmd"
		    Return "application/vnd.chipnuts.karaoke-mmd"
		  Case "cdy"
		    Return "application/vnd.cinderella"
		  Case "cla"
		    Return "application/vnd.claymore"
		  Case "rp9"
		    Return "application/vnd.cloanto.rp9"
		  Case "c4g", "c4d", "c4f", "c4p", "c4u"
		    Return "application/vnd.clonk.c4group"
		  Case "c11amc"
		    Return "application/vnd.cluetrust.cartomobile-config"
		  Case "c11amz"
		    Return "application/vnd.cluetrust.cartomobile-config-pkg"
		  Case "csp"
		    Return "application/vnd.commonspace"
		  Case "cdbcmsg"
		    Return "application/vnd.contact.cmsg"
		  Case "cmc"
		    Return "application/vnd.cosmocaller"
		  Case "clkx"
		    Return "application/vnd.crick.clicker"
		  Case "clkk"
		    Return "application/vnd.crick.clicker.keyboard"
		  Case "clkp"
		    Return "application/vnd.crick.clicker.palette"
		  Case "clkt"
		    Return "application/vnd.crick.clicker.template"
		  Case "clkw"
		    Return "application/vnd.crick.clicker.wordbank"
		  Case "wbs"
		    Return "application/vnd.criticaltools.wbs+xml"
		  Case "pml"
		    Return "application/vnd.ctc-posml"
		  Case "ppd"
		    Return "application/vnd.cups-ppd"
		  Case "car"
		    Return "application/vnd.curl.car"
		  Case "pcurl"
		    Return "application/vnd.curl.pcurl"
		  Case "rdz"
		    Return "application/vnd.data-vision.rdz"
		  Case "uvf", "uvvf", "uvd", "uvvd"
		    Return "application/vnd.dece.data"
		  Case "uvt", "uvvt"
		    Return "application/vnd.dece.ttml+xml"
		  Case "uvx"
		    Return "application/vnd.dece.unspecified"
		  Case "uvvx"
		    Return "application/vnd.dece.unspecified"
		  Case "fe_launch"
		    Return "application/vnd.denovo.fcselayout-link"
		  Case "dna"
		    Return "application/vnd.dna"
		  Case "mlp"
		    Return "application/vnd.dolby.mlp"
		  Case "dpg"
		    Return "application/vnd.dpgraph"
		  Case "dfac"
		    Return "application/vnd.dreamfactory"
		  Case "ait"
		    Return "application/vnd.dvb.ait"
		  Case "svc"
		    Return "application/vnd.dvb.service"
		  Case "geo"
		    Return "application/vnd.dynageo"
		  Case "mag"
		    Return "application/vnd.ecowin.chart"
		  Case "nml"
		    Return "application/vnd.enliven"
		  Case "esf"
		    Return "application/vnd.epson.esf"
		  Case "msf"
		    Return "application/vnd.epson.msf"
		  Case "qam"
		    Return "application/vnd.epson.quickanime"
		  Case "slt"
		    Return "application/vnd.epson.salt"
		  Case "ssf"
		    Return "application/vnd.epson.ssf"
		  Case "es3"
		    Return "application/vnd.eszigno3+xml"
		  Case "et3"
		    Return "application/vnd.eszigno3+xml"
		  Case "ez2"
		    Return "application/vnd.ezpix-album"
		  Case "ez3"
		    Return "application/vnd.ezpix-package"
		  Case "fdf"
		    Return "application/vnd.fdf"
		  Case "mseed"
		    Return "application/vnd.fdsn.mseed"
		  Case "seed", "dataless"
		    Return "application/vnd.fdsn.seed"
		  Case "gph"
		    Return "application/vnd.flographit"
		  Case "ftc"
		    Return "application/vnd.fluxtime.clip"
		  Case "fm", "frame", "maker", "book"
		    Return "application/vnd.framemaker"
		  Case "fnc"
		    Return "application/vnd.frogans.fnc"
		  Case "ltf"
		    Return "application/vnd.frogans.ltf"
		  Case "fsc"
		    Return "application/vnd.fsc.weblaunch"
		  Case "oas"
		    Return "application/vnd.fujitsu.oasys"
		  Case "oa2"
		    Return "application/vnd.fujitsu.oasys2"
		  Case "oa3"
		    Return "application/vnd.fujitsu.oasys3"
		  Case "fg5"
		    Return "application/vnd.fujitsu.oasysgp"
		  Case "bh2"
		    Return "application/vnd.fujitsu.oasysprs"
		  Case "ddd"
		    Return "application/vnd.fujixerox.ddd"
		  Case "xdw"
		    Return "application/vnd.fujixerox.docuworks"
		  Case "xbd"
		    Return "application/vnd.fujixerox.docuworks.binder"
		  Case "fzs"
		    Return "application/vnd.fuzzysheet"
		  Case "txd"
		    Return "application/vnd.genomatix.tuxedo"
		  Case "ggb"
		    Return "application/vnd.geogebra.file"
		  Case "ggt"
		    Return "application/vnd.geogebra.tool"
		  Case "gex", "gre"
		    Return "application/vnd.geometry-explorer"
		  Case "gxt"
		    Return "application/vnd.geonext"
		  Case "g2w"
		    Return "application/vnd.geoplan"
		  Case "g3w"
		    Return "application/vnd.geospace"
		  Case "gmx"
		    Return "application/vnd.gmx"
		  Case "kml"
		    Return "application/vnd.google-earth.kml+xml"
		  Case "kmz"
		    Return "application/vnd.google-earth.kmz"
		  Case "gqf", "gqs"
		    Return "application/vnd.grafeq"
		  Case "gac"
		    Return "application/vnd.groove-account"
		  Case "ghf"
		    Return "application/vnd.groove-help"
		  Case "gim"
		    Return "application/vnd.groove-identity-message"
		  Case "grv"
		    Return "application/vnd.groove-injector"
		  Case "gtm"
		    Return "application/vnd.groove-tool-message"
		  Case "tpl"
		    Return "application/vnd.groove-tool-template"
		  Case "vcg"
		    Return "application/vnd.groove-vcard"
		  Case "hal"
		    Return "application/vnd.hal+xml"
		  Case "zmm"
		    Return "application/vnd.handheld-entertainment+xml"
		  Case "hbci"
		    Return "application/vnd.hbci"
		  Case "les"
		    Return "application/vnd.hhe.lesson-player"
		  Case "hpgl"
		    Return "application/vnd.hp-hpgl"
		  Case "hpid"
		    Return "application/vnd.hp-hpid"
		  Case "hps"
		    Return "application/vnd.hp-hps"
		  Case "jlt"
		    Return "application/vnd.hp-jlyt"
		  Case "pcl"
		    Return "application/vnd.hp-pcl"
		  Case "pclxl"
		    Return "application/vnd.hp-pclxl"
		  Case "sfd-hdstx"
		    Return "application/vnd.hydrostatix.sof-data"
		  Case "x3d"
		    Return "application/vnd.hzn-3d-crossword"
		  Case "mpy"
		    Return "application/vnd.ibm.minipay"
		  Case "afp", "listafp", "list3820"
		    Return "application/vnd.ibm.modcap"
		  Case "irm"
		    Return "application/vnd.ibm.rights-management"
		  Case "sc"
		    Return "application/vnd.ibm.secure-container"
		  Case "icc", "icm"
		    Return "application/vnd.iccprofile"
		  Case "igl"
		    Return "application/vnd.igloader"
		  Case "ivp"
		    Return "application/vnd.immervision-ivp"
		  Case "ivu"
		    Return "application/vnd.immervision-ivu"
		  Case "igm"
		    Return "application/vnd.insors.igm"
		  Case "xpw", "xpx"
		    Return "application/vnd.intercon.formnet"
		  Case "i2g"
		    Return "application/vnd.intergeo"
		  Case "qbo"
		    Return "application/vnd.intu.qbo"
		  Case "qfx"
		    Return "application/vnd.intu.qfx"
		  Case "rcprofile"
		    Return "application/vnd.ipunplugged.rcprofile"
		  Case "irp"
		    Return "application/vnd.irepository.package+xml"
		  Case "xpr"
		    Return "application/vnd.is-xpr"
		  Case "fcs"
		    Return "application/vnd.isac.fcs"
		  Case "jam"
		    Return "application/vnd.jam"
		  Case "rms"
		    Return "application/vnd.jcp.javame.midlet-rms"
		  Case "jisp"
		    Return "application/vnd.jisp"
		  Case "joda"
		    Return "application/vnd.joost.joda-archive"
		  Case "ktz"
		    Return "application/vnd.kahootz"
		  Case "ktr"
		    Return "application/vnd.kahootz"
		  Case "karbon"
		    Return "application/vnd.kde.karbon"
		  Case "chrt"
		    Return "application/vnd.kde.kchart"
		  Case "kfo"
		    Return "application/vnd.kde.kformula"
		  Case "flw"
		    Return "application/vnd.kde.kivio"
		  Case "kon"
		    Return "application/vnd.kde.kontour"
		  Case "kpr"
		    Return "application/vnd.kde.kpresenter"
		  Case "ksp"
		    Return "application/vnd.kde.kspread"
		  Case "kwd"
		    Return "application/vnd.kde.kword"
		  Case "htke"
		    Return "application/vnd.kenameaapp"
		  Case "kia"
		    Return "application/vnd.kidspiration"
		  Case "kne"
		    Return "application/vnd.kinar"
		  Case "skp"
		    Return "application/vnd.koan"
		  Case "sse"
		    Return "application/vnd.kodak-descriptor"
		  Case "lasxml"
		    Return "application/vnd.las.las+xml"
		  Case "lbd"
		    Return "application/vnd.llamagraphics.life-balance.desktop"
		  Case "lbe"
		    Return "application/vnd.llamagraphics.life-balance.exchange+xml"
		  Case "123"
		    Return "application/vnd.lotus-1-2-3"
		  Case "apr"
		    Return "application/vnd.lotus-approach"
		  Case "pre"
		    Return "application/vnd.lotus-freelance"
		  Case "nsf"
		    Return "application/vnd.lotus-notes"
		  Case "org"
		    Return "application/vnd.lotus-organizer"
		  Case "scm"
		    Return "application/vnd.lotus-screencam"
		  Case "lwp"
		    Return "application/vnd.lotus-wordpro"
		  Case "portpkg"
		    Return "application/vnd.macports.portpkg"
		  Case "mcd"
		    Return "application/vnd.mcd"
		  Case "mc1"
		    Return "application/vnd.medcalcdata"
		  Case "cdkey"
		    Return "application/vnd.mediastation.cdkey"
		  Case "mwf"
		    Return "application/vnd.mfer"
		  Case "mfm"
		    Return "application/vnd.mfmp"
		  Case "flo"
		    Return "application/vnd.micrografx.flo"
		  Case "igx"
		    Return "application/vnd.micrografx.igx"
		  Case "mif"
		    Return "application/vnd.mif"
		  Case "daf"
		    Return "application/vnd.mobius.daf"
		  Case "dis"
		    Return "application/vnd.mobius.dis"
		  Case "mbk"
		    Return "application/vnd.mobius.mbk"
		  Case "mqy"
		    Return "application/vnd.mobius.mqy"
		  Case "msl"
		    Return "application/vnd.mobius.msl"
		  Case "plc"
		    Return "application/vnd.mobius.plc"
		  Case "txf"
		    Return "application/vnd.mobius.txf"
		  Case "mpn"
		    Return "application/vnd.mophun.application"
		  Case "mpc"
		    Return "application/vnd.mophun.certificate"
		  Case "xul"
		    Return "application/vnd.mozilla.xul+xml"
		  Case "cil"
		    Return "application/vnd.ms-artgalry"
		  Case "cab"
		    Return "application/vnd.ms-cab-compressed"
		  Case "xls", "xlm", "xla", "xlc", "xlt", "xlw"
		    Return "application/vnd.ms-excel"
		  Case "xlam"
		    Return "application/vnd.ms-excel.addin.macroenabled.12"
		  Case "xlsb"
		    Return "application/vnd.ms-excel.sheet.binary.macroenabled.12"
		  Case "xlsm"
		    Return "application/vnd.ms-excel.sheet.macroenabled.12"
		  Case "xltm"
		    Return "application/vnd.ms-excel.template.macroenabled.12"
		  Case "eot"
		    Return "application/vnd.ms-fontobject"
		  Case "chm"
		    Return "application/vnd.ms-htmlhelp"
		  Case "ims"
		    Return "application/vnd.ms-ims"
		  Case "lrm"
		    Return "application/vnd.ms-lrm"
		  Case "thmx"
		    Return "application/vnd.ms-officetheme"
		  Case "cat"
		    Return "application/vnd.ms-pki.seccat"
		  Case "stl"
		    Return "application/vnd.ms-pki.stl"
		  Case "ppt"
		    Return "application/vnd.ms-powerpoint"
		  Case "pps"
		    Return "application/vnd.ms-powerpoint"
		  Case "ppam"
		    Return "application/vnd.ms-powerpoint.addin.macroenabled.12"
		  Case "pptm"
		    Return "application/vnd.ms-powerpoint.presentation.macroenabled.12"
		  Case "sldm"
		    Return "application/vnd.ms-powerpoint.slide.macroenabled.12"
		  Case "ppsm"
		    Return "application/vnd.ms-powerpoint.slideshow.macroenabled.12"
		  Case "potm"
		    Return "application/vnd.ms-powerpoint.template.macroenabled.12"
		  Case "mpp", "mpt"
		    Return "application/vnd.ms-project"
		  Case "docm"
		    Return "application/vnd.ms-word.document.macroenabled.12"
		  Case "dotm"
		    Return "application/vnd.ms-word.template.macroenabled.12"
		  Case "wps", "wks", "wcm", "wdb"
		    Return "application/vnd.ms-works"
		  Case "wpl"
		    Return "application/vnd.ms-wpl"
		  Case "xps"
		    Return "application/vnd.ms-xpsdocument"
		  Case "mseq"
		    Return "application/vnd.mseq"
		  Case "mus"
		    Return "application/vnd.musician"
		  Case "msty"
		    Return "application/vnd.muvee.style"
		  Case "nlu"
		    Return "application/vnd.neurolanguage.nlu"
		  Case "nnd"
		    Return "application/vnd.noblenet-directory"
		  Case "nns"
		    Return "application/vnd.noblenet-sealer"
		  Case "nnw"
		    Return "application/vnd.noblenet-web"
		  Case "ngdat"
		    Return "application/vnd.nokia.n-gage.data"
		  Case "n-gage"
		    Return "application/vnd.nokia.n-gage.symbian.install"
		  Case "rpst"
		    Return "application/vnd.nokia.radio-preset"
		  Case "rpss"
		    Return "application/vnd.nokia.radio-presets"
		  Case "edm"
		    Return "application/vnd.novadigm.edm"
		  Case "edx"
		    Return "application/vnd.novadigm.edx"
		  Case "ext"
		    Return "application/vnd.novadigm.ext"
		  Case "odc"
		    Return "application/vnd.oasis.opendocument.chart"
		  Case "otc"
		    Return "application/vnd.oasis.opendocument.chart-template"
		  Case "odb"
		    Return "application/vnd.oasis.opendocument.database"
		  Case "odf"
		    Return "application/vnd.oasis.opendocument.formula"
		  Case "odft"
		    Return "application/vnd.oasis.opendocument.formula-template"
		  Case "odg"
		    Return "application/vnd.oasis.opendocument.graphics"
		  Case "otg"
		    Return "application/vnd.oasis.opendocument.graphics-template"
		  Case "odi"
		    Return "application/vnd.oasis.opendocument.image"
		  Case "oti"
		    Return "application/vnd.oasis.opendocument.image-template"
		  Case "odp"
		    Return "application/vnd.oasis.opendocument.presentation"
		  Case "otp"
		    Return "application/vnd.oasis.opendocument.presentation-template"
		  Case "ods"
		    Return "application/vnd.oasis.opendocument.spreadsheet"
		  Case "ots"
		    Return "application/vnd.oasis.opendocument.spreadsheet-template"
		  Case "odt"
		    Return "application/vnd.oasis.opendocument.text"
		  Case "odm"
		    Return "application/vnd.oasis.opendocument.text-master"
		  Case "ott"
		    Return "application/vnd.oasis.opendocument.text-template"
		  Case "oth"
		    Return "application/vnd.oasis.opendocument.text-web"
		  Case "xo"
		    Return "application/vnd.olpc-sugar"
		  Case "dd2"
		    Return "application/vnd.oma.dd2+xml"
		  Case "oxt"
		    Return "application/vnd.openofficeorg.extension"
		  Case "pptx"
		    Return "application/vnd.openxmlformats-officedocument.presentationml.presentation"
		  Case "sldx"
		    Return "application/vnd.openxmlformats-officedocument.presentationml.slide"
		  Case "ppsx"
		    Return "application/vnd.openxmlformats-officedocument.presentationml.slideshow"
		  Case "potx"
		    Return "application/vnd.openxmlformats-officedocument.presentationml.template"
		  Case "xlsx"
		    Return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
		  Case "xltx"
		    Return "application/vnd.openxmlformats-officedocument.spreadsheetml.template"
		  Case "docx"
		    Return "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
		  Case "dotx"
		    Return "application/vnd.openxmlformats-officedocument.wordprocessingml.template"
		  Case "mgp"
		    Return "application/vnd.osgeo.mapguide.package"
		  Case "dp"
		    Return "application/vnd.osgi.dp"
		  Case "pdb"
		    Return "application/vnd.palm"
		  Case "paw"
		    Return "application/vnd.pawaafile"
		  Case "str"
		    Return "application/vnd.pg.format"
		  Case "ei6"
		    Return "application/vnd.pg.osasli"
		  Case "efif"
		    Return "application/vnd.picsel"
		  Case "wg"
		    Return "application/vnd.pmi.widget"
		  Case "plf"
		    Return "application/vnd.pocketlearn"
		  Case "pbd"
		    Return "application/vnd.powerbuilder6"
		  Case "box"
		    Return "application/vnd.previewsystems.box"
		  Case "mgz"
		    Return "application/vnd.proteus.magazine"
		  Case "qps"
		    Return "application/vnd.publishare-delta-tree"
		  Case "ptid"
		    Return "application/vnd.pvi.ptid1"
		  Case "qxd"
		    Return "application/vnd.quark.quarkxpress"
		  Case "bed"
		    Return "application/vnd.realvnc.bed"
		  Case "mxl"
		    Return "application/vnd.recordare.musicxml"
		  Case "musicxml"
		    Return "application/vnd.recordare.musicxml+xml"
		  Case "cryptonote"
		    Return "application/vnd.rig.cryptonote"
		  Case "cod"
		    Return "application/vnd.rim.cod"
		  Case "rm"
		    Return "application/vnd.rn-realmedia"
		  Case "link66"
		    Return "application/vnd.route66.link66+xml"
		  Case "st"
		    Return "application/vnd.sailingtracker.track"
		  Case "see"
		    Return "application/vnd.seemail"
		  Case "sema"
		    Return "application/vnd.sema"
		  Case "semd"
		    Return "application/vnd.semd"
		  Case "semf"
		    Return "application/vnd.semf"
		  Case "ifm"
		    Return "application/vnd.shana.informed.formdata"
		  Case "itp"
		    Return "application/vnd.shana.informed.formtemplate"
		  Case "iif"
		    Return "application/vnd.shana.informed.interchange"
		  Case "ipk"
		    Return "application/vnd.shana.informed.package"
		  Case "twd"
		    Return "application/vnd.simtech-mindmapper"
		  Case "mmf"
		    Return "application/vnd.smaf"
		  Case "teacher"
		    Return "application/vnd.smart.teacher"
		  Case "sdkm"
		    Return "application/vnd.solent.sdkm+xml"
		  Case "dxp"
		    Return "application/vnd.spotfire.dxp"
		  Case "sfs"
		    Return "application/vnd.spotfire.sfs"
		  Case "sdc"
		    Return "application/vnd.stardivision.calc"
		  Case "sda"
		    Return "application/vnd.stardivision.draw"
		  Case "sdd"
		    Return "application/vnd.stardivision.impress"
		  Case "smf"
		    Return "application/vnd.stardivision.math"
		  Case "sdw"
		    Return "application/vnd.stardivision.writer"
		  Case "sgl"
		    Return "application/vnd.stardivision.writer-global"
		  Case "sm"
		    Return "application/vnd.stepmania.stepchart"
		  Case "sxc"
		    Return "application/vnd.sun.xml.calc"
		  Case "stc"
		    Return "application/vnd.sun.xml.calc.template"
		  Case "sxd"
		    Return "application/vnd.sun.xml.draw"
		  Case "std"
		    Return "application/vnd.sun.xml.draw.template"
		  Case "sxi"
		    Return "application/vnd.sun.xml.impress"
		  Case "sti"
		    Return "application/vnd.sun.xml.impress.template"
		  Case "sxm"
		    Return "application/vnd.sun.xml.math"
		  Case "sxw"
		    Return "application/vnd.sun.xml.writer"
		  Case "sxg"
		    Return "application/vnd.sun.xml.writer.global"
		  Case "stw"
		    Return "application/vnd.sun.xml.writer.template"
		  Case "sus"
		    Return "application/vnd.sus-calendar"
		  Case "svd"
		    Return "application/vnd.svd"
		  Case "sis"
		    Return "application/vnd.symbian.install"
		  Case "xsm"
		    Return "application/vnd.syncml+xml"
		  Case "bdm"
		    Return "application/vnd.syncml.dm+wbxml"
		  Case "xdm"
		    Return "application/vnd.syncml.dm+xml"
		  Case "tao"
		    Return "application/vnd.tao.intent-module-archive"
		  Case "tmo"
		    Return "application/vnd.tmobile-livetv"
		  Case "tpt"
		    Return "application/vnd.trid.tpt"
		  Case "mxs"
		    Return "application/vnd.triscape.mxs"
		  Case "tra"
		    Return "application/vnd.trueapp"
		  Case "ufd"
		    Return "application/vnd.ufdl"
		  Case "utz"
		    Return "application/vnd.uiq.theme"
		  Case "umj"
		    Return "application/vnd.umajin"
		  Case "unityweb"
		    Return "application/vnd.unity"
		  Case "uoml"
		    Return "application/vnd.uoml+xml"
		  Case "vcx"
		    Return "application/vnd.vcx"
		  Case "vsd"
		    Return "application/vnd.visio"
		  Case "vis"
		    Return "application/vnd.visionary"
		  Case "vsf"
		    Return "application/vnd.vsf"
		  Case "wbxml"
		    Return "application/vnd.wap.wbxml"
		  Case "wmlc"
		    Return "application/vnd.wap.wmlc"
		  Case "wmlsc"
		    Return "application/vnd.wap.wmlscriptc"
		  Case "wtb"
		    Return "application/vnd.webturbo"
		  Case "nbp"
		    Return "application/vnd.wolfram.player"
		  Case "wpd"
		    Return "application/vnd.wordperfect"
		  Case "wqd"
		    Return "application/vnd.wqd"
		  Case "stf"
		    Return "application/vnd.wt.stf"
		  Case "xar"
		    Return "application/vnd.xara"
		  Case "xfdl"
		    Return "application/vnd.xfdl"
		  Case "hvd"
		    Return "application/vnd.yamaha.hv-dic"
		  Case "hvs"
		    Return "application/vnd.yamaha.hv-script"
		  Case "hvp"
		    Return "application/vnd.yamaha.hv-voice"
		  Case "osf"
		    Return "application/vnd.yamaha.openscoreformat"
		  Case "osfpvg"
		    Return "application/vnd.yamaha.openscoreformat.osfpvg+xml"
		  Case "saf"
		    Return "application/vnd.yamaha.smaf-audio"
		  Case "spf"
		    Return "application/vnd.yamaha.smaf-phrase"
		  Case "cmp"
		    Return "application/vnd.yellowriver-custom-menu"
		  Case "zir"
		    Return "application/vnd.zul"
		  Case "zaz"
		    Return "application/vnd.zzazz.deck+xml"
		  Case "vxml"
		    Return "application/voicexml+xml"
		  Case "wgt"
		    Return "application/widget"
		  Case "hlp"
		    Return "application/winhlp"
		  Case "wsdl"
		    Return "application/wsdl+xml"
		  Case "wspolicy"
		    Return "application/wspolicy+xml"
		  Case "7z"
		    Return "application/x-7z-compressed"
		  Case "abw"
		    Return "application/x-abiword"
		  Case "ace"
		    Return "application/x-ace-compressed"
		  Case "aab"
		    Return "application/x-authorware-bin"
		  Case "aam"
		    Return "application/x-authorware-map"
		  Case "aas"
		    Return "application/x-authorware-seg"
		  Case "bcpio"
		    Return "application/x-bcpio"
		  Case "torrent"
		    Return "application/x-bittorrent"
		  Case "bz"
		    Return "application/x-bzip"
		  Case "bz2"
		    Return "application/x-bzip2"
		  Case "vcd"
		    Return "application/x-cdlink"
		  Case "chat"
		    Return "application/x-chat"
		  Case "pgn"
		    Return "application/x-chess-pgn"
		  Case "cpio"
		    Return "application/x-cpio"
		  Case "csh"
		    Return "application/x-csh"
		  Case "deb"
		    Return "application/x-debian-package"
		  Case "dir"
		    Return "application/x-director"
		  Case "wad"
		    Return "application/x-doom"
		  Case "ncx"
		    Return "application/x-dtbncx+xml"
		  Case "dtb"
		    Return "application/x-dtbook+xml"
		  Case "res"
		    Return "application/x-dtbresource+xml"
		  Case "dvi"
		    Return "application/x-dvi"
		  Case "bdf"
		    Return "application/x-font-bdf"
		  Case "gsf"
		    Return "application/x-font-ghostscript"
		  Case "psf"
		    Return "application/x-font-linux-psf"
		  Case "otf"
		    Return "application/x-font-otf"
		  Case "pcf"
		    Return "application/x-font-pcf"
		  Case "snf"
		    Return "application/x-font-snf"
		  Case "ttf"
		    Return "application/x-font-ttf"
		  Case "pfa"
		    Return "application/x-font-type1"
		  Case "woff"
		    Return "application/x-font-woff"
		  Case "spl"
		    Return "application/x-futuresplash"
		  Case "gnumeric"
		    Return "application/x-gnumeric"
		  Case "gtar"
		    Return "application/x-gtar"
		  Case "hdf"
		    Return "application/x-hdf"
		  Case "jnlp"
		    Return "application/x-java-jnlp-file"
		  Case "latex"
		    Return "application/x-latex"
		  Case "prc"
		    Return "application/x-mobipocket-ebook"
		  Case "mobi"
		    Return "application/x-mobipocket-ebook"
		  Case "m3u8"
		    Return "application/x-mpegurl"
		  Case "application"
		    Return "application/x-ms-application"
		  Case "wmd"
		    Return "application/x-ms-wmd"
		  Case "wmz"
		    Return "application/x-ms-wmz"
		  Case "xbap"
		    Return "application/x-ms-xbap"
		  Case "mdb"
		    Return "application/x-msaccess"
		  Case "obd"
		    Return "application/x-msbinder"
		  Case "crd"
		    Return "application/x-mscardfile"
		  Case "clp"
		    Return "application/x-msclip"
		  Case "exe", "dll", "com", "bat", "msi"
		    Return "application/x-msdownload"
		  Case "mvb"
		    Return "application/x-msmediaview"
		  Case "wmf"
		    Return "application/x-msmetafile"
		  Case "mny"
		    Return "application/x-msmoney"
		  Case "pub"
		    Return "application/x-mspublisher"
		  Case "scd"
		    Return "application/x-msschedule"
		  Case "trm"
		    Return "application/x-msterminal"
		  Case "wri"
		    Return "application/x-mswrite"
		  Case "nc"
		    Return "application/x-netcdf"
		  Case "p12"
		    Return "application/x-pkcs12"
		  Case "p7b"
		    Return "application/x-pkcs7-certificates"
		  Case "p7r"
		    Return "application/x-pkcs7-certreqresp"
		  Case "rar"
		    Return "application/x-rar-compressed"
		  Case "sh"
		    Return "application/x-sh"
		  Case "shar"
		    Return "application/x-shar"
		  Case "swf"
		    Return "application/x-shockwave-flash"
		  Case "xap"
		    Return "application/x-silverlight-app"
		  Case "sit"
		    Return "application/x-stuffit"
		  Case "sitx"
		    Return "application/x-stuffitx"
		  Case "sv4cpio"
		    Return "application/x-sv4cpio"
		  Case "sv4crc"
		    Return "application/x-sv4crc"
		  Case "tar"
		    Return "application/x-tar"
		  Case "tcl"
		    Return "application/x-tcl"
		  Case "tex"
		    Return "application/x-tex"
		  Case "tfm"
		    Return "application/x-tex-tfm"
		  Case "texi"
		    Return "application/x-texinfo"
		  Case "texinfo"
		    Return "application/x-texinfo"
		  Case "ustar"
		    Return "application/x-ustar"
		  Case "src"
		    Return "application/x-wais-source"
		  Case "crt"
		    Return "application/x-x509-ca-cert"
		  Case "der"
		    Return "application/x-x509-ca-cert"
		  Case "fig"
		    Return "application/x-xfig"
		  Case "xpi"
		    Return "application/x-xpinstall"
		  Case "xdf"
		    Return "application/xcap-diff+xml"
		  Case "xenc"
		    Return "application/xenc+xml"
		  Case "xht"
		    Return "application/xhtml+xml"
		  Case "xhtml"
		    Return "application/xhtml+xml"
		  Case "xsl"
		    Return "application/xml"
		  Case "xml"
		    Return "application/xml"
		  Case "dtd"
		    Return "application/xml-dtd"
		  Case "xop"
		    Return "application/xop+xml"
		  Case "xslt"
		    Return "application/xslt+xml"
		  Case "xspf"
		    Return "application/xspf+xml"
		  Case "mxml"
		    Return "application/xv+xml"
		  Case "yang"
		    Return "application/yang"
		  Case "yin"
		    Return "application/yin+xml"
		  Case "zip"
		    Return "application/zip"
		  Case "adp"
		    Return "audio/adpcm"
		  Case "snd", "au"
		    Return "audio/basic"
		  Case "midi", "mid"
		    Return "audio/midi"
		  Case "mp4a"
		    Return "audio/mp4"
		  Case "m4p"
		    Return "audio/mp4a-latm"
		  Case "m4a"
		    Return "audio/mp4a-latm"
		  Case "mpga", "mp2", "mp2a", "mp3", "m2a", "m3a"
		    Return "audio/mpeg"
		  Case "oga", "ogg", "spx"
		    Return "audio/ogg"
		  Case "weba"
		    Return "audio/webm"
		  Case "aac"
		    Return "audio/x-aac"
		  Case "aif", "aiff", "aifc"
		    Return "audio/x-aiff"
		  Case "m3u"
		    Return "audio/x-mpegurl"
		  Case "wax"
		    Return "audio/x-ms-wax"
		  Case "wma"
		    Return "audio/x-ms-wma"
		  Case "ram", "ra"
		    Return "audio/x-pn-realaudio"
		  Case "rmp"
		    Return "audio/x-pn-realaudio-plugin"
		  Case "wav"
		    Return "audio/x-wav"
		  Case "cdx"
		    Return "chemical/x-cdx"
		  Case "cif"
		    Return "chemical/x-cif"
		  Case "cmdf"
		    Return "chemical/x-cmdf"
		  Case "cml"
		    Return "chemical/x-cml"
		  Case "csml"
		    Return "chemical/x-csml"
		  Case "xyz"
		    Return "chemical/x-xyz"
		  Case "bmp"
		    Return "image/bmp"
		  Case "cgm"
		    Return "image/cgm"
		  Case "g3"
		    Return "image/g3fax"
		  Case "gif"
		    Return "image/gif"
		  Case "ief"
		    Return "image/ief"
		  Case "jp2"
		    Return "image/jp2"
		  Case "jpeg", "jpg", "jpe"
		    Return "image/jpeg"
		  Case "ktx"
		    Return "image/ktx"
		  Case "pict", "pic", "pct"
		    Return "image/pict"
		  Case "png"
		    Return "image/png"
		  Case "btif"
		    Return "image/prs.btif"
		  Case "svg"
		    Return "image/svg+xml"
		  Case "tiff"
		    Return "image/tiff"
		  Case "psd"
		    Return "image/vnd.adobe.photoshop"
		  Case "uvi"
		    Return "image/vnd.dece.graphic"
		  Case "sub"
		    Return "image/vnd.dvb.subtitle"
		  Case "djvu"
		    Return "image/vnd.djvu"
		  Case "dwg"
		    Return "image/vnd.dwg"
		  Case "dxf"
		    Return "image/vnd.dxf"
		  Case "fbs"
		    Return "image/vnd.fastbidsheet"
		  Case "fpx"
		    Return "image/vnd.fpx"
		  Case "fst"
		    Return "image/vnd.fst"
		  Case "mmr"
		    Return "image/vnd.fujixerox.edmics-mmr"
		  Case "rlc"
		    Return "image/vnd.fujixerox.edmics-rlc"
		  Case "mdi"
		    Return "image/vnd.ms-modi"
		  Case "npx"
		    Return "image/vnd.net-fpx"
		  Case "wbmp"
		    Return "image/vnd.wap.wbmp"
		  Case "xif"
		    Return "image/vnd.xiff"
		  Case "webp"
		    Return "image/webp"
		  Case "ras"
		    Return "image/x-cmu-raster"
		  Case "cmx"
		    Return "image/x-cmx"
		  Case "fh"
		    Return "image/x-freehand"
		  Case "ico"
		    Return "image/x-icon"
		  Case "pntg", "pnt","mac"
		    Return "image/x-macpaint"
		  Case "pcx"
		    Return "image/x-pcx"
		  Case "pdf"
		    Return "application/pdf"
		  Case "pnm"
		    Return "image/x-portable-anymap"
		  Case "pbm"
		    Return "image/x-portable-bitmap"
		  Case "pgm"
		    Return "image/x-portable-graymap"
		  Case "ppm"
		    Return "image/x-portable-pixmap"
		  Case "qti", "qtif"
		    Return "image/x-quicktime"
		  Case "rgb"
		    Return "image/x-rgb"
		  Case "xbm"
		    Return "image/x-xbitmap"
		  Case "xpm"
		    Return "image/x-xpixmap"
		  Case "xwd"
		    Return "image/x-xwindowdump"
		  Case "mime", "eml"
		    Return "message/rfc822"
		  Case "igs"
		    Return "model/iges"
		  Case "msh"
		    Return "model/mesh"
		  Case "dae"
		    Return "model/vnd.collada+xml"
		  Case "dwf"
		    Return "model/vnd.dwf"
		  Case "gdl"
		    Return "model/vnd.gdl"
		  Case "gtw"
		    Return "model/vnd.gtw"
		  Case "mts"
		    Return "model/vnd.mts"
		  Case "vtu"
		    Return "model/vnd.vtu"
		  Case "vrml"
		    Return "model/vrml"
		  Case "manifest"
		    Return "text/cache-manifest"
		  Case "ics"
		    Return "text/calendar"
		  Case "css"
		    Return "text/css"
		  Case "csv"
		    Return "text/csv"
		  Case "html", "htm"
		    Return "text/html"
		  Case "n3"
		    Return "text/n3"
		  Case "txt", "text", "conf", "def", "list", "log", "in", "md"
		    Return "text/plain"
		  Case "dsc"
		    Return "text/prs.lines.tag"
		  Case "rtx"
		    Return "text/richtext"
		  Case "sgml"
		    Return "text/sgml"
		  Case "tsv"
		    Return "text/tab-separated-values"
		  Case "t", "tr", "roff"
		    Return "text/troff"
		  Case "ttl"
		    Return "text/turtle"
		  Case "uri", "uris", "urls"
		    Return "text/uri-list"
		  Case "curl"
		    Return "text/vnd.curl"
		  Case "dcurl"
		    Return "text/vnd.curl.dcurl"
		  Case "scurl"
		    Return "text/vnd.curl.scurl"
		  Case "mcurl"
		    Return "text/vnd.curl.mcurl"
		  Case "fly"
		    Return "text/vnd.fly"
		  Case "flx"
		    Return "text/vnd.fmi.flexstor"
		  Case "gv"
		    Return "text/vnd.graphviz"
		  Case "3dml"
		    Return "text/vnd.in3d.3dml"
		  Case "spot"
		    Return "text/vnd.in3d.spot"
		  Case "jad"
		    Return "text/vnd.sun.j2me.app-descriptor"
		  Case "wml"
		    Return "text/vnd.wap.wml"
		  Case "wmls"
		    Return "text/vnd.wap.wmlscript"
		  Case "asm"
		    Return "text/x-asm"
		  Case "c", "cc", "cxx", "cpp", "h"
		    Return "text/x-c"
		  Case "pas"
		    Return "text/x-pascal"
		  Case "java"
		    Return "text/x-java-source"
		  Case "etx"
		    Return "text/x-setext"
		  Case "uu"
		    Return "text/x-uuencode"
		  Case "vcs"
		    Return "text/x-vcalendar"
		  Case "vcf"
		    Return "text/x-vcard"
		  Case "3gp"
		    Return "video/3gpp"
		  Case "3g2"
		    Return "video/3gpp2"
		  Case "h261"
		    Return "video/h261"
		  Case "h263"
		    Return "video/h263"
		  Case "h264"
		    Return "video/h264"
		  Case "jpgv"
		    Return "video/jpeg"
		  Case "jpm"
		    Return "video/jpm"
		  Case "mj2"
		    Return "video/mj2"
		  Case "ts"
		    Return "video/mp2t"
		  Case "mp4", "mp4v", "mpg4", "m4v"
		    Return "video/mp4"
		  Case "mpeg", "mpg", "mpe", "m1v", "m2v"
		    Return "video/mpeg"
		  Case "ogv"
		    Return "video/ogg"
		  Case "mov", "qt"
		    Return "video/quicktime"
		  Case "uvh"
		    Return "video/vnd.dece.hd"
		  Case "uvm"
		    Return "video/vnd.dece.mobile"
		  Case "uvp"
		    Return "video/vnd.dece.pd"
		  Case "uvs"
		    Return "video/vnd.dece.sd"
		  Case "uvv"
		    Return "video/vnd.dece.video"
		  Case "fvt"
		    Return "video/vnd.fvt"
		  Case "mxu"
		    Return "video/vnd.mpegurl"
		  Case "pyv"
		    Return "video/vnd.ms-playready.media.pyv"
		  Case "uvu"
		    Return "video/vnd.uvvu.mp4"
		  Case "viv"
		    Return "video/vnd.vivo"
		  Case "dif"
		    Return "video/x-dv"
		  Case "dv"
		    Return "video/x-dv"
		  Case "webm"
		    Return "video/webm"
		  Case "f4v"
		    Return "video/x-f4v"
		  Case "fli"
		    Return "video/x-fli"
		  Case "flv"
		    Return "video/x-flv"
		  Case "m4v"
		    Return "video/x-m4v"
		  Case "rbp", "rbbas", "rbvcp", "rbo"
		    Return "application/x-REALbasic-Project"
		  Case "asx", "asf"
		    Return "video/x-ms-asf"
		  Case "wm"
		    Return "video/x-ms-wm"
		  Case "wmv"
		    Return "video/x-ms-wmv"
		  Case "wmx"
		    Return "video/x-ms-wmx"
		  Case "wvx"
		    Return "video/x-ms-wvx"
		  Case "avi"
		    Return "video/x-msvideo"
		  Case "movie"
		    Return "video/x-sgi-movie"
		  Case "ice"
		    Return "x-conference/x-cooltalk"
		  Case "gz"
		    Return "application/gzip"
		  Case "pcap"
		    Return "application/vnd.tcpdump.pcap"
		  Case "url"
		    Return "application/internet-shortcut"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseDate(DateItem As Date) As String
		  ' Returns an RFC 1123-compliant timestamp for the specified Date
		  
		  Dim dt As String
		  DateItem.GMTOffset = 0
		  Select Case DateItem.DayOfWeek
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
		  
		  dt = dt  + Str(DateItem.Day, "00") + " "
		  
		  Select Case DateItem.Month
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
		  
		  dt = dt  + Str(DateItem.Year, "0000") + " " + Str(DateItem.Hour, "00") + ":" + Str(DateItem.Minute, "00") + ":" + Str(DateItem.Second, "00") + " GMT"
		  Return dt
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ParseDate(RawDate As String, ByRef Parsed As Date) As Boolean
		  ' Parses the passed date string into the referenced Date object.
		  ' If parsing was successful, returns True and instantiates the passed date reference; else, returns false.
		  ' Valid for dates between 1 Jan 1970 00:00:00 GMT and 19 Jan 2038 03:14:07 GMT
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_getdate.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ParseDate
		  
		  If Not libcURL.IsAvailable Then Return False
		  Dim count As Integer = curl_getdate(RawDate, Nil)
		  If count > -1 Then
		    Parsed = New Date(1970, 1, 1, 0, 0, 0, 0.0) 'UNIX epoch
		    Parsed.TotalSeconds = Parsed.TotalSeconds + count
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetSSLBackend(BackEnd As libcURL.SSLBackEnd)
		  ' Sets the SSL backend. This is a global setting that can only be set once and must be set before using any other part
		  ' of the library.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_global_sslset.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.SetSSLBackEnd
		  
		  If Not System.IsFunctionAvailable("curl_global_sslset", cURLLib) Then
		    Dim e As New cURLException(Nil)
		    e.ErrorNumber = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise e
		  End If
		  
		  Dim p As Ptr
		  Dim err As Integer = curl_global_sslset(BackEnd, Nil, p)
		  If err = 0 Then Return ' ok
		  
		  Dim ex As New cURLException(Nil)
		  ex.ErrorNumber = err
		  Select Case err
		  Case CURLSSLSET_UNKNOWN_BACKEND
		    ex.Message = "That SSL backend is not available."
		  Case CURLSSLSET_TOO_LATE
		    ex.Message = "The SSL backend has already been initialized and cannot be changed."
		  Case CURLSSLSET_NO_BACKENDS
		    ex.Message = "The installed version of libcurl was built without SSL support."
		  Else
		    ex.Message = "Unknown error while setting the SSL backend."
		  End Select
		  Raise ex
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URLDecode(Data As String, Optional EasyItem As libcURL.EasyHandle) As String
		  ' Returns the decoded Data using percent encoding as defined in rfc2396
		  ' curl_easy_unescape needs a curl_easy handle to decode data. If EasyItem 
		  ' is not Nil, then the EasyItem is used; otherwise a new EasyHandle is constructed.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_unescape.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLDecode
		  
		  If Data = "" Then Return ""
		  If EasyItem = Nil Then EasyItem = New libcURL.EasyHandle
		  If Not libcURL.Version.IsAtLeast(7, 15, 4) Then
		    Errorsetter(EasyItem).LastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(EasyItem)
		  End If
		  
		  Dim output As MemoryBlock
		  Dim ret As String
		  Dim input As MemoryBlock = Data
		  Dim outlen As Integer
		  output = curl_easy_unescape(EasyItem.Handle, input, input.Size, outlen)
		  Try
		    ret = output.StringValue(0, outlen)
		  Finally
		    If output <> Nil Then curl_free(output)
		  End Try
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URLEncode(Data As String, Optional EasyItem As libcURL.EasyHandle) As String
		  ' Returns the Data encoded using percent encoding as defined in rfc2396
		  ' curl_easy_escape needs a curl_easy handle to encode data. If EasyItem
		  ' is not Nil, then the EasyItem is used; otherwise a new EasyHandle is constructed.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_escape.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLEncode
		  
		  If Data = "" Then Return ""
		  If EasyItem = Nil Then EasyItem = New libcURL.EasyHandle
		  If Not libcURL.Version.IsAtLeast(7, 15, 4) Then
		    Errorsetter(EasyItem).LastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(EasyItem)
		  End If
		  
		  Dim ret As String
		  Dim output As MemoryBlock
		  Dim input As MemoryBlock = Data
		  output = curl_easy_escape(EasyItem.Handle, input, input.Size)
		  Try
		    ret = output.CString(0)
		  Finally
		    If output <> Nil Then curl_free(output)
		  End Try
		  Return ret
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Copying
		RB-libcURL (https://github.com/charonn0/RB-libcURL)
		Copyright (c)2014-22 Andrew Lambert, all rights reserved.
		
		 Permission to use, copy, modify, and distribute this software for any purpose
		 with or without fee is hereby granted, provided that the above copyright
		 notice and this permission notice appear in all copies.
		 
		    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS. IN
		    NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
		    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
		    OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
		    OR OTHER DEALINGS IN THE SOFTWARE.
		 
		 Except as contained in this notice, the name of a copyright holder shall not
		 be used in advertising or otherwise to promote the sale, use or other dealings
		 in this Software without prior written authorization of the copyright holder.
		
		----
		License for the DEFAULT_CA_INFO_PEM file:
		
		  This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. 
		  If a copy of the MPL was not distributed with this file, You can obtain one at 
		  https://mozilla.org/MPL/2.0/.
	#tag EndNote


	#tag Constant, Name = cURLLib, Type = String, Dynamic = False, Default = \"libcurl", Scope = Private
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"libcurl.4.dylib"
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"libcurl.dll"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"libcurl"
	#tag EndConstant

	#tag Constant, Name = CURLSSLSET_NO_BACKENDS, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURLSSLSET_TOO_LATE, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURLSSLSET_UNKNOWN_BACKEND, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURL_BLOB_COPY, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURL_BLOB_NOCOPY, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURL_GLOBAL_ALL, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_GLOBAL_DEFAULT, Type = Double, Dynamic = False, Default = \"CURL_GLOBAL_ALL", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_GLOBAL_NOTHING, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_GLOBAL_SSL, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_GLOBAL_WIN32, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_READFUNC_ABORT, Type = Double, Dynamic = False, Default = \"&h10000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_READFUNC_PAUSE, Type = Double, Dynamic = False, Default = \"&h10000001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_WRITEFUNC_PAUSE, Type = Double, Dynamic = False, Default = \"CURL_READFUNC_PAUSE", Scope = Protected
	#tag EndConstant


	#tag Structure, Name = curl_blob, Flags = &h21, Attributes = \"StructureAlignment \x3D 1"
		Data As Ptr
		  Length As UInt32
		Flags As UInt32
	#tag EndStructure

	#tag Structure, Name = curl_header, Flags = &h21, Attributes = \"StructureAlignment \x3D 1"
		Name As Ptr
		  Value As Ptr
		  Amount As UInt32
		  Index As UInt32
		  Origin As UInt32
		Anchor As Ptr
	#tag EndStructure

	#tag Structure, Name = curl_header64, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
		Name As Ptr
		  Value As Ptr
		  Amount As UInt64
		  Index As UInt64
		  Origin As UInt32
		Anchor As Ptr
	#tag EndStructure

	#tag Structure, Name = timeval, Flags = &h21, Attributes = \"StructureAlignment \x3D 1"
		tv_sec As Integer
		tv_usec As Integer
	#tag EndStructure


	#tag Enum, Name = ConnectionType, Type = Integer, Flags = &h1
		NoSSL=0
		  AttemptSSL=1
		  SSLControlConnectionOnly
		SSLForceAll
	#tag EndEnum

	#tag Enum, Name = CURLAUTH, Type = Integer, Flags = &h1
		BASIC=1
		  DIGEST=2
		  DIGEST_IE=16
		  NEGOTIATE=4
		  NTLM=8
		  NTLM_WB=32
		  BEARER=64
		ANY=&hFFFFFFFF
	#tag EndEnum

	#tag Enum, Name = curl_infotype, Flags = &h1
		text
		  header_in
		  header_out
		  data_in
		  data_out
		  ssl_in
		  ssl_out
		  info_end
		RB_libcURL
	#tag EndEnum

	#tag Enum, Name = CWDMethod, Type = Integer, Flags = &h1
		Multi=1
		  None
		Single
	#tag EndEnum

	#tag Enum, Name = FeatureType, Flags = &h1
		AsyncDNS=128
		  CharsetConversion=4096
		  DebugSymbols=8192
		  HTTP2=65536
		  InternationalDomainNames=1024
		  IPv6=1
		  LargeFiles=512
		  SSL=4
		  Auth_Kerberos4=2
		  Auth_Kerberos5
		  Auth_NTLM=16
		  Auth_GSS=32
		  Auth_SPNEGO=256
		  Auth_SSPI=2048
		Auth_TLS_SRP=16384
	#tag EndEnum

	#tag Enum, Name = FormElementType, Flags = &h1
		MemoryBlock
		  Stream
		  String
		  File
		FileArray
	#tag EndEnum

	#tag Enum, Name = HeaderOriginType, Type = Integer, Flags = &h1
		Header=1
		  Trailer=2
		  Connect=4
		  Intermediate_1XX=8
		  Pseudo=16
		Any=31
	#tag EndEnum

	#tag Enum, Name = HTTPVersion, Type = Integer, Flags = &h1
		None=0
		  HTTP1_0=1
		  HTTP1_1=2
		  HTTP2=3
		  HTTP2TLS=4
		HTTP2PriorKnowledge=5
	#tag EndEnum

	#tag Enum, Name = IPVersion, Type = Integer, Flags = &h1
		Whatever=0
		  V4=1
		V6=2
	#tag EndEnum

	#tag Enum, Name = MIMEPartType, Type = Integer, Flags = &h1
		None
		  Data
		  File
		  Callback
		Multipart
	#tag EndEnum

	#tag Enum, Name = OptionType, Flags = &h1
		Number
		  Bitmask
		  LargeNumber
		  Ptr
		  String
		  List
		  Opaque
		  Blob
		  Subroutine
		  Unknown
		Boolean
	#tag EndEnum

	#tag Enum, Name = ProxyErrorType, Type = Integer, Flags = &h1
		None=0
		  BAD_ADDRESS_TYPE=1
		  BAD_VERSION=2
		  CLOSED=3
		  GSSAPI=4
		  GSSAPI_PERMSG=5
		  GSSAPI_PROTECTION=6
		  IDENTD=7
		  IDENTD_DIFFER=8
		  LONG_HOSTNAME=9
		  LONG_PASSWD=10
		  LONG_USER=11
		  NO_AUTH=12
		  RECV_ADDRESS=13
		  RECV_AUTH=14
		  RECV_CONNECT=15
		  RECV_REQACK=16
		  REPLY_ADDRESS_TYPE_NOT_SUPPORTED=17
		  REPLY_COMMAND_NOT_SUPPORTED=18
		  REPLY_CONNECTION_REFUSED=19
		  REPLY_GENERAL_SERVER_FAILURE=20
		  REPLY_HOST_UNREACHABLE=21
		  REPLY_NETWORK_UNREACHABLE=22
		  REPLY_NOT_ALLOWED=23
		  REPLY_TTL_EXPIRED=24
		  REPLY_UNASSIGNED=25
		  REQUEST_FAILED=26
		  RESOLVE_HOST=27
		  SEND_AUTH=28
		  SEND_CONNECT=29
		  SEND_REQUEST=30
		  UNKNOWN_FAIL=31
		  UNKNOWN_MODE=32
		USER_REJECTED=33
	#tag EndEnum

	#tag Enum, Name = ProxyType, Type = Integer, Flags = &h1
		HTTP=0
		  HTTP1_0=1
		  SOCKS4=4
		  SOCKS4A=6
		  SOCKS5=5
		SOCKS5_HOSTNAME=7
	#tag EndEnum

	#tag Enum, Name = SSHAUTH, Type = Integer, Flags = &h1
		PublicKey=1
		  Password=2
		  Host=4
		  Keyboard=8
		  Agent=16
		Any=&hFFFFFFFF
	#tag EndEnum

	#tag Enum, Name = SSLBackEnd, Type = Integer, Flags = &h1
		None=0
		  OpenSSL=1
		  GNUTLS=2
		  NSS=3
		  GSKit=5
		  PolarSSL=6
		  WolfSSL=7
		  SChannel=8
		  DarwinSSL=9
		  AXTLS=10
		  MBEDTLS=11
		  MesaLink=12
		  BearSSL=13
		Ignore=-1
	#tag EndEnum

	#tag Enum, Name = SSLVersion, Type = Integer, Flags = &h1
		Default=0
		  TLSv1=1
		  SSLv2=2
		  SSLv3=3
		  TLSv1_0=4
		  TLSv1_1=5
		  TLSv1_2=6
		  TLSv1_3=7
		  Max_TLSv1_0=65536
		  Max_TLSv1_1=327680
		  Max_TLSv1_2=393216
		  Max_TLSv1_3=458752
		Max_Default
	#tag EndEnum

	#tag Enum, Name = TransferEncoding, Type = Integer, Flags = &h1
		Binary
		  SevenBit
		  EightBit
		  Base64
		QuotedPrintable
	#tag EndEnum

	#tag Enum, Name = URLPart, Type = Integer, Flags = &h1
		All=0
		  Scheme=1
		  User=2
		  Password=3
		  Options=4
		  Host=5
		  Port=6
		  Path=7
		  Query=8
		  Fragment=9
		ZoneID=10
	#tag EndEnum


	#tag ViewBehavior
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
End Module
#tag EndModule
