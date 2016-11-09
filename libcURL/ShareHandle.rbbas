#tag Class
Protected Class ShareHandle
Inherits libcURL.cURLHandle
	#tag Method, Flags = &h0
		Function AddItem(Item As libcURL.EasyHandle) As Boolean
		  ' Add an easy handle to share handle
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_SHARE.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.AddItem
		  
		  If Not SharedHandles.HasKey(Item.Handle) And Item.SetOption(libcURL.Opts.SHARE, Me) Then
		    SharedHandles.Value(Item.Handle) = Item
		    Return True
		  Else
		    mLastError = Item.LastError
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
		  
		  If SharedHandles <> Nil And libcURL.IsAvailable Then
		    For Each h As Integer In SharedHandles.Keys
		      Call Me.RemoveItem(SharedHandles.Value(h))
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
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(GlobalInitFlags)
		  mHandle = curl_share_init()
		  If mHandle = 0 Then
		    mLastError = libcURL.Errors.INIT_FAILED
		    Raise New cURLException(Me)
		  End If
		  SharedHandles = New Dictionary
		  #If ENABLE_MUTEX Then
		    If Instances = Nil Then Instances = New Dictionary
		    Instances.Value(mHandle) = New WeakRef(Me)
		    CookieLock = New Mutex(Hex(mHandle) + "_Cookie")
		    SSLLock = New Mutex(Hex(mHandle) + "_SSL")
		    DNSLock = New Mutex(Hex(mHandle) + "_DNS")
		    
		    If Not Me.SetOption(libcURL.Opts.SHOPT_USERDATA, mHandle) Then Raise New cURLException(Me)
		    If Not Me.SetOption(libcURL.Opts.SHOPT_LOCKFUNC, AddressOf LockCallback) Then Raise New cURLException(Me)
		    If Not Me.SetOption(libcURL.Opts.SHOPT_UNLOCKFUNC, AddressOf UnlockCallback) Then Raise New cURLException(Me)
		  #endif
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub cURLLock(ShareItem As Integer, Data As curl_lock_data, Access As curl_lock_access, UserData As Integer)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Sub cURLUnlock(ShareItem As Integer, Data As curl_lock_data, UserData As Integer)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Sub curl_Lock(Data As curl_lock_data, Access As curl_lock_access)
		  #pragma Unused Access
		  Select Case Data
		  Case curl_lock_data.LOCK_COOKIE
		    CookieLock.Enter
		    
		  Case curl_lock_data.LOCK_DNS
		    DNSLock.Enter
		    
		  Case curl_lock_data.LOCK_SSL
		    SSLLock.Enter
		    
		  Case curl_lock_data.LOCK_SHARE
		    SSLLock.Enter
		    DNSLock.Enter
		    CookieLock.Enter
		    
		  Else
		    Raise New IllegalLockingException
		    
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub curl_Unlock(Data As curl_lock_data)
		  Select Case Data
		  Case curl_lock_data.LOCK_COOKIE
		    CookieLock.Leave
		    
		  Case curl_lock_data.LOCK_DNS
		    DNSLock.Leave
		    
		  Case curl_lock_data.LOCK_SSL
		    SSLLock.Leave
		    
		  Case curl_lock_data.LOCK_SHARE
		    SSLLock.Leave
		    DNSLock.Leave
		    CookieLock.Leave
		    
		  Else
		    Raise New IllegalLockingException
		    
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Close
		  If mHandle <> 0 Then
		    mLastError = curl_share_cleanup(mHandle)
		    If mLastError = 0 Then
		      If Instances <> Nil And Instances.HasKey(mHandle) Then Instances.Remove(mHandle)
		      mHandle = 0
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub LockCallback(ShareItem As Integer, Data As curl_lock_data, Access As curl_lock_access, UserData As Integer)
		  #pragma X86CallingConvention StdCall
		  #pragma Unused ShareItem
		  
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA ShareHandle Then
		    ShareHandle(curl.Value).curl_Lock(Data, Access)
		    Return
		  End If
		  Break 'UserData does not refer to a valid instance!
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherShare As libcURL.ShareHandle) As Integer
		  Dim i As Integer = Super.Operator_Compare(OtherShare)
		  If i = 0 Then i = Sign(mHandle - OtherShare.Handle)
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemoveItem(Item As libcURL.EasyHandle) As Boolean
		  ' Remove an easy handle from share handle.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/CURLOPT_SHARE.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.ShareHandle.RemoveItem
		  
		  If SharedHandles.HasKey(Item.Handle) And Item.SetOption(libcURL.Opts.SHARE, Nil) Then
		    SharedHandles.Remove(Item.Handle)
		    Return True
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(OptionNumber As Integer, NewValue As Variant) As Boolean
		  Select Case NewValue
		  Case IsA cURLLock
		    Dim p As cURLLock = NewValue
		    mLastError = curl_share_setopt(mHandle, OptionNumber, p)
		  Case IsA cURLUnlock
		    Dim p As cURLUnlock = NewValue
		    mLastError = curl_share_setopt(mHandle, OptionNumber, p)
		  Else
		    mLastError = curl_share_setopt(mHandle, OptionNumber, NewValue.PtrValue)
		  End Select
		  
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub UnlockCallback(ShareItem As Integer, Data As curl_lock_data, UserData As Integer)
		  #pragma X86CallingConvention StdCall
		  #pragma Unused ShareItem
		  
		  Dim curl As WeakRef = Instances.Lookup(UserData, Nil)
		  If curl <> Nil And curl.Value <> Nil And curl.Value IsA ShareHandle Then
		    ShareHandle(curl.Value).curl_Unlock(Data)
		    Return
		  End If
		  Break 'UserData does not refer to a valid instance!
		End Sub
	#tag EndMethod


	#tag Note, Name = About this class
		
		s
	#tag EndNote


	#tag Property, Flags = &h21
		Private CookieLock As Mutex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DNSLock As Mutex
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared Instances As Dictionary
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
			  return mShareCookies
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mShareCookies = value
			  Dim shareoption As Integer
			  If mShareCookies Then shareoption = CURLSHOPT_SHARE Else shareoption = CURLSHOPT_UNSHARE
			  If Not Me.SetOption(shareoption, curl_lock_data.LOCK_COOKIE) Then Raise New cURLException(Me)
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
			  mShareDNSCache = value
			  Dim shareoption As Integer
			  If mShareDNSCache Then shareoption = CURLSHOPT_SHARE Else shareoption = CURLSHOPT_UNSHARE
			  If Not Me.SetOption(shareoption, curl_lock_data.LOCK_DNS) Then Raise New cURLException(Me)
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
			  mShareSSL = value
			  Dim shareoption As Integer
			  If mShareSSL Then shareoption = CURLSHOPT_SHARE Else shareoption = CURLSHOPT_UNSHARE
			  If Not Me.SetOption(shareoption, curl_lock_data.LOCK_SSL) Then Raise New cURLException(Me)
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

	#tag Constant, Name = ENABLE_MUTEX, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant


	#tag Enum, Name = curl_lock_access, Type = Integer, Flags = &h21
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
			Name="ShareCookies"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShareDNSCache"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShareSSL"
			Group="Behavior"
			Type="Boolean"
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
