#tag Module
Protected Module StackCleaner
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
