#tag Class
Class VTJob
	#tag Method, Flags = &h0
		Sub Constructor(File As FolderItem, Algorithm As Integer)
		  Me.TargetFile = File
		  Me.Algorithm = Algorithm
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetResults()
		  Dim js As JSONItem = VTHash.GetReport(Me.Hash, VTAPIKey, VTHash.RequestType.FileReport)
		  If js <> Nil Then
		    mResponse = New Results(js)
		    Me.Response.HashValue = Me.Hash
		    Me.Response.TargetFile = Me.TargetFile
		    Me.Response.Algorithm = Me.Algorithm
		  Else
		    Call MsgBox("VirusTotal.com responded with an illegal or empty object. Please try again in a few minutes.", 16, "Parse Error")
		    Quit(1)
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Algorithm As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mHash = "" Then
			    Dim bs As BinaryStream
			    Dim hp As New Win32.Crypto.HashProcessor(Me.Algorithm)
			    bs = bs.Open(Me.TargetFile)
			    While Not bs.EOF
			      hp.Process(bs.Read(4 * 1024))
			    Wend
			    bs.Close
			    mHash = ConvertEncoding(Win32.Crypto.EncodeHex(hp.Value).Uppercase, Encodings.UTF8)
			  End If
			  return mHash
			End Get
		#tag EndGetter
		Hash As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResponse As Results
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mResponse
			End Get
		#tag EndGetter
		Response As Results
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		TargetFile As FolderItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Algorithm"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hash"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
