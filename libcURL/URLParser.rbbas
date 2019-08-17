#tag Class
Protected Class URLParser
Inherits libcURL.cURLHandle
	#tag Method, Flags = &h0
		Sub AppendArgument(Name As String, Value As String)
		  ' Appends an argument to the list of arguments
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_url_set.html#CURLUPARTQUERY
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.AppendArgument
		  
		  If Value <> "" Then Name = Name + "=" + Value
		  Call Me.SetPartContent(URLPart.Query, Name, CURLU_APPENDQUERY Or CURLU_URLENCODE)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(CopyURL As libcURL.URLParser)
		  ' Constructs a URLParser by duplicating the CopyURL.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_url_dup.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(CopyURL.Flags)
		  Me.AnyScheme = CopyURL.AnyScheme
		  
		  mHandle = curl_url_dup(CopyURL.Handle)
		  If mHandle = 0 Then
		    mLastError = libcURL.Errors.INIT_FAILED
		    Raise New cURLException(Me)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(InitialURL As String = "", GlobalInitFlags As Integer = libcURL.CURL_GLOBAL_DEFAULT)
		  ' Constructs a URLParser, optionally initializing it to the InitialURL parameter.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_url.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(GlobalInitFlags)
		  
		  If Not URLParser.IsAvailable Then
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(Me)
		  End If
		  
		  mHandle = curl_url()
		  If mHandle = 0 Then
		    mLastError = libcURL.Errors.INIT_FAILED
		    Raise New cURLException(Me)
		  End If
		  
		  If InitialURL <> "" Then Me.StringValue = InitialURL
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If mHandle <> 0 Then curl_url_cleanup(mHandle)
		  mHandle = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetPartContent(Part As libcURL.URLPart, Flags As Integer) As String
		  ' Returns the specified URL part. Flags may be zero or more of the following constants:
		  ' CURLU_DEFAULT_PORT, CURLU_DEFAULT_SCHEME, CURLU_NO_DEFAULT_PORT, CURLU_URLDECODE
		  ' Refer to the libcurl documentation linked below for a description of these flags.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_url_get.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.GetPartContent
		  
		  Dim contents As Ptr
		  Dim ret As String
		  mLastError = curl_url_get(mHandle, Part, contents, Flags)
		  If contents <> Nil Then
		    Try
		      Dim mb As MemoryBlock = contents
		      ret = mb.CString(0)
		    Finally
		      curl_free(contents)
		    End Try
		  End If
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function IsAvailable() As Boolean
		  Static avail As Boolean
		  If Not avail Then avail = libcURL.Version.IsAtLeast(7, 62, 0)
		  Return avail
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherURL As libcURL.URLParser) As Integer
		  ' Overloads the comparison operator(=), permitting direct comparisons between references to URLParser.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Operator_Compare
		  
		  Dim i As Integer = Super.Operator_Compare(OtherURL)
		  If i = 0 Then i = Sign(mHandle - OtherURL.Handle)
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherURL As String) As Integer
		  ' Overloads the comparison operator(=), permitting comparisons between a URLParser and a String
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Operator_Compare
		  
		  Dim s As String = Me.StringValue()
		  Return StrComp(s, OtherURL, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetPartContent(Part As libcURL.URLPart, Contents As String, Flags As Integer) As Boolean
		  ' Sets the specified URL part. Flags may be zero or more of the following constants:
		  ' CURLU_NON_SUPPORT_SCHEME, CURLU_URLENCODE, CURLU_DEFAULT_SCHEME, CURLU_GUESS_SCHEME
		  ' Refer to the libcurl documentation linked below for a description of these flags.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_url_set.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.SetPartContent
		  
		  
		  If Contents <> "" Then
		    Dim data As MemoryBlock = Contents + Chr(0)
		    mLastError = curl_url_set(mHandle, Part, data, Flags)
		  Else
		    mLastError = curl_url_set(mHandle, Part, Nil, Flags)
		  End If
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As String
		  ' Returns the full URL string.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_url_get.html#CURLUPARTURL
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.StringValue
		  
		  Return Me.GetPartContent(URLPart.All, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StringValue(Assigns FromString As String)
		  ' Set the full URL from a string.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_url_set.html#CURLUPARTURL
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.StringValue
		  
		  Dim flag As Integer
		  If AnyScheme Then flag = CURLU_NON_SUPPORT_SCHEME
		  If InStr(FromString, "://") = 0 Then FromString = "http://" + FromString ' assume HTTP
		  Call Me.SetPartContent(URLPart.All, FromString, flag)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		AnyScheme As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the arguments as a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_get.html#CURLUPARTQUERY
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Arguments
			  
			  Return Me.GetPartContent(URLPart.Query, CURLU_URLDECODE)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the arguments from a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_set.html#CURLUPARTQUERY
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Arguments
			  
			  If Not Me.SetPartContent(URLPart.Query, value, 0) Then Raise New cURLException(Me)
			End Set
		#tag EndSetter
		Arguments As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the fragment as a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_get.html#CURLUPARTFRAGMENT
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Fragment
			  
			  Return Me.GetPartContent(URLPart.Fragment, CURLU_URLDECODE)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the fragment from a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_set.html#CURLUPARTFRAGMENT
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Fragment
			  
			  If Not Me.SetPartContent(URLPart.Fragment, value, CURLU_URLENCODE) Then Raise New cURLException(Me)
			End Set
		#tag EndSetter
		Fragment As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the hostname or IP address as a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_get.html#CURLUPARTHOST
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Hostname
			  
			  Return Me.GetPartContent(URLPart.Host, CURLU_URLDECODE)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the hostname or IP address from a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_set.html#CURLUPARTHOST
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Hostname
			  
			  If Not Me.SetPartContent(URLPart.Host, value, CURLU_URLENCODE) Then Raise New cURLException(Me)
			End Set
		#tag EndSetter
		Hostname As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the password as a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_get.html#CURLUPARTPASSWORD
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Password
			  
			  Return Me.GetPartContent(URLPart.Password, CURLU_URLDECODE)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the password from a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_set.html#CURLUPARTPASSWORD
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Password
			  
			  If Not Me.SetPartContent(URLPart.Password, value, CURLU_URLENCODE) Then Raise New cURLException(Me)
			End Set
		#tag EndSetter
		Password As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the path as a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_get.html#CURLUPARTPATH
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Path
			  
			  Return Me.GetPartContent(URLPart.Path, CURLU_URLDECODE)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the path from a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_set.html#CURLUPARTPATH
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Path
			  
			  If Not Me.SetPartContent(URLPart.Path, value, 0) Then Raise New cURLException(Me)
			End Set
		#tag EndSetter
		Path As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the port. Returns zero if not specified.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_get.html#CURLUPARTPORT
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Port
			  
			  Return Val(Me.GetPartContent(URLPart.Port, CURLU_NO_DEFAULT_PORT))
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the port. Pass zero to clear/reset the default.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_set.html#CURLUPARTPORT
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Port
			  
			  
			  If value = 0 Then ' clear/reset to default
			    If Not Me.SetPartContent(URLPart.Port, "", 0) Then Raise New cURLException(Me)
			  Else
			    If Not Me.SetPartContent(URLPart.Port, Str(value, "####0"), 0) Then Raise New cURLException(Me)
			  End If
			End Set
		#tag EndSetter
		Port As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the scheme as a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_get.html#CURLUPARTSCHEME
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Scheme
			  
			  Return Me.GetPartContent(URLPart.Scheme, CURLU_DEFAULT_SCHEME)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the scheme from a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_set.html#CURLUPARTSCHEME
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Scheme
			  
			  Dim flag As Integer
			  If AnyScheme Then flag = CURLU_NON_SUPPORT_SCHEME
			  If Not Me.SetPartContent(URLPart.Scheme, value, flag) Then Raise New cURLException(Me)
			End Set
		#tag EndSetter
		Scheme As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Get the username as a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_get.html#CURLUPARTUSER
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Username
			  
			  Return Me.GetPartContent(URLPart.User, CURLU_URLDECODE)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Set the username from a string.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_url_set.html#CURLUPARTUSER
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.URLParser.Username
			  
			  If Not Me.SetPartContent(URLPart.User, value, CURLU_URLENCODE) Then Raise New cURLException(Me)
			End Set
		#tag EndSetter
		Username As String
	#tag EndComputedProperty


	#tag Constant, Name = CURLUE_BAD_HANDLE, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_BAD_PARTPOINTER, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_BAD_PORT_NUMBER, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_MALFORMED_INPUT, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_NO_FRAGMENT, Type = Double, Dynamic = False, Default = \"18", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_NO_HOST, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_NO_OPTIONS, Type = Double, Dynamic = False, Default = \"13", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_NO_PASSWORD, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_NO_PATH, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_NO_PORT, Type = Double, Dynamic = False, Default = \"15", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_NO_QUERY, Type = Double, Dynamic = False, Default = \"17", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_NO_SCHEME, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_NO_USER, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_OUT_OF_MEMORY, Type = Double, Dynamic = False, Default = \"19", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_RELATIVE, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_UNKNOWN_PART, Type = Double, Dynamic = False, Default = \"9", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_UNSUPPORTED_SCHEME, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_URLDECODE, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLUE_USER_NOT_ALLOWED, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLU_APPENDQUERY, Type = Double, Dynamic = False, Default = \"256", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLU_DEFAULT_PORT, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLU_DEFAULT_SCHEME, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLU_DISALLOW_USER, Type = Double, Dynamic = False, Default = \"32", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLU_NON_SUPPORT_SCHEME, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLU_NO_DEFAULT_PORT, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLU_PATH_AS_IS, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLU_URLDECODE, Type = Double, Dynamic = False, Default = \"64", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CURLU_URLENCODE, Type = Double, Dynamic = False, Default = \"128", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="AnyScheme"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Arguments"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Fragment"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hostname"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Password"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Path"
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
			Name="Scheme"
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
	#tag EndViewBehavior
End Class
#tag EndClass
