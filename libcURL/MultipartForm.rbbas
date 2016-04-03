#tag Class
Protected Class MultipartForm
Inherits libcURL.cURLHandle
	#tag Method, Flags = &h0
		Function AddElement(Name As String, Value As FolderItem, ContentType As String = "") As Boolean
		  ' Adds the passed file to the form using the specified name.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_formadd.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.AddElement
		  
		  If Value.Exists And Not Value.Directory Then
		    If ContentType <> "" Then
		      mLastError = curl_formadd(FirstItem, LastItem, CURLFORM_COPYNAME, Name, CURLFORM_FILE, Value.ShellPath, CURLFORM_FILENAME, Value.Name, CURLFORM_CONTENTTYPE, ContentType, CURLFORM_END)
		    Else
		      mLastError = curl_formadd(FirstItem, LastItem, CURLFORM_COPYNAME, Name, CURLFORM_FILE, Value.ShellPath, CURLFORM_FILENAME, Value.Name, CURLFORM_END)
		    End If
		    Return mLastError = 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddElement(Name As String, Value As String) As Boolean
		  ' Adds the passed Value to the form using the specified name.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_formadd.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.AddElement
		  
		  mLastError = curl_formadd(FirstItem, LastItem, CURLFORM_COPYNAME, Name, CURLFORM_COPYCONTENTS, Value, CURLFORM_END)
		  Return mLastError = 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GlobalInitFlags As Integer = libcURL.CURL_GLOBAL_DEFAULT)
		  // Calling the overridden superclass constructor.
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(GlobalInitFlags)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If libcURL.IsAvailable And FirstItem <> Nil Then libcURL.curl_formfree(FirstItem)
		  FirstItem = Nil
		  LastItem = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FormGetCallback(UserData As Integer, Buffer As Ptr, Length As Integer) As Integer
		  #pragma X86CallingConvention CDecl
		  
		  Dim bs As BinaryStream = Instances.Lookup(UserData, Nil)
		  If bs <> Nil Then
		    Dim mb As MemoryBlock = Buffer
		    bs.Write(mb.StringValue(0, Length))
		    Return Length
		  End If
		  
		  Break ' UserData does not refer to a valid stream!
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Handle() As Integer
		  ' This method returns a Ptr to the form structure which can be passed back to libcURL
		  Return Integer(FirstItem)
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
		Sub Operator_Convert(FromDict As Dictionary)
		  ' Overloads the conversion operator(=), permitting implicit and explicit conversion from a Dictionary
		  ' into a MultipartForm. The dictionary contains NAME:VALUE pairs comprising HTML form elements: NAME
		  ' is a string containing the form-element name; VALUE may be a string or a FolderItem.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultipartForm.Operator_Convert
		  
		  If mLastError = libcURL.Errors.NOT_INITIALIZED Then
		    Me.Constructor()
		  Else
		    Me.Destructor() ' free the previous form data
		  End If
		  If FromDict = Nil Then Raise New NilObjectException
		  For Each item As String In FromDict.Keys
		    Dim value As Variant = FromDict.Value(item)
		    If VarType(value) = Variant.TypeString Then
		      If Not Me.AddElement(item, value.StringValue) Then Raise New cURLException(Me)
		      
		    ElseIf VarType(value) = Variant.TypeObject And value IsA FolderItem Then
		      If Not Me.AddElement(item, FolderItem(value)) Then Raise New cURLException(Me)
		      
		    Else
		      Raise New UnsupportedFormatException
		    End If
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
		  
		  If FirstItem = Nil Then Return ""
		  If Not libcURL.Version.IsAtLeast(7, 15, 5) Then
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(Me)
		  End If
		  
		  Dim mb As New MemoryBlock(0)
		  Dim formstream As New BinaryStream(mb)
		  If Instances = Nil Then Instances = New Dictionary
		  Instances.Value(Me.Handle) = formstream
		  mLastError = curl_formget(FirstItem, Me.Handle, AddressOf FormGetCallback)
		  Instances.Remove(Me.Handle)
		  formstream.Close
		  If mLastError <> 0 Then Raise New cURLException(Me)
		  Return mb
		End Function
	#tag EndMethod


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


	#tag Property, Flags = &h1
		Protected FirstItem As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared Instances As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected LastItem As Ptr
	#tag EndProperty


	#tag Constant, Name = CURLFORM_CONTENTTYPE, Type = Double, Dynamic = False, Default = \"14", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLFORM_COPYCONTENTS, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLFORM_COPYNAME, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLFORM_END, Type = Double, Dynamic = False, Default = \"17", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLFORM_FILE, Type = Double, Dynamic = False, Default = \"10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLFORM_FILECONTENT, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLFORM_FILENAME, Type = Double, Dynamic = False, Default = \"16", Scope = Protected
	#tag EndConstant


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
