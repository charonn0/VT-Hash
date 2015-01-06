#tag Module
Protected Module Win32
	#tag Method, Flags = &h1
		Protected Function CurrentProcessID() As Integer
		  #If TargetWin32 Then
		    Return Win32.Libs.Kernel32.GetCurrentProcess()
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CurrentThreadID() As Integer
		  #If TargetWin32 Then
		    Return Win32.Libs.Kernel32.GetCurrentThreadId()
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FormatError(WinErrorNumber As Integer) As String
		  //Returns the error message corresponding to a given windows error number.
		  
		  #If TargetWin32 Then
		    Dim buffer As New MemoryBlock(2048)
		    If Win32.Libs.Kernel32.FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, WinErrorNumber, 0 , Buffer, Buffer.Size, 0) <> 0 Then
		      Return Buffer.WString(0)
		    Else
		      Return "Unknown error number: " + Str(WinErrorNumber)
		    End If
		  #Else
		    Return "Not a Windows system. Error number: " + Str(WinErrorNumber)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetSystemInfo() As SYSTEM_INFO
		  Dim info As SYSTEM_INFO
		  Win32.Libs.Kernel32.GetSystemInfo(info)
		  Return info
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HighBits(Extends BigInt As Int64) As Integer
		  'Gets the high-order bits of the passed Int64
		  Return ShiftRight(BigInt, 32)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HighBits(Extends ByRef BigInt As Int64, Assigns HighOrder As Integer)
		  'Sets the high-order bits of the passed Int64
		  BigInt = BitOr(ShiftLeft(HighOrder, 32), BigInt.LowBits)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Is64BitOS() As Boolean
		  Return System.IsFunctionAvailable("GetNativeSystemInfo", "Kernel32")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function KernelVersion() As Double
		  //Returns the Kernel version of Windows as a Double (MajorVersion.MinorVersion)
		  //For example, Windows 2000 returns 5.0, XP Returns 5.1, Vista Returns 6.0 and Windows 7 returns 6.1
		  //On error, returns 0.0
		  
		  #If TargetWin32 Then
		    Return Win32.OSVersion.MajorVersion + (Win32.OSVersion.MinorVersion / 10)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LastError() As Integer
		  Return Win32.Libs.Kernel32.GetLastError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub LastError(Assigns NewErrorNumber As Integer)
		  Win32.Libs.Kernel32.SetLastError(NewErrorNumber)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LowBits(Extends BigInt As Int64) As Integer
		  'Gets the low-order bits of the passed Int64
		  Return BitAnd(BigInt, &hFFFFFFFF)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LowBits(Extends ByRef BigInt As Int64, Assigns LowOrder As Integer)
		  'Sets the low-order bits of the passed Int64
		  BigInt = BitOr(ShiftLeft(BigInt.HighBits, 32), LowOrder)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function OSVersion() As OSVERSIONINFOEX
		  Dim info As OSVERSIONINFOEX
		  info.StructSize = Info.Size
		  #If TargetWin32 Then
		    If Win32.Libs.Kernel32.GetVersionEx(info) Then
		      Return info
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UserName() As String
		  //Returns the username of the account under which the application is running.
		  //On Error, returns an empty string
		  
		  #If TargetWin32 Then
		    Dim mb As New MemoryBlock(0)
		    Dim nmLen As Integer = mb.Size
		    If Not Win32.Libs.AdvApi32.GetUserName(mb, nmLen) Then Return ""
		    mb = New MemoryBlock(nmLen * 2)
		    nmLen = mb.Size
		    If Win32.Libs.AdvApi32.GetUserName(mb, nmLen) Then
		      Return mb.WString(0)
		    Else
		      Return ""
		    End If
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Win32Exception(ErrorNumber As Integer) As RuntimeException
		  Dim err As New Win32Exception
		  err.ErrorNumber = ErrorNumber
		  err.Message = "Win32 error: " + FormatError(ErrorNumber)
		  Return err
		End Function
	#tag EndMethod


	#tag Constant, Name = FILE_READ_ATTRIBUTES, Type = Double, Dynamic = False, Default = \"&h0080", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_READ_DATA, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FILE_READ_EA, Type = Double, Dynamic = False, Default = \"&h0008", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FORMAT_MESSAGE_FROM_SYSTEM, Type = Double, Dynamic = False, Default = \"&H1000", Scope = Private
	#tag EndConstant

	#tag Constant, Name = INVALID_HANDLE_VALUE, Type = Double, Dynamic = False, Default = \"-1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = READ_CONTROL, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SE_SHUTDOWN_NAME, Type = String, Dynamic = False, Default = \"SeShutdownPrivilege", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SRCCOPY, Type = Double, Dynamic = False, Default = \"&h00CC0020", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_ALL, Type = Double, Dynamic = False, Default = \"&h001F0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_EXECUTE, Type = Double, Dynamic = False, Default = \"READ_CONTROL", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_READ, Type = Double, Dynamic = False, Default = \"READ_CONTROL", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_REQUIRED, Type = Double, Dynamic = False, Default = \"&h000F0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = STANDARD_RIGHTS_WRITE, Type = Double, Dynamic = False, Default = \"READ_CONTROL", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = SYNCHRONIZE, Type = Double, Dynamic = False, Default = \"&h00100000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = S_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


	#tag Structure, Name = OSVERSIONINFOEX, Flags = &h1
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

	#tag Structure, Name = SECURITY_ATTRIBUTES, Flags = &h1
		Length As Integer
		  secDescriptor As Ptr
		InheritHandle As Boolean
	#tag EndStructure

	#tag Structure, Name = SYSTEM_INFO, Flags = &h1
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
