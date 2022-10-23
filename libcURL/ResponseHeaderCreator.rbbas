#tag Class
Private Class ResponseHeaderCreator
Inherits libcURL.ResponseHeader
	#tag Method, Flags = &h0
		Sub Constructor(Header As curl_header, RequestIndex As Integer)
		  ' This class exists solely to protect the superclass Constructor from being called
		  ' from outside the libcURL module.
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(Header As curl_header, RequestIndex As Integer) -- From ResponseHeader
		  Super.Constructor(Header, RequestIndex)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Header As curl_header64, RequestIndex As Integer)
		  ' This class exists solely to protect the superclass Constructor from being called
		  ' from outside the libcURL module.
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(Header As curl_header, RequestIndex As Integer) -- From ResponseHeader
		  Super.Constructor(Header, RequestIndex)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Name As String, Value As String, NameIndex As Integer, NameCount As Integer, RequestIndex As Integer)
		  Dim h As curl_header
		  h.Amount = NameCount
		  h.Index = NameIndex
		  h.Origin = CType(HeaderOriginType.Header, UInt32)
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(Header As curl_header, RequestIndex As Integer) -- From ResponseHeader
		  Super.Constructor(h, RequestIndex)
		  
		  mName = Name
		  mValue = Value
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
