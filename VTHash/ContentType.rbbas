#tag Class
Protected Class ContentType
	#tag Method, Flags = &h0
		Function Acceptance(OtherType As ContentType) As Single
		  'Returns a Single that is <=1. This is the comparative "weight" of the match between the
		  'two types. A weight of 1 has the highest Acceptance
		  If Not OtherType.Accepts(Me) Then Return 0.0
		  Return (OtherType.Weight + Me.Weight) / 2
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Accepts(OtherType As ContentType) As Boolean
		  ' Returns True if the OtherType is compatible with the current type. Use the Acceptance method to
		  ' determine which ContentType is preferred if more than one is accepted.
		  ' Only the SuperType and SubType are compared; optional parts like CharSet are not considered.
		  
		  If OtherType.SuperType <> Me.SuperType And OtherType.SuperType <> "*" And Me.SuperType <> "*" Then Return False
		  If OtherType.SubType <> Me.SubType And OtherType.SubType <> "*" And Me.SubType <> "*" Then Return False
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Raw As String)
		  'Accepts a single raw ContentType string (e.g. "text/html; CharSet=UTF-8")
		  'For strings that might contain multiple entries, use ContentType.ParseTypes
		  
		  If InStr(Raw, "/") = 0 Then Raise New UnsupportedFormatException
		  
		  If InStr(Raw, ";") > 0 Then
		    Dim fields() As String = Split(raw, ";")
		    Dim fcount As Integer = Ubound(fields)
		    For i As Integer = 0 To fcount
		      Dim entry As String = fields(i)
		      If InStr(entry, "/") > 0 Then
		        If NthField(entry, "/", 1).Trim <> "" Then
		          SuperType = NthField(entry, "/", 1).Trim
		        Else
		          SuperType = "*"
		        End If
		        
		        If NthField(entry, "/", 2).Trim <> "" Then
		          SubType = NthField(entry, "/", 2).Trim
		        Else
		          SubType = "*"
		        End If
		      Else
		        Select Case NthField(entry, "=", 1).Trim
		        Case "q"
		          Weight = CDbl(NthField(entry, "=", 2))
		        Case "charset"
		          Dim nm As String = NthField(entry, "=", 2)
		          For e As Integer = 0 To Encodings.Count' - 1
		            If Encodings.Item(e).internetName = nm Then
		              Me.CharSet = Encodings.Item(e)
		              Exit For e
		            End If
		          Next
		        Case "boundary"
		          Boundary = NthField(entry, "boundary=", 2).Trim
		        End Select
		      End If
		      
		    Next
		    
		  Else
		    If NthField(Raw, "/", 1).Trim <> "" Then
		      SuperType = NthField(Raw, "/", 1).Trim
		    Else
		      SuperType = "*"
		    End If
		    
		    If NthField(Raw, "/", 2).Trim <> "" Then
		      SubType = NthField(Raw, "/", 2).Trim
		    Else
		      SubType = "*"
		    End If
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherType As String) As Integer
		  ' Allows you to compare a ContentType directly to a String.
		  ' If the String would be Accepted this method returns 0 (equivalence)
		  ' Otherwise, performs a lexicographic comparison
		  ' e.g.
		  '     If MyContentType = "text/html" Then
		  
		  If Me.Accepts(New ContentType(OtherType)) Then Return 0
		  Return StrComp(Me.ToString, OtherType, 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(FromFile As FolderItem)
		  ' Pass a folderitem to construct a ContentType object based on the file name extension. The FolderItem need not exist.
		  
		  Dim t As String = "application/octet-stream"
		  If FromFile <> Nil Then t = MIMETypes.Lookup(NthField(FromFile.Name, ".", CountFields(FromFile.Name, ".")), t)
		  Me.Constructor(t)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(OtherType As String)
		  ' Allows you to convert a string into a ContentType
		  ' e.g.
		  '     MyContentType = "text/html"
		  
		  Me.Constructor(OtherType)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function ParseTypes(Raw As String) As ContentType()
		  'parses a multi-field content-type string into and array of ContentType objects
		  'e.g. "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
		  Dim fields() As String
		  If InStr(Raw, ",") > 0 Then 'multiple types
		    fields = Split(raw, ",")
		  Else
		    fields.Append(raw)
		  End If
		  Dim types() As ContentType
		  Dim fcount As Integer = Ubound(fields)
		  For i As Integer = 0 To fcount
		    types.Append(New ContentType(fields(i)))
		  Next
		  Return types
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  'serializes the object
		  
		  Dim data As String = SuperType + "/" + SubType
		  If Me.Weight < 1 Then
		    data = data + "; q=" + Format(Me.Weight, ".##")
		  End If
		  If Me.CharSet <> Nil And Me.CharSet.internetName <> "" Then
		    data = data + "; CharSet=" + Me.CharSet.internetName
		  End If
		  If Me.Boundary.Trim <> "" Then
		    data = data + "; boundary=" + Me.Boundary
		  End If
		  Return Data
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		#tag Note
			Optional; only useful in MultipartForms
		#tag EndNote
		Boundary As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Optional; the character encoding of the content.
		#tag EndNote
		CharSet As TextEncoding
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  If mMIMETypes = Nil Then
			    mMIMETypes = New Dictionary( _
			    "ez":"application/andrew-inset", _
			    "aw":"application/applixware", _
			    "atom":"application/atom+xml", _
			    "atomcat":"application/atomcat+xml", _
			    "atomsvc":"application/atomsvc+xml", _
			    "ccxml":"application/ccxml+xml", _
			    "cdmia":"application/cdmi-capability", _
			    "cdmic":"application/cdmi-container", _
			    "cdmid":"application/cdmi-domain", _
			    "cdmio":"application/cdmi-object", _
			    "cdmiq":"application/cdmi-queue", _
			    "cu":"application/cu-seeme", _
			    "davmount":"application/davmount+xml", _
			    "daa":"application/x-daa", _
			    "dssc":"application/dssc+der", _
			    "xdssc":"application/dssc+xml", _
			    "ecma":"application/ecmascript", _
			    "emma":"application/emma+xml", _
			    "epub":"application/epub+zip", _
			    "exi":"application/exi", _
			    "pfr":"application/font-tdpfr", _
			    "stk":"application/hyperstudio", _
			    "ipfix":"application/ipfix", _
			    "jar":"application/java-archive", _
			    "ser":"application/java-serialized-object", _
			    "class":"application/java-vm", _
			    "js":"application/javascript", _
			    "json":"application/json", _
			    "lostxml":"application/lost+xml", _
			    "hqx":"application/mac-binhex40", _
			    "cpt":"application/mac-compactpro", _
			    "mads":"application/mads+xml", _
			    "mrc":"application/marc", _
			    "mrcx":"application/marcxml+xml", _
			    "ma":"application/mathematica", _
			    "nb":"application/mathematica", _
			    "mb":"application/mathematica", _
			    "mathml":"application/mathml+xml", _
			    "mbox":"application/mbox", _
			    "mscml":"application/mediaservercontrol+xml", _
			    "meta4":"application/metalink4+xml", _
			    "mets":"application/mets+xml", _
			    "mods":"application/mods+xml", _
			    "m21":"application/mp21", _
			    "mp21":"application/mp21", _
			    "mp4s":"application/mp4", _
			    "doc":"application/msword", _
			    "dot":"application/msword", _
			    "mxf":"application/mxf", _
			    "asc":"application/pgp-signature", _
			    "sig":"application/pgp-signature", _
			    "prf":"application/pics-rules", _
			    "p10":"application/pkcs10", _
			    "p7m":"application/pkcs7-mime", _
			    "p7c":"application/pkcs7-mime", _
			    "p7s":"application/pkcs7-signature", _
			    "p8":"application/pkcs8", _
			    "ac":"application/pkix-attr-cert", _
			    "cer":"application/pkix-cert", _
			    "crl":"application/pkix-crl", _
			    "pkipath":"application/pkix-pkipath", _
			    "pki":"application/pkixcmp", _
			    "pls":"application/pls+xml", _
			    "ai":"application/postscript", _
			    "eps":"application/postscript", _
			    "ps":"application/postscript", _
			    "cww":"application/prs.cww", _
			    "pskcxml":"application/pskc+xml", _
			    "rdf":"application/rdf+xml", _
			    "rif":"application/reginfo+xml", _
			    "rnc":"application/relax-ng-compact-syntax", _
			    "rl":"application/resource-lists+xml", _
			    "rld":"application/resource-lists-diff+xml", _
			    "rs":"application/rls-services+xml", _
			    "rsd":"application/rsd+xml", _
			    "rss":"application/rss+xml", _
			    "rtf":"application/rtf", _
			    "sbml":"application/sbml+xml", _
			    "scq":"application/scvp-cv-request", _
			    "scs":"application/scvp-cv-response", _
			    "spq":"application/scvp-vp-request", _
			    "spp":"application/scvp-vp-response", _
			    "sdp":"application/sdp", _
			    "setpay":"application/set-payment-initiation", _
			    "setreg":"application/set-registration-initiation", _
			    "shf":"application/shf+xml", _
			    "smi":"application/smil+xml", _
			    "smil":"application/smil+xml", _
			    "rq":"application/sparql-query", _
			    "srx":"application/sparql-results+xml", _
			    "gram":"application/srgs", _
			    "grxml":"application/srgs+xml", _
			    "sru":"application/sru+xml", _
			    "ssml":"application/ssml+xml", _
			    "tei":"application/tei+xml", _
			    "teicorpus":"application/tei+xml", _
			    "tfi":"application/thraud+xml", _
			    "tsd":"application/timestamped-data", _
			    "plb":"application/vnd.3gpp.pic-bw-large", _
			    "psb":"application/vnd.3gpp.pic-bw-small", _
			    "pvb":"application/vnd.3gpp.pic-bw-var", _
			    "tcap":"application/vnd.3gpp2.tcap", _
			    "pwn":"application/vnd.3m.post-it-notes", _
			    "aso":"application/vnd.accpac.simply.aso", _
			    "imp":"application/vnd.accpac.simply.imp", _
			    "acu":"application/vnd.acucobol", _
			    "atc":"application/vnd.acucorp", _
			    "acutc":"application/vnd.acucorp", _
			    "air":"application/vnd.adobe.air-application-installer-package+zip", _
			    "fxp":"application/vnd.adobe.fxp", _
			    "fxpl":"application/vnd.adobe.fxp", _
			    "xdp":"application/vnd.adobe.xdp+xml", _
			    "xfdf":"application/vnd.adobe.xfdf", _
			    "ahead":"application/vnd.ahead.space", _
			    "azf":"application/vnd.airzip.filesecure.azf", _
			    "azs":"application/vnd.airzip.filesecure.azs", _
			    "azw":"application/vnd.amazon.ebook", _
			    "acc":"application/vnd.americandynamics.acc", _
			    "ami":"application/vnd.amiga.ami", _
			    "apk":"application/vnd.android.package-archive", _
			    "cii":"application/vnd.anser-web-certificate-issue-initiation", _
			    "fti":"application/vnd.anser-web-funds-transfer-initiation", _
			    "atx":"application/vnd.antix.game-component", _
			    "mpkg":"application/vnd.apple.installer+xml", _
			    "m3u8":"application/vnd.apple.mpegurl", _
			    "swi":"application/vnd.aristanetworks.swi", _
			    "aep":"application/vnd.audiograph", _
			    "mpm":"application/vnd.blueice.multipass", _
			    "bmi":"application/vnd.bmi", _
			    "rep":"application/vnd.businessobjects", _
			    "cdxml":"application/vnd.chemdraw+xml", _
			    "mmd":"application/vnd.chipnuts.karaoke-mmd", _
			    "cdy":"application/vnd.cinderella", _
			    "cla":"application/vnd.claymore", _
			    "rp9":"application/vnd.cloanto.rp9", _
			    "c4g":"application/vnd.clonk.c4group", _
			    "c4d":"application/vnd.clonk.c4group", _
			    "c4f":"application/vnd.clonk.c4group", _
			    "c4p":"application/vnd.clonk.c4group", _
			    "c4u":"application/vnd.clonk.c4group", _
			    "c11amc":"application/vnd.cluetrust.cartomobile-config", _
			    "c11amz":"application/vnd.cluetrust.cartomobile-config-pkg", _
			    "csp":"application/vnd.commonspace", _
			    "cdbcmsg":"application/vnd.contact.cmsg", _
			    "cmc":"application/vnd.cosmocaller", _
			    "clkx":"application/vnd.crick.clicker", _
			    "clkk":"application/vnd.crick.clicker.keyboard", _
			    "clkp":"application/vnd.crick.clicker.palette", _
			    "clkt":"application/vnd.crick.clicker.template", _
			    "clkw":"application/vnd.crick.clicker.wordbank", _
			    "wbs":"application/vnd.criticaltools.wbs+xml", _
			    "pml":"application/vnd.ctc-posml", _
			    "ppd":"application/vnd.cups-ppd", _
			    "car":"application/vnd.curl.car", _
			    "pcurl":"application/vnd.curl.pcurl", _
			    "rdz":"application/vnd.data-vision.rdz", _
			    "uvf":"application/vnd.dece.data", _
			    "uvvf":"application/vnd.dece.data", _
			    "uvd":"application/vnd.dece.data", _
			    "uvvd":"application/vnd.dece.data", _
			    "uvt":"application/vnd.dece.ttml+xml", _
			    "uvvt":"application/vnd.dece.ttml+xml", _
			    "uvx":"application/vnd.dece.unspecified", _
			    "uvvx":"application/vnd.dece.unspecified", _
			    "fe_launch":"application/vnd.denovo.fcselayout-link", _
			    "dna":"application/vnd.dna", _
			    "mlp":"application/vnd.dolby.mlp", _
			    "dpg":"application/vnd.dpgraph", _
			    "dfac":"application/vnd.dreamfactory", _
			    "ait":"application/vnd.dvb.ait", _
			    "svc":"application/vnd.dvb.service", _
			    "geo":"application/vnd.dynageo", _
			    "mag":"application/vnd.ecowin.chart", _
			    "nml":"application/vnd.enliven", _
			    "esf":"application/vnd.epson.esf", _
			    "msf":"application/vnd.epson.msf", _
			    "qam":"application/vnd.epson.quickanime", _
			    "slt":"application/vnd.epson.salt", _
			    "ssf":"application/vnd.epson.ssf", _
			    "es3":"application/vnd.eszigno3+xml", _
			    "et3":"application/vnd.eszigno3+xml", _
			    "ez2":"application/vnd.ezpix-album", _
			    "ez3":"application/vnd.ezpix-package", _
			    "fdf":"application/vnd.fdf", _
			    "mseed":"application/vnd.fdsn.mseed", _
			    "seed":"application/vnd.fdsn.seed", _
			    "dataless":"application/vnd.fdsn.seed", _
			    "gph":"application/vnd.flographit", _
			    "ftc":"application/vnd.fluxtime.clip", _
			    "fm":"application/vnd.framemaker", _
			    "frame":"application/vnd.framemaker", _
			    "maker":"application/vnd.framemaker", _
			    "book":"application/vnd.framemaker", _
			    "fnc":"application/vnd.frogans.fnc", _
			    "ltf":"application/vnd.frogans.ltf", _
			    "fsc":"application/vnd.fsc.weblaunch", _
			    "oas":"application/vnd.fujitsu.oasys", _
			    "oa2":"application/vnd.fujitsu.oasys2", _
			    "oa3":"application/vnd.fujitsu.oasys3", _
			    "fg5":"application/vnd.fujitsu.oasysgp", _
			    "bh2":"application/vnd.fujitsu.oasysprs", _
			    "ddd":"application/vnd.fujixerox.ddd", _
			    "xdw":"application/vnd.fujixerox.docuworks", _
			    "xbd":"application/vnd.fujixerox.docuworks.binder", _
			    "fzs":"application/vnd.fuzzysheet", _
			    "txd":"application/vnd.genomatix.tuxedo", _
			    "ggb":"application/vnd.geogebra.file", _
			    "ggt":"application/vnd.geogebra.tool", _
			    "gex":"application/vnd.geometry-explorer", _
			    "gre":"application/vnd.geometry-explorer", _
			    "gxt":"application/vnd.geonext", _
			    "g2w":"application/vnd.geoplan", _
			    "g3w":"application/vnd.geospace", _
			    "gmx":"application/vnd.gmx", _
			    "kml":"application/vnd.google-earth.kml+xml", _
			    "kmz":"application/vnd.google-earth.kmz", _
			    "gqf":"application/vnd.grafeq", _
			    "gqs":"application/vnd.grafeq", _
			    "gac":"application/vnd.groove-account", _
			    "ghf":"application/vnd.groove-help", _
			    "gim":"application/vnd.groove-identity-message", _
			    "grv":"application/vnd.groove-injector", _
			    "gtm":"application/vnd.groove-tool-message", _
			    "tpl":"application/vnd.groove-tool-template", _
			    "vcg":"application/vnd.groove-vcard", _
			    "hal":"application/vnd.hal+xml", _
			    "zmm":"application/vnd.handheld-entertainment+xml", _
			    "hbci":"application/vnd.hbci", _
			    "les":"application/vnd.hhe.lesson-player", _
			    "hpgl":"application/vnd.hp-hpgl", _
			    "hpid":"application/vnd.hp-hpid", _
			    "hps":"application/vnd.hp-hps", _
			    "jlt":"application/vnd.hp-jlyt", _
			    "pcl":"application/vnd.hp-pcl", _
			    "pclxl":"application/vnd.hp-pclxl", _
			    "sfd-hdstx":"application/vnd.hydrostatix.sof-data", _
			    "x3d":"application/vnd.hzn-3d-crossword", _
			    "mpy":"application/vnd.ibm.minipay", _
			    "afp":"application/vnd.ibm.modcap", _
			    "listafp":"application/vnd.ibm.modcap", _
			    "list3820":"application/vnd.ibm.modcap", _
			    "irm":"application/vnd.ibm.rights-management", _
			    "sc":"application/vnd.ibm.secure-container", _
			    "icc":"application/vnd.iccprofile", _
			    "icm":"application/vnd.iccprofile", _
			    "igl":"application/vnd.igloader", _
			    "ivp":"application/vnd.immervision-ivp", _
			    "ivu":"application/vnd.immervision-ivu", _
			    "igm":"application/vnd.insors.igm", _
			    "xpw":"application/vnd.intercon.formnet", _
			    "xpx":"application/vnd.intercon.formnet", _
			    "i2g":"application/vnd.intergeo", _
			    "qbo":"application/vnd.intu.qbo", _
			    "qfx":"application/vnd.intu.qfx", _
			    "rcprofile":"application/vnd.ipunplugged.rcprofile", _
			    "irp":"application/vnd.irepository.package+xml", _
			    "xpr":"application/vnd.is-xpr", _
			    "fcs":"application/vnd.isac.fcs", _
			    "jam":"application/vnd.jam", _
			    "rms":"application/vnd.jcp.javame.midlet-rms", _
			    "jisp":"application/vnd.jisp", _
			    "joda":"application/vnd.joost.joda-archive", _
			    "ktz":"application/vnd.kahootz", _
			    "ktr":"application/vnd.kahootz", _
			    "karbon":"application/vnd.kde.karbon", _
			    "chrt":"application/vnd.kde.kchart", _
			    "kfo":"application/vnd.kde.kformula", _
			    "flw":"application/vnd.kde.kivio", _
			    "kon":"application/vnd.kde.kontour", _
			    "kpr":"application/vnd.kde.kpresenter", _
			    "ksp":"application/vnd.kde.kspread", _
			    "kwd":"application/vnd.kde.kword", _
			    "htke":"application/vnd.kenameaapp", _
			    "kia":"application/vnd.kidspiration", _
			    "kne":"application/vnd.kinar", _
			    "skp":"application/vnd.koan", _
			    "sse":"application/vnd.kodak-descriptor", _
			    "lasxml":"application/vnd.las.las+xml", _
			    "lbd":"application/vnd.llamagraphics.life-balance.desktop", _
			    "lbe":"application/vnd.llamagraphics.life-balance.exchange+xml", _
			    "123":"application/vnd.lotus-1-2-3", _
			    "apr":"application/vnd.lotus-approach", _
			    "pre":"application/vnd.lotus-freelance", _
			    "nsf":"application/vnd.lotus-notes", _
			    "org":"application/vnd.lotus-organizer", _
			    "scm":"application/vnd.lotus-screencam", _
			    "lwp":"application/vnd.lotus-wordpro", _
			    "portpkg":"application/vnd.macports.portpkg", _
			    "mcd":"application/vnd.mcd", _
			    "mc1":"application/vnd.medcalcdata", _
			    "cdkey":"application/vnd.mediastation.cdkey", _
			    "mwf":"application/vnd.mfer", _
			    "mfm":"application/vnd.mfmp", _
			    "flo":"application/vnd.micrografx.flo", _
			    "igx":"application/vnd.micrografx.igx", _
			    "mif":"application/vnd.mif", _
			    "daf":"application/vnd.mobius.daf", _
			    "dis":"application/vnd.mobius.dis", _
			    "mbk":"application/vnd.mobius.mbk", _
			    "mqy":"application/vnd.mobius.mqy", _
			    "msl":"application/vnd.mobius.msl", _
			    "plc":"application/vnd.mobius.plc", _
			    "txf":"application/vnd.mobius.txf", _
			    "mpn":"application/vnd.mophun.application", _
			    "mpc":"application/vnd.mophun.certificate", _
			    "xul":"application/vnd.mozilla.xul+xml", _
			    "cil":"application/vnd.ms-artgalry", _
			    "cab":"application/vnd.ms-cab-compressed", _
			    "xls":"application/vnd.ms-excel", _
			    "xlm":"application/vnd.ms-excel", _
			    "xla":"application/vnd.ms-excel", _
			    "xlc":"application/vnd.ms-excel", _
			    "xlt":"application/vnd.ms-excel", _
			    "xlw":"application/vnd.ms-excel", _
			    "xlam":"application/vnd.ms-excel.addin.macroenabled.12", _
			    "xlsb":"application/vnd.ms-excel.sheet.binary.macroenabled.12", _
			    "xlsm":"application/vnd.ms-excel.sheet.macroenabled.12", _
			    "xltm":"application/vnd.ms-excel.template.macroenabled.12", _
			    "eot":"application/vnd.ms-fontobject", _
			    "chm":"application/vnd.ms-htmlhelp", _
			    "ims":"application/vnd.ms-ims", _
			    "lrm":"application/vnd.ms-lrm", _
			    "thmx":"application/vnd.ms-officetheme", _
			    "cat":"application/vnd.ms-pki.seccat", _
			    "stl":"application/vnd.ms-pki.stl", _
			    "ppt":"application/vnd.ms-powerpoint", _
			    "pps":"application/vnd.ms-powerpoint", _
			    "ppam":"application/vnd.ms-powerpoint.addin.macroenabled.12", _
			    "pptm":"application/vnd.ms-powerpoint.presentation.macroenabled.12", _
			    "sldm":"application/vnd.ms-powerpoint.slide.macroenabled.12", _
			    "ppsm":"application/vnd.ms-powerpoint.slideshow.macroenabled.12", _
			    "potm":"application/vnd.ms-powerpoint.template.macroenabled.12", _
			    "mpp":"application/vnd.ms-project", _
			    "mpt":"application/vnd.ms-project", _
			    "docm":"application/vnd.ms-word.document.macroenabled.12", _
			    "dotm":"application/vnd.ms-word.template.macroenabled.12", _
			    "wps":"application/vnd.ms-works", _
			    "wks":"application/vnd.ms-works", _
			    "wcm":"application/vnd.ms-works", _
			    "wdb":"application/vnd.ms-works", _
			    "wpl":"application/vnd.ms-wpl", _
			    "xps":"application/vnd.ms-xpsdocument", _
			    "mseq":"application/vnd.mseq", _
			    "mus":"application/vnd.musician", _
			    "msty":"application/vnd.muvee.style", _
			    "nlu":"application/vnd.neurolanguage.nlu", _
			    "nnd":"application/vnd.noblenet-directory", _
			    "nns":"application/vnd.noblenet-sealer", _
			    "nnw":"application/vnd.noblenet-web", _
			    "ngdat":"application/vnd.nokia.n-gage.data", _
			    "n-gage":"application/vnd.nokia.n-gage.symbian.install", _
			    "rpst":"application/vnd.nokia.radio-preset", _
			    "rpss":"application/vnd.nokia.radio-presets", _
			    "edm":"application/vnd.novadigm.edm", _
			    "edx":"application/vnd.novadigm.edx", _
			    "ext":"application/vnd.novadigm.ext", _
			    "odc":"application/vnd.oasis.opendocument.chart", _
			    "otc":"application/vnd.oasis.opendocument.chart-template", _
			    "odb":"application/vnd.oasis.opendocument.database", _
			    "odf":"application/vnd.oasis.opendocument.formula", _
			    "odft":"application/vnd.oasis.opendocument.formula-template", _
			    "odg":"application/vnd.oasis.opendocument.graphics", _
			    "otg":"application/vnd.oasis.opendocument.graphics-template", _
			    "odi":"application/vnd.oasis.opendocument.image", _
			    "oti":"application/vnd.oasis.opendocument.image-template", _
			    "odp":"application/vnd.oasis.opendocument.presentation", _
			    "otp":"application/vnd.oasis.opendocument.presentation-template", _
			    "ods":"application/vnd.oasis.opendocument.spreadsheet", _
			    "ots":"application/vnd.oasis.opendocument.spreadsheet-template", _
			    "odt":"application/vnd.oasis.opendocument.text", _
			    "odm":"application/vnd.oasis.opendocument.text-master", _
			    "ott":"application/vnd.oasis.opendocument.text-template", _
			    "oth":"application/vnd.oasis.opendocument.text-web", _
			    "xo":"application/vnd.olpc-sugar", _
			    "dd2":"application/vnd.oma.dd2+xml", _
			    "oxt":"application/vnd.openofficeorg.extension", _
			    "pptx":"application/vnd.openxmlformats-officedocument.presentationml.presentation", _
			    "sldx":"application/vnd.openxmlformats-officedocument.presentationml.slide", _
			    "ppsx":"application/vnd.openxmlformats-officedocument.presentationml.slideshow", _
			    "potx":"application/vnd.openxmlformats-officedocument.presentationml.template", _
			    "xlsx":"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", _
			    "xltx":"application/vnd.openxmlformats-officedocument.spreadsheetml.template", _
			    "docx":"application/vnd.openxmlformats-officedocument.wordprocessingml.document", _
			    "dotx":"application/vnd.openxmlformats-officedocument.wordprocessingml.template", _
			    "mgp":"application/vnd.osgeo.mapguide.package", _
			    "dp":"application/vnd.osgi.dp", _
			    "pdb":"application/vnd.palm", _
			    "paw":"application/vnd.pawaafile", _
			    "str":"application/vnd.pg.format", _
			    "ei6":"application/vnd.pg.osasli", _
			    "efif":"application/vnd.picsel", _
			    "wg":"application/vnd.pmi.widget", _
			    "plf":"application/vnd.pocketlearn", _
			    "pbd":"application/vnd.powerbuilder6", _
			    "box":"application/vnd.previewsystems.box", _
			    "mgz":"application/vnd.proteus.magazine", _
			    "qps":"application/vnd.publishare-delta-tree", _
			    "ptid":"application/vnd.pvi.ptid1", _
			    "qxd":"application/vnd.quark.quarkxpress", _
			    "bed":"application/vnd.realvnc.bed", _
			    "mxl":"application/vnd.recordare.musicxml", _
			    "musicxml":"application/vnd.recordare.musicxml+xml", _
			    "cryptonote":"application/vnd.rig.cryptonote", _
			    "cod":"application/vnd.rim.cod", _
			    "rm":"application/vnd.rn-realmedia", _
			    "link66":"application/vnd.route66.link66+xml", _
			    "st":"application/vnd.sailingtracker.track", _
			    "see":"application/vnd.seemail", _
			    "sema":"application/vnd.sema", _
			    "semd":"application/vnd.semd", _
			    "semf":"application/vnd.semf", _
			    "ifm":"application/vnd.shana.informed.formdata", _
			    "itp":"application/vnd.shana.informed.formtemplate", _
			    "iif":"application/vnd.shana.informed.interchange", _
			    "ipk":"application/vnd.shana.informed.package", _
			    "twd":"application/vnd.simtech-mindmapper", _
			    "mmf":"application/vnd.smaf", _
			    "teacher":"application/vnd.smart.teacher", _
			    "sdkm":"application/vnd.solent.sdkm+xml", _
			    "dxp":"application/vnd.spotfire.dxp", _
			    "sfs":"application/vnd.spotfire.sfs", _
			    "sdc":"application/vnd.stardivision.calc", _
			    "sda":"application/vnd.stardivision.draw", _
			    "sdd":"application/vnd.stardivision.impress", _
			    "smf":"application/vnd.stardivision.math", _
			    "sdw":"application/vnd.stardivision.writer", _
			    "sgl":"application/vnd.stardivision.writer-global", _
			    "sm":"application/vnd.stepmania.stepchart", _
			    "sxc":"application/vnd.sun.xml.calc", _
			    "stc":"application/vnd.sun.xml.calc.template", _
			    "sxd":"application/vnd.sun.xml.draw", _
			    "std":"application/vnd.sun.xml.draw.template", _
			    "sxi":"application/vnd.sun.xml.impress", _
			    "sti":"application/vnd.sun.xml.impress.template", _
			    "sxm":"application/vnd.sun.xml.math", _
			    "sxw":"application/vnd.sun.xml.writer", _
			    "sxg":"application/vnd.sun.xml.writer.global", _
			    "stw":"application/vnd.sun.xml.writer.template", _
			    "sus":"application/vnd.sus-calendar", _
			    "svd":"application/vnd.svd", _
			    "sis":"application/vnd.symbian.install", _
			    "xsm":"application/vnd.syncml+xml", _
			    "bdm":"application/vnd.syncml.dm+wbxml", _
			    "xdm":"application/vnd.syncml.dm+xml", _
			    "tao":"application/vnd.tao.intent-module-archive", _
			    "tmo":"application/vnd.tmobile-livetv", _
			    "tpt":"application/vnd.trid.tpt", _
			    "mxs":"application/vnd.triscape.mxs", _
			    "tra":"application/vnd.trueapp", _
			    "ufd":"application/vnd.ufdl", _
			    "utz":"application/vnd.uiq.theme", _
			    "umj":"application/vnd.umajin", _
			    "unityweb":"application/vnd.unity", _
			    "uoml":"application/vnd.uoml+xml", _
			    "vcx":"application/vnd.vcx", _
			    "vsd":"application/vnd.visio", _
			    "vis":"application/vnd.visionary", _
			    "vsf":"application/vnd.vsf", _
			    "wbxml":"application/vnd.wap.wbxml", _
			    "wmlc":"application/vnd.wap.wmlc", _
			    "wmlsc":"application/vnd.wap.wmlscriptc", _
			    "wtb":"application/vnd.webturbo", _
			    "nbp":"application/vnd.wolfram.player", _
			    "wpd":"application/vnd.wordperfect", _
			    "wqd":"application/vnd.wqd", _
			    "stf":"application/vnd.wt.stf", _
			    "xar":"application/vnd.xara", _
			    "xfdl":"application/vnd.xfdl", _
			    "hvd":"application/vnd.yamaha.hv-dic", _
			    "hvs":"application/vnd.yamaha.hv-script", _
			    "hvp":"application/vnd.yamaha.hv-voice", _
			    "osf":"application/vnd.yamaha.openscoreformat", _
			    "osfpvg":"application/vnd.yamaha.openscoreformat.osfpvg+xml", _
			    "saf":"application/vnd.yamaha.smaf-audio", _
			    "spf":"application/vnd.yamaha.smaf-phrase", _
			    "cmp":"application/vnd.yellowriver-custom-menu", _
			    "zir":"application/vnd.zul", _
			    "zaz":"application/vnd.zzazz.deck+xml", _
			    "vxml":"application/voicexml+xml", _
			    "wgt":"application/widget", _
			    "hlp":"application/winhlp", _
			    "wsdl":"application/wsdl+xml", _
			    "wspolicy":"application/wspolicy+xml", _
			    "7z":"application/x-7z-compressed", _
			    "abw":"application/x-abiword", _
			    "ace":"application/x-ace-compressed", _
			    "aab":"application/x-authorware-bin", _
			    "aam":"application/x-authorware-map", _
			    "aas":"application/x-authorware-seg", _
			    "bcpio":"application/x-bcpio", _
			    "torrent":"application/x-bittorrent", _
			    "bz":"application/x-bzip", _
			    "bz2":"application/x-bzip2", _
			    "vcd":"application/x-cdlink", _
			    "chat":"application/x-chat", _
			    "pgn":"application/x-chess-pgn", _
			    "cpio":"application/x-cpio", _
			    "csh":"application/x-csh", _
			    "deb":"application/x-debian-package", _
			    "dir":"application/x-director", _
			    "wad":"application/x-doom", _
			    "ncx":"application/x-dtbncx+xml", _
			    "dtb":"application/x-dtbook+xml", _
			    "res":"application/x-dtbresource+xml", _
			    "dvi":"application/x-dvi", _
			    "bdf":"application/x-font-bdf", _
			    "gsf":"application/x-font-ghostscript", _
			    "psf":"application/x-font-linux-psf", _
			    "otf":"application/x-font-otf", _
			    "pcf":"application/x-font-pcf", _
			    "snf":"application/x-font-snf", _
			    "ttf":"application/x-font-ttf", _
			    "pfa":"application/x-font-type1", _
			    "woff":"application/x-font-woff", _
			    "spl":"application/x-futuresplash", _
			    "gnumeric":"application/x-gnumeric", _
			    "gtar":"application/x-gtar", _
			    "hdf":"application/x-hdf", _
			    "jnlp":"application/x-java-jnlp-file", _
			    "latex":"application/x-latex", _
			    "prc":"application/x-mobipocket-ebook", _
			    "mobi":"application/x-mobipocket-ebook", _
			    "m3u8":"application/x-mpegurl", _
			    "application":"application/x-ms-application", _
			    "wmd":"application/x-ms-wmd", _
			    "wmz":"application/x-ms-wmz", _
			    "xbap":"application/x-ms-xbap", _
			    "mdb":"application/x-msaccess", _
			    "obd":"application/x-msbinder", _
			    "crd":"application/x-mscardfile", _
			    "clp":"application/x-msclip", _
			    "exe":"application/x-msdownload", _
			    "dll":"application/x-msdownload", _
			    "com":"application/x-msdownload", _
			    "bat":"application/x-msdownload", _
			    "msi":"application/x-msdownload", _
			    "mvb":"application/x-msmediaview", _
			    "wmf":"application/x-msmetafile", _
			    "mny":"application/x-msmoney", _
			    "pub":"application/x-mspublisher", _
			    "scd":"application/x-msschedule", _
			    "trm":"application/x-msterminal", _
			    "wri":"application/x-mswrite", _
			    "nc":"application/x-netcdf", _
			    "p12":"application/x-pkcs12", _
			    "p7b":"application/x-pkcs7-certificates", _
			    "p7r":"application/x-pkcs7-certreqresp", _
			    "rar":"application/x-rar-compressed", _
			    "sh":"application/x-sh", _
			    "shar":"application/x-shar", _
			    "swf":"application/x-shockwave-flash", _
			    "xap":"application/x-silverlight-app", _
			    "sit":"application/x-stuffit", _
			    "sitx":"application/x-stuffitx", _
			    "sv4cpio":"application/x-sv4cpio", _
			    "sv4crc":"application/x-sv4crc", _
			    "tar":"application/x-tar", _
			    "tcl":"application/x-tcl", _
			    "tex":"application/x-tex", _
			    "tfm":"application/x-tex-tfm", _
			    "texi":"application/x-texinfo", _
			    "texinfo":"application/x-texinfo", _
			    "ustar":"application/x-ustar", _
			    "src":"application/x-wais-source", _
			    "crt":"application/x-x509-ca-cert", _
			    "der":"application/x-x509-ca-cert", _
			    "fig":"application/x-xfig", _
			    "xpi":"application/x-xpinstall", _
			    "xdf":"application/xcap-diff+xml", _
			    "xenc":"application/xenc+xml", _
			    "xht":"application/xhtml+xml", _
			    "xhtml":"application/xhtml+xml", _
			    "xsl":"application/xml", _
			    "xml":"application/xml", _
			    "dtd":"application/xml-dtd", _
			    "xop":"application/xop+xml", _
			    "xslt":"application/xslt+xml", _
			    "xspf":"application/xspf+xml", _
			    "mxml":"application/xv+xml", _
			    "yang":"application/yang", _
			    "yin":"application/yin+xml", _
			    "zip":"application/zip", _
			    "adp":"audio/adpcm", _
			    "snd":"audio/basic", _
			    "au":"audio/basic", _
			    "midi":"audio/midi", _
			    "mid":"audio/midi", _
			    "mp4a":"audio/mp4", _
			    "m4p":"audio/mp4a-latm", _
			    "m4a":"audio/mp4a-latm", _
			    "mpga":"audio/mpeg", _
			    "mp2":"audio/mpeg", _
			    "mp2a":"audio/mpeg", _
			    "mp3":"audio/mpeg", _
			    "m2a":"audio/mpeg", _
			    "m3a":"audio/mpeg", _
			    "oga":"audio/ogg", _
			    "ogg":"audio/ogg", _
			    "spx":"audio/ogg", _
			    "weba":"audio/webm", _
			    "aac":"audio/x-aac", _
			    "aif":"audio/x-aiff", _
			    "aiff":"audio/x-aiff", _
			    "aifc":"audio/x-aiff", _
			    "m3u":"audio/x-mpegurl", _
			    "wax":"audio/x-ms-wax", _
			    "wma":"audio/x-ms-wma", _
			    "ram":"audio/x-pn-realaudio", _
			    "ra":"audio/x-pn-realaudio", _
			    "rmp":"audio/x-pn-realaudio-plugin", _
			    "wav":"audio/x-wav", _
			    "cdx":"chemical/x-cdx", _
			    "cif":"chemical/x-cif", _
			    "cmdf":"chemical/x-cmdf", _
			    "cml":"chemical/x-cml", _
			    "csml":"chemical/x-csml", _
			    "xyz":"chemical/x-xyz", _
			    "bmp":"image/bmp", _
			    "cgm":"image/cgm", _
			    "g3":"image/g3fax", _
			    "gif":"image/gif", _
			    "ief":"image/ief", _
			    "jp2":"image/jp2", _
			    "jpeg":"image/jpeg", _
			    "jpg":"image/jpeg", _
			    "jpe":"image/jpeg", _
			    "ktx":"image/ktx", _
			    "pict":"image/pict", _
			    "pic":"image/pict", _
			    "pct":"image/pict", _
			    "png":"image/png", _
			    "btif":"image/prs.btif", _
			    "svg":"image/svg+xml", _
			    "tiff":"image/tiff", _
			    "tiff":"image/tiff", _
			    "psd":"image/vnd.adobe.photoshop", _
			    "uvi":"image/vnd.dece.graphic", _
			    "sub":"image/vnd.dvb.subtitle", _
			    "djvu":"image/vnd.djvu", _
			    "dwg":"image/vnd.dwg", _
			    "dxf":"image/vnd.dxf", _
			    "fbs":"image/vnd.fastbidsheet", _
			    "fpx":"image/vnd.fpx", _
			    "fst":"image/vnd.fst", _
			    "mmr":"image/vnd.fujixerox.edmics-mmr", _
			    "rlc":"image/vnd.fujixerox.edmics-rlc", _
			    "mdi":"image/vnd.ms-modi", _
			    "npx":"image/vnd.net-fpx", _
			    "wbmp":"image/vnd.wap.wbmp", _
			    "xif":"image/vnd.xiff", _
			    "webp":"image/webp", _
			    "ras":"image/x-cmu-raster", _
			    "cmx":"image/x-cmx", _
			    "fh":"image/x-freehand", _
			    "ico":"image/x-icon", _
			    "pntg":"image/x-macpaint", _
			    "pnt":"image/x-macpaint", _
			    "mac":"image/x-macpaint", _
			    "pcx":"image/x-pcx", _
			    "pdf":"application/pdf", _
			    "pnm":"image/x-portable-anymap", _
			    "pbm":"image/x-portable-bitmap", _
			    "pgm":"image/x-portable-graymap", _
			    "ppm":"image/x-portable-pixmap", _
			    "qti":"image/x-quicktime", _
			    "qtif":"image/x-quicktime", _
			    "rgb":"image/x-rgb", _
			    "xbm":"image/x-xbitmap", _
			    "xpm":"image/x-xpixmap", _
			    "xwd":"image/x-xwindowdump", _
			    "mime":"message/rfc822", _
			    "eml":"message/rfc822", _
			    "igs":"model/iges", _
			    "msh":"model/mesh", _
			    "dae":"model/vnd.collada+xml", _
			    "dwf":"model/vnd.dwf", _
			    "gdl":"model/vnd.gdl", _
			    "gtw":"model/vnd.gtw", _
			    "mts":"model/vnd.mts", _
			    "vtu":"model/vnd.vtu", _
			    "vrml":"model/vrml", _
			    "manifest":"text/cache-manifest", _
			    "ics":"text/calendar", _
			    "css":"text/css", _
			    "csv":"text/csv", _
			    "html":"text/html", _
			    "htm":"text/html", _
			    "bs":"text/html", _
			    "n3":"text/n3", _
			    "txt":"text/plain", _
			    "text":"text/plain", _
			    "conf":"text/plain", _
			    "def":"text/plain", _
			    "list":"text/plain", _
			    "log":"text/plain", _
			    "in":"text/plain", _
			    "md":"text/plain", _
			    "dsc":"text/prs.lines.tag", _
			    "rtx":"text/richtext", _
			    "sgml":"text/sgml", _
			    "tsv":"text/tab-separated-values", _
			    "t":"text/troff", _
			    "tr":"text/troff", _
			    "roff":"text/troff", _
			    "ttl":"text/turtle", _
			    "uri":"text/uri-list", _
			    "uris":"text/uri-list", _
			    "urls":"text/uri-list", _
			    "curl":"text/vnd.curl", _
			    "dcurl":"text/vnd.curl.dcurl", _
			    "scurl":"text/vnd.curl.scurl", _
			    "mcurl":"text/vnd.curl.mcurl", _
			    "fly":"text/vnd.fly", _
			    "flx":"text/vnd.fmi.flexstor", _
			    "gv":"text/vnd.graphviz", _
			    "3dml":"text/vnd.in3d.3dml", _
			    "spot":"text/vnd.in3d.spot", _
			    "jad":"text/vnd.sun.j2me.app-descriptor", _
			    "wml":"text/vnd.wap.wml", _
			    "wmls":"text/vnd.wap.wmlscript", _
			    "asm":"text/x-asm", _
			    "c":"text/x-c", _
			    "cc":"text/x-c", _
			    "cxx":"text/x-c", _
			    "cpp":"text/x-c", _
			    "h":"text/x-c", _
			    "pas":"text/x-pascal", _
			    "java":"text/x-java-source", _
			    "etx":"text/x-setext", _
			    "uu":"text/x-uuencode", _
			    "vcs":"text/x-vcalendar", _
			    "vcf":"text/x-vcard", _
			    "3gp":"video/3gpp", _
			    "3g2":"video/3gpp2", _
			    "h261":"video/h261", _
			    "h263":"video/h263", _
			    "h264":"video/h264", _
			    "jpgv":"video/jpeg", _
			    "jpm":"video/jpm", _
			    "mj2":"video/mj2", _
			    "ts":"video/mp2t", _
			    "mp4":"video/mp4", _
			    "mp4v":"video/mp4", _
			    "mpg4":"video/mp4", _
			    "m4v":"video/mp4", _
			    "mpeg":"video/mpeg", _
			    "mpg":"video/mpeg", _
			    "mpe":"video/mpeg", _
			    "m1v":"video/mpeg", _
			    "m2v":"video/mpeg", _
			    "ogv":"video/ogg", _
			    "mov":"video/quicktime", _
			    "qt":"video/quicktime", _
			    "uvh":"video/vnd.dece.hd", _
			    "uvm":"video/vnd.dece.mobile", _
			    "uvp":"video/vnd.dece.pd", _
			    "uvs":"video/vnd.dece.sd", _
			    "uvv":"video/vnd.dece.video", _
			    "fvt":"video/vnd.fvt", _
			    "mxu":"video/vnd.mpegurl", _
			    "pyv":"video/vnd.ms-playready.media.pyv", _
			    "uvu":"video/vnd.uvvu.mp4", _
			    "viv":"video/vnd.vivo", _
			    "dif":"video/x-dv", _
			    "dv":"video/x-dv", _
			    "webm":"video/webm", _
			    "f4v":"video/x-f4v", _
			    "fli":"video/x-fli", _
			    "flv":"video/x-flv", _
			    "m4v":"video/x-m4v", _
			    "rbp":"application/x-REALbasic-Project", _
			    "rbbas":"application/x-REALbasic-Project", _
			    "rbvcp":"application/x-REALbasic-Project", _
			    "rbo":"application/x-REALbasic-Project", _
			    "asx":"video/x-ms-asf", _
			    "asf":"video/x-ms-asf", _
			    "wm":"video/x-ms-wm", _
			    "wmv":"video/x-ms-wmv", _
			    "wmx":"video/x-ms-wmx", _
			    "wvx":"video/x-ms-wvx", _
			    "avi":"video/x-msvideo", _
			    "movie":"video/x-sgi-movie", _
			    "ice":"x-conference/x-cooltalk")
			  End If
			  return mMIMETypes
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mMIMETypes = value
			End Set
		#tag EndSetter
		Protected Shared MIMETypes As Dictionary
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared mMIMETypes As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		SubType As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SuperType As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Optional; a number between 0.0 and 1.0 representing the weight of the type (1=highest weight)
		#tag EndNote
		Weight As Single = 1.0
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Boundary"
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
			Name="SubType"
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
			Name="SuperType"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Weight"
			Group="Behavior"
			InitialValue="1.0"
			Type="Single"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
