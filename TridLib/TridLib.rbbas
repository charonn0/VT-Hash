#tag Module
Protected Module TridLib
	#tag Method, Flags = &h1
		Protected Function Analyze() As Integer
		  If TridLib.IsAvailable Then Return TrID_Analyze()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DefCount() As Integer
		  If TridLib.IsAvailable Then Return GetInfo(TRID_GET_DEFSNUM, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetInfo(InfoType As Integer, InfoIndex As Integer, Output As MemoryBlock = Nil) As Integer
		  If Output = Nil Then Output = New MemoryBlock(0)
		  If TridLib.IsAvailable Then Return TrID_GetInfo(InfoType, InfoIndex, Output)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsAvailable() As Boolean
		  Return System.IsFunctionAvailable("TrID_LoadDefsPack", "tridlib")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LoadDefsPack(Directory As FolderItem) As Integer
		  If TridLib.IsAvailable Then
		    Dim mb As New MemoryBlock(Directory.AbsolutePath.LenB * 2)
		    mb.CString(0) = Directory.AbsolutePath
		    If DefCount = 0 Then
		      Return TrID_LoadDefsPack(mb)
		    Else
		      Return DefCount
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetDefsPack(RawDefData As MemoryBlock) As Integer
		  ' This function is not available in all editions of TridLib.dll
		  Dim d As Integer = DefCount
		  If System.IsFunctionAvailable("TrID_SetDefsPack", "tridlib") Then
		    If d = 0 Then d = TrID_SetDefsPack(RawDefData)
		  End If
		  Return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SubmitFile(File As FolderItem) As Integer
		  If TridLib.IsAvailable Then
		    Dim mb As New MemoryBlock(File.AbsolutePath.LenB + 1)
		    mb.CString(0) = File.AbsolutePath
		    Return TrID_SubmitFileA(mb)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TrIDTypes(Extends f As FolderItem) As TridLib.FileType()
		  If DefCount = 0 Then Call LoadDefsPack(DefsFile.Parent)
		  Dim ret() As TridLib.FileType
		  
		  If DefCount > 0 Then
		    If SubmitFile(f) = 1 And Analyze() = 1 Then
		      Dim count As Integer = GetInfo(TRID_GET_RES_NUM, 0)
		      For i As Integer = 1 To count
		        Dim out As New MemoryBlock(4 * 1024)
		        Dim t As New TridLib.FileType
		        Call GetInfo(TRID_GET_RES_FILETYPE, i, out)
		        t.Description = out.CString(0)
		        out = New MemoryBlock(4 * 1024)
		        Call GetInfo(TRID_GET_RES_FILEEXT, i, out)
		        t.Extension = out.CString(0)
		        t.Points = GetInfo(TRID_GET_RES_POINTS, i)
		        ret.Append(t)
		      Next
		    End If
		  End If
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function TrID_Analyze Lib "tridlib" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function TrID_GetInfo Lib "tridlib" (InfoType As Integer, InfoIndex As Integer, TridRes As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function TrID_LoadDefsPack Lib "tridlib" (Path As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function TrID_SetDefsPack Lib "tridlib" (DefsPtr As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function TrID_SubmitFileA Lib "tridlib" (FileName As Ptr) As Integer
	#tag EndExternalMethod

	#tag Method, Flags = &h1
		Protected Function Version() As Integer
		  Return GetInfo(TRID_GET_VER, 0)
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If mDefsFile = Nil Then
			    Dim f As FolderItem = SpecialFolder.Temporary.Child("triddefs.trd")
			    Dim bs As BinaryStream = BinaryStream.Create(f, True)
			    bs.Write(TridDefFile)
			    bs.Close
			    mDefsFile = f
			  End If
			  return mDefsFile
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mDefsFile = value
			End Set
		#tag EndSetter
		Protected DefsFile As FolderItem
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDefsFile As FolderItem
	#tag EndProperty


	#tag Constant, Name = TRID_GET_DEFSNUM, Type = Double, Dynamic = False, Default = \"1004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_DEF_AUTHOREMAIL, Type = Double, Dynamic = False, Default = \"103", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_DEF_AUTHORHOME, Type = Double, Dynamic = False, Default = \"104", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_DEF_AUTHORNAME, Type = Double, Dynamic = False, Default = \"102", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_DEF_FILE, Type = Double, Dynamic = False, Default = \"105", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_DEF_FILESCANNED, Type = Double, Dynamic = False, Default = \"101", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_DEF_ID, Type = Double, Dynamic = False, Default = \"100", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_DEF_MIMETYPE, Type = Double, Dynamic = False, Default = \"109", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_DEF_RELURL, Type = Double, Dynamic = False, Default = \"107", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_DEF_REMARK, Type = Double, Dynamic = False, Default = \"106", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_DEF_TAG, Type = Double, Dynamic = False, Default = \"108", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_ISTEXT, Type = Double, Dynamic = False, Default = \"1005", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_RES_FILEEXT, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_RES_FILETYPE, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_RES_NUM, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_RES_POINTS, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_VER, Type = Double, Dynamic = False, Default = \"1001", Scope = Protected
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
End Module
#tag EndModule
