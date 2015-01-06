#tag Module
Protected Module Version
	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetFileVersionInfo Lib "Version" Alias "GetFileVersionInfoW" (fileName As WString, ignored As Integer, bufferSize As Integer, buffer As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetFileVersionInfoSize Lib "Version" Alias "GetFileVersionInfoSizeW" (fileName As WString, ignored As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function VerQueryValue Lib "Version" Alias "VerQueryValueW" (inBuffer As Ptr, subBlock As WString, outBuffer As Ptr, ByRef outBufferLen As Integer) As Boolean
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
