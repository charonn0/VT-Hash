#tag Class
Protected Class ResponseHeaderEngine
	#tag Method, Flags = &h1
		Protected Sub Constructor(Owner As libcURL.EasyHandle)
		  ' Creates a new instance of ResponseHeaderEngine for the EasyHandle whose response headers
		  ' are to be queried.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Constructor
		  
		  mOwner = New WeakRef(Owner)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count(Name As String = "", Origin As libcURL.HeaderOriginType = libcURL.HeaderOriginType.Any, RequestIndex As Integer = - 1) As Integer
		  ' Counts the number of response headers that match all of the parameters. If a parameter
		  ' is unspecified then all headers match it. Hence, with no parameters specified this
		  ' method counts the total number of all response headers.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Count
		  
		  Dim h() As ResponseHeader = GetHeaders(Name, Origin, RequestIndex)
		  Return UBound(h) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetHeader(Name As String, Index As Integer = 0, Origin As libcURL.HeaderOriginType = libcURL.HeaderOriginType.Any, RequestIndex As Integer = - 1) As libcURL.ResponseHeader
		  ' Retrieves the response header that matches all of the parameters. If a parameter
		  ' is unspecified then all headers match it. If there is more than one header that matches
		  ' all the parameters, then specify the Index parameter to indicate which of these you
		  ' want.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.GetHeader
		  
		  Dim h() As ResponseHeader = GetHeaders(Name, Origin, RequestIndex)
		  If Index > UBound(h) Then
		    ErrorSetter(Owner).LastError = libcURL.Errors.HEADER_INDEX_OUT_OF_BOUNDS
		    Raise New cURLException(Owner)
		  End If
		  
		  For i As Integer = 0 To UBound(h)
		    If h(i).Index = Index Then Return h(i)
		  Next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetHeaders(Name As String = "", Origin As libcURL.HeaderOriginType = libcURL.HeaderOriginType.Any, RequestIndex As Integer = - 1) As libcURL.ResponseHeader()
		  ' Retrieves the response headers that matches all of the parameters. If a parameter
		  ' is unspecified then all headers match it. 
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.GetHeaders
		  
		  Dim ori As UInt32 = CType(Origin, UInt32)
		  Dim this As Ptr = curl_easy_nextheader(Owner.Handle, ori, RequestIndex, Nil)
		  Dim h() As ResponseHeader
		  Do Until this = Nil
		    Dim header As New ResponseHeaderCreator(Owner, this.curl_header(0))
		    If Name = "" Or Name = header.Name Then h.Append(header)
		    this = curl_easy_nextheader(Owner.Handle, ori, RequestIndex, this)
		  Loop
		  
		  Return h
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasHeader(Name As String, Origin As libcURL.HeaderOriginType = libcURL.HeaderOriginType.Any, RequestIndex As Integer = - 1) As Boolean
		  ' Returns True if at least one header exists which matches all of the parameters. If a parameter
		  ' is unspecified then all headers match it.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.HasHeader
		  
		  Dim h() As ResponseHeader = GetHeaders(Name, Origin, RequestIndex)
		  Return UBound(h) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As InternetHeaders
		  ' Converts the headers into an InternetHeaders object
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeader.Operator_Convert
		  
		  Dim ori As UInt32 = CType(HeaderOriginType.Any, UInt32)
		  Dim this As Ptr = curl_easy_nextheader(Owner.Handle, ori, -1, Nil)
		  Dim h As New InternetHeaders
		  Do Until this = Nil
		    Dim header As New ResponseHeaderCreator(Owner, this.curl_header(0))
		    h.AppendHeader(header.Name, header.Value)
		    this = curl_easy_nextheader(Owner.Handle, ori, -1, this)
		  Loop
		  
		  Return h
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Owner() As libcURL.EasyHandle
		  If mOwner <> Nil And Not (mOwner.Value Is Nil) And mOwner.Value IsA libcURL.EasyHandle Then
		    Return libcURL.EasyHandle(mOwner.Value)
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mOwner As WeakRef
	#tag EndProperty


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
