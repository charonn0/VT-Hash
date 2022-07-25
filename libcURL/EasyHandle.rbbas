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
		  
		  If Not libcURL.Version.IsExactly(7, 56, 1) Then // broken in this version only
		    If Not Me.SetOption(libcURL.Opts.POSTFIELDSIZE, -1) Then Raise New cURLException(Me)
		  End If
		  If libcURL.Version.IsAtLeast(7, 17, 1) Then
		    If Not Me.SetOption(libcURL.Opts.COPYPOSTFIELDS, Nil) Then Raise New cURLException(Me)
		  End If
		  If Not Me.SetOption(libcURL.Opts.HTTPPOST, Nil) Then Raise New cURLException(Me)
		  If libcURL.Version.IsAtLeast(7, 56, 0) Then
		    If Not Me.SetOption(libcURL.Opts.MIMEPOST, Nil) Then Raise New cURLException(Me)
		  End If
		  mForm = Nil
		  mMIMEMessage = Nil
		  mUploadMode = False
		  If Not Me.SetOption(libcURL.Opts.HTTPGET, True) Then Raise New cURLException(Me)
		  
		End Sub
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
		  // Constructor() -- From libcURL.cURLHandle
		  #pragma Unused GlobalInitFlags
		  Super.Constructor()
		  
		  mHandle = curl_easy_init()
		  If mHandle = 0 Then
		    mLastError = libcURL.Errors.INIT_FAILED
		    Raise New cURLException(Me)
		  End If
		  
		  mOptions = New Dictionary
		  If Instances = Nil Then Instances = New Dictionary
		  Instances.Value(mHandle) = New WeakRef(Me)
		  InitCallbacks()
		  
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
		  
		  // Calling the overridden superclass constructor.
		  // Constructor() -- From libcURL.cURLHandle
		  Super.Constructor()
		  
		  If CopyOpts.Handle = 0 Then Raise New NilObjectException
		  mHandle = curl_easy_duphandle(CopyOpts.Handle)
		  If mHandle = 0 Then
		    mLastError = libcURL.Errors.INIT_FAILED
		    Raise New cURLException(Me)
		  End If
		  
		  mOptions = New Dictionary
		  For Each opt As Integer In CopyOpts.mOptions.Keys
		    mOptions.Value(opt) = CopyOpts.mOptions.Value(opt)
		  Next
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function curlDebug(info As curl_infotype, data As MemoryBlock, Size As Integer) As Integer
		  ' This method is the intermediary between DebugCallback and the DebugMessage event.
		  ' DO NOT CALL THIS METHOD
		  
		  #If LOG_DEBUG Then
		    ' writes debug messages to System.DebugLog
		    Select Case info
		    Case libcURL.curl_infotype.data_in, libcURL.curl_infotype.data_out, libcURL.curl_infotype.ssl_in, libcURL.curl_infotype.ssl_out
		      ' skip raw data messages
		    Else
		      System.DebugLog(curl_infoname(info) + ": " + DefineEncoding(data.StringValue(0, size), Encodings.UTF8).Trim)
		    End Select
		  #endif
		  
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
		Private Function curlHeader(char As MemoryBlock, size As Integer, nmemb As Integer) As Integer
		  ' This method is the intermediary between HeaderCallback and the HeaderReceived event.
		  ' DO NOT CALL THIS METHOD
		  
		  Dim sz As Integer = nmemb * size
		  RaiseEvent HeaderReceived(char.StringValue(0, sz))
		  Return sz
		  
		  Exception Err As RuntimeException
		    If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		    Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function curlInitRequest(PrimaryIP As MemoryBlock, LocalIP As MemoryBlock, PrimaryPort As Int32, LocalPort As Int32) As Integer
		  ' This method is the intermediary between InitRequestCallback and the RequestInitiated event.
		  ' DO NOT CALL THIS METHOD
		  
		  Const CURL_PREREQFUNC_ABORT = 1
		  Const CURL_PREREQFUNC_OK = 0
		  
		  Dim remote, local As String
		  remote = DefineEncoding(PrimaryIP.CString(0), Encodings.UTF8)
		  local = DefineEncoding(LocalIP.CString(0), Encodings.UTF8)
		  
		  If RaiseEvent RequestInitiated(remote, local, PrimaryPort, LocalPort) Then Return CURL_PREREQFUNC_ABORT
		  Return CURL_PREREQFUNC_OK
		  
		  Exception Err As RuntimeException
		    If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		    Return CURL_PREREQFUNC_ABORT
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLInitRequestCallback(UserData As Integer, PrimaryIP As Ptr, LocalIP As Ptr, PrimaryPort As Int32, LocalPort As Int32) As Integer
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLIOCallback(char As Ptr, size As Integer, nmemb As Integer, UserData As Integer) As Integer
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
		Private Delegate Function cURLProgressCallback(UserData As Integer, dlTotal As Int64, dlNow As Int64, ulTotal As Int64, ulNow As Int64) As Integer
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
		    If mb.Size > 0 Then char.StringValue(0, mb.Size) = mb
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

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLSeekCallback(Userdata As Integer, Offset As Integer, Origin As Integer) As Integer
	#tag EndDelegateDeclaration

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
		  If curl <> Nil And curl.Value IsA EasyHandle Then
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
		    ' strings
		  Case libcURL.Info.EFFECTIVE_URL, libcURL.Info.REDIRECT_URL, libcURL.Info.CONTENT_TYPE, libcURL.Info.PRIVATE_, libcURL.Info.PRIMARY_IP, _
		    libcURL.Info.LOCAL_IP, libcURL.Info.FTP_ENTRY_PATH, libcURL.Info.RTSP_SESSION_ID, libcURL.Info.SCHEME, libcURL.Info.EFFECTIVE_METHOD, _
		    libcURL.Info.REFERER
		    #If Target32Bit Then
		      mb = New MemoryBlock(4)
		    #Else
		      mb = New MemoryBlock(8)
		    #Endif
		    If Me.GetInfo(InfoType, mb) Then
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
		    If Me.GetInfo(InfoType, mb) Then Return mb.Int32Value(0)
		    
		  Case libcURL.Info.PROXY_ERROR
		    mb = New MemoryBlock(4)
		    If Me.GetInfo(InfoType, mb) Then Return CType(mb.Int32Value(0), libcURL.ProxyErrorType)
		    
		    ' dates
		  Case libcURL.Info.FILETIME
		    mb = New MemoryBlock(4)
		    If Me.GetInfo(InfoType, mb) Then
		      Dim t As Int32 = mb.Int32Value(0)
		      If t >= 0 Then
		        Dim d As New Date(1970, 1, 1, 0, 0, 0, 0.0) 'UNIX epoch
		        d.TotalSeconds = d.TotalSeconds + t
		        Return d
		      End If
		    End If
		    
		    ' HTTPAuthMethods
		  Case libcurl.Info.PROXYAUTH_AVAIL, libcURL.Info.HTTPAUTH_AVAIL
		    mb = New MemoryBlock(4)
		    If Me.GetInfo(InfoType, mb) Then
		      Dim h As libcURL.HTTPAuthMethods = mb.Int32Value(0)
		      Return h
		    End If
		    
		    ' Doubles
		  Case libcURL.Info.TOTAL_TIME, libcURL.Info.NAMELOOKUP_TIME, libcURL.Info.CONNECT_TIME, libcURL.Info.APPCONNECT_TIME, libcURL.Info.PRETRANSFER_TIME, _
		    libcURL.Info.STARTTRANSFER_TIME, libcURL.Info.REDIRECT_TIME, libcURL.Info.SIZE_DOWNLOAD, libcURL.Info.SIZE_UPLOAD, libcURL.Info.SPEED_DOWNLOAD, _
		    libcURL.Info.SPEED_UPLOAD, libcURL.Info.CONTENT_LENGTH_UPLOAD, libcURL.Info.CONTENT_LENGTH_DOWNLOAD
		    mb = New MemoryBlock(8)
		    If Me.GetInfo(InfoType, mb) Then Return mb.DoubleValue(0)
		    
		    ' Int64s
		  Case libcURL.Info.TOTAL_TIME_T, libcURL.Info.NAMELOOKUP_TIME_T, libcURL.Info.CONNECT_TIME_T, libcURL.Info.APPCONNECT_TIME_T, _
		    libcURL.Info.PRETRANSFER_TIME_T, libcURL.Info.STARTTRANSFER_TIME_T, libcURL.Info.REDIRECT_TIME_T, libcURL.Info.SIZE_DOWNLOAD_T, _
		    libcURL.Info.SIZE_UPLOAD_T, libcURL.Info.SPEED_DOWNLOAD_T, libcURL.Info.SPEED_UPLOAD_T, libcURL.Info.CONTENT_LENGTH_UPLOAD_T, _
		    libcURL.Info.CONTENT_LENGTH_DOWNLOAD_T
		    mb = New MemoryBlock(8)
		    If Me.GetInfo(InfoType, mb) Then Return mb.Int64Value(0)
		    
		    ' ListPtrs
		  Case libcURL.Info.SSL_ENGINES, libcURL.Info.COOKIELIST
		    #If Target32Bit Then
		      mb = New MemoryBlock(4)
		    #Else
		      mb = New MemoryBlock(8)
		    #Endif
		    If Me.GetInfo(InfoType, mb) And mb.Ptr(0) <> Nil Then Return New ListPtr(mb.Ptr(0))
		    
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

	#tag Method, Flags = &h0
		Function GetOption(OptionNumber As Integer, DefaultValue As Variant = Nil) As Variant
		  ' This method complements the SetOption method. You can use this method to retrieve any previously-set
		  ' option value. If the OptionNumber has not been set then the DefaultValue parameter is returned.
		  '
		  ' This method cannot retrieve option values which were set using the SetOptionPtr method.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.GetOption
		  
		  Const SECRET_INTERNAL_FLAG = &hFEF1F0F9
		  If OptionNumber = SECRET_INTERNAL_FLAG And DefaultValue Is Me Then Return mOptions
		  
		  Dim v As Variant = mOptions.Lookup(OptionNumber, DefaultValue)
		  If v IsA WeakRef And WeakRef(v).Value IsA cURLHandle Then v = WeakRef(v).Value
		  Return v
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function HeaderCallback(char As Ptr, size As Integer, nmemb As Integer, UserData As Integer) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlHeader(char, size, nmemb)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InitCallbacks()
		  ' This method sets up the callback functions for the EasyHandle.
		  
		  If libcURL.Version.IsAtLeast(7, 18, 0) Then
		    If Not SetOption(libcURL.Opts.SEEKDATA, mHandle) Then Raise New cURLException(Me)
		    If Not SetOption(libcURL.Opts.SEEKFUNCTION, AddressOf SeekCallback) Then Raise New cURLException(Me)
		  End If
		  
		  If mUseProgressEvent Then UseProgressEvent = True
		  If libcURL.Version.IsAtLeast(7, 32, 0) Then
		    If Not SetOption(libcURL.Opts.XFERINFODATA, mHandle) Then Raise New cURLException(Me)
		    If Not SetOption(libcURL.Opts.XFERINFOFUNCTION, AddressOf ProgressCallback) Then Raise New cURLException(Me)
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
		  
		  If libcURL.Version.IsAtLeast(7, 80, 0) Then
		    If Not SetOption(libcURL.Opts.PREREQDATA, mHandle) Then Raise New cURLException(Me)
		    If Not SetOption(libcURL.Opts.PREREQFUNCTION, AddressOf InitRequestCallback) Then Raise New cURLException(Me)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function InitRequestCallback(UserData As Integer, PrimaryIP As Ptr, LocalIP As Ptr, PrimaryPort As Int32, LocalPort As Int32) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlInitRequest(PrimaryIP, LocalIP, PrimaryPort, LocalPort)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub KeepAlive()
		  ' Sends a protocol-specific "keep-alive" message.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_easy_upkeep.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.KeepAlive
		  
		  If libcURL.Version.IsAtLeast(7, 62, 0) Then
		    mLastError = curl_easy_upkeep(mHandle)
		  Else
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		  End If
		End Sub
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
		  ' THIS IS PROBABLY NOT THE METHOD YOU ARE LOOKING FOR. YOU PROBABLY WANT CURLCLIENT.PERFORM()
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
		  If curl <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlProgress(dlTotal, dlnow, ultotal, ulnow)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ReadCallback(char As Ptr, size As Integer, nmemb As Integer, UserData As Integer) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  // called when data is needed
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value IsA EasyHandle Then
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
		  mOptions = New Dictionary
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
		  mHTTPVersion = libcURL.HTTPVersion.None
		  mMaxRedirects = -1
		  mPassword = ""
		  mProxyEngine = Nil
		  mSecure = True
		  mSSLVersion = libcURL.SSLVersion.Default
		  mTimeOut = 0
		  mUploadMode = False
		  mUserAgent = ""
		  mUseProgressEvent = True
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
		  If curl <> Nil And curl.Value IsA EasyHandle Then
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
		Sub SetFormData(FormData As libcURL.MIMEMessage)
		  ' Sets the FormData MIMEMessage object as the HTTP form to POST as multipart/form-data
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_MIMEPOST.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.SetFormData
		  
		  Me.ClearFormData
		  If Not Me.SetOption(libcURL.Opts.MIMEPOST, FormData) Then Raise New libcURL.cURLException(Me)
		  mMIMEMessage = FormData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFormData(FormData As libcURL.MultipartForm)
		  ' Sets the FormData MultipartForm object as the HTTP form to POST as multipart/form-data
		  ' You may also pass a Dictionary of NAME:VALUE pairs comprising HTTP form elements which
		  ' will be automatically converted to a MultipartForm
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_HTTPPOST.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.SetFormData
		  
		  Me.ClearFormData
		  If Not Me.SetOption(libcURL.Opts.HTTPPOST, FormData) Then Raise New cURLException(Me)
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
		    Raise New cURLException(Me)
		  End If
		  
		  Me.ClearFormData
		  Dim data As String = Join(FormData, "&")
		  If Not Me.SetOption(libcURL.Opts.POSTFIELDSIZE, data.LenB) Then Raise New cURLException(Me)
		  If Not Me.SetOption(libcURL.Opts.COPYPOSTFIELDS, data) Then Raise New cURLException(Me)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(OptionNumber As Integer, NewValue As Variant) As Boolean
		  ' SetOption is the primary interface to the easy_handle. Call this method with a curl option number
		  ' and a value that is acceptable for that option. SetOption does not check that a value is valid for
		  ' a particular option (except Nil,) however it will raise an exception if an unsupported type is passed.
		  
		  ' NewValue may be a Boolean, Integer, Ptr, String, MemoryBlock, FolderItem, libcURL.MultipartForm,
		  ' libcURL.ListPtr, libcuRL.HTTPAuthMethods; or, a Delegate matching cURLIOCallback, cURLCloseCallback,
		  ' cURLDebugCallback, cURLOpenCallback, cURLProgressCallback, or cURLInitRequestCallback. Passing Nil
		  ' will raise an exception unless the option explicitly accepts NULL.
		  
		  ' If the option was set then this method returns True. If it returns False then the option was not set
		  ' and the curl error number is stored in EasyHandle.LastError.
		  
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_setopt.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.SetOption
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts
		  
		  Dim ValueType As Integer = VarType(NewValue)
		  Select Case ValueType
		    
		  Case Variant.TypeNil ' Sometimes Nil is an error; sometimes not
		    ' Only some option numbers may accept NULL. Refer to the curl documentation on the individual option numbers for details.
		    Dim opt As libcURL.Opts.OptionInfo = OptionNumber
		    If opt.IsNullable Then
		      If mOptions.HasKey(OptionNumber) Then mOptions.Remove(OptionNumber)
		      Return Me.SetOptionPtr(OptionNumber, Nil)
		    Else
		      ' for all other option numbers reject NULL values.
		      Dim err As New NilObjectException
		      err.Message = "cURL option " + opt.LibraryAlias + "(0x" + Hex(OptionNumber) + ") may not be set to null."
		      Raise err
		    End If
		    
		  Case Variant.TypeBoolean
		    If NewValue.BooleanValue Then
		      Return Me.SetOption(OptionNumber, 1)
		    Else
		      Return Me.SetOption(OptionNumber, 0)
		    End If
		    
		  Case Variant.TypePtr, Variant.TypeInteger
		    mOptions.Value(OptionNumber) = NewValue
		    Return Me.SetOptionPtr(OptionNumber, NewValue.PtrValue)
		    
		    #If Target64Bit Then
		  Case Variant.TypeInt64
		    mOptions.Value(OptionNumber) = NewValue
		    Return Me.SetOptionPtr(OptionNumber, NewValue.PtrValue)
		    #Else
		  Case Variant.TypeLong
		    mLastError= curl_easy_setopt_long(mHandle, OptionNumber, NewValue)
		    If mLastError = 0 Then 
		      mOptions.Value(OptionNumber) = NewValue
		      Return True
		    Else
		      Return False
		    End If
		    #EndIf
		    
		  Case Variant.TypeString
		    mOptions.Value(OptionNumber) = NewValue
		    Dim mb As MemoryBlock = NewValue.CStringValue + Chr(0) ' make doubleplus sure it's null terminated
		    Return Me.SetOptionPtr(OptionNumber, mb)
		    
		  Case Variant.TypeStructure
		    ' assume it's a curl_blob structure
		    Dim struct As curl_blob = NewValue
		    mLastError= curl_easy_setopt_blob(mHandle, OptionNumber, struct)
		    If mLastError = 0 Then
		      mOptions.Value(OptionNumber) = struct.Data
		      Return True
		    Else
		      Return False
		    End If
		    
		    
		  Case Variant.TypeObject
		    ' To add support for a custom object type, add a block to this Select statement
		    Select Case NewValue
		    Case IsA MemoryBlock
		      mOptions.Value(OptionNumber) = NewValue
		      Return Me.SetOptionPtr(OptionNumber, NewValue.PtrValue)
		      
		    Case IsA FolderItem
		      mOptions.Value(OptionNumber) = NewValue
		      Return Me.SetOption(OptionNumber, FolderItem(NewValue).AbsolutePath_)
		      
		    Case IsA Dictionary ' assume a multipart form
		      Dim form As Dictionary = NewValue
		      mForm = form
		      Return Me.SetOption(OptionNumber, mForm)
		      
		    Case IsA libcURL.HTTPAuthMethods
		      Dim auth As HTTPAuthMethods = NewValue
		      Return Me.SetOption(OptionNumber, auth.Mask)
		      
		    Case IsA libcURL.cURLHandle
		      If NewValue IsA URLParser Then Return SetOption(OptionNumber, URLParser(NewValue).StringValue)
		      Dim cURL As libcURL.cURLHandle = NewValue
		      If Not Me.SetOption(OptionNumber, cURL.Handle) Then Return False
		      mOptions.Value(OptionNumber) = New WeakRef(cURL)
		      Return True
		      
		    Case IsA cURLProgressCallback
		      mOptions.Value(OptionNumber) = NewValue
		      Dim p As cURLProgressCallback = NewValue
		      Return Me.SetOptionPtr(OptionNumber, p)
		      
		    Case IsA cURLIOCallback
		      mOptions.Value(OptionNumber) = NewValue
		      Dim p As cURLIOCallback = NewValue
		      Return Me.SetOptionPtr(OptionNumber, p)
		      
		    Case IsA cURLDebugCallback
		      mOptions.Value(OptionNumber) = NewValue
		      Dim p As cURLDebugCallback = NewValue
		      Return Me.SetOptionPtr(OptionNumber, p)
		      
		    Case IsA cURLSeekCallback
		      mOptions.Value(OptionNumber) = NewValue
		      Dim p As cURLSeekCallback = NewValue
		      Return Me.SetOptionPtr(OptionNumber, p)
		      
		    Case IsA cURLInitRequestCallback
		      mOptions.Value(OptionNumber) = NewValue
		      Dim p As cURLInitRequestCallback = NewValue
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

	#tag Method, Flags = &h21
		Private Shared Function WriteCallback(char As Ptr, size As Integer, nmemb As Integer, UserData As Integer) As Integer
		  ' This method is invoked by libcURL. DO NOT CALL THIS METHOD
		  // Called when data is available
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value IsA EasyHandle Then
		    Return EasyHandle(curl.Value).curlWrite(char, size, nmemb)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		End Function
	#tag EndMethod


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
		Event HeaderReceived(HeaderLine As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Progress(dlTotal As Int64, dlNow As Int64, ulTotal As Int64, ulNow As Int64) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RequestInitiated(RemoteIP As String, LocalIP As String, RemotePort As Integer, LocalPort As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SeekStream(Offset As Integer, Origin As Integer) As Boolean
	#tag EndHook


	#tag Note, Name = Using this class
		
		  ##################################################################################################
		  # NOTE: THIS CLASS IS NOT ACTUALLY THE EASY WAY TO USE THIS PROJECT. "Easy" is just what libcURL #
		  # calls it for historical reasons. The easy way to use this project is the cURLClient class.     #
		  ##################################################################################################
		
		This class provides low level access to the curl_easy API. It is strongly recommended that you
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
			  return mBufferSize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set preferred receive buffer size (in bytes). The main point of this would be that the DataAvailable event
			  ' gets called more often and with smaller chunks. Secondly, for some protocols, there's a benefit of having
			  ' a larger buffer for performance. This is just treated as a request, not an order. You cannot be guaranteed
			  ' to actually get the given size.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/CURLOPT_BUFFERSIZE.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.BufferSize
			  
			  If value < CURL_MIN_READ_SIZE Or value > CURL_MAX_READ_SIZE Then Raise New OutOfBoundsException
			  If Not Me.SetOption(libcURL.Opts.BUFFERSIZE, value) Then Raise New cURLException(Me)
			  mBufferSize = value
			End Set
		#tag EndSetter
		BufferSize As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mBufferSizeUpload
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set preferred send buffer size (in bytes).
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/CURLOPT_UPLOAD_BUFFERSIZE.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.BufferSizeUpload
			  
			  If Not libcURL.Version.IsAtLeast(7, 62, 0) Then
			    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
			    Return
			  End If
			  
			  If value < CURL_MIN_WRITE_SIZE Or value > CURL_MAX_WRITE_SIZE Then Raise New OutOfBoundsException
			  If Not Me.SetOption(libcURL.Opts.UPLOAD_BUFFERSIZE , value) Then Raise New cURLException(Me)
			  mBufferSizeUpload = value
			End Set
		#tag EndSetter
		BufferSizeUpload As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the memory block containing one or more certificate authorities libcURL will trust to
			  ' verify the peer with. If no memoryblock is specified (default) then returns Nil.
			  ' This feature was added in libcurl 7.77.0 and might not be available from all supported
			  ' TLS backends. If set then this property overrides CA_ListFile.
			  
			  return mCA_List
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the memoryblock containing one or more certificate authorities libcURL should trust
			  ' to verify the peer with. Set this to DEFAULT_CA_INFO_PEM to use the default CA list for
			  ' Mozilla products. Set this to Nil to unset the current list. This feature was added in libcurl
			  ' 7.77.0 and might not be available from all supported TLS backends.If set then this property
			  ' overrides CA_ListFile. EasyHandle.Secure must be set to True to enable certificate verification.
			  '
			  ' See:
			  ' https://curl.se/libcurl/c/CURLOPT_CAINFO_BLOB.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.CA_List
			  
			  If Not libcURL.Version.IsAtLeast(7, 77, 0) Then
			    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
			    Raise New cURLException(Me)
			  End If
			  
			  Select Case True
			  Case value = Nil
			    If Not Me.SetOption(libcURL.Opts.CAINFO_BLOB, Nil) Then Raise New cURLException(Me)
			    mCA_List = Nil
			    
			  Else
			    Dim blob As curl_blob
			    blob.Data = value
			    blob.Length = value.Size
			    blob.Flags = CURL_BLOB_NOCOPY
			    If Not Me.SetOption(libcURL.Opts.CAINFO_BLOB, blob) Then Raise New cURLException(Me)
			    mCA_List = value
			    
			  End Select
			End Set
		#tag EndSetter
		CA_List As MemoryBlock
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
			    
			  Case Not value.Exists
			    mLastError = libcURL.Errors.INVALID_LOCAL_FILE
			    Return
			    
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
			  If mCookieEngine = Nil Then mCookieEngine = New CookieEngineCreator(Me)
			  return mCookieEngine
			End Get
		#tag EndGetter
		CookieEngine As libcURL.CookieEngine
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
			  If Not Me.SetOption(libcURL.Opts.POSTREDIR, mask) Then Raise New cURLException(Me)
			  mHTTPPreserveMethod = value
			End Set
		#tag EndSetter
		HTTPPreserveMethod As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the version of HTTP to be used. Returns HTTPVersion.HTTP1_0, HTTPVersion.HTTP1_1, HTTPVersion.HTTP2, or HTTPVersion.None
			  return mHTTPVersion
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the version of HTTP to be used. Pass a member of the HTTPVersion enumeration.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_HTTP_VERSION.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.HTTPVersion
			  
			  If (value = libcURL.HTTPVersion.HTTP2 And Not libcURL.Version.IsAtLeast(7, 33, 0)) _
			    Or (value = libcURL.HTTPVersion.HTTP2TLS And Not libcURL.Version.IsAtLeast(7, 47, 0)) _
			    Or (value = libcURL.HTTPVersion.HTTP2PriorKnowledge And Not libcURL.Version.IsAtLeast(7, 49, 0)) Then
			    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
			    Raise New cURLException(Me)
			  End If
			  
			  If Not Me.SetOption(libcURL.Opts.HTTPVERSION, value) Then Raise New cURLException(Me)
			  mHTTPVersion = value
			End Set
		#tag EndSetter
		HTTPVersion As libcURL.HTTPVersion
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected Shared Instances As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the version of IP to be used. Returns IPVersion.V4, IPVersion.V6, or IPVersion.Whatever
			  
			  return mIPVersion
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the IP version to be used. Pass a member of the libcURL.IPVersion enum
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/CURLOPT_IPRESOLVE.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.IPVersion
			  
			  If Not Me.SetOption(libcURL.Opts.IPRESOLVE, value) Then Raise New cURLException(Me)
			  mIPVersion = value
			End Set
		#tag EndSetter
		IPVersion As libcURL.IPVersion
	#tag EndComputedProperty

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
			  If Not Me.SetOption(libcURL.Opts.MAXREDIRS, value) Then Raise New cURLException(Me)
			  mMaxRedirects = value
			End Set
		#tag EndSetter
		MaxRedirects As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBufferSize As Integer = CURL_DEFAULT_READ_SIZE
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBufferSizeUpload As Integer = CURL_DEFAULT_WRITE_SIZE
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCA_List As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCA_ListFile As FolderItem
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
		Private mHTTPVersion As libcURL.HTTPVersion
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIPVersion As libcURL.IPVersion
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxRedirects As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMIMEMessage As libcURL.MIMEMessage
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mOptions As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPipeWait As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProxyEngine As libcURL.ProxyEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResponseHeaderEngine As libcURL.ResponseHeaderEngine
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
		#tag Getter
			Get
			  return mPipeWait
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets whether libcURL will prefer to wait for a pipelined connection.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/CURLOPT_PIPEWAIT.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.PipeWait
			  
			  If Not libcURL.Version.IsAtLeast(7, 43, 0) Then
			    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
			    Return
			  End If
			  
			  If Not Me.SetOption(libcURL.Opts.PIPEWAIT, value) Then Raise New cURLException(Me)
			  mPipeWait = value
			End Set
		#tag EndSetter
		PipeWait As Boolean
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
			  ' Returns a reference to the ProxyEngine for this instance of EasyHandle.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.ProxyEngine
			  
			  If mProxyEngine = Nil Then mProxyEngine = New ProxyEngineCreator(Me)
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
			  ' Returns a reference to the ResponseHeaderEngine for this instance of EasyHandle.
			  ' This feature is only available in libcURL 7.84.0 and newer.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.ResponseHeaderEngine
			  
			  If Not libcURL.Version.IsAtLeast(7, 84, 0) Then
			    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
			    Return Nil
			  End If
			  If mResponseHeaderEngine = Nil Then mResponseHeaderEngine = New ResponseHeaderEngineCreator(Me)
			  return mResponseHeaderEngine
			End Get
		#tag EndGetter
		ResponseHeaderEngine As libcURL.ResponseHeaderEngine
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
			  If value = libcURL.SSLVersion.Max_Default Then
			    If libcURL.Version.IsAtLeast(7, 61, 0) Then
			      value = libcURL.SSLVersion.Max_TLSv1_2
			    Else
			      value = libcURL.SSLVersion.Max_TLSv1_3
			    End If
			  End If
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
			  
			  If Not Me.SetOption(libcURL.Opts.UPLOAD, value) Then Raise New cURLException(Me)
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

	#tag Constant, Name = CURLSSLOPT_ALLOW_BEAST, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLSSLOPT_AUTO_CLIENT_CERT, Type = Double, Dynamic = False, Default = \"32", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLSSLOPT_NO_PARTIALCHAIN, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLSSLOPT_NO_REVOKE, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLSSLOPT_REVOKE_BEST_EFFORT, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURL_DEFAULT_READ_SIZE, Type = Double, Dynamic = False, Default = \"16384", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURL_DEFAULT_WRITE_SIZE, Type = Double, Dynamic = False, Default = \"65536", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURL_MAX_READ_SIZE, Type = Double, Dynamic = False, Default = \"524288", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURL_MAX_WRITE_SIZE, Type = Double, Dynamic = False, Default = \"2097152", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURL_MIN_READ_SIZE, Type = Double, Dynamic = False, Default = \"1024", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURL_MIN_WRITE_SIZE, Type = Double, Dynamic = False, Default = \"16384", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURL_SOCKET_BAD, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_SOCKOPT_ERROR, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_SOCKOPT_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LOG_DEBUG, Type = Boolean, Dynamic = False, Default = \"DebugBuild", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="AutoDisconnect"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoReferer"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BufferSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BufferSizeUpload"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConnectionTimeout"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FailOnServerError"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FollowRedirects"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPCompression"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPPreserveMethod"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LocalPort"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxRedirects"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
			Name="Password"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PipeWait"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemoteIP"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Secure"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="TimeOut"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
			Name="UploadMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="URL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseErrorBuffer"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseProgressEvent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UserAgent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Username"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Verbose"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConnectionType"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="libcURL.ConnectionType"
			EditorType="Enum"
			#tag EnumValues
				"0 - NoSSL"
				"1 - AttemptSSL"
				"2 - SSLControlConnectionOnly"
				"3 - SSLForceAll"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="CWDMethod"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="libcURL.CWDMethod"
			EditorType="Enum"
			#tag EnumValues
				"1 - Multi"
				"2 - None"
				"3 - Single"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="libcURL.HTTPVersion"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - HTTP1_0"
				"2 - HTTP1_1"
				"3 - HTTP2"
				"4 - HTTP2TLS"
				"5 - HTTP2PriorKnowledge"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="IPVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="libcURL.IPVersion"
			EditorType="Enum"
			#tag EnumValues
				"0 - Whatever"
				"1 - V4"
				"2 - V6"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="SSLVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="libcURL.SSLVersion"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - TLSv1"
				"2 - SSLv2"
				"3 - SSLv3"
				"4 - TLSv1_0"
				"5 - TLSv1_1"
				"6 - TLSv1_2"
				"7 - TLSv1_3"
				"65536 - Max_TLSv1_0"
				"327680 - Max_TLSv1_1"
				"393216 - Max_TLSv1_2"
				"458752 - Max_TLSv1_3"
				"458753 - Max_Default"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
