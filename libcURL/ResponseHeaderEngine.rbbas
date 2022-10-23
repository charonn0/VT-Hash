#tag Class
Protected Class ResponseHeaderEngine
	#tag Method, Flags = &h1
		Protected Function AllRequestGetHeader(Name As String, Index As Integer, Origin As libcURL.HeaderOriginType) As libcURL.ResponseHeader
		  Dim h() As ResponseHeader = AllRequestGetHeaders(Name, Origin)
		  If Index <= UBound(h) Then Return h(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function AllRequestGetHeaders(Name As String, Origin As libcURL.HeaderOriginType) As libcURL.ResponseHeader()
		  Dim ori As UInt32 = CType(Origin, UInt32)
		  Dim h() As ResponseHeader
		  Dim c As Integer = RequestCount - 1
		  
		  For i As Integer = 0 To c
		    Dim this As Ptr = curl_easy_nextheader(Owner.Handle, ori, i, Nil)
		    Do Until this = Nil
		      #If Target64Bit Then
		        Dim header As New ResponseHeaderCreator(this.curl_header64(0), i)
		      #Else
		        Dim header As New ResponseHeaderCreator(this.curl_header(0), i)
		      #EndIf
		      If Name = "" Or Name = header.Name Then h.Append(header)
		      this = curl_easy_nextheader(Owner.Handle, ori, i, this)
		    Loop
		  Next
		  
		  Return h
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Owner As libcURL.EasyHandle)
		  ' Creates a new instance of ResponseHeaderEngine for the EasyHandle whose response headers
		  ' are to be queried.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeaderEngine.Constructor
		  
		  mOwner = New WeakRef(Owner)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count(Name As String = "", Origin As libcURL.HeaderOriginType = libcURL.HeaderOriginType.Any, RequestIndex As Integer = -1) As Integer
		  ' Counts the number of response headers that match all of the parameters. If a parameter
		  ' is unspecified then all headers match it. Hence, with no parameters specified this
		  ' method counts the number of response headers to the final request in the transfer.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeaderEngine.Count
		  
		  Dim h() As ResponseHeader = GetHeaders(Name, Origin, RequestIndex)
		  Return UBound(h) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetHeader(Name As String, Index As Integer = 0, Origin As libcURL.HeaderOriginType = libcURL.HeaderOriginType.Any, RequestIndex As Integer = -1) As libcURL.ResponseHeader
		  ' Retrieves the response header that matches all of the parameters. If a parameter
		  ' is unspecified then all headers match it. If there is more than one header that matches
		  ' all the parameters, then specify the Index parameter to indicate which of these you
		  ' want.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeaderEngine.GetHeader
		  
		  If RequestIndex = -2 Then Return AllRequestGetHeader(Name, Index, Origin) ' -2 is all requests
		  Dim reqidx As Integer = RequestIndex
		  If reqidx = -1 Then reqidx = RequestCount - 1 ' -1 is most recent request
		  
		  Dim ori As UInt32 = CType(Origin, UInt32)
		  If BitAnd(ori, 16) = 16 And libcURL.Version.IsExactly(7, 84, 0) Then ' broken in this version only
		    Dim h() As ResponseHeader = GetHeaders(Name, Origin, RequestIndex)
		    If UBound(h) <= Index Then Return h(Index)
		  End If
		  
		  Dim p As Ptr
		  Select Case curl_easy_header(Owner.Handle, Name, Index, ori, RequestIndex, p)
		  Case 0
		    #If Target64Bit Then
		      Return New ResponseHeaderCreator(p.curl_header64(0), reqidx)
		    #Else
		      Return New ResponseHeaderCreator(p.curl_header(0), reqidx)
		    #EndIf
		    
		  Case CURLHE_BADINDEX, CURLHE_MISSING, CURLHE_NOHEADERS, CURLHE_NOREQUEST
		    Return Nil
		    
		  Case CURLHE_OUT_OF_MEMORY
		    ErrorSetter(Owner).LastError = libcURL.Errors.OUT_OF_MEMORY
		    Raise New cURLException(Owner)
		    
		  Case CURLHE_BAD_ARGUMENT
		    ErrorSetter(Owner).LastError = libcURL.Errors.BAD_FUNCTION_ARGUMENT
		    Raise New cURLException(Owner)
		    
		  Case CURLHE_NOT_BUILT_IN
		    ErrorSetter(Owner).LastError = libcURL.Errors.NOT_BUILT_IN
		    Raise New cURLException(Owner)
		    
		  Else
		    ErrorSetter(Owner).LastError = libcURL.Errors.INCONCEIVABLE
		    Raise New cURLException(Owner)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetHeaders(Name As String = "", Origin As libcURL.HeaderOriginType = libcURL.HeaderOriginType.Any, RequestIndex As Integer = -1) As libcURL.ResponseHeader()
		  ' Retrieves the response headers that matches all of the parameters. If a parameter
		  ' is unspecified then all headers match it.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeaderEngine.GetHeaders
		  
		  If RequestIndex = -2 Then Return AllRequestGetHeaders(Name, Origin) ' -2 is all requests
		  Dim reqidx As Integer = RequestIndex
		  If reqidx = -1 Then reqidx = RequestCount - 1 ' -1 is most recent request
		  
		  Dim ori As UInt32 = CType(Origin, UInt32)
		  Dim this As Ptr = curl_easy_nextheader(Owner.Handle, ori, RequestIndex, Nil)
		  
		  Dim h() As ResponseHeader
		  Do Until this = Nil
		    #If Target64Bit Then
		      Dim header As New ResponseHeaderCreator(this.curl_header64(0), reqidx)
		    #Else
		      Dim header As New ResponseHeaderCreator(this.curl_header(0), reqidx)
		    #EndIf
		    
		    If Name = "" Or Name = header.Name Then h.Append(header)
		    this = curl_easy_nextheader(Owner.Handle, ori, RequestIndex, this)
		  Loop
		  
		  Return h
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasHeader(Name As String, Origin As libcURL.HeaderOriginType = libcURL.HeaderOriginType.Any, RequestIndex As Integer = -1) As Boolean
		  ' Returns True if at least one header exists which matches all of the parameters. If a parameter
		  ' is unspecified then all headers match it.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeaderEngine.HasHeader
		  
		  Dim h() As ResponseHeader
		  If RequestIndex > -2 Then
		    h = GetHeaders(Name, Origin, RequestIndex)
		  Else
		    h = AllRequestGetHeaders(Name, Origin)
		  End If
		  Return UBound(h) > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As InternetHeaders
		  ' Converts the headers into an InternetHeaders object
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeaderEngine.Operator_Convert
		  
		  Dim ori As UInt32 = CType(HeaderOriginType.Any, UInt32)
		  Dim this As Ptr = curl_easy_nextheader(Owner.Handle, ori, -1, Nil)
		  Dim h As New InternetHeaders
		  Do Until this = Nil
		    #If Target64Bit Then
		      Dim header As New ResponseHeaderCreator(this.curl_header64(0), 0)
		    #Else
		      Dim header As New ResponseHeaderCreator(this.curl_header(0), 0)
		    #EndIf
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

	#tag Method, Flags = &h0
		Function RequestCount() As Integer
		  ' Returns the number of requests that were made during the previous transfer, for example
		  ' redirects or multi-stage authentication.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ResponseHeaderEngine.RequestCount
		  
		  Dim ori As UInt32 = CType(HeaderOriginType.Any, UInt32)
		  Dim idx As Integer
		  While curl_easy_nextheader(Owner.Handle, ori, idx, Nil) <> Nil
		    idx = idx + 1
		  Wend
		  
		  Return idx
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mOwner As WeakRef
	#tag EndProperty


	#tag Constant, Name = CURLHE_BADINDEX, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLHE_BAD_ARGUMENT, Type = Double, Dynamic = False, Default = \"6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLHE_MISSING, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLHE_NOHEADERS, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLHE_NOREQUEST, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLHE_NOT_BUILT_IN, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CURLHE_OUT_OF_MEMORY, Type = Double, Dynamic = False, Default = \"5", Scope = Protected
	#tag EndConstant


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
