#tag Module
Protected Module Multi
	#tag Constant, Name = CHUNK_LENGTH_PENALTY_SIZE, Type = Double, Dynamic = False, Default = \"30010", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CONTENT_LENGTH_PENALTY_SIZE, Type = Double, Dynamic = False, Default = \"30009", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAXCONNECTS, Type = Double, Dynamic = False, Default = \"6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAX_HOST_CONNECTIONS, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAX_PIPELINE_LENGTH, Type = Double, Dynamic = False, Default = \"8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = MAX_TOTAL_CONNECTIONS, Type = Double, Dynamic = False, Default = \"13", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PIPELINING, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SOCKETDATA, Type = Double, Dynamic = False, Default = \"10002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SOCKETFUNCTION, Type = Double, Dynamic = False, Default = \"20001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TIMERDATA, Type = Double, Dynamic = False, Default = \"10005", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TIMERFUNCTION, Type = Double, Dynamic = False, Default = \"20004", Scope = Protected
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
