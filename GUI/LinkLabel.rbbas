#tag Class
Protected Class LinkLabel
Inherits Label
	#tag CompatibilityFlags = TargetHasGUI
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  If Not IsContextualClick Then
		    Return RaiseEvent MouseDown(X, Y) Or True
		  Else
		    Return False
		  End If
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  If Draggable Then
		    If Not RaiseEvent CancelDrag Then
		      Dim p As Picture = TextToPicture(Me.Text)
		      p.Transparent = 1
		      Dim tmp As New Picture(Me.Width, Me.Height, 32)
		      Me.TrueWindow.DrawInto(tmp.Graphics, Me.Top, Me.Left)
		      
		      tmp.Graphics.DrawPicture(p, 0, 0)
		      tmp.Transparent = 1
		      p = tmp
		      p.Transparent = 1
		      Dim obj As New DragItem(Me.TrueWindow, Me.Window.MouseX, Me.Window.MouseY, p.Width, p.Height, p)
		      obj.Text = Me.URL
		      
		      'obj.MouseCursor = System.Cursors.HandClosed
		      'obj.FolderItem = CreateURLShortcut(Me.Text, Me.URL)
		      RaiseEvent CreateDragItem(obj)
		      If obj = Nil Then Return
		      obj.Drag
		    End If
		  End If
		  RaiseEvent MouseDrag(X, Y)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  HoverTimer.Mode = Timer.ModeSingle
		  Me.HelpTag = AltText
		  Me.mousecursor = System.Cursors.FingerPointer
		  Me.Underline = True
		  RaiseEvent MouseEnter
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  HoverTimer.Mode = Timer.ModeOff
		  Me.mousecursor = System.Cursors.StandardPointer
		  Me.Underline = False
		  RaiseEvent MouseExit
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  If HoverTimer <> Nil And HoverTimer.Mode <> Timer.ModeOff Then HoverTimer.Reset()
		  RaiseEvent MouseMove(X, Y)
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If (Me.Left < Me.Window.MouseX) And (Me.Window.MouseX < Me.Left + Me.Width) And (Me.Top < Me.Window.Mousey) And (Me.Window.Mousey < Me.Top + Me.height) Then
		    Me.TextColor = ActiveColor
		    RaiseEvent Action()
		    colorTimer.Mode = Timer.ModeSingle
		  End If
		  RaiseEvent MouseUp(X, Y)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  colorTimer = New Timer
		  AddHandler colorTimer.Action, AddressOf colorHandler
		  colorTimer.Period = ResetPeriod
		  
		  HoverTimer = New Timer
		  AddHandler HoverTimer.Action, AddressOf HoverHandler
		  HoverTimer.Period = HoverPeriod
		  
		  BaseColor = Me.TextColor
		  RaiseEvent Open()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub colorHandler(Sender As Timer)
		  #pragma Unused Sender
		  Me.TextColor = BaseColor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HoverHandler(Sender As Timer)
		  Sender.Mode = Timer.ModeOff
		  RaiseEvent Hover
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TextToPicture(Text As String) As Picture
		  Dim lines() As Picture
		  Dim requiredHeight, requiredWidth As Integer
		  Dim tlines() As String = Split(Text, EndOfLine)
		  
		  For i As Integer = 0 To UBound(tlines)
		    Try
		      Dim p As New Picture(250, 250, 24)
		      p.Graphics.TextFont = Me.TextFont
		      p.Graphics.TextSize = Me.TextSize
		      Dim nm As String = tlines(i)
		      Dim strWidth, strHeight As Integer
		      strWidth = p.Graphics.StringWidth(nm) + 5
		      strHeight = p.Graphics.StringHeight(nm, strWidth)
		      p = New Picture(strWidth, strHeight, 32)
		      p.Graphics.AntiAlias = True
		      p.Graphics.ForeColor = Me.BaseColor
		      p.Graphics.TextFont = Me.TextFont
		      p.Graphics.TextSize = Me.TextSize
		      p.Graphics.DrawString(nm, 1, ((p.Height/2) + (strHeight/4)))
		      p.Graphics.ForeColor = &cFFFFFF
		      p.Graphics.DrawRect(1, 1, p.Width - 1, p.Height - 1)
		      lines.Append(p)
		      requiredHeight = requiredHeight + p.Height
		      If p.Width > requiredWidth Then requiredWidth = p.Width
		    Catch NilObjectException
		      Continue
		    End Try
		  Next
		  Dim txtBuffer As Picture
		  txtBuffer = New Picture(requiredWidth, requiredHeight, 24)
		  Dim x, y As Integer
		  For i As Integer = 0 To UBound(lines)
		    txtBuffer.Graphics.DrawPicture(lines(i), x, y)
		    y = y + lines(i).Height
		  Next
		  txtBuffer.Graphics.ForeColor = &cFFFFFF
		  txtBuffer.Graphics.DrawRect(0, 0, txtBuffer.Width - 1, txtBuffer.Height - 1)
		  txtBuffer.Transparent = 1
		  Return txtBuffer
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Action()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CancelDrag() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CreateDragItem(ByRef Obj As DragItem)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Hover()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDown(X As Integer, Y As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDrag(X As Integer, Y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseEnter()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseExit()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseMove(X As Integer, Y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseUp(X As Integer, Y As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h0
		ActiveColor As Color = &cFF0000
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mAltText = "" Then Return Me.URL
			  return mAltText
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mAltText = value
			End Set
		#tag EndSetter
		AltText As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private BaseColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private colorTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h0
		Draggable As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		HilightColor As Color = &c00FFFF
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The period in milliseconds (1000 = 1 second) after which the mouse
			pointer is considered to be hovering. The default is 250 (qurarter second)
			
			If the user moves the mouse pointer into the label and leaves it there
			for this period of time then the Hover() Event is raised.
		#tag EndNote
		HoverPeriod As Integer = 250
	#tag EndProperty

	#tag Property, Flags = &h21
		Private HoverTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAltText As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ResetPeriod As Integer = 1000
	#tag EndProperty

	#tag Property, Flags = &h0
		URL As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextAlignment"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="TextAlignments"
			EditorType="Enum"
			#tag EnumValues
				"0 - Left"
				"2 - Center"
				"3 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActiveColor"
			Visible=true
			Group="Behavior"
			InitialValue="&cFF0000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AltText"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataField"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataSource"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Draggable"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="20"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HilightColor"
			Visible=true
			Group="Behavior"
			InitialValue="&c00FFFF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverPeriod"
			Visible=true
			Group="Behavior"
			InitialValue="250"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Initial State"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Multiline"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ResetPeriod"
			Visible=true
			Group="Behavior"
			InitialValue="1000"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Selectable"
			Visible=false
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Text"
			Visible=true
			Group="Appearance"
			InitialValue="Untitled"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextColor"
			Visible=true
			Group="Appearance"
			InitialValue="&c0000FF"
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=false
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="URL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
