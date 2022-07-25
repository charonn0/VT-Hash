#tag Class
Private Class ResponseHeaderEngineCreator
Inherits libcURL.ResponseHeaderEngine
	#tag Method, Flags = &h0
		Sub Constructor(Owner As libcURL.EasyHandle, Optional FakeHeaders As InternetHeaders)
		  // Calling the overridden superclass constructor.
		  Super.Constructor(Owner)
		  mFake = FakeHeaders
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count(Name As String = "", Origin As libcURL.HeaderOriginType = libcURL.HeaderOriginType.Any, RequestIndex As Integer = - 1) As Integer
		  If mFake = Nil Then Return Super.Count(Name, Origin, RequestIndex)
		  If Name = "" Then
		    Return mFake.Count
		  Else
		    Return mFake.NameCount(Name)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetHeader(Name As String, Index As Integer = 0, Origin As libcURL.HeaderOriginType = libcURL.HeaderOriginType.Any, RequestIndex As Integer = - 1) As libcURL.ResponseHeader
		  If mFake = Nil Then Return Super.GetHeader(Name, Index, Origin, RequestIndex)
		  Dim vl As String = mFake.Value(Name, Index)
		  If vl <> "" Then Return New ResponseHeaderCreator(Owner, Name, vl, Index, Me.Count(Name, Origin, RequestIndex))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetHeaders(Name As String = "", Origin As libcURL.HeaderOriginType = libcURL.HeaderOriginType.Any, RequestIndex As Integer = - 1) As libcURL.ResponseHeader()
		  If mFake = Nil Then Return Super.GetHeaders(Name, Origin, RequestIndex)
		  Dim h() As ResponseHeader
		  Dim count As Integer = mFake.Count
		  For i As Integer = 0 To count - 1
		    If Name = "" Or Name = mFake.Name(i) Then h.Append(New ResponseHeaderCreator(Owner, mFake.Name(i), mFake.Value(i), i, count))
		  Next
		  Return h
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As InternetHeaders
		  If mFake = Nil Then Return Super.Operator_Convert()
		  Return mFake
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mFake As InternetHeaders
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
