#tag Module
Protected Module AdvApi32
	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptAcquireContext Lib "AdvApi32" Alias "CryptAcquireContextW" (ByRef provider as Integer, container as Integer, providerName as WString, providerType as Integer, flags as Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptContextAddRef Lib "AdvApi32" (Provider As Integer, Reserved As Ptr, Flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptCreateHash Lib "AdvApi32" (Provider as Integer, Algorithm as Integer, Key as Integer, flags as Integer, ByRef hashHandle as Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptDecrypt Lib "AdvApi32" (hKey As Integer, hHash As Integer, Final As Boolean, Flags As Integer, Buffer As Ptr, ByRef BufferLen As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptDeriveKey Lib "AdvApi32" (Provider As Integer, Algorithm As Integer, BaseData As Integer, Flags As Integer, ByRef hKey As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptDestroyHash Lib "AdvApi32" (HashHandle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptDestroyKey Lib "AdvApi32" (hKey As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptDuplicateHash Lib "AdvApi32" (hHash As Integer, Reserved As Integer, Flags As Integer, ByRef NewHash As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptEncrypt Lib "AdvApi32" (hKey As Integer, hHash As Integer, Final As Boolean, Flags As Integer, Buffer As Ptr, ByRef DataLen As Integer, BufferLen As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptExportKey Lib "AdvApi32" (hKey As Integer, ExpKey As Integer, BlobType As Integer, Flags As Integer, Buffer As Ptr, ByRef BufferSize As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptGenKey Lib "AdvApi32" (Provider As Integer, Algorithm As Integer, Flags As Integer, ByRef hKey As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptGenRandom Lib "AdvApi32" (Provider As Integer, BufferLen As Integer, Buffer As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptGetHashParam Lib "AdvApi32" (hashHandle as Integer, type as Integer, value as Ptr, ByRef length as Integer, flags as Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptGetKeyParam Lib "AdvApi32" (hKeyContainer As Integer, Param As Integer, Buffer As Ptr, ByRef BufferSize As Integer, Flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptGetProvParam Lib "AdvApi32" (Provider As Integer, Param As Integer, Buffer As Ptr, ByRef BufferSize As Integer, Flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptHashData Lib "AdvApi32" (hashHandle as Integer, data as Ptr, length as Integer, flags as Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptImportKey Lib "AdvApi32" (hProvider As Integer, Data As Ptr, DataLen As Integer, hPubKey As Integer, Flags As Integer, ByRef hKey As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptReleaseContext Lib "AdvApi32" (Provider As Integer, Reserved As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptSetHashParam Lib "AdvApi32" (Hash As Integer, Param As Integer, Buffer As Ptr, Flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptSetKeyParam Lib "AdvApi32" (hKeyContainer As Integer, Param As Integer, Buffer As Ptr, Flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CryptSetProvParam Lib "AdvApi32" (Provider As Integer, Param As Integer, Buffer As Ptr, Flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetUserName Lib "AdvApi32" Alias "GetUserNameW" (buffer As Ptr, ByRef buffSize As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SaferiIsExecutableFileType Lib "AdvApi32" (FilePath As WString, OmitEXE As Boolean) As Boolean
	#tag EndExternalMethod


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
