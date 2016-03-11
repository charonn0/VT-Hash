#tag Class
Class PrefStore
	#tag Method, Flags = &h0
		Sub Close()
		  If mModificationDate <> Nil Then
		    Dim f As FolderItem = mVolume.Root.Child(".META")
		    If f.Directory Then Me.WriteValue(f.Child("MODIFY_DATE"), mModificationDate)
		    mModificationDate = Nil
		  End If
		  mVolume.Flush
		  mVolume = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(VolumeRef As VirtualVolume)
		  If VolumeRef = Nil Then Raise New NilObjectException
		  mVolume = VolumeRef
		  If Me.PathSeparator = "" Then Me.PathSeparator = "."
		  If Me.CreationDate = Nil Then Me.CreationDate = New Date
		  If Me.ModificationDate = Nil Then Me.ModificationDate = New Date
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

	#tag Method, Flags = &h1
		Protected Function Count(Folder As FolderItem) As Integer
		  If Folder <> Nil And Folder.Exists And Folder.Directory Then
		    Dim x As Integer
		    For i As Integer = 0 To Folder.Count - 1
		      Dim item As FolderItem = Folder.Item(i)
		      If Right(item.Name, 5) = ".META" Then Continue
		      x = x + 1
		    Next
		    Return x
		  End If
		  Raise New NilObjectException
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count(DirectoryPath As String, Dereference As Boolean = True) As Integer
		  Dim f As FolderItem = Me.Locate(DirectoryPath, Dereference)
		  Return Me.Count(f)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(RegFile As FolderItem) As PrefStore
		  Dim v As VirtualVolume = RegFile.CreateVirtualVolume()
		  Dim f As FolderItem = v.Root.Child(".META")
		  f.CreateAsFolder
		  f = f.Child("PATH_SEPARATOR")
		  Dim bs As BinaryStream = BinaryStream.Create(f, True)
		  bs.Write(".")
		  bs.Close
		  v.Flush
		  Dim p As PrefStore
		  Try
		    p = New PrefStore(v)
		  Catch
		    Return Nil
		  End Try
		  p.mRootFile = RegFile
		  Return p
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CreateDirectory(Folder As FolderItem) As Boolean
		  If Folder.Exists Then Return False
		  Folder.CreateAsFolder
		  If Folder.Exists And Folder.Directory Then
		    Me.WriteType(Folder, TYPE_DIRECTORY)
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateDirectory(Path As String, CreateParents As Boolean, Dereference As Boolean = True) As Boolean
		  Dim parts() As String = Split(Path, PathSeparator)
		  Dim paths As String
		  For i As Integer = 0 To UBound(parts)
		    paths = paths + parts(i)
		    Dim item As FolderItem = Me.Locate(paths, Dereference)
		    If item = Nil Then Return False
		    If item.Name.Trim = "" Then Return False
		    If i <> UBound(parts) Then
		      paths = paths + PathSeparator
		      If Not item.Exists And CreateParents Then
		        If Not Me.CreateDirectory(item) Then Return False
		      End If
		    End If
		  Next
		  Dim f As FolderItem = Me.Locate(paths, Dereference)
		  If f = Nil Or f.Exists Then Return False
		  If f.Name.Trim = "" Then Return False
		  Return Me.CreateDirectory(f)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Delete(Item As FolderItem) As Boolean
		  If Item <> Nil And Item.AbsolutePath <> mVolume.Root.AbsolutePath Then
		    If Item.Directory And Item.Count > 0 Then Return False
		    Item.Parent.Child(Item.Name + ".META").Delete
		    Item.Delete
		    mVolume.Flush
		    Return Not Item.Exists
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Delete(Path As String, Dereference As Boolean = True) As Boolean
		  Dim f As FolderItem = Me.Locate(Path, Dereference)
		  Return Me.Delete(f)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flush()
		  mVolume.Flush
		End Sub
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
		 Shared Function IsAPrefStore(RegFile As FolderItem) As Boolean
		  Dim bs As BinaryStream = BinaryStream.Open(RegFile, True)
		  If bs.Read(4) <> "VFSv" Then Return False ' Not a PrefStore
		  bs.Close
		  Dim v As VirtualVolume = RegFile.OpenAsVirtualVolume()
		  Dim f As FolderItem = v.Root.Child(".META")
		  Return f.Exists And f.Directory
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Item(Folder As FolderItem, Index As Integer) As FolderItem
		  If Folder <> Nil And Folder.Exists And Folder.Directory Then
		    Dim x As Integer
		    For i As Integer = 0 To Folder.Count - 1
		      Dim item As FolderItem = Folder.Item(i)
		      If Right(item.Name, 5) = ".META" Then Continue
		      If x = Index Then Return item
		      x = x + 1
		    Next
		  End If
		  Raise New OutOfBoundsException
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Item(DirectoryPath As String, Index As Integer, Dereference As Boolean = True) As String
		  Dim f As FolderItem = Me.Locate(DirectoryPath, Dereference)
		  Return Me.Item(f, Index).Name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Locate(Path As String, Dereference As Boolean = True) As FolderItem
		  ' Traverses the VirtualVolume directory structure using Path, and returns a FolderItem pointing to the
		  ' located item. If the item cannot be located, returns Nil.
		  '
		  ' If Dereference=False and the located item is of type TYPE_SYMLINK then the returned FolderItem points
		  ' to the link; if Dereference=True then the returned FolderItem points to the link target.
		  '
		  ' If the Path is empty and Dereference=False, returns the root directory of the VirtualVolume.
		  
		  Dim parts() As String = Split(Path, PathSeparator)
		  Dim item As FolderItem = mVolume.Root
		  For i As Integer = 0 To UBound(parts)
		    If item = Nil Then
		      Break
		      Return Nil
		      
		    End If
		    Dim child As FolderItem = item.Child(parts(i))
		    Select Case True
		    Case child = Nil
		      Break
		      Return Nil
		      
		    Case Me.ReadType(child) = TYPE_SYMLINK And Dereference
		      Dim v As Variant = Me.ReadValue(child)
		      If v IsA FolderItem Then
		        child = v
		      Else
		        child = Me.Locate(v.StringValue)
		      End If
		    Case Not item.Directory And i <> UBound(parts)
		      Return Nil
		    End Select
		    item = child
		  Next
		  If item.AbsolutePath = mVolume.Root.AbsolutePath And Dereference Then Return Nil
		  Return item
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Open(RegFile As FolderItem) As PrefStore
		  If RegFile = Nil Then Return Nil
		  If Not IsAPrefStore(RegFile) Then Return Nil
		  Dim v As VirtualVolume = RegFile.OpenAsVirtualVolume()
		  Dim p As PrefStore
		  Try
		    p = New PrefStore(v)
		  Catch
		    Return Nil
		  End Try
		  p.mRootFile = RegFile
		  Return p
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadType(File As FolderItem) As Integer
		  If File.AbsolutePath = mVolume.Root.AbsolutePath Then Return TYPE_DIRECTORY
		  If File <> Nil And File.Parent <> Nil Then File = File.Parent.Child(File.Name + ".META")
		  If File = Nil Or Not File.Exists Then Return TYPE_INVALID
		  If File.Directory Then Return TYPE_DIRECTORY
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
		  Case TYPE_SYMLINK, TYPE_DIRECTORY
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
		Function RootFile() As FolderItem
		  Return mRootFile
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
		  ModificationDate = New Date
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
		  Else
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
		      If Not RaiseEvent SerializeValue(writer, type, Value) Then Raise New UnsupportedFormatException
		    End Select
		  End Select
		  Me.WriteType(File, type)
		  Writer.Close
		  ModificationDate = New Date
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DeserializeValue(ByteStream As Readable, Type As Integer, ByRef Value As Variant) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SerializeValue(ByteStream As Writeable, ByRef Type As Integer, Value As Variant) As Boolean
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim f As FolderItem = mVolume.Root.Child(".META")
			  If f.Directory And f.Exists And f.Child("CREATE_DATE").Exists Then
			    Dim d As Double = Me.ReadValue(f.Child("CREATE_DATE"))
			    Dim dd As New Date
			    dd.TotalSeconds = d
			    Return dd
			  End If
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim f As FolderItem = mVolume.Root.Child(".META")
			  If Not f.Exists Then f.CreateAsFolder
			  If Not f.Directory Then
			    Raise New RuntimeException ' not a PrefStore
			  Else
			    Me.WriteValue(f.Child("CREATE_DATE"), value)
			  End If
			End Set
		#tag EndSetter
		CreationDate As Date
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mModificationDate As Date
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mModificationDate <> Nil Then Return mModificationDate
			  
			  Dim f As FolderItem = mVolume.Root.Child(".META")
			  If f.Directory And f.Exists And f.Child("MODIFY_DATE").Exists Then
			    Dim d As Double = Me.ReadValue(f.Child("MODIFY_DATE"))
			    Dim dd As New Date
			    dd.TotalSeconds = d
			    Return dd
			  End If
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' To minimize writing to disk, this value is stored until the Close method is called.
			  mModificationDate = value
			End Set
		#tag EndSetter
		ModificationDate As Date
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mPathSeparator As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRootFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVolume As VirtualVolume
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mPathSeparator = "" Then
			    Dim f As FolderItem = mVolume.Root.Child(".META")
			    If Not f.Directory Or Not f.Exists Then
			      mPathSeparator = "" ' not a PrefStore
			    Else
			      mPathSeparator = Me.ReadValue(f.Child("PATH_SEPARATOR"))
			    End If
			  End If
			  return mPathSeparator
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Dim f As FolderItem = mVolume.Root.Child(".META")
			  If Not f.Exists Then f.CreateAsFolder
			  If Not f.Directory Then
			    Raise New RuntimeException ' not a PrefStore
			  Else
			    Me.WriteValue(f.Child("PATH_SEPARATOR"), value)
			    mPathSeparator = value
			  End If
			End Set
		#tag EndSetter
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
