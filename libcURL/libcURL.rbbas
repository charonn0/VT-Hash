#tag Module
Protected Module libcURL
	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_easy_cleanup Lib "libcurl" (EasyHandle As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_duphandle Lib "libcurl" (EasyHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_escape Lib "libcurl" (EasyHandle As Integer, CharBuffer As Ptr, Length As Integer) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_getinfo Lib "libcurl" (EasyHandle As Integer, InfoCode As Integer, Buffer As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_init Lib "libcurl" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_pause Lib "libcurl" (EasyHandle As Integer, Mask As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_perform Lib "libcurl" (EasyHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_recv Lib "libcurl" (EasyHandle As Integer, Buffer As Ptr, BytesToRead As Integer, ByRef BytesRead As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_easy_reset Lib "libcurl" (EasyHandle As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_send Lib "libcurl" (EasyHandle As Integer, Buffer As Ptr, BytesToWrite As Integer, ByRef BytesWritten As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_setopt Lib "libcurl" (EasyHandle As Integer, Option As Integer, Value As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_strerror Lib "libcurl" (EasyError As Integer) As CString
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_easy_unescape Lib "libcurl" (EasyHandle As Integer, char As Ptr, Length As Integer, ByRef OutLength As Integer) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_formadd Lib "libcurl" (ByRef FirstItem As Ptr, ByRef LastItem As Ptr, Option1 As Integer, Value1 As CString, Option2 As Integer, Value2 As CString, FinalOption As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_formadd Lib "libcurl" (ByRef FirstItem As Ptr, ByRef LastItem As Ptr, Option1 As Integer, Value1 As CString, Option2 As Integer, Value2 As CString, Option3 As Integer, Value3 As CString, FinalOption As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_formfree Lib "libcurl" (curlform As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_formget Lib "libcurl" (First As Ptr, UserData As Integer, Callback As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_free Lib "libcurl" (char As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_getdate Lib "libcurl" (DateString As CString, Reserved As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_global_cleanup Lib "libcurl" ()
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_global_init Lib "libcurl" (flags As Integer) As Integer
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function curl_infoname(MessageType As libcURL.curl_infotype) As String
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
		  Case libcURL.curl_infotype.RB_libcURL
		    Return "RB-libcURL"
		  End Select
		  
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_add_handle Lib "libcurl" (MultiHandle As Integer, EasyHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_cleanup Lib "libcurl" (MultiHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_info_read Lib "libcurl" (MultiHandle As Integer, ByRef MsgCount As Integer) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_init Lib "libcurl" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_perform Lib "libcurl" (MultiHandle As Integer, ByRef ActiveCount As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_remove_handle Lib "libcurl" (MultiHandle As Integer, EasyHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_setopt Lib "libcurl" (MultiHandle As Integer, Option As Integer, Value As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_strerror Lib "libcurl" (errNo As Integer) As CString
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_multi_timeout Lib "libcurl" (MultiHandle As Integer, ByRef Timeout As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_share_cleanup Lib "libcurl" (ShareHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_share_init Lib "libcurl" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_share_setopt Lib "libcurl" (ShareHandle As Integer, Option As Integer, Value As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_share_strerror Lib "libcurl" (errNo As Integer) As CString
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_slist_append Lib "libcurl" (sList As Ptr, Data As CString) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Sub curl_slist_free_all Lib "libcurl" (sList As Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_version Lib "libcurl" () As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function curl_version_info Lib "libcurl" (Version As Integer) As Ptr
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function Default_CA_File() As FolderItem
		  ' For SSL/TLS connections we must specify a file with a list of acceptable certificate authorities to verify the peer with.
		  ' This method dumps the the default CA list for Mozilla products (included as DEFAULT_CA_INFO_PEM) into a temp file and
		  ' returns it. The DEFAULT_CA_INFO_PEM file is subject to the terms of the Mozilla Public License 1.1
		  '
		  ' To generate an updated CA file use one of these two scripts:
		  '    VBScript: https://github.com/bagder/curl/blob/master/lib/mk-ca-bundle.vbs
		  '        perl: https://github.com/bagder/curl/blob/master/lib/mk-ca-bundle.pl
		  
		  Static CA_File As FolderItem
		  If CA_File = Nil Then
		    CA_FILE = App.DataFolder.Child("certlist.pem")
		    If Not CA_File.Exists Then
		      CA_File = GetTemporaryFolderItem()
		      Dim bs As BinaryStream = BinaryStream.Create(CA_File, True)
		      bs.Write(DEFAULT_CA_INFO_PEM)
		      bs.Close
		    End If
		  End If
		  Return CA_File
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
		Attributes( deprecated = "libcURL.cURLClient.Get" ) Protected Function Get(URL As String, TimeOut As Integer, ByRef Headers As InternetHeaders, ByRef StatusCode As Integer, Username As String = "", Password As String = "") As MemoryBlock
		  ' Synchronously performs a retrieval using protocol-appropriate semantics (http GET, ftp RETR, etc.)
		  ' The protocol is inferred from the URL; explictly specify the protocol in the URL to avoid bad guesses.
		  ' Pass a connection TimeOut interval (in seconds), or 0 to wait forever. Pass an InternetHeaders instance and
		  ' an Integer by reference to contain the response headers (if any) and final result code (if any). Headers and
		  ' StatusCode are mandatory and MUST NOT be Nil. Pass a username or password if a username and/or password will
		  ' be required to complete the transfer. Returns a MemoryBlock containing any downloaded data.
		  
		  Dim out As New MemoryBlock(0)
		  Dim outstream As New BinaryStream(out)
		  Dim c As libcURL.EasyHandle = libcURL.SynchronousHelpers.Get(URL, TimeOut, outstream, Headers, Username, Password)
		  StatusCode = c.LastError
		  outstream.Close
		  Return out
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsAvailable() As Boolean
		  ' Returns True if libcURL is available and at least version 7.15.2. Prior versions require that curl_global_init and
		  ' curl_global_cleanup be called only once each, which we aren't doing.
		  Const MinMajor = 7
		  Const MinMinor = 15
		  Const MinPatch = 2
		  
		  Static available As Boolean
		  If Not available Then available = libcURL.Version.IsAtLeast(MinMajor, MinMinor, MinPatch)
		  Return available
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
		Attributes( deprecated = "libcURL.cURLClient.Post" ) Protected Function Post(FormData As Dictionary, URL As String, TimeOut As Integer, ByRef Headers As InternetHeaders, ByRef StatusCode As Integer, Username As String = "", Password As String = "") As MemoryBlock
		  ' Synchronously POST the passed FormData via HTTP(S) using multipart/form-data encoding. The FormData dictionary
		  ' contains NAME:VALUE pairs comprising HTML form elements. NAME is a string containing the form-element name; VALUE
		  ' may be a string or a FolderItem. Pass a connection TimeOut interval (in seconds), or 0 to wait forever. Pass an
		  ' InternetHeaders instance and an Integer by reference to contain the response headers (if any) and final result
		  ' code (if any). Headers and StatusCode are mandatory and MUST NOT be Nil. Pass a username or password if a username
		  ' and/or password will be required to complete the transfer. Returns a MemoryBlock containing any downloaded data.
		  
		  Dim out As New MemoryBlock(0)
		  Dim outstream As New BinaryStream(out)
		  Dim c As libcURL.EasyHandle = libcURL.SynchronousHelpers.Post(FormData, URL, TimeOut, outstream, Headers, Username, Password)
		  StatusCode = c.LastError
		  outstream.Close
		  Return out
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Attributes( deprecated = "libcURL.cURLClient.Put" ) Protected Function Put(File As FolderItem, URL As String, TimeOut As Integer, ByRef Headers As InternetHeaders, ByRef StatusCode As Integer, Username As String = "", Password As String = "") As MemoryBlock
		  ' Synchronously uploads the passed FolderItem using protocol-appropriate semantics (http PUT, ftp STOR, etc.)
		  ' The protocol is inferred from the URL; explictly specify the protocol in the URL to avoid bad guesses. The
		  ' path part of the URL specifies the remote directory and file name to store the file under. Pass a connection
		  ' TimeOut interval (in seconds), or 0 to wait forever. Pass an InternetHeaders instance and an Integer by reference
		  ' to contain the response headers (if any) and final result code (if any). Headers and StatusCode are mandatory
		  ' and MUST NOT be Nil. Pass a username or password if a username and/or password will be required to complete
		  ' the transfer. Returns a MemoryBlock containing any downloaded data.
		  
		  Dim out As New MemoryBlock(0)
		  Dim outstream As New BinaryStream(out)
		  Dim instream As BinaryStream = BinaryStream.Open(File)
		  
		  Dim c As libcURL.EasyHandle = libcURL.SynchronousHelpers.Put(URL, TimeOut, instream, outstream, Headers, Username, Password)
		  StatusCode = c.LastError
		  outstream.Close
		  instream.Close
		  Return out
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URLDecode(Data As String, Optional EasyItem As libcURL.EasyHandle) As String
		  ' Returns the decoded Data using percent encoding as defined in rfc2396
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_unescape.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLDecode
		  
		  If EasyItem = Nil Then EasyItem = New libcURL.EasyHandle(CURL_GLOBAL_NOTHING)
		  If Not libcURL.Version.IsAtLeast(7, 15, 4) Then
		    Errorsetter(EasyItem).LastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(EasyItem)
		  End If
		  
		  Dim InP As MemoryBlock = Data
		  Dim outlen As Integer
		  Dim p As Ptr = curl_easy_unescape(EasyItem.Handle, InP, InP.Size, outlen)
		  InP = p
		  Dim ret As String = InP.StringValue(0, outlen)
		  curl_free(p)
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URLEncode(Data As String, Optional EasyItem As libcURL.EasyHandle) As String
		  ' Returns the Data encoded using percent encoding as defined in rfc2396
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_escape.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLEncode
		  
		  If EasyItem = Nil Then EasyItem = New libcURL.EasyHandle(CURL_GLOBAL_NOTHING)
		  If Not libcURL.Version.IsAtLeast(7, 15, 4) Then
		    Errorsetter(EasyItem).LastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(EasyItem)
		  End If
		  
		  Dim InP As MemoryBlock = Data
		  Dim p As Ptr = curl_easy_escape(EasyItem.Handle, InP, InP.Size)
		  InP = p
		  Dim ret As String = InP.CString(0)
		  curl_free(p)
		  Return ret
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Copying
		libcURL Copyright (c) 1996 - 2015, Daniel Stenberg, <daniel@haxx.se>.
		RB-libcURL Copyright (c)2014-15 Andrew Lambert, <andrew@boredomsoft.org>.
		 
		All rights reserved.
		 
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
	#tag EndNote


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
