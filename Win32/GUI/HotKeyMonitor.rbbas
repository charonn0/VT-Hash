#tag Class
Protected Class HotKeyMonitor
Inherits Win32.GUI.MessageMonitor
	#tag CompatibilityFlags = TargetHasGUI
	#tag Event
		Function WindowMessage(Message As Integer, WParam As Ptr, LParam As Ptr) As Boolean
		  If Message = WM_HOTKEY Then
		    Dim keystring As String = ConstructKeyString(Integer(LParam))
		    Return HotKeyPressed(Integer(WParam), keystring)
		  End If
		End Function
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Shared Function ConstructKeyString(lParam as Integer) As String
		  #If TargetWin32 Then
		    Dim lo, high As Integer
		    lo = Bitwise.BitAnd(lParam, &hFFFF)
		    high = Bitwise.ShiftRight(lParam, 16)
		    
		    Dim ret As String
		    If Bitwise.BitAnd(lo, MOD_CONTROL) <> 0 Then
		      ret = ret + "Ctrl "
		    End
		    If Bitwise.BitAnd(lo, MOD_ALT) <> 0 Then
		      ret = ret + "Alt "
		    End
		    If Bitwise.BitAnd(lo, MOD_SHIFT) <> 0 Then
		      ret = ret + "Shift "
		    End
		    If Bitwise.BitAnd(lo, MOD_WIN) <> 0 Then
		      ret = ret + "Meta "
		    End
		    ret = ReplaceAll(ret, " ", "+")
		    
		    Dim scanCode As Integer = Win32.Libs.User32.MapVirtualKey(high, 0)
		    scanCode = Bitwise.ShiftLeft(scanCode, 16)
		    Dim keyText As New MemoryBlock(32)
		    Dim keyTextLen As Integer
		    keyTextLen = Win32.Libs.User32.GetKeyNameText(scanCode, keyText, keyText.Size)
		    Return ret + keyText.WString(0)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  // Constructor(HWND As Integer) -- From MessageMonitor
		  Super.Constructor(RB_FOREMOST_WINDOW_HWND)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  For i As Integer = UBound(KeyIDs) DownTo 0
		    Me.UnregisterKey(KeyIDs(i))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RegisterKey(modifiers as Integer, virtualKey as Integer, Optional ID As Integer) As Integer
		  #If TargetWin32 Then
		    If ID = 0 Then ID = NextNum
		    If Win32.Libs.User32.RegisterHotKey(Me.Handle, ID, modifiers, virtualKey) Then
		      KeyIDs.Append(id)
		      Return id
		    Else
		      Return -1
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RegisterKey(Key As String, ParamArray modifiers() As Integer) As Integer
		  Dim m As Integer
		  For i As Integer = 0 To UBound(modifiers)
		    m = m Or modifiers(i)
		  Next
		  Return Me.RegisterKey(m, VirtualKey(key))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnregisterKey(id as Integer)
		  #If TargetWin32 Then
		    Call Win32.Libs.User32.UnregisterHotkey(Me.Handle, id)
		    Call Win32.Libs.User32.GlobalDeleteAtom(id)
		    For i As Integer = UBound(KeyIDs) DownTo 0
		      If KeyIDs(i) = id Then
		        KeyIDs.Remove(i)
		      End If
		    Next
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function VirtualKey(Key As String) As Integer
		  #If TargetWin32 Then Return Win32.Libs.User32.VkKeyScan(Asc(Key))
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event HotKeyPressed(Identifier As Integer, KeyString As String) As Boolean
	#tag EndHook


	#tag Note, Name = About This Class
		This class allows you to detect specified keyboard shortcuts no matter what application has keyboard input.
		
		For example:
		
		     Dim hotkey As New HotKeyMonitor()
		     Dim hotkeyID As Integer = HotKey.RegisterKey("a", MOD_CONTROL, MOD_ALT)
		
		The above snippet would raise the HotKeyMonitor.HotKeyPressed event whenever the global hotkey combo Ctrl+Alt+a is pressed.
		Each instance of the HotKeyMonitor class can handle an arbitrary number of hotkey combinations, each being uniquely
		identifiable by their hotkeyID number. A global hotkey combo can be registered to only one application at a time, and
		only the most recent application to register the combo will be notified.
		
		If you no longer want to receive notifications for a particular HotKey, pass its ID number (the return value from RegisterKey)
		to the UnregisterKey method. 
		
		See: http://msdn.microsoft.com/en-us/library/windows/desktop/ms646309%28v=vs.85%29.aspx
	#tag EndNote


	#tag Property, Flags = &h1
		Protected KeyIDs() As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Static i As Integer
			  i = i + 1
			  Return i
			End Get
		#tag EndGetter
		Private Shared NextNum As Integer
	#tag EndComputedProperty


	#tag Constant, Name = MOD_ALT, Type = Double, Dynamic = False, Default = \"&h1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MOD_CONTROL, Type = Double, Dynamic = False, Default = \"&h2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MOD_SHIFT, Type = Double, Dynamic = False, Default = \"&h4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MOD_WIN, Type = Double, Dynamic = False, Default = \"&h8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = WM_HOTKEY, Type = Double, Dynamic = False, Default = \"&h0312", Scope = Public
	#tag EndConstant


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
