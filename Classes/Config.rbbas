#tag Module
Protected Module Config
	#tag Method, Flags = &h0
		Function isFound(Extends f As FolderItem) As Integer
		  Declare Function CloseHandle Lib "Kernel32"(HWND As Integer) As Boolean
		  Declare Function CreateFileW Lib "Kernel32"(name As WString, access As Integer, sharemode As Integer, SecAtrribs As Integer, _
		  CreateDisp As Integer, flags As Integer, template As Integer) As Integer
		  
		  Dim HWND As Integer = CreateFileW(f.AbsolutePath, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0)
		  If HWND = -1 Then
		    HWND = GetLastError()
		    Select Case HWND
		    Case 5
		      Return ACCESS_DENIED
		    Case 2
		      Return FILE_NOT_FOUND
		    Else
		      Return ERROR_OTHER
		    End Select
		    
		  Else
		    Call CloseHandle(HWND)
		    Return ERROR_NO_ERROR
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function saveAs(mode As Integer) As FolderItem
		  Dim f As FolderItem = autosavePath
		  If Not f.Exists Then f.CreateAsFolder
		  If Not f.Directory Then
		    resultWindow.saved.Text = "Invalid Save Path"
		    resultWindow.saved.TextColor = &cFF0000
		    Return Nil
		  End If
		  Dim d As New Date
		  f = f.Child(toBeHashed.Name + "_" + Format(d.TotalSeconds, "#######0000000") + ".txt")
		  Dim tos As TextOutputStream
		  
		  Select Case Mode
		  Case Mode_Text
		    tos = tos.Create(f)
		    tos.WriteLine("VirusTotal Scan Results")
		    tos.WriteLine("Report retrieved: " + d.ShortDate + "; " + d.ShortTime + " " + Timezone)
		    tos.WriteLine("Report Date: " + theresults.Value("scan_date"))
		    tos.WriteLine("")
		    For i As Integer = 0 To resultWindow.ListBox1.LastIndex
		      tos.WriteLine(resultWindow.ListBox1.Cell(i, 0) + " " + resultWindow.ListBox1.Cell(i, 1) + ": " + Chr(9) + resultWindow.ListBox1.Cell(i, 2))
		    Next
		  Case Mode_Org_JSON
		    tos = tos.Create(f)
		    tos.Write(theresults.ToString)
		  Case Mode_Unp_JSON
		    tos = tos.Create(f)
		    theresults.Compact = False
		    tos.Write(theresults.ToString)
		  Case Mode_CSV
		    tos = tos.Create(f)
		    For i As Integer = 0 To resultWindow.ListBox1.LastIndex
		      tos.WriteLine(resultWindow.ListBox1.Cell(i, 0) + "," + resultWindow.ListBox1.Cell(i, 1) + "," + resultWindow.ListBox1.Cell(i, 2))
		    Next
		  End Select
		  tos.Close
		  Return f
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Timezone() As String
		  //This function returns a string representing the name of the current time zone. e.g. "EST" or "Pacific Daylight Time." This name
		  //is localized and may be up to 32 characters long.
		  //On error, returns an empty string.
		  
		  #If TargetWin32 Then 
		    Declare Function GetTimeZoneInformation Lib "Kernel32" (ByRef TZInfo As TIME_ZONE_INFORMATION) As Integer
		    
		    Const daylightSavingsOn = 2
		    Const daylightSavingsOff = 1
		    Const daylightSavingsUnknown = 0
		    Const invalidTimeZone = &hFFFFFFFF
		    
		    Dim TZInfo As TIME_ZONE_INFORMATION
		    Dim dlsStatus As Integer = GetTimeZoneInformation(TZInfo)
		    
		    If dlsStatus = daylightSavingsOn Or dlsStatus = daylightSavingsOff Or dlsStatus = daylightSavingsUnknown Then
		      Return TZInfo.StandardName
		    Else
		      Return ""
		    End If
		  #endif
		End Function
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
			  If mautosavePath = Nil Then mautosavePath = SpecialFolder.ApplicationData.Child("Boredom Software").Child("VT Hash").Child("scans")
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
		Private mversion As Double = 0.99
	#tag EndProperty

	#tag Property, Flags = &h0
		theresults As JSONItem
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
			  Return Format(mversion, "0.00")
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

	#tag Constant, Name = Mode_Unp_JSON, Type = Double, Dynamic = False, Default = \"2", Scope = Public
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
