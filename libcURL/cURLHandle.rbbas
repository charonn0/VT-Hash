#tag Class
Protected Class cURLHandle
Implements ErrorSetter
	#tag Method, Flags = &h1
		Protected Sub Constructor(GlobalInitFlags As Integer)
		  ' Initializes libcURL if necessary. GlobalInitFlags is one of the CURL_GLOBAL_* constants.
		  ' This class keeps track of which flags have already been initialized, and only initializes
		  ' libcURL if GlobalInitFlags is not among them.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_global_init.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/cURLHandle.Constructor
		  
		  If Not libcURL.IsAvailable Then
		    Dim err As New PlatformNotSupportedException
		    err.Message = "libcURL is not available or is an unsupported version."
		    Raise err
		  End If
		  
		  If InitFlags = Nil Then InitFlags = New Dictionary
		  If Not InitFlags.HasKey(GlobalInitFlags) Then
		    mLastError = curl_global_init(GlobalInitFlags)
		    If mLastError <> 0 Then Raise New cURLException(Me)
		  End If
		  InitFlags.Value(GlobalInitFlags) = InitFlags.Lookup(GlobalInitFlags, 0) + 1
		  mFlags = GlobalInitFlags
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  ' Decrements the reference count for the instance's Flags. If the count reaches zero
		  ' calls curl_global_cleanup.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_global_cleanup.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/cURLHandle.Destructor
		  
		  If InitFlags = Nil Then Return
		  InitFlags.Value(mFlags) = InitFlags.Value(mFlags) - 1
		  If InitFlags.Value(mFlags) <= 0 Then
		    If libcURL.IsAvailable Then curl_global_cleanup()
		    InitFlags.Remove(mFlags)
		  End If
		  If InitFlags.Count = 0 Then InitFlags = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flags() As Integer
		  ' The global initialization flags that were passed to the instance Constructor
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/cURLHandle.Flags
		  
		  Return mFlags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Handle() As Integer
		  ' the curl handle itself
		  Return mHandle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As Integer
		  ' All calls into libcURL that return an error code will update LastError
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/cURLHandle.LastError
		  
		  Return mLastError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LastError(Assigns NewError As Integer)
		  // Part of the ErrorSetter interface.
		  mLastError = NewError
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherHandle As libcURL.cURLHandle) As Integer
		  If OtherHandle Is Nil Then Return 1
		  Return Sign(Me.Flags - OtherHandle.Flags)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared InitFlags As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFlags As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mHandle As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastError As Integer
	#tag EndProperty


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
