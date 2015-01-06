#tag Class
Protected Class ClipboardFormat
Implements Win32.Win32Object
	#tag CompatibilityFlags = TargetHasGUI
	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		 Shared Function CF_BITMAP() As Win32.GUI.ClipboardFormat
		  Return New Win32.GUI.ClipboardFormat(CF_BITMAP)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		 Shared Function CF_TEXT() As Win32.GUI.ClipboardFormat
		  Return New Win32.GUI.ClipboardFormat(CF_TEXT)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(hClipFormat As Integer)
		  mHandle = hClipFormat
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Handle() As Integer
		  // Part of the Win32Object interface.
		  Return mHandle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsAvailable() As Boolean
		  Return Win32.Libs.User32.IsClipboardFormatAvailable(Me.Handle)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastError() As Integer
		  // Part of the Win32Object interface.
		  Return mLastError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  Select Case Me.Handle
		  Case 2
		    Return "CF_BITMAP"
		  Case 8
		    Return "CF_DIB"
		  Case 17
		    Return "CF_DIBV5"
		  Case &h0082
		    Return "CF_DSPBITMAP"
		  Case &h008E
		    Return "CF_DSPENHMETAFILE"
		  Case &h0083
		    Return "CF_DSPMETAFILEPICT"
		  Case &h0081
		    Return "CF_DSPTEXT"
		  Case 14
		    Return "CF_ENHMETAFILE"
		  Case &h0300
		    Return "CF_GDIOBJFIRST"
		  Case &h03FF
		    Return "CF_GDIOBJLAST"
		  Case 15
		    Return "CF_HDROP"
		  Case 16
		    Return "CF_LOCALE"
		  Case 3
		    Return "CF_METAFILEPICT"
		  Case 7
		    Return "CF_OEMTEXT"
		  Case &h0080
		    Return "CF_OWNERDISPLAY"
		  Case 9
		    Return "CF_PALETTE"
		  Case 10
		    Return "CF_PENDATA"
		  Case &h0200
		    Return "CF_PRIVATEFIRST"
		  Case &h02FF
		    Return "CF_PRIVATELAST"
		  Case 11
		    Return "CF_RIFF"
		  Case 4
		    Return "CF_SYLK"
		  Case 1
		    Return "CF_TEXT"
		  Case 6
		    Return "CF_TIFF"
		  Case 13
		    Return "CF_UNICODETEXT"
		  Case 12
		    Return "CF_WAVE"
		  Else
		    Dim mb As MemoryBlock
		    Dim sz As Integer = Win32.Libs.User32.GetClipboardFormatName(mhandle, Nil, 0)
		    If sz > 0 Then
		      mb = New MemoryBlock(sz * 2)
		      Call Win32.Libs.User32.GetClipboardFormatName(mhandle, mb, sz)
		      Return mb.WString(0)
		    End If
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function RegisterFormat(Name As String) As Win32.GUI.ClipboardFormat
		  Static formats As Dictionary
		  If formats = Nil Then formats = New Dictionary
		  If formats.HasKey(Name) Then
		    Return New Win32.GUI.ClipboardFormat(formats.Value(Name))
		  Else
		    Dim hClipFormat As Integer = Win32.Libs.User32.RegisterClipboardFormat(Name)
		    If hClipFormat <> 0 Then
		      formats.Value(Name) = hClipFormat
		      Return New Win32.GUI.ClipboardFormat(hClipFormat)
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h21
		Private Delegate Function RenderHandler(Sender As Win32 . GUI . ClipboardFormat, RawClipboard As Ptr) As Boolean
	#tag EndDelegateDeclaration


	#tag Hook, Flags = &h0
		Event RenderClipboard(RawClipboard As Ptr) As Boolean
	#tag EndHook


	#tag Property, Flags = &h1
		Protected mHandle As Integer = INVALID_HANDLE_VALUE
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mLastError As Integer
	#tag EndProperty


	#tag Constant, Name = CF_BITMAP, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_DIB, Type = Double, Dynamic = False, Default = \"8", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_DIBV5, Type = Double, Dynamic = False, Default = \"17", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_DIF, Type = Double, Dynamic = False, Default = \"5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_ENHMETAFILE, Type = Double, Dynamic = False, Default = \"14", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_HDROP, Type = Double, Dynamic = False, Default = \"15", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_LOCALE, Type = Double, Dynamic = False, Default = \"16", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_METAFILEPICT, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_OEMTEXT, Type = Double, Dynamic = False, Default = \"7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_PALETTE, Type = Double, Dynamic = False, Default = \"9", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_PENDATA, Type = Double, Dynamic = False, Default = \"10", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_RIFF, Type = Double, Dynamic = False, Default = \"11", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_SYLK, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_TEXT, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_TIFF, Type = Double, Dynamic = False, Default = \"6", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_UNICODETEXT, Type = Double, Dynamic = False, Default = \"13", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CF_WAVE, Type = Double, Dynamic = False, Default = \"12", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
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
