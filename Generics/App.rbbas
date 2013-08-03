#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  'Call AdjustPrivilegeToken(SE_BACKUP_NAME, SE_PRIVILEGE_ENABLED)
		  'Call AdjustPrivilegeToken(SE_RESTORE_NAME, SE_PRIVILEGE_ENABLED)
		  Dim args() As String = Tokenize(System.CommandLine)
		  args.Remove(0)
		  ParseArgs(args)
		  
		  KillApiKeyFile()
		  LoadConf()
		  'If toBeHashed = Nil Then
		  'toBeHashed = App.ExecutableFile
		  'End If
		  
		  'Dim rw As New resultWindow
		  'Dim tis As TextInputStream
		  'Dim s As String
		  'Dim f As FolderItem = GetFolderItem("F:\Projects\Git Repository\VT-Hash\sampleresult.json")
		  'toBeHashed = f
		  'tis = tis.Open(f)
		  's = tis.ReadAll
		  'tis.Close
		  '
		  'rw.showList(New JSONItem(s))
		  'Quit11
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  Window1.Timer1.Mode = Timer.ModeOff
		  Window1.Timer2.Mode = Timer.ModeOff
		  For Each w As resultWindow In ResultWindows()
		    w.Close
		  Next
		  Window1.Visible = False
		  If error IsA JSONException Then
		    Call MsgBox("VirusTotal.com provided an improperly formatted response." + EndOfLine + "Please try again later.", 16, "Illegal Response Format")
		    Quit(1)
		  Else
		    Return errorHandler.ShowException(error)
		  End If
		End Function
	#tag EndEvent


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
		      settswin.ShowModal
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
		    
		    If j.HasName("Use SSL") Then
		      System.DebugLog("VT Hash Check " + VTHash.version + ":  'Use SSL'  has been deprecated. SSL/TLS is no longer optional.")
		    End If
		    
		    If j.HasName("Search Engine") And j.HasName("Search URL") Then
		      SearchEngineName = j.Value("Search Engine").StringValue
		      SearchEngineURL = j.Value("Search URL").StringValue
		    Else
		      SearchEngineName = "Google"
		      SearchEngineURL = "https://encrypted.google.com/search?q=%PARAMETER%"
		    End If
		    
		    If j.Value("Use SHA1").BooleanValue Then
		      algorithm = ALG_SHA1
		    Else
		      algorithm = ALG_MD5
		    End If
		    
		    Dim g As FolderItem = GetFolderItem(j.Value("Default Save Directory"))
		    If g <> Nil Then autosavePath = g
		    defaultFormat = j.Value("Default Save Format")
		    autosave = j.Value("Autosave Results")
		    VTAPIKey = j.Value("API Key")
		    If j.HasName("Comment Signature") Then
		      CommentSignature = j.Value("Comment Signature")
		    End If
		  Else
		    SaveSettings()
		    LoadConf
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseArgs(Args() As String)
		  For i As Integer = 0 To UBound(Args)
		    Select Case Args(i)
		    Case "--about"
		      about.ShowModal()
		      Quit()
		      
		    Case "--ssl"
		      MsgBox("'--ssl' has been deprecated. SSL/TLS is no longer optional.")
		      
		    Case "--sha1"
		      algorithm = ALG_SHA1
		      
		    Else
		      if Left(Args(i), 6) = "--API=" Then
		        Dim s As String = NthField(Args(i), "=", 2)
		        If s.Len = 64 Then
		          VTAPIKey = s
		        Else
		          MsgBox("An invalid API key was specified on the command line.")
		        End If
		      Else
		        Dim f As FolderItem = GetFolderItem(Args(i))
		        If f <> Nil Then
		          If f.AbsolutePath <> App.ExecutableFile.AbsolutePath Then
		            toBeHashed = f
		          End If
		        End If
		      end if
		    End Select
		  Next
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
