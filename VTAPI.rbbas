#tag Module
Protected Module VTAPI
	#tag Method, Flags = &h0
		Function Rescan(Results As JSONItem) As JSONItem
		  Dim js As New JSONItem
		  js.Value("resource") = Results.Value("resource")
		  js.Value("apikey") = VTAPIKey
		  Dim sock As New VTSocket
		  Return sock.SendRequest(Rescan_URL, js)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScanReport(Hash As String) As JSONItem
		  Dim js As New JSONItem
		  js.Value("resource") = Hash
		  js.Value("apikey") = VTAPIKey
		  Dim sock As New VTSocket
		  Return sock.SendRequest(Report_URL, js)
		End Function
	#tag EndMethod


	#tag Constant, Name = Report_URL, Type = String, Dynamic = False, Default = \"www.virustotal.com/vtapi/v2/file/report", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Rescan_URL, Type = String, Dynamic = False, Default = \"www.virustotal.com/vtapi/v2/file/rescan", Scope = Public
	#tag EndConstant


End Module
#tag EndModule
