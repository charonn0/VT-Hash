VT Hash Check 1.4
Copyright ©2009-13 Boredom Software, All Rights Reserved

1. Purpose
2. Installing
3. Using
4. Uninstalling
5. Bugs & Issues
6. Misc notes
7. Contact



1. Purpose
The purpose of this program is to quickly check the MD5 (or SHA1) checksum of a given file against the checksum database of VirusTotal.com. If the checksum matches a file already scanned by VirusTotal.com then the results of 41 anti-virus scanners are shown.

2. Installing
To install the program, run the setup.exe file.

3. Using

As of version 0.85, you will need an API key from Virus Total to use VT Hash Check. If you prefer to not get an API key, then you must use an earlier version of the program. Earlier versions are not supported and won't have any bugs fixed in them. An API key is free with a Virus Total Community account (which is also free.) Sign up at: http://www.virustotal.com/vt-community/register.html

VT Hash Check will ask you for your API key the first time you run it. Alternatively, you can specify an API key on the command line using the 'api=' argument followed by your 64 character API key.

To use the program, once installed, simply right-click on any file in Windows Explorer and choose "Check Hash" from the context menu.

Settings may be modified by running the vthash.exe program directly (i.e. without arguments.) You may toggle SHA1/MD5 and edit your API key. VT Hash Check can also be configured to automatically save all scan results to a directory. You may specify the directory and the save format in the settings window.

4. Uninstalling
To uninstall, either click "Remove" from the Add/Remove Programs control panel applet or execute the uninstall.exe file from the program's installation directory.

5. Bugs & Issues
	None known ATM, but they're there.
	
6. Misc Notes
Virus Total is a free service provided by Hispasec Sistemas (http://www.hispasec.com/), independent IT Security laboratory. Boredom Software is not affiliated with them in any way nor have they provided input or are even (likely) aware of the development of this application. Hence, they should not be contacted with support questions. They cannot help youwith this application.

VirusTotal, and this program by extension, is not substitute any antivirus software installed in a PC, as it only checks individual files on demand. It does not offer permanent protection for the user's system either.

Although the detection rate afforded by the use of multiple antivirus engines is far superior to that offered by just one product, these results DO NOT guarantee the harmlessness of a file.

This program is in compliance with the terms and conditions set forth on the VirusTotal.com website as of the date of this writing. However, you, the user, should review the Terms and Conditions at http://www.virustotal.com/privacy.html before using this program.

If you feel as though your computer might be afflicted by malicious software, there are a number of highly reputable, skilled, and free malware removal forums on the internet, such as:
*www.bleepingcomputer.com/forums
*www.forospyware.es (Spanish)
*forums.malwarebytes.org
*www.247fixes.com/forums
*www.techsupportforum.com

7. Contact
Please send all queries to andrew@boredomsoft.org or use the online form at http://www.boredomsoft.org/contactus.bs.