#tag Class
Protected Class ProxyEngine
	#tag Method, Flags = &h0
		Sub Constructor(Owner As libcURL.EasyHandle)
		  ' Creates a new instance of ProxyEngine for the EasyHandle whose proxy settings are to be manipulated
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.Constructor
		  
		  mOwner = New WeakRef(Owner)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExcludeHost(Hostname As String) As Boolean
		  ' Exclude the specified Hostname from proxying. By default, all hosts are proxied.
		  ' Specify the hostname only; i.e. if the URL is "http://www.example.com" then "www.example.com"
		  ' is the Hostname.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_NOPROXY.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.ExcludeHost
		  
		  If mExclusions.IndexOf(Hostname) = -1 Then mExclusions.Append(Hostname)
		  Return Owner.SetOption(libcURL.Opts.NOPROXY, Join(mExclusions, ","))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetAuthMethods() As libcURL.HTTPAuthMethods
		  ' Gets an object which represents the available/allowed proxy authentication methods.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLINFO_PROXYAUTH_AVAIL.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.GetAuthMethods
		  
		  If mAuthMethods = Nil Then mAuthMethods = Owner.GetInfo(libcURL.Info.PROXYAUTH_AVAIL)
		  return mAuthMethods
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IncludeHost(Hostname As String) As Boolean
		  ' Removes the specified Hostname from the proxy exclusion list. By default, all hosts are proxied,
		  ' so you needn't call this method unless you have previously excluded the Hostname. Specify the
		  ' hostname only; i.e. if the URL is "http://www.example.com" then "www.example.com" is the Hostname.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_NOPROXY.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.IncludeHost
		  
		  Dim i As Integer
		  Do
		    i = mExclusions.IndexOf(Hostname)
		    If i <> -1 Then mExclusions.Remove(i)
		  Loop Until i < 0
		  Return Owner.SetOption(libcURL.Opts.NOPROXY, Join(mExclusions, ","))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsProxied(Hostname As String) As Boolean
		  ' Returns True if requests to Hostname will be proxied. Specify the hostname only; i.e. if
		  ' the URL is http://www.example.com/foo.txt then www.example.com is the hostname. If no
		  ' proxy is configured then all hosts return False.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.IsProxied
		  
		  If mAddress = "" Then
		    Return False
		  Else
		    For Each host As String In mExclusions
		      Dim h As String = Right(Hostname, host.Len)
		      If h = host And Mid(Hostname, Hostname.Len - h.Len, 1) = "." Then Return False
		    Next
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Owner() As libcURL.EasyHandle
		  If mOwner <> Nil And Not (mOwner.Value Is Nil) And mOwner.Value IsA libcURL.EasyHandle Then
		    Return libcURL.EasyHandle(mOwner.Value)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetAuthMethods(NewAuthMask As libcURL.HTTPAuthMethods) As Boolean
		  ' Sets the available/allowed proxy authentication methods.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_PROXYAUTH.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.SetAuthMethods
		  
		  If Not Owner.SetOption(libcURL.Opts.PROXYAUTH, NewAuthMask) Then Return False
		  mAuthMethods = NewAuthMask.Mask
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetProxyHeader(HeaderName As String, HeaderValue As String) As Boolean
		  ' Sets a header to send to the proxy. Not all proxy types support this feature.
		  ' Subsequent calls to this method will append the header to the previously set headers.
		  ' Headers will persist from transfer to transfer. Pass an empty value to clear the named
		  ' header. Pass an empty name to clear all headers.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_PROXYHEADER.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.SetProxyHeader
		  
		  If Not libcURL.Version.IsAtLeast(7, 37, 0) Then
		    ErrorSetter(Owner).LastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Return False
		  End If
		  
		  If mHeaders = Nil And HeaderName <> "" Then ' Add first header
		    mHeaders = Array(HeaderName + ": " + HeaderValue) ' array converts to ListPtr
		    
		  ElseIf HeaderName <> "" Then ' append another header
		    Dim s() As String = mHeaders
		    If Not Owner.SetOption(libcURL.Opts.PROXYHEADER, Nil) Then Raise New cURLException(Owner)
		    If HeaderName = "" And HeaderValue = "" Then Return True ' deleted headers
		    For i As Integer = UBound(s) DownTo 0
		      If NthField(s(i), ":", 1).Trim = HeaderName Then s.Remove(i)
		    Next
		    mHeaders = s
		    If Not mHeaders.Append(HeaderName + ": " + HeaderValue) Then Raise New cURLException(mHeaders)
		    
		  Else' clear all headers
		    mHeaders = Nil
		    
		  End If
		  
		  If Not Owner.SetOption(libcURL.Opts.PROXYHEADER, mHeaders) Then Raise New cURLException(Owner)
		  Return (mHeaders <> Nil Or HeaderName = "")
		End Function
	#tag EndMethod


	#tag Note, Name = About this class
		This class provides accessor methods to specify a proxy server for use with some or
		all transfers performed with a particular EasyHandle.
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets proxy's URL or IP address.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_PROXY.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.Address
			  
			  return mAddress
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets proxy's URL or IP address. IPv6 addresses must be enclosed in square brackets []. Set this
			  ' to the empty string ("") to disable the proxy.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_PROXY.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.Address
			  
			  If Not Owner.SetOption(libcURL.Opts.PROXY, value) Then Raise New libcURL.cURLException(Owner)
			  mAddress = value
			End Set
		#tag EndSetter
		Address As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mHTTPTunnel
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' If True, then libcURL will tunnel through the proxy server instead of relay requests through it
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.HTTPTunnel
			  
			  If Not Owner.SetOption(libcURL.Opts.HTTPPROXYTUNNEL, value) Then Raise New libcURL.cURLException(Owner)
			  mHTTPTunnel = value
			End Set
		#tag EndSetter
		HTTPTunnel As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAddress As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAuthMethods As libcURL.HTTPAuthMethods
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mExclusions() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHeaders As libcURL.ListPtr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHTTPTunnel As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOwner As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPort As Integer = 1080
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mServiceName As String = "HTTP"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As libcURL.ProxyType = libcURL.ProxyType.HTTP
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsername As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The proxy authentication password, if any.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.Password
			  
			  If Not Owner.SetOption(libcURL.Opts.PROXYUSERPWD, Me.Username + ":" + value) Then Raise New libcURL.cURLException(Owner)
			  mPassword = value
			End Set
		#tag EndSetter
		Password As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mPort
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The proxy server's port
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.Port
			  
			  If Not Owner.SetOption(libcURL.Opts.PROXYPORT, value) Then Raise New libcURL.cURLException(Owner)
			  mPort = value
			End Set
		#tag EndSetter
		Port As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mServiceName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The proxy service name, if any.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_PROXY_SERVICE_NAME.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.ServiceName
			  
			  If libcURL.Version.IsAtLeast(7, 43, 0) Then
			    If Not Owner.SetOption(libcURL.Opts.PROXY_SERVICE_NAME, value) Then Raise New libcURL.cURLException(Owner)
			    mServiceName = value
			  Else
			    ErrorSetter(Me.Owner).LastError = libcURL.Errors.FEATURE_UNAVAILABLE
			  End If
			End Set
		#tag EndSetter
		ServiceName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mType
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The type of proxy server to be used.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.Type
			  
			  If Not Owner.SetOption(libcURL.Opts.PROXYTYPE, Integer(value)) Then 
			    Raise New libcURL.cURLException(Owner)
			  End If
			  mType = value
			End Set
		#tag EndSetter
		Type As libcURL.ProxyType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mUsername
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' The proxy authentication username, if any.
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ProxyEngine.Username
			  
			  If Not Owner.SetOption(libcURL.Opts.PROXYUSERPWD, value + ":" + Me.Password) Then Raise New libcURL.cURLException(Owner)
			  mUsername = value
			End Set
		#tag EndSetter
		Username As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Address"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPTunnel"
			Group="Behavior"
			Type="Boolean"
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
			Name="Password"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ServiceName"
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
		#tag ViewProperty
			Name="Username"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
