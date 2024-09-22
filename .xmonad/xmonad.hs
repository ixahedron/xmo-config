import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.Magnifier


modKey = mod4Mask

myTerminal = "urxvt"
xmobar = "xmobar"

myWorkspaces = ["1:term","2:code","3:web","4:media","5:", "6:music", "7:graphics", "8:", "9:messaging"]

bordWidth = 1
normColour = "#cccccc"
bordColour = "#cd8b00"

addKeyBindings = [ ((controlMask, xK_Print), spawn "escrotum")
                 , ((0, xK_Print), spawn "sleep 0.2; escrotum -s")
                 , ((0, 0x1008ff03), spawn "brightnessctl -c backlight s 10%-")
                 , ((0, 0x1008ff02), spawn "brightnessctl -c backlight s 10%+")
                 , ((0, 0x1008ff11), spawn "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-")
                 , ((0, 0x1008ff12), spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
                 , ((0, 0x1008ff13), spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+")
--                 , ((mod4Mask .|. controlMask              , xK_plus ), sendMessage MagnifyMore)
--                 , ((mod4Mask .|. controlMask              , xK_minus), sendMessage MagnifyLess)
--                 , ((mod4Mask .|. controlMask              , xK_o    ), sendMessage ToggleOff  )
--                 , ((mod4Mask .|. controlMask .|. shiftMask, xK_o    ), sendMessage ToggleOn   )
--                 , ((mod4Mask .|. controlMask              , xK_m    ), sendMessage Toggle     )
                 ]

magnifyLayout = magnifier (Tall 1 (3/100) (1/2))

-------------------------

main = do
  xmproc <- spawnPipe xmobar
  xmonad $ ewmhFullscreen $ ewmh $ docks def
      { manageHook         = manageDocks <+> manageHook def
      , layoutHook         = avoidStruts $ layoutHook def --{layoutHook = magnifyLayout}
      , terminal           = myTerminal
      , modMask            = modKey
      , workspaces         = myWorkspaces
      , borderWidth        = bordWidth
      , normalBorderColor  = normColour
      , focusedBorderColor = bordColour
      } `additionalKeys` addKeyBindings


