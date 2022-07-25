#tag Class
Protected Class MIMEMessagePart
	#tag Method, Flags = &h1
		Protected Sub Constructor(ItemStruct As Ptr, Owner As libcURL.MIMEMessage)
		  ' Constructs a new MIMEMessagePart. Generally, you should not construct instances of
		  ' this class. Use the value returned from MIMEMessage.FirstPart, MIMEMessagePart.NextPart,
		  ' or MIMEMessage.SubPart instead.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.Constructor
		  
		  mOwner = Owner
		  mStruct = ItemStruct
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherMIMEPart As libcURL.MIMEMessagePart) As Integer
		  ' Overloads the comparison operator(=), permitting direct comparisons between instances of MIMEMessagePart.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.Operator_Compare
		  
		  If OtherMIMEPart Is Nil Then Return 1
		  Return Sign(Integer(mStruct) - Integer(OtherMIMEPart.mStruct))
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the message part is a file part (regardless of whether an actual file is used), then this
			  ' property will return the MIMEType being used.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.ContentType
			  
			  Dim mb As MemoryBlock
			  #If Target32Bit Then
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			      mb = Struct_7_75_0.MIMEType
			    Else
			      mb = Struct.MIMEType
			    End If
			  #Else
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then
			      mb = Struct64_7_75_0.MIMEType
			    Else
			      mb = Struct64.MIMEType
			    End If
			  #endif
			  If mb <> Nil Then Return mb.CString(0)
			End Get
		#tag EndGetter
		ContentType As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the message part is not a Readable object, then this property will return a copy of the value.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.Data
			  
			  Dim mb As MemoryBlock
			  #If Target32Bit Then
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			      mb = Struct_7_75_0.Data
			    Else
			      mb = Struct.Data
			    End If
			  #Else
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then
			      mb = Struct64_7_75_0.Data
			    Else
			      mb = Struct64.Data
			    End If
			  #endif
			  If mb <> Nil Then
			    Select Case Me.Type
			    Case MIMEPartType.File ' file path
			      Return mb.CString(0)
			    Case MIMEPartType.Data
			      If DataSize > 0 Then
			        Return mb.StringValue(0, DataSize)
			      Else
			        Return mb.CString(0)
			      End If
			    End Select
			  End If
			End Get
		#tag EndGetter
		Data As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the message part is not a Readable object, then this property will return the size of the value.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.DataSize
			  
			  #If Target32Bit Then
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			      Return Struct_7_75_0.DataSize
			    Else
			      Return Struct.DataSize
			    End If
			  #Else
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then
			      Return Struct64_7_75_0.DataSize
			    Else
			      Return Struct64.DataSize
			    End If
			  #endif
			End Get
		#tag EndGetter
		DataSize As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the message part is a file part (regardless of whether an actual file is used), then
			  ' this property will return the file name being used.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.FileName
			  
			  Dim mb As MemoryBlock
			  #If Target32Bit Then
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			      mb = Struct_7_75_0.FileName
			    Else
			      mb = Struct.FileName
			    End If
			  #Else
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then
			      mb = Struct64_7_75_0.FileName
			    Else
			      mb = Struct64.FileName
			    End If
			  #endif
			  If mb <> Nil Then Return mb.CString(0)
			End Get
		#tag EndGetter
		FileName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the flags for the message part.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.Flags
			  
			  #If Target32Bit Then
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			      Return Struct_7_75_0.Flags
			    Else
			      Return Struct.Flags
			    End If
			  #Else
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then
			      Return Struct64_7_75_0.Flags
			    Else
			      Return Struct64.Flags
			    End If
			  #endif
			End Get
		#tag EndGetter
		Flags As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' A list of default headers that will be included with the message part. If no default
			  ' headers were specified then this property will be Nil.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.Headers
			  
			  If mHeaders = Nil Then
			    Dim p As Ptr
			    #If Target32Bit Then
			      If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			        p = Struct_7_75_0.Headers
			      Else
			        p = Struct.Headers
			      End If
			    #Else
			      If libcURL.Version.IsAtLeast(7, 75, 0) Then
			        p = Struct64_7_75_0.Headers
			      Else
			        p = Struct64.Headers
			      End If
			    #endif
			    If p <> Nil Then mHeaders = New ListPtr(p)
			  End If
			  Return mHeaders
			End Get
		#tag EndGetter
		Headers As libcURL.ListPtr
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mHeaders As libcURL.ListPtr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOwner As libcURL.MIMEMessage
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStruct As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUserHeaders As libcURL.ListPtr
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the name of the message part.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.Name
			  
			  Dim mb As MemoryBlock
			  #If Target32Bit Then
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			      mb = Struct_7_75_0.Name
			    Else
			      mb = Struct.Name
			    End If
			  #Else
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			      mb = Struct64_7_75_0.Name
			    Else
			      mb = Struct64.Name
			    End If
			  #endif
			  If mb <> Nil Then Return mb.CString(0)
			  
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' MIME messages are stored as a linked list. This property allows you to traverse the list from first to last.
			  ' The last part will have Nil as its NextPart.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.NextPart
			  
			  Dim p As Ptr
			  #If Target32Bit Then
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			      p = Struct_7_75_0.NextPart
			    Else
			      p = Struct.NextPart
			    End If
			  #Else
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then
			      p = Struct64_7_75_0.NextPart
			    Else
			      p = Struct64.NextPart
			    End If
			  #endif
			  If p <> Nil Then Return New MIMEMessagePart(p, mOwner)
			End Get
		#tag EndGetter
		NextPart As libcURL.MIMEMessagePart
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a reference to the Readable object from which the message part contents will be read when
			  ' the message is actually sent to a server. If the part Type is not MIMEPartType.Callback then
			  ' this will be Nil.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.Stream
			  
			  If Me.Type <> MIMEPartType.Callback Then Return Nil
			  Dim p As Ptr = Me.UserData
			  If p <> Nil Then Return FormStreamGetter(mOwner).GetStream(p)
			End Get
		#tag EndGetter
		Stream As Readable
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If mStruct <> Nil Then Return mStruct.curl_mimepart
			End Get
		#tag EndGetter
		Protected Struct As curl_mimepart
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If mStruct <> Nil Then Return mStruct.curl_mimepart64
			End Get
		#tag EndGetter
		Protected Struct64 As curl_mimepart64
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If mStruct <> Nil Then Return mStruct.curl_mimepart64_7_75_0
			End Get
		#tag EndGetter
		Protected Struct64_7_75_0 As curl_mimepart64_7_75_0
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If mStruct <> Nil Then Return mStruct.curl_mimepart_7_75_0
			End Get
		#tag EndGetter
		Protected Struct_7_75_0 As curl_mimepart_7_75_0
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If the message contains several file parts then this property returns the first extra file. Use the
			  ' NextPart property of the returned MIMEMessagePart to iterate over the file list. If the part
			  ' Type is not MIMEPartType.Multipart then this will be Nil.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.SubPart
			  
			  If Me.Type <> MIMEPartType.Multipart Then Return Nil
			  Return New MIMEMessageCreator(Me.UserData, mOwner)
			End Get
		#tag EndGetter
		SubPart As libcURL.MIMEMessage
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns a member of the MIMEPartType enum.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.Type
			  
			  #If Target32Bit Then
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			      Return CType(Struct_7_75_0.Kind, MIMEPartType)
			    Else
			      Return CType(Struct.Kind, MIMEPartType)
			    End If
			  #Else
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then
			      Return CType(Struct64_7_75_0.Kind, MIMEPartType)
			    Else
			      Return CType(Struct64.Kind, MIMEPartType)
			    End If
			  #endif
			  
			End Get
		#tag EndGetter
		Type As libcURL.MIMEPartType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' An opaque value used in callback functions. If the Type is not MIMEPartType.Callback then this property
			  ' may be nil.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.UserData
			  
			  #If Target32Bit Then
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			      Return Struct_7_75_0.UserData
			    Else
			      Return Struct.UserData
			    End If
			  #Else
			    If libcURL.Version.IsAtLeast(7, 75, 0) Then
			      Return Struct64_7_75_0.UserData
			    Else
			      Return Struct64.UserData
			    End If
			  #endif
			End Get
		#tag EndGetter
		UserData As Ptr
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' A list of custom headers that will be included with the message part. If no custom
			  ' headers were specified then this property will be Nil.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MIMEMessagePart.UserHeaders
			  
			  If mUserHeaders = Nil Then
			    Dim p As Ptr
			    #If Target32Bit Then
			      If libcURL.Version.IsAtLeast(7, 75, 0) Then ' libcURL changed the order of structure members as of this version
			        p = Struct_7_75_0.UserHeaders
			      Else
			        p = Struct.UserHeaders
			      End If
			    #Else
			      If libcURL.Version.IsAtLeast(7, 75, 0) Then
			        p = Struct64_7_75_0.UserHeaders
			      Else
			        p = Struct64.UserHeaders
			      End If
			    #endif
			    If p <> Nil Then mUserHeaders = New ListPtr(p)
			  End If
			  Return mUserHeaders
			End Get
		#tag EndGetter
		UserHeaders As libcURL.ListPtr
	#tag EndComputedProperty


	#tag Structure, Name = curl_mimepart, Flags = &h21, Attributes = \"StructureAlignment \x3D 1"
		Easy As Integer
		  Parent As Ptr
		  NextPart As Ptr
		  Kind As Int32
		  Data As Ptr
		  ReadFunc As Ptr
		  SeekFunc As Ptr
		  FreeFunc As Ptr
		  UserData As Ptr
		  FilePtr As Ptr
		  Headers As Ptr
		  UserHeaders As Ptr
		  MIMEType As Ptr
		  FileName As Ptr
		  Name As Ptr
		  DataSize As UInt32
		  Flags As UInt32
		  State As Integer
		  Encoder As Ptr
		EncoderState As Integer
	#tag EndStructure

	#tag Structure, Name = curl_mimepart64, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
		Easy As Integer
		  Parent As Ptr
		  NextPart As Ptr
		  Kind As Int32
		  Data As Ptr
		  ReadFunc As Ptr
		  SeekFunc As Ptr
		  FreeFunc As Ptr
		  UserData As Ptr
		  FilePtr As Ptr
		  Headers As Ptr
		  UserHeaders As Ptr
		  MIMEType As Ptr
		  FileName As Ptr
		  Name As Ptr
		  DataSize As UInt32
		  Flags As UInt32
		  State As Integer
		  Encoder As Ptr
		EncoderState As Integer
	#tag EndStructure

	#tag Structure, Name = curl_mimepart64_7_75_0, Flags = &h21, Attributes = \"StructureAlignment \x3D 8"
		Easy As Integer
		  Parent As Ptr
		  NextPart As Ptr
		  Kind As Int32
		  Flags As UInt32
		  Data As Ptr
		  ReadFunc As Ptr
		  SeekFunc As Ptr
		  FreeFunc As Ptr
		  UserData As Ptr
		  FilePtr As Ptr
		  Headers As Ptr
		  UserHeaders As Ptr
		  MIMEType As Ptr
		  FileName As Ptr
		  Name As Ptr
		  DataSize As UInt32
		  State As Integer
		  Encoder As Ptr
		EncoderState As Integer
	#tag EndStructure

	#tag Structure, Name = curl_mimepart_7_75_0, Flags = &h21, Attributes = \"StructureAlignment \x3D 1"
		Easy As Integer
		  Parent As Ptr
		  NextPart As Ptr
		  Kind As Int32
		  Flags As UInt32
		  Data As Ptr
		  ReadFunc As Ptr
		  SeekFunc As Ptr
		  FreeFunc As Ptr
		  UserData As Ptr
		  FilePtr As Ptr
		  Headers As Ptr
		  UserHeaders As Ptr
		  MIMEType As Ptr
		  FileName As Ptr
		  Name As Ptr
		  DataSize As UInt32
		  State As Integer
		  Encoder As Ptr
		EncoderState As Integer
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="ContentType"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Data"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FileName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Flags"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
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
		#tag ViewProperty
			Name="DataSize"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="UInt32"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="libcURL.MIMEPartType"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Data"
				"2 - File"
				"3 - Callback"
				"4 - Multipart"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
