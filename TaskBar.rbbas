#tag Class
Protected Class TaskBar
Inherits COM.IUnknown
	#tag Method, Flags = &h0
		Sub Constructor(wnd As Window)
		  mAssociatedWindow = wnd
		  
		  // The CLSID describes the COM object we want to create
		  Dim CLSID_TaskbarList As MemoryBlock = COM.IIDFromString("{56FDF344-FD6D-11d0-958A-006097C9A090}")
		  // The IID describes the interface you're requesting from the COM object
		  Dim IID_ITaskbarList3 As MemoryBlock = COM.IIDFromString("{ea1afb91-9e28-4b86-90e9-9e9f8a5eefaf}")
		  
		  Dim taskBarPtr As Ptr
		  Dim result As Integer
		  result = COM.CoCreateInstance(CLSID_TaskbarList, Nil, COM.CLSCTX_SERVER, IID_ITaskbarList3, taskBarPtr)
		  
		  If result = COM.S_OK Then
		    // Constructor for COM.IUnknown takes a pointer.
		    // This pointer is the TaskBar COM object.
		    // COM.IUnknown adopts the reference and will release this reference on destruction.
		    Super.Constructor(taskBarPtr)
		  Else
		    MsgBox "Failed to create TaskBar object"
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function SetProgressState(this As Ptr, hwnd As Integer, state As TaskBarStates) As Integer
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub SetProgressState(state As TaskBarStates)
		  Dim sizeOfPtr As Integer
		  #if Target64Bit
		    sizeOfPtr = 8
		  #else
		    sizeOfPtr = 4
		  #endif
		  
		  // SetProgressState is listed as the 10th function pointer in ITaskbarList3
		  Dim setProgressStateFunc As New SetProgressState(Handle.Ptr(0).Ptr(10 * sizeOfPtr))
		  Call SetProgressStateFunc.Invoke(Handle, mAssociatedWindow.Handle, state)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetProgressValue(value As Integer, maxValue As Integer)
		  Dim sizeOfPtr As Integer
		  #if Target64Bit
		    sizeOfPtr = 8
		  #else
		    sizeOfPtr = 4
		  #endif
		  
		  // SetProgressValue is listed as the 9th function pointer in ITaskbarList3
		  Dim setProgressValueFunc As New SetProgressValue(Handle.Ptr(0).Ptr(9 * sizeOfPtr))
		  Call SetProgressValueFunc.Invoke(Handle, mAssociatedWindow.Handle, value, maxValue)
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function SetProgressValue(this As Ptr, hwnd As Integer, completed As Int64, total As Int64) As Integer
	#tag EndDelegateDeclaration


	#tag Property, Flags = &h21
		Private mAssociatedWindow As Window
	#tag EndProperty


	#tag Enum, Name = TaskBarStates, Type = Int32, Flags = &h0
		NoProgress  = 0
		  Indeterminate = 1
		  Normal = 2
		  Error = 4
		Paused = 8
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="2147483648"
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
