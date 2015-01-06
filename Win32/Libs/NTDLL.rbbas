#tag Module
Protected Module NTDLL
	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Sub NtQueryInformationFile Lib "NTDLL" (fHandle As Integer, ByRef status As Win32 . IO . IO_STATUS_BLOCK, FileInformation As Ptr, FILength As UInt32, InfoClass As Int32)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function NtQuerySystemInformation Lib "NTDLL" (SystemInfoClass As UInt32, SystemInfoBuffer As Ptr, SysInfoBufferLen As UInt32, ByRef ReturnLen As Integer) As UInt32
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function RtlCompressBuffer Lib "NTDLL" (Engine As Integer, SourceBuffer As Ptr, SrcSize As Integer, OutputBuffer As Ptr, OutputSize As Integer, SourceChunkSize As Integer, ByRef FinalSize As Integer, Workspace As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function RtlDecompressBuffer Lib "NTDLL" (Format As Integer, OutputBuffer As Ptr, OutputSize As Integer, SourceBuffer As Ptr, SourceSize As Integer, ByRef FinalSize As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function RtlGetCompressionWorkSpaceSize Lib "NTDLL" (Format As Integer, ByRef WorkSpaceSize As Integer, ByRef FragmentSize As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function RtlQueryElevationFlags Lib "NTDLL" (ByRef flags As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function RtlSetProcessIsCritical Lib "NTDLL" (NewStatus As Boolean, ByRef OldStatus As Boolean, needscb As Boolean) As Boolean
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
