#tag Class
Protected Class EasyHandle
Inherits libcURL.cURLHandle
	#tag Method, Flags = &h0
		Sub ClearFormData()
		  ' Clears all forms and resets upload options. Can be used to do a "soft" reset even
		  ' if no form was defined.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.ClearFormData
		  
		  If Not Me.SetOption(libcURL.Opts.POSTFIELDSIZE, -1) Then Raise New libcURL.cURLException(Me)
		  If libcURL.Version.IsAtLeast(7, 17, 1) Then
		    If Not Me.SetOption(libcURL.Opts.COPYPOSTFIELDS, Nil) Then Raise New libcURL.cURLException(Me)
		  End If
		  If Not Me.SetOption(libcURL.Opts.HTTPPOST, Nil) Then Raise New libcURL.cURLException(Me)
		  mForm = Nil
		  mUploadMode = False
		  If Not Me.SetOption(libcURL.Opts.HTTPGET, True) Then Raise New libcURL.cURLException(Me)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( deprecated = "libcURL.CookieEngine.NewSession" )  Sub ClearSessionCookies()
		  If Not Me.CookieEngine.NewSession Then Raise New cURLException(Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CloseCallback(UserData As Integer, Socket As Integer) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return CURL_SOCKET_BAD
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlClose(socket)
		  End If
		  
		  Return CURL_SOCKET_BAD
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConnectionCount() As Integer
		  ' Returns the number of sockets employed by the easy handle which have not yet disconnected.
		  ' libcURL will attempt to reuse connections, so this may be greater-than zero even after a
		  ' transfer has completed.
		  
		  Return mConnectionCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GlobalInitFlags As Integer = libcURL.CURL_GLOBAL_DEFAULT)
		  ' Creates a new curl_easy handle. If creating the handle fails for any reason
		  ' an exception will be raised; otherwise, the handle may be used immediately.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_init.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(GlobalInitFlags)
		  
		  mHandle = curl_easy_init()
		  If mHandle > 0 Then
		    If Instances = Nil Then Instances = New Dictionary
		    Instances.Value(mHandle) = New WeakRef(Me)
		    InitCallbacks()
		  Else
		    mLastError = libcURL.Errors.INIT_FAILED
		    Raise New cURLException(Me)
		  End If
		  ' by default, only raise the DebugMessage event if we're debugging
		  #If DebugBuild Then
		    Me.Verbose = True
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(CopyOpts As libcURL.EasyHandle)
		  ' Creates a new curl_easy handle by cloning the passed handle and all of its options. The clone is independent
		  ' of the original. If CopyOpts is Nil, its handle is invalid, or its handle cannot be duplicated an exception
		  ' will be raised.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_duphandle.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Constructor
		  
		  If CopyOpts = Nil Or CopyOpts.Handle = 0 Then Raise New NilObjectException
		  // Calling the overridden superclass constructor.
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(CopyOpts.Flags)
		  mHandle = curl_easy_duphandle(CopyOpts.Handle)
		  If mHandle > 0 Then
		    Instances.Value(mHandle) = New WeakRef(Me)
		    InitCallbacks()
		    If CopyOpts.mAuthMethods <> Nil Then Call Me.SetAuthMethods(CopyOpts.GetAuthMethods)
		    mAutoDisconnect = CopyOpts.AutoDisconnect
		    mAutoReferer = CopyOpts.AutoReferer
		    If CopyOpts.mCA_ListFile <> Nil Then Me.CA_ListFile = CopyOpts.CA_ListFile
		    mConnectionTimeout = CopyOpts.ConnectionTimeout
		    mConnectionType = CopyOpts.ConnectionType
		    Me.CookieEngine.Enabled = CopyOpts.CookieEngine.Enabled
		    Me.UseErrorBuffer = CopyOpts.UseErrorBuffer
		    mFailOnServerError = CopyOpts.FailOnServerError
		    mFollowRedirects = CopyOpts.FollowRedirects
		    mHTTPCompression = CopyOpts.HTTPCompression
		    mHTTPPreserveMethod = CopyOpts.HTTPPreserveMethod
		    mHTTPVersion = CopyOpts.HTTPVersion
		    mMaxRedirects = CopyOpts.MaxRedirects
		    mPassword = CopyOpts.Password
		    If CopyOpts.mProxyEngine <> Nil Then
		      Me.ProxyEngine.Address = CopyOpts.ProxyEngine.Address
		      If CopyOpts.ProxyEngine.Port <> 1080 Then Me.ProxyEngine.Port = CopyOpts.ProxyEngine.Port
		      If CopyOpts.ProxyEngine.Type <> libcURL.ProxyType.HTTP Then Me.ProxyEngine.Type = CopyOpts.ProxyEngine.Type
		    End If
		    mSecure = CopyOpts.Secure
		    If CopyOpts.SSLVersion <> libcURL.SSLVersion.Default Then mSSLVersion = CopyOpts.SSLVersion
		    mTimeOut = CopyOpts.TimeOut
		    mUploadMode = CopyOpts.UploadMode
		    mUserAgent = CopyOpts.UserAgent
		    mUsername = CopyOpts.Username
		    Me.Verbose = CopyOpts.Verbose
		    mForm = CopyOpts.mForm
		  Else
		    mLastError = libcURL.Errors.INIT_FAILED
		    Raise New cURLException(Me)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function curlClose(Socket As Integer) As Integer
		  ' This method is the intermediary between CloseCallback and the Disconnected event.
		  ' DO NOT CALL THIS METHOD
		  mConnectionCount = mConnectionCount - 1
		  RaiseEvent Disconnected(Socket)
		  
		  #If TargetWin32 Then
		    Declare Function closesocket Lib "Ws2_32" (SocketHandle As Integer) As Integer
		    mLastError = closesocket(Socket)
		  #else
		    Dim bs As BinaryStream
		    bs = New BinaryStream(Socket, BinaryStream.HandleTypeFileNumber)
		    bs.Close
		    mLastError = bs.LastErrorCode
		  #endif
		  Return CURL_SOCKOPT_OK
		  
		Exception Err As RuntimeException
		  If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		  Return CURL_SOCKOPT_ERROR
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLCloseCallback(UserData As Integer, cURLSocket As Integer) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Function curlDebug(info As curl_infotype, data As MemoryBlock, Size As Integer) As Integer
		  ' This method is the intermediary between DebugCallback and the DebugMessage event.
		  ' DO NOT CALL THIS METHOD
		  
		  RaiseEvent DebugMessage(info, DefineEncoding(data.StringValue(0, size), Encodings.UTF8))
		  Return size
		  
		Exception Err As RuntimeException
		  If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		  Return 0
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLDebugCallback(Handle As Integer, info As curl_infotype, data As Ptr, size As Integer, UserData As Integer) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Function curlHeader(char As Ptr, size As Integer, nmemb As Integer) As Integer
		  ' This method is the intermediary between HeaderCallback and the HeaderReceived event.
		  ' DO NOT CALL THIS METHOD
		  
		  Dim sz As Integer = nmemb * size
		  Dim data As MemoryBlock = char
		  Dim s As String = data.StringValue(0, sz)
		  RaiseEvent HeaderReceived(s)
		  Return sz
		  
		Exception Err As RuntimeException
		  If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		  Return 0
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLIOCallback(char As Ptr, size As Integer, nmemb As Integer, UserData As Integer) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Function curlOpen(SocketType As Integer, Socket As Integer) As Integer
		  ' This method is the intermediary between OpenCallback and the CreateSocket event.
		  ' DO NOT CALL THIS METHOD
		  
		  Const CURL_SOCKOPT_BAD = 1
		  Const CURLSOCKTYPE_IPCXN = 0
		  Const CURLSOCKTYPE_ACCEPT = 1
		  
		  Select Case SocketType
		  Case CURLSOCKTYPE_IPCXN, CURLSOCKTYPE_ACCEPT
		    RaiseEvent CreateSocket(Socket)
		    mConnectionCount = mConnectionCount + 1
		    Return CURL_SOCKOPT_OK
		  End Select
		  
		  Return CURL_SOCKOPT_BAD
		  
		Exception Err As RuntimeException
		  If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		  Return CURL_SOCKOPT_BAD
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLOpenCallback(UserData As Integer, Socket As Integer, SocketType As Integer) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Function curlProgress(dlTotal As Int64, dlNow As Int64, ulTotal As Int64, ulNow As Int64) As Integer
		  ' This method is the intermediary between ProgressCallback and the Progress event.
		  ' Return True from the Progress event to abort.
		  ' DO NOT CALL THIS METHOD
		  
		  If RaiseEvent Progress(dlTotal, dlnow, ultotal, ulnow) Then Return 1
		  
		Exception Err As RuntimeException
		  If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		  Return 1
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLProgressCallback(UserData As Integer, dlTotal As Int64, dlNow As Int64, ulTotal As Int64, ulnNow As Int64) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Function curlRead(char As MemoryBlock, size As Integer, nmemb As Integer) As Integer
		  ' This method is the intermediary between ReadCallback and the DataNeeded event.
		  ' DO NOT CALL THIS METHOD
		  
		  Dim sz As Integer = nmemb * size
		  If UploadStream Is Nil Then
		    Return RaiseEvent DataNeeded(char, sz)
		  Else
		    Dim mb As MemoryBlock = UploadStream.Read(sz)
		    If mb.Size > 0 Then char.StringValue(0, mb.Size) = mb.StringValue(0, mb.Size)
		    Return mb.Size
		  End If
		  
		Exception Err As RuntimeException
		  If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		  Return CURL_READFUNC_ABORT
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function curlSeek(Offset As Integer, Origin As Integer) As Integer
		  ' This method is the intermediary between SeekCallback and the SeekStream event.
		  ' DO NOT CALL THIS METHOD
		  
		  If UploadStream Is Nil Or Not UploadStream IsA BinaryStream Then
		    If RaiseEvent SeekStream(Offset, Origin) Then Return 0
		  Else
		    Dim bs As BinaryStream = BinaryStream(UploadStream)
		    If bs.Length <= Offset And Offset > -1 Then
		      bs.Position = Offset
		      Return 0
		    End If
		  End If
		  
		  Return 2 ' fail seek, but libcURL can try to work around it.
		  
		Exception Err As RuntimeException
		  If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		  Return 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function curlWrite(char As MemoryBlock, size As Integer, nmemb As Integer) As Integer
		  ' This method is the intermediary between WriteCallback and the DataAvailable event.
		  ' DO NOT CALL THIS METHOD
		  
		  If DownloadStream Is Nil Then
		    Return RaiseEvent DataAvailable(char.StringValue(0, nmemb * size))
		  Else
		    DownloadStream.Write(char.StringValue(0, nmemb * size))
		    Return nmemb * size
		  End If
		  
		Exception Err As RuntimeException
		  If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DebugCallback(Handle As Integer, info As curl_infotype, data As Ptr, size As Integer, UserData As Integer) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Handle ' handle is the cURL handle of the instance, which we stored in UserData already
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlDebug(info, data, size)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  ' Closes the handle.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_cleanup.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Destructor
		  
		  If mHandle <> 0 Then
		    curl_easy_cleanup(mHandle)
		    Instances.Remove(mHandle)
		    mErrorBuffer = Nil
		  End If
		  mConnectionCount = 0
		  mHandle = 0
		  
		  If Instances <> Nil And Instances.Count = 0 Then Instances = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorBuffer() As String
		  ' Returns a copy of the contents of the error buffer, or an empty string. The contents of this buffer will persist
		  ' between transfers; it is NOT automatically cleared. To clear the buffer set UseErrorBuffer to True (even if
		  ' it's already True)
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.ErrorBuffer
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.UseErrorBuffer
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_ERRORBUFFER.html
		  
		  If mErrorBuffer <> Nil Then Return mErrorBuffer.CString(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAuthMethods() As libcURL.HTTPAuthMethods
		  ' Gets an object which represents the available/allowed HTTP authentication methods.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLINFO_HTTPAUTH_AVAIL.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.GetAuthMethods
		  
		  If mAuthMethods = Nil Then mAuthMethods = Me.GetInfo(libcURL.Info.HTTPAUTH_AVAIL)
		  return mAuthMethods
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInfo(InfoType As Integer) As Variant
		  ' Calls curl_easy_getinfo. Returns a Variant suitable to contain the InfoType requested. If the InfoType is not
		  ' among the values marshalled below, a TypeMismatchException will be raised.
		  ' This method returns various data about the most recently completed connection (successful or not.)
		  ' As such, it is not useful to call this method before the first connection attempt.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_getinfo.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.GetInfo
		  
		  Dim mb As MemoryBlock
		  
		  Select Case InfoType
		  Case libcURL.Info.EFFECTIVE_URL, libcURL.Info.REDIRECT_URL, libcURL.Info.CONTENT_TYPE, libcURL.Info.PRIVATE_, libcURL.Info.PRIMARY_IP, _
		    libcURL.Info.LOCAL_IP, libcURL.Info.FTP_ENTRY_PATH, libcURL.Info.RTSP_SESSION_ID
		    mb = New MemoryBlock(4)
		    If Me.GetInfo(InfoType, mb) Then
		      mb = mb.Ptr(0)
		      If mb <> Nil Then Return mb.CString(0)
		    End If
		    
		  Case libcURL.Info.RESPONSE_CODE, libcURL.Info.HTTP_CONNECTCODE, libcURL.Info.FILETIME, libcURL.Info.REDIRECT_COUNT, libcURL.Info.HEADER_SIZE, _
		    libcURL.Info.REQUEST_SIZE, libcURL.Info.SSL_VERIFYRESULT, libcURL.Info.OS_ERRNO, _
		    libcURL.Info.NUM_CONNECTS, libcURL.Info.PRIMARY_PORT, libcURL.Info.LOCAL_PORT, libcURL.Info.LASTSOCKET, libcURL.Info.CONDITION_UNMET, _
		    libcURL.Info.RTSP_CLIENT_CSEQ, libcURL.Info.RTSP_SERVER_CSEQ, libcURL.Info.RTSP_CSEQ_RECV
		    mb = New MemoryBlock(4)
		    If Me.GetInfo(InfoType, mb) Then Return mb.Int32Value(0)
		    
		  Case libcurl.Info.PROXYAUTH_AVAIL, libcURL.Info.HTTPAUTH_AVAIL
		    mb = New MemoryBlock(4)
		    If Me.GetInfo(InfoType, mb) Then
		      Dim h As libcURL.HTTPAuthMethods = mb.Int32Value(0)
		      Return h
		    End If
		    
		  Case libcURL.Info.TOTAL_TIME, libcURL.Info.NAMELOOKUP_TIME, libcURL.Info.CONNECT_TIME, libcURL.Info.APPCONNECT_TIME, libcURL.Info.PRETRANSFER_TIME, _
		    libcURL.Info.STARTTRANSFER_TIME, libcURL.Info.REDIRECT_TIME, libcURL.Info.SIZE_DOWNLOAD, libcURL.Info.SIZE_UPLOAD, libcURL.Info.SPEED_DOWNLOAD, _
		    libcURL.Info.SPEED_UPLOAD, libcURL.Info.CONTENT_LENGTH_UPLOAD, libcURL.Info.CONTENT_LENGTH_DOWNLOAD
		    mb = New MemoryBlock(8)
		    If Me.GetInfo(InfoType, mb) Then Return mb.DoubleValue(0)
		    
		  Case libcURL.Info.SSL_ENGINES, libcURL.Info.COOKIELIST
		    mb = New MemoryBlock(8)
		    If Me.GetInfo(InfoType, mb) And mb.Ptr(0) <> Nil Then Return New libcURL.ListPtr(mb.Ptr(0))
		    
		  Else
		    Dim err As New TypeMismatchException
		    err.Message = "0x" + Left(Hex(InfoType) + "00000000", 8) + " is not a known InfoType."
		    err.ErrorNumber = InfoType
		    Raise err
		  End Select
		  
		Exception Err As NilObjectException
		  If mLastError <> 0 Then Raise New cURLException(Me) Else Raise Err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInfo(InfoType As Integer, Buffer As MemoryBlock) As Boolean
		  ' Calls curl_easy_getinfo. If the operation succeeded then this function returns True
		  ' and the requested information is copied into the Buffer. Otherwise this function
		  ' returns False and the error code is stored in LastError. This method returns various
		  ' data about the most recently completed connection (successful or not.) As such, it
		  ' is not useful to call this method before the first connection attempt.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_getinfo.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.GetInfo
		  
		  
		  mLastError = curl_easy_getinfo(mHandle, InfoType, Buffer)
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function HeaderCallback(char As Ptr, size As Integer, nmemb As Integer, UserData As Integer) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlHeader(char, size, nmemb)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InitCallbacks()
		  ' This method sets up the callback functions for the EasyHandle.
		  
		  If libcURL.Version.IsAtLeast(7, 16, 0) Then
		    If Not SetOption(libcURL.Opts.SOCKOPTDATA, mHandle) Then Raise New cURLException(Me)
		    If Not SetOption(libcURL.Opts.SOCKOPTFUNCTION, AddressOf OpenCallback) Then Raise New cURLException(Me)
		  End If
		  
		  If libcURL.Version.IsAtLeast(7, 21, 7) Then
		    If Not SetOption(libcURL.Opts.CLOSESOCKETDATA, mHandle) Then Raise New cURLException(Me)
		    If Not SetOption(libcURL.Opts.CLOSESOCKETFUNCTION, AddressOf CloseCallback) Then Raise New cURLException(Me)
		  End If
		  
		  If libcURL.Version.IsAtLeast(7, 18, 0) Then
		    If Not SetOption(libcURL.Opts.SEEKDATA, mHandle) Then Raise New cURLException(Me)
		    If Not SetOption(libcURL.Opts.SEEKFUNCTION, AddressOf SeekCallback) Then Raise New cURLException(Me)
		  End If
		  
		  If mUseProgressEvent Then UseProgressEvent = True
		  If libcURL.Version.IsAtLeast(7, 32, 0) Then
		    If Not SetOption(libcURL.Opts.XFERINFOFUNCTION, AddressOf ProgressCallback) Then Raise New cURLException(Me)
		    If Not SetOption(libcURL.Opts.XFERINFODATA, mHandle) Then Raise New cURLException(Me)
		  Else ' old versions
		    If Not SetOption(libcURL.Opts.PROGRESSDATA, mHandle) Then Raise New cURLException(Me)
		    If Not SetOption(libcURL.Opts.PROGRESSFUNCTION, AddressOf ProgressCallback) Then Raise New cURLException(Me)
		  End If
		  
		  If Not SetOption(libcURL.Opts.WRITEDATA, mHandle) Then Raise New cURLException(Me)
		  If Not SetOption(libcURL.Opts.WRITEFUNCTION, AddressOf WriteCallback) Then Raise New cURLException(Me)
		  
		  If Not SetOption(libcURL.Opts.READDATA, mHandle) Then Raise New cURLException(Me)
		  If Not SetOption(libcURL.Opts.READFUNCTION, AddressOf ReadCallback) Then Raise New cURLException(Me)
		  
		  If Not SetOption(libcURL.Opts.HEADERDATA, mHandle) Then Raise New cURLException(Me)
		  If Not SetOption(libcURL.Opts.HEADERFUNCTION, AddressOf HeaderCallback) Then Raise New cURLException(Me)
		  
		  If Not SetOption(libcURL.Opts.DEBUGDATA, mHandle) Then Raise New cURLException(Me)
		  If Not SetOption(libcURL.Opts.DEBUGFUNCTION, AddressOf DebugCallback) Then Raise New cURLException(Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function OpenCallback(UserData As Integer, Socket As Integer, SocketType As Integer) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlOpen(SocketType, Socket)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		  Return CURL_SOCKET_BAD
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherEasy As libcURL.EasyHandle) As Integer
		  ' This method overloads the comparison operator(=), permitting direct
		  ' comparisons between instances of EasyHandle.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Operator_Compare
		  
		  Dim i As Integer = Super.Operator_Compare(OtherEasy)
		  If i = 0 Then i = Sign(mHandle - OtherEasy.Handle)
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Pause(Mask As Integer = CURLPAUSE_ALL) As Boolean
		  ' Pauses or unpauses uploads and/or downloads
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_pause.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Pause
		  
		  If libcURL.Version.IsAtLeast(7, 18, 0) Then
		    mLastError = curl_easy_pause(mHandle, Mask)
		  Else
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		  End If
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Perform(URL As String = "", Timeout As Integer = 0) As Boolean
		  ' Tells libcURL to perform the transfer. Pass a URL if you have not specified one already using EasyHandle.URL.
		  ' Pass an integer representing how long libcURL should wait, in seconds, before giving up the connection
		  ' attempt. The default is to wait forever.
		  '
		  ' This method is a blocking function: it will not return (and your application will stop responding) until the
		  ' transfer completes. For non-blocking transfers use the MultiHandle class to manage the EasyHandle.
		  '
		  ' If this method returns true the transfer completed without error. Otherwise, check EasyHandle.LastError for the
		  ' error code.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_perform.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Perform
		  
		  If URL <> "" Then Me.URL = URL
		  If Timeout > 0 Then Me.ConnectionTimeout = Timeout
		  mLastError = curl_easy_perform(mHandle)
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ProgressCallback(UserData As Integer, dlTotal As Int64, dlNow As Int64, ulTotal As Int64, ulNow As Int64) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlProgress(dlTotal, dlnow, ultotal, ulnow)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Count As Integer, encoding As TextEncoding = Nil) As String
		  ' Only available after calling SetOption(libcURL.Opts.CONNECT_ONLY, True)
		  ' Once Perform returns you may Read from the easy_handle by calling this method
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_recv.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Read
		  
		  Static IsAvailable As Boolean
		  If Not IsAvailable Then IsAvailable = libcURL.Version.IsAtLeast(7, 18, 2)
		  If Not IsAvailable Then
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(Me)
		  End If
		  
		  Dim mb As New MemoryBlock(Count)
		  Dim i As Integer
		  mLastError = curl_easy_recv(mHandle, mb, mb.Size, i)
		  If mLastError = 0 Then
		    Dim s As String
		    If encoding <> Nil Then
		      s = DefineEncoding(mb.StringValue(0, i), encoding)
		    Else
		      s = mb.StringValue(0, i)
		    End If
		    Return s
		  ElseIf mLastError = libcURL.Errors.UNSUPPORTED_PROTOCOL Then ' no readable connection
		    Return ""
		  Else
		    Dim err As New IOException
		    err.ErrorNumber = Me.LastError
		    err.Message = libcURL.FormatError(Me.LastError)
		    Raise err
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ReadCallback(char As Ptr, size As Integer, nmemb As Integer, UserData As Integer) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  // called when data is needed
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlRead(char, size, nmemb)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  ' Resets the curl_easy handle to a pristine state. You may reuse the handle immediately.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_reset.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Reset
		  
		  curl_easy_reset(mHandle)
		  mAuthMethods = Nil
		  mAutoDisconnect = False
		  mAutoReferer = False
		  mCA_ListFile = Nil
		  mConnectionTimeout = 300
		  mConnectionType = libcURL.ConnectionType.NoSSL
		  mErrorBuffer = Nil
		  mFailOnServerError = False
		  mFollowRedirects = False
		  mForm = Nil
		  mHTTPCompression = False
		  mHTTPVersion = 0
		  mMaxRedirects = -1
		  mPassword = ""
		  mProxyEngine = Nil
		  mSecure = True
		  mSSLVersion = libcURL.SSLVersion.Default
		  mTimeOut = 0
		  mUploadMode = False
		  mUserAgent = ""
		  mUsername = ""
		  Verbose = mVerbose
		  InitCallbacks()
		  mLastError = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Resume(Mask As Integer = CURLPAUSE_CONT) As Boolean
		  ' Resumes uploads and/or downloads
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_pause.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Resume
		  
		  Return Me.Pause(mask)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SeekCallback(Userdata As Integer, Offset As Integer, Origin As Integer) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlSeek(Offset, Origin)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetAuthMethods(NewAuthMask As libcURL.HTTPAuthMethods) As Boolean
		  ' Sets the available/allowed HTTP authentication methods.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_HTTPAUTH.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.SetAuthMethods
		  
		  If Not Me.SetOption(libcURL.Opts.HTTPAUTH, NewAuthMask) Then Return False
		  mAuthMethods = NewAuthMask.Mask
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFormData(FormData As libcURL.MultipartForm)
		  ' Sets the FormData MultipartForm object as the HTTP form to POST as multipart/form-data
		  ' You may also pass a Dictionary of NAME:VALUE pairs comprising HTML form elements which
		  ' will be automatically converted to a MultipartForm
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_HTTPPOST.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.SetFormData
		  
		  Me.ClearFormData
		  If Not Me.SetOption(libcURL.Opts.HTTPPOST, FormData) Then Raise New libcURL.cURLException(Me)
		  mForm = FormData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFormData(FormData() As String)
		  ' Sets the FormData array as the HTTP form to POST as application/x-www-form-urlencoded
		  ' Pass an array of URL encoded "Name=Value" strings.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_COPYPOSTFIELDS.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.SetFormData
		  
		  If Not libcURL.Version.IsAtLeast(7, 17, 1) Then
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New libcURL.cURLException(Me)
		  End If
		  
		  Me.ClearFormData
		  Dim data As String = Join(FormData, "&")
		  If Not Me.SetOption(libcURL.Opts.POSTFIELDSIZE, data.LenB) Then Raise New libcURL.cURLException(Me)
		  If Not Me.SetOption(libcURL.Opts.COPYPOSTFIELDS, data) Then Raise New libcURL.cURLException(Me)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(OptionNumber As Integer, NewValue As Variant) As Boolean
		  ' SetOption is the primary interface to the easy_handle. Call this method with a curl option number
		  ' and a value that is acceptable for that option. SetOption does not check that a value is valid for
		  ' a particular option (except Nil,) however it will raise an exception if an unsupported type is passed.
		  
		  ' NewValue may be a Boolean, Integer, Ptr, String, MemoryBlock, FolderItem, libcURL.MultipartForm,
		  ' libcURL.ListPtr, libcuRL.HTTPAuthMethods; or, a Delegate matching cURLIOCallback, cURLCloseCallback,
		  ' cURLDebugCallback, cURLOpenCallback, or cURLProgressCallback. Passing Nil will raise an exception
		  ' unless the option explicitly accepts NULL.
		  
		  ' If the option was set then this method returns True. If it returns False then the option was not set
		  ' and the curl error number is stored in EasyHandle.LastError.
		  
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_setopt.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.SetOption
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts
		  
		  Dim ValueType As Integer = VarType(NewValue)
		  Select Case ValueType
		    
		  Case Variant.TypeNil ' Sometimes Nil is an error; sometimes not
		    Static Nilable() As Integer = Array(libcURL.Opts.POSTFIELDS, libcURL.Opts.HTTPHEADER, libcURL.Opts.PROXYHEADER, _
		    libcURL.Opts.FTPPORT, libcURL.Opts.QUOTE, libcURL.Opts.POSTQUOTE, libcURL.Opts.PREQUOTE, libcURL.Opts.FTP_ACCOUNT, _
		    libcURL.Opts.RTSP_SESSION_ID, libcURL.Opts.RANGE, libcURL.Opts.CUSTOMREQUEST, libcURL.Opts.DNS_INTERFACE, _
		    libcURL.Opts.DNS_LOCAL_IP4, libcURL.Opts.DNS_LOCAL_IP6, libcURL.Opts.KRBLEVEL, libcURL.Opts.CLOSESOCKETFUNCTION, _
		    libcURL.Opts.DEBUGFUNCTION, libcURL.Opts.HEADERFUNCTION, libcURL.Opts.OPENSOCKETFUNCTION, libcURL.Opts.PROGRESSFUNCTION, _
		    libcURL.Opts.READFUNCTION, libcURL.Opts.SSL_CTX_FUNCTION, libcURL.Opts.WRITEFUNCTION, libcURL.Opts.SHARE, _
		    libcURL.Opts.COOKIEJAR, libcURL.Opts.COOKIEFILE, libcURL.Opts.HTTPPOST, libcURL.Opts.CAINFO, libcURL.Opts.CAPATH, _
		    libcURL.Opts.NETINTERFACE, libcURL.Opts.ERRORBUFFER, libcURL.Opts.COPYPOSTFIELDS, libcURL.Opts.ACCEPT_ENCODING, _
		    libcURL.Opts.FNMATCH_FUNCTION, libcURL.Opts.CHUNK_BGN_FUNCTION, libcURL.Opts.CHUNK_END_FUNCTION, libcURL.Opts.CHUNK_DATA, _
		    libcURL.Opts.SSLCERT)
		    ' These option numbers explicitly accept NULL. Refer to the curl documentation on the individual option numbers for details.
		    If Nilable.IndexOf(OptionNumber) > -1 Then
		      Return Me.SetOptionPtr(OptionNumber, Nil)
		    Else
		      ' for all other option numbers reject NULL values.
		      Dim err As New NilObjectException
		      err.Message = "cURL option number 0x" + Hex(OptionNumber) + " may not be set to null."
		      Raise err
		    End If
		    
		  Case Variant.TypeBoolean
		    If NewValue.BooleanValue Then
		      Return Me.SetOption(OptionNumber, 1)
		    Else
		      Return Me.SetOption(OptionNumber, 0)
		    End If
		    
		  Case Variant.TypePtr, Variant.TypeInteger
		    Return Me.SetOptionPtr(OptionNumber, NewValue.PtrValue)
		    
		  Case Variant.TypeString
		    Dim mb As MemoryBlock = NewValue.CStringValue + Chr(0) ' make doubleplus sure it's null terminated
		    Return Me.SetOptionPtr(OptionNumber, mb)
		    
		  Case Variant.TypeObject
		    ' To add support for a custom object type, add a block to this Select statement
		    Select Case NewValue
		    Case IsA MemoryBlock
		      Return Me.SetOptionPtr(OptionNumber, NewValue.PtrValue)
		      
		    Case IsA FolderItem
		      Return Me.SetOption(OptionNumber, FolderItem(NewValue).AbsolutePath)
		      
		    Case IsA Dictionary ' assume a multipart form
		      Dim form As Dictionary = NewValue
		      mForm = form
		      Return Me.SetOption(OptionNumber, mForm)
		      
		    Case IsA libcURL.HTTPAuthMethods
		      Dim auth As HTTPAuthMethods = NewValue
		      Return Me.SetOption(OptionNumber, auth.Mask)
		      
		    Case IsA libcURL.cURLHandle
		      Dim cURL As libcURL.cURLHandle = NewValue
		      Return Me.SetOption(OptionNumber, cURL.Handle)
		      
		    Case IsA cURLProgressCallback
		      Dim p As cURLProgressCallback = NewValue
		      Return Me.SetOptionPtr(OptionNumber, p)
		      
		    Case IsA cURLIOCallback
		      Dim p As cURLIOCallback = NewValue
		      Return Me.SetOptionPtr(OptionNumber, p)
		      
		    Case IsA cURLDebugCallback
		      Dim p As cURLDebugCallback = NewValue
		      Return Me.SetOptionPtr(OptionNumber, p)
		      
		    Case IsA cURLCloseCallback
		      Dim p As cURLCloseCallback = NewValue
		      Return Me.SetOptionPtr(OptionNumber, p)
		      
		    Case IsA cURLOpenCallback
		      Dim p As cURLOpenCallback = NewValue
		      Return Me.SetOptionPtr(OptionNumber, p)
		      
		    End Select
		  End Select
		  
		  Dim err As New TypeMismatchException
		  err.Message = "NewValue is of unsupported vartype: " + Str(ValueType)
		  Raise err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOptionPtr(OptionNumber As Integer, NewValue As Ptr) As Boolean
		  ' Call this method with a curl option number and a Ptr to a representation of the new value for that option.
		  ' The Ptr is passed verbatim to libcURL.
		  '
		  ' If the option was set this method returns True. If it returns False the option was not set and the
		  ' curl error number is stored in EasyHandle.LastError.
		  
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_setopt.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.SetOptionPtr
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts
		  
		  mLastError = curl_easy_setopt(mHandle, OptionNumber, NewValue)
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetRequestHeader(Optional List As libcURL.ListPtr, Name As String, Value As String) As libcURL.ListPtr
		  ' Subsequent calls to this method will append the headers to the List parameter. You must maintain a reference to the List until
		  ' it is no longer in use by libcURL. Pass the List reference back to this function when adding subsequent headers.
		  ' If Name is "" (empty string), then any previously set headers will be cleared and this function returns Nil. The List may then
		  ' be safely destroyed. If List is not specified then a new List is returned.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_HTTPHEADER.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.SetRequestHeader
		  
		  If List = Nil And Name <> "" Then ' Add first header
		    List = Array(Name + ": " + Value) ' array converts to ListPtr
		    
		  ElseIf Name <> "" Then ' append another header
		    Dim s() As String = List
		    If Not Me.SetOption(libcURL.Opts.HTTPHEADER, Nil) Then Raise New cURLException(Me)
		    If Name = "" And Value = "" Then Return Nil
		    For i As Integer = UBound(s) DownTo 0
		      If NthField(s(i), ":", 1).Trim = Name Then s.Remove(i)
		    Next
		    List = s
		    If Not List.Append(Name + ": " + Value) Then Raise New cURLException(List)
		    
		  Else' clear all headers
		    List = Nil
		    
		  End If
		  
		  If Not Me.SetOption(libcURL.Opts.HTTPHEADER, List) Then Raise New cURLException(Me)
		  Return List
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Write(Text As String) As Integer
		  ' Only available after calling SetOption(libcURL.Opts.CONNECT_ONLY, True)
		  ' Once Perform returns you may Write to the easy_handle by calling this method
		  ' If the write succeeded this method returns then number of bytes actually written.
		  ' If the write failed an IOException will be raised.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_send.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Write
		  
		  Static IsAvailable As Boolean
		  If Not IsAvailable Then IsAvailable = libcURL.Version.IsAtLeast(7, 18, 2)
		  If Not IsAvailable Then
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(Me)
		  End If
		  
		  Dim byteswritten As Integer
		  Dim mb As MemoryBlock = Text
		  mLastError = curl_easy_send(mHandle, mb, mb.Size, byteswritten)
		  If mLastError = 0 Then
		    Return byteswritten
		  ElseIf mLastError = libcURL.Errors.UNSUPPORTED_PROTOCOL Then ' no writeable connection
		    Return 0
		  Else
		    Dim err As New IOException
		    err.ErrorNumber = Me.LastError
		    err.Message = libcURL.FormatError(Me.LastError)
		    Raise err
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function WriteCallback(char As Ptr, size As Integer, nmemb As Integer, UserData As Integer) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  // Called when data is available
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlWrite(char, size, nmemb)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CreateSocket(Socket As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DataAvailable(NewData As MemoryBlock) As Integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DataNeeded(Buffer As MemoryBlock, MaxLength As Integer) As Integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DebugMessage(MessageType As libcURL.curl_infotype, Data As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Disconnected(Socket As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event HeaderReceived(HeaderLine As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Progress(dlTotal As Int64, dlNow As Int64, ulTotal As Int64, ulNow As Int64) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SeekStream(Offset As Integer, Origin As Integer) As Boolean
	#tag EndHook


	#tag Note, Name = Using this class
		This class provides basic access to the curl_easy API. It is strongly recommended that you
		familiarize yourself with libcURL, as this class is mostly glue code for libcURL's API.
		
		Create a new instance, then use the SetOption method to define what cURL will be doing.
		
		For example, setting the user-agent string:
		
		   Dim mcURL As New libcURL.EasyHandle
		   If Not mcURL.SetOption(libcURL.Opts.USERAGENT, "Bob's download manager/5.1") Then
		      MsgBox("cURL error: " + Str(mcURL.LastError))
		   End If
		
		SetOption accepts a Variant as the option value, but only Boolean, Integer, Ptr, String, MemoryBlock, 
		FolderItem, libcURL.MultipartForm, libcURL.ListPtr should be used. 
		
		Once all options are set, you may call the EasyHandle.Perform method to initiate a synchronous (i.e. blocking)
		transfer, or pass the EasyHandle to a MultiHandle stack for asynchronous processing.
		
		Once the transfer has completed (successfully or not, and regardless of whether a MultiHandle stack was used,)
		you may call EasyHandle.GetInfo to retrieve various data about the transfer.
		
		For example, continuing the above code sample:
		
		   If Not mcURL.Perform("http://www.example.com/") Then
		      MsgBox("cURL error: " + Str(mcURL.LastError))
		   Else
		      MsgBox("Transfer completed successfully with HTTP status: " + mcURL.GetInfo(libcURL.Info.RESPONSE_CODE)
		   End If
		
		NOTE: 
		In order to receive downloaded data you must handle the DataAvailable event.
		In order to provide upload data you must handle the DataNeeded event.
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mAutoDisconnect
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' If true, libcURL will close sockets immediately after the transfer completes.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.AutoDisconnect
			  
			  If Not Me.SetOption(libcURL.Opts.FORBID_REUSE, value) Then Raise New cURLException(Me)
			  If Not Me.SetOption(libcURL.Opts.FRESH_CONNECT, value) Then Raise New cURLException(Me)
			  mAutoDisconnect = value
			End Set
		#tag EndSetter
		AutoDisconnect As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mAutoReferer
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' If true, libcURL will automatically set the HTTP referer header when following a redirect.
			  ' The default is False.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_AUTOREFERER.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.AutoReferer
			  
			  If Not Me.SetOption(libcURL.Opts.AUTOREFERER, value) Then Raise New cURLException(Me)
			  mAutoReferer = value
			End Set
		#tag EndSetter
		AutoReferer As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the PEM file (or a directory of PEM files) containing one or more certificate authorities libcURL
			  ' will trust to verify the peer with. If no file/folder is specified (default) then returns Nil.
			  
			  return mCA_ListFile
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the PEM file (or a directory of PEM files) containing one or more certificate authorities libcURL
			  ' should trust to verify the peer with. Set this to libcURL.Default_CA_File to use the default CA list for
			  ' Mozilla products. Set this to Nil to unset the current file/folder.
			  ' EasyHandle.Secure must be set to True to enable certificate verification.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_CAINFO.html
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_CAPATH.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.CA_ListFile
			  
			  Select Case True
			  Case value = Nil
			    If Not Me.SetOption(libcURL.Opts.CAINFO, Nil) Then Raise New cURLException(Me)
			    If Not Me.SetOption(libcURL.Opts.CAPATH, Nil) Then Raise New cURLException(Me)
			    
			  Case value.Directory
			    If Not Me.SetOption(libcURL.Opts.CAPATH, value) Then Raise New cURLException(Me)
			    
			  Else
			    If Not Me.SetOption(libcURL.Opts.CAINFO, value) Then Raise New cURLException(Me)
			    
			  End Select
			  
			  mCA_ListFile = value
			End Set
		#tag EndSetter
		CA_ListFile As FolderItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mConnectionTimeout
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the connection timeout in seconds. libcURL will abort the attempt if no connection is established before
			  ' time expires. If a connection is aborted due to the timeout elapsing EasyHandle.LastError will be
			  ' libcURL.Errors.TIMEOUT (28). The default is 300 seconds.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_CONNECTTIMEOUT.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.ConnectionTimeout
			  
			  If Not Me.SetOption(libcURL.Opts.CONNECTTIMEOUT, value) Then Raise New cURLException(Me)
			  mConnectionTimeout = value
			End Set
		#tag EndSetter
		ConnectionTimeout As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets whether SSL will be requested. Returns one of the libcURL.Opts.USE_SSL_* values.
			  
			  return mConnectionType
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets whether SSL will be requested. Use one of the libcURL.Opts.USE_SSL_* values.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_USE_SSL.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.ConnectionType
			  
			  If Not Me.SetOption(libcURL.Opts.USE_SSL, Integer(value)) Then Raise New cURLException(Me)
			  mConnectionType = value
			End Set
		#tag EndSetter
		ConnectionType As libcURL.ConnectionType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mCookieEngine = Nil Then mCookieEngine = New libcURL.CookieEngine(Me)
			  return mCookieEngine
			End Get
		#tag EndGetter
		CookieEngine As libcURL.CookieEngine
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the local file to be used as cookie storage. If no file/folder is specified (default) then returns Nil.
			  
			  return Me.CookieEngine.CookieJar
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the local file to be used as cookie storage.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_COOKIEJAR.html
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_COOKIEFILE.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.CookieJar
			  
			  Me.CookieEngine.CookieJar = value
			End Set
		#tag EndSetter
		Attributes( deprecated = "libcURL.EasyHandle.CookieEngine.CookieJar" ) CookieJar As FolderItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the method libcURL will use to traverse the remote directory tree.
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/CURLOPT_FTP_FILEMETHOD.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.CWDMethod
			  
			  return mCWDMethod
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the method libcURL will use to traverse the remote directory tree.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/CURLOPT_FTP_FILEMETHOD.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.CWDMethod
			  
			  If Not Me.SetOption(libcURL.Opts.FTP_FILEMETHOD, Integer(value)) Then Raise New cURLException(Me)
			  mCWDMethod = value
			End Set
		#tag EndSetter
		CWDMethod As libcURL.CWDMethod
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		DownloadStream As Writeable
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets whether HTTP error codes constitute a failure condition. The default is False.
			  
			  return mFailOnServerError
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets whether HTTP error codes constitute a failure condition. The default is False.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_FAILONERROR.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.FailOnServerError
			  
			  If Not Me.SetOption(libcURL.Opts.FAILONERROR, value) Then Raise New cURLException(Me)
			  mFailOnServerError = value
			End Set
		#tag EndSetter
		FailOnServerError As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets whether libcURL will follow HTTP redirection. The default is False
			  
			  Return mFollowRedirects
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets whether libcURL will follow HTTP redirection. The default is False
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_FOLLOWLOCATION.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.FollowRedirects
			  
			  If Not Me.SetOption(libcURL.Opts.FOLLOWLOCATION, value) Then Raise New cURLException(Me)
			  mFollowRedirects = value
			End Set
		#tag EndSetter
		FollowRedirects As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mHTTPCompression
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If libcURL.Version.LibZ.IsAvailable Then
			    If value Then
			      If Not Me.SetOption(libcURL.Opts.ACCEPT_ENCODING, "") Then Raise New cURLException(Me)
			    Else
			      If Not Me.SetOption(libcURL.Opts.ACCEPT_ENCODING, Nil) Then Raise New cURLException(Me)
			    End If
			    mHTTPCompression = value
			  Else
			    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
			  End If
			End Set
		#tag EndSetter
		HTTPCompression As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mHTTPPreserveMethod
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Not libcURL.Version.IsAtLeast(7, 17, 1) Then
			    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
			    Return
			  End If
			  
			  Dim mask As Integer
			  If value Then mask = 7 ' CURL_REDIR_POST_ALL
			  If Not Me.SetOption(libcURL.Opts.POSTREDIR, mask) Then Raise New libcURL.cURLException(Me)
			  mHTTPPreserveMethod = value
			End Set
		#tag EndSetter
		HTTPPreserveMethod As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the version of HTTP to be used. Returns HTTP_VERSION_1_0, HTTP_VERSION_1_1, HTTP_VERSION_2_0, or HTTP_VERSION_NONE
			  return mHTTPVersion
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the version of HTTP to be used. Pass HTTP_VERSION_1_0, HTTP_VERSION_1_1, HTTP_VERSION_2_0, or HTTP_VERSION_NONE
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_HTTP_VERSION.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.HTTPVersion
			  
			  If Not Me.SetOption(libcURL.Opts.HTTPVERSION, value) Then Raise New cURLException(Me)
			  mHTTPVersion = value
			End Set
		#tag EndSetter
		HTTPVersion As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected Shared Instances As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The local port used to make the most recent connection. This is decided upon by libcurl and the OS's network stack
			  
			  Return Me.GetInfo(libcURL.Info.LOCAL_PORT)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the local port to use for the next connection
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_LOCALPORT.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.LocalPort
			  
			  If Not Me.SetOption(libcURL.Opts.LOCALPORT, value) Then Raise New cURLException(Me)
			End Set
		#tag EndSetter
		LocalPort As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAuthMethods As libcURL.HTTPAuthMethods
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAutoDisconnect As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAutoReferer As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMaxRedirects
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Not Me.SetOption(libcURL.Opts.MAXREDIRS, value) Then Raise New libcURL.cURLException(Me)
			  mMaxRedirects = value
			End Set
		#tag EndSetter
		MaxRedirects As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCA_ListFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConnectionCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConnectionTimeout As Integer = 300
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConnectionType As libcURL.ConnectionType
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCookieEngine As libcURL.CookieEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCWDMethod As libcURL.CWDMethod = libcURL.CWDMethod.Multi
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mErrorBuffer As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFailOnServerError As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFollowRedirects As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mForm As libcURL.MultipartForm
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHTTPCompression As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHTTPPreserveMethod As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHTTPVersion As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxRedirects As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProxyEngine As libcURL.ProxyEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSecure As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSSLVersion As libcURL.SSLVersion = libcURL.SSLVersion.Default
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTimeOut As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUploadMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUseProgressEvent As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserAgent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsername As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVerbose As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the local network connection used to perform the most recent transfer
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/curl_easy_getinfo.html#CURLINFOLOCALIP
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.NetworkInterface
			  ' http://docs.xojo.com/index.php/NetworkInterface
			  
			  
			  Dim ip As String = Me.GetInfo(libcURL.Info.LOCAL_IP)
			  If Me.LastError <> 0 Then Return Nil
			  For i As Integer = 0 To System.NetworkInterfaceCount - 1
			    Dim iface As NetworkInterface = System.GetNetworkInterface(i)
			    If iface.IPAddress = ip Then
			      Return iface
			    End If
			  Next
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the local network interface to be used for the next connection.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_INTERFACE.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.NetworkInterface
			  ' http://docs.xojo.com/index.php/NetworkInterface
			  
			  If value <> Nil Then
			    If Not Me.SetOption(libcURL.Opts.NETINTERFACE, value.IPAddress) Then Raise New cURLException(Me)
			  Else
			    If Not Me.SetOption(libcURL.Opts.NETINTERFACE, Nil) Then Raise New cURLException(Me)
			  End If
			End Set
		#tag EndSetter
		NetworkInterface As NetworkInterface
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The password to be supplied to the remote host if the underlying protocol requires/allows users to log on.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_PASSWORD.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Password
			  
			  If Not Me.SetOption(libcURL.Opts.PASSWORD, value) Then Raise New cURLException(Me)
			  mPassword = value
			End Set
		#tag EndSetter
		Password As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			SocketCore.Port workalike.
			See: http://docs.xojo.com/index.php/SocketCore.Port
			
			Prior to connecting, you may set this value to the remote port to connect to. If the port is not specified
			libcURL will select the default port for the inferred protocol (e.g. HTTP=80; HTTPS=443)
			
			Once connected, you may get this value to read the actual remote port number that is connected to.
		#tag EndNote
		#tag Getter
			Get
			  //Remote port
			  Return Me.GetInfo(libcURL.Info.PRIMARY_PORT)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  //remote port.
			  If Not Me.SetOption(libcURL.Opts.PORT, value) Then Raise New cURLException(Me)
			End Set
		#tag EndSetter
		Port As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mProxyEngine = Nil Then mProxyEngine = New libcURL.ProxyEngine(Me)
			  return mProxyEngine
			End Get
		#tag EndGetter
		ProxyEngine As libcURL.ProxyEngine
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Prior to connecting this value will be empty. Once connected, this value will contain the
			  ' IP address of the remote server.
			  
			  Return Me.GetInfo(libcURL.Info.PRIMARY_IP)
			End Get
		#tag EndGetter
		RemoteIP As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mSecure
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' If True, libcURL will verify any SSL certificates presented by a server. This does not
			  ' tell libcURL to use SSL, only to verify certs if SSL is used. Use EasyHandle.CA_ListFile to
			  ' specify a list of certificate authorities to be trusted.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYHOST.html
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Secure
			  
			  If value Then
			    If Not Me.SetOption(libcURL.Opts.SSL_VERIFYHOST, 2) Then Raise New cURLException(Me) ' 2 is not a typo
			    If Not Me.SetOption(libcURL.Opts.SSL_VERIFYPEER, 1) Then Raise New cURLException(Me)
			  Else
			    If Not Me.SetOption(libcURL.Opts.SSL_VERIFYHOST, 0) Then Raise New cURLException(Me)
			    If Not Me.SetOption(libcURL.Opts.SSL_VERIFYPEER, 0) Then Raise New cURLException(Me)
			  End If
			  
			  mSecure = value
			End Set
		#tag EndSetter
		Secure As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the version of SSL/TLS to be used.
			  return mSSLVersion
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the version of SSL/TLS to be used.
			  
			  If Not Me.SetOption(libcURL.Opts.SSLVERSION, Integer(value)) Then Raise New cURLException(Me)
			  mSSLVersion = value
			End Set
		#tag EndSetter
		SSLVersion As libcURL.SSLVersion
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mTimeOut
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the timeout period, in seconds, for the entire transfer (including time spent establishing the
			  ' connection.) libcURL will abort the if the transfer has not completed before time expires. If a
			  ' transfer is aborted due to the timeout elapsing EasyHandle.LastError will be libcURL.Errors.TIMEOUT (28).
			  ' A timeout of zero means no timeout (wait forever) and is the default.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_TIMEOUT.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Timeout
			  
			  If Not Me.SetOption(libcURL.Opts.TIMEOUT, value) Then Raise New cURLException(Me)
			  mTimeOut = value
			End Set
		#tag EndSetter
		TimeOut As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mUploadMode
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' If True, the next transfer is an upload operation.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_UPLOAD.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.UploadMode
			  
			  If Not Me.SetOption(libcURL.Opts.UPLOAD, value) Then Raise New libcURL.cURLException(Me)
			  mUploadMode = value
			End Set
		#tag EndSetter
		UploadMode As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		UploadStream As Readable
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the last effective URL, if any
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/curl_easy_getinfo.html#CURLINFOEFFECTIVEURL
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.URL
			  
			  Return DefineEncoding(Me.GetInfo(libcURL.Info.EFFECTIVE_URL), Encodings.UTF8)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the URL for the next request.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/curl_easy_setopt.html#CURLOPTURL
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.URL
			  
			  If Not SetOption(libcURL.Opts.URL, value) Then Raise New cURLException(Me)
			End Set
		#tag EndSetter
		URL As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mErrorBuffer <> Nil And mErrorBuffer.Size > 0
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets whether libcURL will write additional debug info to an application-provided buffer.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_ERRORBUFFER.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.UseErrorBuffer
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.ErrorBuffer
			  
			  If value Then
			    mErrorBuffer = New MemoryBlock(256)
			  Else
			    mErrorBuffer = Nil
			  End If
			  If Not Me.SetOption(libcURL.Opts.ERRORBUFFER, mErrorBuffer) Then Raise New cURLException(Me)
			End Set
		#tag EndSetter
		UseErrorBuffer As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mUseProgressEvent
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables and disables the Progress event. The progress event is called very frequently, so if
			  ' you aren't handling it then you may see a performance boost by disabling the event entirely.
			  ' This can be toggled on and off at any time.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/CURLOPT_NOPROGRESS.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.UseProgressEvent
			  
			  If value Then
			    If Not Me.SetOption(libcURL.Opts.NOPROGRESS, False) Then Raise New cURLException(Me)
			  Else
			    If Not Me.SetOption(libcURL.Opts.NOPROGRESS, True) Then Raise New cURLException(Me)
			  End If
			  mUseProgressEvent = value
			End Set
		#tag EndSetter
		UseProgressEvent As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mUserAgent
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the User-Agent string used by libcURL for protocols which support that feature.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_USERAGENT.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.UserAgent
			  
			  If Not Me.SetOption(libcURL.Opts.USERAGENT, value) Then Raise New cURLException(Me)
			  mUserAgent = value
			End Set
		#tag EndSetter
		UserAgent As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mUsername
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The username to be supplied to the remote host if the underlying protocol requires/allows users to log on.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_USERNAME.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.UserName
			  
			  If Not Me.SetOption(libcURL.Opts.USERNAME, value) Then Raise New cURLException(Me)
			  mUsername = value
			End Set
		#tag EndSetter
		Username As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mVerbose
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Pass True to receive the DebugMessage event. The default is False
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/curl_easy_setopt.html#CURLOPTVERBOSE
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Verbose
			  
			  If Not Me.SetOption(libcURL.Opts.VERBOSE, value) Then Raise New cURLException(Me)
			  mVerbose = value
			End Set
		#tag EndSetter
		Verbose As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = CURLPAUSE_ALL, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLPAUSE_CONT, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLPAUSE_RECV, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLPAUSE_SEND, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURL_SOCKET_BAD, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_SOCKOPT_ERROR, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_SOCKOPT_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = GNUTLS_MAX_ALGORITHM_NUM, Type = Double, Dynamic = False, Default = \"16", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HTTP_VERSION_1_0, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HTTP_VERSION_1_1, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HTTP_VERSION_2_0, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HTTP_VERSION_NONE, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="AutoDisconnect"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoReferer"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConnectionTimeout"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FailOnServerError"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FollowRedirects"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPCompression"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPPreserveMethod"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPVersion"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="LocalPort"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxRedirects"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Password"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemoteIP"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Secure"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TimeOut"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UploadMode"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="URL"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseErrorBuffer"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseProgressEvent"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UserAgent"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Username"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Verbose"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
