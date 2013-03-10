#tag Class
Protected Class hasher
Inherits Thread
	#tag Method, Flags = &h0
		Function hashIt(input As FolderItem, algorithm As String) As string
		  if not cancel then
		    dim hash As String
		    dim tis As TextInputStream
		    Window1.ProgressBar1.Value = 1
		    tis = tis.Open(input)
		    fileData = tis.ReadAll
		    tis.Close
		    Window1.ProgressBar1.Value = 2
		    
		    Select Case algorithm
		    case "SHA1"
		      Return Win32Crypto.Hash(fileData, Win32Crypto.CALG_SHA1)
		    case "MD5"
		      Return MD5Hash(toBeHashed, 1048576)
		    end Select
		  else
		    self.Kill
		  end if
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InheritedFrom="Thread"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="Thread"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Thread"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			InheritedFrom="Thread"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Thread"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Thread"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="Thread"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
