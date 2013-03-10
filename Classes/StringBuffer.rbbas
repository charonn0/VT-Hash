#tag Class
Protected Class StringBuffer
	#tag Method, Flags = &h0
		Sub Append(text as String)
		  dim lb as uint64 = text.lenB
		  dim targetSize as uint64 = data.Size
		  while binaryLength + lb > targetSize
		    targetSize = targetSize * 2
		  wend
		  data.Size = targetSize
		  data.StringValue(binaryLength,lb) = text
		  binaryLength = binaryLength + lb
		  length = length + text.Len
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(text as String)
		  Constructor(text.LenB)
		  Append text
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(defaultSize as uint64 = 1024)
		  data = New MemoryBlock(defaultSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Len() As UInt64
		  return length
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LenB() As UInt64
		  return LenB
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  return StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(text as String)
		  if data = nil then
		    Constructor
		  else
		    length = 0
		    binaryLength = 0
		  end
		  Append text
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As String
		  return data.StringValue(0,binaryLength)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private binaryLength As uint64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private data As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private length As uint64
	#tag EndProperty


	#tag Constant, Name = version, Type = Double, Dynamic = False, Default = \"1.0", Scope = Public
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
