#tag Window
Begin Window ErrorWindow
   BackColor       =   "&cFFFFFF00"
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   171
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   300
   MaximizeButton  =   False
   MaxWidth        =   600
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   148
   MinimizeButton  =   False
   MinWidth        =   425
   Placement       =   1
   Resizeable      =   True
   Title           =   "Error"
   Visible         =   True
   Width           =   469
   Begin Label StaticText1
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   35
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   47
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   0
      Selectable      =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      Text            =   "An unhandled error has caused VT Hash to crash. \r\nTechnical details follow:"
      TextAlign       =   0
      TextColor       =   "&c00000000"
      TextFont        =   "System"
      TextSize        =   11.0
      TextUnit        =   0
      Top             =   5
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   387
   End
   Begin TextArea errorStack
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   "&cFFFFFF00"
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   85
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   13
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   "&c00000000"
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   46
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   443
   End
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Quit"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   321
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   143
      Underline       =   False
      Visible         =   True
      Width           =   135
   End
   Begin PushButton PushButton2
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Copy Error"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   13
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   143
      Underline       =   False
      Visible         =   True
      Width           =   83
   End
   Begin PushButton PushButton3
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Send Error"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   101
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   143
      Underline       =   False
      Visible         =   True
      Width           =   83
   End
   Begin Canvas Canvas1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   35
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   5
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   5
      UseFocusRing    =   True
      Visible         =   True
      Width           =   35
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Me.Top = Window(0).Top + 111
		  Me.Left = Window(0).Left + 87
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Function CleanMangledFunction(item as string) As string
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

	#tag Method, Flags = &h21
		Private Shared Function CleanStack(Err As RuntimeException) As String()
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

	#tag Method, Flags = &h21
		Private Shared Function ParseParams(input as string) As string()
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
		Function ShowException(Error As RuntimeException) As Boolean
		  'Dim t as Introspection.TypeInfo = Introspection.GetType(error)
		  Dim trace As String = StackTrace(Error)
		  errorStack.Text = trace
		  Me.ShowModal
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function StackTrace(Err As RuntimeException) As String
		  Dim OS As String = "Unknown"
		  Dim bits As String = "x32"
		  If Win32.Is64BitOS Then bits = "x64"
		  OS = "WinNT " + Str(Win32.OSVersion.MajorVersion) + "." + Str(Win32.OSVersion.MinorVersion) + "(" + Win32.OSVersion.ServicePackName + ")" + bits
		  Dim d As New Date
		  Dim stack() As String = CleanStack(Err)
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
		  m + EndOfLine + _
		  "libcURL version: " + libcURL.Version.Name + EndOfLine + _
		  EndOfLine
		  
		  Dim Error As String =_
		  "Call stack at last call to Raise:" + EndOfLine + EndOfLine + _
		  Join(stack, "     " + EndOfLine) + EndOfLine
		  
		  Dim OsBlock As String = _
		  "EXE Version: " + VTHash.VersionString + EndOfLine + "Algorithm: 0x" + Hex(VTHash.GetConfig("Algorithm")) + EndOfLine + "OS: " + OS + EndOfLine
		  
		  Return head + OsBlock + Error
		End Function
	#tag EndMethod


#tag EndWindowCode

#tag Events PushButton1
	#tag Event
		Sub Action()
		  App.mIsQuitting = True
		  Quit()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  Dim cb As New Clipboard
		  cb.Text = errorStack.Text
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton3
	#tag Event
		Sub Action()
		  'ShowURL("http://www.boredomsoft.org/contactus.bs")
		  SuggestionBox.ShowData("Exception":ReplaceLineEndings(errorStack.Text, EndOfLine.Windows))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Canvas1
	#tag Event
		Sub Paint(g As Graphics)
		  g.DrawStopIcon(0, 0)
		End Sub
	#tag EndEvent
#tag EndEvents
