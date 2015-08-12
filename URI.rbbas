#tag Class
Protected Class URI
	#tag Method, Flags = &h1
		Protected Sub Constructor(URL As String)
		  ' Pass a URI string to parse. e.g. http://user:password@www.example.com:8080/?foo=bar&bat=baz#Top
		  
		  Dim isIPv6 As Boolean
		  If NthField(URL, ":", 1) <> "mailto" Then
		    If InStr(URL, "://") > 0 Then
		      Me.Scheme = NthField(URL, "://", 1)
		      URL = URL.Replace(Me.Scheme + "://", "")
		    End If
		    
		    If Instr(URL, "@") > 0 Then //  USER:PASS@Domain
		      Me.Username = NthField(URL, ":", 1)
		      URL = URL.Replace(Me.Username + ":", "")
		      
		      Me.Password = NthField(URL, "@", 1)
		      URL = URL.Replace(Me.Password + "@", "")
		    End If
		    
		    If Instr(URL, ":") > 0 And Left(URL, 1) <> "[" Then //  Domain:Port
		      Dim s As String = NthField(URL, ":", 2)
		      s = NthField(s, "?", 1)
		      If Val(s) > 0 Then
		        Me.Port = Val(s)
		        URL = URL.Replace(":" + Format(Me.Port, "######"), "")
		      End If
		    ElseIf Left(URL, 1) = "[" And InStr(URL, "]:") > 0 Then ' ipv6 with port
		      isIPv6 = True
		      Dim s As String = NthField(URL, "]:", 2)
		      s = NthField(s, "?", 1)
		      Me.Port = Val(s)
		      URL = URL.Replace("]:" + Format(Me.Port, "######"), "]")
		    ElseIf Left(URL, 1) = "[" And InStr(URL, "]") > 0 Then ' ipv6
		      isIPv6 = True
		    Else
		      Me.Port = SchemeToPort(Me.Scheme)
		    End If
		    
		    
		    If Instr(URL, "#") > 0 Then
		      Me.Fragment = NthField(URL, "#", 2)  //    #fragment
		      URL = URL.Replace("#" + Me.Fragment, "")
		    End If
		    
		    Me.Host = NthField(URL, "/", 1)  //  [sub.]domain.tld
		    URL = URL.Replace(Me.Host, "")
		    
		    If InStr(URL, "?") > 0 Then
		      Dim tmp As String = NthField(URL, "?", 1)
		      Path = tmp  //    /foo/bar.php
		      URL = URL.Replace(tmp + "?", "")
		      Me.Arguments = Split(URL, "&")
		    ElseIf URL.Trim <> "" Then
		      Path = URL.Trim
		      URL = Replace(URL, Me.Path, "")
		    End If
		    
		  Else
		    Me.Scheme = "mailto"
		    URL = Replace(URL, "mailto:", "")
		    Me.Username = NthField(URL, "@", 1)
		    URL = Replace(URL, Me.Username + "@", "")
		    
		    If InStr(URL, "?") > 0 Then
		      Me.Host = NthField(URL, "?", 1)
		      Me.Arguments = Split(NthField(URL, "?", 2), "&")
		    Else
		      Me.Host = URL
		    End If
		  End If
		  Me.Scheme = EncodeURLComponent(Me.Scheme)
		  Me.Username = EncodeURLComponent(Me.Username)
		  Me.Password = EncodeURLComponent(Me.Password)
		  If Not isIPv6 Then Me.Host = EncodeURLComponent(Me.Host)
		  For Each arg As String In Me.Arguments
		    arg = EncodeURLComponent(arg)
		  Next
		  Me.Fragment = EncodeURLComponent(Me.Fragment)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(CopyURL As URI)
		  Me.Constructor(CopyURL.ToString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(NewValue As String)
		  Me.Constructor(NewValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path() As String
		  Dim s As String
		  For i As Integer = 0 To UBound(mPath)
		    If mPath(i).Trim = "" Then Continue
		    s = s + "/" + EncodeURLComponent(mPath(i))
		  Next
		  If mHasEndSlash Then s = s + "/"
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Path(Assigns NewPath As String)
		  Dim s() As String = Split(DecodeURLComponent(NewPath), "/")
		  ReDim mPath(-1)
		  For i As Integer = 0 To UBound(s)
		    If s(i).Trim <> "" Then mPath.Append(s(i))
		  Next
		  If s.Ubound > -1 Then mHasEndSlash = (s(s.Ubound) = "") Else mHasEndSlash = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function SchemeToPort(Scheme As String) As Integer
		  Static mPorts As Dictionary
		  If mPorts = Nil Then
		    mPorts = New Dictionary( _
		    "http":80, _
		    "https":443, _
		    "ftp":21, _
		    "ssh":22, _
		    "telnet":23, _
		    "smtp":25, _
		    "smtps":25, _
		    "pop2":109, _
		    "pop3":110, _
		    "ident":113, _
		    "auth":113, _
		    "sftp":115, _
		    "nntp":119, _
		    "ntp":123, _
		    "irc":6667)
		  End If
		  
		  Return mPorts.Lookup(Scheme, -1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Dim URL As String
		  If Scheme = "mailto" Then
		    URL = "mailto:"
		  Else
		    If Scheme <> "" Then URL = EncodeURLComponent(Scheme) + "://"
		  End If
		  
		  If Username <> "" Then
		    URL = URL + EncodeURLComponent(Username)
		    If Scheme <> "mailto" Then URL = URL + ":"
		    If Password <> "" Then URL = URL + EncodeURLComponent(Password)
		    URL = URL + "@"
		  End If
		  
		  If Left(Host, 1) = "[" And Right(Host, 1) = "]" Then ' IPv6 literal
		    URL = URL + Host
		  Else
		    URL = URL + EncodeURLComponent(Host)
		  End If
		  
		  If Port > -1 And (Scheme <> "" And SchemeToPort(Scheme) <> Port) Then
		    URL = URL + ":" + Format(Port, "####0")
		  End If
		  
		  URL = URL + Me.Path
		  
		  If Arguments.Ubound > -1 Then
		    Dim args As String = "?"
		    Dim acount As Integer = UBound(Arguments)
		    For i As Integer = 0 To acount
		      If i > 0 Then args = args + "&"
		      If EncodeArguments Then
		        args = args + EncodeURLComponent(Arguments(i))
		      Else
		        args = args + Arguments(i)
		      End If
		    Next
		    URL = URL + args
		  End If
		  
		  If Fragment <> "" Then
		    URL = URL + "#" + EncodeURLComponent(Fragment)
		  End If
		  If URL.Trim = "" Then URL = "/"
		  Return URL
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Arguments() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		EncodeArguments As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Fragment As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Host As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasEndSlash As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Password As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Port As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		Scheme As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Username As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="EncodeArguments"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Fragment"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Host"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
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
			InitialValue="80"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Scheme"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
