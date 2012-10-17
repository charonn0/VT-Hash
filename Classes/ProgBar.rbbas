#tag Class
Protected Class ProgBar
Inherits Canvas
	#tag Event
		Sub Paint(g As Graphics)
		  //Repaints the canvas
		  //This event fires whenever the control has been painted by something other than itself
		  //calculates and draws a new buffer with val=0 or recalculates the old buffer and paints it, or simply repaints the old buffer
		  
		  Static myHeight As Integer
		  Static mywidth As Integer
		  
		  If mywidth <> Me.Width Or myHeight <> Me.Height Then
		    drawingBuffer = New Picture(Me.Width, Me.Height, 24)
		    Me.Value = mvalue
		  Else
		    g.DrawPicture(drawingBuffer, 0, 0)
		  End If
		  mywidth = Me.Width
		  myHeight = Me.Height
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub drawBar(filledWidth As Integer)
		  //Draws the actual progress bar part of the control
		  If mValue >= 80 Then
		    mbarColor = &cFF0000
		    mgradientEnd = &c800000
		  ElseIf mValue >= 60 Then
		    mbarColor = &cFF8000
		    mgradientEnd = &c804000
		  ElseIf mValue >= 30 Then
		    mbarColor = &cFFFF00
		    mgradientEnd = &c808000
		  ElseIf mValue > 0 Then
		    mbarColor = &c1EA6F7
		    mgradientEnd = &c0000FF
		  Else
		    mbarColor = &c00FF00
		    mgradientEnd = &c004000
		  End If
		  
		  Dim myHeight, myWidth As Integer
		  myHeight = Me.Height
		  myWidth = Me.Width
		  
		  If hasGradient Then
		    Dim ratio, endratio as Double
		    For i As Integer = 0 To drawingBuffer.Height
		      ratio = ((drawingBuffer.Height - i) / drawingBuffer.Height)
		      endratio = (i / drawingBuffer.Height)
		      drawingBuffer.Graphics.ForeColor = RGB(gradientEnd.Red * endratio + barColor.Red * ratio, gradientEnd.Green * endratio + barColor.Green * ratio, _
		      gradientEnd.Blue * endratio + barColor.Blue * ratio)
		      drawingBuffer.Graphics.DrawLine(0, i, filledWidth, i)
		    next
		    drawingBuffer.Graphics.ForeColor = barColor
		    drawingBuffer.Graphics.DrawLine(0, 0, filledWidth, 0)
		  Else
		    drawingBuffer.Graphics.ForeColor = barColor
		    drawingBuffer.Graphics.FillRect(0, 0, filledWidth, myHeight)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub drawBarwell()
		  //Draws the background of the control
		  
		  Dim myHeight, myWidth As Integer
		  myHeight = Me.Height
		  myWidth = Me.Width
		  If barWell = &cFFFFFF Then
		    drawingBuffer.Graphics.ForeColor = &cFFFFFE
		  Else
		    drawingBuffer.Graphics.ForeColor = barWell
		  End If
		  
		  drawingBuffer.Graphics.FillRect(0, 0, myWidth, myHeight)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub drawBox()
		  //Draws the outline of the control if hasBox = True
		  Dim myHeight, myWidth As Integer
		  myHeight = Me.Height
		  myWidth = Me.Width
		  drawingBuffer.Graphics.ForeColor = boxColor
		  drawingBuffer.Graphics.DrawRect(0, 0, myWidth, myHeight)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub drawText()
		  //Draws the text, if hasText = True
		  Dim percStr As String
		  drawingBuffer.Graphics.TextSize = 10
		  percStr = Me.Text'Format((Me.Value*100) / Me.maximum, textFormat)
		  drawingBuffer.Graphics.Bold = (mvalue > 80)
		  drawingBuffer.Graphics.Italic = italic
		  drawingBuffer.Graphics.Underline = underline
		  drawingBuffer.Graphics.TextFont = textFont
		  drawingBuffer.Graphics.ForeColor = textColor
		  drawingBuffer.Graphics.TextSize = textSize
		  Dim strWidth, strHeight As Integer
		  strWidth = drawingBuffer.Graphics.StringWidth(percStr)
		  strHeight = drawingBuffer.Graphics.StringHeight(percStr, Me.Width)
		  drawingBuffer.Graphics.DrawString(percStr, (Me.Width/2) - (strWidth/2), ((Me.Height/2) + (strHeight/4)))
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		
		GNU LESSER GENERAL PUBLIC LICENSE
		
		Version 3, 29 June 2007
		
		Copyright © 2007 Free Software Foundation, Inc. <http://fsf.org/>
		
		Everyone is permitted to copy and distribute verbatim copies of this license document, but changing it is not allowed.
		
		This version of the GNU Lesser General Public License incorporates the terms and conditions of version 3 of the GNU General Public License, supplemented by the additional permissions listed below.
		0. Additional Definitions.
		
		As used herein, “this License” refers to version 3 of the GNU Lesser General Public License, and the “GNU GPL” refers to version 3 of the GNU General Public License.
		
		“The Library” refers to a covered work governed by this License, other than an Application or a Combined Work as defined below.
		
		An “Application” is any work that makes use of an interface provided by the Library, but which is not otherwise based on the Library. Defining a subclass of a class defined by the Library is deemed a mode of using an interface provided by the Library.
		
		A “Combined Work” is a work produced by combining or linking an Application with the Library. The particular version of the Library with which the Combined Work was made is also called the “Linked Version”.
		
		The “Minimal Corresponding Source” for a Combined Work means the Corresponding Source for the Combined Work, excluding any source code for portions of the Combined Work that, considered in isolation, are based on the Application, and not on the Linked Version.
		
		The “Corresponding Application Code” for a Combined Work means the object code and/or source code for the Application, including any data and utility programs needed for reproducing the Combined Work from the Application, but excluding the System Libraries of the Combined Work.
		1. Exception to Section 3 of the GNU GPL.
		
		You may convey a covered work under sections 3 and 4 of this License without being bound by section 3 of the GNU GPL.
		2. Conveying Modified Versions.
		
		If you modify a copy of the Library, and, in your modifications, a facility refers to a function or data to be supplied by an Application that uses the facility (other than as an argument passed when the facility is invoked), then you may convey a copy of the modified version:
		
		    a) under this License, provided that you make a good faith effort to ensure that, in the event an Application does not supply the function or data, the facility still operates, and performs whatever part of its purpose remains meaningful, or
		    b) under the GNU GPL, with none of the additional permissions of this License applicable to that copy.
		
		3. Object Code Incorporating Material from Library Header Files.
		
		The object code form of an Application may incorporate material from a header file that is part of the Library. You may convey such object code under terms of your choice, provided that, if the incorporated material is not limited to numerical parameters, data structure layouts and accessors, or small macros, inline functions and templates (ten or fewer lines in length), you do both of the following:
		
		    a) Give prominent notice with each copy of the object code that the Library is used in it and that the Library and its use are covered by this License.
		    b) Accompany the object code with a copy of the GNU GPL and this license document.
		
		4. Combined Works.
		
		You may convey a Combined Work under terms of your choice that, taken together, effectively do not restrict modification of the portions of the Library contained in the Combined Work and reverse engineering for debugging such modifications, if you also do each of the following:
		
		    a) Give prominent notice with each copy of the Combined Work that the Library is used in it and that the Library and its use are covered by this License.
		    b) Accompany the Combined Work with a copy of the GNU GPL and this license document.
		    c) For a Combined Work that displays copyright notices during execution, include the copyright notice for the Library among these notices, as well as a reference directing the user to the copies of the GNU GPL and this license document.
		    d) Do one of the following:
		        0) Convey the Minimal Corresponding Source under the terms of this License, and the Corresponding Application Code in a form suitable for, and under terms that permit, the user to recombine or relink the Application with a modified version of the Linked Version to produce a modified Combined Work, in the manner specified by section 6 of the GNU GPL for conveying Corresponding Source.
		        1) Use a suitable shared library mechanism for linking with the Library. A suitable mechanism is one that (a) uses at run time a copy of the Library already present on the user's computer system, and (b) will operate properly with a modified version of the Library that is interface-compatible with the Linked Version.
		    e) Provide Installation Information, but only if you would otherwise be required to provide such information under section 6 of the GNU GPL, and only to the extent that such information is necessary to install and execute a modified version of the Combined Work produced by recombining or relinking the Application with a modified version of the Linked Version. (If you use option 4d0, the Installation Information must accompany the Minimal Corresponding Source and Corresponding Application Code. If you use option 4d1, you must provide the Installation Information in the manner specified by section 6 of the GNU GPL for conveying Corresponding Source.)
		
		5. Combined Libraries.
		
		You may place library facilities that are a work based on the Library side by side in a single library together with other library facilities that are not Applications and are not covered by this License, and convey such a combined library under terms of your choice, if you do both of the following:
		
		    a) Accompany the combined library with a copy of the same work based on the Library, uncombined with any other library facilities, conveyed under the terms of this License.
		    b) Give prominent notice with the combined library that part of it is a work based on the Library, and explaining where to find the accompanying uncombined form of the same work.
		
		6. Revised Versions of the GNU Lesser General Public License.
		
		The Free Software Foundation may publish revised and/or new versions of the GNU Lesser General Public License from time to time. Such new versions will be similar in spirit to the present version, but may differ in detail to address new problems or concerns.
		
		Each version is given a distinguishing version number. If the Library as you received it specifies that a certain numbered version of the GNU Lesser General Public License “or any later version” applies to it, you have the option of following the terms and conditions either of that published version or of any later version published by the Free Software Foundation. If the Library as you received it does not specify a version number of the GNU Lesser General Public License, you may choose any version of the GNU Lesser General Public License ever published by the Free Software Foundation.
		
		If the Library as you received it specifies that a proxy can decide whether future versions of the GNU Lesser General Public License shall apply, that proxy's public statement of acceptance of any version is permanent authorization for you to choose that version for the Library.
	#tag EndNote

	#tag Note, Name = Using
		
		To use this control, import it into your RealBasic project. This will add a new control to the Controls pane called "ProgBar"
		Add a ProgBar control to the window and change the default settings in the properties pane, if desired.
		
		This control is intended as a drop-in replacement of the standard ProgressBar control. Set and read its maximum and value in the same manner 
		as a ProgressBar control:
		
		 Dim x As Integer = ProgBar.value
		 Dim x As Integer = ProgBar.maximum
		
		 ProgBar.value = x
		 ProgBar.maximum = x
		
		
		  Boolean values (set/get):
		    *bold
		       True=Text is bold
		       False=Text is not bold
		
		    *italic
		       True=Text is italicized
		       False=Text is not italicized
		
		    *underline
		       True=Text is underlined
		       False=Text is not underlined
		
		    *hasBox
		       True=A border is drawn around the Control
		       False=No border
		
		    *hasGradient
		       True=The bar is drawn as a gradient from barColor to gradientEnd
		       False=The bar is a solid bar of barColor
		
		    *hasText
		       True=A string representation of the control's percent full is drawn in the center of the control
		       False=No text is drawn
		
		  Integer values (set/get):
		    *maximum
		       get or set the maximum value of the ProgBar (minimum is always zero)
		
		    *textSize
		       get or set the point size of the text (see: hasText As Boolean)
		
		    *value
		       get or set the current value of the ProgBar.
		
		  Color values (set/get):
		    *barColor
		       get or set the main color of the foreground bar (the part that shows how "full" the ProgBar is)
		
		    *barWell
		       get or set the color of the background 
		
		    *boxColor
		       get or set the color of the border around the control (if hasBox = True)
		
		    *gradientEnd
		       get or set the ending (bottom) color of the foreground bar if hasGradient = true
		
		    *textColor
		       get or set the color of the percent string if hasText = True
		
		  String values (set/get):
		    *textFont
		       get or set the font of the percent text is hasText = True
		
		    *textFormat
		       get or set the format of the percent text if hasText = True  (see: http://docs.realsoftware.com/index.php/Format)
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mbarColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mbarColor = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		barColor As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mbarWell
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mbarWell = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		barWell As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mbold
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mbold = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		bold As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mboxColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mboxColor = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		boxColor As Color
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private drawingBuffer As Picture
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mgradientEnd
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mgradientEnd = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		gradientEnd As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mhasBox
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mhasBox = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		hasBox As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mhasGradient
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mhasGradient = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		hasGradient As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mhasText
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mhasText = value
			  Me.value = Me.value
			End Set
		#tag EndSetter
		hasText As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mitalic
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mitalic = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		italic As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mmaximum
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mmaximum = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		maximum As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mbarColor As Color = &c808080
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mbarWell As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mbold As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mboxColor As Color = &c808080
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mgradientEnd As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mhasBox As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mhasGradient As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mhasText As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mitalic As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mmaximum As Integer = 100
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mtextColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mtextFont As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mtextFormat As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mtextSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private munderline As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mvalue As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Text As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mtextColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mtextColor = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		textColor As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mtextFont
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mtextFont = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		textFont As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mtextFormat
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mtextFormat = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		textFormat As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mtextSize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mtextSize = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		textSize As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return munderline
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  munderline = value
			  Me.Value = Me.Value
			End Set
		#tag EndSetter
		underline As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mvalue
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  //Calculates x, where x/Control.Width = val/maximum
			  //Invokes the drawing methods
			  #pragma BreakOnExceptions Off
			  mvalue = value
			  If mvalue > maximum Then mvalue = maximum
			  Dim filledWidth As Integer = (((value * 100) / maximum) * (Me.Width / 100))
			  
			  If drawingBuffer = Nil Then
			    drawingBuffer = New Picture(Me.Width, Me.Height, 24)
			  End If
			  drawBarwell()
			  drawBar(filledWidth)
			  If hasBox Then drawBox()
			  If hasText Then drawText()
			  Refresh(False)
			  
			  Exception
			    mvalue = value
			End Set
		#tag EndSetter
		value As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AcceptFocus"
			Visible=true
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AcceptTabs"
			Visible=true
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Group="Appearance"
			Type="Picture"
			EditorType="Picture"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="barColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c00FF00"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="barWell"
			Visible=true
			Group="Behavior"
			InitialValue="&cC0C0C0"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="bold"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="boxColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EraseBackground"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="gradientEnd"
			Visible=true
			Group="Behavior"
			InitialValue="&c009B4E"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hasBox"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hasGradient"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hasText"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="25"
			Type="Integer"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Initial State"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="italic"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="maximum"
			Visible=true
			Group="Behavior"
			InitialValue="100"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Text"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="textColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="textFont"
			Visible=true
			Group="Behavior"
			InitialValue="System"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="textFormat"
			Visible=true
			Group="Behavior"
			InitialValue="###.0\\%"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="textSize"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="underline"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="value"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="Canvas"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			InheritedFrom="Canvas"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
