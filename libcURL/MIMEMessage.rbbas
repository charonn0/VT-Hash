#tag Class
Protected Class MIMEMessage
Inherits libcURL.cURLHandle
Implements FormStreamGetter
	#tag Method, Flags = &h0
		Function AddElement(Name As String, Value As FolderItem, FileName As String = "", ContentType As String = "", AdditionalHeaders As libcURL.ListPtr = Nil, Encoding As libcURL.TransferEncoding = libcURL.TransferEncoding.Binary) As Boolean
		  ' Adds the passed file to the form using the specified name.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.AddElement
		  
		  Dim part As Ptr = AddPart()
		  If Not SetPartName(part, Name) Then Return False
		  If Not SetPartFile(part, Value) Then Return False
		  If FileName <> "" And Not SetPartFileName(part, FileName) Then Return False
		  If ContentType = "" Then ContentType = MIMEType(Value)
		  If ContentType <> "" Then
		    If Not SetPartType(part, ContentType) Then Return False
		  End If
		  If AdditionalHeaders <> Nil Then
		    If Not SetPartHeaders(part, AdditionalHeaders) Then Return False
		  End If
		  If Encoding <> TransferEncoding.Binary Then
		    If Not SetPartEncoding(part, encoding) Then Return False
		  End If
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddElement(Name As String, Value As libcURL.MIMEMessage, AdditionalHeaders As libcURL.ListPtr = Nil) As Boolean
		  ' Adds the passed MIME message to the form as a subpart using the specified name.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.AddElement
		  
		  If Value Is Me Then
		    mLastError = libcURL.Errors.CALL_LOOP_DETECTED
		    Raise New cURLException(Me)
		  End If
		  
		  Dim part As Ptr = AddPart()
		  If Not SetPartName(part, Name) Then Return False
		  If Not SetPartSubparts(part, Value) Then Return False
		  If AdditionalHeaders <> Nil Then
		    If Not SetPartHeaders(part, AdditionalHeaders) Then Return False
		  End If
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddElement(Name As String, ValueStream As Readable, ValueSize As Integer, Filename As String = "", ContentType As String = "", AdditionalHeaders As libcURL.ListPtr = Nil, Encoding As libcURL.TransferEncoding = libcURL.TransferEncoding.Binary) As Boolean
		  ' Adds an element using the specified name, with contents which will be read from the passed Readable object.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.AddElement
		  
		  Dim part As Ptr = AddPart()
		  If Not SetPartName(part, Name) Then Return False
		  If Filename <> "" Then
		    If Not SetPartFileName(part, Filename + Chr(0)) Then Return False
		  End If
		  If Filename <> "" And ContentType = "" Then ContentType = MIMEType(SpecialFolder.Temporary.Child(Filename))
		  If ContentType <> "" Then
		    If Not SetPartType(part, ContentType) Then Return False
		  End If
		  If AdditionalHeaders <> Nil Then
		    If Not SetPartHeaders(part, AdditionalHeaders) Then Return False
		  End If
		  If Encoding <> TransferEncoding.Binary Then
		    If Not SetPartEncoding(part, encoding) Then Return False
		  End If
		  If PartStreams = Nil Then PartStreams = New Dictionary
		  PartStreams.Value(part) = ValueStream
		  If ValueStream IsA BinaryStream Then ' seekable
		    If Not SetPartCallbacks(part, ValueSize, AddressOf ReadCallback, AddressOf SeekCallback, AddressOf FreeCallback, part) Then Return False
		  Else
		    If Not SetPartCallbacks(part, ValueSize, AddressOf ReadCallback, Nil, AddressOf FreeCallback, part) Then Return False
		  End If
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddElement(Name As String, Value As String, AdditionalHeaders As libcURL.ListPtr = Nil, Encoding As libcURL.TransferEncoding = libcURL.TransferEncoding.Binary) As Boolean
		  ' Adds the passed Value to the form using the specified Name.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.AddElement
		  
		  Dim part As Ptr = AddPart()
		  If Not SetPartName(part, Name) Then Return False
		  If Not SetPartData(part, Value) Then Return False
		  If Encoding <> TransferEncoding.Binary Then
		    If Not SetPartEncoding(part, encoding) Then Return False
		  End If
		  If AdditionalHeaders <> Nil Then
		    If Not SetPartHeaders(part, AdditionalHeaders) Then Return False
		  End If
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AddPart() As Ptr
		  ' Adds a new part to the message and returns a Ptr to it.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_mime_addpart.html
		  
		  If Owner = Nil Then
		    mLastError = libcURL.Errors.MIME_OWNER_MISSING
		    Raise New cURLException(Me)
		  End If
		  
		  Dim part As Ptr = curl_mime_addpart(mHandle)
		  If part = Nil Then
		    mLastError = libcURL.Errors.MIME_ADD_FAILED
		    Raise New cURLException(Me)
		  End If
		  Return part
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Owner As libcURL.EasyHandle)
		  ' Constructs a new MIME message. You must specify an EasyHandle to be the owner of the
		  ' MIMEMessage.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(Owner.Flags)
		  If Not libcURL.Version.IsAtLeast(7, 56, 0) Then
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(Me)
		  End If
		  
		  mHandle = curl_mime_init(Owner.Handle)
		  If mHandle = 0 Then
		    mLastError = libcURL.Errors.INIT_FAILED
		    Raise New cURLException(Me)
		  End If
		  mOwner = New WeakRef(Owner)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Owner As libcURL.EasyHandle, FromDict As Dictionary)
		  ' Constructs a new MIME message from a dictionary. You must specify an EasyHandle to be the owner of the
		  ' MIMEMessage.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.Constructor
		  
		  Me.Constructor(Owner)
		  For Each k As String In FromDict.Keys
		    Dim v As Variant = FromDict.Value(k)
		    If v IsA FolderItem Then
		      Dim f As FolderItem = v
		      Call Me.AddElement(k, f)
		    ElseIf v.Type = Variant.TypeString Then
		      Call Me.AddElement(k, v.StringValue)
		    Else
		      mLastError = libcURL.Errors.MIME_MANUAL_ONLY
		      Raise New cURLException(Me)
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(MessagePtr As Ptr, ParentMessage As libcURL.MIMEMessage)
		  ' Constructs a non-freeable instance of MIMEMessage which references a sub-part of the
		  ' ParentMessage. (Used by MIMEMessagePart.SubPart)
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.Constructor
		  
		  Dim own As EasyHandle = ParentMessage.Owner
		  // Calling the overridden superclass constructor.
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(own.Flags)
		  If Not libcURL.Version.IsAtLeast(7, 56, 0) Then
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(Me)
		  End If
		  
		  mHandle = Integer(MessagePtr)
		  mOwner = New WeakRef(own)
		  mFreeable = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  ' Returns the number of top-level parts in the message.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.Count
		  
		  Dim e As libcURL.MIMEMessagePart = Me.FirstPart
		  Dim c As Integer
		  Do Until e = Nil
		    c = c + 1
		    e = e.NextPart
		  Loop
		  Return c
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub cURLFreeCallback(UserData As Ptr)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLReadCallback(Buffer As Ptr, Size As UInt32, NumItems As Integer, UserData As Ptr) As Integer
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function cURLSeekCallback(UserData As Ptr, Offset As Integer, Origin As Integer) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  ' Frees the MIME message. If the message is a subpart of another MIMEMessage then
		  ' it will not be freed until the owner message is freed.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_mime_free.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.Destructor
		  
		  If mFreeable And mHandle <> 0 Then curl_mime_free(mHandle)
		  mHandle = 0
		  ReDim mOwnedLists(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub FreeCallback(UserData As Ptr)
		  #pragma X86CallingConvention CDecl
		  If PartStreams <> Nil And PartStreams.HasKey(UserData) Then PartStreams.Remove(UserData)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(Index As Integer) As libcURL.MIMEMessagePart
		  ' Returns a reference to the MIMEMessagePart at the specified index; if the index is out of bounds
		  ' then an OutOfBoundsException will be raised.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.GetElement
		  
		  
		  Dim e As libcURL.MIMEMessagePart = Me.FirstPart
		  Dim i As Integer
		  Do
		    If i < Index Then
		      e = e.NextPart
		      If e = Nil Then
		        Dim err As New OutOfBoundsException
		        err.Message = "The message does not contain an element at that index."
		        Raise err
		      End If
		      
		    ElseIf i = Index Then
		      Return e
		      
		    Else
		      Dim err As New OutOfBoundsException
		      err.Message = "Message indices must be greater than or equal to zero."
		      Raise err
		    End If
		    i = i + 1
		    
		  Loop
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(Name As String) As Integer
		  ' Returns the index of the first MultipartFormElement that matches the given name.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.GetElement
		  
		  Dim e As libcURL.MIMEMessagePart = Me.FirstPart
		  Dim i As Integer
		  Do Until e = Nil
		    If e.Name = Name Then Return i
		    e = e.NextPart
		    i = i + 1
		  Loop
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetStream(UserData As Ptr) As Readable
		  // Part of the FormStreamGetter interface.
		  Return PartStreams.Lookup(UserData, Nil)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsAvailable() As Boolean
		  ' Returns True if the MIME API is available (if not then use the MultipartForm class instead.)
		  
		  Return libcURL.Version.IsAtLeast(7, 56, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherMessage As libcURL.MIMEMessage) As Integer
		  ' Overloads the comparison operator(=), permitting direct comparisons between instances of MIMEMessage.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.Operator_Compare
		  
		  Dim i As Integer = Super.Operator_Compare(OtherMessage)
		  If i = 0 Then i = Sign(mHandle - OtherMessage.Handle)
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Owner() As libcURL.EasyHandle
		  If mOwner <> Nil And mOwner.Value <> Nil And mOwner.Value IsA EasyHandle Then Return EasyHandle(mOwner.Value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ReadCallback(Buffer As Ptr, Size As UInt32, NumItems As Integer, UserData As Ptr) As Integer
		  #pragma X86CallingConvention CDecl
		  
		  Dim r As Readable = PartStreams.Lookup(UserData, Nil)
		  If r = Nil Then Return 0 ' fail read
		  Dim sz As Integer = NumItems * Size
		  Dim mb As MemoryBlock = r.Read(sz)
		  Dim buf As MemoryBlock = Buffer
		  If mb.Size > 0 Then buf.StringValue(0, mb.Size) = mb
		  Return mb.Size
		  
		  Exception Err As RuntimeException
		    If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		    Return CURL_READFUNC_ABORT
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function SeekCallback(UserData As Ptr, Offset As Integer, Origin As Integer) As Integer
		  #pragma X86CallingConvention CDecl
		  #pragma Unused Origin
		  
		  Dim r As Readable = PartStreams.Lookup(UserData, Nil)
		  If r = Nil Then Return 1 ' fail seek
		  If Not r IsA BinaryStream Then Return 2 ' fail seek but libcURL can try to work around it
		  Dim ps As BinaryStream = BinaryStream(r)
		  If ps.Length < Offset Then Return 2 ' fail seek but libcURL can try to work around it
		  ps.Position = Offset
		  Return 0 ' OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetPartCallbacks(Part As Ptr, ReadLength As Integer, ReadFunction As cURLReadCallback, SeekFunction As cURLSeekCallback, FreeFunction As cURLFreeCallback, UserData As Ptr) As Boolean
		  ' Assigns callback functions to the MIME message part denoted by the Part parameter. The Part
		  ' must belong to this MIME message.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_mime_data_cb.html
		  
		  mLastError = curl_mime_data_cb(Part, ReadLength, ReadFunction, SeekFunction, FreeFunction, UserData)
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetPartData(Part As Ptr, Data As MemoryBlock, DataLength As Integer = - 1) As Boolean
		  ' Sets the value of the Part to the Data parameter. The Part must belong to this MIME message.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_mime_data.html
		  
		  If DataLength = -1 Then DataLength = Data.Size
		  mLastError = curl_mime_data(Part, Data, DataLength)
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetPartEncoding(Part As Ptr, Encoding As TransferEncoding) As Boolean
		  ' Sets the encoding of the Part. The Part must belong to this MIME message.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_mime_data.html
		  
		  Dim mb As MemoryBlock
		  Select Case Encoding
		  Case TransferEncoding.Binary
		    mb = "binary" + Chr(0)
		  Case TransferEncoding.SevenBit
		    mb = "7bit" + Chr(0)
		  Case TransferEncoding.EightBit
		    mb = "8bit" + Chr(0)
		  Case TransferEncoding.Base64
		    mb = "base64" + Chr(0)
		  Case TransferEncoding.QuotedPrintable
		    mb = "quoted-printable" + Chr(0)
		  End Select
		  
		  mLastError = curl_mime_encoder(Part, mb)
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetPartFile(Part As Ptr, File As FolderItem) As Boolean
		  ' Sets the value of the Part to the File parameter. The Part must belong to this MIME message.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_mime_filedata.html
		  
		  Dim mb As MemoryBlock = File.NativePath + Chr(0)
		  mLastError = curl_mime_filedata(Part, mb)
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetPartFileName(Part As Ptr, Filename As String) As Boolean
		  ' If the Part is a file then this sets the filename. The Part must belong to this MIME message.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_mime_filename.html
		  
		  Dim mb As MemoryBlock = Filename + Chr(0)
		  mLastError = curl_mime_filename(Part, mb)
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetPartHeaders(Part As Ptr, Headers As libcURL.ListPtr, TakeOwnerShip As Boolean = True) As Boolean
		  ' Sets additional MIME headers to be included in the Part. The Part must belong to this MIME message.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_mime_headers.html
		  
		  Dim own As Integer
		  If TakeOwnerShip Then
		    own = 1
		    If mOwnedLists.IndexOf(Headers) = -1 Then mOwnedLists.Append(Headers)
		  End If
		  mLastError = curl_mime_headers(Part, Headers.Handle, own)
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetPartName(Part As Ptr, Name As String) As Boolean
		  ' Sets the name of the Part. The Part must belong to this MIME message.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_mime_name.html
		  
		  Dim mb As MemoryBlock = Name + Chr(0)
		  mLastError = curl_mime_name(Part, mb, mb.Size)
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetPartSubparts(Part As Ptr, Subparts As libcURL.MIMEMessage) As Boolean
		  ' Sets the Subparts MIME message as the value of the Part. The Part must belong to this MIME message.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_mime_subparts.html
		  
		  mLastError = curl_mime_subparts(Part, Subparts.Handle)
		  If mLastError = 0 Then Subparts.mFreeable = False
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetPartType(Part As Ptr, MIMEType As String) As Boolean
		  ' Sets the content-type of the value if the Part is a file part. The Part must belong to this MIME message.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_mime_type.html
		  
		  
		  Dim mb As MemoryBlock = MIMEType + Chr(0)
		  mLastError = curl_mime_type(Part, mb)
		  Return mLastError = 0
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a read-only reference to the first part of the message. Use the NextPart property of
			  ' the returned MIMEMessagePart object to iterate over the message parts.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessage.FirstPart
			  
			  Dim List As Ptr = Ptr(Me.Handle)
			  If List <> Nil Then
			    Dim m As curl_mime = List.curl_mime
			    Return New MIMEMessagePart(m.FirstPart, Me)
			  End If
			End Get
		#tag EndGetter
		FirstPart As libcURL.MIMEMessagePart
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mFreeable As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOwnedLists() As libcURL.ListPtr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared PartStreams As Dictionary
	#tag EndProperty


	#tag Structure, Name = curl_mime, Flags = &h21, Attributes = \"StructureAlignment \x3D 1"
		Easy As Ptr
		  Parent As Ptr
		  FirstPart As Ptr
		  LastPart As Ptr
		  Boundary As Ptr
		State As Integer
	#tag EndStructure


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
End Class
#tag EndClass
