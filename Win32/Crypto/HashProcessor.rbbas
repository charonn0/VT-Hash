#tag Class
Protected Class HashProcessor
Inherits Win32.Crypto.Context
	#tag Method, Flags = &h0
		Function Algorithm() As Integer
		  Dim alg As New MemoryBlock(4)
		  If Not Me.GetHashParam(HP_ALGID, alg) Then
		    Dim err As New Win32Exception
		    err.ErrorNumber = mLastError
		    err.Message = Win32.FormatError(mLastError)
		    Raise err
		  End If
		  Return alg.Int32Value(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Algorithm As Integer, Key As Win32.Crypto.KeyContainer = Nil)
		  Select Case Algorithm
		  Case CALG_MD2, CALG_MD4, CALG_MD5, CALG_SHA1
		    Super.Constructor(EnhancedProvider)
		  Case CALG_SHA256, CALG_SHA384, CALG_SHA512
		    Super.Constructor(AESProvider)
		  Else
		    Raise New UnsupportedFormatException
		  End Select
		  
		  Dim kh As Integer
		  If Key <> Nil Then kh = Key.Handle
		  If Not Win32.Libs.AdvApi32.CryptCreateHash(Me.Provider, Algorithm, kh, 0, mHandle) Then
		    mLastError = Win32.LastError
		    Dim err As New Win32Exception
		    err.ErrorNumber = mLastError
		    err.Message = Win32.FormatError(mLastError)
		    Raise err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(DuplicateHash As Win32.Crypto.HashProcessor)
		  // Calling the overridden superclass constructor.
		  // Constructor(DuplicateContext As Win32.Crypto.Context) -- From Context
		  Super.Constructor(DuplicateHash)
		  If Not Win32.Libs.AdvApi32.CryptDuplicateHash(DuplicateHash.mHandle, 0, 0, mHandle) Then
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
		  If Not Win32.Libs.AdvApi32.CryptDestroyHash(mHandle) Then
		    mLastError = Win32.LastError
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetHashParam(Type As Integer, Buffer As MemoryBlock) As Boolean
		  Dim buffersz As Integer = buffer.Size
		  If Not Win32.Libs.AdvApi32.CryptGetHashParam(mHandle, Type, buffer, buffersz, 0) Then
		    mLastError = Win32.LastError
		    Return False
		  Else
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Handle() As Integer
		  Return mHandle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Process(NewData As MemoryBlock)
		  If Not Win32.Libs.AdvApi32.CryptHashData(mHandle, NewData, NewData.Size, 0) Then
		    mLastError = Win32.LastError
		    Dim err As New Win32Exception
		    err.ErrorNumber = mLastError
		    err.Message = Win32.FormatError(mLastError)
		    Raise err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetHashParam(Type As Integer, Buffer As MemoryBlock, Flags As Integer) As Boolean
		  If Not Win32.Libs.AdvApi32.CryptSetHashParam(mHandle, Type, buffer, Flags) Then
		    mLastError = Win32.LastError
		    Return False
		  Else
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As String
		  Dim buffer As New MemoryBlock(4)
		  If Not Me.GetHashParam(HP_HASHSIZE, buffer) Then
		    Dim err As New Win32Exception
		    err.ErrorNumber = mLastError
		    err.Message = Win32.FormatError(mLastError)
		    Raise err
		  End If
		  buffer = New MemoryBlock(buffer.Int32Value(0))
		  If Not Me.GetHashParam(HP_HASHVAL, buffer) Then
		    Dim err As New Win32Exception
		    err.ErrorNumber = mLastError
		    err.Message = Win32.FormatError(mLastError)
		    Raise err
		  End If
		  Return buffer
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mHandle As Integer = INVALID_HANDLE_VALUE
	#tag EndProperty


	#tag Constant, Name = HP_ALGID, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HP_HASHSIZE, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = HP_HASHVAL, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
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
