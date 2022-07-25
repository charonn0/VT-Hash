#tag Class
Protected Class cURLHandle
Implements ErrorSetter
	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  ' Initializes libcURL if necessary. 
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_global_init.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLHandle.Constructor
		  
		  Static available As Boolean = libcURL.IsAvailable
		  If Not available Then
		    Dim err As New PlatformNotSupportedException
		    err.Message = "libcURL is not available or is an unsupported version."
		    ' We can't find the libcurl binary or one of its dependencies (OpenSSL, zlib, etc.) Verify
		    ' that all neccesary dll/solib/dylib files are located in the expected directory for your
		    ' environment. The easiest way to avoid this problem is to add a build step to your project
		    ' that copies the necessary files automatically.
		    ' See: http://docs.xojo.com/UserGuide:Build_Automation#Copy_Files
		    Raise err
		  End If
		  
		  mLastError = 0 ' clears the NOT_INITIALIZED default value
		  
		  If InitFlag = libcURL.Errors.INIT_FAILED Then
		    mLastError = curl_global_init(CURL_GLOBAL_DEFAULT)
		    If mLastError <> 0 Then
		      ' We were not able to initialize libcurl (or a dependency) even though the binary was
		      ' successfully loaded.
		      Raise New cURLException(Me)
		    End If
		  End If
		  mFlags = CURL_GLOBAL_DEFAULT
		  InitFlag = CURL_GLOBAL_DEFAULT
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  ' Decrements the reference count for the instance's Flags. If the count reaches zero
		  ' calls curl_global_cleanup.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_global_cleanup.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLHandle.Destructor
		  
		  If InitFlags = Nil Then Return
		  Do Until InitFlagsLock.TrySignal
		    #If RBVersion < 2020 Then
		      App.YieldToNextThread
		    #Else
		      Thread.YieldToNext
		    #EndIf
		  Loop
		  Try
		    InitFlags.Value(mFlags) = InitFlags.Value(mFlags) - 1
		    If InitFlags.Value(mFlags) <= 0 Then
		      If libcURL.IsAvailable Then curl_global_cleanup()
		      InitFlags.Remove(mFlags)
		    End If
		    If InitFlags.Count = 0 Then InitFlags = Nil
		  Finally
		    InitFlagsLock.Release
		  End Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( deprecated )  Function Flags() As Integer
		  ' The global initialization flags that were passed to the instance Constructor
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLHandle.Flags
		  
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
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.cURLHandle.LastError
		  
		  Return mLastError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LastError(Assigns NewError As Integer)
		  // Part of the ErrorSetter interface.
		  mLastError = NewError
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Operator_Compare(OtherHandle As libcURL.cURLHandle) As Integer
		  If OtherHandle Is Nil Then Return 1
		  Return Sign(mFlags - OtherHandle.mFlags)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared InitFlag As Integer = libcURL.Errors.INIT_FAILED
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared InitFlags As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared InitFlagsLock As Semaphore
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFlags As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mHandle As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastError As Integer = libcURL.Errors.NOT_INITIALIZED
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
