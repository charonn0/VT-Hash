#tag Module
Protected Module Shlwapi
	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function AssocIsDangerous Lib "Shlwapi" (FileExtension As WString) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function IsOS Lib "Shlwapi" (OSFeature As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function PathAddBackslash Lib "Shlwapi" Alias "PathAddBackslashW" (thePath As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function PathAppend Lib "Shlwapi" Alias "PathAppendW" (firstHalf As Ptr, secondHalf As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function PathCanonicalize Lib "Shlwapi" Alias "PathCanonicalizeW" (OutBuffer As Ptr, InBuffer As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function PathGetArgs Lib "Shlwapi" Alias "PathGetArgsW" (path As WString) As WString
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function PathMatchSpec Lib "Shlwapi" Alias "PathMatchSpecW" (path As WString, spec As WString) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function PathMatchSpecEx Lib "Shlwapi" Alias "PathMatchSpecExW" (path As WString, spec As WString, Flags As Integer) As Integer
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
