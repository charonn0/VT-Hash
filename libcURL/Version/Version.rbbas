#tag Module
Protected Module Version
	#tag Method, Flags = &h1
		Protected Function IsAtLeast(Major As Integer, Minor As Integer, Patch As Integer) As Boolean
		  ' Returns True if libcURL is available and at least the version specified.
		  
		  Static min, maj, pat As Integer
		  Static avail As Boolean = System.IsFunctionAvailable("curl_global_init", cURLLib)
		  If Not avail Then Return False
		  If maj = 0 Then
		    Dim n As String = UserAgent()
		    maj = Val(NthField(NthField(NthField(n, " ", 1), "/", 2), ".", 1))
		    min = Val(NthField(NthField(NthField(n, " ", 1), "/", 2), ".", 2))
		    pat = Val(NthField(NthField(NthField(n, " ", 1), "/", 2), ".", 3))
		  End If
		  
		  Return maj > Major Or (maj = Major And (min > Minor Or (min = Minor And pat >= Patch)))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsExactly(Major As Integer, Minor As Integer, Patch As Integer) As Boolean
		  ' Returns True if libcURL is available and exactly the version specified.
		  
		  Static min, maj, pat As Integer
		  Static avail As Boolean = System.IsFunctionAvailable("curl_global_init", cURLLib)
		  If Not avail Then Return False
		  If maj = 0 Then
		    Dim n As String = UserAgent()
		    maj = Val(NthField(NthField(NthField(n, " ", 1), "/", 2), ".", 1))
		    min = Val(NthField(NthField(NthField(n, " ", 1), "/", 2), ".", 2))
		    pat = Val(NthField(NthField(NthField(n, " ", 1), "/", 2), ".", 3))
		  End If
		  
		  Return maj = Major And min = Minor And pat = Patch
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsProtocolAvailable(ParamArray Schemes() As String) As Boolean
		  ' Returns True if libcURL is available and supports the protocol specified by the Scheme (e.g. "https", "ftp")
		  
		  Dim s() As String = Protocols()
		  If HTTP2 Then s.Append("http2")
		  For Each p As String In Schemes
		    If s.IndexOf(p.Lowercase) = -1 Then Return False
		  Next
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Platform() As String
		  #If Target32Bit Then
		    Dim data As MemoryBlock = Struct.HostString
		  #Else
		    Dim data As MemoryBlock = Struct64.HostString
		  #EndIf
		  If data <> Nil Then Return data.CString(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Protocols() As String()
		  ' Returns an array of available protocols.
		  
		  Dim prots() As String
		  #If Target32Bit Then
		    Dim lst As Ptr = Struct.Protocols
		  #Else
		    Dim lst As Ptr = Struct64.Protocols
		  #EndIf
		  
		  If lst = Nil Then Return prots
		  
		  Dim i As Integer
		  Dim item As Ptr = lst.Ptr(0)
		  Do Until item = Nil
		    Dim mb As MemoryBlock = item
		    prots.Append(mb.CString(0))
		    i = i + 1
		    #If Target32Bit Then
		      item = lst.Ptr(i * 4)
		    #Else
		      item = lst.Ptr(i * 8)
		    #EndIf
		    
		  Loop
		  
		  Return prots
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SSHProviderName() As String
		  #If Target32Bit Then
		    Dim data As MemoryBlock = Struct.libSSHVersion
		  #Else
		    Dim data As MemoryBlock = Struct64.libSSHVersion
		  #EndIf
		  
		  If data <> Nil Then Return data.CString(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SSLProviderName() As String
		  #If Target32Bit Then
		    Dim data As MemoryBlock = Struct.SSLVersionString
		  #Else
		    Dim data As MemoryBlock = Struct64.SSLVersionString
		  #EndIf
		  
		  If data <> Nil Then Return data.CString(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UserAgent() As String
		  If Not System.IsFunctionAvailable("curl_version", cURLLib) Then Return ""
		  Static p As MemoryBlock
		  If p = Nil Then
		    p = curl_version()
		  End If
		  Return p.CString(0)
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  ' See: https://curl.haxx.se/libcurl/c/curl_version_info.html#CURLVERSIONASYNCHDNS
			  
			  Return BitAnd(Features, FEATURE_ASYNCHDNS) = FEATURE_ASYNCHDNS  // asynchronous dns resolves
			End Get
		#tag EndGetter
		Protected ASYNCHDNS As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_CONV) = FEATURE_CONV // character conversions are supported
			End Get
		#tag EndGetter
		Protected CONV As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_CURLDEBUG) = FEATURE_CURLDEBUG // built with memory tracking debug capabilities
			End Get
		#tag EndGetter
		Protected CURLDEBUG As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_DEBUG) = FEATURE_DEBUG // built with debug capabilities
			End Get
		#tag EndGetter
		Protected DEBUG As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  #If Target32Bit Then
			    Return Struct.Features
			  #Else
			    Return Struct64.Features
			  #EndIf
			  
			End Get
		#tag EndGetter
		Private Features As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_GSSNEGOTIATE) = FEATURE_GSSNEGOTIATE // Negotiate auth support
			End Get
		#tag EndGetter
		Protected GSSNEGOTIATE As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_HTTP2) = FEATURE_HTTP2 // HTTP2.0 support
			End Get
		#tag EndGetter
		Protected HTTP2 As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_IDN) = FEATURE_IDN // International Domain Names support
			End Get
		#tag EndGetter
		Protected IDN As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_IPV6) = FEATURE_IPV6 // IPv6-enabled
			End Get
		#tag EndGetter
		Protected IPV6 As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_KERBEROS4) = FEATURE_KERBEROS4 // kerberos 4 auth is supported
			End Get
		#tag EndGetter
		Protected KERBEROS4 As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_KERBEROS5) = FEATURE_KERBEROS5 // kerberos 5 auth is supported
			End Get
		#tag EndGetter
		Protected KERBEROS5 As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_LARGEFILE) = FEATURE_LARGEFILE // supports files bigger than 2GB
			End Get
		#tag EndGetter
		Protected LARGEFILE As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_NTLM) = FEATURE_NTLM // NTLM auth is supported
			End Get
		#tag EndGetter
		Protected NTLM As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_SPNEGO) = FEATURE_SPNEGO // SPNEGO auth
			End Get
		#tag EndGetter
		Protected SPNEGO As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_SSL) = FEATURE_SSL // SSL options are present
			End Get
		#tag EndGetter
		Protected SSL As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Dim kSSPI As Integer = ShiftLeft(1, 11)
			  Return BitAnd(Features, kSSPI) = kSSPI // SSPI is supported
			End Get
		#tag EndGetter
		Protected SSPI As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Static mStruct As CURLVersion
			  Static init As Boolean
			  If Not init And System.IsFunctionAvailable("curl_version_info", cURLLib) Then
			    Dim error As Integer = curl_global_init(CURL_GLOBAL_DEFAULT) ' do not try to replace with cURLHandle, which performs version checks
			    If error = 0 Then
			      init = True
			      Dim ve As Ptr = curl_version_info(CURLVERSION_FOURTH)
			      Try
			        mStruct = ve.CURLVersion
			      Catch err
			        If err.Message = "" Then err.Message = "Unable to read libcURL version information."
			        Raise err
			      Finally
			        curl_global_cleanup()
			      End Try
			    Else
			      Dim err As New cURLException(Nil)
			      err.ErrorNumber = error
			      err.Message = libcURL.FormatError(error)
			      Raise err
			    End If
			  End If
			  If init Then Return mStruct
			End Get
		#tag EndGetter
		Private Struct As CURLVersion
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Static mStruct As CURLVersion64
			  Static init As Boolean
			  If Not init And System.IsFunctionAvailable("curl_version_info", cURLLib) Then
			    Dim error As Integer = curl_global_init(CURL_GLOBAL_DEFAULT) ' do not try to replace with cURLHandle, which performs version checks
			    If error = 0 Then
			      init = True
			      Dim ve As Ptr = curl_version_info(CURLVERSION_FOURTH)
			      Try
			        mStruct = ve.CURLVersion64
			      Catch err
			        If err.Message = "" Then err.Message = "Unable to read libcURL version information."
			        Raise err
			      Finally
			        curl_global_cleanup()
			      End Try
			    Else
			      Dim err As New cURLException(Nil)
			      err.ErrorNumber = error
			      err.Message = libcURL.FormatError(error)
			      Raise err
			    End If
			  End If
			  If init Then Return mStruct
			End Get
		#tag EndGetter
		Private Struct64 As CURLVersion64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return BitAnd(Features, FEATURE_TLSAUTH_SRP) = FEATURE_TLSAUTH_SRP // TLS-SRP support
			End Get
		#tag EndGetter
		Protected TLS_SRP As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = CURLVERSION_FOURTH, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_ASYNCHDNS, Type = Double, Dynamic = False, Default = \"128", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_CONV, Type = Double, Dynamic = False, Default = \"4096", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_CURLDEBUG, Type = Double, Dynamic = False, Default = \"8192", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_DEBUG, Type = Double, Dynamic = False, Default = \"64", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_GSSNEGOTIATE, Type = Double, Dynamic = False, Default = \"32", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_HTTP2, Type = Double, Dynamic = False, Default = \"65536", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_IDN, Type = Double, Dynamic = False, Default = \"1024", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_IPV6, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_KERBEROS4, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_KERBEROS5, Type = Double, Dynamic = False, Default = \"262144", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_LARGEFILE, Type = Double, Dynamic = False, Default = \"512", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_NTLM, Type = Double, Dynamic = False, Default = \"16", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_SPNEGO, Type = Double, Dynamic = False, Default = \"256", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_SSL, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = FEATURE_TLSAUTH_SRP, Type = Double, Dynamic = False, Default = \"16384", Scope = Private
	#tag EndConstant


	#tag Structure, Name = CURLVersion, Flags = &h21, Attributes = \"StructureAlignment \x3D 1"
		Age As Integer
		  VersionString As Ptr
		  VersionNumber As UInt32
		  HostString As Ptr
		  Features As Integer
		  SSLVersionString As Ptr
		  SSLVersionNumber As Integer
		  libzVersion As Ptr
		  Protocols As Ptr
		  ares As Ptr
		  aresnum As Integer
		  libidn As Ptr
		  iconvVersion as Integer
		libSSHVersion As Ptr
	#tag EndStructure

	#tag Structure, Name = CURLVersion64, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
		Age As Integer
		  VersionString As Ptr
		  VersionNumber As UInt32
		  HostString As Ptr
		  Features As Integer
		  SSLVersionString As Ptr
		  SSLVersionNumber As Integer
		  libzVersion As Ptr
		  Protocols As Ptr
		  ares As Ptr
		  aresnum As Integer
		  libidn As Ptr
		  iconvVersion as Integer
		libSSHVersion As Ptr
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
End Module
#tag EndModule
