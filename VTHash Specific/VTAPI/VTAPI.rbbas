#tag Module
Protected Module VTAPI
	#tag Method, Flags = &h21
		Private Function CRLF() As String
		  Return EndOfLine.Windows
		End Function
	#tag EndMethod


	#tag Constant, Name = AgentVersion, Type = Double, Dynamic = False, Default = \"2.0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RESOURCE_FOUND, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOURCE_INVALID, Type = Double, Dynamic = False, Default = \"-1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOURCE_NOT_FOUND, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOURCE_PENDING, Type = Double, Dynamic = False, Default = \"-2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESPONSE_INVALID, Type = Double, Dynamic = False, Default = \"255", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = VT_Get_Domain, Type = String, Dynamic = False, Default = \"/vtapi/v2/domain/report", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VT_Get_File, Type = String, Dynamic = False, Default = \"/vtapi/v2/file/report", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VT_Get_IP, Type = String, Dynamic = False, Default = \"/vtapi/v2/ip-address/report", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VT_Get_URL, Type = String, Dynamic = False, Default = \"/vtapi/v2/url/scan", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VT_Put_Comment, Type = String, Dynamic = False, Default = \"/vtapi/v2/comments/put", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VT_Rescan_File, Type = String, Dynamic = False, Default = \"/vtapi/v2/file/rescan", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VT_Submit_File, Type = String, Dynamic = False, Default = \"/vtapi/v2/file/scan", Scope = Private
	#tag EndConstant


	#tag Enum, Name = RequestType, Type = Integer, Flags = &h1
		FileReport
		  URLReport
		  DomainReport
		  IPReport
		  FileSubmit
		  Comment
		Rescan
	#tag EndEnum


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
