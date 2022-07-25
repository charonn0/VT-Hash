#tag Class
Protected Class ShareHandle
Inherits libcURL.cURLHandle
	#tag Method, Flags = &h0
		Attributes( deprecated = "libcURL.ShareHandle.AddTransfer" )  Function AddItem(Item As libcURL.EasyHandle) As Boolean
		  Return AddTransfer(Item)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddTransfer(Transfer As libcURL.EasyHandle) As Boolean
		  ' Add an easy handle to share handle
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_SHARE.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.AddTransfer
		  
		  If Not Me.HasTransfer(Transfer) And Transfer.SetOption(libcURL.Opts.SHARE, Me) Then
		    SharedHandles.Value(Transfer.Handle) = Transfer
		    Return True
		  Else
		    mLastError = Transfer.LastError
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  ' Removes all EasyHandles from the share
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.Close
		  
		  If SharedHandles <> Nil Then
		    For Each h As Integer In SharedHandles.Keys
		      Call Me.RemoveTransfer(SharedHandles.Value(h))
		    Next
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(GlobalInitFlags As Integer = libcURL.CURL_GLOBAL_DEFAULT)
		  ' Create a new share.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_share_init.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor() -- From libcURL.cURLHandle
		  #pragma Unused GlobalInitFlags
		  Super.Constructor()
		  mHandle = curl_share_init()
		  If mHandle = 0 Then
		    mLastError = libcURL.Errors.INIT_FAILED
		    Raise New cURLException(Me)
		  End If
		  SharedHandles = New Dictionary
		  
		  If Not Me.SetOption(libcURL.Opts.SHOPT_USERDATA, mHandle) Then Raise New cURLException(Me)
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub cURLLock(ShareItem As Integer, Data As curl_lock_data, Access As curl_lock_access, UserData As Integer)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub cURLUnlock(ShareItem As Integer, Data As curl_lock_data, UserData As Integer)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Close
		  If mHandle <> 0 Then mLastError = curl_share_cleanup(mHandle)
		  mHandle = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( deprecated = "libcURL.ShareHandle.HasTransfer" )  Function HasItem(EasyItem As libcURL.EasyHandle) As Boolean
		  Return HasTransfer(EasyItem)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasTransfer(Transfer As libcURL.EasyHandle) As Boolean
		  Return SharedHandles.HasKey(Transfer.Handle)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherShare As libcURL.ShareHandle) As Integer
		  ' This method overloads the comparison operator(=), permitting direct
		  ' comparisons between instances of ShareHandle.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.Operator_Compare
		  
		  Dim i As Integer = Super.Operator_Compare(OtherShare)
		  If i = 0 Then i = Sign(mHandle - OtherShare.Handle)
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( deprecated = "libcURL.ShareHandle.RemoveTransfer" )  Function RemoveItem(Item As libcURL.EasyHandle) As Boolean
		  Return RemoveTransfer(Item)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemoveTransfer(Transfer As libcURL.EasyHandle) As Boolean
		  ' Remove an easy handle from share handle.
		  '
		  ' See: 
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_SHARE.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.RemoveTransfer
		  
		  If SharedHandles.HasKey(Transfer.Handle) And Transfer.SetOption(libcURL.Opts.SHARE, Nil) Then
		    SharedHandles.Remove(Transfer.Handle)
		    Return True
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(OptionNumber As Integer, NewValue As Variant) As Boolean
		  ' SetOption is the primary interface to the share handle. Call this method with a curl option number
		  ' and a value that is acceptable for that option. SetOption does not check that a value is valid for
		  ' a particular option (except Nil,) however it will raise an exception if an unsupported type is passed.
		  
		  ' If the option was set then this method returns True. If it returns False then the option was not set
		  ' and the curl error number is stored in EasyHandle.LastError.
		  
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_share_setopt.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.SetOption
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts
		  
		  Dim ValueType As Integer = VarType(NewValue)
		  Select Case ValueType
		    
		  Case Variant.TypeNil ' Sometimes Nil is an error; sometimes not
		    Static Nilable() As Integer = Array(libcURL.Opts.SHOPT_LOCKFUNC,libcURL.Opts.SHOPT_UNLOCKFUNC)
		    ' These option numbers explicitly accept NULL. Refer to the curl documentation on the individual option numbers for details.
		    If Nilable.IndexOf(OptionNumber) > -1 Then
		      Return Me.SetOptionPtr(OptionNumber, Nil)
		    Else
		      ' for all other option numbers reject NULL values.
		      Dim err As New NilObjectException
		      err.Message = "cURL option number 0x" + Hex(OptionNumber) + " may not be set to null."
		      Raise err
		    End If
		    
		  Case Variant.TypeBoolean
		    If NewValue.BooleanValue Then
		      Return Me.SetOption(OptionNumber, 1)
		    Else
		      Return Me.SetOption(OptionNumber, 0)
		    End If
		    
		  Case Variant.TypePtr, Variant.TypeInteger
		    Return Me.SetOptionPtr(OptionNumber, NewValue.PtrValue)
		    
		    #If Target64Bit Then
		  Case Variant.TypeInt64
		    Return Me.SetOptionPtr(OptionNumber, NewValue.PtrValue)
		    #EndIf
		    
		  Case Variant.TypeString
		    Dim mb As MemoryBlock = NewValue.CStringValue + Chr(0) ' make doubleplus sure it's null terminated
		    Return Me.SetOptionPtr(OptionNumber, mb)
		    
		  Case Variant.TypeObject
		    ' To add support for a custom object type, add a block to this Select statement
		    Select Case NewValue
		    Case IsA MemoryBlock
		      Return Me.SetOptionPtr(OptionNumber, NewValue.PtrValue)
		      
		    Case IsA FolderItem
		      Return Me.SetOption(OptionNumber, FolderItem(NewValue).AbsolutePath_)
		      
		    Case IsA cURLLock
		      Dim p As cURLLock = NewValue
		      Return Me.SetOptionPtr(OptionNumber, p)
		      
		    Case IsA cURLUnlock
		      Dim p As cURLUnlock = NewValue
		      Return Me.SetOptionPtr(OptionNumber, p)
		      
		    End Select
		  End Select
		  
		  Dim err As New TypeMismatchException
		  err.Message = "NewValue is of unsupported vartype: " + Str(ValueType)
		  Raise err
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOptionPtr(OptionNumber As Integer, NewValue As Ptr) As Boolean
		  ' Call this method with a share option number and a Ptr to a representation of the new value for that option.
		  ' The Ptr is passed verbatim to libcURL.
		  '
		  ' If the option was set this method returns True. If it returns False the option was not set and the
		  ' curl error number is stored in ShareHandle.LastError.
		  
		  ' See:
		  ' https://curl.haxx.se/libcurl/c/curl_share_setopt.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.SetOptionPtr
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts
		  
		  mLastError = curl_share_setopt(mHandle, OptionNumber, NewValue)
		  Return mLastError = 0
		End Function
	#tag EndMethod


	#tag Note, Name = About this class
		This class wraps the curl_share API. EasyHandles that are added to a ShareHandle instance may share SSL session data, 
		DNS caches, connection pools, and/or HTTP cookies. By default nothing is shared. You must enable the share options 
		you want before adding any EasyHandles to the share. Doing so after will raise an error (CURLSHE_IN_USE (2))
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private CookieLock As Mutex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DNSLock As Mutex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShareConnections As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShareCookies As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShareDNSCache As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShareSSL As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mShareConnections
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Specifies whether the connection cache is shared. This feature was added in libcurl 7.57.0.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_share_setopt.html#CURLSHOPTSHARE
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.ShareConnections
			  
			  If Not libcURL.Version.IsAtLeast(7, 57, 0) Then
			    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
			    Return
			  End If
			  
			  Dim shareoption As Integer
			  If value Then shareoption = CURLSHOPT_SHARE Else shareoption = CURLSHOPT_UNSHARE
			  If Not Me.SetOption(shareoption, curl_lock_data.LOCK_CONNECT) Then Raise New cURLException(Me)
			  mShareConnections = value
			End Set
		#tag EndSetter
		ShareConnections As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mShareCookies
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Specifies whether cookies are shared.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_share_setopt.html#CURLSHOPTSHARE
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.ShareCookies
			  
			  
			  Dim shareoption As Integer
			  If value Then shareoption = CURLSHOPT_SHARE Else shareoption = CURLSHOPT_UNSHARE
			  If Not Me.SetOption(shareoption, curl_lock_data.LOCK_COOKIE) Then Raise New cURLException(Me)
			  mShareCookies = value
			End Set
		#tag EndSetter
		ShareCookies As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private SharedHandles As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mShareDNSCache
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Specifies whether the DNS cache is shared.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_share_setopt.html#CURLSHOPTSHARE
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.ShareDNSCache
			  
			  Dim shareoption As Integer
			  If value Then shareoption = CURLSHOPT_SHARE Else shareoption = CURLSHOPT_UNSHARE
			  If Not Me.SetOption(shareoption, curl_lock_data.LOCK_DNS) Then Raise New cURLException(Me)
			  mShareDNSCache = value
			End Set
		#tag EndSetter
		ShareDNSCache As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mShareSSL
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Specifies whether the SSL session data is shared.
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/curl_share_setopt.html#CURLSHOPTSHARE
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.ShareSSL
			  
			  Dim shareoption As Integer
			  If value Then shareoption = CURLSHOPT_SHARE Else shareoption = CURLSHOPT_UNSHARE
			  If Not Me.SetOption(shareoption, curl_lock_data.LOCK_SSL) Then Raise New cURLException(Me)
			  mShareSSL = value
			End Set
		#tag EndSetter
		ShareSSL As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private SSLLock As Mutex
	#tag EndProperty


	#tag Constant, Name = CURLSHOPT_SHARE, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CURLSHOPT_UNSHARE, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


	#tag Enum, Name = curl_lock_access, Flags = &h21
		ACCESS_NONE=0
		  ACCESS_SHARED
		  ACCESS_SINGLE
		ACCESS_LAST
	#tag EndEnum

	#tag Enum, Name = curl_lock_data, Type = Integer, Flags = &h21
		LOCK_NONE=0
		  LOCK_SHARE
		  LOCK_COOKIE
		  LOCK_DNS
		  LOCK_SSL
		  LOCK_CONNECT
		LOCK_LAST
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShareCookies"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShareDNSCache"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShareSSL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShareConnections"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
