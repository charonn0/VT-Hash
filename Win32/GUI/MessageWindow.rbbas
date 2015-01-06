#tag Class
Protected Class MessageWindow
Inherits Win32.GUI.MessageMonitor
Implements Win32.Win32Object
	#tag CompatibilityFlags = TargetHasGUI
	#tag Method, Flags = &h0
		Sub Close()
		  Super.Close
		  If Not Win32.Libs.User32.DestroyWindow(Me.Handle) Then mLastError = Win32.LastError
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor()
		  Me.Constructor("WinLibMessageWindow")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ClassName As String)
		  mAtom = Super.RegisterClass(ClassName, AddressOf DefWindowProc)
		  Dim HWND As Integer = Super.CreateWindow(ClassName, "", 0, 0, 0, 0, 0, New Win32.GUI.HWND(HWND_MESSAGE))
		  mLastError = Win32.LastError
		  If HWND <> 0 Then
		    Super.Constructor(HWND)
		  Else
		    Raise Win32Exception(Win32.LastError)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function DefWindowProc(HWND as Integer, msg as Integer, wParam as Ptr, lParam as Ptr) As Integer
		  #pragma X86CallingConvention StdCall
		  #If TargetWin32 Then
		    Select Case msg
		    Case WM_CREATE, WM_NCCREATE
		      ' Windows sends these messages when the window is first created, but before this class is fully initialized.
		      ' We must return success else Windows will consider the creation to have failed.
		      Return 1
		    Else
		      ' Let the superclass handle all other messages
		      Break
		      Return Super.DefWindowProc(HWND, msg, wParam, lParam)
		    End Select
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  Me.Close
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Note, Name = About this class
		This class provides an invisible message-reception window.
	#tag EndNote


	#tag Property, Flags = &h1
		Protected mAtom As Integer
	#tag EndProperty


	#tag Constant, Name = HWND_MESSAGE, Type = Double, Dynamic = False, Default = \"-3", Scope = Private
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
