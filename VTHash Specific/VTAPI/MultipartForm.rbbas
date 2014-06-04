#tag Class
Private Class MultipartForm
	#tag Method, Flags = &h0
		Sub Constructor()
		  mFormElements = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return mFormElements.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Element(Name As String) As Variant
		  Return mFormElements.Value(Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Element(Name As String, Assigns Value As Variant)
		  If Value = Nil Then
		    mFormElements.Remove(Name)
		  Else
		    mFormElements.Value(Name) = Value
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FromData(Data As String, Boundary As String) As MultipartForm
		  Dim form As New MultipartForm
		  Dim elements() As String = Split(Data, "--" + Boundary + CRLF)
		  form.Boundary = Boundary
		  
		  Dim ecount As Integer = UBound(elements)
		  For i As Integer = 1 To ecount
		    Dim line As String = NthField(elements(i), CRLF, 1)
		    Dim name As String = NthField(line, ";", 2)
		    name = NthField(name, "=", 2)
		    name = ReplaceAll(name, """", "")
		    If name.Trim = "" Then Continue For i
		    If CountFields(line, ";") < 3 Then 'form data
		      form.Element(name) = NthField(elements(i), CRLF + CRLF, 2)
		    Else 'file
		      Dim filename As String = NthField(line, ";", 3)
		      filename = NthField(filename, "=", 2)
		      filename = ReplaceAll(filename, """", "")
		      Dim tmp As FolderItem = SpecialFolder.Temporary.Child(filename)
		      Try
		        Dim bs As BinaryStream = BinaryStream.Create(tmp, True)
		        Dim filedata As MemoryBlock = elements(i)
		        Dim t As Integer = InStr(filedata, CRLF + CRLF) + 3
		        filedata = filedata.StringValue(t, filedata.Size - t - 2)
		        bs.Write(filedata)
		        bs.Close
		        form.Element(filename) = tmp
		      Catch Err As IOException
		        Continue For i
		      End Try
		    End If
		  Next
		  
		  Return form
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasElement(Name As String) As Boolean
		  Return mFormElements.HasKey(Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name(Index As Integer) As String
		  Dim s() As Variant = mFormElements.Keys
		  Return s(Index).StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Dim data As String
		  For Each key As String In mFormElements.Keys
		    If VarType(mFormElements.Value(Key)) = Variant.TypeString Then
		      data = data + "--" + Me.Boundary + CRLF
		      data = data + "Content-Disposition: form-data; name=""" + key + """" + CRLF + CRLF
		      data = data + mFormElements.Value(key) + CRLF
		    ElseIf mFormElements.Value(Key) IsA FolderItem Then
		      Dim file As FolderItem = mFormElements.Value(key)
		      data = data + "--" + Me.Boundary + CRLF
		      data = data + "Content-Disposition: form-data; name=""file""; filename=""" + File.Name + """" + CRLF
		      Dim type As New ContentType(file)
		      data = data + "Content-Type: " + type.ToString + CRLF + CRLF
		      Dim bs As BinaryStream = BinaryStream.Open(File)
		      data = data + bs.Read(bs.Length) + CRLF
		      bs.Close
		    End If
		  Next
		  
		  data = data + "--" + Me.Boundary + "--" + CRLF
		  
		  Return "Content-Type: multipart/form-data; boundary=" + Me.Boundary + CRLF + CRLF + data
		End Function
	#tag EndMethod


	#tag Note, Name = About this class
		This class allows you to construct a multipart/formdata object.
		
		Add or remove
	#tag EndNote


	#tag Property, Flags = &h0
		Boundary As String = "bOrEdOmSoFtBoUnDaRy"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFormElements As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Boundary"
			Group="Behavior"
			InitialValue="--bOrEdOmSoFtBoUnDaRy"
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
