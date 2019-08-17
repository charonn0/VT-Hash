#tag Module
Protected Module LibZ
	#tag Method, Flags = &h1
		Protected Function IsAtLeast(Major As Integer, Minor As Integer, Patch As Integer) As Boolean
		  ' Returns True if LibZ is available and at least the version specified.
		  
		  Static avail As Boolean = libcURL.Version.LibZ.IsAvailable
		  If Not avail Then Return False
		  
		  Static versionname As String
		  If versionname = "" And Struct.libzVersion <> Nil Then
		    Dim mb As MemoryBlock = Struct.libzVersion
		    versionname = mb.CString(0)
		  End If
		  Static min, maj, pat As Integer
		  If maj = 0 Then
		    maj = Val(NthField(versionname, ".", 1))
		    min = Val(NthField(versionname, ".", 2))
		    pat = Val(NthField(versionname, ".", 3))
		  End If
		  
		  Return maj > Major Or (maj = Major And (min > Minor Or (min = Minor And pat >= Patch)))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsAvailable() As Boolean
		  Return BitAnd(Features, FEATURE_LIBZ) = FEATURE_LIBZ // libz features are present
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Attributes( deprecated ) Protected Function Name() As String
		  #If Target32Bit Then
		    Dim data As MemoryBlock = Struct.libzVersion
		  #Else
		    Dim data As MemoryBlock = Struct64.libzVersion
		  #EndIf
		  
		  If data <> Nil Then Return data.CString(0)
		End Function
	#tag EndMethod


	#tag Constant, Name = FEATURE_LIBZ, Type = Double, Dynamic = False, Default = \"8", Scope = Private
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
