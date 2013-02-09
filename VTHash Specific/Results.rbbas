#tag Class
Protected Class Results
	#tag Method, Flags = &h0
		Sub Constructor(Item As JSONItem)
		  If Item <> Nil Then
		    Me.Original = Item
		  Else
		    Raise New NilObjectException
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScannerName(Item As Integer) As String
		  Dim scanner, scanResult As String
		  scanner = Me.Scans.Name(Item)
		  Return scanner
		  
		Exception
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScannerResult(Item As Integer) As String
		  Dim scanner, scanResult As String
		  scanner = Me.Scans.Name(Item)
		  scanResult = Me.Scans.Child(scanner).Value("result")
		  Return scanResult
		  
		  
		Exception
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScannerUpdate(Item As Integer) As String
		  Dim scanner, LastUpdate As String
		  scanner = Me.Scans.Name(Item)
		  LastUpdate = Me.Scans.Child(scanner).Value("update")
		  Return LastUpdate
		  
		  
		Exception
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScannerVersion(Item As Integer) As String
		  Dim scanner, scannerVersion As String
		  scanner = Me.Scans.Name(Item)
		  scannerVersion = Me.Scans.Child(scanner).Value("version")
		  
		  Return scannerVersion
		  
		Exception
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return Original.ToString()
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Algorithm As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		HashValue As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Original As JSONItem
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Original.Value("permalink")
			End Get
		#tag EndGetter
		Permalink As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Original.Value("resource")
			End Get
		#tag EndGetter
		Resource As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Original.Value("response_code")
			End Get
		#tag EndGetter
		ResponseCode As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Original.Value("verbose_msg")
			End Get
		#tag EndGetter
		ResponseMessage As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Original.Value("total")
			End Get
		#tag EndGetter
		ResultCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Original.Value("scan_date").DateValue
			End Get
		#tag EndGetter
		ScanDate As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Original.Value("scan_id")
			End Get
		#tag EndGetter
		ScanID As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Original.Child("scans")
			End Get
		#tag EndGetter
		Scans As JSONItem
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		TargetFile As FolderItem
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Original.Value("positives")
			End Get
		#tag EndGetter
		ThreatCount As Integer
	#tag EndComputedProperty


	#tag Constant, Name = ALG_MD5, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ALG_SHA1, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Code_Not_Found, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Code_OK, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Code_Still_Proccessing, Type = Double, Dynamic = False, Default = \"-2", Scope = Public
	#tag EndConstant


End Class
#tag EndClass
