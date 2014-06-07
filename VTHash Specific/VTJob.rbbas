#tag Class
Protected Class VTJob
	#tag Method, Flags = &h0
		Sub Constructor(File As FolderItem, Algorithm As Integer)
		  Me.TargetFile = File
		  Me.Algorithm = Algorithm
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetResults()
		  Dim js As JSONItem = VTAPI.GetReport(Me.Hash, VTAPIKey, VTAPI.RequestType.FileReport)
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
			    Dim fileData As String
			    
			    bs = bs.Open(Me.TargetFile)
			    fileData = bs.Read(bs.Length)
			    bs.Close
			    
			    Select Case Me.Algorithm
			    case Results.ALG_SHA1
			      mHash = Win32Crypto.Hash(fileData, Win32Crypto.CALG_SHA1)
			    case Results.ALG_MD5
			      mHash = Win32Crypto.Hash(fileData, Win32Crypto.CALG_MD5)
			    end Select
			  End If
			  
			  return mHash
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHash = value
			End Set
		#tag EndSetter
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
