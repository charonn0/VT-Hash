#tag Module
Protected Module Kernel32
	#tag ExternalMethod, Flags = &h1
		Protected Declare Function AreFileApisANSI Lib "Kernel32" () As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CheckNameLegalDOS8Dot3 Lib "Kernel32" Alias "CheckNameLegalDOS8Dot3W" (FileName As WString, ByRef OEMName As WString, OEMNameSize As Integer, ByRef NameContainsSpaces As Boolean, ByRef NameLegal As Boolean) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CloseHandle Lib "Kernel32" (handle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function ConnectNamedPipe Lib "Kernel32" (hPipe As Integer, Overlapped As Win32 . IO . OVERLAPPED) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CopyFileEx Lib "Kernel32" Alias "CopyFileExW" (sourceFile As WString, destinationFile As WString, FailIfExists As Boolean) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateConsoleScreenBuffer Lib "Kernel32" (DesiredAccess As Integer, ShareMode As Integer, SecurityAttributes As Ptr, Flags As Integer, Reserved As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateFile Lib "Kernel32" Alias "CreateFileW" (name As WString, access As Integer, sharemode As Integer, SecAtrribs As Ptr, CreateDisp As Integer, flags As Integer, template As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateFile Lib "Kernel32" (name As WString, access As Integer, sharemode As Integer, SecAtrribs As SECURITY_ATTRIBUTES, CreateDisp As Integer, flags As Integer, template As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateFileMapping Lib "Kernel32" Alias "CreateFileMappingW" (hFile As Integer, SecurityAttribs As Ptr, PageProtection As Integer, MaxSizeHi As Integer, MaxSizeLo As Integer, Name As WString) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function CreateHardLink Lib "Kernel32" Alias "CreateHardLinkW" (NewPath As WString, ExistingFile As WString, Reserved As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateNamedPipe Lib "Kernel32" Alias "CreateNamedPipeW" (PipeName As WString, OpenMode As Integer, PipeMode As Integer, MaxInstances As Integer, OutBufferSize As Integer, InBufferSize As Integer, DefaultTimeOut As Integer, SecurityAttribute As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreatePipe Lib "Kernel32" (ByRef ReadPipe As Integer, ByRef WritePipe As Integer, SecAttributes As Ptr, SuggestedBufferSize As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateProcess Lib "Kernel32" Alias "CreateProcessW" (AppName As WString, commandline As Ptr, ProcessAttribs As Integer, ThreadAttribs As Integer, inheritHandles As Boolean, flags As Integer, environ As Ptr, currentDir As Ptr, startInfo As Ptr, ProcInfo As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateProcess Lib "Kernel32" Alias "CreateProcessW" (AppName As WString, commandline As Ptr, ProcessAttribs As SECURITY_ATTRIBUTES, ThreadAttribs As SECURITY_ATTRIBUTES, inheritHandles As Boolean, flags As Integer, environ As Ptr, currentDir As Ptr, startInfo As Win32 . Utils . STARTUPINFO, ByRef info As Win32 . Utils . PROCESS_INFORMATION) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function CreateSymbolicLink Lib "Kernel32" Alias "CreateSymbolicLinkW" (NewPath As WString, ExistingFile As WString, Flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateThread Lib "Kernel32" (ThreadAttribs As Ptr, Stacksize As Integer, ThreadProcedure As Ptr, Parameter As Ptr, Flags As Integer, ByRef ThreadID As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function CreateToolhelp32Snapshot Lib "Kernel32" (Flags As Integer, ProcessID As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function DeleteFile Lib "Kernel32" Alias "DeleteFileW" (Path As WString) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function DeviceIoControl Lib "Kernel32" (hDevice As Integer, dwIoControlCode As Integer, lpInBuffer As Ptr, nInBufferSize As Integer, lpOutBuffer As Ptr, nOutBufferSize As Integer, lpBytesReturned As Ptr, lpOverlapped As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function DuplicateHandle Lib "Kernel32" (SourceProcess As Integer, SourceHandle As Integer, TargetProcess As Integer, ByRef TargetHandle As Integer, DesiredAccess As Integer, InheritHandle As Boolean, Options As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Sub ExitThread Lib "Kernel32" (ExitCode As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function ExpandEnvironmentStrings Lib "Kernel32" Alias "ExpandEnvironmentStringsW" (EnvString As WString, parsedString As Ptr, buffSize As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function FatalAppExit Lib "Kernel32" Alias "FatalAppExitW" (Action As Integer, Message As WString) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function FileTimeToSystemTime Lib "Kernel32" (fileTime As Ptr, systemTime As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function FindClose Lib "Kernel32" (FindHandle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function FindCloseChangeNotification Lib "Kernel32" (FindHandle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function FindFirstChangeNotification Lib "Kernel32" Alias "FindFirstChangeNotificationW" (dirPath As WString, watchChildren As Boolean, eventTypeFilter As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function FindFirstFile Lib "Kernel32" Alias "FindFirstFileW" (FileName As WString, ByRef FindData As Win32 . IO . WIN32_FIND_DATA) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function FindFirstFileEx Lib "Kernel32" Alias "FindFirstFileExW" (FileName As WString, InfoLevel As Integer, ByRef FindData As Win32 . IO . WIN32_FIND_DATA, SearchOptions As Integer, Reserved As Ptr, AdditionalFlags As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function FindFirstFileNameW Lib "Kernel32" (filename As WString, flags As Integer, ByRef StringLength As Integer, LinkName As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function FindFirstStream Lib "Kernel32" Alias "FindFirstStreamW" (filename As WString, InfoLevel As Integer, ByRef buffer As Win32 . IO . WIN32_FIND_STREAM_DATA, Reserved As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function FindNextFile Lib "Kernel32" Alias "FindNextFileW" (FindHandle As Integer, ByRef FindData As Win32 . IO . WIN32_FIND_DATA) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function FindNextFileNameW Lib "Kernel32" (FindHandle As Integer, ByRef StringLength As Integer, LinkName As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function FindNextStream Lib "Kernel32" Alias "FindNextStreamW" (FindHandle As Integer, ByRef buffer As Win32 . IO . WIN32_FIND_STREAM_DATA) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function FlushFileBuffers Lib "Kernel32" (FindHandle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function FormatMessage Lib "Kernel32" Alias "FormatMessageW" (dwFlags As Integer, lpSource As Integer, dwMessageId As Integer, dwLanguageId As Integer, lpBuffer As ptr, nSize As Integer, Arguments As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GenerateConsoleCtrlEvent Lib "Kernel32" (CtrlEvent As Integer, ProcessGroupID As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetBinaryType Lib "Kernel32" Alias "GetBinaryTypeW" (appFile As WString, ByRef binType As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetComputerName Lib "Kernel32" Alias "GetComputerNameW" (name As Ptr, ByRef size As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetCurrentDirectory Lib "Kernel32" Alias "GetCurrentDirectoryW" (BufferSize As Integer, Buffer As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetCurrentProcess Lib "Kernel32" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetCurrentThreadId Lib "Kernel32" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetDevicePowerState Lib "Kernel32" (dHandle As Integer, ByRef IsOn As Boolean) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetDiskFreeSpaceEx Lib "Kernel32" Alias "GetDiskFreeSpaceExW" (dirname As WString, ByRef freeBytesAvailable As UInt64, ByRef totalbytes As UInt64, ByRef totalFreeBytes As UInt64) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetFileAttributes Lib "Kernel32" Alias "GetFileAttributesW" (path As WString) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function GetFinalPathNameByHandle Lib "Kernel32" Alias "GetFinalPathNameByHandleW" (FileHandle As Integer, FilePath As Ptr, FilePathSize As Integer, Flags As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetLastError Lib "Kernel32" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetLogicalDriveStrings Lib "Kernel32" Alias "GetLogicalDriveStringsW" (BufferLength As Integer, Buffer As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function GetMappedFileName Lib "Kernel32" Alias "GetMappedFileNameW" (hProcess As Integer, lvp As Integer, Filename As Ptr, Size As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetModuleHandle Lib "Kernel32" Alias "GetModuleHandleW" (ModuleName As WString) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Sub GetNativeSystemInfo Lib "Kernel32" (ByRef info As SYSTEM_INFO)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetPriorityClass Lib "Kernel32" (ProcessHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function GetProcessHeap Lib "Kernel32" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function GetProcessImageFileName Lib "Kernel32" Alias "GetProcessImageFileNameW" (pHandle As Integer, path As Ptr, pathsize As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetStdHandle Lib "Kernel32" (HandleType As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function GetSystemDefaultLocaleName Lib "Kernel32" (buffer As Ptr, bufferSize As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Sub GetSystemInfo Lib "Kernel32" (ByRef info As SYSTEM_INFO)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetSystemTimes Lib "Kernel32" (idleTime As Ptr, kernelTime As Ptr, userTime As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function GetTimeZoneInformation Lib "Kernel32" (ByRef TZInfo As Win32 . Utils . TIME_ZONE_INFORMATION) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function GetVersionEx Lib "Kernel32" Alias "GetVersionExA" (ByRef info As OSVERSIONINFOEX) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function GetVolumeInformation Lib "Kernel32" Alias "GetVolumeInformationW" (path As WString, volumeName As Ptr, volnameSize As Integer, volumeSerialNumber As Ptr, ByRef maximumNameLength As Integer, ByRef FSFlags As Integer, filesystem As Ptr, fsNameSize As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GetVolumeNameForVolumeMountPoint Lib "Kernel32" Alias "GetVolumeNameForVolumeMountPointW" (mountPoint As WString, volumeName As Ptr, bufferSize As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GlobalAddAtom Lib "Kernel32" Alias "GlobalAddAtomW" (Name As WString) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GlobalAlloc Lib "Kernel32" (flags As UInt32, Bytes As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GlobalFree Lib "Kernel32" (hGlobal As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GlobalLock Lib "Kernel32" (hMem As Integer) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function GlobalMemoryStatusEx Lib "Kernel32" (ByRef MemStatus As Win32 . Utils . MEMORYSTATUSEX) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GlobalReAlloc Lib "Kernel32" (hMem As Integer, Size As Integer, Flags As UInt32) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GlobalSize Lib "Kernel32" (hMem As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function GlobalUnlock Lib "Kernel32" (hMem As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function HeapAlloc Lib "Kernel32" (HeapHandle As Integer, Flags As Integer, Size As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function HeapFree Lib "Kernel32" (HeapHandle As Integer, Flags As Integer, HMB As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function HeapLock Lib "Kernel32" (hHeap As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function HeapReAlloc Lib "Kernel32" (hHeap As Integer, Flags As Integer, hMem As Integer, NewSize As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function HeapSize Lib "Kernel32" (HeapHandle As Integer, Flags As Integer, HMB As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function HeapUnlock Lib "Kernel32" (hHeap As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function IsWow64Process Lib "Kernel32" (handle As Integer, ByRef is64 As Boolean) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function LocalAlloc Lib "Kernel32" (flags As UInt32, Bytes As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function LocalFree Lib "Kernel32" (hMem As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function LocalLock Lib "Kernel32" (hMem As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function LockFile Lib "Kernel32" (FileHandle As Integer, dwFileOffsetLow As Integer, dwFileOffsetHigh As Integer, nNumberOfBytesToLockLow As Integer, nNumberOfBytesToLockHigh As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function MapViewOfFile Lib "Kernel32" (hFilemap As Integer, DesiredAccess As Integer, OffsetHi As Integer, Offsetlo As Integer, ByteCount As UInt32) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function MoveFileEx Lib "Kernel32" Alias "MoveFileExW" (sourceFile As WString, destinationFile As WString, flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function OpenFileMapping Lib "Kernel32" Alias "OpenFileMappingW" (DesiredAccess As Integer, InheritHandle As Boolean, MapName As WString) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function OpenProcess Lib "Kernel32" (DesiredAccess As Integer, InheritHandle As Boolean, ProcessId As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function PeekNamedPipe Lib "Kernel32" (PipeHandle As Integer, Buffer As Ptr, BufferSize As Integer, ByRef BytesRead As Integer, ByRef TotalBytesAvailable As Integer, ByRef BytesLeftThisMessage As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function Process32First Lib "Kernel32" Alias "Process32FirstW" (Handle As Integer, ByRef Entry As Win32 . Utils . PROCESSENTRY32) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function Process32Next Lib "Kernel32" Alias "Process32NextW" (Handle As Integer, ByRef Entry As Win32 . Utils . PROCESSENTRY32) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function QueryDosDevice Lib "Kernel32" Alias "QueryDosDeviceW" (devicePath As WString, drivePath As Ptr, drivePathSize As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function ReadDirectoryChangesW Lib "Kernel32" (DirHandle As Integer, Buffer As Ptr, BufferLen As Integer, WatchSubtree As Boolean, NotifyFilter As Integer, ByRef BytesReturned As Integer, Overlapped As Ptr, CompletionRoutine As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function ReadFile Lib "Kernel32" (hFile As Integer, Buffer As Ptr, BytesToRead As Integer, ByRef BytesRead As Integer, Overlapped As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function RegisterWaitForSingleObject Lib "Kernel32" (ByRef waitHandle As Integer, objectHandle As Integer, callback As Ptr, context As Ptr, waitMilliseconds As Integer, flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function ReplaceFile Lib "Kernel32" Alias "ReplaceFileW" (SourceFile As WString, destinationFile As WString, backupFile As Ptr, flags As Integer, Reserved1 As Integer, Reserved2 As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function ResumeThread Lib "Kernel32" (ThreadHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SetCurrentDirectory Lib "Kernel32" Alias "SetCurrentDirectoryW" (Buffer As WString) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SetEndOfFile Lib "Kernel32" (hFile As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SetFileAttributes Lib "Kernel32" Alias "SetFileAttributesW" (path As WString, fattribs As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SetFilePointer Lib "Kernel32" (hFile As Integer, DistanceToMove As Integer, ByRef DistanceToMoveHigh As Integer, MoveMethod As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SetHandleInformation Lib "Kernel32" (Handle As Integer, Mask As Integer, Flags As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Sub SetLastError Lib "Kernel32" (ErrorNumber As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SetPriorityClass Lib "Kernel32" (ProcessHandle As Integer, NewPriority As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SetStdHandle Lib "Kernel32" (HandleType As Integer, Handle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SetSystemTime Lib "Kernel32" (ByRef NewTime As Win32 . Utils . SYSTEMTIME) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Sub SleepCurrentThread Lib "Kernel32" Alias "Sleep" (Milliseconds As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function SuspendThread Lib "Kernel32" (ThreadHandle As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function TerminateProcess Lib "Kernel32" (ProcessHandle As Integer, ExitCode As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function TerminateThread Lib "Kernel32" (ThreadHandle As Integer, ExitCode As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function TlsAlloc Lib "Kernel32" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function TlsFree Lib "Kernel32" (TlsIndex As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function TlsGetValue Lib "Kernel32" (TlsIndex As Integer) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function TlsSetValue Lib "Kernel32" (TlsIndex As Integer, TlsValue As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function UnlockFile Lib "Kernel32" (FileHandle As Integer, dwFileOffsetLow As integer, dwFileOffsetHigh As integer, nNumberOfBytesToUnlockLow As integer, nNumberOfBytesToUnlockHigh As integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function UnmapViewOfFile Lib "Kernel32" (BaseAddress As Ptr) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function UnregisterWait Lib "Kernel32" (WaitHandle As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function VirtualAlloc Lib "Kernel32" (Address As Integer, Size As Integer, AllocationType As Integer, Protect As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function VirtualFree Lib "Kernel32" (Address As Integer, Size As Integer, FreeType As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function VirtualLock Lib "Kernel32" (Address As Integer, Size As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function VirtualProtect Lib "Kernel32" (Address As Integer, Size As Integer, NewProtect As Integer, ByRef OldProtect As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function VirtualQuery Lib "Kernel32" (Address As Integer, ByRef InfoBuffer As Win32 . Utils . MEMORY_BASIC_INFORMATION, BufferLen As Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function VirtualUnlock Lib "Kernel32" (Address As Integer, Size As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function WaitForSingleObject Lib "Kernel32" (HWND as Integer, Period as Integer) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Soft Declare Function WinBeep Lib "Kernel32" Alias "Beep" (freq As Integer, duration As Integer) As Boolean
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Function WriteFile Lib "Kernel32" (hFile As Integer, Buffer As Ptr, BytesToWrite As Integer, ByRef BytesWritten As Integer, Overlapped As Ptr) As Boolean
	#tag EndExternalMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
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
	#tag EndViewBehavior
End Module
#tag EndModule
