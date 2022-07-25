#tag Class
Protected Class RequestHeaderEngine
	#tag Method, Flags = &h1
		Protected Sub Constructor(Owner As libcURL.EasyHandle)
		  ' Creates a new instance of RequestHeaderEngine for the EasyHandle whose request headers are to be manipulated
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.RequestHeaderEngine.Constructor
		  
		  mOwner = New WeakRef(Owner)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CopyFrom(OtherHeaders As libcURL.RequestHeaderEngine)
		  ' Copies the specified request headers.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.RequestHeaderEngine.CopyFrom
		  
		  Dim s() As String = OtherHeaders.mHeaders
		  Dim l As ListPtr = s
		  If Not Owner.SetOption(libcURL.Opts.HTTPHEADER, l) Then Raise New cURLException(Owner)
		  mHeaders = l
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  ' Returns the number of user-set request headers currently being used.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.RequestHeaderEngine.Count
		  
		  If mHeaders <> Nil Then Return mHeaders.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetHeader(Name As String) As String
		  ' Returns the value of the named request header.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.RequestHeaderEngine.GetHeader
		  
		  Dim c As Integer = Me.Count
		  For i As Integer = 0 To c - 1
		    If Me.Name(i) = Name Then Return Me.Value(i)
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasHeader(Name As String) As Boolean
		  ' Returns True if the named request header has been set.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.RequestHeaderEngine.HasHeader
		  
		  Return Me.GetHeader(Name) <> ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name(Index As Integer) As String
		  ' Returns the name of the request header at Index. The first header is at Index=0.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.RequestHeaderEngine.Name
		  
		  If mHeaders = Nil Then Return ""
		  Return NthField(mHeaders.Item(Index), ":", 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Owner() As libcURL.EasyHandle
		  If mOwner <> Nil And mOwner.Value <> Nil And mOwner.Value IsA libcURL.EasyHandle Then
		    Return libcURL.EasyHandle(mOwner.Value)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveHeader(Name As String)
		  ' Removes the named request header.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.RequestHeaderEngine.RemoveHeader
		  
		  Me.SetHeader(Name, "")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  ' Deletes all custom request headers and resets defaults.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.RequestHeaderEngine.Reset
		  
		  Me.SetHeader("", "")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetHeader(Name As String, Value As String)
		  ' Adds or updates the named request header. Headers will persist until removed or reset.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.RequestHeaderEngine.SetHeader
		  
		  mHeaders = Owner.SetRequestHeader(mHeaders, Name, Value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Index As Integer) As String
		  ' Returns the value of the request header at Index. The first header is at Index=0.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.RequestHeaderEngine.Value
		  
		  If mHeaders = Nil Then Return ""
		  Dim header As String = mHeaders.Item(Index)
		  Dim nm As String = Me.Name(Index)
		  Return Replace(header, nm + ":", "").Trim
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHeaders As libcURL.ListPtr
	#tag EndProperty

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
