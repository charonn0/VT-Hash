#tag Module
Private Module SynchronousHelpers
	#tag Method, Flags = &h21
		Private Function CreateItem(InputStream As Readable, OutputStream As Writeable, ByRef Headers As InternetHeaders) As libcURL.EasyHandle
		  Dim cURL As New libcURL.EasyHandle
		  If Not cURL.SetOption(libcURL.Opts.FOLLOWLOCATION, True) Then Raise New cURLException(cURL) ' Follow redirects automatically
		  If Not cURL.SetOption(libcURL.Opts.FAILONERROR, True) Then Raise New cURLException(cURL) ' fail on server errors
		  cURL.CA_ListFile = libcURL.Default_CA_File
		  AddHandler cURL.DataAvailable, AddressOf _DataAvailableHandler
		  AddHandler cURL.DataNeeded, AddressOf _DataNeededHandler
		  AddHandler cURL.HeaderReceived, AddressOf _HeaderReceivedHandler
		  
		  Dim d As New Dictionary
		  d.Value("Input") = InputStream
		  d.Value("Output") = OutputStream
		  d.Value("Headers") = Headers
		  Transfers.Value(cURL) = d
		  Return cURL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Get(URL As String, TimeOut As Integer, OutputStream As Writeable, ByRef Headers As InternetHeaders, Username As String, Password As String) As libcURL.EasyHandle
		  Dim cURL As libcURL.EasyHandle = CreateItem(Nil, OutputStream, Headers)
		  If Username <> "" Then cURL.Username = Username
		  If Password <> "" Then cURL.Password = Password
		  Call cURL.Perform(URL, TimeOut)
		  Transfers.Remove(cURL)
		  Return cURL
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Post(FormData As libcURL.MultipartForm, URL As String, TimeOut As Integer, OutputStream As Writeable, ByRef Headers As InternetHeaders, Username As String, Password As String) As libcURL.EasyHandle
		  Dim cURL As libcURL.EasyHandle = CreateItem(Nil, OutputStream, Headers)
		  If Not cURl.SetOption(libcURL.Opts.HTTPPOST, FormData) Then Raise New cURLException(cURL)
		  If Username <> "" Then cURL.Username = Username
		  If Password <> "" Then cURL.Password = Password
		  Call cURL.Perform(URL, TimeOut)
		  Transfers.Remove(cURL)
		  Return cURL
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Put(URL As String, TimeOut As Integer, InputStream As Readable, OutputStream As Writeable, ByRef Headers As InternetHeaders, Username As String, Password As String) As libcURL.EasyHandle
		  Dim cURL As libcURL.EasyHandle = CreateItem(InputStream, OutputStream, Headers)
		  If Not cURL.SetOption(libcURL.Opts.UPLOAD, True) Then Raise New cURLException(cURL)
		  If Username <> "" Then cURL.Username = Username
		  If Password <> "" Then cURL.Password = Password
		  Call cURL.Perform(URL, TimeOut)
		  Transfers.Remove(cURL)
		  Return cURL
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _DataAvailableHandler(Sender As EasyHandle, NewData As String) As Integer
		  Dim d As Dictionary = Transfers.Lookup(Sender, Nil)
		  If d = Nil Then Return 0
		  Dim w As Writeable = d.Value("Output")
		  w.Write(NewData)
		  Return NewData.LenB
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function _DataNeededHandler(Sender As EasyHandle, Buffer As MemoryBlock) As Integer
		  Dim d As Dictionary = Transfers.Lookup(Sender, Nil)
		  If d = Nil Then Return 0
		  Dim r As Readable = d.Value("Input")
		  Dim data As MemoryBlock = r.Read(Buffer.Size)
		  Buffer.StringValue(0, data.Size) = data
		  Return data.Size
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub _HeaderReceivedHandler(Sender As EasyHandle, HeaderLine As String)
		  Dim n, v As String
		  If InStr(HeaderLine, ":") > 1 Then
		    n = NthField(HeaderLine, ":", 1)
		    v = Replace(HeaderLine, n + ":", "")
		  Else
		    n = HeaderLine.Trim
		  End If
		  Dim d As Dictionary = Transfers.Lookup(Sender, Nil)
		  If d = Nil Then Return
		  Dim h As InternetHeaders = d.Value("Headers")
		  If n.Trim <> "" Or v.Trim <> "" Then h.AppendHeader(n, v)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mTransfers As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If mTransfers = Nil Then mTransfers = New Dictionary
			  return mTransfers
			End Get
		#tag EndGetter
		Protected Transfers As Dictionary
	#tag EndComputedProperty


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
