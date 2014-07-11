#tag Module
Protected Module VTHash
	#tag Method, Flags = &h0
		Function AddComment(ResourceID As String, APIKey As String, Comment As String) As JSONItem
		  Dim frm As New MultipartForm
		  frm.Element("apikey") = APIKey
		  frm.Element("resource") = ResourceID
		  frm.Element("comment") = Comment
		  Return SendRequest(RequestType.Comment, frm)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AdjustPrivilegeToken(PrivilegeName As String, mode As Integer) As Integer
		  //Modifies the calling process' security token
		  //See the SE_* Constants in Win32Constants for privilege names.
		  //Returns 0 on success, or a Win32 error number on failure.
		  Dim error As Integer
		  #If TargetWin32 Then
		    Dim thisProc As Integer = GetCurrentProcess()
		    Dim tHandle As Integer
		    If OpenProcessToken(thisProc, TOKEN_ADJUST_PRIVILEGES Or TOKEN_QUERY, tHandle) Then
		      Dim luid As New MemoryBlock(8)
		      If LookupPrivilegeValue(Nil, PrivilegeName, luid) Then
		        Dim newState As New MemoryBlock(16)
		        newState.UInt32Value(0) = 1
		        newState.UInt32Value(4) = luid.UInt32Value(0)
		        newState.UInt32Value(8) = luid.UInt32Value(4)
		        newState.UInt32Value(12) = mode  //mode can be enable, disable, or remove. See: EnablePrivilege, DisablePrivilege, and DropPrivilege.
		        Dim retLen As Integer
		        Dim prevPrivs As Ptr
		        If AdjustTokenPrivileges(tHandle, False, newState, newState.Size, prevPrivs, retLen) Then
		          error = 0
		        Else
		          error = GetLastError()
		        End If
		      Else
		        error = GetLastError()
		      End If
		    Else
		      error = GetLastError()
		    End If
		  #endif
		  
		  Return error
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function AdjustTokenPrivileges Lib "AdvApi32" (tHandle As Integer, disableAllPrivs As Boolean, newState As Ptr, buffLength As Integer, prevPrivs As Ptr, ByRef retLen As Integer) As Boolean
	#tag EndExternalMethod

	#tag Method, Flags = &h0
		Function CleanedStack(Err As RuntimeException) As String()
		  'This method was written by SirG3 <TheSirG3@gmail.com>; http://fireyesoftware.com/developer/stackcleaner/
		  Dim result() As String
		  
		  #If rbVersion >= 2005.5
		    For Each s As String In Err.stack
		      Dim tmp As String = cleanMangledFunction( s )
		      
		      If tmp <> "" Then _
		      result.append( tmp )
		    Next
		    
		  #Else
		    // leave result empty
		    
		  #EndIf
		  
		  // we must return some sort of array (even if empty), otherwise REALbasic will return a "nil" array, causing a crash when trying to use the array.
		  // see http://realsoftware.com/feedback/viewreport.php?reportid=urvbevct
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CleanMangledFunction(item as string) As string
		  #if rbVersion >= 2005.5
		    
		    dim blacklist() as string = array( _
		    "REALbasic._RuntimeRegisterAppObject%%o<Application>", _
		    "_NewAppInstance", _'
		    "_Main", _
		    "% main", _
		    "REALbasic._RuntimeRun" _
		    )
		    
		    if blacklist.indexOf( item ) >= 0 then _
		    exit function
		    
		    dim parts() as string = item.split( "%" )
		    if ubound( parts ) < 2 then _
		    exit function
		    
		    dim func as string = parts( 0 )
		    dim returnType as string
		    if parts( 1 ) <> "" then _
		    returnType = parseParams( parts( 1 ) ).pop()
		    dim args() as string = parseParams( parts( 2 ) )
		    
		    if func.inStr( "$" ) > 0 then
		      args( 0 ) = "extends " + args( 0 )
		      func = func.replaceAll( "$", "" )
		      
		    elseif ubound( args ) >= 0 and func.nthField( ".", 1 ) = args( 0 ) then
		      args.remove( 0 )
		      
		    end if
		    
		    if func.inStr( "=" ) > 0 then
		      dim index as integer = ubound( args )
		      
		      args( index ) = "assigns " + args( index )
		      func = func.replaceAll( "=", "" )
		    end if
		    
		    if func.inStr( "*" ) > 0 then
		      dim index as integer = ubound( args )
		      
		      args( index ) = "paramarray " + args( index )
		      func = func.replaceAll( "*", "" )
		    end if
		    
		    dim sig as string
		    if func.instr( "#" ) > 0 then
		      sig = "Event"
		      func = func.replaceAll( "#", "" )
		      
		    elseif returnType = "" then
		      sig = "Sub"
		      
		    else
		      sig = "Function"
		      
		    end if
		    
		    if ubound( args ) >= 0 then
		      sig = sig + " " + func + "( " + join( args, ", " ) + " )"
		      
		    else
		      sig = sig + " " + func + "()"
		      
		    end if
		    
		    
		    if returnType <> "" then
		      sig = sig + " as " + returnType
		    end if
		    
		    return sig
		    
		  #else
		    return ""
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CleanStack(extends error as RuntimeException) As string()
		  dim result() as string
		  
		  #if rbVersion >= 2005.5
		    for each s as string in error.stack
		      dim tmp as string = cleanMangledFunction( s )
		      
		      if tmp <> "" then _
		      result.append( tmp )
		    next
		    
		  #else
		    // leave result empty
		    
		  #endif
		  
		  // we must return some sort of array (even if empty), otherwise REALbasic will return a "nil" array, causing a crash when trying to use the array.
		  // see http://realsoftware.com/feedback/viewreport.php?reportid=urvbevct
		  
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CleanStack(error as RuntimeException) As string()
		  'This method was written by SirG3 <TheSirG3@gmail.com>; http://fireyesoftware.com/developer/stackcleaner/
		  Dim result() As String
		  
		  #If rbVersion >= 2005.5
		    For Each s As String In error.stack
		      Dim tmp As String = cleanMangledFunction( s )
		      
		      If tmp <> "" Then _
		      result.append( tmp )
		    Next
		    
		  #Else
		    // leave result empty
		    
		  #EndIf
		  
		  // we must return some sort of array (even if empty), otherwise REALbasic will return a "nil" array, causing a crash when trying to use the array.
		  // see http://realsoftware.com/feedback/viewreport.php?reportid=urvbevct
		  
		  Return result
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function CloseHandle Lib "Kernel32" (handle As Integer) As Boolean
	#tag EndExternalMethod

	#tag Method, Flags = &h21
		Private Sub ConnectedHandler(Sender As VTSession)
		  'Break
		End Sub
	#tag EndMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function CreateFile Lib "Kernel32" Alias "CreateFileW" (name As WString, access As Integer, sharemode As Integer, SecAtrribs As Integer, CreateDisp As Integer, flags As Integer, template As Integer) As Integer
	#tag EndExternalMethod

	#tag Method, Flags = &h0
		Function CRLF() As String
		  Return EndOfLine.Windows
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function CryptAcquireContext Lib "AdvApi32" Alias "CryptAcquireContextW" (ByRef provider as Integer, container as Integer, providerName as WString, providerType as Integer, flags as Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function CryptCreateHash Lib "AdvApi32" (provider as Integer, algorithm as Integer, key as Integer, flags as Integer, ByRef hashHandle as Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Sub CryptDestroyHash Lib "AdvApi32" (HashHandle As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function CryptGetHashParam Lib "AdvApi32" (hashHandle as Integer, type as Integer, value as Ptr, ByRef length as Integer, flags as Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function CryptHashData Lib "AdvApi32" (hashHandle as Integer, data as Ptr, length as Integer, flags as Integer) As Boolean
	#tag EndExternalMethod

	#tag Method, Flags = &h0
		Function DeleteOnReboot(Extends source As FolderItem) As Boolean
		  //Schedules the source file to be deleted on the next system reboot
		  //This function will fail if the user does not have write access to the
		  //HKEY_LOCAL_MACHINE registry hive (HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\PendingFileRenameOperations)
		  //Or if the user does not have write access to the Target file.
		  
		  #If TargetWin32
		    Return MoveFileEx(source.AbsolutePath, Nil, MOVEFILE_DELAY_UNTIL_REBOOT)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ErrorHandler(Sender As VTSession, code As Integer)
		  Break
		End Sub
	#tag EndMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function FindExecutable Lib "Shell32" (file As WString, directory As WString, result As Ptr) As Integer
	#tag EndExternalMethod

	#tag Method, Flags = &h0
		Function FormatBytes(bytes As UInt64, precision As Integer = 2) As String
		  //Converts raw byte counts into SI formatted strings. 1KB = 1024 bytes.
		  //Optionally pass an integer representing the number of decimal places to return. The default is two decimal places. You may specify
		  //between 0 and 16 decimal places. Specifying more than 16 will append extra zeros to make up the length. Passing 0
		  //shows no decimal places and no decimal point.
		  
		  Const kilo = 1024
		  Static mega As UInt64 = kilo * kilo
		  Static giga As UInt64 = kilo * mega
		  Static tera As UInt64 = kilo * giga
		  Static peta As UInt64 = kilo * tera
		  Static exab As UInt64 = kilo * peta
		  
		  Dim suffix, precisionZeros As String
		  Dim strBytes As Double
		  
		  
		  If bytes < kilo Then
		    strbytes = bytes
		    suffix = "bytes"
		  ElseIf bytes >= kilo And bytes < mega Then
		    strbytes = bytes / kilo
		    suffix = "KB"
		  ElseIf bytes >= mega And bytes < giga Then
		    strbytes = bytes / mega
		    suffix = "MB"
		  ElseIf bytes >= giga And bytes < tera Then
		    strbytes = bytes / giga
		    suffix = "GB"
		  ElseIf bytes >= tera And bytes < peta Then
		    strbytes = bytes / tera
		    suffix = "TB"
		  ElseIf bytes >= tera And bytes < exab Then
		    strbytes = bytes / peta
		    suffix = "PB"
		  ElseIf bytes >= exab Then
		    strbytes = bytes / exab
		    suffix = "EB"
		  End If
		  
		  
		  While precisionZeros.Len < precision
		    precisionZeros = precisionZeros + "0"
		  Wend
		  If precisionZeros.Trim <> "" Then precisionZeros = "." + precisionZeros
		  
		  Return Format(strBytes, "#,###0" + precisionZeros) + " " + suffix
		  
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function GetCurrentProcess Lib "Kernel32" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function GetLastError Lib "Kernel32" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Soft Declare Sub GetNativeSystemInfo Lib "Kernel32" (ByRef info As SYSTEM_INFO)
	#tag EndExternalMethod

	#tag Method, Flags = &h0
		Function GetReport(ResourceID As String, APIKey As String, Type As RequestType) As JSONItem
		  Dim frm As New MultipartForm
		  frm.Element("apikey") = APIKey
		  
		  Select Case Type
		  Case RequestType.FileReport
		    frm.Element("resource") = ResourceID
		  Case VTHash.RequestType.URLReport
		    frm.Element("url") = ResourceID
		  Case RequestType.IPReport
		    frm.Element("ip") = ResourceID
		  Case RequestType.DomainReport
		    frm.Element("domain") = ResourceID
		  End Select
		  Return SendRequest(Type, frm)
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h0
		Soft Declare Function GetVersionEx Lib "Kernel32" Alias "GetVersionExA" (ByRef info As OSVERSIONINFOEX) As Boolean
	#tag EndExternalMethod

	#tag Method, Flags = &h0
		Function Hash(data As String, algorithm As Integer) As String
		  //Hashes the data string using the specified hash algorithm (see the constants for this Module for available algorithms.)
		  //Returns a hex-formatted string of the binary hash
		  
		  Dim hashHandle As Integer
		  Dim hashPtr As MemoryBlock
		  'Select Case algorithm
		  'Case CALG_SHA256
		  'hashPtr = HashData(RSAProvider, data, hashHandle, algorithm)
		  'Else
		  hashPtr = HashData(baseCryptoProvider, data, hashHandle, algorithm)
		  'End Select
		  If hashPtr = Nil Then Return ""
		  Dim ret As String = StringToHex(hashPtr.StringValue(0, hashPtr.Size))
		  CryptDestroyHash(hashHandle)
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HashData(provider as Integer, data as String, ByRef handle as Integer, algorithm As Integer) As MemoryBlock
		  Dim hashHandle as Integer
		  Dim xxx As UInt64
		  If Not CryptCreateHash(provider, algorithm, 0, 0, hashHandle) Then
		    xxx = GetLastError
		    Break
		    Return Nil
		  End If
		  Dim dataPtr As New MemoryBlock(Len(data))
		  dataPtr = data
		  If Not CryptHashData(hashHandle, dataPtr, dataPtr.Size, 0) Then
		    xxx = GetLastError
		    Break
		    Return Nil
		  End If
		  Dim size as Integer = 4
		  Dim toss As New MemoryBlock(4)
		  If Not CryptGetHashParam(hashHandle, HP_HASHSIZE, toss, size, 0) Then
		    xxx = GetLastError
		    Break
		    Return Nil
		  End If
		  size = toss.UInt32Value(0)
		  Dim hashValue As New MemoryBlock(size)
		  If Not CryptGetHashParam(hashHandle, HP_HASHVAL, hashValue, size, 0) Then
		    xxx = GetLastError
		    Break
		    Return Nil
		  End If
		  handle = hashHandle
		  
		  Return hashValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HeadersReceivedHandler(Sender As VTSession, headers As InternetHeaders, code As Integer)
		  'Break
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isFound(Extends f As FolderItem) As Integer
		  Const FILE_FLAG_BACKUP_SEMANTICS = &h02000000
		  Dim HWND As Integer = CreateFile(f.AbsolutePath, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, 0)
		  If HWND = -1 Then
		    HWND = GetLastError()
		    Select Case HWND
		    Case 5
		      Return ACCESS_DENIED
		    Case 2
		      Return FILE_NOT_FOUND
		    Else
		      Return ERROR_OTHER
		    End Select
		    
		  Else
		    Call CloseHandle(HWND)
		    Return ERROR_NO_ERROR
		  End If
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function LookupPrivilegeValue Lib "AdvApi32" Alias "LookupPrivilegeValueW" (sysName As WString, privName As WString, Luid As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function MoveFileEx Lib "Kernel32" Alias "MoveFileExW" (sourceFile As WString, destinationFile As WString, flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h0
		Declare Function OpenProcessToken Lib "AdvApi32" (handle As Integer, access As Integer, ByRef tHandle As Integer) As Boolean
	#tag EndExternalMethod

	#tag Method, Flags = &h21
		Private Function ParseParams(input as string) As string()
		  dim chars() as string = input.split( "" )
		  dim funcTypes() as string
		  dim arrays() as integer
		  dim arrayDims() as integer
		  dim byrefs() as integer
		  dim mode as integer
		  dim buffer as string
		  
		  const kParamMode = 0
		  const kObjectMode = 1
		  const kIntMode = 2
		  const kUIntMode = 3
		  const kFloatingMode = 4
		  const kArrayMode = 5
		  
		  for each char as string in chars
		    select case mode
		    case kParamMode
		      select case char
		      Case "v"
		        funcTypes.append( "Variant" )
		      case "i"
		        mode = kIntMode
		        
		      case "u"
		        mode = kUIntMode
		        
		      case "o"
		        mode = kObjectMode
		        
		      case "b"
		        funcTypes.append( "boolean" )
		        
		      case "s"
		        funcTypes.append( "string" )
		        
		      case "f"
		        mode = kFloatingMode
		        
		      case "c"
		        funcTypes.append( "color" )
		        
		      case "A"
		        mode = kArrayMode
		        
		      case "&"
		        byrefs.append( ubound( funcTypes ) + 1 )
		        
		      end select
		      
		      
		    case kObjectMode
		      if char = "<" then _
		      continue
		      
		      if char = ">" then
		        funcTypes.append( buffer )
		        buffer = ""
		        mode = kParamMode
		        
		        continue
		      end if
		      
		      buffer = buffer + char
		      
		      
		    case kIntMode, kUIntMode
		      dim intType as string = "int"
		      
		      if mode = kUIntMode then _
		      intType = "uint"
		      
		      funcTypes.append( intType + str( val( char ) * 8 ) )
		      mode = kParamMode
		      
		      
		    case kFloatingMode
		      if char = "4" then
		        funcTypes.append( "single" )
		        
		      elseif char = "8" then
		        funcTypes.append( "double" )
		        
		      end if
		      
		      mode = kParamMode
		      
		    case kArrayMode
		      arrays.append( ubound( funcTypes ) + 1 )
		      arrayDims.append( val( char ) )
		      mode = kParamMode
		      
		    end select
		  next
		  
		  for i as integer = 0 to ubound( arrays )
		    dim arr as integer = arrays( i )
		    dim s as string = funcTypes( arr ) + "("
		    
		    for i2 as integer = 2 to arrayDims( i )
		      s = s + ","
		    next
		    
		    funcTypes( arr ) = s + ")"
		  next
		  
		  for each b as integer in byrefs
		    funcTypes( b ) = "byref " + funcTypes( b )
		  next
		  
		  return funcTypes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PlatformString() As String
		  //Returns a human-readable string corresponding to the version, SKU, service pack, and architecture of
		  //the currently running version of Windows.
		  //e.g. "Windows 7 Ultimate x64 Service Pack 1"
		  
		  #If TargetWin32 Then
		    Dim info As OSVERSIONINFOEX
		    info.StructSize = Info.Size
		    
		    If GetVersionEx(info) Then
		      Return "(VT Hash Check " + VTHash.version + "; U; Win32 " + Str(info.BuildNumber) + ")"
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RegExFind(Extends source As String, pattern As String) As String()
		  //Returns a string array of all subexpressions
		  
		  Dim rg as New RegEx
		  Dim myMatch as RegExMatch
		  Dim ret() As String
		  rg.SearchPattern = pattern
		  myMatch=rg.search(source)
		  If myMatch <> Nil Then
		    For i As Integer = 0 To myMatch.SubExpressionCount - 1
		      ret.Append(myMatch.SubExpressionString(i))
		    Next
		  End If
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequestRescan(ResourceID As String, APIKey As String) As JSONItem
		  Dim frm As New MultipartForm
		  frm.Element("resource") = ResourceID
		  frm.Element("apikey") = APIKey
		  Return SendRequest(RequestType.Rescan, frm)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResponseHandler(Sender As VTSession, ResponseObject As JSONItem, HTTPStatus As Integer)
		  #pragma Unused Sender
		  If HTTPStatus = 200 And ResponseObject <> Nil Then
		    Output = ResponseObject
		  Else
		    Output = Nil
		  End If
		  Waiting = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveSettings()
		  Dim s As New JSONItem
		  s.Value("Use SHA1") = algorithm <> ALG_MD5
		  s.Value("Autosave Results") = autosave
		  s.Value("Default Save Format") = defaultFormat
		  If autosavePath <> Nil Then
		    s.Value("Default Save Directory") = autosavePath.AbsolutePath
		  Else
		    s.Value("Default Save Directory") = SpecialFolder.ApplicationData.Child("Boredom Software").Child("VT Hash").Child("scans").AbsolutePath
		  End If
		  s.Value("API Key") = VTAPIKey
		  s.Value("Search Engine") = SearchEngineName
		  s.Value("Search URL") = SearchEngineURL
		  s.Value("Comment Signature") = CommentSignature.Trim
		  s.Compact = False
		  Dim t As String = s.ToString
		  Dim tos As TextOutputStream
		  Dim f As FolderItem = SpecialFolder.ApplicationData.Child("Boredom Software")
		  If Not f.Exists Then
		    f.CreateAsFolder()
		  End If
		  f = f.Child("VT Hash")
		  If Not f.Exists Then
		    f.CreateAsFolder()
		  End If
		  f = f.Child("config.dat")
		  tos = tos.Create(f)
		  tos.Write(t)
		  tos.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScreenFromXY(X As Integer, Y As Integer) As Integer
		  Dim rect As New REALbasic.Rect
		  Dim pt As New REALbasic.Point
		  pt.X = X
		  pt.Y = Y
		  For i As Integer = 0 To ScreenCount - 1
		    rect.Top = Screen(i).Top
		    rect.Left = Screen(i).Left
		    rect.Width = Screen(i).Width
		    rect.Height = Screen(i).Height
		    If rect.Contains(pt) Then
		      Return i
		    End If
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SearchEngineSet() As Boolean
		  Return SearchEngineName.Trim <> "" And SearchEngineURL.Trim <> ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest(Type As RequestType, Form As MultipartForm) As JSONItem
		  If Sock = Nil Then
		    Sock = New VTSession
		    AddHandler Sock.Response, AddressOf ResponseHandler
		    AddHandler Sock.Connected, AddressOf ConnectedHandler
		    AddHandler Sock.HeadersReceived, AddressOf HeadersReceivedHandler
		    AddHandler Sock.Error, AddressOf VTHash.ErrorHandler
		  End If
		  Dim content As String = Form.ToString
		  Dim t As New ContentType("multipart/form-data; boundary=" + Form.Boundary)
		  Sock.SetRequestHeader("User-Agent", "RB-VTAPI/" + Format(AgentVersion, "#0.0#") + " " + VTHash.PlatformString)
		  Sock.SetPostContent(content, t.ToString)
		  
		  '#if DebugBuild Then
		  'Dim apiurl As String = System.GetNetworkInterface(0).IPAddress
		  '#else
		  Dim apiurl As String = "www.virustotal.com"
		  '#endif
		  
		  Waiting = True
		  Select Case Type
		  Case RequestType.Comment
		    Sock.SendRequest("POST", apiurl + VT_Put_Comment)
		  Case RequestType.DomainReport
		    Sock.SendRequest("POST", apiurl + VT_Get_Domain)
		  Case RequestType.FileReport
		    Sock.SendRequest("POST", apiurl + VT_Get_File)
		  Case RequestType.FileSubmit
		    Sock.SendRequest("POST", apiurl + VT_Submit_File)
		  Case RequestType.IPReport
		    Sock.SendRequest("POST", apiurl + VT_Get_IP)
		  Case RequestType.Rescan
		    Sock.SendRequest("POST", apiurl + VT_Rescan_File)
		  Case RequestType.URLReport
		    Sock.SendRequest("POST", apiurl + VT_Get_URL)
		  End Select
		  While Waiting
		    App.DoEvents
		  Wend
		  
		  Return Output
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Shorten(Extends data As String, maxLength As Integer = 45) As String
		  //Replaces characters from the middle of a string with a single ellipsis ("...") until data.Len is less than the specified length.
		  //Useful for showing long paths by omitting the middle part of the data, though not limited to this use.
		  
		  If data.Len <= maxLength then
		    Return data
		  Else
		    Dim shortdata, snip As String
		    Dim start As Integer
		    shortdata = data
		    
		    While shortdata.len > maxLength
		      start = shortdata.Len / 3
		      snip = mid(shortdata, start, 5)
		      shortdata = Replace(shortdata, snip, "...")
		    Wend
		    Return shortdata
		  End If
		  
		Exception err
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowCentered(Win As Window, ScreenNumber As Integer = 0)
		  ' Shows the passed window centered on the specified Screen.
		  
		  Dim X, Y As Integer
		  X = (0.5 * Screen(ScreenNumber).Width) - (0.5 * Win.Width)
		  Y = (0.5 * Screen(ScreenNumber).Height) - (0.5 * Win.Height)
		  win.Show
		  If Screen(ScreenNumber).Top > Screen(0).Height - 1 Then
		    Y = Y + Screen(ScreenNumber).Height
		  End If
		  If Screen(ScreenNumber).Left > Screen(0).Width - 1 Then
		    X = X + Screen(ScreenNumber).Width
		  End If
		  win.Left = X
		  win.Top = Y
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowInExplorer(extends f As FolderItem)
		  //Shows the file in Windows Explorer
		  
		  #If TargetWin32 Then
		    Dim param As String = "/select, """ + f.AbsolutePath + """"
		    Soft Declare Sub ShellExecuteW Lib "Shell32" (hwnd As Integer, op As WString, file As WString, params As WString, directory As Integer, _
		    cmd As Integer)
		    
		    Const SW_SHOW = 5
		    ShellExecuteW(0, "open", "explorer", param, 0, SW_SHOW)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StackTrace(Err As RuntimeException) As String
		  Dim info As OSVERSIONINFOEX
		  info.StructSize = Info.Size
		  Dim OS As String = "Unknown"
		  Dim bits As String = "x32"
		  If GetVersionEx(info) Then
		    If System.IsFunctionAvailable("GetNativeSystemInfo", "kernel32.dll") Then
		      Dim sysinfo As SYSTEM_INFO
		      GetNativeSystemInfo(sysinfo)
		      bits = "x64"
		    End If
		    OS = "WinNT " + Str(info.MajorVersion) + "." + Str(info.MinorVersion) + "(" + info.ServicePackName + ")" + bits
		  End If
		  Dim d As New Date
		  Dim stack() As String = CleanedStack(Err)
		  Dim m As String = "Message: "
		  If Err.Message.Trim = "" Then
		    m = m + "No additional details"
		  Else
		    m = m + Err.Message
		  End If
		  Dim head As String = _
		  "Runtime Exception:" + EndOfLine + _
		  "Date: " + d.SQLDateTime + EndOfLine + _
		  "Exception type: " + Introspection.GetType(Err).FullName + EndOfLine + _
		  "Error number: " + Str(Err.ErrorNumber) + EndOfLine + _
		  m + EndOfLine + EndOfLine
		  
		  Dim file As String = "No File Specified"
		  If toBeHashed <> Nil Then file = toBeHashed.AbsolutePath
		  Dim Error As String =_
		  "Call stack at last call to Raise:" + EndOfLine + EndOfLine + _
		  Join(stack, "     " + EndOfLine) + EndOfLine
		  
		  Dim OsBlock As String = _
		  "EXE Version: " + VTHash.version + EndOfLine + "Target path: " + file + EndOfLine + "Algorithm: " + Str(algorithm) + EndOfLine + "OS: " + OS + EndOfLine
		  
		  Return head + OsBlock + Error
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatusCodeText(StatusCode As Integer) As String
		  Select Case StatusCode
		  Case 100
		    Return "Continue"
		  Case 101
		    Return "Switching Protocols"
		  Case 102
		    Return "Processing"
		  Case 200
		    Return "OK"
		  Case 201
		    Return "Created"
		  Case 202
		    Return "Accepted"
		  Case 203
		    Return "Non-Authoritative"
		  Case 204
		    Return "No Content"
		  Case 205
		    Return "Reset Content"
		  Case 206
		    Return "Partial Content"
		  Case 207
		    Return "Multi-Status"
		  Case 208
		    Return "Already Reported"
		  Case 209
		    Return "IM Used"
		  Case 300
		    Return "Multiple Choices"
		  Case 301
		    Return "Moved Permanently"
		  Case 302
		    Return "Found"
		  Case 303
		    Return "See Other"
		  Case 304
		    Return "Not Modified"
		  Case 305
		    Return "Use Proxy"
		  Case 306
		    Return "Switch Proxy"
		  Case 307
		    Return "Temporary Redirect"
		  Case 308
		    Return "Permanent Redirect"
		  Case 400
		    Return "Bad Request"
		  Case 401
		    Return "Unauthorized"
		  Case 402
		    Return "Payment Required"
		  Case 403
		    Return "Forbidden"
		  Case 404
		    Return "Not Found"
		  Case 405
		    Return "Method Not Allowed"
		  Case 406
		    Return "Not Acceptable"
		  Case 407
		    Return "Proxy Authentication Required"
		  Case 408
		    Return "Request Timeout"
		  Case 409
		    Return "Conflict"
		  Case 410
		    Return "Gone"
		  Case 411
		    Return "Length Required"
		  Case 412
		    Return "Precondition Failed"
		  Case 413
		    Return "Request Entity Too Large"
		  Case 414
		    Return "Request-URI Too Long"
		  Case 415
		    Return "Unsupported Media Type"
		  Case 416
		    Return "Requested Range Not Satisfiable"
		  Case 417
		    Return "Expectation Failed"
		  Case 418
		    Return "I'm A Teapot"
		  Case 420
		    Return "Enhance Your Calm"
		  Case 422
		    Return "Unprocessable Entity"
		  Case 423
		    Return "Locked"
		  Case 424
		    Return "Failed Dependency or Method Failure"
		  Case 425
		    Return "Unordered Collection"
		  Case 426
		    Return "Upgrade Required"
		  Case 428
		    Return "Precondition Required"
		  Case 429
		    Return "Too Many Requests"
		  Case 431
		    Return "Request Header Fields Too Large"
		  Case 444
		    Return "No Response"
		  Case 449
		    Return "Retry With"
		  Case 450
		    Return "Blocked by Windows Parental Controls"
		  Case 451
		    Return "Unavailable For Legal Reasons"
		  Case 499
		    Return "Client Closed Request"
		  Case 500
		    Return "Internal Server Error"
		  Case 501
		    Return "Not Implemented"
		  Case 502
		    Return "Bad Gateway"
		  Case 503
		    Return "Service Unavailabe"
		  Case 504
		    Return "Gateway Timeout"
		  Case 505
		    Return "HTTP Version Not Supported"
		  Case 506
		    Return "Variant Also Negotiates"
		  Case 507
		    Return "Insufficient Storage"
		  Case 508
		    Return "Loop Detected"
		  Case 509
		    Return "Bandwidth Limit Exceeded"
		  Case 510
		    Return "Not Extended"
		  Case 511
		    Return "Network Authentication Required"
		  Case 598
		    Return "Network Read Timeout"
		  Case 599
		    Return "Network Connect Timeout"
		  Else
		    Return "Not HTTP"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringToHex(src as string) As string
		  //Hexify a string of binary data
		  
		  Dim hexvalue As Integer
		  Dim hexedInt As String
		  
		  For i As Integer = 1 To LenB(src)
		    hexvalue = AscB(MidB(src, i, 1))
		    hexedInt = hexedInt + RightB("00" + Hex(hexvalue), 2)
		  next
		  
		  Return LeftB(hexedInt, LenB(hexedInt))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubmitFile(File As FolderItem, APIKey As String) As JSONItem
		  Dim frm As New MultipartForm
		  frm.Element("apikey") = APIKey
		  frm.Element("file") = File
		  Return SendRequest(RequestType.FileSubmit, frm)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Timezone() As String
		  //This function returns a string representing the name of the current time zone. e.g. "EST" or "Pacific Daylight Time." This name
		  //is localized and may be up to 32 characters long.
		  //On error, returns an empty string.
		  
		  #If TargetWin32 Then
		    Declare Function GetTimeZoneInformation Lib "Kernel32" (ByRef TZInfo As TIME_ZONE_INFORMATION) As Integer
		    
		    Const daylightSavingsOn = 2
		    Const daylightSavingsOff = 1
		    Const daylightSavingsUnknown = 0
		    Const invalidTimeZone = &hFFFFFFFF
		    
		    Dim TZInfo As TIME_ZONE_INFORMATION
		    Dim dlsStatus As Integer = GetTimeZoneInformation(TZInfo)
		    
		    If dlsStatus = daylightSavingsOn Or dlsStatus = daylightSavingsOff Or dlsStatus = daylightSavingsUnknown Then
		      Return TZInfo.StandardName
		    Else
		      Return ""
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tokenize(ByVal Input As String) As String()
		  //Returns a String array containing the space-delimited members of the Input string.
		  //Like `String.Split(" ")` but honoring quotes; good for command line arguments and other parsing.
		  //For example, this string:
		  '                     MyApp.exe --foo "C:\My Dir\"
		  //Would become:
		  '                     s(0) = MyApp.exe
		  '                     s(1) = --foo
		  '                     s(2) = "C:\My Dir\"
		  
		  
		  #If TargetWin32 Then
		    Declare Function PathGetArgsW Lib "Shlwapi" (path As WString) As WString
		    Dim ret() As String
		    Dim cmdLine As String = Input
		    While cmdLine.Len > 0
		      Dim tmp As String
		      Dim args As String = PathGetArgsW(cmdLine)
		      If Len(args) = 0 Then
		        tmp = ReplaceAll(cmdLine.Trim, Chr(34), "")
		        ret.Append(tmp)
		        Exit While
		      Else
		        tmp = Left(cmdLine, cmdLine.Len - args.Len).Trim
		        tmp = ReplaceAll(tmp, Chr(34), "")
		        ret.Append(tmp)
		        cmdLine = args
		      End If
		    Wend
		    Return ret
		  #endif
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Trid(f As FolderItem) As Dictionary
		  If f.Directory Then Return New Dictionary("That is a directory":100)
		  Dim g As FolderItem = SpecialFolder.Temporary.Child("trid.exe")
		  Dim d As FolderItem = SpecialFolder.Temporary.Child("triddefs.trd")
		  Dim tos As TextOutputStream
		  tos = tos.Create(g)
		  tos.Write(trid1)
		  tos.Close
		  tos = tos.Create(d)
		  tos.Write(triddefs)
		  tos.Close
		  
		  Dim sh As New Shell
		  Dim ret As Dictionary
		  sh.Execute("""" + g.AbsolutePath + """" + " """ + f.AbsolutePath + """")
		  Dim search() As String = sh.Result.Split(EndOfLine)
		  Dim pattern As String = "([+-]?\d*\.\d+)(?![-+0-9\.])(%)(\s+)(.*)\((\d*)"
		  For i As Integer = 0 To UBound(search)
		    Dim res() As String = search(i).RegExFind(pattern)
		    If UBound(res) > -1 Then
		      If ret = Nil Then ret = New Dictionary
		      ret.Value(res(4)) = Val(res(1))
		    End If
		  Next
		  
		  Return ret
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  //Returns 0 on error, positive integer on success
			  //For use with certain algorithms
			  
			  Static provider As Integer
			  
			  If provider = 0 Then
			    If Not CryptAcquireContext(provider, 0, MS_DEF_PROV + Chr(0), PROV_RSA_FULL, 0) Then
			      If Not CryptAcquireContext(provider, 0, MS_DEF_PROV + Chr(0), PROV_RSA_FULL, CRYPT_NEWKEYSET) Then
			        Return 0
			      End If
			    End If
			  end if
			  
			  Return provider
			End Get
		#tag EndGetter
		Private AESProvider As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		algorithm As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		autosave As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mautosavePath = Nil Then
			    mautosavePath = SpecialFolder.ApplicationData.Child("Boredom Software").Child("VT Hash").Child("scans")
			    If Not mautosavePath.Exists Then mautosavePath.CreateAsFolder
			  End If
			  return mautosavePath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mautosavePath = value
			End Set
		#tag EndSetter
		autosavePath As FolderItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  //Returns 0 on error, positive integer on success
			  
			  Static provider As Integer
			  Dim lasterr As Integer
			  Dim s As String
			  If provider = 0 Then
			    If Not CryptAcquireContext(provider, 0, MS_DEF_PROV, PROV_RSA_FULL, 0) Then
			      lasterr = GetLastError
			      s = Hex(lasterr)
			      Break
			      If Not CryptAcquireContext(provider, 0, MS_DEF_PROV, PROV_RSA_FULL, CRYPT_NEWKEYSET) Then
			        lasterr = GetLastError
			        s = Hex(lasterr)
			        Break
			        Return 0
			      End If
			    End If
			  end if
			  
			  Return provider
			End Get
		#tag EndGetter
		Private baseCryptoProvider As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		cancel As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		CommentSignature As String
	#tag EndProperty

	#tag Property, Flags = &h0
		defaultFormat As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		errorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h0
		fileData As String
	#tag EndProperty

	#tag Property, Flags = &h0
		LastResponseCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LastResponseVerbose As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mautosavePath As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mversion As Double = 1.47
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Output As JSONItem
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #If TargetWin32 Then
			    Dim info As OSVERSIONINFOEX
			    info.StructSize = Info.Size
			    
			    Call GetVersionEx(info)
			    If info.MajorVersion >= 6 Then
			      Return &h1000  //PROCESS_QUERY_LIMITED_INFORMATION
			    Else
			      Return PROCESS_QUERY_INFORMATION  //On old Windows, use the old API
			    End If
			  #endif
			End Get
		#tag EndGetter
		PROCESS_QUERY_LIMITED_INFORMATION As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ResultWindows() As resultWindow
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  //Returns 0 on error, positive integer on success
			  //For use with certain algorithms
			  
			  Static provider As Integer
			  
			  If provider = 0 Then
			    If Not CryptAcquireContext(provider, 0, MS_DEF_PROV + Chr(0), PROV_RSA_FULL, 0) Then
			      If Not CryptAcquireContext(provider, 0, MS_DEF_PROV + Chr(0), PROV_RSA_FULL, CRYPT_NEWKEYSET) Then
			        Return 0
			      End If
			    End If
			  end if
			  
			  Return provider
			End Get
		#tag EndGetter
		Private RSAProvider As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		SearchEngineName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SearchEngineURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Sock As VTSession
	#tag EndProperty

	#tag Property, Flags = &h0
		toBeHashed As FolderItem
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Format(mversion, "0.0#")
			End Get
		#tag EndGetter
		version As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		VTAPIKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Waiting As Boolean
	#tag EndProperty


	#tag Constant, Name = ACCESS_DENIED, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = AgentVersion, Type = Double, Dynamic = False, Default = \"2.0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ALG_MD5, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ALG_SHA1, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CALG_MD5, Type = Double, Dynamic = False, Default = \"&h00008003", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA1, Type = Double, Dynamic = False, Default = \"&h00008004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA256, Type = Double, Dynamic = False, Default = \"&h0000800c", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA384, Type = Double, Dynamic = False, Default = \"&h0000800d", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CALG_SHA512, Type = Double, Dynamic = False, Default = \"&h0000800e", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CRYPT_NEWKEYSET, Type = Double, Dynamic = False, Default = \"&h00000008\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ERROR_NO_ERROR, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ERROR_OTHER, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NOT_FOUND, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_READ_ACCESS, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_SHARE_READ, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = GENERIC_READ, Type = Double, Dynamic = False, Default = \"&h80000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HP_HASHSIZE, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HP_HASHVAL, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kHashTypeHMAC, Type = Double, Dynamic = False, Default = \"32777", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Mode_CSV, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Mode_Org_JSON, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Mode_Text, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = Mode_Unp_JSON, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MOVEFILE_DELAY_UNTIL_REBOOT, Type = Double, Dynamic = False, Default = \"&h4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MS_DEF_PROV, Type = String, Dynamic = False, Default = \"Microsoft Base Cryptographic Provider v1.0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OPEN_EXISTING, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PROCESS_QUERY_INFORMATION, Type = Double, Dynamic = False, Default = \"&h400", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PROV_RSA_FULL, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RESOURCE_FOUND, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOURCE_INVALID, Type = Double, Dynamic = False, Default = \"-1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOURCE_NOT_FOUND, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOURCE_PENDING, Type = Double, Dynamic = False, Default = \"-2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESPONSE_INVALID, Type = Double, Dynamic = False, Default = \"255", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SE_BACKUP_NAME, Type = String, Dynamic = False, Default = \"SeBackupPrivilege", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SE_PRIVILEGE_ENABLED, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SE_RESTORE_NAME, Type = String, Dynamic = False, Default = \"SeRestorePrivilege", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TOKEN_ADJUST_PRIVILEGES, Type = Double, Dynamic = False, Default = \"&h00000020", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TOKEN_QUERY, Type = Double, Dynamic = False, Default = \"&h00000008", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Code_Not_Found, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Code_OK, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Code_Still_Proccessing, Type = Double, Dynamic = False, Default = \"-2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Get_Domain, Type = String, Dynamic = False, Default = \"/vtapi/v2/domain/report", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Get_File, Type = String, Dynamic = False, Default = \"/vtapi/v2/file/report", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Get_IP, Type = String, Dynamic = False, Default = \"/vtapi/v2/ip-address/report", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Get_URL, Type = String, Dynamic = False, Default = \"/vtapi/v2/url/scan", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Put_Comment, Type = String, Dynamic = False, Default = \"/vtapi/v2/comments/put", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Rescan_File, Type = String, Dynamic = False, Default = \"/vtapi/v2/file/rescan", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VT_Submit_File, Type = String, Dynamic = False, Default = \"/vtapi/v2/file/scan", Scope = Public
	#tag EndConstant


	#tag Structure, Name = OSVERSIONINFOEX, Flags = &h0
		StructSize As UInt32
		  MajorVersion As Integer
		  MinorVersion As Integer
		  BuildNumber As Integer
		  PlatformID As Integer
		  ServicePackName As String*128
		  ServicePackMajor As UInt16
		  ServicePackMinor As UInt16
		  SuiteMask As UInt16
		  ProductType As Byte
		Reserved As Byte
	#tag EndStructure

	#tag Structure, Name = SYSTEMTIME, Flags = &h0
		Year As UInt16
		  Month As UInt16
		  DOW As UInt16
		  Day As UInt16
		  Hour As UInt16
		  Minute As UInt16
		  Second As UInt16
		MS As UInt16
	#tag EndStructure

	#tag Structure, Name = SYSTEM_INFO, Flags = &h0
		OEMID As Integer
		  pageSize As Integer
		  minApplicationAddress As Ptr
		  maxApplicationAddress As Ptr
		  activeProcessorMask As Integer
		  numberOfProcessors As Integer
		  processorType As Integer
		  allocationGranularity As Integer
		  processorLevel As Int16
		processorRevision As Int16
	#tag EndStructure

	#tag Structure, Name = TIME_ZONE_INFORMATION, Flags = &h0
		Bias As Integer
		  StandardName As Wstring*32
		  StandardDate As SYSTEMTIME
		  StandardBias As Integer
		  DaylightName As WString*32
		  DaylightDate As SYSTEMTIME
		DaylightBias As Integer
	#tag EndStructure


	#tag Enum, Name = RequestType, Flags = &h1
		FileReport
		  URLReport
		  DomainReport
		  IPReport
		  FileSubmit
		  Comment
		Rescan
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="algorithm"
			Group="Behavior"
			InitialValue="""""MD5"""""
			Type="Integer"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="autosave"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="cancel"
			Group="Behavior"
			InitialValue="false"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CommentSignature"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultFormat"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="errorMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="fileData"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastResponseCode"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastResponseVerbose"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PROCESS_QUERY_LIMITED_INFORMATION"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SearchEngineName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SearchEngineURL"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="version"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="VTAPIKey"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
