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
		  Try
		    VTHash.LoadConfig(App.DataFolder)
		  Catch Err
		    If Err IsA EndException Or Err IsA ThreadEndException Then Raise Err
		    Declare Function FormatMessageW Lib "Kernel32" (Flags As Integer, Source As Integer, MessageId As Integer, LanguageId As Integer, _
		    Buffer As ptr, BufferSize As Integer, Arguments As Integer) As Integer
		    Const FORMAT_MESSAGE_FROM_SYSTEM = &h1000
		    Dim buffer As New MemoryBlock(2048)
		    Dim s As String = "Unable to read configuration file."
		    If err.ErrorNumber <> 0 Then
		      s = s +" System error code: " + Str(Err.ErrorNumber)
		      If FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM, 0, Err.ErrorNumber, 0 , Buffer, Buffer.Size, 0) <> 0 Then
		        s = s  + ", Message: " +  Buffer.WString(0)
		      End If
		    End If
		    Call MsgBox(s, 16, "VT Hash Check - Cannot read configuration file")
		    App.mIsQuitting = True
		    Quit(1)
		  End Try
		  
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
		  
		  If VTHash.Config.GetType("UseSSL") = PrefStore.TYPE_INVALID Then VTHash.SetConfig("UseSSL", True)
		  If Win32.KernelVersion < 6.0  And VTHash.GetConfig("Algorithm") = Win32.Crypto.CALG_SHA256 Then
		    ' XP doesn't support SHA256 or higher
		    VTHash.SetConfig("Algorithm", Win32.Crypto.CALG_SHA1)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenDocument(item As FolderItem)
		  If mIsQuitting Then Return
		  Select Case True
		  Case item = Nil, item.AbsolutePath.Trim = ""
		    Return
		  Case Not item.Exists
		    Select Case item.AbsolutePath
		    Case "--debug"
		      VTHash.CurlVerbose = True
		      
		    Case "--prefs"
		      SettingsWindow.ShowModal
		      mIsQuitting = True
		      
		    Case "--trid"
		      mTridMode = True
		      
		    Case "--insecure"
		      mInsecure = True
		      
		    Case "--view"
		      mViewOld = True
		      
		    Case "--update"
		      Dim upd As New UpdateWindow
		      Dim f As FolderItem = upd.CheckNow("www.boredomsoft.org/updates/vthash.json", VTHash.Version)
		      If f <> Nil Then
		        f.Child("vthashsetup.exe").Launch
		      End If
		      mIsQuitting = True
		      
		    Case "--about"
		      AboutWindow.ShowModal
		      mIsQuitting = True
		      
		    Else
		      Call MsgBox(item.AbsolutePath + " does not exist.", 16, "VT Hash Check - File not found")
		    End Select
		  Case item.Directory
		    Call MsgBox(item.AbsolutePath + " is a directory.", 16, "VT Hash Check - Invalid file")
		  Case item.Length > 128 * 1024 * 1024 And Not mTridMode
		    Call MsgBox(item.AbsolutePath + " is too large for VirusTotal.", 16, "VT Hash Check - Invalid file")
		  Else
		    Select Case True
		    Case mTridMode
		      If TridLib.IsAvailable Then
		        Dim s() As TridLib.FileType = item.TrIDTypes()
		        Dim tridwin As New TridResultWindow
		        tridwin.ShowResult(s, item, Nil)
		      Else
		        Call MsgBox("TrIDLib.dll could not be loaded!", 16, "VT Hash Check - Error: missing dependency")
		        mIsQuitting = True
		        Quit
		      End If
		    Case mViewOld
		      Dim bs As BinaryStream = BinaryStream.Open(item)
		      Dim data As String = bs.Read(bs.Length)
		      bs.Close
		      Dim js As New JSONItem(data)
		      Dim res As New ResultWindow
		      res.ShowResult(New VTHash.Results(js, Nil))
		      mIsQuitting = True
		      Quit()
		    Else
		      Dim w As New HashWindow
		      w.ProcessFile(item)
		    End Select
		    
		    mOpened = True
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  Select Case error
		  Case IsA JSONException
		    Call MsgBox("VirusTotal.com provided an improperly formatted response." + EndOfLine + "Please try again later.", 16, "VT Hash Check - Illegal Response Format")
		    mIsQuitting = True
		    Quit(1)
		    
		  Case IsA PlatformNotSupportedException
		    If Instr(error.Message, "libcurl") > 0 Then
		      Call MsgBox("libcurl could not be loaded! The program will now exit.", 16, "VT Hash Check - Fatal error: missing dependency")
		      mIsQuitting = True
		      Quit(2)
		    End If
		    
		  End Select
		  Return ErrorWindow.ShowException(error)
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function DataFolder() As FolderItem
		  If mDataFolder <> Nil Then Return mDataFolder
		  If DebugBuild Then
		    Dim dlg As New SelectFolderDialog
		    dlg.Title = "Select AppData"
		    dlg.InitialDirectory = SpecialFolder.Desktop
		    mDataFolder = dlg.ShowModal
		    mDataFolder = mDataFolder.Child("Boredom Software")
		  Else
		    mDataFolder = SpecialFolder.ApplicationData.Child("Boredom Software")
		  End If
		  
		  If Not mDataFolder.Exists Then
		    mDataFolder.CreateAsFolder()
		  End If
		  mDataFolder = mDataFolder.Child("VT Hash")
		  If Not mDataFolder.Exists Then
		    mDataFolder.CreateAsFolder()
		  End If
		  Return mDataFolder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Secure() As Boolean
		  Return Not mInsecure
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ViewMode() As Boolean
		  Return mViewOld
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDataFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInsecure As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		mIsQuitting As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOpened As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTridMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mViewOld As Boolean
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
