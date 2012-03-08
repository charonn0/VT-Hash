#tag Module
Protected Module Debugging
	#tag Method, Flags = &h0
		Sub debug(err As Boolean = False, message As String)
		  If err Then
		    System.DebugLog("Faster!: The system experienced an error.")
		    System.DebugLog("       System said:")
		    System.DebugLog("       " + FormatErrorMessage)
		    System.DebugLog("       Faster! said:")
		    System.DebugLog("       " + message)
		  Else
		    System.DebugLog("Faster!: " + message)
		  End If
		  
		  
		  
		Exception error
		  System.DebugLog("Faster!: Oh, shit!")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatErrorMessage() As String
		  ///Gets lasterror and formats system message
		  ///If format fails, return lasterror
		  Dim ret As Integer
		  Dim buffer As memoryBlock
		  Declare Function FormatMessageW Lib "kernel32" (dwFlags As Integer, lpSource As Integer, dwMessageId As Integer, dwLanguageId As Integer, lpBuffer As ptr, _
		  nSize As Integer, Arguments As Integer) As Integer
		  
		  Const FORMAT_MESSAGE_FROM_SYSTEM = &H1000
		  
		  buffer = New MemoryBlock(2048)
		  ret = FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM, 0, GetLastError, 0 , Buffer, Buffer.Size, 0)
		  If ret <> 0 then
		    Return Buffer.WString(0)
		  End If
		  
		  Return str(GetLastError)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLastError() As Integer
		  Declare Function GetLastError Lib "Kernel32" () As Integer
		  Return GetLastError
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
End Module
#tag EndModule
