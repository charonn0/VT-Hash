#tag Class
Protected Class ListPtr
Inherits libcURL.cURLHandle
	#tag Method, Flags = &h0
		Function Append(s As String) As Boolean
		  ' Appends the passed string to the list. If the List is NULL it will be created.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_slist_append.html
		  
		  Dim p As Ptr = curl_slist_append(List, s)
		  If p <> Nil Then
		    List = p
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ListPtr As Ptr = Nil, GlobalInitFlags As Integer = libcURL.CURL_GLOBAL_NOTHING)
		  ' Creates a linked list that is managed by libcURL. Pass a Ptr to the first item in an existing list,
		  ' or Nil to create an empty list.
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(GlobalInitFlags)
		  List = ListPtr
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Free()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Free()
		  ' Frees the list.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_slist_free_all.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ListPtr.Free
		  
		  If libcURL.IsAvailable And List <> Nil Then libcURL.curl_slist_free_all(List)
		  List = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Handle() As Integer
		  ' This method returns a Ptr to the header list which can be passed back to libcURL
		  Return Integer(List)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherList As libcURL.ListPtr) As Integer
		  Dim i As Integer = Super.Operator_Compare(OtherList)
		  If i = 0 Then Return Sign(mHandle - OtherList.Handle)
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(From() As String)
		  Me.Free()
		  Me.Constructor()
		  For i As Integer = 0 To UBound(From)
		    If Not Me.Append(From(i)) Then Raise New cURLException(Me)
		  Next
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  return Ptr(mHandle)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHandle = Integer(value)
			End Set
		#tag EndSetter
		Protected List As Ptr
	#tag EndComputedProperty


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
End Class
#tag EndClass
