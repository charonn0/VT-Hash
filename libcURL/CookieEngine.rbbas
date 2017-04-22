#tag Class
Protected Class CookieEngine
	#tag Method, Flags = &h0
		Sub Constructor(Owner As libcURL.EasyHandle)
		  ' Creates a new instance of CookieEngine for the EasyHandle whose cookies are to be manipulated
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Constructor
		  
		  mOwner = New WeakRef(Owner)
		  Me.Invalidate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  ' Counts the number of unexpired cookies currently collected.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Count
		  
		  If CookieList <> Nil Then Return CookieList.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeleteAll() As Boolean
		  ' Clears all cookies held in memory, expired or not.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_COOKIELIST.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.DeleteAll
		  
		  Me.Invalidate
		  Return Owner.SetOption(libcURL.Opts.COOKIELIST, "ALL")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( deprecated = "libcURL.CookieEngine.NewSession" )  Function DeleteSession() As Boolean
		  ' Note: This method has been deprecated in favor of CookieEngine.NewSession
		  ' Deletes all session cookies. Session cookies are those without an explicit expiration date.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.DeleteSession
		  
		  If libcURL.Version.IsAtLeast(7, 17, 1) Then
		    Me.Invalidate
		    Return Owner.SetOption(libcURL.Opts.COOKIELIST, "SESS")
		  Else
		    ErrorSetter(Owner).LastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Domain(Index As Integer) As String
		  ' Returns the domain for the cookie at Index. If the domain is empty then the cookie is sent to all hosts and will not
		  ' be updated should a server send the Set-Cookie header.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Domain
		  
		  Const HTTPONLY = "#HttpOnly_"
		  Static sz As Integer = HTTPONLY.Len
		  
		  Dim dm As String = NthField(Me.StringValue(Index), Chr(9), 1)
		  
		  If Left(dm, sz) = HTTPONLY Then dm = Right(dm, dm.Len - sz)
		  If Left(dm, sz + 1) = "." + HTTPONLY Then dm = Right(dm, dm.Len - (sz + 1))
		  Return dm
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Expiry(Index As Integer) As Date
		  ' Returns the expiration date for the cookie at Index. If the cookie is a session cookie then the return value will be Nil.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Expiry
		  
		  Dim count As Integer = Val(NthField(Me.StringValue(Index), Chr(9), 5))
		  If count > 0 Then
		    Dim d As New Date(1970, 1, 1, 0, 0, 0, 0.0) 'UNIX epoch
		    d.TotalSeconds = d.TotalSeconds + count
		    Return d
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Expiry(Index As Integer, Assigns NewExpiry As Date)
		  ' Sets the expiration date for the cookie at Index. To make the cookie into a session cookie pass NIL; to
		  ' delete a cookie set its expiration date in the past.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Expiry
		  
		  If Not Me.SetCookie(Me.Name(Index), Me.Value(Index), Me.Domain(Index), NewExpiry, Me.Path(Index), Me.HTTPOnly(Index)) Then
		    Raise New libcURL.cURLException(Owner)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flush(CookieFile As FolderItem = Nil) As Boolean
		  ' Flushes all cookies to a file. If no CookieFile is specified as a parameter then the cookiejar property is used.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_COOKIELIST.html
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_COOKIEJAR.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Flush
		  
		  If Not libcURL.Version.IsAtLeast(7, 17, 1) Then
		    ErrorSetter(Owner).LastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Return False
		  End If
		  
		  If CookieFile = Nil Then CookieFile = mCookieJar
		  If CookieFile = Nil Then
		    ErrorSetter(Owner).LastError = libcURL.Errors.NO_COOKIEJAR
		    Return False
		  End If
		  Dim OK As Boolean = Owner.SetOption(libcURL.Opts.COOKIEJAR, CookieFile)
		  If OK Then OK = Owner.SetOption(libcURL.Opts.COOKIELIST, "FLUSH")
		  If OK Then OK = Owner.SetOption(libcURL.Opts.COOKIEJAR, mCookieJar)
		  Me.Invalidate
		  Return OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HTTPOnly(Index As Integer) As Boolean
		  ' Returns True if the cookie at Index should not be available to non-HTTP APIs (e.g. Javascript)
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.HTTPOnly
		  
		  Const HTTPONLY = "#HttpOnly_"
		  Static sz As Integer = HTTPONLY.Len
		  Dim dm As String = NthField(Me.StringValue(Index), Chr(9), 1)
		  
		  Return (Left(dm, sz) = HTTPONLY) Or Left(dm, sz + 1) = "." + HTTPONLY
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invalidate()
		  ' Marks the cached cookie list as dirty. You must use this method whenever cookies are modified from outside
		  ' the CookieEngine class, for example after a transfer has completed.
		  
		  mDirty = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(CookieName As String, CookieDomain As String, StartWith As Integer = 0, Strict As Boolean = True) As Integer
		  ' Locates the index of the cookie matching the CookieName and CookieDomain parameters. To continue searching from
		  ' a previous index specify the StartWith parameter. If CookieDomain is "" then all domains match. If CookieName
		  ' is "" then all cookies for CookieDomain match. If Strict is False, then a cookie will match if the name and
		  ' domain contain the CookieName and CookieDomain parameters.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Lookup
		  
		  Dim c As Integer = Me.Count
		  For i As Integer = StartWith To c - 1
		    Dim n, d As String
		    n = Me.Name(i)
		    If CookieName = "" Or n = CookieName Or (Not Strict And InStr(n, CookieName) > 0) Then
		      d = Me.Domain(i)
		      If d = "" And CookieDomain = "" Then Return i
		      If Strict Then
		        If Not CompareDomains(CookieDomain, d, Owner) Then Continue For i
		        Return i
		      Else
		        If CookieDomain <> "" And CookieDomain <> d And "." + CookieDomain <> d And InStr(d, CookieDomain) = 0 Then Continue For i
		        Return i
		      End If
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name(Index As Integer) As String
		  ' Returns the name of the Cookie at Index
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Name
		  
		  Return NthField(Me.StringValue(Index), Chr(9), 6)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NewSession() As Boolean
		  ' Begins a new cookie session. All session cookies held in memory are deleted. This also prevents
		  ' libcurl from loading session cookies from a cookie file.
		  '
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_COOKIESESSION.html
		  ' https://curl.haxx.se/libcurl/c/CURLOPT_COOKIELIST.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.NewSession
		  
		  Me.Invalidate
		  Dim OK As Boolean = Owner.SetOption(libcURL.Opts.COOKIESESSION, True)
		  If OK And libcURL.Version.IsAtLeast(7, 17, 1) Then
		    OK = Owner.SetOption(libcURL.Opts.COOKIELIST, "SESS")
		  End If
		  Return OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Owner() As libcURL.EasyHandle
		  If mOwner <> Nil And mOwner.Value <> Nil And mOwner.Value IsA libcURL.EasyHandle Then
		    Return libcURL.EasyHandle(mOwner.Value)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Path(Index As Integer) As String
		  ' Returns the remote path associated with the cookie at Index.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Path
		  
		  Return NthField(Me.StringValue(Index), Chr(9), 3)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Reload(CookieFile As FolderItem = Nil) As Boolean
		  ' Reloads the cookie list from the CookieFile. If no CookieFile is specified then the CookieJar is used.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Reload
		  
		  If Not libcURL.Version.IsAtLeast(7, 17, 1) Then
		    ErrorSetter(Owner).LastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Return False
		  End If
		  
		  Dim OK As Boolean
		  If CookieFile <> Nil Then
		    Dim tmp As FolderItem = Me.CookieJar
		    Me.CookieJar = CookieFile
		    OK = Owner.SetOption(libcURL.Opts.COOKIELIST, "RELOAD")
		    Me.CookieJar = tmp
		  ElseIf Me.CookieJar <> Nil Then
		    OK = Owner.SetOption(libcURL.Opts.COOKIELIST, "RELOAD")
		  End If
		  Me.Invalidate
		  Return OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetCookie(RawCookie As String) As Boolean
		  ' Sets a cookie for the cookie engine to use. If a cookie with the same name and domain already exists it will be updated.
		  ' You may pass either Netscape cookie jar lines or HTTP Set-Cookie header lines. (See: CookieEngine.StringValue for details.)
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_COOKIELIST.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.SetCookie
		  
		  Me.Invalidate
		  If Left(RawCookie, 7) <> "Cookie:" Then Return Owner.SetOption(libcURL.Opts.COOKIELIST, RawCookie)
		  
		  ' convert the Cookie header into one or more Set-Cookie headers
		  ' Since no domain name is specified these will be 'global' cookies.
		  Dim s() As String = Split(Replace(RawCookie, "Cookie: ", ""), ";")
		  Dim count As Integer = UBound(s)
		  For i As Integer = 0 To count
		    Dim ck As String = s(i).Trim
		    If ck = "" Then Continue
		    If Not Me.SetCookie("Set-Cookie: " + ck) Then Return False
		  Next
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetCookie(Name As String, Value As String, Domain As String, Expires As Date = Nil, Path As String = "", HTTPOnly As Boolean = False) As Boolean
		  ' Sets a cookie for the cookie engine to use. If a cookie with the same name and domain already exists it will be updated. If
		  ' no domain is specified then the cookie will be sent with all transfers and cannot be modified by a server-set cookie; always
		  ' specify a domain if more than one server will be contacted.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_COOKIELIST.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.SetCookie
		  
		  Dim c As String = "Set-Cookie: " + Name + "=" + Value
		  If Domain <> "" Then c = c + "; Domain=" + Domain
		  If Path <> "" Then c = c + "; path=" + Path
		  If Expires <> Nil Then c = c + "; Expires=" + libcURL.ParseDate(Expires)
		  If HTTPOnly Then c = c + "; httpOnly"
		  Return Me.SetCookie(c)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue(Index As Integer, StringFormat As Integer = libcURL.CookieEngine.FORMAT_NETSCAPE) As String
		  ' Returns the string value of the cookie at Index using the format specified by StringFormat.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.StringValue
		  
		  Dim cookie As String
		  Select Case StringFormat
		  Case FORMAT_NETSCAPE
		    If Not mDirty And mLastCookie <> Nil And mLastCookie.Right = Index Then
		      cookie = mLastCookie.Left
		    Else
		      cookie = CookieList.Item(Index)
		      mLastCookie = cookie:Index
		    End If
		    
		  Case FORMAT_HTTP
		    cookie = "Set-Cookie: " + Me.Name(Index) + "=" + Me.Value(Index)
		    If Me.Domain(Index) <> "" Then cookie = cookie + "; Domain=" + Me.Domain(Index)
		    If Me.Path(Index) <> "" Then cookie = cookie + "; path=" + Me.Path(Index)
		    If Me.Expiry(Index) <> Nil Then cookie = cookie + "; Expires=" + libcURL.ParseDate(Me.Expiry(Index))
		    If Me.HTTPOnly(Index) Then cookie = cookie + "; httpOnly"
		    
		  Else
		    Raise New UnsupportedFormatException
		  End Select
		  
		  Return cookie
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Index As Integer) As String
		  ' Gets the value of the cookie at Index.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Value
		  
		  Return NthField(Me.StringValue(Index), Chr(9), 7)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Index As Integer, Assigns NewValue As String)
		  ' Sets the value of the cookie at Index.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Value
		  
		  If Not Me.SetCookie(Me.Name(Index), NewValue, Me.Domain(Index), Me.Expiry(Index), Me.Path(Index), Me.HTTPOnly(Index)) Then
		    Raise New libcURL.cURLException(Owner)
		  End If
		End Sub
	#tag EndMethod


	#tag Note, Name = About this class
		This class provides accessor methods to control libcurl's internal cookie engine.
		The cookie engine works much like that of a web browser, automatically collecting
		cookies when they are received and sending them back when appropriate.
		
		The cookie engine indexes cookies by cookie name and by domain name. Cookies are
		only sent if the remote host matches the domain. 
		
		You may set/update cookies by calling the SetCookie method. If you are connecting to 
		multiple servers then you should always specify a domain name when setting cookies.
		Cookies without a domain ("") will be sent to ALL hosts, will not be updated
		if a remote host uses the Set-Cookie header, and will be sent in addition to any
		same-named cookies which do specify a domain.
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Gets the local file to be used as cookie storage. If no file/folder is specified (default) then returns Nil.
			  
			  return mCookieJar
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets the local file to be used as cookie storage.
			  '
			  ' See:
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_COOKIEJAR.html
			  ' http://curl.haxx.se/libcurl/c/CURLOPT_COOKIEFILE.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.CookieJar
			  
			  If value = Nil Or value.Directory Then
			    If Not Owner.SetOption(libcURL.Opts.COOKIEFILE, Nil) Then Raise New cURLException(Owner)
			    If Not Owner.SetOption(libcURL.Opts.COOKIEJAR, Nil) Then Raise New cURLException(Owner)
			  Else
			    If Not Owner.SetOption(libcURL.Opts.COOKIEFILE, value) Then Raise New cURLException(Owner)
			    If Not Owner.SetOption(libcURL.Opts.COOKIEJAR, value) Then Raise New cURLException(Owner)
			    mEnabled = True
			  End If
			  
			  mCookieJar = value
			  
			End Set
		#tag EndSetter
		CookieJar As FolderItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If mDirty Or mCookieList = Nil Then
			    mCookieList = Owner.GetInfo(libcURL.Info.COOKIELIST)
			    mDirty = False
			  End If
			  return mCookieList
			End Get
		#tag EndGetter
		Protected CookieList As libcURL.ListPtr
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mEnabled Or mCookieJar <> Nil
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Enables/disables the cookie engine
			  '
			  ' See:
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.CookieEngine.Enabled
			  
			  If value Then
			    If Not Owner.SetOption(libcURL.Opts.COOKIEFILE, "") Then Raise New cURLException(Owner)
			  Else
			    CookieJar = Nil
			  End If
			  mEnabled = value
			End Set
		#tag EndSetter
		Enabled As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCookieJar As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCookieList As libcURL.ListPtr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDirty As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastCookie As Pair
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOwner As WeakRef
	#tag EndProperty


	#tag Constant, Name = FORMAT_HTTP, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FORMAT_NETSCAPE, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Enabled"
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
