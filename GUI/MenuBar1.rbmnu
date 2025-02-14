#tag Menu
Begin Menu MenuBar1
   Begin MenuItem FileMenu
      SpecialMenu = 0
      Text = "&Tools"
      Index = -2147483648
      AutoEnable = True
      Begin MenuItem RescanMenu
         SpecialMenu = 0
         Text = "&Request Rescan 🔒"
         Index = -2147483648
         ShortcutKey = "R"
         Shortcut = "Cmd+R"
         MenuModifier = True
         AutoEnable = True
      End
      Begin MenuItem exportmenu
         SpecialMenu = 0
         Text = "&Save report"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Begin MenuItem textmenu
            SpecialMenu = 0
            Text = "As &Text"
            Index = -2147483648
            AutoEnable = True
         End
         Begin MenuItem csvmenu
            SpecialMenu = 0
            Text = "As &CSV"
            Index = -2147483648
            AutoEnable = True
         End
         Begin MenuItem jsonmenu
            SpecialMenu = 0
            Text = "As original &JSON"
            Index = -2147483648
            AutoEnable = True
         End
         Begin MenuItem unpackedmenu
            SpecialMenu = 0
            Text = "As &unpacked JSON"
            Index = -2147483648
            AutoEnable = True
         End
      End
      Begin MenuItem tridmenu
         SpecialMenu = 0
         Text = "Analyze with &TrID..."
         Index = -2147483648
         ShortcutKey = "T"
         Shortcut = "Cmd+T"
         MenuModifier = True
         AutoEnable = True
      End
      Begin MenuItem OpenFileMenu
         SpecialMenu = 0
         Text = "R&un target file"
         Index = -2147483648
         ShortcutKey = "K"
         Shortcut = "Cmd+K"
         MenuModifier = True
         AutoEnable = True
      End
      Begin MenuItem SettsMenu
         SpecialMenu = 0
         Text = "&Settings..."
         Index = -2147483648
         AutoEnable = True
      End
      Begin MenuItem AboutMenu
         SpecialMenu = 0
         Text = "&About..."
         Index = -2147483648
         AutoEnable = True
      End
   End
End
#tag EndMenu
