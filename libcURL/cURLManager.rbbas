#tag Class
Protected Class cURLManager
	#tag Method, Flags = &h0
		Sub ClearFormData()
		  If Not mEasyItem.SetOption(libcURL.Opts.POSTFIELDSIZE, -1) Then Raise New libcURL.cURLException(mEasyItem)
		  If Not Me.SetOption(libcURL.Opts.COPYPOSTFIELDS, Nil) Then Raise New libcURL.cURLException(mEasyItem)
		  If Not Me.SetOption(libcURL.Opts.HTTPPOST, Nil) Then Raise New libcURL.cURLException(mEasyItem)
		  mForm = Nil
		  If Not Me.SetOption(libcURL.Opts.HTTPGET, True) Then Raise New libcURL.cURLException(mEasyItem)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  mMultiItem = Nil
		  mEasyItem = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mEasyItem = New libcURL.EasyHandle
		  AddHandler mEasyItem.CreateSocket, WeakAddressOf _CreateSocketHandler
		  AddHandler mEasyItem.DataAvailable, WeakAddressOf _DataAvailableHandler
		  AddHandler mEasyItem.DataNeeded, WeakAddressOf _DataNeededHandler
		  AddHandler mEasyItem.DebugMessage, WeakAddressOf _DebugMessageHandler
		  AddHandler mEasyItem.Disconnected, WeakAddressOf _DisconnectedHandler
		  AddHandler mEasyItem.HeaderReceived, WeakAddressOf _HeaderReceivedHandler
		  AddHandler mEasyItem.Progress, WeakAddressOf _ProgressHandler
		  AddHandler mEasyItem.SeekStream, WeakAddressOf _SeekStreamHandler
		  
		  mMultiItem = New libcURL.MultiHandle
		  AddHandler mMultiItem.TransferComplete, WeakAddressOf _TransferCompleteHandler
		  mEasyItem.UserAgent = libcURL.Version.Name
		  mEasyItem.Secure = True
		  mEasyItem.FailOnServerError = True
		  mEasyItem.FollowRedirects = True
		  If libcURL.Version.LibZ.IsAvailable Then
		    If Not mEasyItem.SetOption(libcURL.Opts.ACCEPT_ENCODING, "") Then Raise New cURLException(mEasyItem)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EasyItem() As libcURL.EasyHandle
		  Return mEasyItem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDownloadedData() As MemoryBlock
		  ' Returns a MemoryBlock containing all data which was downloaded during the most recent transfer.
		  ' If you passed a Writeable object to any of the transfer methods (get, post, put) then this
		  ' method will return an empty MemoryBlock (not Nil) as the data will have been downloaded into
		  ' the Writeable object directly.
		  
		  If mDownloadMB <> Nil Then Return mDownloadMB
		  Dim data As New MemoryBlock(0)
		  If mDownload = Nil Or Not mDownload IsA BinaryStream Then Return data
		  Dim bs As BinaryStream = BinaryStream(mDownload)
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
		  If mEasyItem <> Nil Then Return mEasyItem.GetInfo(InfoType)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResponseHeaders() As InternetHeaders
		  ' Returns an InternetHeaders object containing all protocol headers received from the server
		  ' during the most recent transfer. If no headers were received, returns Nil.
		  
		  Return mHeaders
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStatusCode() As Integer
		  ' Returns a protocol-specific status code for the most recent transfer. If the transfer
		  ' involved several status codes (FTP anything, HTTP redirects, etc.) then only the most
		  ' recent code is returned.
		  Return Me.GetInfo(libcURL.Info.RESPONSE_CODE).Int32Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsTransferComplete() As Boolean
		  Return mIsTransferComplete
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As Integer
		  Return mEasyItem.LastError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Perform(URL As String, ReadFrom As Readable, WriteTo As Writeable)
		  ' Perform the transfer on the main thread/event loop.
		  
		  QueueTransfer(URL, ReadFrom, WriteTo)
		  mMultiItem.Perform()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Perform(URL As String, ReadFrom As Readable, WriteTo As Writeable) As Boolean
		  ' Perform the transfer on the calling thread.
		  
		  QueueTransfer(URL, ReadFrom, WriteTo)
		  While mMultiItem.PerformOnce()
		    App.YieldToNextThread
		  Wend
		  Return mEasyItem.LastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub QueueTransfer(URL As String, ReadFrom As Readable, WriteTo As Writeable)
		  mIsTransferComplete = False
		  mEasyItem.URL = URL
		  mHeaders = Nil
		  mDownload = WriteTo
		  mDownloadMB = Nil
		  mUpload = ReadFrom
		  If mRequestHeaders <> Nil Then
		    If Not Me.SetOption(libcURL.Opts.HTTPHEADER, mRequestHeaders) Then Raise New libcURL.cURLException(mEasyItem)
		  End If
		  
		  If Not mMultiItem.AddItem(mEasyItem) Then Raise New libcURL.cURLException(mMultiItem)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFormData(FormData As Dictionary)
		  Dim frm As libcURL.MultipartForm
		  If FormData <> Nil Then frm = FormData
		  If Not Me.SetOption(libcURL.Opts.HTTPPOST, frm) Then Raise New libcURL.cURLException(mEasyItem)
		  mForm = frm
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFormData(FormData() As String)
		  'For i As Integer = 0 To UBound(FormData)
		  'FormData(i) = URLEncode(FormData(i))
		  'Next
		  
		  Dim data As String = Join(FormData, "&")
		  If Not mEasyItem.SetOption(libcURL.Opts.POSTFIELDSIZE, data.LenB) Then Raise New libcURL.cURLException(mEasyItem)
		  If Not mEasyItem.SetOption(libcURL.Opts.COPYPOSTFIELDS, data) Then Raise New libcURL.cURLException(mEasyItem)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(OptionNumber As Integer, NewValue As Variant) As Boolean
		  If mEasyItem <> Nil Then Return mEasyItem.SetOption(OptionNumber, NewValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRequestHeaders(Headers As InternetHeaders)
		  If Headers <> Nil Then
		    If mRequestHeaders = Nil Then mRequestHeaders = New libcURL.ListPtr
		    For i As Integer = 0 To Headers.Count - 1
		      Call mRequestHeaders.Append(Headers.Name(i) + ": " + Headers.Value(Headers.Name(i)))
		    Next
		  Else
		    If Not Me.SetOption(libcURL.Opts.HTTPHEADER, Nil) Then Raise New libcURL.cURLException(mEasyItem)
		    mRequestHeaders = Nil
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub _CreateSocketHandler(Sender As libcURL.EasyHandle, Socket As Integer)
		  #pragma Unused Sender
		  #pragma Unused Socket
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _DataAvailableHandler(Sender As libcURL.EasyHandle, NewData As MemoryBlock) As Integer
		  #pragma Unused Sender
		  If mDownload = Nil Then
		    mDownloadMB = New MemoryBlock(0)
		    mDownload = New BinaryStream(mDownloadMB)
		  End If
		  mDownload.Write(NewData)
		  Return NewData.Size
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _DataNeededHandler(Sender As libcURL.EasyHandle, Buffer As MemoryBlock, MaxLength As Integer) As Integer
		  #pragma Unused Sender
		  
		  If mUpload <> Nil Then
		    Dim data As MemoryBlock = mUpload.Read(MaxLength)
		    Buffer.StringValue(0, data.Size) = data
		    Return data.Size
		  End If
		  
		  If mEasyItem.Verbose Then RaiseEvent DebugMessage(curl_infotype.RB_libcURL, "Abort: No stream to upload!")
		  ' LastError will be libcURL.Errors.ABORTED_BY_CALLBACK(42)
		  Return libcURL.CURL_READFUNC_ABORT
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub _DebugMessageHandler(Sender As libcURL.EasyHandle, MessageType As libcURL.curl_infotype, data As String)
		  #pragma Unused Sender
		  RaiseEvent DebugMessage(MessageType, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub _DisconnectedHandler(Sender As libcURL.EasyHandle, Socket As Integer)
		  #pragma Unused Sender
		  #pragma Unused Socket
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub _HeaderReceivedHandler(Sender As libcURL.EasyHandle, HeaderLine As String)
		  #pragma Unused Sender
		  If mHeaders = Nil Then mHeaders = New InternetHeaders
		  mHeaders.AppendHeader(NthField(HeaderLine, ": ", 1), NthField(HeaderLine, ": ", 2))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _ProgressHandler(Sender As libcURL.EasyHandle, dlTotal As UInt64, dlnow As UInt64, ultotal As UInt64, ulnow As UInt64) As Boolean
		  #pragma Unused Sender
		  'If ulnow > 0 or ultotal > 0 Then Break
		  Return RaiseEvent Progress(dlTotal, dlnow, ultotal, ulnow)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _SeekStreamHandler(Sender As libcURL.EasyHandle, Offset As Integer, Origin As Integer) As Boolean
		  #pragma Unused Sender
		  #pragma Unused Origin
		  If mUpload <> Nil And mUpload IsA BinaryStream Then
		    Dim bs As BinaryStream = BinaryStream(mUpload)
		    If bs.Length <= Offset And Offset > 0 Then
		      bs.Position = Offset
		      Return bs.Position = Offset
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub _TransferCompleteHandler(Sender As libcURL.MultiHandle, Item As libcURL.EasyHandle)
		  #pragma Unused Sender
		  If mDownload <> Nil And mDownload IsA BinaryStream And mDownloadMB <> Nil Then BinaryStream(mDownload).Close
		  Dim status As Integer = Item.LastError
		  If status <> 0 Then
		    RaiseEvent Error(status)
		  Else
		    RaiseEvent TransferComplete(Me.GetInfo(libcURL.Info.SIZE_DOWNLOAD).Int32Value, Me.GetInfo(libcURL.Info.SIZE_UPLOAD).Int32Value)
		  End If
		  mIsTransferComplete = True
		  ClearFormData()
		  mEasyItem.UploadMode = False
		  mUpload = Nil
		  If Item.LastError <> status Then ErrorSetter(Item).LastError = status
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DebugMessage(MessageType As libcURL.curl_infotype, data As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Error(cURLCode As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Progress(dlTotal As UInt64, dlnow As UInt64, ultotal As UInt64, ulnow As UInt64) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TransferComplete(BytesRead As Integer, BytesWritten As Integer)
	#tag EndHook


	#tag Property, Flags = &h21
		Private mDownload As Writeable
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDownloadMB As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEasyItem As libcURL.EasyHandle
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mForm As libcURL.MultipartForm
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHeaders As InternetHeaders
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsTransferComplete As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMultiItem As libcURL.MultiHandle
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequestHeaders As libcURL.ListPtr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpload As Readable
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
End Class
#tag EndClass
