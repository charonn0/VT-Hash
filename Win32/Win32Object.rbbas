#tag Interface
Protected Interface Win32Object
	#tag Method, Flags = &h0
		Function Handle() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As Integer
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About this interface
		A Win32Object refers to a Win32 handle (or equivalent). Once the Object is constructed, implementors guarentee 
		that the handle value will be returned from the Win32Object.Handle method. Implementors do not necessarily 
		guarantee that the handle is (or ever was) valid.
		
		Implementors MUST store the value of Win32.LastError after every Win32 call, and return the stored error number from
		Win32Object.LastError.
	#tag EndNote


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
End Interface
#tag EndInterface
