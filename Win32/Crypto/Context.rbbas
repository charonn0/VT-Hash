#tag Class
Protected Class Context
	#tag Method, Flags = &h0
		Sub Constructor(ProviderID As String, ProviderType As Integer)
		  ' See: http://msdn.microsoft.com/en-us/library/windows/desktop/aa386983%28v=vs.85%29.aspx
		  Select Case True
		  Case Win32.Libs.AdvApi32.CryptAcquireContext(mProvider, 0, ProviderID, ProviderType, 0)
		    mLastError = 0
		    
		    'Case Win32.Libs.AdvApi32.CryptAcquireContext(mProvider, 0, ProviderID, ProviderType, CRYPT_NEWKEYSET)
		    'mLastError = 0
		    
		  Case Win32.Libs.AdvApi32.CryptAcquireContext(mProvider, 0, ProviderID, ProviderType, CRYPT_VERIFYCONTEXT)
		    mLastError = 0
		    
		  Else
		    mLastError = Win32.LastError
		  End Select
		  
		  If mLastError <> 0 Then
		    Dim err As New Win32Exception
		    err.ErrorNumber = mLastError
		    err.Message = Win32.FormatError(mLastError)
		    Raise err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(DuplicateContext As Win32.Crypto.Context)
		  If Win32.Libs.AdvApi32.CryptContextAddRef(DuplicateContext.Provider, Nil, 0) Then ' increment ref count
		    mProvider = DuplicateContext.Provider
		    
		  Else
		    mLastError = Win32.LastError
		    Dim err As New Win32Exception
		    err.ErrorNumber = mLastError
		    err.Message = Win32.FormatError(mLastError)
		    Raise err
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  If Not Win32.Libs.AdvApi32.CryptReleaseContext(mProvider, 0) Then
		    mLastError = Win32.LastError
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetProviderParam(Type As Integer, ByRef Buffer As MemoryBlock, Flags As Integer) As Boolean
		  ' If Buffer is Nil and no error occurs, on return Buffer will be instantiated with the correct size of the data.
		  ' Call this method again with the same parameters to fill the Buffer.
		  Dim buffersz As Integer
		  Dim p As Ptr
		  If Buffer <> Nil Then
		    p = Buffer
		    buffersz = buffer.Size
		  End If
		  If Not Win32.Libs.AdvApi32.CryptGetProvParam(mProvider, Type, p, buffersz, Flags) Then
		    mLastError = Win32.LastError
		    Return False
		  Else
		    If Buffer = Nil Then Buffer = New MemoryBlock(buffersz)
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As Integer
		  // Part of the Win32Object interface.
		  Return mLastError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherContext As Win32.Crypto.Context) As Integer
		  Select Case True
		  Case OtherContext Is Nil
		    Return 1
		  Case OtherContext.Provider > mProvider
		    Return -1
		  Case OtherContext.Provider < mProvider
		    Return 1
		  Case OtherContext.Provider = mProvider
		    Return 0
		  End Select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Provider() As Integer
		  Return mProvider
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProviderName() As String
		  Dim mb As MemoryBlock
		  ' first call allocates a buffer big enough for the second call
		  If Me.GetProviderParam(PP_NAME, mb, 0) Then ' on in mb is Nil
		    If Me.GetProviderParam(PP_NAME, mb, 0) Then ' on in mb is a MemoryBlock of correct size
		      Return mb.CString(0)
		    Else
		      mLastError = Win32.LastError
		    End If
		  Else
		    mLastError = Win32.LastError
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetProviderParam(Type As Integer, Buffer As MemoryBlock, Flags As Integer) As Boolean
		  If Not Win32.Libs.AdvApi32.CryptSetProvParam(mProvider, Type, buffer, Flags) Then
		    mLastError = Win32.LastError
		    Return False
		  Else
		    Return True
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mLastError As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mProvider As Integer
	#tag EndProperty


	#tag Constant, Name = NTE_BAD_UID, Type = Double, Dynamic = False, Default = \"&h80090001", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PP_NAME, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant


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
