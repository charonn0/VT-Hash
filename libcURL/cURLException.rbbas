#tag Class
Protected Class cURLException
Inherits RuntimeException
	#tag Method, Flags = &h1000
		Sub Constructor(ErrantItem As libcURL.cURLHandle)
		  Me.ErrorNumber = ErrantItem.LastError
		  Select Case True
		  Case Not libcURL.IsAvailable
		    Me.Message = "libcURL is not available or is an unsupported version."
		    
		  Case Me.ErrorNumber = libcURL.Errors.INIT_FAILED
		    Me.Message = "Unknown failure while constructing a libcURL handle."
		    
		  Case Me.ErrorNumber = libcURL.Errors.FEATURE_UNAVAILABLE
		    Me.Message = "This feature is not available in the installed version of libcURL."
		    
		  Case ErrantItem IsA libcURL.ShareHandle
		    Me.Message = libcURL.FormatShareError(Me.ErrorNumber)
		    
		  Case ErrantItem IsA libcURL.MultiHandle
		    Me.Message = libcURL.FormatMultiError(Me.ErrorNumber)
		    
		  Else
		    Me.Message = libcURL.FormatError(Me.ErrorNumber) + "(" + libcURL.Errors.Name(Me.ErrorNumber) + ")"
		    
		  End Select
		  If ErrantItem IsA libcURL.EasyHandle Then
		    Dim easy As libcURL.EasyHandle = libcURL.EasyHandle(ErrantItem)
		    If easy.ErrorBuffer <> "" Then
		      Me.Message = Me.Message + EndOfLine + "Additional info: " + easy.ErrorBuffer
		    End If
		  End If
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="ErrorNumber"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="RuntimeException"
		#tag EndViewProperty
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
			Name="Message"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="RuntimeException"
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