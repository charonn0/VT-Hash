#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  '#If DebugBuild Then
		  'toBeHashed = App.ExecutableFile.Parent.Parent.Child("sampleresult.json")
		  'Dim tis As TextInputStream
		  'Dim js As JSONItem
		  'Dim s As String
		  'tis = tis.Open(toBeHashed)
		  's = tis.ReadAll
		  'tis.Close
		  'js = New JSONItem(s)
		  'resultWindow.showList(js)
		  'Quit(0)
		  '#endif
		  
		  
		  Dim args() As String = Tokenize(System.CommandLine)
		  Dim path As String = System.CommandLine
		  
		  For Each arg As String In args
		    if InStr(arg, "/") > 0 Or Instr(arg, chr(34)) > 0 Or Instr(arg, "\") > 0 Then Continue
		    
		    if arg = "--ABOUT" Then
		      aboutSwitch = True
		      Exit For
		    end if
		    
		    if arg = "--SSL" Then
		      useSSL = True
		      Continue
		    end if
		    
		    If arg = "--SHA1" Then
		      algorithm = "SHA1"
		      Continue
		    End If
		    
		    if instr(arg, "--API=") > 0 And NthField(arg, "=", 2).Len = 64 Then
		      VTAPIKey = NthField(arg, "=", 2)
		    end if
		    
		  Next
		  
		  KillApiKeyFile()
		  LoadConf()
		  
		  path = Replace(path, "--SHA1", "")
		  path = Replace(path, "--ABOUT", "")
		  path = path.ReplaceAll(chr(34), "")
		  path = NthField(path, "EXE" + " ", 2)
		  path = path.Replace(VTAPIKey, "")
		  path = path.Replace("--API=", "")
		  path = path.Replace("--SSL", "")
		  path = path.Trim
		  
		  #if DebugBuild Then
		    DryRun()
		  #Else
		    if Not aboutSwitch then
		      toBeHashed = GetFolderItem(path)
		    end if
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  If error IsA JSONException Then
		    Call MsgBox("Illegal Response Format", 0, "VirusTotal.com provided an improperly formatted response." + EndOfLine + "Please try again later.")
		    Quit(1)
		  Else
		    errorHandler.Show
		    Dim t as Introspection.TypeInfo = Introspection.GetType(error)
		    Dim theStack As String = Join(error.CleanStack, EndOfLine)
		    errorHandler.errorStack.Text = t.Name + ": " + error.Message + "(" + Str(error.ErrorNumber) + ")" + EndOfLine + theStack
		    Return True
		    
		  End If
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub DryRun()
		  toBeHashed = GetFolderItem("F:\Projects\Git Repository\VT Hash\eicar.com")
		  dim makeHash As new hasher
		  Select Case algorithm
		  case "MD5"
		    theHash = makeHash.hashIt(toBeHashed, "MD5")
		  case "SHA1"
		    theHash = makeHash.hashIt(toBeHashed, "SHA1")
		  end Select
		  Dim f As FolderItem = App.ExecutableFile.Parent.Parent.Child("sampleresult.json")
		  If f.Exists Then
		    Dim s As String
		    Dim tis As TextInputStream
		    Dim js As JSONItem
		    tis = tis.Open(f)
		    s = tis.ReadAll
		    tis.Close
		    js = New JSONItem(s)
		    resultWindow.showList(js)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub KillApiKeyFile()
		  Dim f As FolderItem = SpecialFolder.ApplicationData.Child("Boredom Software")
		  If Not f.Exists Then Return
		  
		  Dim keyfile As FolderItem = SpecialFolder.ApplicationData.Child("Boredom Software").Child("VT Hash").Child("api.key")
		  If keyfile = Nil Then Return
		  if keyfile.isFound = ERROR_NO_ERROR Then
		    Dim tis As TextInputStream
		    tis = tis.Open(keyfile)
		    VTAPIKey = tis.ReadAll.Trim
		    tis.Close
		    keyfile.Delete
		    if VTAPIKey.Len <> 64 Then
		      MsgBox("Bad Virus Total API Key!")
		      settswin.ShowMe
		    end if
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadConf()
		  Dim f As FolderItem = SpecialFolder.ApplicationData.Child("Boredom Software")
		  If Not f.Exists Then
		    f.CreateAsFolder()
		  End If
		  f = f.Child("VT Hash")
		  If Not f.Exists Then
		    f.CreateAsFolder()
		  End If
		  f = f.Child("config.dat")
		  
		  If f.Exists Then
		    Dim tis As TextInputStream
		    Dim s As String
		    Dim j As JSONItem
		    tis = tis.Open(f)
		    s = tis.ReadAll
		    tis.Close
		    j = New JSONItem(s)
		    
		    useSSL = j.Value("Use SSL")
		    If j.Value("Use SHA1").BooleanValue Then
		      algorithm = "SHA1"
		    Else
		      algorithm = "MD5"
		    End If
		    
		    Dim g As FolderItem = GetFolderItem(j.Value("Default Save Directory"))
		    If g <> Nil Then autosavePath = g
		    defaultFormat = j.Value("Default Save Format")
		    autosave = j.Value("Autosave Results")
		    VTAPIKey = j.Value("API Key")
		  Else
		    SaveSettings()
		    LoadConf
		  End If
		End Sub
	#tag EndMethod


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
	#tag EndViewBehavior
End Class
#tag EndClass
