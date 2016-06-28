; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{1E579B65-503B-4184-B481-5138124BEE1D}
AppName=VT Hash Check
AppVersion=1.57
;AppVerName=VT Hash Check 1.22
AppPublisher=Boredom Software
AppPublisherURL=http://www.boredomsoft.org
AppSupportURL=http://www.boredomsoft.org/vt-hash-check.bs
AppUpdatesURL=http://www.boredomsoft.org/vt-hash-check.bs
DefaultDirName={pf}\Boredom Software\VT Hash Check
DisableProgramGroupPage=true
AllowNoIcons=true
LicenseFile=..\Misc\license.txt
InfoBeforeFile=..\Misc\readme.txt
OutputBaseFilename=setup
SetupIconFile=..\GUI\Images\VTHash_102.ico
Compression=lzma/ultra
SolidCompression=true
AppCopyright=Boredom Software
AppVerName=VT Hash Check 1.57
AllowUNCPath=false
UsePreviousGroup=false
UninstallDisplayIcon={app}\VTHash.exe
UninstallDisplayName=VT Hash Check 1.57
ShowLanguageDialog=no
WizardImageFile=D:\Program Files\Inno Setup 5\Wizard Images\Modern\SetupModern21.bmp
WizardSmallImageFile=D:\Program Files\Inno Setup 5\Wizard Images\Modern\Small\SetupModernSmall26.bmp

[Languages]
Name: english; MessagesFile: compiler:Default.isl

[Files]
Source: ..\Builds - virusTotal_RELEASE.rbvcp\Windows\VTHash\*; DestDir: {app}; Flags: ignoreversion replacesameversion touch
Source: ..\Builds - virusTotal_RELEASE.rbvcp\Windows\VTHash\VTHash Libs\*; DestDir: {app}\VTHash Libs; Flags: ignoreversion recursesubdirs createallsubdirs touch; Languages: 
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: readme.txt; DestDir: {app}; DestName: readme.txt; Flags: touch
Source: license.txt; DestDir: {app}; DestName: license.txt; Flags: touch
Source: ..\GUI\Images\VTHash_102.ico; DestDir: {app}; MinVersion: 0,6.0.6000
Source: triddefs.trd; DestDir: {app}; Flags: overwritereadonly
Source: TrIDLib.dll; DestDir: {app}; Flags: overwritereadonly
Source: libcurl.dll; DestDir: {app}; Flags: overwritereadonly
Source: libeay32.dll; DestDir: {app}; Flags: overwritereadonly
Source: libidn-11.dll; DestDir: {app}; Flags: overwritereadonly
Source: ssleay32.dll; DestDir: {app}; Flags: overwritereadonly
Source: zlib1.dll; DestDir: {app}; Flags: overwritereadonly


[Registry]
Root: HKCR; SubKey: *\shell\vthash; ValueType: string; ValueData: Check File Hash...; Flags: uninsdeletekey
Root: HKLM; SubKey: SOFTWARE\Boredomsoft\VTHash; ValueType: string; ValueName: Version; ValueData: 1.57; Flags: uninsdeletekey
Root: HKLM; SubKey: SOFTWARE\Boredomsoft\VTHash; ValueType: string; ValueName: Release; ValueData: Final
Root: HKCR; SubKey: *\shell\vthash\command; ValueType: string; ValueData: """{app}\VTHash.exe"" ""%1"""; Flags: uninsdeletekey
Root: HKCR; SubKey: *\shell\vthash; ValueType: string; ValueData: """{app}\VTHash_102.ico"""; Flags: uninsdeletekey; ValueName: Icon; MinVersion: 0,6.0.6000; Languages: 
[InstallDelete]
Name: {app}\Libs\*; Type: filesandordirs; Languages: 
