#tag Class
Protected Class MultipartForm
Inherits libcURL.cURLHandle
Implements FormStreamGetter
	#tag Method, Flags = &h0
		Function AddElement(Name As String, Values() As FolderItem) As Boolean
		  ' Adds the passed file array to the form using the specified name.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_formadd.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.AddElement
		  
		  Dim v() As Variant
		  Dim o() As Integer
		  
		  o.Append(CURLFORM_COPYNAME)
		  v.Append(Name)
		  For i As Integer = 0 To UBound(Values)
		    Dim file As FolderItem = Values(i)
		    If Not file.Exists Or file.Directory Then
		      mLastError = libcURL.Errors.INVALID_LOCAL_FILE
		      Return False
		    End If
		    
		    o.Append(CURLFORM_FILE)
		    v.Append(file)
		    
		    o.Append(CURLFORM_CONTENTTYPE)
		    v.Append(MimeType(file))
		  Next
		  
		  Return FormAdd(o, v)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddElement(Name As String, Value As FolderItem, ContentType As String = "", AdditionalHeaders As libcURL.ListPtr = Nil) As Boolean
		  ' Adds the passed file to the form using the specified name.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_formadd.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.AddElement
		  
		  If Not Value.Exists Or Value.Directory Then
		    mLastError = libcURL.Errors.INVALID_LOCAL_FILE
		    Return False
		  End If
		  
		  If ContentType = "" Then ContentType = MimeType(Value)
		  Dim headeropt As Integer = CURLFORM_END
		  If AdditionalHeaders <> Nil Then
		    headeropt = CURLFORM_CONTENTHEADER
		    If mAdditionalHeaders.IndexOf(AdditionalHeaders) = -1 Then mAdditionalHeaders.Append(AdditionalHeaders)
		  End If
		  If ContentType <> "" Then
		    Return FormAdd(CURLFORM_COPYNAME, Name, CURLFORM_FILE, Value.ShellPath, CURLFORM_FILENAME, Value.Name, CURLFORM_CONTENTTYPE, ContentType, headeropt, AdditionalHeaders)
		  Else
		    Return FormAdd(CURLFORM_COPYNAME, Name, CURLFORM_FILE, Value.ShellPath, CURLFORM_FILENAME, Value.Name, headeropt, AdditionalHeaders)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddElement(Name As String, ByRef Value As MemoryBlock, Filename As String, ContentType As String = "", AdditionalHeaders As libcURL.ListPtr = Nil) As Boolean
		  ' Adds the passed buffer to the form as a file part using the specified name. The buffer pointed to by Value
		  ' is used directly (i.e. not copied) so it must continue to exist until after the POST request has completed.
		  ' This method allows file parts to be added without using an actual file. Specify an empty Filename parameter
		  ' to add the Value as a non-file form part.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_formadd.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.AddElement
		  
		  If Value Is Nil Then Raise New NilObjectException
		  If Value.Size < 0 Then Raise New OutOfBoundsException
		  
		  Dim v() As Variant
		  Dim o() As Integer
		  o.Append(CURLFORM_COPYNAME)
		  v.Append(Name)
		  o.Append(CURLFORM_BUFFERPTR)
		  v.Append(Value)
		  If Filename.Trim <> "" Then
		    o.Append(CURLFORM_BUFFER)
		    v.Append(Filename)
		  End If
		  o.Append(CURLFORM_BUFFERLENGTH)
		  v.Append(Value.Size)
		  
		  If ContentType.Trim <> "" Then
		    o.Append(CURLFORM_CONTENTTYPE)
		    v.Append(ContentType)
		  End If
		  
		  If AdditionalHeaders <> Nil Then
		    o.Append(CURLFORM_CONTENTHEADER)
		    v.Append(AdditionalHeaders)
		    If mAdditionalHeaders.IndexOf(AdditionalHeaders) = -1 Then mAdditionalHeaders.Append(AdditionalHeaders)
		  End If
		  
		  Return FormAdd(o, v)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddElement(Name As String, ValueStream As Readable, ValueSize As Integer, Filename As String = "", ContentType As String = "", AdditionalHeaders As libcURL.ListPtr = Nil) As Boolean
		  ' Adds an element using the specified name, with contents which will be read from the passed Readable object.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_formadd.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.AddElement
		  
		  ' this dummy EasyHandle handles the ReadCallback by reading from ValueStream
		  Dim dummy As New libcURL.EasyHandle(Me.Flags)
		  dummy.UploadStream = ValueStream
		  mStreams.Append(dummy)
		  
		  Dim v() As Variant
		  Dim o() As Integer
		  
		  o.Append(CURLFORM_COPYNAME)
		  v.Append(Name)
		  o.Append(CURLFORM_STREAM)
		  v.Append(dummy)
		  
		  If Filename.Trim <> "" Then
		    o.Append(CURLFORM_FILENAME)
		    v.Append(Filename)
		  End If
		  
		  If ContentType.Trim <> "" Then
		    o.Append(CURLFORM_CONTENTTYPE)
		    v.Append(ContentType)
		  End If
		  
		  If AdditionalHeaders <> Nil Then
		    o.Append(CURLFORM_CONTENTHEADER)
		    v.Append(AdditionalHeaders)
		    If mAdditionalHeaders.IndexOf(AdditionalHeaders) = -1 Then mAdditionalHeaders.Append(AdditionalHeaders)
		  End If
		  
		  o.Append(CURLFORM_CONTENTSLENGTH)
		  v.Append(ValueSize)
		  
		  Return FormAdd(o, v)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddElement(Name As String, Value As String, AdditionalHeaders As libcURL.ListPtr = Nil) As Boolean
		  ' Adds the passed Value to the form using the specified name.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_formadd.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.AddElement
		  
		  If AdditionalHeaders <> Nil Then
		    If mAdditionalHeaders.IndexOf(AdditionalHeaders) = -1 Then mAdditionalHeaders.Append(AdditionalHeaders)
		    Return FormAdd(CURLFORM_COPYNAME, Name, CURLFORM_COPYCONTENTS, Value, CURLFORM_CONTENTHEADER, AdditionalHeaders)
		  Else
		    Return FormAdd(CURLFORM_COPYNAME, Name, CURLFORM_COPYCONTENTS, Value)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GlobalInitFlags As Integer = libcURL.CURL_GLOBAL_DEFAULT)
		  // Calling the overridden superclass constructor.
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(GlobalInitFlags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  ' Returns the number of elements in the form.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.Count
		  
		  Dim e As libcURL.MultipartFormElement = Me.FirstElement
		  Dim c As Integer
		  Do Until e = Nil
		    c = c + 1
		    e = e.NextElement
		  Loop
		  Return c
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function curlFormGet(Data As MemoryBlock, Length As Integer) As Integer
		  Return RaiseEvent SerializePart(Data, Length)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Deserialize(FormData As Readable) As libcURL.MultipartForm
		  Dim data As New MemoryBlock(0)
		  Dim bs As New BinaryStream(data)
		  Do Until FormData.EOF
		    bs.Write(FormData.Read(64 * 1024))
		  Loop
		  bs.Close
		  Return Deserialize(data)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Deserialize(FormData As String) As libcURL.MultipartForm
		  Dim form As New MultipartForm
		  Dim Boundary As String = NthField(FormData, EndOfLine.Windows, 1)
		  If Left(Boundary, Len("Content-Type:")) <> "Content-Type:" Then Raise New UnsupportedFormatException
		  Boundary = NthField(Boundary, "boundary=", 2).Trim
		  Dim elements() As String = Split(FormData, "--" + Boundary)
		  
		  Dim ecount As Integer = UBound(elements)
		  For i As Integer = 1 To ecount
		    Dim line As String = NthField(elements(i).LTrim, EndOfLine.Windows, 1)
		    Dim name As String = NthField(line, ";", 2)
		    name = NthField(name, "=", 2)
		    name = ReplaceAll(name, """", "")
		    If name.Trim = "" Then Continue For i
		    If CountFields(line, ";") < 3 Then 'form field
		      If Not form.AddElement(name, NthField(elements(i), EndOfLine.Windows + EndOfLine.Windows, 2)) Then Raise New cURLException(form)
		    Else 'file field
		      Dim filename As String = NthField(line, ";", 3)
		      filename = NthField(filename, "=", 2)
		      filename = ReplaceAll(filename, """", "")
		      Dim tmp As FolderItem = SpecialFolder.Temporary.Child(filename)
		      Dim bs As BinaryStream = BinaryStream.Create(tmp, True)
		      Dim filedata As MemoryBlock = elements(i)
		      Dim t As Integer = InStr(filedata, EndOfLine.Windows + EndOfLine.Windows) + 3
		      filedata = filedata.StringValue(t, filedata.Size - t - 2)
		      bs.Write(filedata)
		      bs.Close
		      If Not form.AddElement(name, tmp) Then Raise New cURLException(form)
		    End If
		  Next
		  
		  Return form
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If mHandle <> 0 Then curl_formfree(mHandle)
		  ReDim mStreams(-1)
		  ReDim mAdditionalHeaders(-1)
		  mHandle = 0
		  LastItem = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormAdd(Options() As Integer, Values() As Variant) As Boolean
		  If UBound(Options) <> UBound(Values) Then Raise New OutOfBoundsException
		  
		  Select Case UBound(Options)
		  Case 1
		    Return FormAdd(Options(0), Values(0), Options(1), Values(1))
		  Case 2
		    Return FormAdd(Options(0), Values(0), Options(1), Values(1), Options(2), Values(2))
		  Case 3
		    Return FormAdd(Options(0), Values(0), Options(1), Values(1), Options(2), Values(2), Options(3), Values(3))
		  Case 4
		    Return FormAdd(Options(0), Values(0), Options(1), Values(1), Options(2), Values(2), Options(3), Values(3), Options(4), Values(4))
		  Case 5
		    Return FormAdd(Options(0), Values(0), Options(1), Values(1), Options(2), Values(2), Options(3), Values(3), Options(4), Values(4), Options(5), Values(5))
		  Case 6
		    Return FormAdd(Options(0), Values(0), Options(1), Values(1), Options(2), Values(2), Options(3), Values(3), Options(4), Values(4), Options(5), Values(5), Options(6), Values(6))
		  Case 7
		    Return FormAdd(Options(0), Values(0), Options(1), Values(1), Options(2), Values(2), Options(3), Values(3), Options(4), Values(4), Options(5), Values(5), Options(6), Values(6), Options(7), Values(7))
		  Case 8
		    Return FormAdd(Options(0), Values(0), Options(1), Values(1), Options(2), Values(2), Options(3), Values(3), Options(4), Values(4), Options(5), Values(5), Options(6), Values(6), Options(7), Values(7), Options(8), Values(8))
		  Case 9
		    Return FormAdd(Options(0), Values(0), Options(1), Values(1), Options(2), Values(2), Options(3), Values(3), Options(4), Values(4), Options(5), Values(5), Options(6), Values(6), Options(7), Values(7), Options(8), Values(8), Options(9), Values(9))
		  Case 10
		    Return FormAdd(Options(0), Values(0), Options(1), Values(1), Options(2), Values(2), Options(3), Values(3), Options(4), Values(4), Options(5), Values(5), Options(6), Values(6), Options(7), Values(7), Options(8), Values(8), Options(9), Values(9), Options(10), Values(10))
		  Else
		    Dim err As New OutOfBoundsException
		    err.Message = "Too many parameters for one call to FormAdd!"
		    Raise err
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FormAdd(Option As Integer, Value As Variant, Option1 As Integer = CURLFORM_END, Value1 As Variant = Nil, Option2 As Integer = CURLFORM_END, Value2 As Variant = Nil, Option3 As Integer = CURLFORM_END, Value3 As Variant = Nil, Option4 As Integer = CURLFORM_END, Value4 As Variant = Nil, Option5 As Integer = CURLFORM_END, Value5 As Variant = Nil, Option6 As Integer = CURLFORM_END, Value6 As Variant = Nil, Option7 As Integer = CURLFORM_END, Value7 As Variant = Nil, Option8 As Integer = CURLFORM_END, Value8 As Variant = Nil, Option9 As Integer = CURLFORM_END, Value9 As Variant = Nil, Option10 As Integer = CURLFORM_END, Value10 As Variant = Nil) As Boolean
		  ' This helper function is a wrapper for the variadic external method curl_formadd. Since external methods
		  ' can't be variadic, this method simulates it by accepting a finite number of optional arguments.
		  '
		  ' Each form field is passed as (at least) four arguments: two Option/Value arguments each for the name and
		  ' contents of the form field. For example, a form with a username field and password field:
		  '
		  '    Call FormAdd( _
		  '      CURLFORM_COPYNAME, "username", CURLFORM_COPYCONTENTS, "Bob", _
		  '      CURLFORM_COPYNAME, "password", CURLFORM_COPYCONTENTS, "seekrit")
		  '
		  ' At least 1 and up to 11 pairs of arguments may be passed at once. Refer the to the libcURL documentation
		  ' for details.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_formadd.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.FormAdd
		  
		  Dim v() As Variant = Array(Value, Value1, Value2, Value3, Value4, Value5, Value6, Value7, Value8, Value9, Value10)
		  Dim m() As MemoryBlock
		  Dim o() As Integer = Array(Option, Option1, Option2, Option3, Option4, Option5, Option6, Option7, Option8, Option9, Option10)
		  For i As Integer = 0 To UBound(v)
		    Select Case VarType(v(i))
		    Case Variant.TypeNil
		      m.Append(New MemoryBlock(0))
		      
		    Case Variant.TypePtr, Variant.TypeInteger
		      m.Append(v(i).PtrValue)
		      
		      #If Target64Bit Then
		    Case Variant.TypeInt64
		      m.Append(v(i).PtrValue)
		      #endif
		      
		    Case Variant.TypeObject
		      Select Case v(i)
		      Case IsA FolderItem
		        Dim mb As MemoryBlock = FolderItem(v(i)).NativePath + Chr(0) ' make doubleplus sure it's null terminated
		        m.Append(mb)
		      Case IsA cURLHandle
		        m.Append(Ptr(cURLHandle(v(i)).Handle))
		      Case IsA MemoryBlock
		        m.Append(MemoryBlock(v(i)))
		      Else
		        Break
		      End Select
		      
		    Case Variant.TypeString
		      Dim mb As MemoryBlock = v(i).StringValue + Chr(0) ' make doubleplus sure it's null terminated
		      m.Append(mb)
		      
		    Else
		      Break
		      
		    End Select
		  Next
		  
		  Return FormAddPtr(o(0), m(0), o(1), m(1), o(2), m(2), o(3), m(3), o(4), m(4), o(5), m(5), o(6), m(6), o(7), m(7), o(8), m(8), o(9), m(9), o(10), m(10))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormAddPtr(Option As Integer, Value As Ptr, Option1 As Integer = CURLFORM_END, Value1 As Ptr = Nil, Option2 As Integer = CURLFORM_END, Value2 As Ptr = Nil, Option3 As Integer = CURLFORM_END, Value3 As Ptr = Nil, Option4 As Integer = CURLFORM_END, Value4 As Ptr = Nil, Option5 As Integer = CURLFORM_END, Value5 As Ptr = Nil, Option6 As Integer = CURLFORM_END, Value6 As Ptr = Nil, Option7 As Integer = CURLFORM_END, Value7 As Ptr = Nil, Option8 As Integer = CURLFORM_END, Value8 As Ptr = Nil, Option9 As Integer = CURLFORM_END, Value9 As Ptr = Nil, Option10 As Integer = CURLFORM_END, Value10 As Ptr = Nil) As Boolean
		  mLastError = curl_formadd(mHandle, LastItem, Option, Value, Option1, Value1, _
		  Option2, Value2, Option3, Value3, Option4, Value4, Option5, Value5, Option6, _
		  Value6, Option7, Value7, Option8, Value8, Option9, Value9, Option10, Value10, CURLFORM_END)
		  
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FormGetCallback(UserData As Integer, Buffer As Ptr, Length As Integer) As Integer
		  #pragma X86CallingConvention CDecl
		  
		  If FormGetStreams = Nil Then Return 0
		  Dim ref As Variant = FormGetStreams.Lookup(UserData, Nil)
		  Select Case ref
		  Case IsA Writeable
		    Dim stream As Writeable = ref
		    Dim mb As MemoryBlock = Buffer
		    stream.Write(mb.StringValue(0, Length))
		    Return Length
		    
		  Case IsA MultipartForm
		    Return MultipartForm(ref).curlFormGet(Buffer, Length)
		    
		  Else
		    Break ' UserData does not refer to a valid stream or form!
		    
		  End Select
		  
		  
		  Exception Err As RuntimeException
		    If Err IsA ThreadEndException Or Err IsA EndException Then Raise Err
		    Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(Index As Integer) As libcURL.MultipartFormElement
		  ' Returns a reference to the MultipartFormElement at the specified index; if the index is out of bounds
		  ' then an OutOfBoundsException will be raised.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.GetElement
		  
		  
		  Dim e As libcURL.MultipartFormElement = Me.FirstElement
		  Dim i As Integer
		  Do
		    If i < Index Then
		      e = e.NextElement
		      If e = Nil Then
		        Dim err As New OutOfBoundsException
		        err.Message = "The form does not contain an element at that index."
		        Raise err
		      End If
		      
		    ElseIf i = Index Then
		      Return e
		      
		    Else
		      Dim err As New OutOfBoundsException
		      err.Message = "Form indices must be greater than or equal to zero."
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
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.GetElement
		  
		  Dim e As libcURL.MultipartFormElement = Me.FirstElement
		  Dim i As Integer
		  Do Until e = Nil
		    If e.Name = Name Then Return i
		    e = e.NextElement()
		    i = i + 1
		  Loop
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetStream(UserData As Ptr) As Readable
		  // Part of the FormStreamGetter interface.
		  For Each h As EasyHandle In mStreams
		    If h.Handle = Integer(UserData) Then Return h.UploadStream
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherForm As libcURL.MultipartForm) As Integer
		  ' Overloads the comparison operator(=), permitting direct comparisons between instances of MultipartForm.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.Operator_Compare
		  
		  Dim i As Integer = Super.Operator_Compare(OtherForm)
		  If i = 0 Then i = Sign(mHandle - OtherForm.Handle)
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Dictionary
		  ' Overloads the conversion operator(=), permitting implicit and explicit conversion from a MultipartForm
		  ' into a Dictionary. The Dictionary contains form elements as NAME:VALUE pairs. NAME is a string containing
		  ' the form-element name; VALUE can be a string, FolderItem, or an object that implements the Readable interface.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.Operator_Convert
		  
		  Dim e As MultipartFormElement = Me.FirstElement
		  If e = Nil Then Return Nil
		  Dim d As New Dictionary
		  Do Until e = Nil
		    Select Case e.Type
		    Case libcURL.FormElementType.File
		      If e.MoreFiles = Nil Then ' single file
		        d.Value(e.Name) = GetFolderItem(e.Contents)
		      Else
		        Dim f() As FolderItem
		        f.Append(GetFolderItem(e.Contents))
		        Dim tmp As MultipartFormElement = e.MoreFiles
		        Do Until tmp = Nil
		          f.Append(GetFolderItem(tmp.Contents))
		          tmp = tmp.NextElement
		        Loop
		        d.Value(e.Name) = f
		      End If
		    Case libcURL.FormElementType.MemoryBlock
		      d.Value(e.Name) = e.Buffer
		    Case libcURL.FormElementType.String
		      d.Value(e.Name) = e.Contents
		    Case libcURL.FormElementType.Stream
		      d.Value(e.Name) = e.Stream
		    End Select
		    e = e.NextElement
		  Loop
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(FromDict As Dictionary)
		  ' Overloads the conversion operator(=), permitting implicit and explicit conversion from a Dictionary
		  ' into a MultipartForm. The dictionary contains NAME:VALUE pairs comprising HTTP form elements: NAME
		  ' is a string containing the form-element name; VALUE may be a string, FolderItem, or an object that
		  ' implements then Readable interface.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.Operator_Convert
		  
		  If mLastError = libcURL.Errors.NOT_INITIALIZED Then
		    Me.Constructor()
		  Else
		    Me.Destructor() ' free the previous form data
		  End If
		  If FromDict = Nil Then Return
		  
		  ' loop over the dictionary
		  For Each item As String In FromDict.Keys
		    Dim value As Variant = FromDict.Value(item)
		    Select Case True
		    Case VarType(value) = Variant.TypeString
		      If Not Me.AddElement(item, value.StringValue) Then Raise New cURLException(Me)
		      
		    Case value IsA FolderItem
		      If Not Me.AddElement(item, FolderItem(value)) Then Raise New cURLException(Me)
		      
		    Case value IsA Readable ' rtfm about CURLFORM_STREAM before using this
		      If Not Me.AddElement(item, Readable(value), 0) Then Raise New cURLException(Me)
		      
		    Case value IsA MemoryBlock
		      Dim mb As MemoryBlock = Value
		      If Not Me.AddElement(item, mb, "") Then Raise New cURLException(Me)
		      
		    Else
		      If VarType(value) >= Variant.TypeArray Then ' files
		        Dim f() As FolderItem = value
		        If Not Me.AddElement(item, f) Then Raise New cURLException(Me)
		      Else
		        Raise New UnsupportedFormatException
		      End If
		    End Select
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Serialize() As String
		  ' Serialize the form structure into a multipart/form-data string. The serialized form may be used with
		  ' other HTTP libraries, including the built-in HTTPSocket.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_formget.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.Serialize
		  
		  Dim mb As New MemoryBlock(0)
		  Dim formstream As New BinaryStream(mb)
		  If Me.Serialize(formstream) Then
		    formstream.Close
		    Return mb
		  Else
		    If mLastError <> 0 Then Raise New cURLException(Me)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Serialize(WriteTo As Writeable) As Boolean
		  ' Serialize the form and write the output to WriteTo. The serialized form may be used with
		  ' other HTTP libraries, including the built-in HTTPSocket. If WriteTo is Nil then the
		  ' SerializePart event will be raised in lieu of writing the data to a stream.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_formget.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.Serialize
		  
		  If mHandle = 0 Then Return False
		  If Not libcURL.Version.IsAtLeast(7, 15, 5) Then
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Return False
		  End If
		  
		  ' The form will be serialized one element at a time via several invocations of FormGetCallback
		  If FormGetStreams = Nil Then FormGetStreams = New Dictionary
		  If WriteTo <> Nil Then
		    FormGetStreams.Value(mHandle) = WriteTo
		  Else
		    FormGetStreams.Value(mHandle) = Me
		  End If
		  Try
		    mLastError = curl_formget(mHandle, mHandle, AddressOf FormGetCallback)
		  Finally
		    FormGetStreams.Remove(mHandle)
		  End Try
		  Return mLastError = 0
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event SerializePart(Data As MemoryBlock, Length As Integer) As Integer
	#tag EndHook


	#tag Note, Name = Using this class
		This class represents a linked list of form elements that are managed by libcURL.
		Use the AddElement method to add a form element to the form. Form elements may be
		either strings or folderitems (for uploading)
		
		Once the form is constructed you can pass it to the EasyHandle.SetOption method using
		libcURL.Opts.HTTPPOST as the option number.
		
		e.g.
		
		  Dim frm As New libcURL.MultipartForm
		  Dim f FolderItem //assume a valid & extant file
		  Call frm.AddElement("file", f)
		  Call frm.AddElement("username", "AzureDiamond")
		  Call frm.AddElement("password", "hunter2")
		  Dim sock As New libcURL.EasyHandle
		  Call sock.SetOption(libcURL.Opts.HTTPPOST, frm)
		  Call sock.Perform("http://www.example.com/submit.php", 5)
	#tag EndNote


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  ' Returns a reference to the first element in the form. If the form is empty then
			  ' this method returns Nil.
			  
			  Dim List As Ptr = Ptr(Me.Handle)
			  If List = Nil Then Return Nil
			  Return New MultipartFormElement(List, Me)
			  
			  
			End Get
		#tag EndGetter
		Protected FirstElement As libcURL.MultipartFormElement
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared FormGetStreams As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected LastItem As Ptr
	#tag EndProperty

	#tag Property, Flags = &h1
		#tag Note
			This array merely holds references to any header lists being used, to prevent them from going out of scope too early.
		#tag EndNote
		Protected mAdditionalHeaders() As libcURL.ListPtr
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mStreams() As libcURL.EasyHandle
	#tag EndProperty


	#tag Constant, Name = CURLFORM_BUFFER, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_BUFFERLENGTH, Type = Double, Dynamic = False, Default = \"13", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_BUFFERPTR, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_CONTENTHEADER, Type = Double, Dynamic = False, Default = \"15", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_CONTENTLEN, Type = Double, Dynamic = False, Default = \"20", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_CONTENTSLENGTH, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_CONTENTTYPE, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_COPYCONTENTS, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_COPYNAME, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_END, Type = Double, Dynamic = False, Default = \"17", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLFORM_FILE, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_FILECONTENT, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_FILENAME, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLFORM_STREAM, Type = Double, Dynamic = False, Default = \"19", Scope = Public
	#tag EndConstant


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
