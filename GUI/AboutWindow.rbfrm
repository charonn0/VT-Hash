#tag Window
Begin Window AboutWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   HasFullScreenButton=   False
   Height          =   119
   ImplicitInstance=   True
   LiveResize      =   "False"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   2
   Resizeable      =   False
   Title           =   "About VT Hash Check"
   Visible         =   True
   Width           =   424
   Begin Canvas IconView
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      Height          =   85
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   2
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   2
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   90
   End
   Begin PushButton CloseBtn
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Close"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   213
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   11.0
      TextUnit        =   0
      Top             =   93
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   60
   End
   Begin PushButton UpdateBtn
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Update"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   151
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
      TextSize        =   11.0
      TextUnit        =   0
      Top             =   93
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   60
   End
   Begin HREFArea LegalTextArea
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   89
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   94
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   False
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
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Transparent     =   True
      Underline       =   False
      UnicodeMode     =   0
      UseFocusRing    =   True
      Visible         =   True
      Width           =   330
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h1
		Protected Sub ProcessLinks(Text As String, TextSize As Single)
		  Text = ReplaceAll(Text, "#EOL@", EndOfLine + EndOfLine)
		  Dim lines() As String = Split(Text, "</link>")
		  Dim sr As New StyleRun
		  sr.Size = TextSize
		  For i As Integer = 0 To UBound(lines)
		    Dim ln As String = lines(i)
		    Dim linktext, url As String
		    linktext = NthField(ln, ">", 2)
		    ln = Replace(ln, ">" + linktext, "")
		    url = NthField(ln, "<link=", 2)
		    Dim href As New StyleRun
		    href.Size = TextSize
		    sr.Text = NthField(ln, "<link=", 1)
		    href.Text = linktext
		    href.TextColor = &c0000FF00
		    href.Underline = True
		    LegalTextArea.AppendText(sr)
		    LegalTextArea.AppendText(href, url)
		  Next
		  sr.Text = CRLF
		  sr.Bold = Not sr.Bold
		  LegalTextArea.AppendText(sr)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowMe()
		  Me.ShowModal
		End Sub
	#tag EndMethod


	#tag Constant, Name = MAIN_LICENSE_TEXT, Type = String, Dynamic = False, Default = \"The source code for this application is available under the terms of the GNU General Public License 3.0. This binary distribution is licensed under the <link\x3Dhttps://creativecommons.org/licenses/by-nc-nd/4.0/>Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International</link> license.\r\r----\r\r<link\x3Dhttps://www.virustotal.com/>VirusTotal</link> is a registered trademark of Chronicle LLC. \r\rThis application is not made or supported by VirusTotal or Chronicle LLC.", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = THIRD_PARTY_LICENSE_TEXTS, Type = String, Dynamic = False, Default = \"\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\rLicense for libcurl\r\rCOPYRIGHT AND PERMISSION NOTICE\r\rCopyright (c) 1996 - 2021\x2C Daniel Stenberg\x2C daniel@haxx.se\x2C and many contributors\x2C see the THANKS file.\r\rAll rights reserved.\r\rPermission to use\x2C copy\x2C modify\x2C and distribute this software for any purpose with or without fee is hereby granted\x2C provided that the above copyright notice and this permission notice appear in all copies.\r\rTHE SOFTWARE IS PROVIDED \"AS IS\"\x2C WITHOUT WARRANTY OF ANY KIND\x2C EXPRESS OR IMPLIED\x2C INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY\x2C FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM\x2C DAMAGES OR OTHER LIABILITY\x2C WHETHER IN AN ACTION OF CONTRACT\x2C TORT OR OTHERWISE\x2C ARISING FROM\x2C OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\r\rExcept as contained in this notice\x2C the name of a copyright holder shall not be used in advertising or otherwise to promote the sale\x2C use or other dealings in this Software without prior written authorization of the copyright holder.\r\r\r\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\rLicense for zlib\r\r/* zlib.h -- interface of the \'zlib\' general purpose compression library\r  version 1.2.11\x2C January 15th\x2C 2017\r\r  Copyright (C) 1995-2017 Jean-loup Gailly and Mark Adler\r\r  This software is provided \'as-is\'\x2C without any express or implied\r  warranty.  In no event will the authors be held liable for any damages\r  arising from the use of this software.\r\r  Permission is granted to anyone to use this software for any purpose\x2C\r  including commercial applications\x2C and to alter it and redistribute it\r  freely\x2C subject to the following restrictions:\r\r  1. The origin of this software must not be misrepresented; you must not\r     claim that you wrote the original software. If you use this software\r     in a product\x2C an acknowledgment in the product documentation would be\r     appreciated but is not required.\r  2. Altered source versions must be plainly marked as such\x2C and must not be\r     misrepresented as being the original software.\r  3. This notice may not be removed or altered from any source distribution.\r\r  Jean-loup Gailly        Mark Adler\r  jloup@gzip.org          madler@alumni.caltech.edu\r\r*/\r\r\r\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\rLicense for Brotli\r\rCopyright (c) 2009\x2C 2010\x2C 2013-2016 by the Brotli Authors.\r\rPermission is hereby granted\x2C free of charge\x2C to any person obtaining a copy\rof this software and associated documentation files (the \"Software\")\x2C to deal\rin the Software without restriction\x2C including without limitation the rights\rto use\x2C copy\x2C modify\x2C merge\x2C publish\x2C distribute\x2C sublicense\x2C and/or sell\rcopies of the Software\x2C and to permit persons to whom the Software is\rfurnished to do so\x2C subject to the following conditions:\r\rThe above copyright notice and this permission notice shall be included in\rall copies or substantial portions of the Software.\r\rTHE SOFTWARE IS PROVIDED \"AS IS\"\x2C WITHOUT WARRANTY OF ANY KIND\x2C EXPRESS OR\rIMPLIED\x2C INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY\x2C\rFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE\rAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM\x2C DAMAGES OR OTHER\rLIABILITY\x2C WHETHER IN AN ACTION OF CONTRACT\x2C TORT OR OTHERWISE\x2C ARISING FROM\x2C\rOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\rTHE SOFTWARE.\r\r\r\r\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\rLicense for OpenSSL\r\r\r                                 Apache License\r                           Version 2.0\x2C January 2004\r                        <link\x3Dhttps://www.apache.org/licenses/>https://www.apache.org/licenses/</link>\r\r   TERMS AND CONDITIONS FOR USE\x2C REPRODUCTION\x2C AND DISTRIBUTION\r\r   1. Definitions.\r\r      \"License\" shall mean the terms and conditions for use\x2C reproduction\x2C\r      and distribution as defined by Sections 1 through 9 of this document.\r\r      \"Licensor\" shall mean the copyright owner or entity authorized by\r      the copyright owner that is granting the License.\r\r      \"Legal Entity\" shall mean the union of the acting entity and all\r      other entities that control\x2C are controlled by\x2C or are under common\r      control with that entity. For the purposes of this definition\x2C\r      \"control\" means (i) the power\x2C direct or indirect\x2C to cause the\r      direction or management of such entity\x2C whether by contract or\r      otherwise\x2C or (ii) ownership of fifty percent (50%) or more of the\r      outstanding shares\x2C or (iii) beneficial ownership of such entity.\r\r      \"You\" (or \"Your\") shall mean an individual or Legal Entity\r      exercising permissions granted by this License.\r\r      \"Source\" form shall mean the preferred form for making modifications\x2C\r      including but not limited to software source code\x2C documentation\r      source\x2C and configuration files.\r\r      \"Object\" form shall mean any form resulting from mechanical\r      transformation or translation of a Source form\x2C including but\r      not limited to compiled object code\x2C generated documentation\x2C\r      and conversions to other media types.\r\r      \"Work\" shall mean the work of authorship\x2C whether in Source or\r      Object form\x2C made available under the License\x2C as indicated by a\r      copyright notice that is included in or attached to the work\r      (an example is provided in the Appendix below).\r\r      \"Derivative Works\" shall mean any work\x2C whether in Source or Object\r      form\x2C that is based on (or derived from) the Work and for which the\r      editorial revisions\x2C annotations\x2C elaborations\x2C or other modifications\r      represent\x2C as a whole\x2C an original work of authorship. For the purposes\r      of this License\x2C Derivative Works shall not include works that remain\r      separable from\x2C or merely link (or bind by name) to the interfaces of\x2C\r      the Work and Derivative Works thereof.\r\r      \"Contribution\" shall mean any work of authorship\x2C including\r      the original version of the Work and any modifications or additions\r      to that Work or Derivative Works thereof\x2C that is intentionally\r      submitted to Licensor for inclusion in the Work by the copyright owner\r      or by an individual or Legal Entity authorized to submit on behalf of\r      the copyright owner. For the purposes of this definition\x2C \"submitted\"\r      means any form of electronic\x2C verbal\x2C or written communication sent\r      to the Licensor or its representatives\x2C including but not limited to\r      communication on electronic mailing lists\x2C source code control systems\x2C\r      and issue tracking systems that are managed by\x2C or on behalf of\x2C the\r      Licensor for the purpose of discussing and improving the Work\x2C but\r      excluding communication that is conspicuously marked or otherwise\r      designated in writing by the copyright owner as \"Not a Contribution.\"\r\r      \"Contributor\" shall mean Licensor and any individual or Legal Entity\r      on behalf of whom a Contribution has been received by Licensor and\r      subsequently incorporated within the Work.\r\r   2. Grant of Copyright License. Subject to the terms and conditions of\r      this License\x2C each Contributor hereby grants to You a perpetual\x2C\r      worldwide\x2C non-exclusive\x2C no-charge\x2C royalty-free\x2C irrevocable\r      copyright license to reproduce\x2C prepare Derivative Works of\x2C\r      publicly display\x2C publicly perform\x2C sublicense\x2C and distribute the\r      Work and such Derivative Works in Source or Object form.\r\r   3. Grant of Patent License. Subject to the terms and conditions of\r      this License\x2C each Contributor hereby grants to You a perpetual\x2C\r      worldwide\x2C non-exclusive\x2C no-charge\x2C royalty-free\x2C irrevocable\r      (except as stated in this section) patent license to make\x2C have made\x2C\r      use\x2C offer to sell\x2C sell\x2C import\x2C and otherwise transfer the Work\x2C\r      where such license applies only to those patent claims licensable\r      by such Contributor that are necessarily infringed by their\r      Contribution(s) alone or by combination of their Contribution(s)\r      with the Work to which such Contribution(s) was submitted. If You\r      institute patent litigation against any entity (including a\r      cross-claim or counterclaim in a lawsuit) alleging that the Work\r      or a Contribution incorporated within the Work constitutes direct\r      or contributory patent infringement\x2C then any patent licenses\r      granted to You under this License for that Work shall terminate\r      as of the date such litigation is filed.\r\r   4. Redistribution. You may reproduce and distribute copies of the\r      Work or Derivative Works thereof in any medium\x2C with or without\r      modifications\x2C and in Source or Object form\x2C provided that You\r      meet the following conditions:\r\r      (a) You must give any other recipients of the Work or\r          Derivative Works a copy of this License; and\r\r      (b) You must cause any modified files to carry prominent notices\r          stating that You changed the files; and\r\r      (c) You must retain\x2C in the Source form of any Derivative Works\r          that You distribute\x2C all copyright\x2C patent\x2C trademark\x2C and\r          attribution notices from the Source form of the Work\x2C\r          excluding those notices that do not pertain to any part of\r          the Derivative Works; and\r\r      (d) If the Work includes a \"NOTICE\" text file as part of its\r          distribution\x2C then any Derivative Works that You distribute must\r          include a readable copy of the attribution notices contained\r          within such NOTICE file\x2C excluding those notices that do not\r          pertain to any part of the Derivative Works\x2C in at least one\r          of the following places: within a NOTICE text file distributed\r          as part of the Derivative Works; within the Source form or\r          documentation\x2C if provided along with the Derivative Works; or\x2C\r          within a display generated by the Derivative Works\x2C if and\r          wherever such third-party notices normally appear. The contents\r          of the NOTICE file are for informational purposes only and\r          do not modify the License. You may add Your own attribution\r          notices within Derivative Works that You distribute\x2C alongside\r          or as an addendum to the NOTICE text from the Work\x2C provided\r          that such additional attribution notices cannot be construed\r          as modifying the License.\r\r      You may add Your own copyright statement to Your modifications and\r      may provide additional or different license terms and conditions\r      for use\x2C reproduction\x2C or distribution of Your modifications\x2C or\r      for any such Derivative Works as a whole\x2C provided Your use\x2C\r      reproduction\x2C and distribution of the Work otherwise complies with\r      the conditions stated in this License.\r\r   5. Submission of Contributions. Unless You explicitly state otherwise\x2C\r      any Contribution intentionally submitted for inclusion in the Work\r      by You to the Licensor shall be under the terms and conditions of\r      this License\x2C without any additional terms or conditions.\r      Notwithstanding the above\x2C nothing herein shall supersede or modify\r      the terms of any separate license agreement you may have executed\r      with Licensor regarding such Contributions.\r\r   6. Trademarks. This License does not grant permission to use the trade\r      names\x2C trademarks\x2C service marks\x2C or product names of the Licensor\x2C\r      except as required for reasonable and customary use in describing the\r      origin of the Work and reproducing the content of the NOTICE file.\r\r   7. Disclaimer of Warranty. Unless required by applicable law or\r      agreed to in writing\x2C Licensor provides the Work (and each\r      Contributor provides its Contributions) on an \"AS IS\" BASIS\x2C\r      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND\x2C either express or\r      implied\x2C including\x2C without limitation\x2C any warranties or conditions\r      of TITLE\x2C NON-INFRINGEMENT\x2C MERCHANTABILITY\x2C or FITNESS FOR A\r      PARTICULAR PURPOSE. You are solely responsible for determining the\r      appropriateness of using or redistributing the Work and assume any\r      risks associated with Your exercise of permissions under this License.\r\r   8. Limitation of Liability. In no event and under no legal theory\x2C\r      whether in tort (including negligence)\x2C contract\x2C or otherwise\x2C\r      unless required by applicable law (such as deliberate and grossly\r      negligent acts) or agreed to in writing\x2C shall any Contributor be\r      liable to You for damages\x2C including any direct\x2C indirect\x2C special\x2C\r      incidental\x2C or consequential damages of any character arising as a\r      result of this License or out of the use or inability to use the\r      Work (including but not limited to damages for loss of goodwill\x2C\r      work stoppage\x2C computer failure or malfunction\x2C or any and all\r      other commercial damages or losses)\x2C even if such Contributor\r      has been advised of the possibility of such damages.\r\r   9. Accepting Warranty or Additional Liability. While redistributing\r      the Work or Derivative Works thereof\x2C You may choose to offer\x2C\r      and charge a fee for\x2C acceptance of support\x2C warranty\x2C indemnity\x2C\r      or other liability obligations and/or rights consistent with this\r      License. However\x2C in accepting such obligations\x2C You may act only\r      on Your own behalf and on Your sole responsibility\x2C not on behalf\r      of any other Contributor\x2C and only if You agree to indemnify\x2C\r      defend\x2C and hold each Contributor harmless for any liability\r      incurred by\x2C or claims asserted against\x2C such Contributor by reason\r      of your accepting any such warranty or additional liability.\r\r   END OF TERMS AND CONDITIONS\r\r\r\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\x3D\rLicense for TrIDLib\r\rTrIDLib - Free version - (C) 2008-2011 By Marco Pontello\r\rInfo: <link\x3Dhttp://mark0.net/code-tridlib-e.html>http://mark0.net/code-tridlib-e.html</link>\r      <link\x3Dhttp://mark0.net/soft-trid-e.html>http://mark0.net/soft-trid-e.html</link>\rE-Mail: <link\x3Dmailto:marcopon@gmail.com>marcopon@gmail.com</link>\r\rLicense:\r\rThis Win32 DLL can be freely redistribuited in this exact form.\rThis license file must be included along the DLL.\rA TrID\'s definitions file package may also be included.\rAll these files need to retain the original names:\rTrIDLib.dll\x2C TrIDLib-License.txt\x2C TrIDDefs.trd\r\rThis version/edition is free for non commercial\x2C personal\x2C research and\reducational use. It can be included in freeware applications\x2C as long as the\rapplication\x2C its documentation and its website contain a clear reference to\rTrIDLib & his author name\x2C and a link to TrIDLib mainpage (or to the Online\rTrID\x2C or TrID pages)\r\rContact the author for agreements in any kind of commercial / for profit /\rbusiness use. The full version also have importants additional features.\r\r\rDISCLAIMER:\r\rTHIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER \xE2\x80\x9CAS IS\xE2\x80\x9D AND ANY EXPRESS OR\rIMPLIED WARRANTIES\x2C INCLUDING\x2C BUT NOT LIMITED TO\x2C THE IMPLIED WARRANTIES OF\rMERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO\rEVENT SHALL THE COPYRIGHT OWNER BE LIABLE FOR ANY DIRECT\x2C INDIRECT\x2C INCIDENTAL\x2C\rSPECIAL\x2C EXEMPLARY\x2C OR CONSEQUENTIAL DAMAGES ( INCLUDING\x2C BUT NOT LIMITED TO\x2C\rPROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE\x2C DATA\x2C OR PROFITS; OR\rBUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY\x2C WHETHER\rIN CONTRACT\x2C STRICT LIABILITY\x2C OR TORT ( INCLUDING NEGLIGENCE OR OTHERWISE)\rARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE\x2C EVEN IF ADVISED OF THE\rPOSSIBILITY OF SUCH DAMAGE.", Scope = Protected
	#tag EndConstant


