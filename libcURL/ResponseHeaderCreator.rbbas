#tag Class
Private Class ResponseHeaderCreator
Inherits libcURL.ResponseHeader
	#tag Method, Flags = &h0
		Sub Constructor(Owner As libcURL.EasyHandle, Header As curl_header)
		  ' This class exists solely to protect the superclass Constructor from being called
		  ' from outside the libcURL module.
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(Owner As libcURL.EasyHandle, Header As curl_header) -- From ResponseHeader
		  Super.Constructor(Owner, Header)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Owner As libcURL.EasyHandle, Name As String, Value As String, NameIndex As Integer, NameCount As Integer)
		  Dim h As curl_header
		  h.Amount = NameCount
		  h.Index = NameIndex
		  h.Origin = CType(HeaderOriginType.Header, UInt32)
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(Owner As libcURL.EasyHandle, Header As curl_header) -- From ResponseHeader
		  Super.Constructor(Owner, h)
		  
		  mName = Name
		  mValue = Value
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Amount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Origin"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="libcURL.HeaderOriginType"
			EditorType="Enum"
			#tag EnumValues
				"1 - Header"
				"2 - Trailer"
				"4 - Connect"
				"8 - Intermediate_1XX"
				"16 - Pseudo"
				"31 - Any"
			#tag EndEnumValues
		#tag EndViewProperty
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
