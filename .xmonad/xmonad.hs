import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.Magnifier


modKey = mod4Mask

myTerminal = "urxvt"
xmobar = "xmobar"

myWorkspaces = ["1:term","2:web","3:code","4:media","5:ssh", "6", "7:graphics", "8", "9:music"]

bordWidth = 1
normColour = "#cccccc"
bordColour = "#cd8b00"

addKeyBindings = [ ((mod4Mask .|. shiftMask, xK_z), spawn "slimlock")
                 , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
                 , ((0, xK_Print), spawn "scrot")
                 , ((0, 0x1008ff19), spawn "xbacklight -dec 10")
                 , ((0, 0x1008ff2e), spawn "xbacklight -inc 10")
--                 , ((0, 0x1008ff11), spawn "amixer set Master 5%-")
--                 , ((0, 0x1008ff12), spawn "amixer set Master toggle")
--                 , ((0, 0x1008ff13), spawn "amixer set Master 5%+ unmute")
--                 , ((mod4Mask .|. controlMask              , xK_plus ), sendMessage MagnifyMore)
--                 , ((mod4Mask .|. controlMask              , xK_minus), sendMessage MagnifyLess)
--                 , ((mod4Mask .|. controlMask              , xK_o    ), sendMessage ToggleOff  )
--                 , ((mod4Mask .|. controlMask .|. shiftMask, xK_o    ), sendMessage ToggleOn   )
--                 , ((mod4Mask .|. controlMask              , xK_m    ), sendMessage Toggle     )
                 ]

magnifyLayout = magnifier (Tall 1 (3/100) (1/2))

-------------------------

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ def
      { manageHook         = manageDocks <+> manageHook def
      , layoutHook         = avoidStruts $ layoutHook def --{layoutHook = magnifyLayout}
      , terminal           = myTerminal
      , modMask            = modKey
      , workspaces         = myWorkspaces
      , borderWidth        = bordWidth
      , normalBorderColor  = normColour
      , focusedBorderColor = bordColour
      } `additionalKeys` addKeyBindings


