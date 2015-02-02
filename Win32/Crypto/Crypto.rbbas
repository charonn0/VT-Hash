#tag Module
Protected Module Crypto
	#tag Method, Flags = &h1
		Protected Function BinaryToString(Data As MemoryBlock, Flags As Integer) As String
		  ' See: http://msdn.microsoft.com/en-us/library/windows/desktop/aa379887%28v=vs.85%29.aspx
		  
		  Dim sz As Integer
		  Call Win32.Libs.Crypt32.CryptBinaryToString(Data, Data.Size, Flags, Nil, sz)
		  Dim output As New MemoryBlock(sz * 2)
		  If Not Win32.Libs.Crypt32.CryptBinaryToString(Data, Data.Size, Flags, output, sz) Then
		    sz = Win32.LastError
		    Dim err As New Win32Exception
		    err.ErrorNumber = sz
		    err.Message = Win32.FormatError(sz)
		    Raise err
		  End If
		  Return output.WString(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeBase64(Data As MemoryBlock) As String
		  Return BinaryToString(Data, CRYPT_STRING_BASE64)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeHex(Data As MemoryBlock) As String
		  If Win32.KernelVersion >= 6.0 Then
		    Return BinaryToString(Data, CRYPT_STRING_HEXRAW)
		  Else
		    #If RBVersion >= 2010.03 Then
		      Return REALbasic.EncodeHex(Data)
		    #Else
		      Dim formattedhex As String = BinaryToString(Data, CRYPT_STRING_HEX) ' CRYPT_STRING_HEX has extra formatting chars we need to strip
		      formattedhex = ConvertEncoding(formattedhex, Encodings.ASCII)
		      For i As Integer = 0 To 122
		        If i = 48 Then i = 58
		        If i = 65 Then i = 91
		        If i = 97 Then i = 123
		        formattedhex = ReplaceAll(formattedhex, Chr(i), "")
		      Next
		      Return formattedhex.Trim
		    #endif
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MD2(Data As MemoryBlock) As String
		  Return ProcessHash(Data, CALG_MD2)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MD4(Data As MemoryBlock) As String
		  Return ProcessHash(Data, CALG_MD4)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MD5(Data As MemoryBlock) As String
		  Return ProcessHash(Data, CALG_MD5)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MS_ENH_RSA_AES_PROV() As String
		  If KernelVersion < 6.0 Then ' XP used a different name
		    Return "Microsoft Enhanced RSA and AES Cryptographic Provider (Prototype)"
		  Else
		    Return "Microsoft Enhanced RSA and AES Cryptographic Provider"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ProcessHash(Data As MemoryBlock, Algorithm As Integer) As String
		  Dim h As New HashProcessor(Algorithm)
		  Dim bs As New BinaryStream(Data)
		  While Not bs.EOF
		    h.Process(bs.Read(1024 *4))
		  Wend
		  bs.Close
		  Return h.Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SHA1(Data As MemoryBlock) As String
		  Return ProcessHash(Data, CALG_SHA1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SHA256(Data As MemoryBlock) As String
		  Return ProcessHash(Data, CALG_SHA256)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SHA384(Data As MemoryBlock) As String
		  Return ProcessHash(Data, CALG_SHA384)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SHA512(Data As MemoryBlock) As String
		  Return ProcessHash(Data, CALG_SHA512)
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  ' See: http://msdn.microsoft.com/en-us/library/windows/desktop/aa386979%28v=vs.85%29.aspx
			  
			  If mAESProvider = Nil Then
			    mAESProvider = New Win32.Crypto.Context(MS_ENH_RSA_AES_PROV, PROV_RSA_AES)
			  End If
			  Return mAESProvider
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mAESProvider = value
			End Set
		#tag EndSetter
		Protected AESProvider As Win32.Crypto.Context
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  'See: http://msdn.microsoft.com/en-us/library/windows/desktop/aa386980%28v=vs.85%29.aspx
			  
			  If mBaseProvider = Nil Then
			    mBaseProvider = New Win32.Crypto.Context(MS_DEF_PROV, PROV_RSA_FULL)
			  End If
			  Return mBaseProvider
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mBaseProvider = value
			End Set
		#tag EndSetter
		Protected BaseProvider As Win32.Crypto.Context
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  ' For diffie-hellman key exchanges
			  ' See: http://msdn.microsoft.com/en-us/library/windows/desktop/bb394802%28v=vs.85%29.aspx
			  
			  If mDHProvider = Nil Then
			    mDHProvider = New Win32.Crypto.Context(MS_ENH_DSS_DH_PROV, PROV_DSS_DH)
			  End If
			  Return mDHProvider
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDHProvider = value
			End Set
		#tag EndSetter
		Protected DHProvider As Win32.Crypto.Context
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  ' See: http://msdn.microsoft.com/en-us/library/windows/desktop/aa386986%28v=vs.85%29.aspx
			  
			  If mEnhancedProvider = Nil Then
			    mEnhancedProvider = New Win32.Crypto.Context(MS_ENHANCED_PROV, PROV_RSA_FULL)
			  End If
			  Return mEnhancedProvider
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mEnhancedProvider = value
			End Set
		#tag EndSetter
		Protected EnhancedProvider As Win32.Crypto.Context
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAESProvider As Win32.Crypto.Context
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBaseProvider As Win32.Crypto.Context
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDHProvider As Win32.Crypto.Context
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnhancedProvider As Win32.Crypto.Context
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStrongProvider As Win32.Crypto.Context
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  ' See: http://msdn.microsoft.com/en-us/library/windows/desktop/aa386989%28v=vs.85%29.aspx
			  
			  If mStrongProvider = Nil Then
			    mStrongProvider = New Win32.Crypto.Context(MS_STRONG_PROV, PROV_RSA_FULL)
			  End If
			  Return mStrongProvider
			End Get
		#tag EndGetter
		Protected StrongProvider As Win32.Crypto.Context
	#tag EndComputedProperty


	#tag Constant, Name = CALG_3DES, Type = Double, Dynamic = False, Default = \"&h00006603", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_3DES_112, Type = Double, Dynamic = False, Default = \"&h00006609", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_AES, Type = Double, Dynamic = False, Default = \"&h00006611", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_AES128, Type = Double, Dynamic = False, Default = \"&h0000660e", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_AES192, Type = Double, Dynamic = False, Default = \"&h0000660f", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_AES256, Type = Double, Dynamic = False, Default = \"&h00006610", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_AES_128, Type = Double, Dynamic = False, Default = \"&h0000660e", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_AES_192, Type = Double, Dynamic = False, Default = \"&h0000660f", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_AES_256, Type = Double, Dynamic = False, Default = \"&h00006610", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_DES, Type = Double, Dynamic = False, Default = \"&h00006601", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_HMAC, Type = Double, Dynamic = False, Default = \"&h00008009", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_MAC, Type = Double, Dynamic = False, Default = \"&h00008005", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_MD2, Type = Double, Dynamic = False, Default = \"&h00008001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_MD4, Type = Double, Dynamic = False, Default = \"&h00008002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_MD5, Type = Double, Dynamic = False, Default = \"&h00008003", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_RC2, Type = Double, Dynamic = False, Default = \"&h000065FF", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_RC4, Type = Double, Dynamic = False, Default = \"&h00006801", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_RSA_KEYX, Type = Double, Dynamic = False, Default = \"&h0000a400", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_RSA_SIGN, Type = Double, Dynamic = False, Default = \"&h00002400", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA1, Type = Double, Dynamic = False, Default = \"&h00008004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA256, Type = Double, Dynamic = False, Default = \"&h0000800c", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA384, Type = Double, Dynamic = False, Default = \"&h0000800d", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA512, Type = Double, Dynamic = False, Default = \"&h0000800e", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_CREATE_SALT, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_EXPORTABLE, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_NEWKEYSET, Type = Double, Dynamic = False, Default = \"&h00000008\r", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_NO_SALT, Type = Double, Dynamic = False, Default = \"&h10", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_SERVER, Type = Double, Dynamic = False, Default = \"1024", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_STRING_BASE64, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_STRING_BASE64HEADER, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_STRING_BASE64REQUESTHEADER, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_STRING_BASE64X509CRLHEADER, Type = Double, Dynamic = False, Default = \"9", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_STRING_BINARY, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_STRING_HEX, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_STRING_HEXADDR, Type = Double, Dynamic = False, Default = \"&h0a", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_STRING_HEXASCII, Type = Double, Dynamic = False, Default = \"5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_STRING_HEXASCIIADDR, Type = Double, Dynamic = False, Default = \"&h0B", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_STRING_HEXRAW, Type = Double, Dynamic = False, Default = \"&h0C", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_STRING_STRICT, Type = Double, Dynamic = False, Default = \"&h20000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_UPDATE_KEY, Type = Double, Dynamic = False, Default = \"&h00000008", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MS_DEF_DH_SCHANNEL_PROV, Type = String, Dynamic = False, Default = \"Microsoft DH Schannel Cryptographic Provider", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MS_DEF_DSS_DH_PROV, Type = String, Dynamic = False, Default = \"Microsoft Base DSS and Diffie-Hellman Cryptographic Provider", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MS_DEF_DSS_PROV, Type = String, Dynamic = False, Default = \"Microsoft Base DSS Cryptographic Provider", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MS_DEF_PROV, Type = String, Dynamic = False, Default = \"Microsoft Base Cryptographic Provider v1.0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MS_DEF_RSA_SCHANNEL_PROV, Type = String, Dynamic = False, Default = \"Microsoft RSA Schannel Cryptographic Provider", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MS_ENHANCED_PROV, Type = String, Dynamic = False, Default = \"Microsoft Enhanced Cryptographic Provider v1.0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MS_ENH_DSS_DH_PROV, Type = String, Dynamic = False, Default = \"Microsoft Enhanced DSS and Diffie-Hellman Cryptographic Provider", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MS_SCARD_PROV, Type = String, Dynamic = False, Default = \"Microsoft Base Smart Card Crypto Provider", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MS_STRONG_PROV, Type = String, Dynamic = False, Default = \"Microsoft Strong Cryptographic Provider", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NTE_BAD_KEYSET, Type = Double, Dynamic = False, Default = \"&h80090016", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PROV_DSS, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PROV_DSS_DH, Type = Double, Dynamic = False, Default = \"13", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PROV_RSA_AES, Type = Double, Dynamic = False, Default = \"24", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PROV_RSA_FULL, Type = Double, Dynamic = False, Default = \"1", Scope = Private
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
End Module
#tag EndModule
