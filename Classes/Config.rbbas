#tag Module
Protected Module Config
	#tag Method, Flags = &h0
		Sub SaveSettings()
		  Dim s As New JSONItem
		  s.Value("Use SSL") = useSSL
		  s.Value("Use SHA1") = algorithm <> "MD5"
		  s.Value("Autosave Results") = autosave
		  s.Value("Default Save Format") = defaultFormat
		  If autosavePath <> Nil Then
		    s.Value("Default Save Directory") = autosavePath.AbsolutePath
		  Else
		    s.Value("Default Save Directory") = SpecialFolder.ApplicationData.Child("Boredom Software").Child("VT Hash").Child("scans").AbsolutePath
		  End If
		  s.Value("API Key") = VTAPIKey
		  s.Compact = False
		  Dim t As String = s.ToString
		  Dim tos As TextOutputStream
		  Dim f As FolderItem = SpecialFolder.ApplicationData.Child("Boredom Software")
		  If Not f.Exists Then
		    f.CreateAsFolder()
		  End If
		  f = f.Child("VT Hash")
		  If Not f.Exists Then
		    f.CreateAsFolder()
		  End If
		  f = f.Child("config.dat")
		  tos = tos.Create(f)
		  tos.Write(t)
		  tos.Close
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		aboutSwitch As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		algorithm As String = "MD5"
	#tag EndProperty

	#tag Property, Flags = &h0
		autosave As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mautosavePath = Nil Then
			    mautosavePath = SpecialFolder.ApplicationData.Child("Boredom Software").Child("VT Hash").Child("scans")
			    If Not mautosavePath.Exists Then mautosavePath.CreateAsFolder
			  End If
			  return mautosavePath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mautosavePath = value
			End Set
		#tag EndSetter
		autosavePath As FolderItem
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		cancel As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		defaultFormat As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		errorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h0
		fileData As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mautosavePath As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mversion As Double = 1.1
	#tag EndProperty

	#tag Property, Flags = &h0
		TheHash As String
	#tag EndProperty

	#tag Property, Flags = &h0
		toBeHashed As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		useSSL As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Format(mversion, "0.0#")
			End Get
		#tag EndGetter
		version As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		VTAPIKey As String
	#tag EndProperty


	#tag Constant, Name = ACCESS_DENIED, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ERROR_NO_ERROR, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ERROR_OTHER, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NOT_FOUND, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_READ_ACCESS, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SHARE_READ, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = GENERIC_READ, Type = Double, Dynamic = False, Default = \"&h80000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Mode_CSV, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Mode_Org_JSON, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Mode_Text, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Mode_Unp_JSON, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OPEN_EXISTING, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant


	#tag Structure, Name = SYSTEMTIME, Flags = &h0
		Year As UInt16
		  Month As UInt16
		  DOW As UInt16
		  Day As UInt16
		  Hour As UInt16
		  Minute As UInt16
		  Second As UInt16
		MS As UInt16
	#tag EndStructure

	#tag Structure, Name = TIME_ZONE_INFORMATION, Flags = &h0
		Bias As Integer
		  StandardName As Wstring*32
		  StandardDate As SYSTEMTIME
		  StandardBias As Integer
		  DaylightName As WString*32
		  DaylightDate As SYSTEMTIME
		DaylightBias As Integer
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="aboutSwitch"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="algorithm"
			Group="Behavior"
			InitialValue="""""MD5"""""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="autosave"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="cancel"
			Group="Behavior"
			InitialValue="false"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultFormat"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="errorMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="fileData"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
			Name="TheHash"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="useSSL"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="version"
			Group="Behavior"
			InitialValue="0.87"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="VTAPIKey"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
