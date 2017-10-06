#tag Class
Protected Class cURLManager
	#tag Method, Flags = &h0
		Sub Abort()
		  ' Aborts the current transfer by automatically returning `True` from the Progress event the
		  ' next time it is raised. If no transfer is in progress or if the Progress event has been disabled
		  ' then this method has no effect.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.Abort
		  
		  If Not Me.IsTransferComplete Then mAbort = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  ' Explicitly closes all libcURL handles associated with the cURLManager instance.
		  ' Automatically called by the Destructor.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.Close
		  
		  If mMultiItem <> Nil Then mMultiItem.Close()
		  If mEasyItem <> Nil Then
		    #pragma BreakOnExceptions Off
		    Try
		      If mRemoveDebugHandler Then RemoveHandler mEasyItem.DebugMessage, WeakAddressOf _DebugMessageHandler
		    Catch
		    Finally
		      mRemoveDebugHandler = False
		    End Try
		    Try
		      If mRemoveHeaderHandler Then RemoveHandler mEasyItem.HeaderReceived, WeakAddressOf _HeaderReceivedHandler
		    Catch
		    Finally
		      mRemoveHeaderHandler = False
		    End Try
		    Try
		      If mRemoveProgressHandler Then RemoveHandler mEasyItem.Progress, WeakAddressOf _ProgressHandler
		    Catch
		    Finally
		      mRemoveProgressHandler = False
		    End Try
		    #pragma BreakOnExceptions On
		  End If
		  
		  mEasyItem = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  ' Creates a new instance of cURLManager with default options
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.Constructor
		  
		  mMultiItem = New libcURL.MultiHandle
		  AddHandler mMultiItem.TransferComplete, WeakAddressOf _TransferCompleteHandler
		  Me.Reset()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( deprecated )  Sub Constructor(CopyOpts As libcURL.cURLManager)
		  ' This method is deprecated. To duplicate an instance of cURLManager, duplicate its EasyItem
		  ' and pass the duplicate to cURLManager.Constructor(EasyHandle) instead.
		  '
		  ' Creates a new instance of cURLManager by cloning the passed cURLManager
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.Constructor
		  
		  Select Case CopyOpts.EasyItem
		  Case IsA libcURL.Protocols.FTPWildCard
		    mEasyItem = New libcURL.Protocols.FTPWildCard(CopyOpts.EasyItem)
		  Else
		    mEasyItem = New libcURL.EasyHandle(CopyOpts.EasyItem)
		  End Select
		  Me.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ExistingEasy As libcURL.EasyHandle)
		  ' Creates a new instance of cURLManager by taking ownership of the passed EasyHandle
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.Constructor
		  
		  mEasyItem = ExistingEasy
		  Me.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Cookies() As libcURL.CookieEngine
		  ' Returns a reference to the CookieEngine instance
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.Cookies
		  
		  Return mEasyItem.CookieEngine
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Close()
		  mMultiItem = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCookie(Name As String, Domain As String) As String
		  ' Gets the value of the first cookie named 'Name' set for the host matching 'Domain', or the empty
		  ' string ("") if no cookie is found. For more advanced lookups refer to the CookieEngine class.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.GetCookie
		  
		  Dim index As Integer = mEasyItem.CookieEngine.Lookup(Name, Domain)
		  If index > -1 Then Return mEasyItem.CookieEngine.Value(index)
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
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.GetDownloadedData
		  
		  If mDownloadMB <> Nil Then Return mDownloadMB
		  Dim data As New MemoryBlock(0)
		  If mEasyItem.DownloadStream = Nil Or Not mEasyItem.DownloadStream IsA BinaryStream Then Return data
		  Dim bs As BinaryStream = BinaryStream(mEasyItem.DownloadStream)
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
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.GetInfo
		  
		  If mEasyItem <> Nil Then Return mEasyItem.GetInfo(InfoType)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResponseHeaders() As InternetHeaders
		  ' Returns an InternetHeaders object containing all protocol headers received from the server
		  ' during the most recent transfer. If no headers were received, returns Nil.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.GetResponseHeaders
		  
		  Return mHeaders
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStatusCode() As Integer
		  ' Returns a protocol-specific status code for the most recent transfer. If the transfer
		  ' involved several status codes (FTP anything, HTTP redirects, etc.) then only the most
		  ' recent code is returned.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.GetStatusCode
		  
		  Return Me.GetInfo(libcURL.Info.RESPONSE_CODE).Int32Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTransferComplete() As Boolean
		  ' After a transfer is initiated this method will return False until the
		  ' transfer completes (successfully or not.)
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.IsTransferComplete
		  
		  Return mIsTransferComplete
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As Integer
		  ' Gets the most recent cURL easy error code for the transfer.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.LastError
		  
		  Return mEasyItem.LastError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Perform(URL As String, ReadFrom As Readable, WriteTo As Writeable)
		  ' Performs the transfer on the main thread/event loop.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.Perform
		  
		  QueueTransfer(URL, ReadFrom, WriteTo)
		  mMultiItem.Perform()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Perform(URL As String, ReadFrom As Readable, WriteTo As Writeable) As Boolean
		  ' Perform the transfer on the calling thread.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.Perform
		  
		  QueueTransfer(URL, ReadFrom, WriteTo)
		  Do Until Not mMultiItem.PerformOnce()
		    If Yield And Rnd > 0.99 Then
		      #If TargetHasGUI Then
		        App.SleepCurrentThread(50)
		      #Else
		        App.YieldToNextThread
		      #EndIf
		    End If
		  Loop
		  
		  Return mEasyItem.LastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Proxy() As libcURL.ProxyEngine
		  ' Returns a reference to a ProxyEngine instance
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.Proxy
		  
		  Return mEasyItem.ProxyEngine
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub QueueTransfer(URL As String, ReadFrom As Readable, WriteTo As Writeable)
		  If Not mMultiItem.AddItem(mEasyItem) Then Raise New libcURL.cURLException(mMultiItem)
		  
		  mIsTransferComplete = False
		  mAbort = False
		  If URL.Trim <> "" Then mEasyItem.URL = URL
		  mHeaders = Nil
		  If WriteTo = Nil Then
		    mDownloadMB = New MemoryBlock(0)
		    WriteTo = New BinaryStream(mDownloadMB)
		  Else
		    mDownloadMB = Nil
		  End If
		  If ReadFrom = Nil And mUploadMB <> Nil Then ReadFrom = New BinaryStream(mUploadMB)
		  mEasyItem.DownloadStream = WriteTo
		  mEasyItem.UploadStream = ReadFrom
		  If mEasyItem.UseErrorBuffer Then mEasyItem.UseErrorBuffer = True ' clears the previous buffer, if any
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  If mEasyItem = Nil Then mEasyItem = New libcURL.EasyHandle Else mEasyItem.Reset
		  Me.EasyItem = mEasyItem
		  mEasyItem.UserAgent = libcURL.Version.UserAgent
		  mEasyItem.Secure = True
		  mEasyItem.CA_ListFile = libcURL.Default_CA_File
		  mEasyItem.FailOnServerError = True
		  mEasyItem.FollowRedirects = True
		  mEasyItem.AutoReferer = True
		  mEasyItem.HTTPCompression = libcURL.Version.LibZ.IsAvailable
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetCookie(Name As String, Value As String, Domain As String, Expires As Date = Nil, Path As String = "", HTTPOnly As Boolean = False) As Boolean
		  ' Sets or updates a cookie. The cookie engine must be enabled.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.SetCookie
		  
		  Return mEasyItem.CookieEngine.SetCookie(Name, Value, Domain, Expires, Path, HTTPOnly)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(OptionNumber As Integer, NewValue As Variant) As Boolean
		  ' Calls SetOption on the EasyHandle. Refer to the EasyHandle.SetOption documentation for details.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.SetOption
		  
		  If mEasyItem <> Nil Then Return mEasyItem.SetOption(OptionNumber, NewValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetRequestHeader(Name As String, Value As String) As Boolean
		  ' Subsequent calls to this method will append the headers to the previously set headers. Headers will persist from transfer
		  ' to transfer. Pass an empty value to clear the named header. Pass an empty name to clear all headers.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.SetRequestHeader
		  
		  mRequestHeaders = mEasyItem.SetRequestHeader(mRequestHeaders, Name, Value)
		  Return (mRequestHeaders <> Nil Or Name = "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetRequestMethod(RequestMethod As String) As Boolean
		  ' Overrides the request method used by libcurl. The behavior of this feature depends on which protocol
		  ' is being used, and not all protocols are supported. Pass the empty string to clear custom methods.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_CUSTOMREQUEST.html#DESCRIPTION
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.SetRequestMethod
		  
		  If RequestMethod.Trim <> "" Then
		    Return mEasyItem.SetOption(libcURL.Opts.CUSTOMREQUEST, RequestMethod)
		  Else
		    Return mEasyItem.SetOption(libcURL.Opts.CUSTOMREQUEST, Nil)
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
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.SetUploadData
		  
		  mUploadMB = UploadData
		  mEasyItem.UploadMode = (mUploadMB <> Nil)
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
		  If mDownloadMB <> Nil And mEasyItem.DownloadStream <> Nil And mEasyItem.DownloadStream IsA BinaryStream Then
		    BinaryStream(mEasyItem.DownloadStream).Close
		  End If
		  
		  mLastTransferError = Item.LastError
		  mIsTransferComplete = True
		  If Cookies.Enabled Then Cookies.Invalidate
		  
		  If mLastTransferError <> 0 Then
		    RaiseEvent Error(mLastTransferError)
		  Else
		    RaiseEvent TransferComplete(Me.GetInfo(libcURL.Info.SIZE_DOWNLOAD).Int32Value, Me.GetInfo(libcURL.Info.SIZE_UPLOAD).Int32Value)
		  End If
		  
		  mEasyItem.ClearFormData()
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
			  return mEasyItem
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Gets and sets the EasyHandle instance which will be/has been used to conduct transfers.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.EasyItem
			  
			  Me.Close()
			  Try
			    AddHandler value.DebugMessage, WeakAddressOf _DebugMessageHandler
			    mRemoveDebugHandler = True
			  Catch
			    mRemoveDebugHandler = False
			  End Try
			  Try
			    AddHandler value.HeaderReceived, WeakAddressOf _HeaderReceivedHandler
			    mRemoveHeaderHandler = True
			  Catch
			    mRemoveHeaderHandler = False
			  End Try
			  Try
			    AddHandler value.Progress, WeakAddressOf _ProgressHandler
			    mRemoveProgressHandler = True
			  Catch
			    mRemoveProgressHandler = False
			  End Try
			  mEasyItem = value
			End Set
		#tag EndSetter
		EasyItem As libcURL.EasyHandle
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the version of HTTP to be used. Returns HTTP_VERSION_1_0, HTTP_VERSION_1_1, HTTP_VERSION_2_0, or HTTP_VERSION_NONE
			  return EasyItem.HTTPVersion
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the version of HTTP to be used.
			  
			  EasyItem.HTTPVersion = value
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
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLManager.IsSSLCertOK
			  
			  Dim v As Integer = Me.GetInfo(libcURL.Info.SSL_VERIFYRESULT)
			  Return v = 0
			End Get
		#tag EndGetter
		IsSSLCertOK As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAbort As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadMB As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEasyItem As libcURL.EasyHandle
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHeaders As InternetHeaders
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsTransferComplete As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastTransferError As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMultiItem As libcURL.MultiHandle
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
		Private mRequestHeaders As libcURL.ListPtr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUploadMB As MemoryBlock
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return EasyItem.Password
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  EasyItem.Password = value
			End Set
		#tag EndSetter
		Password As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return EasyItem.Username
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  EasyItem.Username = value
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
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsSSLCertOK"
			Group="Behavior"
			Type="Boolean"
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
			Name="Password"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
		#tag ViewProperty
			Name="Username"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Yield"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
