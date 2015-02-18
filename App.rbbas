#tag Class
Protected Class App
Inherits Application
	#tag Event
		Function CancelClose() As Boolean
		  If Not mOpened And Not mIsQuitting Then
		    SettingsWindow.ShowModal
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  If VTHash.GetConfig("APIKey").StringValue.Len <> 64 Then
		    If Not mIsQuitting And MsgBox("A VirusTotal.com API key is required in order to use this application. Would you like to open the settings window and enter a key now?", 4 + 48, "No API key configured") = 6 Then
		      SettingsWindow.ShowModal
		      If VTHash.GetConfig("APIKey").StringValue.Len <> 64 Then
		        mIsQuitting = True
		        Quit(ERR_NO_APIKEY)
		      End If
		    Else
		      mIsQuitting = True
		      Quit(ERR_NO_APIKEY)
		    End If
		  End If
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenDocument(item As FolderItem)
		  If mIsQuitting Then Return
		  If item <> Nil And item.Exists And Not item.Directory Then
		    Dim w As New HashWindow
		    w.ProcessFile(item)
		  End If
		  mOpened = True
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  If error IsA JSONException Then
		    Call MsgBox("VirusTotal.com provided an improperly formatted response." + EndOfLine + "Please try again later.", 16, "Illegal Response Format")
		    Quit(1)
		  Else
		    Return ErrorWindow.ShowException(error)
		  End If
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function DataFolder() As FolderItem
		  Dim f As FolderItem
		  If DebugBuild Then
		    f = SelectFolder.Child("Boredom Software")
		  Else
		    f = SpecialFolder.ApplicationData.Child("Boredom Software")
		  End If
		  
		  If Not f.Exists Then
		    f.CreateAsFolder()
		  End If
		  f = f.Child("VT Hash")
		  If Not f.Exists Then
		    f.CreateAsFolder()
		  End If
		  Return f
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		mIsQuitting As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOpened As Boolean
	#tag EndProperty


	#tag Constant, Name = ERR_NO_APIKEY, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="mIsQuitting"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
