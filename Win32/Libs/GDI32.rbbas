#tag Module
Protected Module GDI32
	#tag ExternalMethod, Flags = &h1
		Protected Declare Function AddFontResource Lib "GDI32" Alias "AddFontResourceW" (FontFile As WString) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function AddFontResourceEx Lib "GDI32" Alias "AddFontResourceExW" (FontFile As WString, Flags As Integer, Reserved As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function BitBlt Lib "GDI32" (DCdest As Integer, xDest As Integer, yDest As Integer, nWidth As Integer, nHeight As Integer, DCdource As Integer, xSource As Integer, ySource As Integer, rasterOp As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CombineRgn Lib "GDI32" (rgnDest As Integer, rgnSrc1 As Integer, rgnSrc2 As Integer, combineMode As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateBitmap Lib "GDI32" (Width As Integer, Height As Integer, Planes As UInt32, BitsPerPel As UInt32, Buffer As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateCompatibleBitmap Lib "GDI32" (hDC As Integer, Width As Integer, Height As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateCompatibleDC Lib "GDI32" (hDC As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateRectRgn Lib "GDI32" (Left As Integer, Top As Integer, Right As Integer, Bottom As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function DeleteObject Lib "GDI32" (hObject As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetBitmapDimensionEx Lib "GDI32" (hBitmap As Integer, Dimensions As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetObject Lib "GDI32" Alias "GetObjectW" (hObject As Integer, BuffSz As Integer, Buffer As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function RemoveFontResourceEx Lib "GDI32" Alias "RemoveFontResourceExW" (FontFile As WString, Flags As Integer, Reserved As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SelectObject Lib "GDI32" (hDC As Integer, hObject As Integer) As Integer
	#tag EndExternalMethod


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
End Module
#tag EndModule
