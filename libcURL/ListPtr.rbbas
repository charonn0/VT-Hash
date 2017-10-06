#tag Class
Protected Class ListPtr
Inherits libcURL.cURLHandle
	#tag Method, Flags = &h0
		Function Append(s As String) As Boolean
		  ' Appends the passed string to the list. If the List is NULL it will be created.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_slist_append.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ListPtr.Append
		  
		  Dim p As Ptr = curl_slist_append(List, s)
		  If p <> Nil Then
		    List = p
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ListPtr As Ptr = Nil, GlobalInitFlags As Integer = libcURL.CURL_GLOBAL_DEFAULT)
		  ' Creates a linked list that is managed by libcURL. Pass a Ptr to the first item in an existing list,
		  ' or Nil to create an empty list.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ListPtr.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(GlobalInitFlags)
		  List = ListPtr
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  ' Returns the number of strings in the list.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ListPtr.Count
		  
		  Dim nxt As Ptr = List
		  Dim i As Integer
		  Do Until nxt = Nil
		    i = i + 1
		    nxt = nxt.Ptr(4)
		  Loop
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If List <> Nil Then curl_slist_free_all(List)
		  List = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( deprecated = "libcURL.ListPtr.Destructor" )  Sub Free()
		  ' Frees the list.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_slist_free_all.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ListPtr.Free
		  
		  Me.Destructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(Index As Integer) As String
		  ' Reads the string located at Index. The first item is at Index=0
		  ' If the list does not contain a string at Index, an OutOfBoundsException will be raised.
		  ' If the list is empty then a NilObjectException will be raised.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ListPtr.Item
		  
		  If List = Nil Then
		    Dim err As New NilObjectException
		    err.Message = "The list is empty."
		    Raise err
		  End If
		  
		  Dim nxt As Ptr = List
		  Dim i As Integer
		  Do
		    If i < Index Then
		      nxt = nxt.Ptr(4)
		      If nxt = Nil Then
		        Dim err As New OutOfBoundsException
		        err.Message = "The list does not contain an entry at that index."
		        Raise err
		      End If
		      
		    ElseIf i = Index Then
		      Dim txt As MemoryBlock = nxt.Ptr(0)
		      If txt = Nil Then Return ""
		      Return txt.CString(0)
		      
		    Else
		      Dim err As New OutOfBoundsException
		      err.Message = "List indices must be greater than or equal to zero."
		      Raise err
		    End If
		    i = i + 1
		  Loop
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherList As libcURL.ListPtr) As Integer
		  ' Overloads the comparison operator(=), permitting direct comparisons between references to ListPtrs
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ListPtr.Operator_Compare
		  
		  Dim i As Integer = Super.Operator_Compare(OtherList)
		  If i = 0 Then i = Sign(mHandle - OtherList.Handle)
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String()
		  ' Overloads the conversion operator(=), permitting implicit and explicit conversion from a ListPtr into a string array
		  ' The converted array is a copy of the ListPtr contents
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ListPtr.Operator_Convert
		  
		  If mLastError = libcURL.Errors.NOT_INITIALIZED Then Raise New cURLException(Me)
		  
		  Dim ret() As String
		  Dim nxt As Ptr = List
		  Do Until nxt = Nil
		    Dim txt As MemoryBlock = nxt.Ptr(0)
		    nxt = nxt.Ptr(4)
		    If txt = Nil Then Continue
		    ret.Append(txt.CString(0))
		  Loop
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(From() As String)
		  ' Overloads the conversion operator(=), permitting implicit and explicit conversion from a string array into a ListPtr
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ListPtr.Operator_Convert
		  
		  If mLastError = libcURL.Errors.NOT_INITIALIZED Then
		    Me.Constructor()
		  Else
		    Me.Destructor()
		  End If
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
