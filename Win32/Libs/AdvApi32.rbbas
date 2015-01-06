#tag Module
Protected Module AdvApi32
	#tag ExternalMethod, Flags = &h1
		Protected Declare Function AbortSystemShutdown Lib "AdvApi32" Alias "AbortSystemShutdownW" (MachineName As WString) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function AdjustTokenPrivileges Lib "AdvApi32" (tHandle As Integer, disableAllPrivs As Boolean, newState As Ptr, buffLength As Integer, prevPrivs As Ptr, ByRef retLen As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CloseServiceHandle Lib "AdvApi32" (ServiceHandle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function ControlService Lib "AdvApi32" (ServiceHandle As Integer, Control As Integer, ByRef Status As Win32 . Utils . SERVICE_STATUS) As Boolean
	#tag EndExternalMethod

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
		Protected Declare Function DecryptFile Lib "AdvApi32" Alias "DecryptFileW" (FilePath As WString, Reserved As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function EncryptFile Lib "AdvApi32" Alias "EncryptFileW" (FilePath As WString) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetServiceDisplayName Lib "AdvApi32" Alias "GetServiceDisplayNameW" (SCManager As Integer, ServiceName As WString, DisplayName As Ptr, ByRef ServiceNameSize As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetServiceKeyName Lib "AdvApi32" Alias "GetServiceKeyNameW" (SCManager As Integer, DisplayName As WString, ServiceName As Ptr, ByRef ServiceNameSize As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetUserName Lib "AdvApi32" Alias "GetUserNameW" (buffer As Ptr, ByRef buffSize As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function InitiateSystemShutdown Lib "AdvApi32" Alias "InitiateSystemShutdownW" (MachineName As WString, Message As WString, TimeOut As Integer, ForceAppsClosed As Boolean, RebootAfterShutdown As Boolean) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function InitiateSystemShutdownEx Lib "AdvApi32" Alias "InitiateSystemShutdownExW" (MachineName As WString, Message As WString, TimeOut As Integer, ForceAppsClosed As Boolean, RebootAfterShutdown As Boolean, Reason As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function LookupPrivilegeValue Lib "AdvApi32" Alias "LookupPrivilegeValueW" (sysName As WString, privName As WString, Luid As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function LookupPrivilegeValue Lib "AdvApi32" Alias "LookupPrivilegeValueW" (sysName As WString, privName As WString, ByRef Luid As Win32 . Utils . TOKEN_PRIVILEGES) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function OpenProcessToken Lib "AdvApi32" (handle As Integer, access As Integer, ByRef tHandle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function OpenSCManager Lib "AdvApi32" Alias "OpenSCManagerW" (MachineName As WString, DatabaseName As WString, DesiredAccess As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function OpenService Lib "AdvApi32" Alias "OpenServiceW" (SCManager As Integer, ServiceName As WString, DesiredAccess As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function QueryServiceConfig Lib "AdvApi32" Alias "QueryServiceConfigW" (SCManager As Integer, DataBuffer As Ptr, BufferSize As Integer, ByRef NeededSize As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function QueryServiceStatus Lib "AdvApi32" (ServiceHandle As Integer, ByRef Status As Win32 . Utils . SERVICE_STATUS) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function RegGetValue Lib "AdvApi32" Alias "RegGetValueW" (hKey As Integer, SubKeyName As WString, ValueName As WString, Flags As Integer, ByRef TypeCode As Integer, DataBuffer As Ptr, ByRef DataBufferSize As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function RegOpenKeyEx Lib "AdvApi32" Alias "RegOpenKeyExW" (hKey As Integer, SubkeyName As WString, Options As Integer, AccessMask As Integer, ByRef ResultKey As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function RegSetValueEx Lib "AdvApi32" Alias "RegSetValueExW" (hKey As Integer, ValueName As WString, Reserved As Integer, TypeCode As Integer, DataBuffer As Ptr, DataBufferSize As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SaferiIsExecutableFileType Lib "AdvApi32" (FilePath As WString, OmitEXE As Boolean) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function StartService Lib "AdvApi32" Alias "StartServiceW" (ServiceHandle As Integer, NumServiceArgs As Integer, ServiceArguments As Ptr) As Boolean
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
