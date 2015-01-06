#tag Class
Protected Class Stream
Implements Readable,Writeable
	#tag Method, Flags = &h0
		Sub Close()
		  If mWriter <> Nil And mKey <> Nil Then
		    mWriter.Write(mKey.Encrypt("", True, mHash))
		    mWriter.Flush
		  End If
		  mWriter = Nil
		  mReader = Nil
		  mKey = Nil
		  mHash = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Key As Win32.Crypto.KeyContainer)
		  mKey = Key
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Key As Win32.Crypto.KeyContainer, Output As Writeable, Hash As Win32.Crypto.HashProcessor = Nil) As Win32.Crypto.Stream
		  Dim c As New Win32.Crypto.Stream(Key)
		  c.mWriter = Output
		  c.mHash = Hash
		  Return c
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Close()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EOF() As Boolean
		  // Part of the Readable interface.
		  If mReader <> Nil Then
		    Return mReader.EOF
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flush()
		  // Part of the Writeable interface.
		  If mWriter <> Nil Then
		    mWriter.Flush
		  Else
		    Raise New IOException
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HashValue() As MemoryBlock
		  If mHash <> Nil Then Return mHash.Value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Open(Key As Win32.Crypto.KeyContainer, InputData As Readable) As Win32.Crypto.Stream
		  Dim c As New Win32.Crypto.Stream(Key)
		  c.mReader = InputData
		  Return c
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Read(Count As Integer, encoding As TextEncoding = Nil) As String
		  // Part of the Readable interface.
		  If mReader <> Nil Then
		    Dim data As MemoryBlock = mReader.Read(Count)
		    data = mKey.Decrypt(data, False, mHash)
		    Return DefineEncoding(data, encoding)
		  Else
		    Raise New IOException
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReadError() As Boolean
		  // Part of the Readable interface.
		  If mReader <> Nil Then
		    Return mReader.ReadError Or mKey.LastError <> 0
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write(text As String)
		  // Part of the Writeable interface.
		  If mWriter <> Nil Then
		    mWriter.Write(mKey.Encrypt(text, False, mHash))
		  Else
		    Raise New IOException
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WriteError() As Boolean
		  // Part of the Writeable interface.
		  If mWriter <> Nil Then
		    Return mWriter.WriteError Or mKey.LastError <> 0
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHash As Win32.Crypto.HashProcessor
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mKey As Win32.Crypto.KeyContainer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mReader As Readable
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWriter As Writeable
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
