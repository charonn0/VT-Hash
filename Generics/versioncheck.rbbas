#tag Class
Protected Class versioncheck
Inherits HTTPSocket
	#tag Event
		Sub Connected()
		  //The code below is executed when the socket first makes a connection to the server. This event will fire twice: first when the myapp.upd file is retrieved, and second when (if) the updated file is downloaded.
		  //This code merely updates the status indicators in the updateWin to reflect the current state.
		  //
		  //The code check to see whether the update in question is a silent one and whether it's downloading the myupp.upd file or an actual update.
		  //If it is a silent check and the file being downloaded is the myapp.upd file, then no user notification is given. Otherwise, the updateWin is changed to reflect the status.
		  
		  if update = True and isSilent = False then
		    updateWin.Status.Text = "Connection Established"
		    updateWin.Log.AddRow("Connection Established")
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub DownloadComplete(url as string, httpStatus as integer, headers as internetHeaders, file as folderItem)
		  //This event fires when the file being downloaded has completed downloading.
		  //
		  //It checks which file it downloaded (the myapp.upd file or the actual updates) and calles the appropriate method.
		  //
		  //It also check to see whether the user has cancelled and, if so, deletes the temporary file.
		  
		  if updateWin.cancel = False then
		    //See the comments in the HeadersReceived event for details
		    updateWin.Log.AddRow("Transfer Complete")
		    updateWin.Status.Text = "Complete"
		    if update = False then
		      checkforupdate()
		    else
		      launchUpdate()
		    end if
		  end if
		  
		Exception err as NilObjectException
		  self.Close
		End Sub
	#tag EndEvent

	#tag Event
		Sub Error(code as integer)
		  //HTTPSocket error codes and user notification
		  if isSilent = True and update = True then
		    MsgBox("HTTP Error: " + str(code) + " occured while attempting to update.")
		  else
		    updateWin.Status.Text = "An Error Ocurred While Updating."
		    updateWin.Log.AddRow("Error " + str(code) + " ocurred during transfer")
		    Select case code
		    case 100
		      updateWin.Log.AddRow("     Error Returned Was: 100, driver error")
		    case 102
		      updateWin.Log.AddRow("     Error Returned Was: 102, Connection Lost")
		    case 103
		      updateWin.Log.AddRow("     Error Returned Was: 103, Unresolved Host")
		    case 105
		      updateWin.Log.AddRow("     Error Returned Was: 105, Port Bind Error")
		    case 106
		      updateWin.Log.AddRow("     Error Returned Was: 106, Invalid Socket State")
		    case 107
		      updateWin.Log.AddRow("     Error Returned Was: 107, Invalid Port")
		    case 108
		      updateWin.Log.AddRow("     Error Returned Was: 108, Out Of Memory")
		    case 400
		      updateWin.Log.AddRow("     Error Returned Was: 400, Bad Request")
		    case 401
		      updateWin.Log.AddRow("     Error Returned Was: 401, Unauthorized")
		    case 414
		      updateWin.Log.AddRow("     Error Returned Was: 414, Request-URI Too Long")
		    case 500
		      updateWin.Log.AddRow("     Error Returned Was: 500, Internal Server Error")
		    case 505
		      updateWin.Log.AddRow("     Error Returned Was: 505, HTTP Version Not Supported")
		    case 509
		      updateWin.Log.AddRow("     Error Returned Was: 509, Bandwidth Limit Exceeded")
		    else
		      updateWin.Log.AddRow("     Error Type Unknown or Undefined. Error Code:" + str(code))
		    end Select
		    
		  end if
		  updateWin.ProgressBar1.Value = updateWin.ProgressBar1.Maximum
		  updateWin.stopDone.Caption = "Close"
		  updateWin.startTry.Caption = "Retry"
		  updateWin.startTry.Enabled = True
		Exception err as NilObjectException
		  self.Close
		End Sub
	#tag EndEvent

	#tag Event
		Sub HeadersReceived(headers as internetHeaders, httpStatus as integer)
		  //Here we catch several common HTTP status codes for redirection and authorization and File Not Found Errors
		  //
		  //Each redirect increments the redirCount value by one. More than five redirects and we give up.
		  Static redirCount As Integer
		  
		  Select case httpStatus
		  Case 301, 302  //Moved
		    redirCount = redirCount + 1
		    if redirCount > 5 then
		      updateWin.Status.Text = "Server Error. Please Try Again Later."
		      updateWin.Log.AddRow("     Server reports 301 or 302: Moved.")
		      updateWin.Log.AddRow("          Already followed five redirects. Fail.")
		      updateWin.startTry.Caption = "Retry"
		      updateWin.startTry.Enabled = True
		      updateWin.stopDone.Caption = "Close"
		    else
		      updateWin.Log.AddRow("     Server reports 301 or 302: Moved. Following Redirect")
		      updateaddress = headers.CommaSeparatedValues("Location")  //retrieve redirect URI from header, put it in the updateaddress property
		      updInfo.localFile.Delete
		      checkVer(isSilent)
		    end if
		  case 403  //Access Denied or Password Required
		    updateWin.Status.Text = "Server Error. Please Try Again Later."
		    updateWin.Log.AddRow("     Server reports 403: Forbidden! Unable To Download")
		    updateWin.startTry.Caption = "Retry"
		    updateWin.startTry.Enabled = True
		    updateWin.stopDone.Caption = "Close"
		    self.Close   //Nothing can be done: die
		  case 404  //File not found
		    updateWin.Status.Text = "Server Error. Please Try Again Later."
		    updateWin.Log.AddRow("     Server reports 404: File Not Found! Unable To Download!")
		    updateWin.startTry.Caption = "Retry"
		    updateWin.startTry.Enabled = True
		    updateWin.stopDone.Caption = "Close"
		    updateWin.cancel = True
		    self.Close  //Nothing can be done: die
		  case 200  //Everything's OK, proceed normally
		    updateWin.Status.Text = "Receiving data."
		    updateWin.Log.AddRow("     Headers received")
		  else   //If the server sends back a response code other than 301, 302, 403, 404, or 200
		    updateWin.Status.Text = "Server Error. Please Try Again Later."
		    updateWin.Log.AddRow("     Unexpected HTTP Response: " + str(httpStatus) + ". Cannot Continue.")
		    updateWin.startTry.Caption = "Retry"
		    updateWin.stopDone.Caption = "Close"
		    self.Close   //Nothing can be done: die
		  end Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub ReceiveProgress(bytesReceived as integer, totalBytes as integer, newData as string)
		  //This event fires several times per second while a file is being downloaded. The code below merely updates the updateWin UI to reflect the current state of the transfer,
		  //as well as checking to see whether the user has clicked the cancel button.
		  
		  
		  if updateWin.cancel = False then
		    //See the comments in the HeadersReceived event for details
		    updateWin.ProgressBar1.value=(bytesReceived/totalBytes)*100
		    updateWin.StaticText3.Text = FormatBytes(bytesReceived)
		    if updateWin.Log.Cell(updateWin.Log.LastIndex,0) <> "Beginning Transfer" then
		      updateWin.Log.AddRow("Beginning Transfer")
		    end if
		    Select case updateWin.Status.Text
		    case "Receiving"
		      updateWin.Status.Text = "Receiving."
		    case "Receiving."
		      updateWin.Status.Text = "Receiving.."
		    case "Receiving.."
		      updateWin.Status.Text = "Receiving..."
		    else
		      updateWin.Status.Text = "Receiving"
		    end Select
		  else
		    updInfo.localFile.Delete
		    MsgBox("Transfer Aborted")
		    updateWin.Log.AddRow("Update Aborted!")
		    self.Disconnect
		    self.Close
		  end if
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub checkforupdate()
		  //This method is called by the DownloadComplete event if the update property is set to false.
		  //The update property is instantiated as false and is only set to true after this method runs.
		  //See the Notes section for details about using the update property.
		  //
		  //The code below assumes that the file containing the version info which was downloaded is named "myapp.upd"
		  //You can change this to whatever you like provided you update the necessary properties. See the Notes section for info about using the myapp.upd file.
		  //
		  //The parseUpdFile method is called which returns a Boolean based on success or failure to parse the myapp.upd file.
		  //The parseUpdFile method will populate the updInfo UpdateInformation class:
		  //     "Name" is the name of the program; Required
		  //     "Version" is the latest available version number, as a str(double); Required
		  //     "URL" is the URI to download the latest version of the program; Required
		  //     "RequireConfirm" is whether or not to show a special message to the user (see notes on RequireOK); Optional
		  //     "ConfirmTitle" is the window title of the special message, if used; Optional
		  //     "ConfirmMessage" is the special message itself; Optional
		  //     "FileType" is the File Type declaration. At this time, this isn't used much; Optional
		  //     "Verify" is whether an MD5 checksum is provided/will be checked
		  //     "Checksum" is the MD5sum (hex) of the file being downloaded
		  //
		  //
		  //The currentversion value is then compared the the "Version" value. If the currentversion value is greater than or equal to the "Version" value, then the user is notified that they have the latest version.
		  //Otherwise, the user is asked whether they want to update to the latest version. If they click yes, then the update property is set to True and the getupdate() method is called.
		  //
		  //The myapp.upd file can include four optional parameters: requireOK, confimTitle, confirmMessage, and filetype. The first three parameters allow you to optionally require the user to read
		  //a custom message before continuing. This message can be any string and is diplayed in a message box. If no custom message is provided, the default message is used.
		  //Refer to the notes section for how to use this.
		  //
		  //The fourth parameter, filetype, can tell the program what type of file the upgrade file is. There are two built-in possibilities: "exe" and "arc" for "executable" and "archive" respectively.
		  //The use of this parameter is useful if your target platform is POSIX compliant (Unix-type systems like Linux) and you are using an executable file as the upgrade file.
		  //Since most POSIX systems require that executable be explicitly marked as executable, setting this parameter to "exe" will cause the launchupdate method to attempt
		  //to chmod +x the file before executing it. The default is "arc" which does nothing to the file. Future editions of this project may expand this.
		  //
		  //Note: Any or all of the optional paramers may be used. However, if requireConfirm is NOT set to "yes" then the other two associated parameters are ignored.
		  //
		  //Refer to the Notes section on further uses for the myapp.upd file.
		  
		  if parseUpdFile() = False then    //If failed, error out
		    Raise new UnsupportedFormatException
		  Else
		    try
		      if currentversion >= updInfo.Version Then      //compare the versions
		        if Not isSilent then
		          MsgBox("You Have The Latest Version of " + updInfo.Name)     //Up to date already
		          updateWin.Status.Text = "Done. Already the latest version."
		          updateWin.Log.AddRow("All operations completed. No new versions were available.")
		          updateWin.startTry.Enabled = True
		          updateWin.startTry.Caption = "Retry"
		          updateWin.stopDone.Caption = "Done"
		        end if
		        self.Close            //Die
		      else
		        //Ask for confirmation, update status and log
		        updateWin.Status.Text = "New version available. Please confirm download."
		        updateWin.Log.AddRow("New version found. Awaiting user confirmation.")
		        dim x as Integer
		        if updInfo.RequireConfirm Then
		          x = MsgBox(updInfo.ConfirmMessage, 33, updInfo.ConfirmMessage)
		        else
		          x = MsgBox("A New Version Is Available!" + EndOfLine + "Would You Like To Download The Update Now?", 33, "New Version Available")    //Generic confirmation
		        end if
		        if x = 1 then
		          //User clicked Yes
		          updateWin.Status.Text = "Downloading latest version..."
		          updateWin.Log.AddRow("Download commenced.")
		          update = True     //Update is available
		          getupdate()        //So get it
		        else
		          //User clicked No
		          updateWin.Status.Text = "Upgrade Canceled."
		          updateWin.Log.AddRow("User declined to upgrade. Done.")
		          updateWin.startTry.Enabled = True
		          updateWin.startTry.Caption = "Retry"
		          updateWin.stopDone.Caption = "Done"
		          updateWin.ProgressBar1.Value = updateWin.ProgressBar1.Maximum
		          self.Close     //Die
		        end if
		      end if
		    Catch
		      MsgBox("Error!")
		      self.Close
		    end try
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub checkVer(silence As Boolean)
		  //This method is the first to be called. It performs several functions then connects to your webserver (defined in the updateaddress string variable) and downloads a small text file. Also defined
		  //here is the HTTP "User-Agent" string. You can change this to whatever you like, and it should show up in your server's logs (this is a neat little way to see how often people are updating.)
		  //Refer to the sample myapp.upd file included in the archive for a look at what the update file contains.
		  //
		  //Then a check is first performed to see whether this is a "silent" update or not. If it is, then the updateWin window is hidden.
		  //The parameter "silence" is passed from the calling statement, true for silent false for not silent. If not silent, the progress bar is made visible
		  //and the window is shown.
		  //
		  //Next, the updateFile FolderItem is instantiated in the system's temporary folder.
		  //
		  //You can name your update file anything you want provided you update the code in this method as well as in the downloadcomplete event.
		  //
		  //After connecting to the server, the file is downloaded to the folderitem defined below as updFile
		  //
		  //the me.get() method will cause several of the event handlers to fire as the download commences (connected), is going (HeadersRecieved, ReceiveProgress),
		  //ends (DownloadComplete), or errors out (Error).
		  updateWin.cancel = False
		  updateWin.startTry.Enabled = False
		  isSilent = silence
		  if isSilent = True Then
		    updateWin.Visible = False
		  end if
		  updInfo = New UpdateInformation
		  updInfo.localFile = SpecialFolder.Temporary.Child("myapp.upd")
		  updateWin.Log.AddRow("Connecting to Server")
		  updateWin.Status.Text = "Attempting Connection..."
		  me.SetRequestHeader("User-Agent", "App Updater 1.8")
		  me.Get(updateaddress, updInfo.localFile)
		  
		Exception Err
		  handleException(Err)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub getupdate()
		  //This method connects to your webserver and downloads the updated version of the app  from the URI specified in the update file that was downloaded in
		  //the checkver method and parsed in the checkforupdate method.
		  //
		  //The code below instantiates the upgrdFile FolderItem in the user's Temporary Files folder using the name of the file being downloaded.
		  //For example, http://www.example.com/downloads/updates/myApp.exe would yield "myApp.exe" as the upgradename
		  //The file is then downloaded by passing the updInfo(2) property to Get() along with the upgrade FolderItem as its target.
		  
		  if updateWin.Visible = False then
		    updateWin.Visible = True
		  end if
		  
		  updInfo.fileName = NthField(updInfo.URL, "/", CountFields(updInfo.URL, "/"))
		  if updInfo.fileName = "" then
		    updInfo.fileName = NthField(updInfo.URL, "/", (CountFields(updInfo.URL, "/") - 1))
		  end if
		  if usebrowser = False then
		    updInfo.localFile = SpecialFolder.Temporary.Child(updInfo.fileName)
		    me.SetRequestHeader("User-Agent", "App Updater 1.8")
		    me.Get(updInfo.URL, updInfo.localFile)
		  else
		    ShowURL(updInfo.URL)
		    updateWin.stopDone.Caption = "Done"
		    updateWin.startTry.Enabled = False
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub handleException(err As RuntimeException)
		  MsgBox(Err.Message)
		  updateWin.Close
		  Self.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub launchUpdate()
		  //This is the final step in upgrading the program.
		  //
		  //The user is asked whether they want to launch the update now or save it to their desktop for later use.
		  //
		  //In either event, both temporary files will be deleted at the end. Cleanliness is next to godliness...
		  //
		  //The update is launched using the operating system's built-in file associations. For example, if the upgrade file is a ZIP or RAR archive file, then the user's
		  //default archive program will launch with the upgrade file. If the file is an executable, at least under Windows, then the executable will be executed. To specify
		  //the filetype, refer to the notes in the checkforupdates method.
		  //
		  //This whole method needs to be improved substantially to accommodate more filetypes and to more intelligently run them.
		  
		  dim fileVerified As Boolean = True
		  
		  if updInfo.Verify then
		    fileVerified = verifyMD5()
		  end if
		  
		  if fileVerified then
		    
		    updateWin.Status.Text = "Complete"
		    dim x As Integer = MsgBox("Download Complete, Would You Like To Launch The Update?", 36, "Download Complete")
		    if x = 6 then
		      updateWin.Status.Text = "Launching Update"
		      #if TargetLinux then
		        if Uppercase(updInfo.FileType) = "EXE" then
		          dim sh As new Shell
		          sh.Execute("chmod +x " + updInfo.localFile.AbsolutePath)
		          if sh.ErrorCode <> 0 then
		            MsgBox("Unable to set execute bit!")
		          else
		            updInfo.localFile.Launch(True)
		          end if
		        else
		          updInfo.localFile.Launch(True)
		        end if
		      #else
		        updInfo.localFile.Launch(True)
		      #endif
		      
		      
		      //Quit                        //Uncomment this line to kill the current app
		    else
		      updateWin.Status.Text = "New Version Saved To Desktop"
		      updateWin.Log.AddRow("Upgrade Not Installed. File saved to desktop.")
		      MsgBox("The Update File Has Been Saved To Your Desktop")
		      updInfo.localFile.MoveFileTo SpecialFolder.Desktop
		    end if
		  else
		    MsgBox("File Failed Verification!")
		    self.Close
		  end if
		  
		  updateWin.stopDone.Caption = "Done"
		  updateWin.Status.Text = "Complete"
		  updateWin.startTry.Enabled = False
		  self.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function parseUpdFile() As Boolean
		  dim myAppFile As FolderItem = SpecialFolder.Temporary.Child("myapp.upd")
		  dim tis As TextInputStream
		  dim lineFromFile As String
		  tis = tis.Open(myAppFile)
		  While Not tis.EOF
		    lineFromFile = tis.ReadLine
		    if left(lineFromFile, 2).Trim <> "//" and InStr(lineFromFile, "=") > 0 then
		      Select case Uppercase(NthField(lineFromFile, "=", 1)).Trim
		      case "NAME"
		        updInfo.Name = NthField(lineFromFile, "=", 2).Trim
		      case "VERSION"
		        updInfo.Version = Val(NthField(lineFromFile, "=", 2))
		      case "URL"
		        updInfo.URL = NthField(lineFromFile, "=", 2).Trim
		      case "REQUIRE CONFIRM"
		        if Uppercase(NthField(lineFromFile, "=", 2).Trim) = "YES" then updInfo.RequireConfirm = True
		      case "CONFIRM TITLE"
		        updInfo.ConfirmTitle = NthField(lineFromFile, "=", 2).Trim
		      case "CONFIRM MESSAGE"
		        updInfo.ConfirmMessage = NthField(lineFromFile, "=", 2).Trim
		      case "FILETYPE"
		        updInfo.FileType = NthField(lineFromFile, "=", 2).Trim
		      case "CHECKMD5"
		        If Uppercase(NthField(lineFromFile, "=", 2).Trim) = "YES" Then updInfo.Verify = True
		      case "MD5SUM"
		        updInfo.Checksum = NthField(lineFromFile, "=", 2).Trim
		      else
		        Continue
		      end Select
		    end if
		  wend
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function verifyMD5() As Boolean
		  //Calculates the MD5 Checksum of the file, converts the checksum into hex, and compares it to the checksum provided in the update file.
		  
		  dim checkSum, fileInput, s As String
		  dim tis As TextInputStream
		  dim v as integer
		  
		  updateWin.Log.AddRow("Verifying File Integrity")
		  tis = tis.Open(updInfo.localFile)
		  fileInput = tis.ReadAll
		  tis.Close
		  checkSum = Win32Crypto.Hash(fileInput, Win32Crypto.CALG_MD5)
		  
		  
		  if checkSum <> updInfo.Checksum then
		    updateWin.Log.AddRow("     File Not Verified.")
		    Return False
		  else
		    updateWin.Log.AddRow("     File Verified!")
		    Return True
		  end if
		End Function
	#tag EndMethod


	#tag Note, Name = changelog
		This is version 1.9 of the AppUpdater REALbasic Class from Boredom Software.
		
		Changes from 1.8:
		*Significant refactoring
		*Replaced the updInfo array with a class
		
		Changes from 1.7:
		*Cancelling actually works now.
		*Progress bar gets updated properly if a new version is downloaded after a silent check.
		
		Changes from 1.6:
		*Removed fixBytes() method as it became redundant
		*Modified prettyBytes() per anonymous suggestion
		
		Changes from 1.5:
		*MD5 Verification
		*Minor cleanup
		*Changed license to GNU LGPL 3.0
		
		Jumped over versions 1.3 and 1.4 because this is a pretty major update.
		
		Changes From Version 1.2:
		
		*Refactored most of the code
		*Added custom message options
		*redid the comments to make the code more readable!
		*changed the format of the myapp.upd file to be more robust and flexible
		*Added support for 301 and 302 HTTP redirects
		*General Maintenance
		
		Changes From Version 1.0:
		
		*Fixed the progressbar
		*Fixed an error when comparing version numbers
		*Added functionality to read the HTTP headers of a download to determine the filesize
		*Added the fixBytes method to convert raw bytes into KB, MB, etc.
		*Refactored the silent update so that it actually works right :-|
		*Several minor bug fixes and flow control optimizations.
		
		Updating Your App from Version 1.0, 1.1 or version 1.2:
		is going to be a pain in the ass. You should just basically replace the old version with this one and treat it as though it's the first time you've seen it.
		But updating is recommended as this version is vastly superior, plus I will no longer be providing support for 1.0 - 1.2!
	#tag EndNote

	#tag Note, Name = Definitions
		
		Throughout the comments I try to use a uniform set of terms to discuss various things. Here's the word list:
		
		update, upd
		        I use the term "update" or the abbreviation "upd" to refer to the act of checking for an updated version of the app. I also use it to refer to the small text
		        file that's downloaded containing the version information (called "myapp.upd" throughout)
		        The property called "update" is used to determine whether the current file being downloaded is the update file or the upgrade file. It starts out as false and then is
		        changed to true in the checkforupdate method.
		
		upgrade, upgrd
		        I use the term "upgrade" or the abbreviation "upgrd" to refer to the actual file that will upgrade the app. This could be an executable file, an archive file, whatever.
	#tag EndNote

	#tag Note, Name = General Notes
		This project, if not changed, will connect to my webserver and download a dummy file when run. I don't have any plans on discontinuing this, but I make no promise that
		the dummy file will always be there. Have a look at the URL in the updateaddress property for the update file's address (should be the same file as is distributed with the source.)
		
		
		
		Properties And Their Meanings/uses
		
		updateWin.cancel
		       This property is instantiated as false and gets set to True if the user clicks on the cancel button in updateWin. The receiveprogress checks for this.
		
		currentversion
		       The numeric version number of the current app. This value is a double so that decimal numbers like 1.005 can be used. Version numbers like
		       1.21.32 or 1.43a cannot be used unless you change the datatype to Variant or String.
		       If you change the datatype, you will need to change how the class compares the currentversion value with the newversion value in the checkforupdate method.
		       It's probably a better idea to NOT hard code this value but to read it from a file or registry key. Not implemented here for the sake of simplicity.
		
		isSilent
		       This is a Boolean value which is set by passing a boolean in to the checkVer method (which is how you should call this class, see the MainWin.Pushbutton1 & 2 's Action event). 
		       When set to False, the updateWin is shown throughout the process.
		       When set to True, the updateWin is only shown if a new version is available and the user is prompted to download the new version. 
		       Set this to True if you plan on using some method which will call this class periodically, as in an automatic update scheme.
		
		update 
		       This Boolean value is used by the class in the DownloadComplete event to decide which set of code to execute. You should not alter this property.
		
		UpdateInformation Class
		        This class has several properties which describe the upgrade listed in the update file. See the parseUpdFile() method and the notes in the 
		        checkforupdate() method. This
		        array replaces the old string array from previous versions.
		
		updateaddress
		       This is a string value that needs to be changed to point to the small text file on your web server that contains information about the latest version that is available. 
		       Throughout this class, that file called myapp.upd. As this is merely a text file, it can be called anything you want. However, if you choose a name other than 
		       myapp.upd, you will need to change all references to myapp.upd accordingly. In the comments throughout this class, I refer to this file as the update file. 
		       This should not be confused with the upgrade file, which is the actual updated version of the program. so, update = text file, upgrade = executable (or archive)
		
		usebrowser
		       This is a Boolean value which is by default set to False. Set this value to True if you want to launch the upgradeURI in the user's browser rather than 
		      directly download it. This is useful if you host your upgrade file on a third party server that doesn't allow direct downloads like File Hippo or Download.com. 
		      If you set this value to True then make sure that the upgradeURI value points to the appropriate web page.
	#tag EndNote

	#tag Note, Name = How To Integrate into your app
		
		You ought to be able to simply drag and drop the versioncheck and UpdateInformation classes from one IDE window into another to import it. You should also import the updateWin window
		or recreate it in your app using the same names (or change the names in the versioncheck class.) You will then need to write some of your own code to create a
		means of calling the updateWin Window (for user-invoked updates) or versioncheck.checkVer(True) (for automatic, silent checking) into your app.
		
		This class was written using REALbasic 20010R4.1. This version has some important differences in how it references SpecialFolders as well as other changes. You
		will need to alter the code to work in older versions of the IDE and compiler.
	#tag EndNote

	#tag Note, Name = Legal Notes & Stuff
		This project is free software, licensed under the GNU Lesser General Public License version 3.0 (http://www.gnu.org/copyleft/lesser.html)
		Copyright (c)2008-10 Boredom Software, All Rights Reserved
		
		Requirements:
		
		You are free to use and modify this project, compile it into your free or commercial program(s) for no fee. Any changes or modifications you 
		make must be made available under the same license.
		
		If you do use this in your program, I'd appreciate knowing about it. You can E-mail me at andrew@boredomsoft.org
		
		Any questions, comments, and suggestions are also welcome!
	#tag EndNote

	#tag Note, Name = myapp.upd Notes
		The myapp.upd file is the core of this entire excercise. It contains the necessary information to compare the latest version number to the current version number,
		the location to download the latest version from, the name of the program, plus options to display a customized message to the user before downloading and 
		controlling how the upgrade file is handled.
		
		The basic structure of the myapp.upd file is like this:
		
		//Begin File
		Name=My Super App
		Version=1.1
		URL=http://www.boredomsoft.org/Test/update.rar
		//Blah blah blah
		Require Confirm=Yes
		Confirm Title=Please Read This
		Confirm Message=You must agree to give me your soul before downloading. Click OK to agree
		Filetype=arc
		CheckMD5=yes
		//Blah! Blah, blahblah
		MD5Sum=b5eb1515c9246d07c9e500a2d2d57ea3
		//Blah?
		
		
		Basically this is a key=value system. Key names musn't be changed, but the values can contain any data in string form (strings cannot contain equals signs, though.) Comment lines are denoted by double slashes: //
		The key=value pairs can be given in any order, interspersed with any number of comment lines. One key=value pair or comment per line!
		
		Of the nine key=value pairs, six are optional and three are mandatory. The mandatory ones are:
		Name=
		Version=
		URL=
		
		The four optional parameters that you can use are:
		
		require: if you include the Require=Yes key=value pair, then the program will display a message box prior to downloading the upgrade
		confirmTitle: if the "require=Yes" pair is present, this is the title of the message box that will be presented
		confirmMessage: if the "require=Yes" pair is present, this is the text of the message presented
		filetype: defines how the program should handle the upgrade file. Currently, only the "exe" option is honored. The other option, "arc", is the default behavior anyway.
		CheckMD5: yes, or no. Whether or not to check the file's MD5Sum
		MD5Sum:  The hex representation of the files MD5 checksum.
		
		Key=value pairs are NOT case sensitive.
	#tag EndNote

	#tag Note, Name = Read me
		
		This is a method to have the ability to check for a newer version of your program online either via user action (a "Check for Updates" button, for example) or 
		through automatic means.
		
		You will need to have access to some sort of online file hosting to use this. Access to the file you upload must be via a direct HTTP GET request; this class does 
		not support any dynamic page generation or authentication (yet). It does honor HTTP redirects using the 301 or 302 HTTP status codes.
		
		The update file which is queried by this class must contain the following (see the example file, myapp.upd, included for syntax and all): the app's name; the most 
		current version number; the URI to download the latest version.
		
		The optional parameters in the myapp.upd file are requireOK, messageTitle, messageText, and filetype. They are discussed in more detail in the comments of the 
		checkforupdates and parseUpdFile methods, as well as in the myapp.upd Notes. 
		
		The default behavior of this class is to download the updated version of the app, save the upgrade to SpecialFolder.Temporary.Child(updInfo(1)), launch the 
		downloaded executable (or archive using the system file associations), then close itself. You can override this behavior by changing the usebrowser property 
		to true. This will then load the URI passed in the update file in the user's default browser (for example, if you use something like FileFront to host the upgrade 
		and the user needs to fill in extra data or CAPTCHA's)
		
		Refer to the Notes section for a run down of all the properties, as well as to know which ones need to be changed and which ones should be left alone.
		
		See the MainWin for examples of how to call the class both silently and non-silently.
		
		If you run this project without modification, it (should) connect to my webserver and download a dummy update. This way, you can see how it works without actually
		mucking around in the code or uploading anything to you server. However, I can't guarentee that this will always be the case!
		
		
		
		Reading the comments before the code in each method/event should prove enlightening to anyone haveing difficulties! 
		Nevertheless, if you have questions, comments, suggestions, or criticism please feel free to e-mail me at andrew@boredomsoft.org
	#tag EndNote

	#tag Note, Name = What not To Touch
		There are a number of methods, events and properties in this class that you needn't mess with unless you really want to.
		
		Things you can change if you feel like it:
		*Connected event
		*Error event
		*HeadersReceived event
		
		Things you can change if you know a better way (and will tell me!)
		* the prettyBytes Method simply converts raw byte numbers into nicer KB and MB numbers. 
		
		Things you shouldn't fuck with unless you know what you're doing. These are all automatically populated, so don't worry about them.
		* updateWin.cancel property
		* update property
		
		
		Everything else requires at least a little attention on your part.
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return VTHash.mversion
			End Get
		#tag EndGetter
		currentversion As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		isSilent As boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		update As boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		updateaddress As string = "http://www.boredomsoft.org/update/vthash.upd"
	#tag EndProperty

	#tag Property, Flags = &h0
		updInfo As UpdateInformation
	#tag EndProperty

	#tag Property, Flags = &h0
		usebrowser As boolean = false
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Address"
			Visible=true
			Group="Behavior"
			InheritedFrom="HTTPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="currentversion"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultPort"
			Group="Behavior"
			InitialValue="0"
			InheritedFrom="HTTPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="httpProxyAddress"
			Group="Behavior"
			InheritedFrom="HTTPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="httpProxyPort"
			Group="Behavior"
			InitialValue="0"
			InheritedFrom="HTTPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			InheritedFrom="HTTPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="isSilent"
			Group="Behavior"
			InitialValue="false"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InheritedFrom="HTTPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="HTTPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			InheritedFrom="HTTPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="HTTPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InheritedFrom="HTTPSocket"
		#tag EndViewProperty
		#tag ViewProperty
			Name="update"
			Group="Behavior"
			InitialValue="false"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="updateaddress"
			Group="Behavior"
			InitialValue="http://www.boredomsoft.com/myapp.upd"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="usebrowser"
			Group="Behavior"
			InitialValue="false"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="yield"
			Group="Behavior"
			InitialValue="0"
			InheritedFrom="HTTPSocket"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
