**VT Hash Check** ("VTHC") is a Windows Explorer context menu extension that allows you to query the [Virus Total](https://www.virustotal.com/) malware scanning service simply by right-clicking on a file. If the file has already been scanned by Virus Total then the most recent results are displayed, otherwise VTCH will allow you to upload the file for analysis.

[**Download the latest release**](https://github.com/charonn0/VT-Hash/releases/latest)

![VTHash](https://user-images.githubusercontent.com/585485/156867146-4a53f28f-3745-4cef-9d2c-0124f41424e3.png)

![VTHash2](https://user-images.githubusercontent.com/585485/156867175-d8961989-6720-4df9-93a3-31f9fe4e192c.png)

![VTHash4](https://user-images.githubusercontent.com/585485/156867164-00a8113f-2236-4ddd-b495-2f2b57bc95be.png)



## Command line arguments
VT Hash Check will interpret its command line arguments as a list of files to check, allowing it to be used in other ways besides right-clicking a file. 
 
Besides file paths, you may optionally pass several command line arguments:

* `--prefs` Opens the settings window instead of checking a file
* `--trid` Runs a TrID analysis of the input file(s) instead of a hash check
* `--debug` Writes debugging info to the system log. Use a tool like DbgView to view the debug messages.
* `--insecure` Disables SSL certificate validation without disabling SSL/TLS (not recommended)
* `--update` Shows the updater window instead of checking a file
* `--about` Shows the about window instead of checking a file

## TrID mode from the context menu

You can add a context menu item which runs only a [TrID](http://mark0.net/soft-trid-e.html) analysis by using this registry script:

```reg
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\*\shell\vthashtrid]
@="Analyze with TrID..."
"Icon"="\"C:\\Program Files (x86)\\Boredom Software\\VT Hash Check\\VTHash_102.ico\""

[HKEY_CLASSES_ROOT\*\shell\vthashtrid\command]
@="\"C:\\Program Files (x86)\\Boredom Software\\VT Hash Check\\VTHash.exe\" --trid \"%1\""
```	

## SSL Certificate Authorities
VT Hash Check ships with [a list of trusted CAs](https://github.com/charonn0/RB-libcURL/blob/master/DEFAULT_CA_INFO_PEM). This list is the default list of trusted authorities used by Mozilla products, and includes a number of CAs that Virus Total may never actually use. You may optionally provide your own list of trustworthy CAs. This may be useful in situations where you need to trust a proxy's certificate or allow similarly friendly MITM "attacks" on your SSL connections, but using the `--insecure` command line parameter is undesirable.

List your trusted authorities in a file named `certlist.pem` saved to VT Hash's data folder. The data folder is located at `%USERDATA%\Boredom Software\VT Hash\`. The file format is standard PEM.

## Using the search engine feature
You may optionally define an Internet search engine which you can use to search for results from the context menu. To define a search engine, open the Settings window and enter the URL and display name of the search engine to use. Use the string `%PARAMETER%` as a placeholder in the URL for the search parameter. For example, Google's URL would be: `https://encrypted.google.com/search?q=%PARAMETER%`

## Further Notes
To use this application you will need a [Virus Total API key](https://support.virustotal.com/hc/en-us/articles/115002146769-Vote-comment#retrieve-api-key). VT Hash Check will prompt you to fill in your key the first time you run it. You can get an API key by signing up for a free Virus Total community account.

Virus Total limits the number of requests made to its API unless the particular API key has been granted higher limits. VT Hash Check should work just fine with both standard API keys and keys which have been granted higher request limits.

By default, the SHA256 checksum is computed. MD5 and SHA1 may also be used if SHA256 proves too slow, however MD5 is vulnerable to collisions and is not recommended for operations requiring a high level of security1. SHA1 is similarly not recommended, but to a lesser severity.

When attempting check the hashes of executable files obtained from the Internet or accessed via a network share users are likely to see a warning similar to these:

