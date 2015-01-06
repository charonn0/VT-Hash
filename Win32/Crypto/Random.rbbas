#tag Class
Protected Class Random
Inherits Win32.Crypto.Context
	#tag Method, Flags = &h1000
		Sub Constructor()
		  Super.Constructor(BaseProvider)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Generate(ByteCount As Integer) As MemoryBlock
		  Dim mb As New MemoryBlock(ByteCount)
		  If Not Win32.Libs.AdvApi32.CryptGenRandom(Me.Provider, mb.Size, mb) Then
		    mLastError = Win32.LastError
		  Else
		    Return mb
		  End If
		  
		End Function
	#tag EndMethod


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
