#tag Class
Protected Class FTPWildCard
Inherits libcURL.EasyHandle
	#tag Method, Flags = &h21
		Private Shared Function ChunkBeginCallback(TransferInfo As Ptr, UserData As Integer, Remaining As Integer) As Integer
		  ' This method handles the CURLOPT_CHUNK_BGN_FUNCTION callback by invoking curlChunkBegin
		  ' on the appropriate instance of FTPWildCard
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_CHUNK_BGN_FUNCTION.html
		  
		  #pragma X86CallingConvention CDecl
		  
		  If Instances = Nil Then Return CURL_CHUNK_BGN_FUNC_FAIL
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA FTPWildCard And TransferInfo <> Nil Then
		    Return FTPWildCard(curl.Value).curlChunkBegin(TransferInfo.FileInfo, Remaining)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		  Return CURL_CHUNK_BGN_FUNC_FAIL
		  
		Exception Err As RuntimeException
		  If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		  Return CURL_CHUNK_BGN_FUNC_FAIL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ChunkEndCallback(UserData As Integer) As Integer
		  ' This method handles the CURLOPT_CHUNK_END_FUNCTION callback by invoking curlChunkEnd
		  ' on the appropriate instance of FTPWildCard
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_CHUNK_END_FUNCTION.html
		  
		  #pragma X86CallingConvention CDecl
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA FTPWildCard Then
		    Return FTPWildCard(curl.Value).curlChunkEnd()
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		  Return CURL_CHUNK_END_FUNC_FAIL
		  
		  
		Exception Err As RuntimeException
		  If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		  Return CURL_CHUNK_END_FUNC_FAIL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(CopyOpts As libcURL.EasyHandle)
		  // Calling the overridden superclass constructor.
		  // Constructor(CopyOpts As libcURL.EasyHandle) -- From libcURL.EasyHandle
		  Super.Constructor(CopyOpts)
		  If CopyOpts IsA FTPWildCard Then
		    Me.LocalRoot = FTPWildCard(CopyOpts).LocalRoot
		    Me.OverwriteLocalFiles = FTPWildCard(CopyOpts).OverwriteLocalFiles
		    Me.CustomMatch = FTPWildCard(CopyOpts).CustomMatch
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function curlChunkBegin(Info As FileInfo, Remaining As Integer) As Integer
		  ' The LIST entry is starting
		  
		  mRemaining = Remaining
		  Dim mb As MemoryBlock = Info.FileName
		  Dim filename As String = mb.CString(0)
		  If filename = "." Or filename = ".." Then Return CURL_CHUNK_BGN_FUNC_SKIP ' skip parent and self references
		  Dim file As FolderItem
		  If LocalRoot <> Nil Then file = LocalRoot.Child(filename)
		  
		  Dim p As New Permissions(Info.Perm)
		  Me.DownloadStream = Nil
		  If RaiseEvent QueueFile(filename, file, Info.FileType, p) Then Return CURL_CHUNK_BGN_FUNC_SKIP
		  If file = Nil Then Return CURL_CHUNK_BGN_FUNC_OK ' the dataavailable event will be raised
		  
		  Select Case Info.FileType
		  Case FILETYPE_FILE
		    Try
		      Me.DownloadStream = BinaryStream.Create(file, OverwriteLocalFiles)
		    Catch Err As IOException
		      Return CURL_CHUNK_BGN_FUNC_FAIL
		    End Try
		  Case FILETYPE_DIR
		    If Not file.Exists Then file.CreateAsFolder
		    If Not file.Directory Then Return CURL_CHUNK_BGN_FUNC_FAIL
		  Else
		    Break ' other type; the dataavailable event will be raised
		  End Select
		  
		  Return CURL_CHUNK_BGN_FUNC_OK
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLChunkBegin(TransferInfo As Ptr, UserData As Integer, Remaining As Integer) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Function curlChunkEnd() As Integer
		  ' The LIST entry is ended
		  
		  If Me.DownloadStream <> Nil And Me.DownloadStream IsA BinaryStream Then BinaryStream(Me.DownloadStream).Close
		  Me.DownloadStream = Nil
		  Return CURL_CHUNK_END_FUNC_OK
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLChunkEnd(UserData As Integer) As Integer
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLFNMatch(UserData As Integer, Pattern As Ptr, FileName As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Function curlFNMatch(Pattern As MemoryBlock, FileName As MemoryBlock) As Integer
		  Dim fn As String = FileName.CString(0)
		  If fn = "." Or fn = ".." Then Return CURL_FNMATCHFUNC_NOMATCH
		  If RaiseEvent PatternMatch(Pattern.CString(0), fn) Then Return CURL_FNMATCHFUNC_MATCH
		  Return CURL_FNMATCHFUNC_NOMATCH
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FNMatchCallback(UserData As Integer, Pattern As Ptr, FileName As Ptr) As Integer
		  ' This method handles the CURLOPT_FNMATCH_FUNCTION callback by invoking curlFNMatch
		  ' on the appropriate instance of FTPWildCard
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_FNMATCH_FUNCTION.html
		  
		  #pragma X86CallingConvention CDecl
		  
		  If Instances = Nil Then Return 0
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA FTPWildCard Then
		    Return FTPWildCard(curl.Value).curlFNMatch(Pattern, FileName)
		  End If
		  
		  Break ' UserData does not refer to a valid instance!
		  Return CURL_FNMATCHFUNC_FAIL
		  
		  
		Exception Err As RuntimeException
		  If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		  Return CURL_FNMATCHFUNC_FAIL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub InitCallbacks()
		  ' This method initializes the callbacks for the FTPWildCard; it is called by the
		  ' superclass Constructor and Reset methods.
		  
		  If Not libcURL.Version.IsAtLeast(7, 21, 0) Then
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(Me)
		  End If
		  
		  Super.InitCallbacks()
		  If Not Me.SetOption(libcURL.Opts.WILDCARDMATCH, True) Then Raise New cURLException(Me)
		  If Not Me.SetOption(libcURL.Opts.CHUNK_BGN_FUNCTION, AddressOf ChunkBeginCallback) Then Raise New cURLException(Me)
		  If Not Me.SetOption(libcURL.Opts.CHUNK_END_FUNCTION, AddressOf ChunkEndCallback) Then Raise New cURLException(Me)
		  If Not Me.SetOption(libcURL.Opts.CHUNK_DATA, mHandle) Then Raise New cURLException(Me)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  ' Resets the curl_easy handle to a pristine state. You may reuse the handle immediately.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_reset.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.Reset
		  
		  Super.Reset
		  CustomMatch = mCustomMatch
		  mLastError = 0
		  mRemaining = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(OptionNumber As Integer, NewValue As Variant) As Boolean
		  ' Call this method with a curl option number and a value that is acceptable for that option.
		  ' Refer to the EasyHandle.SetOption method for additional info.
		  
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_easy_setopt.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.EasyHandle.SetOption
		  
		  Select Case True
		  Case NewValue IsA cURLChunkBegin
		    Dim p As cURLChunkBegin = NewValue
		    Return Me.SetOptionPtr(OptionNumber, p)
		  Case NewValue IsA cURLChunkEnd
		    Dim p As cURLChunkEnd = NewValue
		    Return Me.SetOptionPtr(OptionNumber, p)
		  Case NewValue IsA cURLFNMatch
		    Dim p As cURLFNMatch = NewValue
		    Return Me.SetOptionPtr(OptionNumber, p)
		  End Select
		  
		  Return Super.SetOption(OptionNumber, NewValue)
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event PatternMatch(Pattern As String, Filename As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event QueueFile(RemoteName As String, ByRef LocalFile As FolderItem, Type As Integer, UnixPerms As Permissions) As Boolean
	#tag EndHook


	#tag Note, Name = About this class
		This class wraps libcURL's built-in FTP WildCard download feature. If libcURL understands the server's LIST response
		format, then you can use this class to enumerate or download all the files in a remote directory whose name matches 
		a specific pattern. 
		
		Since this class is a subclass of EasyHandle, it can be used anywhere an EasyHandle is expected. This means that you can use
		classes like cURLClient to conduct WildCard transfers:
		
		  Dim outputdir As FolderItem = SelectFolder()
		  Dim w As New FTPWildCard
		  w.LocalRoot = outputdir
		
		  Dim c As New cURLClient(w) ' pass the FTPWildCard to cURLManager.Constructor(EasyHandle)
		
		  If Not c.Get("ftp://ftp.example.com/pub/*.htm*") Then ' use a pattern in the URL
		    MsgBox("Error: " + Str(c.LastError))
		  Else
		    MsgBox("Success!")
		    outputdir.Launch
		  End If
		  
		See this page for a description of supported patterns: http://curl.haxx.se/libcurl/c/CURLOPT_WILDCARDMATCH.html#DESCRIPTION
		
		You may also implement custom pattern matching by setting CustomMatch=True and handling the PatternMatch event.
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets whether the PatternMatch event will be raised in lieu of libcurl's default pattern matching function.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Protocols.FTPWildCard.CustomMatch
			  
			  return mCustomMatch
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets whether the PatternMatch event will be raised in lieu of libcurl's default pattern matching function.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Protocols.FTPWildCard.CustomMatch
			  
			  If value Then
			    If Not Me.SetOption(libcURL.Opts.FNMATCH_FUNCTION, AddressOf FNMatchCallback) Then Raise New cURLException(Me)
			    If Not Me.SetOption(libcURL.Opts.FNMATCH_DATA, mHandle) Then Raise New cURLException(Me)
			  Else
			    If Not Me.SetOption(libcURL.Opts.FNMATCH_FUNCTION, Nil) Then Raise New cURLException(Me)
			    If Not Me.SetOption(libcURL.Opts.FNMATCH_DATA, 0) Then Raise New cURLException(Me)
			  End If
			  mCustomMatch = value
			End Set
		#tag EndSetter
		CustomMatch As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		#tag Note
			Specify the local directory into which files should be downloaded. The FolderItem passed to the QueueFile event
			as 'LocalFile' will be a child of LocalRoot. If LocalRoot is Nil then the DataAvailable event will be raised instead.
			
			See:
			https://github.com/charonn0/RB-libcURL/wiki/libcURL.Protocols.FTPWildCard.LocalRoot
		#tag EndNote
		LocalRoot As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCustomMatch As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRemaining As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			If set to True then existing children of the 'LocalRoot' directory will be overwritten if they have the same name as a file
			being downloaded from the server. The default is False, in which case existing children will cause the transfer to fail with
			curl error code CURLE_CHUNK_FAILED(88)
			
			See:
			https://github.com/charonn0/RB-libcURL/wiki/libcURL.Protocols.FTPWildCard.OverwriteLocalFiles
		#tag EndNote
		OverwriteLocalFiles As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the number of LIST entries which remain to be processed.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Protocols.FTPWildCard.Remaining
			  
			  Return mRemaining
			End Get
		#tag EndGetter
		Remaining As Integer
	#tag EndComputedProperty


	#tag Constant, Name = CURL_CHUNK_BGN_FUNC_FAIL, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURL_CHUNK_BGN_FUNC_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURL_CHUNK_BGN_FUNC_SKIP, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURL_CHUNK_END_FUNC_FAIL, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURL_CHUNK_END_FUNC_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURL_FNMATCHFUNC_FAIL, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURL_FNMATCHFUNC_MATCH, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURL_FNMATCHFUNC_NOMATCH, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FILETYPE_BLOCK, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILETYPE_CHAR, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILETYPE_DIR, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILETYPE_FILE, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILETYPE_PIPE, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILETYPE_SOCKET, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILETYPE_SYM, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant


	#tag Structure, Name = FileInfo, Flags = &h1
		FileName As Ptr
		  FileType As UInt32
		  Time As UInt32
		  Perm As UInt32
		  UID As Int32
		  GID As Int32
		  FileSize As Integer
		HardLinks As Integer
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="AutoDisconnect"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoReferer"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BufferSize"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BufferSizeUpload"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConnectionTimeout"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CustomMatch"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FailOnServerError"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FollowRedirects"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPCompression"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPPreserveMethod"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
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
			Name="LocalPort"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxRedirects"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="OverwriteLocalFiles"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Password"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PipeWait"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Remaining"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemoteIP"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Secure"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.EasyHandle"
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
			InheritedFrom="libcURL.EasyHandle"
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
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="URL"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseErrorBuffer"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseProgressEvent"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UserAgent"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Username"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Verbose"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="libcURL.EasyHandle"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