#tag EndWindowCode

#tag Events IconView
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #pragma Unused areas
		  vt_small.Transparent = 1
		  g.DrawPicture(vt_small, 0, 0)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events CloseBtn
	#tag Event
		Sub Action()
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UpdateBtn
	#tag Event
		Sub Action()
		  Dim upd As New UpdateWindow
		  Dim f As FolderItem = upd.CheckNow("www.boredomsoft.org/updates/vthash.json", VTHash.Version)
		  If f <> Nil Then
		    f.Child("vthashsetup.exe").Launch
		    Quit
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LegalTextArea
	#tag Event
		Sub Open()
		  Dim sr As New StyleRun
		  sr.Text = "VT Hash Check " + VTHash.VersionString + EndOfLine
		  sr.FontSize = 28
		  sr.Bold = True
		  Me.AppendText(sr)
		  
		  sr = New StyleRun
		  sr.Text = "Copyright ©2009-21 "
		  sr.FontSize = 11
		  Me.AppendText(sr)
		  
		  sr = New StyleRun
		  sr.Text = "Andrew Lambert"
		  sr.FontSize = 11
		  Me.AppendText(sr, "https://github.com/charonn0/")
		  
		  sr = New StyleRun
		  sr.Text = ", All Rights Reserved." + EndOfLine + EndOfLine
		  sr.FontSize = 11
		  Me.AppendText(sr)
		  
		  ProcessLinks(MAIN_LICENSE_TEXT, 9.5)
		  sr = New StyleRun
		  sr.Text = THIRD_PARTY_LICENSE_TEXTS
		  sr.FontSize = 9.0
		  Me.AppendText(sr)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ClickLink(LinkValue As Variant, LinkText As String)
		  #pragma Unused LinkText
		  ShowURL(LinkValue.StringValue)
		End Sub
	#tag EndEvent
#tag EndEvents
