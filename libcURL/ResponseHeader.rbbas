#tag Class
Protected Class ResponseHeader
	#tag Method, Flags = &h1
		Protected Sub Constructor(Owner As libcURL.EasyHandle, Header As curl_header)
		  ' Creates a new instance of ResponseHeader for the EasyHandle whose response headers are to be queried.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Constructor
		  
		  mOwner = New WeakRef(Owner)
		  mHeader = Header
		  Dim mb As MemoryBlock = mHeader.Name
		  If mb <> Nil Then mName = mb.CString(0)
		  mb = mHeader.Value
		  If mb <> Nil Then mValue = mb.CString(0)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Pair
		  ' Converts to a Pair of the name and value properties.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Operator_Convert
		  
		  Return Name:Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Owner() As libcURL.EasyHandle
		  If mOwner <> Nil And Not (mOwner.Value Is Nil) And mOwner.Value IsA libcURL.EasyHandle Then
		    Return libcURL.EasyHandle(mOwner.Value)
		  End If
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the number of headers using this name
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Amount
			  
			  Return mHeader.Amount
			End Get
		#tag EndGetter
		Amount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' There may be more than one header of the same name for a given transfer. This property is
			  ' the index of this instance of the named header, 0 or higher.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Index
			  
			  Return mHeader.Index
			End Get
		#tag EndGetter
		Index As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mHeader As curl_header
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mValue As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The name of the header.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Name
			  
			  Return mName
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The origin of the header. A member of the HeaderOriginType enumeration.
			  '     HeaderOriginType.Header -> plain server header
			  '     HeaderOriginType.Trailer -> trailing header
			  '     HeaderOriginType.Connect -> proxy CONNECT headers
			  '     HeaderOriginType.Intermediate_1XX -> HTTP 1xx headers
			  '     HeaderOriginType.Pseudo -> HTTP/2 pseudo headers
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Origin
			  
			  Dim t As UInt16 = CType(mHeader.Origin, UInt16)
			  Return CType(t, HeaderOriginType)
			End Get
		#tag EndGetter
		Origin As libcURL.HeaderOriginType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' The value of the header.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Value
			  
			  Return mValue
			End Get
		#tag EndGetter
		Value As String
	#tag EndComputedProperty


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
	#tag EndViewBehavior
End Class
#tag EndClass
