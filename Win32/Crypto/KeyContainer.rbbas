#tag Class
Protected Class KeyContainer
Inherits Win32.Crypto.Context
	#tag Method, Flags = &h0
		Function BitLength() As Integer
		  Dim mb As MemoryBlock
		  ' first call allocates a buffer big enough for the second call
		  If Me.GetKeyParam(KP_KEYLEN, mb, 0) Then ' on in mb is Nil
		    If Me.GetKeyParam(KP_KEYLEN, mb, 0) Then ' on in mb is a MemoryBlock of correct size
		      Return mb.Int32Value(0)
		    Else
		      mLastError = Win32.LastError
		    End If
		  Else
		    mLastError = Win32.LastError
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Algorithm As Integer, KeySize As Integer = 0)
		  Select Case Algorithm
		  Case CALG_3DES, CALG_3DES_112, CALG_DES, CALG_RC2, CALG_RC4, CALG_RSA_KEYX, CALG_RSA_SIGN
		    Super.Constructor(EnhancedProvider)
		  Case CALG_AES_128, CALG_AES_192, CALG_AES_256
		    Super.Constructor(AESProvider)
		  Else
		    Raise New UnsupportedFormatException
		  End Select
		  
		  Dim Flags As Integer = CRYPT_CREATE_SALT Or CRYPT_EXPORTABLE Or ShiftLeft(KeySize, 16)
		  If Not Win32.Libs.AdvApi32.CryptGenKey(Me.Provider, Algorithm, Flags, mHandle) Then mLastError = Win32.LastError
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Decrypt(InputData As MemoryBlock, FinalBlock As Boolean = True, Hashcontainer As Win32.Crypto.HashProcessor = Nil) As MemoryBlock
		  Dim sz As Integer = InputData.Size
		  Dim h As Integer
		  If Hashcontainer <> Nil Then h = Hashcontainer.Handle
		  If Not Win32.Libs.AdvApi32.CryptDecrypt(Me.Handle, h, FinalBlock, 0, InputData, sz) Then
		    mLastError = Win32.LastError
		    Dim err As New Win32Exception
		    err.ErrorNumber = mLastError
		    err.Message = Win32.FormatError(mLastError)
		    Raise err
		  End If
		  Return InputData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If Not Win32.Libs.AdvApi32.CryptDestroyKey(mHandle) Then
		    mLastError = Win32.LastError
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Encrypt(InputData As MemoryBlock, FinalBlock As Boolean = True, Hashcontainer As Win32.Crypto.HashProcessor = Nil) As MemoryBlock
		  Dim sz As Integer = InputData.Size
		  Dim h As Integer
		  If Hashcontainer <> Nil Then h = Hashcontainer.Handle
		  If Not Win32.Libs.AdvApi32.CryptEncrypt(Me.Handle, h, FinalBlock, 0, InputData, sz, InputData.Size) Then
		    mLastError = Win32.LastError
		    Dim err As New Win32Exception
		    err.ErrorNumber = mLastError
		    err.Message = Win32.FormatError(mLastError)
		    Raise err
		  End If
		  Return InputData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export(EncryptWith As Win32.Crypto.KeyContainer = Nil) As MemoryBlock
		  Dim sz, exp, blobtype As Integer
		  If EncryptWith <> Nil Then
		    exp = EncryptWith.Handle
		    blobtype = PRIVATEKEYBLOB
		  Else
		    blobtype = PLAINTEXTKEYBLOB
		  End If
		  
		  If Not Win32.Libs.AdvApi32.CryptExportKey(Me.Handle, exp, blobtype, 0, Nil, sz) Then
		    mLastError = Win32.LastError
		    Return Nil
		  End If
		  
		  Dim mb As New MemoryBlock(sz)
		  sz = mb.Size
		  
		  If Not Win32.Libs.AdvApi32.CryptExportKey(Me.Handle, exp, blobtype, 0, mb, sz) Then
		    mLastError = Win32.LastError
		    Return Nil
		  End If
		  Return mb
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetKeyParam(Type As Integer, ByRef Buffer As MemoryBlock, Flags As Integer) As Boolean
		  ' If Buffer is Nil and no error occurs, on return Buffer will be instantiated with the correct size of the data.
		  ' Call this method again with the same parameters to fill the Buffer.
		  Dim buffersz As Integer
		  Dim p As Ptr
		  If Buffer <> Nil Then
		    p = Buffer
		    buffersz = buffer.Size
		  End If
		  If Not Win32.Libs.AdvApi32.CryptGetKeyParam(mHandle, Type, p, buffersz, Flags) Then
		    mLastError = Win32.LastError
		    Return False
		  Else
		    If Buffer = Nil Then Buffer = New MemoryBlock(buffersz)
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Handle() As Integer
		  Return mHandle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Import(KeyData As MemoryBlock, Provider As Win32.Crypto.Context) As Win32.Crypto.KeyContainer
		  Dim hKey As Integer
		  If Win32.Libs.AdvApi32.CryptImportKey(Provider.Provider, KeyData, KeyData.Size, 0, 0, hKey) Then
		    ' Calling Context.Constructor instead of KeyContainer.Constructor
		    Dim key As New Win32.Crypto.KeyContainer(Provider)
		    key.mHandle = hkey
		    Return key
		  Else
		    hKey = Win32.LastError
		    Dim err As New Win32Exception
		    err.ErrorNumber = hKey
		    err.Message = Win32.FormatError(hKey)
		    Raise err
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function KeySize() As Integer
		  Dim mb As MemoryBlock
		  ' first call allocates a buffer big enough for the second call
		  If Me.GetKeyParam(KP_KEYLEN, mb, 0) Then ' on in mb is Nil
		    If Me.GetKeyParam(KP_KEYLEN, mb, 0) Then ' on in mb is a MemoryBlock of correct size
		      Return mb.Int32Value(0)
		    Else
		      mLastError = Win32.LastError
		    End If
		  Else
		    mLastError = Win32.LastError
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Permissions() As Integer
		  Dim mb As MemoryBlock
		  ' first call allocates a buffer big enough for the second call
		  If Me.GetKeyParam(KP_PERMISSIONS, mb, 0) Then ' on in mb is Nil
		    If Me.GetKeyParam(KP_PERMISSIONS, mb, 0) Then ' on in mb is a MemoryBlock of correct size
		      Return mb.Int32Value(0)
		    Else
		      mLastError = Win32.LastError
		    End If
		  Else
		    mLastError = Win32.LastError
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Permissions(Assigns NewPermissionsMask As Integer)
		  Dim mb As New MemoryBlock(4)
		  mb.Int32Value(0) = NewPermissionsMask
		  If Not Me.SetKeyParam(KP_PERMISSIONS, mb, 0) Then
		    Dim err As New Win32Exception
		    err.ErrorNumber = mLastError
		    err.Message = Win32.FormatError(mLastError)
		    Raise err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetKeyParam(Type As Integer, Buffer As MemoryBlock, Flags As Integer) As Boolean
		  If Not Win32.Libs.AdvApi32.CryptSetKeyParam(mHandle, Type, buffer, Flags) Then
		    mLastError = Win32.LastError
		    Return False
		  Else
		    Return True
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mHandle As Integer = INVALID_HANDLE_VALUE
	#tag EndProperty


	#tag Constant, Name = KP_KEYLEN, Type = Double, Dynamic = False, Default = \"&h00000009", Scope = Private
	#tag EndConstant

	#tag Constant, Name = KP_PERMISSIONS, Type = Double, Dynamic = False, Default = \"&h00000006", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PLAINTEXTKEYBLOB, Type = Double, Dynamic = False, Default = \"&h8", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PRIVATEKEYBLOB, Type = Double, Dynamic = False, Default = \"&h7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PUBLICKEYBLOB, Type = Double, Dynamic = False, Default = \"&h6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PUBLICKEYBLOBEX, Type = Double, Dynamic = False, Default = \"&hA", Scope = Private
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
