#tag Class
Class PrefStore
	#tag Method, Flags = &h0
		Sub Close()
		  mVolume.Flush
		  mVolume = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(VolumeRef As VirtualVolume)
		  If VolumeRef = Nil Then Raise New NilObjectException
		  mVolume = VolumeRef
		  Dim f As FolderItem = mVolume.Root.Child(".META")
		  If Not f.Exists Then
		    f.CreateAsFolder
		  End If
		  If Not f.Directory Then
		    Raise New RuntimeException ' not a PrefStore
		  Else
		    If ReadValue(f.Child("PATH_SEPARATOR")).StringValue <> "" Then
		      mPathSeparator = Me.ReadValue(f.Child("PATH_SEPARATOR"))
		    Else
		      Me.WriteValue(f.Child("PATH_SEPARATOR"), PathSeparator)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CopyItem(Source As String, Destination As String) As Boolean
		  Dim value As Variant = Me.GetValue(Source)
		  Me.SetValue(Destination) = value
		  mVolume.Flush
		  Return Me.GetValue(Source) = Me.GetValue(Destination)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count(Path As String) As Integer
		  Dim f As FolderItem = Me.Locate(Path)
		  If f <> Nil And f.Exists And f.Directory Then
		    Dim x As Integer
		    For i As Integer = 0 To f.Count - 1
		      Dim item As FolderItem = f.Item(i)
		      If Right(item.Name, 5) = ".META" Then Continue
		      x = x + 1
		    Next
		    Return x
		  End If
		  Raise New NilObjectException
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(RegFile As FolderItem) As PrefStore
		  Try
		    Return New PrefStore(RegFile.CreateVirtualVolume)
		  Catch
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateDirectory(Path As String, CreateParents As Boolean) As Boolean
		  Dim parts() As String = Split(Path, PathSeparator)
		  Dim paths As String
		  For i As Integer = 0 To UBound(parts)
		    paths = paths + parts(i)
		    Dim item As FolderItem = Me.Locate(paths)
		    If item = Nil Then Return False
		    If item.Name.Trim <> "" Then Break
		    If i <> UBound(parts) Then
		      paths = paths + PathSeparator
		      If Not item.Exists Then
		        If CreateParents Then item.CreateAsFolder Else Return False
		      End If
		    End If
		  Next
		  Dim f As FolderItem = Me.Locate(paths)
		  If f = Nil Or f.Exists Then Return False
		  If f.Name.Trim <> "" Then Break
		  f.CreateAsFolder
		  Me.WriteType(f, TYPE_DIRECTORY)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Delete(Path As String, Dereference As Boolean = False) As Boolean
		  Dim f As FolderItem = Me.Locate(Path, Dereference)
		  If f <> Nil And f.AbsolutePath <> mVolume.Root.AbsolutePath Then
		    If f.Directory And f.Count > 0 Then Return False
		    f.Parent.Child(f.Name + ".META").Delete
		    f.Delete
		    mVolume.Flush
		    Return Not f.Exists
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetType(Path As String) As Integer
		  Dim meta As FolderItem = Me.Locate(Path, False)
		  If meta <> Nil Then Return Me.ReadType(meta)
		  Return TYPE_INVALID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetValue(Path As String, Dereference As Boolean = True) As Variant
		  Dim f As FolderItem = Me.Locate(Path, Dereference)
		  If f <> Nil Then Return Me.ReadValue(f)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(Path As String, Index As Integer) As String
		  Dim f As FolderItem = Me.Locate(Path)
		  If f <> Nil And f.Exists And f.Directory Then
		    Dim x As Integer
		    For i As Integer = 0 To f.Count - 1
		      Dim item As FolderItem = f.Item(i)
		      If Right(item.Name, 5) = ".META" Then Continue
		      If x = Index Then Return item.Name
		      x = x + 1
		    Next
		  End If
		  Raise New OutOfBoundsException
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Locate(Path As String, Dereference As Boolean = True) As FolderItem
		  Dim parts() As String = Split(Path, PathSeparator)
		  Dim item As FolderItem = mVolume.Root
		  For i As Integer = 0 To UBound(parts)
		    If item <> Nil Then
		      item = item.Child(parts(i))
		      Select Case True
		      Case Me.ReadType(item) = TYPE_SYMLINK And Dereference
		        item = Me.Locate(Me.ReadValue(item))
		      Case Not item.Directory And i <> UBound(parts)
		        Return Nil
		      End Select
		    Else
		      Return Nil
		    End If
		  Next
		  If item.AbsolutePath = mVolume.Root.AbsolutePath And Dereference Then Return Nil
		  Return item
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Open(RegFile As FolderItem) As PrefStore
		  Try
		    Return New PrefStore(RegFile.OpenAsVirtualVolume)
		  Catch
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadType(File As FolderItem) As Integer
		  If File.AbsolutePath = mVolume.Root.AbsolutePath Then Return TYPE_DIRECTORY
		  If File <> Nil And File.Parent <> Nil Then File = File.Parent.Child(File.Name + ".META")
		  If File = Nil Or Not File.Exists Or File.Directory Then Return TYPE_INVALID
		  Dim bs As BinaryStream = BinaryStream.Open(File)
		  bs.LittleEndian = False
		  Dim type As Integer = bs.ReadInt32
		  bs.Close
		  Return type
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadValue(File As FolderItem) As Variant
		  If File.AbsolutePath = mVolume.Root.AbsolutePath Then Return mVolume.Root
		  Dim reader As BinaryStream
		  Try
		    #pragma BreakOnExceptions Off
		    reader = BinaryStream.Open(File)
		    #pragma BreakOnExceptions On
		  Catch Err As IOException
		    If File.Directory Then Return File
		    Return Nil
		  End Try
		  reader.LittleEndian = False
		  Dim ret As Variant
		  Dim type As Integer = Me.ReadType(File)
		  Select Case type
		  Case Variant.TypeBoolean
		    ret = reader.ReadBoolean
		  Case Variant.TypeColor
		    Dim mb As New MemoryBlock(4)
		    mb.Int32Value(0) = reader.ReadInt32
		    ret = mb.ColorValue(0, 32)
		  Case Variant.TypeCurrency
		    ret = reader.ReadCurrency
		  Case Variant.TypeDate
		    Dim d As Double = reader.ReadDouble
		    Dim dt As New Date
		    dt.TotalSeconds = d
		    ret = dt
		  Case Variant.TypeDouble
		    ret = reader.ReadDouble
		  Case Variant.TypeSingle
		    ret = reader.ReadSingle
		  Case Variant.TypeLong
		    ret = reader.ReadInt64
		  Case Variant.TypeInteger
		    ret = reader.ReadInt32
		  Case Variant.TypeNil, TYPE_INVALID
		    ret = Nil
		  Case Variant.TypeString
		    ret = reader.Read(reader.Length)
		  Case TYPE_PNG
		    ret = Picture.FromData(reader.Read(reader.Length))
		  Case TYPE_FILE
		    Dim path As String = reader.Read(reader.Length)
		    If path.Trim <> "" Then ret = GetFolderItem(path, FolderItem.PathTypeAbsolute) Else ret = Nil
		  Case TYPE_SYMLINK
		    ret = reader.Read(reader.Length)
		  Else
		    '#pragma BreakOnExceptions Off
		    If Not RaiseEvent DeserializeValue(reader, type, ret) Then Raise New UnsupportedFormatException
		  End Select
		  reader.Close
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetType(Path As String, Dereference As Boolean = True, Assigns NewType As Integer)
		  Dim meta As FolderItem = Me.Locate(Path, Dereference)
		  If meta <> Nil Then Me.WriteType(meta, NewType)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetValue(Path As String, Dereference As Boolean = True, Assigns NewValue As Variant)
		  Dim f As FolderItem = Me.Locate(Path, Dereference)
		  If f <> Nil Then Me.WriteValue(f, NewValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub WriteType(File As FolderItem, Type As Integer)
		  If File.AbsolutePath = mVolume.Root.AbsolutePath Then Return
		  If File <> Nil And File.Parent <> Nil Then File = File.Parent.Child(File.Name + ".META")
		  If File = Nil Then Raise New IOException
		  If File.Exists Then File.Delete
		  Dim bs As BinaryStream = BinaryStream.Create(File, True)
		  bs.LittleEndian = False
		  bs.WriteInt32(Type)
		  bs.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub WriteValue(File As FolderItem, Value As Variant)
		  If File.AbsolutePath = mVolume.Root.AbsolutePath Then Raise New IOException
		  If File.Exists Then File.Delete
		  Dim writer As BinaryStream = BinaryStream.Create(File, True)
		  Dim type As Integer = VarType(Value)
		  Select Case type
		  Case Variant.TypeBoolean
		    writer.WriteBoolean(value)
		  Case Variant.TypeColor
		    Dim mb As New MemoryBlock(4)
		    mb.ColorValue(0, 32) = Value
		    writer.WriteInt32(mb.Int32Value(0))
		  Case Variant.TypeCurrency
		    writer.WriteCurrency(value)
		  Case Variant.TypeDate
		    Dim d As Double = Value.DateValue.TotalSeconds
		    writer.WriteDouble(d)
		  Case Variant.TypeDouble
		    writer.WriteDouble(value)
		  Case Variant.TypeSingle
		    writer.WriteSingle(value)
		  Case Variant.TypeLong
		    writer.WriteInt64(value)
		  Case Variant.TypeInteger
		    writer.WriteInt32(value)
		  Case Variant.TypeNil
		    ' nothing
		  Case Variant.TypeString
		    writer.Write(value)
		  Case Variant.TypeObject
		    Select Case True
		    Case Value IsA Picture
		      Dim p As Picture = Value
		      writer.Write(p.GetData(Picture.FormatPNG))
		      type = TYPE_PNG
		    Case Value IsA FolderItem
		      Dim source As FolderItem = Value
		      writer.Write(source.AbsolutePath)
		      type = TYPE_FILE
		    Else
		      '#pragma BreakOnExceptions Off
		      If Not RaiseEvent SerializeValue(writer, type, Value) Then Raise New UnsupportedFormatException
		    End Select
		  Else
		    '#pragma BreakOnExceptions Off
		    If Not RaiseEvent SerializeValue(writer, type, Value) Then Raise New UnsupportedFormatException
		  End Select
		  Me.WriteType(File, type)
		  Writer.Close
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DeserializeValue(ByteStream As Readable, Type As Integer, ByRef Value As Variant) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SerializeValue(ByteStream As Writeable, ByRef Type As Integer, Value As Variant) As Boolean
	#tag EndHook


	#tag Property, Flags = &h21
		Private mPathSeparator As String = "."
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVolume As VirtualVolume
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mPathSeparator
			End Get
		#tag EndGetter
		PathSeparator As String
	#tag EndComputedProperty


	#tag Constant, Name = CURRENT_VERSION, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TYPE_DIRECTORY, Type = Double, Dynamic = False, Default = \"-7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TYPE_FILE, Type = Double, Dynamic = False, Default = \"-4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TYPE_INVALID, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TYPE_PNG, Type = Double, Dynamic = False, Default = \"-2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TYPE_SYMLINK, Type = Double, Dynamic = False, Default = \"-5", Scope = Public
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
			Name="PathSeparator"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
