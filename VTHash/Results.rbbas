#tag Class
Protected Class Results
	#tag Method, Flags = &h0
		Sub Compact(Assigns b As Boolean)
		  Original.Compact = b
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Item As JSONItem, File As FolderItem)
		  If Item <> Nil Then
		    Me.Original = Item
		  Else
		    Raise New NilObjectException
		  End If
		  TargetFile = File
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScannerName(Item As Integer) As String
		  Return Me.Scans.Name(Item)
		  
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="Algorithm"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HashValue"
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
			Name="Permalink"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Resource"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ResponseCode"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ResponseMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ResultCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScanID"
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
			Name="ThreatCount"
			Group="Behavior"
			Type="Integer"
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
