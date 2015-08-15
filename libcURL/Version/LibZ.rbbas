#tag Module
Protected Module LibZ
	#tag Method, Flags = &h1
		Protected Function IsAtLeast(Major As Integer, Minor As Integer, Patch As Integer) As Boolean
		  ' Returns True if LibZ is available and at least the version specified.
		  
		  Select Case True
		  Case Not libcURL.Version.LibZ.IsAvailable
		    Return False
		    
		  Case libcURL.Version.LibZ.MajorNumber > Minor
		    Return True
		    
		  Case libcURL.Version.LibZ.MajorNumber = Major
		    If libcURL.Version.LibZ.MinorNumber > Minor Or (libcURL.Version.LibZ.MinorNumber = Minor And libcURL.Version.LibZ.PatchNumber >= Patch) Then
		      Return True
		    End If
		    
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsAvailable() As Boolean
		  Dim kLIBZ As Integer = ShiftLeft(1, 3)
		  Return BitAnd(Features, kLIBZ) = kLIBZ // libz features are present
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MajorNumber() As Integer
		  ' libcurl's major version; e.g. if the version is 1.2.3 then the MajorNumber is 1
		  Return Val(NthField(libcURL.Version.LibZ.Name, ".", 1))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MinorNumber() As Integer
		  ' libcurl's minor version; e.g. if the version is 1.2.3 then the MinorNumber is 2
		  Return Val(NthField(libcURL.Version.LibZ.Name, ".", 2))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Name() As String
		  Dim data As MemoryBlock = Struct.libzVersion
		  If data <> Nil Then Return data.CString(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PatchNumber() As Integer
		  ' libcurl's patch version; e.g. if the version is 1.2.3 then the PatchNumber is 3
		  Return Val(NthField(libcURL.Version.LibZ.Name, ".", 3))
		End Function
	#tag EndMethod


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
