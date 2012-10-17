#tag Class
Protected Class HintTextField
Inherits TextField
	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  If Not HasText Then
		    Me.TextColor = &c000000
		    Me.Italic = False
		  End If
		  
		  RaiseEvent DropObject(Obj, action)
		End Sub
	#tag EndEvent

	#tag Event
		Function KeyDown(Key As String) As Boolean
		  If Not HasText Then
		    Me.TextColor = &c000000
		    Me.Italic = False
		    Me.Text = ""
		  End If
		  Return RaiseEvent KeyDown(Key) Or False
		End Function
	#tag EndEvent

	#tag Event
		Sub LostFocus()
		  If Not HasText Or Me.Text = "" Then
		    Me.TextColor = &c838383
		    Me.Text = HintText
		    Me.Italic = True
		  Else
		    Me.TextColor = &c000000
		    Me.Italic = False
		  End If
		  LostFocus()
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  If Not HasText Then
		    Me.TextColor = &c000000
		    Me.Text = ""
		    Me.Italic = False
		  End If
		  Return (False Or MouseDown(X, Y))
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  Me.TextColor = &c838383
		  Me.Text = HintText
		  Me.Italic = True
		  Open()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub SetText(Text As String)
		  Me.TextColor = &c000000
		  Me.Italic = False
		  Me.Text = Text
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DropObject(Obj As DragItem, action As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event KeyDown(Key As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LostFocus()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDown(X As Integer, Y As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Me.Text <> Me.HintText
			End Get
		#tag EndGetter
		HasText As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		HintText As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AcceptTabs"
			Visible=true
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Alignment"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			InheritedFrom="TextField"
			#tag EnumValues
				"0 - Default"
				"1 - Left"
				"2 - Center"
				"3 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutomaticallyCheckSpelling"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackColor"
			Visible=true
			Group="Appearance"
			InitialValue="&hFFFFFF"
			Type="Color"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Border"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CueText"
			Visible=true
			Group="Initial State"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataField"
			Visible=true
			Group="Database Binding"
			Type="String"
			EditorType="DataField"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataSource"
			Visible=true
			Group="Database Binding"
			Type="String"
			EditorType="DataSource"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Format"
			Visible=true
			Group="Appearance"
			Type="String"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasText"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="22"
			Type="Integer"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HintText"
			Visible=true
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LimitText"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mask"
			Visible=true
			Group="Behavior"
			Type="String"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Password"
			Visible=true
			Group="Appearance"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReadOnly"
			Visible=true
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Text"
			Visible=true
			Group="Initial State"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextColor"
			Visible=true
			Group="Appearance"
			InitialValue="&h000000"
			Type="Color"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextFont"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			InheritedFrom="TextField"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="80"
			Type="Integer"
			InheritedFrom="TextField"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
