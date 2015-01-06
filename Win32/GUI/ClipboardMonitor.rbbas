#tag Class
Protected Class ClipboardMonitor
Inherits Win32.GUI.MessageMonitor
	#tag CompatibilityFlags = TargetHasGUI
	#tag Event
		Function WindowMessage(Message As Integer, WParam As Ptr, LParam As Ptr) As Boolean
		  #If TargetWin32 Then
		    Select Case Message
		    Case WM_CHANGECBCHAIN ' XP and older
		      'A window is being removed
		      If Integer(WParam) = NextViewerWindow Then
		        NextViewerWindow = Integer(LParam)
		        Return True
		      Else
		        Call Win32.Libs.User32.SendMessage(NextViewerWindow, Message, WParam, LParam)
		        Return True
		      End If
		      
		    Case WM_DRAWCLIPBOARD ' XP and older
		      'clipboard changed, pass it on
		      Call Win32.Libs.User32.SendMessage(NextViewerWindow, Message, WParam, LParam)
		      RaiseEvent ClipboardChanged()
		      
		      Return True
		    Case WM_CLIPBOARDUPDATE ' Vista and newer
		      RaiseEvent ClipboardChanged()
		      Return True
		      
		    End Select
		  #endif
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h1001
		Protected Sub Constructor()
		  ' Empty constructor so the class can be dropped on a window.
		  Me.Constructor(RB_FOREMOST_WINDOW_HWND)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(ParentHandle As Integer)
		  // Calling the overridden superclass constructor.
		  // Constructor(HWND As Integer) -- From MessageMonitor
		  Super.Constructor(ParentHandle)
		  #If TargetWin32 Then
		    If Win32.KernelVersion >= 6.0 Then ' Vista and newer
		      If Not Win32.Libs.User32.AddClipboardFormatListener(Me.Handle) Then
		        mLastError = Win32.LastError
		        Raise Win32Exception(mLastError)
		      End If
		    Else
		      NextViewerWindow = Win32.Libs.User32.SetClipboardViewer(Me.Handle)
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  #If TargetWin32 Then
		    If Win32.KernelVersion >= 6.0 Then ' Vista and newer
		      Call Win32.Libs.User32.RemoveClipboardFormatListener(Me.Handle)
		      
		    Else ' XP and older
		      ' We must unlink ourselves from the Clipboard chain without breaking it!
		      Call Win32.Libs.User32.ChangeClipboardChain(Me.Handle, Me.NextViewerWindow)
		    End If
		  #endif
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ClipboardChanged()
	#tag EndHook


	#tag Note, Name = About this class
		For Windows XP and older, uses this API: http://msdn.microsoft.com/en-us/library/windows/desktop/ms649052%28v=vs.85%29.aspx
		
		For Vista and newer, uses the new API: http://msdn.microsoft.com/en-us/library/windows/desktop/ms649033%28v=vs.85%29.aspx
		
		Monitors the system-wide clipboard for changes.
	#tag EndNote


	#tag Property, Flags = &h1
		#tag Note
			This property is unused on Vista and newer
		#tag EndNote
		Protected NextViewerWindow As Integer
	#tag EndProperty


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
