#tag Class
Protected Class MultiHandle
Inherits libcURL.cURLHandle
	#tag Method, Flags = &h0
		Function AddItem(Item As libcURL.EasyHandle) As Boolean
		  ' Add a EasyHandle to the multistack. The EasyHandle should have all of its options already set and ready to go.
		  ' A EasyHandle may belong to only one MultiHandle object at a time. Passing an owned EasyHandle will fail.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_multi_add_handle.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultiHandle.AddItem
		  
		  If Not libcURL.Version.IsAtLeast(7, 32, 1) And Instances.HasKey(Item.Handle) Then
		    ' This error code was not defined until 7.32.1, so we fake it
		    Const CURLM_ADDED_ALREADY = 7
		    mLastError = CURLM_ADDED_ALREADY
		    
		  Else
		    mLastError = curl_multi_add_handle(mHandle, Item.Handle)
		    If mLastError = 0 Then Instances.Value(Item.Handle) = Item
		  End If
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  ' Removes all EasyHandles from the stack
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultiHandle.Close
		  
		  If Instances <> Nil Then
		    For Each h As Integer In Instances.Keys
		      Call Me.RemoveItem(Instances.Value(h))
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GlobalInitFlags As Integer = libcURL.CURL_GLOBAL_DEFAULT)
		  ' Creates a new multi stack
		  
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_multi_init.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultiHandle.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(GlobalInitFlags As Integer) -- From libcURL.cURLHandle
		  Super.Constructor(GlobalInitFlags)
		  
		  mHandle = curl_multi_init()
		  If mHandle <= 0 Then
		    mLastError = libcURL.Errors.INIT_FAILED
		    Raise New cURLException(Me)
		  End If
		  Instances = New Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  ' Returns the number of EasyHandles currently being managed by the MultiHandle.
		  
		  Return Instances.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  ' Destroys the stack. Any remaining EasyHandles are removed first.
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_multi_cleanup.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultiHandle.Destructor
		  
		  Me.Close
		  If mHandle <> 0 Then mLastError = curl_multi_cleanup(mHandle)
		  mHandle = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasItem(EasyItem As libcURL.EasyHandle) As Boolean
		  Return Instances.HasKey(EasyItem.Handle)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherMulti As libcURL.MultiHandle) As Integer
		  Dim i As Integer = Super.Operator_Compare(OtherMulti)
		  If i = 0 Then i = Sign(mHandle - OtherMulti.Handle)
		  Return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Perform()
		  ' Calling this method will activate a timer which calls PerformOnce on the multistack until the last item is Removed.
		  ' If the stack is not being processed, begins processing the stack. If the stack is already being processed, updates the PerformTimer
		  ' period with libcURL's best estimate of an optimum interval.
		  '
		  ' See:
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultiHandle.Perform
		  
		  If PerformTimer = Nil Then
		    PerformTimer = New Timer
		    AddHandler PerformTimer.Action, WeakAddressOf PerformTimerHandler
		  End If
		  Dim q As Integer = QueryInterval()
		  PerformTimer.Period = Min(Max(q, 10), 100)
		  PerformTimer.Mode = Timer.ModeMultiple
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PerformOnce() As Boolean
		  ' Calling this method will call curl_multi_perform on the multistack once and read all
		  ' messages emitted by libcURL during that operation. The TransferComplete event will be
		  ' raised for any completed easy handles. This method must be called repeatedly until libcURL
		  ' indicates that all transfers have completed. PerformOnce will return True until all transfers
		  ' have completed or an error occurs.
		  '
		  ' Unlike MultiHandle.Perform, this method will run the transfers and raise events on the calling
		  ' thread instead of always on the main thread.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_multi_perform.html
		  ' http://curl.haxx.se/libcurl/c/curl_multi_info_read.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultiHandle.PerformOnce
		  
		  If StackLocked Then
		    mLastError = libcURL.Errors.CALL_LOOP_DETECTED
		    Raise New cURLException(Me) ' Called by an EasyHandle or MultiHandle event!
		  End If
		  StackLocked = True
		  Try
		    Dim c As Integer
		    mLastError = curl_multi_perform(mHandle, c) ' on exit, 'c' will contain the number of easy handles with unfinished business.
		    If (mLastError = 0 Or mLastError = CURLM_CALL_MULTI_PERFORM) And (LastCount <> c Or c <> Instances.Count) Then
		      LastCount = c
		      Do
		        Dim msg As CURLMsg = ReadNextMsg(c) ' on exit, 'c' will contain the number of messages remaining
		        If c > -1 Then
		          Dim curl As EasyHandle = Instances.Value(msg.easy_handle)
		          Call Me.RemoveItem(curl)
		          ErrorSetter(curl).LastError = Integer(msg.Data) ' msg.Data is the last error code for the easy handle
		          RaiseEvent TransferComplete(curl)
		          
		        End If
		      Loop Until c <= 0
		    End If
		  Finally
		    StackLocked = False
		  End Try
		  Return ((mLastError = 0 Or mLastError = CURLM_CALL_MULTI_PERFORM) And Instances.Count > 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PerformTimerHandler(Sender As Timer)
		  ' This method handles the PerformTimer.Action event. It calls PerformOnce on the main thread until PerformOnce returns False.
		  
		  ' this loop calls PerformOnce 3 times and then updates the Timer's period.
		  For i As Integer = 0 To 4
		    If Not Me.PerformOnce() Then
		      Sender.Mode = Timer.ModeOff
		      Exit For
		    ElseIf i = 4 Then
		      Sender.Period = QueryInterval()
		    End If
		  Next
		  
		  Exception Err As RuntimeException
		    #pragma BreakOnExceptions Off
		    If Err IsA EndException Or Err IsA ThreadEndException Then Raise Err
		    If Sender <> Nil Then Sender.Mode = Timer.ModeOff
		    Raise Err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function QueryInterval() As Double
		  ' Returns libcURL's best estimate for an optimum interval, in milliseconds, between calls to PerformOnce. An interval of 1 means
		  ' that PerformOnce may be called immediately.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_multi_timeout.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultiHandle.QueryInterval
		  
		  Static IsAvailable As Boolean
		  If Not IsAvailable Then IsAvailable = libcURL.Version.IsAtLeast(7, 15, 4)
		  Dim time As timeval
		  If IsAvailable Then
		    mLastError = curl_multi_timeout(mHandle, time)
		  Else
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		  End If
		  If mLastError = 0 Then
		    Dim d As Double = CDbl(Str(time.tv_sec) + "." + Str(time.tv_usec))
		    If d < 0.0 Or d > 1000.0 Then d = 10.0
		    Return d
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReadNextMsg(ByRef MsgsRemaining As Integer) As CURLMsg
		  Dim p As Ptr = curl_multi_info_read(mHandle, MsgsRemaining)
		  If p <> Nil Then
		    Return p.CURLMsg
		  ElseIf MsgsRemaining = 0 Then
		    MsgsRemaining = -1
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RemoveItem(Item As libcURL.EasyHandle) As Boolean
		  ' Removes the passed EasyHandle from the multistack. If there no more EasyHandles then turns off the PerformTimer.
		  '
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_multi_remove_handle.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultiHandle.RemoveItem
		  
		  mLastError = curl_multi_remove_handle(mHandle, Item.Handle)
		  If Instances.HasKey(Item.Handle) Then Instances.Remove(Item.Handle)
		  If Instances.Count = 0 And PerformTimer <> Nil Then PerformTimer.Mode = Timer.ModeOff
		  Return mLastError = 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOption(OptionNumber As Integer, NewValue As Variant) As Boolean
		  ' SetOption is the primary interface to the multistack. Call this method with a MultiHandle option number
		  ' and a value that is acceptable for that option. SetOption does not check that a value is valid for
		  ' a particular option (except Nil,) however it does enforce type safety of the value and will raise
		  ' an exception if an unsupported type is passed.
		  
		  ' NewValue may be a Boolean, Integer, Ptr, String, or MemoryBlock. Passing a Nil object will raise an
		  ' exception unless the option explicitly accepts NULL.
		  
		  ' If the option was set this method returns True. If it returns False the option was not set and the
		  ' curl error number is stored in MultiHandle.LastError.
		  
		  ' See:
		  ' http://curl.haxx.se/libcurl/c/curl_multi_setopt.html
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultiHandle.SetOption
		  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.Opts
		  
		  If Not libcURL.Version.IsAtLeast(7, 15, 4) Then
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(Me)
		  End If
		  
		  Dim MarshalledValue As MemoryBlock
		  Dim ValueType As Integer = VarType(NewValue)
		  Select Case ValueType
		  Case Variant.TypeNil
		    ' Sometimes Nil is an error; sometimes not
		    Select Case OptionNumber
		    Case libcURL.Opts.PIPELINING_SITE_BL, libcURL.Opts.PIPELINING_SERVER_BL
		      ' These option numbers explicitly accept NULL. Refer to the curl documentation on the individual option numbers for details.
		      Return Me.SetOptionPtr(OptionNumber, Nil)
		    Else
		      ' for all other option numbers reject NULL values.
		      Dim err As New NilObjectException
		      err.Message = "cURL option number 0x" + Hex(OptionNumber) + " may not be set to null."
		      Raise err
		    End Select
		    
		  Case Variant.TypeBoolean
		    If NewValue.BooleanValue Then
		      Return Me.SetOption(OptionNumber, 1)
		    Else
		      Return Me.SetOption(OptionNumber, 0)
		    End If
		    
		  Case Variant.TypePtr, Variant.TypeInteger
		    MarshalledValue = NewValue.PtrValue
		    
		    #If Target64Bit Then
		  Case Variant.TypeInt64
		    MarshalledValue = NewValue.PtrValue
		    #EndIf
		    
		  Case Variant.TypeString
		    MarshalledValue = NewValue.StringValue + Chr(0)
		    
		  Case Variant.TypeObject
		    Select Case NewValue
		    Case IsA MemoryBlock
		      MarshalledValue = NewValue.PtrValue
		      
		    Else
		      Dim err As New TypeMismatchException
		      err.Message = "NewValue is of unsupported vartype: " + Str(ValueType)
		      Raise err
		      
		    End Select
		    
		  Else
		    Dim err As New TypeMismatchException
		    err.Message = "NewValue is of unsupported vartype: " + Str(ValueType)
		    Raise err
		  End Select
		  
		  Return Me.SetOptionPtr(OptionNumber, MarshalledValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetOptionPtr(OptionNumber As Integer, NewValue As Ptr) As Boolean
		  If Not libcURL.Version.IsAtLeast(7, 15, 4) Then
		    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
		    Raise New cURLException(Me)
		  End If
		  
		  mLastError = curl_multi_setopt(mHandle, OptionNumber, NewValue)
		  Return mLastError = 0
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event TransferComplete(easyitem As libcURL.EasyHandle)
	#tag EndHook


	#tag Note, Name = Using this class
		This class implements the curl_multi interface of libcURL. A MultiHandle instance can manage one or more EasyHandles. 
		See: http://curl.haxx.se/libcurl/c/libcurl-multi.html
		
		Using MultiHandle allows us to use the EasyHandle class asynchronously, either automatically on the main thread or 'manually' 
		on a RB thread.
		
		EasyHandles may be added to the stack at any time. Once added, MultiHandle will maintain a (RB) reference to the EasyHandle.
		You should not call any methods/set any properties on the EasyHandle until you receive its reference as the parameter to the 
		TransferComplete event.
		
		Once all desired EasyHandles have been added, you may call Perform or PerformOnce to begin the transfer(s). 
		
		Calling PerformOnce executes curl_multi_perform once and processes all completed EasyHandles. All EasyHandle and MultiHandle events will be 
		raised on the thread which calls PerformOnce. PerformOnce will not return until all event handlers have returned.
		
		Calling Perform will activate a timer which calls PerformOnce on the main thread until there are no more items. Perform returns immediately.
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mHTTPMultiplexing
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets whether two (or more) HTTP requests which are added to the same MultiHandle can be
			  ' multiplexed over the same connection (HTTP/2 required).
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/CURLMOPT_PIPELINING.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultiHandle.HTTPMultiplexing
			  
			  If Not libcURL.Version.IsAtLeast(7, 43, 0) Or Not libcURL.Version.HTTP2 Then
			    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
			    Return
			  End If
			  
			  If value Then
			    If Not Me.SetOption(libcURL.Opts.Multi.PIPELINING, 2) Then Raise New cURLException(Me)
			  Else
			    If Not Me.SetOption(libcURL.Opts.Multi.PIPELINING, mHTTPPipelining) Then Raise New cURLException(Me)
			  End If
			  mHTTPMultiplexing = value
			End Set
		#tag EndSetter
		HTTPMultiplexing As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mHTTPPipelining
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' Sets whether two (or more) HTTP requests which are added to the same MultiHandle can be
			  ' pipelined over the same connection (server support required).
			  '
			  ' See:
			  ' https://curl.haxx.se/libcurl/c/CURLMOPT_PIPELINING.html
			  ' https://github.com/charonn0/RB-libcURL/wiki/libcURL.MultiHandle.HTTPPipelining
			  
			  If Not libcURL.Version.IsAtLeast(7, 16, 0) Then
			    mLastError = libcURL.Errors.FEATURE_UNAVAILABLE
			    Return
			  End If
			  
			  If Not Me.SetOption(libcURL.Opts.Multi.PIPELINING, value) Then Raise New cURLException(Me)
			  mHTTPPipelining = value
			End Set
		#tag EndSetter
		HTTPPipelining As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Instances As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastCount As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHTTPMultiplexing As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHTTPPipelining As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PerformTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private StackLocked As Boolean
	#tag EndProperty


	#tag Constant, Name = CURLM_CALL_MULTI_PERFORM, Type = Double, Dynamic = False, Default = \"-1", Scope = Private
	#tag EndConstant


	#tag Structure, Name = CURLMsg, Flags = &h1, Attributes = \"StructureAlignment \x3D 1"
		msg As Integer
		  easy_handle As Integer
		Data As Ptr
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="HTTPMultiplexing"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPPipelining"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
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
	#tag EndViewBehavior
End Class
#tag EndClass
