#tag Menu
Begin Menu MenuBar1
   Begin MenuItem FileMenu
      SpecialMenu = 0
      Text = "&Tools"
      Index = -2147483648
      AutoEnable = True
      Begin MenuItem exportmenu
         SpecialMenu = 0
         Text = "Export Results"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Begin MenuItem textmenu
            SpecialMenu = 0
            Text = "Text"
            Index = -2147483648
            AutoEnable = True
         End
         Begin MenuItem csvmenu
            SpecialMenu = 0
            Text = "CSV"
            Index = -2147483648
            AutoEnable = True
         End
         Begin MenuItem jsonmenu
            SpecialMenu = 0
            Text = "Original JSON"
            Index = -2147483648
            AutoEnable = True
         End
         Begin MenuItem unpackedmenu
            SpecialMenu = 0
            Text = "Unpacked JSON"
            Index = -2147483648
            AutoEnable = True
         End
      End
      Begin MenuItem tridmenu
         SpecialMenu = 0
         Text = "Analyze with TrID..."
         Index = -2147483648
         AutoEnable = True
      End
   End
End
#tag EndMenu
