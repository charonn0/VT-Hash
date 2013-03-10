#tag Module
Protected Module Win32Crypto
	#tag Method, Flags = &h0
		Function Hash(data As String, algorithm As Integer) As String
		  //Hashes the data string using the specified hash algorithm (see the constants for this Module for available algorithms.)
		  //Returns a hex-formatted string of the binary hash
		  
		  Dim hashHandle As Integer
		  Dim hashPtr As MemoryBlock
		  'Select Case algorithm
		  'Case CALG_SHA256
		  'hashPtr = HashData(RSAProvider, data, hashHandle, algorithm)
		  'Else
		  hashPtr = HashData(baseCryptoProvider, data, hashHandle, algorithm)
		  'End Select
		  If hashPtr = Nil Then Return ""
		  Dim ret As String = StringToHex(hashPtr.StringValue(0, hashPtr.Size))
		  CryptDestroyHash(hashHandle)
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HashData(provider as Integer, data as String, ByRef handle as Integer, algorithm As Integer) As MemoryBlock
		  Dim hashHandle as Integer
		  Dim xxx As UInt64
		  If Not CryptCreateHash(provider, algorithm, 0, 0, hashHandle) Then
		    xxx = GetLastError
		    Break
		    Return Nil
		  End If
		  Dim dataPtr As New MemoryBlock(Len(data))
		  dataPtr = data
		  If Not CryptHashData(hashHandle, dataPtr, dataPtr.Size, 0) Then
		    xxx = GetLastError
		    Break
		    Return Nil
		  End If
		  Dim size as Integer = 4
		  Dim toss As New MemoryBlock(4)
		  If Not CryptGetHashParam(hashHandle, HP_HASHSIZE, toss, size, 0) Then
		    xxx = GetLastError
		    Break
		    Return Nil
		  End If
		  size = toss.UInt32Value(0)
		  Dim hashValue As New MemoryBlock(size)
		  If Not CryptGetHashParam(hashHandle, HP_HASHVAL, hashValue, size, 0) Then
		    xxx = GetLastError
		    Break
		    Return Nil
		  End If
		  handle = hashHandle
		  
		  Return hashValue
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  //Returns 0 on error, positive integer on success
			  //For use with certain algorithms
			  
			  Static provider As Integer
			  
			  If provider = 0 Then
			    If Not CryptAcquireContext(provider, 0, MS_DEF_PROV + Chr(0), PROV_RSA_FULL, 0) Then
			      If Not CryptAcquireContext(provider, 0, MS_DEF_PROV + Chr(0), PROV_RSA_FULL, CRYPT_NEWKEYSET) Then
			        Return 0
			      End If
			    End If
			  end if
			  
			  Return provider
			End Get
		#tag EndGetter
		Private AESProvider As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  //Returns 0 on error, positive integer on success
			  
			  Static provider As Integer
			  Dim lasterr As Integer
			  Dim s As String
			  If provider = 0 Then
			    If Not CryptAcquireContext(provider, 0, MS_DEF_PROV, PROV_RSA_FULL, 0) Then
			      lasterr = GetLastError
			      s = Hex(lasterr)
			      Break
			      If Not CryptAcquireContext(provider, 0, MS_DEF_PROV, PROV_RSA_FULL, CRYPT_NEWKEYSET) Then
			        lasterr = GetLastError
			        s = Hex(lasterr)
			        Break
			        Return 0
			      End If
			    End If
			  end if
			  
			  Return provider
			End Get
		#tag EndGetter
		Private baseCryptoProvider As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  //Returns 0 on error, positive integer on success
			  //For use with certain algorithms
			  
			  Static provider As Integer
			  
			  If provider = 0 Then
			    If Not CryptAcquireContext(provider, 0, MS_DEF_PROV + Chr(0), PROV_RSA_FULL, 0) Then
			      If Not CryptAcquireContext(provider, 0, MS_DEF_PROV + Chr(0), PROV_RSA_FULL, CRYPT_NEWKEYSET) Then
			        Return 0
			      End If
			    End If
			  end if
			  
			  Return provider
			End Get
		#tag EndGetter
		Private RSAProvider As Integer
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

	#tag Constant, Name = CALG_RC4, Type = Double, Dynamic = False, Default = \"&h00006801", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_RC5, Type = Double, Dynamic = False, Default = \"&h0000660d", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA1, Type = Double, Dynamic = False, Default = \"&h00008004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA256, Type = Double, Dynamic = False, Default = \"&h0000800c", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA384, Type = Double, Dynamic = False, Default = \"&h0000800d", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA512, Type = Double, Dynamic = False, Default = \"&h0000800e", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kHashTypeHMAC, Type = Integer, Dynamic = False, Default = \"32777", Scope = Protected
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
