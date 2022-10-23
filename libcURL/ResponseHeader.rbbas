#tag Class
Protected Class ResponseHeader
	#tag Method, Flags = &h1
		Protected Sub Constructor(Header As curl_header, RequestIndex As Integer)
		  ' Creates a new instance of ResponseHeader for the EasyHandle whose response headers are to be queried.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Constructor
		  
		  mAmount = Header.Amount
		  mIndex = Header.Index
		  Dim mb As MemoryBlock = Header.Name
		  If mb <> Nil Then mName = mb.CString(0)
		  Dim ori As UInt16 = CType(Header.Origin, UInt16)
		  mOrigin = CType(ori, HeaderOriginType)
		  mb = Header.Value
		  If mb <> Nil Then mValue = mb.CString(0)
		  mRequestIndex = RequestIndex
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Header As curl_header64, RequestIndex As Integer)
		  ' Creates a new instance of ResponseHeader for the EasyHandle whose response headers are to be queried.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Constructor
		  
		  mAmount = Header.Amount
		  mIndex = Header.Index
		  Dim mb As MemoryBlock = Header.Name
		  If mb <> Nil Then mName = mb.CString(0)
		  Dim ori As UInt16 = CType(Header.Origin, UInt16)
		  mOrigin = CType(ori, HeaderOriginType)
		  mb = Header.Value
		  If mb <> Nil Then mValue = mb.CString(0)
		  mRequestIndex = RequestIndex
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


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the number of headers using this name
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Amount
			  
			  Return mAmount
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
			  
			  Return mIndex
			End Get
		#tag EndGetter
		Index As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAmount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOrigin As libcURL.HeaderOriginType
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequestIndex As Integer
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
			  
			  Return mOrigin
			End Get
		#tag EndGetter
		Origin As libcURL.HeaderOriginType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' A given transfer might involve more than one request (redirects, etc.) This property is
			  ' the index of the request that this header is a response to, 0 or higher.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.RequestIndex
			  
			  Return mRequestIndex
			End Get
		#tag EndGetter
		RequestIndex As Integer
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
			Name="RequestIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
