#tag Class
Protected Class cURLSession
	#tag Method, Flags = &h0
		Sub Abort()
		  ' Aborts the current transfer by automatically returning True from the Progress event the
		  ' next time it is raised. If no transfer is in progress or if the Progress event has been disabled
		  ' then this method has no effect.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Abort
		  
		  If Not Me.IsTransferComplete Then mAbort = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  ' Explicitly frees the EasyHandle associated with the cURLSession instance.
		  ' Automatically called by the Destructor.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Close
		  
		  If mMultiHandle <> Nil Then mMultiHandle.Close()
		  If mEasyHandle <> Nil Then
		    #pragma BreakOnExceptions Off
		    Try
		      If mRemoveDebugHandler Then RemoveHandler mEasyHandle.DebugMessage, WeakAddressOf _DebugMessageHandler
		    Catch
		    Finally
		      mRemoveDebugHandler = False
		    End Try
		    Try
		      If mRemoveHeaderHandler Then RemoveHandler mEasyHandle.HeaderReceived, WeakAddressOf _HeaderReceivedHandler
		    Catch
		    Finally
		      mRemoveHeaderHandler = False
		    End Try
		    Try
		      If mRemoveProgressHandler Then RemoveHandler mEasyHandle.Progress, WeakAddressOf _ProgressHandler
		    Catch
		    Finally
		      mRemoveProgressHandler = False
		    End Try
		    #pragma BreakOnExceptions On
		  End If
		  
		  mEasyHandle = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  ' Creates a new instance of cURLSession with default options
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Constructor
		  
		  mMultiHandle = New libcURL.MultiHandle
		  AddHandler mMultiHandle.TransferComplete, WeakAddressOf _TransferCompleteHandler
		  Me.Reset()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ExistingEasy As libcURL.EasyHandle)
		  ' Creates a new instance of cURLSession by taking ownership of the passed EasyHandle
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Constructor
		  
		  mEasyHandle = ExistingEasy
		  Me.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Close()
		  mMultiHandle = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DoPerform() As Boolean
		  Do Until Not mMultiHandle.PerformOnce()
		    If Yield And Rnd > 0.99 Then
		      #If RBVersion < 2020 Then
		        App.YieldToNextThread()
		      #Else
		        Thread.YieldToNext()
		      #EndIf
		    End If
		  Loop
		  
		  Return mEasyHandle.LastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCookie(Name As String, Domain As String) As String
		  ' Gets the value of the first cookie named 'Name' set for the host matching 'Domain', or the empty
		  ' string ("") if no cookie is found. For more advanced lookups refer to the CookieEngine class.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.GetCookie
		  
		  Dim index As Integer = mEasyHandle.CookieEngine.Lookup(Name, Domain)
		  If index > -1 Then Return mEasyHandle.CookieEngine.Value(index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDownloadedData() As MemoryBlock
		  ' Returns a MemoryBlock containing all data which was downloaded during the most recent transfer.
		  ' If you passed a Writeable object to any of the transfer methods (get, post, put, perform) then this
		  ' method will return an empty MemoryBlock (not Nil) as the data will have been downloaded into
		  ' the Writeable object directly.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.GetDownloadedData
		  
		  If mDownloadMB <> Nil Then Return mDownloadMB
		  Dim data As New MemoryBlock(0)
		  If mEasyHandle.DownloadStream = Nil Or Not mEasyHandle.DownloadStream IsA BinaryStream Then Return data
		  Dim bs As BinaryStream = BinaryStream(mEasyHandle.DownloadStream)
		  bs.Position = 0
		  Dim out As New BinaryStream(data)
		  While Not bs.EOF
		    out.Write(bs.Read(1024))
		  Wend
		  out.Close
		  bs.Position = bs.Length
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInfo(InfoType As Integer) As Variant
		  ' Calls GetInfo on the EasyHandle. Refer to the EasyHandle.GetInfo documentation for details.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.GetInfo
		  
		  If mEasyHandle <> Nil Then Return mEasyHandle.GetInfo(InfoType)
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
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.GetOption
		  
		  Return EasyHandle.GetOption(OptionNumber, DefaultValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( deprecated = "libcURL.cURLSession.ResponseHeaders" )  Function GetResponseHeaders() As InternetHeaders
		  ' Returns an InternetHeaders object containing all protocol headers received from the server
		  ' during the most recent transfer. If no headers were received, returns Nil.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.GetResponseHeaders
		  
		  Return mHeaders
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( deprecated = "libcurl.cURLSession.LastStatusCode" )  Function GetStatusCode() As Integer
		  ' This method has been deprecated in favor of the LastStatusCode property.
		  '
		  ' Returns a protocol-specific status code for the most recent transfer. If the transfer
		  ' involved several status codes (FTP anything, HTTP redirects, etc.) then only the most
		  ' recent code is returned.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.GetStatusCode
		  
		  Return Me.GetInfo(libcURL.Info.RESPONSE_CODE).Int32Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsOptionSet(OptionNumber As Integer) As Boolean
		  ' This method returns True if the OptionNumber has already been set on the EasyHandle. This method doesn't
		  ' know about option values which were set using the SetOptionPtr method.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.IsOptionSet
		  
		  Dim opt As libcURL.Opts.OptionInfo = OptionNumber
		  Return opt.IsSet(EasyHandle)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pause()
		  ' Pauses the current transfer if one exists and is not paused. This method pauses both
		  ' upload and download operations; to pause them separately refer to EasyHandle.Pause.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Pause
		  
		  Call EasyHandle.Pause()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Perform(URL As libcURL.URLParser, ReadFrom As Readable, WriteTo As Writeable)
		  ' Performs the transfer on the main thread/event loop.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Perform
		  
		  QueueTransfer(URL, ReadFrom, WriteTo)
		  mMultiHandle.Perform()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Perform(URL As libcURL.URLParser, ReadFrom As Readable, WriteTo As Writeable) As Boolean
		  ' Perform the transfer on the calling thread.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Perform
		  
		  QueueTransfer(URL, ReadFrom, WriteTo)
		  Return DoPerform()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Perform(URL As String, ReadFrom As Readable, WriteTo As Writeable)
		  ' Performs the transfer on the main thread/event loop.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Perform
		  
		  QueueTransfer(URL, ReadFrom, WriteTo)
		  mMultiHandle.Perform()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Perform(URL As String, ReadFrom As Readable, WriteTo As Writeable) As Boolean
		  ' Perform the transfer on the calling thread.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Perform
		  
		  QueueTransfer(URL, ReadFrom, WriteTo)
		  Return DoPerform()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub QueueStreams(ReadFrom As Readable, WriteTo As Writeable)
		  If Not mMultiHandle.AddTransfer(mEasyHandle) Then
		    ' Most likely another transfer is already in progress.
		    Raise New cURLException(mMultiHandle)
		  End If
		  
		  mIsTransferComplete = False
		  mAbort = False
		  mHeaders = Nil
		  If WriteTo = Nil Then
		    mDownloadMB = New MemoryBlock(0)
		    WriteTo = New BinaryStream(mDownloadMB)
		  Else
		    mDownloadMB = Nil
		  End If
		  If ReadFrom = Nil And mUploadMB <> Nil Then ReadFrom = New BinaryStream(mUploadMB)
		  mEasyHandle.DownloadStream = WriteTo
		  mEasyHandle.UploadStream = ReadFrom
		  If mEasyHandle.UseErrorBuffer Then mEasyHandle.UseErrorBuffer = True ' clears the previous buffer, if any
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub QueueTransfer(URL As libcURL.URLParser, ReadFrom As Readable, WriteTo As Writeable)
		  QueueStreams(ReadFrom, WriteTo)
		  If URL <> Nil And Not mEasyHandle.SetOption(libcURL.Opts.URL, URL) Then Raise New cURLException(mEasyHandle)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub QueueTransfer(URL As String, ReadFrom As Readable, WriteTo As Writeable)
		  QueueStreams(ReadFrom, WriteTo)
		  If URL.Trim <> "" Then mEasyHandle.URL = URL
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  ' Resets the cURLSession to a pristine state. All options that were previously set will be cleared and returned
		  ' to their default values. Existing connections, the Session ID cache, the DNS cache, cookies, and shares are
		  ' not affected.
		  '
		  ' It is not necessary to call this method between transfers.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Reset
		  
		  If mEasyHandle = Nil Then mEasyHandle = New libcURL.EasyHandle Else mEasyHandle.Reset
		  Me.EasyHandle = mEasyHandle
		  mEasyHandle.UserAgent = libcURL.Version.UserAgent
		  mEasyHandle.Secure = True
		  mEasyHandle.CA_ListFile = libcURL.Default_CA_File
		  mEasyHandle.FailOnServerError = True
		  mEasyHandle.FollowRedirects = True
		  mEasyHandle.AutoReferer = True
		  mEasyHandle.HTTPCompression = libcURL.Version.LibZ.IsAvailable
		  mEasyHandle.UseErrorBuffer = True
		  Me.Yield = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Resume()
		  ' Resumes the current transfer if one exists and is paused. This method resumes both
		  ' upload and download operations; to resume them separately refer to EasyHandle.Resume.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Pause
		  
		  Call EasyHandle.Resume()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetCookie(Name As String, Value As String, Domain As String, Expires As Date = Nil, Path As String = "", HTTPOnly As Boolean = False) As Boolean
		  ' Sets or updates a cookie. The cookie engine must be enabled.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.SetCookie
		  
		  Return mEasyHandle.CookieEngine.SetCookie(Name, Value, Domain, Expires, Path, HTTPOnly)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(OptionNumber As Integer, NewValue As Variant) As Boolean
		  ' Calls SetOption on the EasyHandle. Refer to the EasyHandle.SetOption documentation for details.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.SetOption
		  
		  If mEasyHandle <> Nil Then Return mEasyHandle.SetOption(OptionNumber, NewValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetRequestMethod(RequestMethod As String) As Boolean
		  ' Overrides the request method used by libcurl. The behavior of this feature depends on which protocol
		  ' is being used, and not all protocols are supported. Pass the empty string to reset.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_CUSTOMREQUEST.html#DESCRIPTION
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.SetRequestMethod
		  
		  If RequestMethod.Trim <> "" Then
		    Return mEasyHandle.SetOption(libcURL.Opts.CUSTOMREQUEST, RequestMethod)
		  Else
		    Return mEasyHandle.SetOption(libcURL.Opts.CUSTOMREQUEST, Nil)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetUploadData(UploadData As MemoryBlock)
		  ' Sets a MemoryBlock containing all data to be uploaded during the next transfer.
		  ' If you pass a Readable object to any of the transfer methods (get, post, put, perform)
		  ' then the data passed to this method will be discarded. Once the transfer completes the
		  ' MemoryBlock is discarded; it does not persist between transfers.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.SetUploadData
		  
		  mUploadMB = UploadData
		  mEasyHandle.UploadMode = (mUploadMB <> Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub _DebugMessageHandler(Sender As libcURL.EasyHandle, MessageType As libcURL.curl_infotype, data As String)
		  #pragma Unused Sender
		  RaiseEvent DebugMessage(MessageType, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub _HeaderReceivedHandler(Sender As libcURL.EasyHandle, HeaderLine As String)
		  #pragma Unused Sender
		  If mHeaders = Nil Then mHeaders = New InternetHeaders
		  If HeaderLine.Trim = "" Then Return
		  mHeaders.AppendHeader(NthField(HeaderLine, ": ", 1), NthField(HeaderLine, ": ", 2))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _ProgressHandler(Sender As libcURL.EasyHandle, dlTotal As Int64, dlnow As Int64, ultotal As Int64, ulnow As Int64) As Boolean
		  #pragma Unused Sender
		  If mAbort Then
		    mAbort = False
		    Return True
		  End If
		  Return RaiseEvent Progress(dlTotal, dlnow, ultotal, ulnow)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub _TransferCompleteHandler(Sender As libcURL.MultiHandle, Item As libcURL.EasyHandle)
		  #pragma Unused Sender
		  If mDownloadMB <> Nil And mEasyHandle.DownloadStream <> Nil And mEasyHandle.DownloadStream IsA BinaryStream Then
		    BinaryStream(mEasyHandle.DownloadStream).Close
		  End If
		  
		  mLastTransferError = Item.LastError
		  mLastErrorMessage = Item.ErrorBuffer
		  mIsTransferComplete = True
		  If Cookies.Enabled Then Cookies.Invalidate
		  
		  If mLastTransferError <> 0 Then
		    RaiseEvent Error(mLastTransferError)
		  Else
		    RaiseEvent TransferComplete(Me.GetInfo(libcURL.Info.SIZE_DOWNLOAD).Int32Value, Me.GetInfo(libcURL.Info.SIZE_UPLOAD).Int32Value)
		  End If
		  
		  mEasyHandle.ClearFormData()
		  mUploadMB = Nil
		  ErrorSetter(Item).LastError = mLastTransferError
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DebugMessage(MessageType As libcURL.curl_infotype, data As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Error(cURLCode As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Progress(dlTotal As Int64, dlNow As Int64, ulTotal As Int64, ulNow As Int64) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TransferComplete(BytesRead As Integer, BytesWritten As Integer)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a reference to the CookieEngine instance
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Cookies
			  
			  Return mEasyHandle.CookieEngine
			End Get
		#tag EndGetter
		Cookies As libcURL.CookieEngine
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mEasyHandle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Gets and sets the EasyHandle instance which will be/has been used to conduct transfers.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.EasyItem
			  
			  Me.Close()
			  Try
			    AddHandler value.DebugMessage, WeakAddressOf _DebugMessageHandler
			    mRemoveDebugHandler = True
			  Catch
			    mRemoveDebugHandler = False
			  End Try
			  Try
			    If Not libcURL.Version.IsAtLeast(7, 84, 0) Then
			      AddHandler value.HeaderReceived, WeakAddressOf _HeaderReceivedHandler
			      mRemoveHeaderHandler = True
			    End If
			  Catch
			    mRemoveHeaderHandler = False
			  End Try
			  Try
			    AddHandler value.Progress, WeakAddressOf _ProgressHandler
			    mRemoveProgressHandler = True
			  Catch
			    mRemoveProgressHandler = False
			  End Try
			  mEasyHandle = value
			End Set
		#tag EndSetter
		EasyHandle As libcURL.EasyHandle
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mEasyHandle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Me.EasyHandle = value
			End Set
		#tag EndSetter
		Attributes( deprecated = "libcURL.cURLSession.EasyHandle" ) EasyItem As libcURL.EasyHandle
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the available/allowed HTTP authentication methods.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.HTTPAuthenticationMethod
			  
			  Return EasyHandle.GetAuthMethods
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the available/allowed HTTP authentication methods.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.HTTPAuthenticationMethod
			  
			  Call EasyHandle.SetAuthMethods(value)
			  
			End Set
		#tag EndSetter
		HTTPAuthenticationMethod As libcURL.HTTPAuthMethods
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the version of HTTP to be used. Returns HTTP_VERSION_1_0, HTTP_VERSION_1_1, HTTP_VERSION_2_0, or HTTP_VERSION_NONE
			  return EasyHandle.HTTPVersion
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the version of HTTP to be used.
			  
			  EasyHandle.HTTPVersion = value
			End Set
		#tag EndSetter
		HTTPVersion As libcURL.HTTPVersion
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' When using OpenSSL or NSS, returns True if the server's SSL/TLS certificate was valid and
			  ' verified by a trusted certificate authority. If the connection did not use SSL/TLS then
			  ' this property will always be False.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/CURLINFO_SSL_VERIFYRESULT.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.IsSSLCertOK
			  
			  Dim v As Integer = Me.GetInfo(libcURL.Info.SSL_VERIFYRESULT)
			  Return v = 0
			End Get
		#tag EndGetter
		IsSSLCertOK As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' After a transfer is initiated this method will return False until the
			  ' transfer completes (successfully or not.)
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.IsTransferComplete
			  
			  Return mIsTransferComplete
			End Get
		#tag EndGetter
		IsTransferComplete As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the most recent cURL easy error code for the transfer.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.LastError
			  
			  Return mEasyHandle.LastError
			End Get
		#tag EndGetter
		LastError As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a human-friendly description of why the previous transfer failed.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.LastErrorMessage
			  
			  return mLastErrorMessage
			End Get
		#tag EndGetter
		LastErrorMessage As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a protocol-specific status code for the most recent transfer. If the transfer
			  ' involved several status codes (FTP anything, HTTP redirects, etc.) then only the most
			  ' recent code is returned.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.LastStatusCode
			  
			  Return Me.GetInfo(libcURL.Info.RESPONSE_CODE).Int32Value
			End Get
		#tag EndGetter
		LastStatusCode As Int32
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAbort As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadMB As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEasyHandle As libcURL.EasyHandle
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHeaders As InternetHeaders
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsTransferComplete As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastErrorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastTransferError As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMultiHandle As libcURL.MultiHandle
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRemoveDebugHandler As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRemoveHeaderHandler As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRemoveProgressHandler As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUploadMB As MemoryBlock
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return EasyHandle.Password
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  EasyHandle.Password = value
			End Set
		#tag EndSetter
		Password As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a reference to a ProxyEngine instance
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.Proxy
			  
			  Return mEasyHandle.ProxyEngine
			End Get
		#tag EndGetter
		Proxy As libcURL.ProxyEngine
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a reference to a RequestHeaderEngine instance
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLSession.RequestHeaders
			  
			  Return EasyHandle.RequestHeaderEngine
			End Get
		#tag EndGetter
		RequestHeaders As libcURL.RequestHeaderEngine
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a reference to the ResponseHeaderEngine for this instance of EasyHandle.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.ResponseHeaderEngine
			  
			  If Not libcURL.Version.IsAtLeast(7, 84, 0) Then
			    If mHeaders = Nil Then mHeaders = New InternetHeaders
			    Return New ResponseHeaderEngineCreator(EasyHandle, mHeaders)
			  Else
			    Return EasyHandle.ResponseHeaderEngine
			  End If
			End Get
		#tag EndGetter
		ResponseHeaders As libcURL.ResponseHeaderEngine
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return EasyHandle.Username
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  EasyHandle.Username = value
			End Set
		#tag EndSetter
		Username As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Yield As Boolean = True
	#tag EndProperty


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
			Name="IsSSLCertOK"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsTransferComplete"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastError"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
			Name="Password"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Username"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Yield"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastErrorMessage"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastStatusCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Int32"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
