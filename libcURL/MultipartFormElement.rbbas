#tag Class
Protected Class MultipartFormElement
	#tag Method, Flags = &h0
		Sub Constructor(ItemStruct As Ptr, Owner As libcURL.MultipartForm)
		  ' Constructs a new MultipartFormElement. Generally, you should not construct instances
		  ' of this class. Use the value returned from MultipartForm.GetElement, MultipartFormElement.NextElement,
		  ' or MultipartFormElement.MoreFiles instead.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.Constructor
		  
		  mOwner = Owner
		  mStruct = ItemStruct
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherFormElement As libcURL.MultipartFormElement) As Integer
		  ' Overloads the comparison operator(=), permitting direct comparisons between instances of MultipartFormElement.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.Operator_Compare
		  
		  If OtherFormElement Is Nil Then Return 1
		  Dim i As Integer = mOwner.Operator_Compare(OtherFormElement.mOwner)
		  If i = 0 Then i = Sign(Integer(mStruct) - Integer(OtherFormElement.mStruct))
		  Return i
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the form element's Type is FormElementType.MemoryBlock, then this property
			  ' will return a pointer to the MemoryBlock being used. Otherwise, returns Nil.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.Buffer
			  
			  If Struct.Buffer <> Nil Then Return Struct.Buffer
			End Get
		#tag EndGetter
		Buffer As MemoryBlock
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the form element's Type is FormElementType.MemoryBlock, then this property will return
			  ' length of the buffer in bytes.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.BufferSize
			  
			  Return Struct.BufferLen
			End Get
		#tag EndGetter
		BufferSize As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' A list of additional headers that have been included with the form element. If no additional
			  ' headers were specified then this property will be Nil.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.ContentHeaders
			  
			  If mContentHeaders = Nil Then
			    Dim p As Ptr = Struct.ContentHeader
			    If p <> Nil Then mContentHeaders = New ListPtr(p, mOwner.Flags)
			  End If
			  Return mContentHeaders
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value <> Nil Then
			    Dim p As Ptr = Ptr(value.Handle)
			    Struct.ContentHeader = p
			  Else
			    Struct.ContentHeader = Nil
			  End If
			  mContentHeaders = value
			End Set
		#tag EndSetter
		ContentHeaders As libcURL.ListPtr
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The length of the form element's contents if the form element's Type is FormElementType.Stream.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.ContentLen
			  
			  Return Struct.ContentsLen
			End Get
		#tag EndGetter
		ContentLen As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the form element's Type is FormElementType.String or FormElementType.MemoryBlock, then this property
			  ' will return a copy of the form element's contents. If the Type is FormElementType.File then this property
			  ' returns the path to the file being used. Otherwise, this property returns an empty string.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.Contents
			  
			  If Struct.UserData <> Nil Then Return "" ' CURLFORM_STREAM doesn't store the contents
			  Dim mb As MemoryBlock = Struct.Contents
			  If mb <> Nil Then
			    If Struct.ContentsLen > 0 Then
			      Return mb.StringValue(0, Struct.ContentsLen)
			    Else
			      Return mb.CString(0)
			    End If
			  End If
			End Get
		#tag EndGetter
		Contents As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the form element is a file part (regardless of whether an actual file is used), then this
			  ' property will return the MIMEType being used.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.ContentType
			  
			  Dim mb As MemoryBlock = Struct.ContentType
			  If mb <> Nil Then Return mb.CString(0)
			End Get
		#tag EndGetter
		ContentType As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the form element is a file part (regardless of whether an actual file is used), then
			  ' this property will return the file name being used.
			  '
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.FileName
			  
			  Dim mb As MemoryBlock = Struct.ShowFileName
			  If mb <> Nil Then Return mb.CString(0)
			End Get
		#tag EndGetter
		FileName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the flags for the form element.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.Flags
			  
			  Return Struct.Flags
			End Get
		#tag EndGetter
		Flags As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mContentHeaders As libcURL.ListPtr
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the element contains several file parts then this property returns the first extra file. Use the
			  ' NextElement property of the returned MultipartFormElement to iterate over the file list.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.MoreFiles
			  
			  Dim p As Ptr = Struct.MoreFiles
			  If p = Nil Then Return Nil
			  Return New MultipartFormElement(p, mOwner)
			End Get
		#tag EndGetter
		MoreFiles As libcURL.MultipartFormElement
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mOwner As libcURL.MultipartForm
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStruct As Ptr
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the name of the form element.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.Name
			  
			  Dim mb As MemoryBlock = Struct.Name
			  If mb <> Nil Then Return mb.StringValue(0, Struct.NameLen)
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Form elements are stored as a linked list. This property allows you to traverse the list from first to last.
			  ' The last element will have Nil as its NextElement.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.NextElement
			  
			  Dim p As Ptr = Struct.NextItem
			  If p <> Nil Then Return New MultipartFormElement(p, mOwner)
			End Get
		#tag EndGetter
		NextElement As libcURL.MultipartFormElement
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a reference to the Readable object from which the form element contents will be read when
			  ' the form is actually posted to a server. If the element Type is not FormElementType.Stream then
			  ' this will be Nil.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.Stream
			  
			  If Struct.UserData <> Nil Then Return FormStreamGetter(mOwner).GetStream(Struct.UserData)
			End Get
		#tag EndGetter
		Stream As Readable
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If mStruct <> Nil Then Return mStruct.curl_httppost
			End Get
		#tag EndGetter
		Protected Struct As curl_httppost
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a member of the FormElementType enum.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartFormElement.Type
			  
			  Select Case True
			  Case Struct.Buffer <> Nil
			    Return FormElementType.MemoryBlock
			    
			  Case Struct.UserData <> Nil
			    Return FormElementType.Stream
			    
			  Case Struct.ShowFileName <> Nil, Struct.MoreFiles <> Nil
			    Return FormElementType.File
			    
			  Else
			    Return FormElementType.String
			    
			  End Select
			End Get
		#tag EndGetter
		Type As libcURL.FormElementType
	#tag EndComputedProperty


	#tag Constant, Name = CURL_HTTPPOST_BUFFER, Type = Double, Dynamic = False, Default = \"16", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_HTTPPOST_CALLBACK, Type = Double, Dynamic = False, Default = \"64", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_HTTPPOST_FILENAME, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_HTTPPOST_LARGE, Type = Double, Dynamic = False, Default = \"128", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_HTTPPOST_PTRBUFFER, Type = Double, Dynamic = False, Default = \"32", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_HTTPPOST_PTRCONTENTS, Type = Double, Dynamic = False, Default = \"8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_HTTPPOST_PTRNAME, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURL_HTTPPOST_READFILE, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="BufferSize"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContentLen"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Contents"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContentType"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FileName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Flags"
			Group="Behavior"
			Type="Integer"
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
