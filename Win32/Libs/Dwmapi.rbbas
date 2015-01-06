#tag Module
Protected Module Dwmapi
	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function DwmEnableComposition Lib "Dwmapi" (CompositionAction As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Soft Declare Function DwmExtendFrameIntoClientArea Lib "Dwmapi" (HWND As Integer, ByRef Margin As Win32 . GUI . MARGINS) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function DwmIsCompositionEnabled Lib "Dwmapi" (ByRef IsEnabled As Boolean) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function DwmRegisterThumbnail Lib "Dwmapi" (MainWindow As Integer, ThumbWindow As Integer, ByRef ThumbID As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function DwmUnregisterThumbnail Lib "Dwmapi" (ThumbID As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Soft Declare Function DwmUpdateThumbnailProperties Lib "Dwmapi" (ThumbID As Integer, ByRef Properties As Win32 . GUI . DWM_THUMBNAIL_PROPERTIES) As Integer
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
