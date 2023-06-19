{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances #-}

import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Decoration
import XMonad.Layout.Hidden
import XMonad.Layout.Spacing
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Types
import XMonad.Util.WorkspaceCompare

main :: IO ()
main = xmonad . ewmhFullscreen . docks
       . addEwmhWorkspaceSort (pure (filterOutWs ["NSP"])) 
       . ewmh $ customConf

customConf = def {
        workspaces = greekLetters,
        modMask = modm,
        borderWidth = 5,
        normalBorderColor = "#007070",
        focusedBorderColor = "#FF7400",
        manageHook = hooks,
        layoutHook = avoidStruts . (spacing 6) $
                     hiddenWindows (Tall 1 (3/100) (1/2)) 
                     ||| Full,
        terminal = "alacritty"
    }
    `additionalKeysP` [
        ("M-<Backspace>", withFocused hideWindow),
        ("M-S-<Backspace>", popNewestHiddenWindow),
        ("<XF86MonBrightnessUp>", spawn "xbacklight +5"),
        ("<XF86MonBrightnessDown>", spawn "xbacklight -5"),
        ("<XF86AudioRaiseVolume>", 
         spawn "pulsemixer --change-volume +1"),
        ("<XF86AudioLowerVolume>", 
         spawn "pulsemixer --change-volume -1"),
        ("M-v", namedScratchpadAction scratchpads "vim"),
        ("M-g", namedScratchpadAction scratchpads "ghci"),
        ("M-S-o", spawn "slock"),
        ("M-p", spawn "bash $HOME/.config/run-recent")
        -- screenshot
    ]
  where
    greekLetters = ["α","β","γ","δ","ε","ζ","η","θ","ι"]
    modm = mod4Mask

-- Hooks

hooks :: ManageHook
hooks = composeAll [
                     ifM (className =? "Gimp") idHook
                         (insertPosition Below Newer),
                     namedScratchpadManageHook scratchpads,
                     isFloatable --> doFloat
                   ]
  where
    isFloatable = (className =? "Gimp") <||> (className =? "Arandr")
                    <||> isDialog

-- Scratchpads

scratchpads = [
        NS "vim" "alacritty -t 'vim' -e 'vim'" (title =? "vim") smallCenter,
        NS "ghci" "alacritty -t 'ghci' -e 'ghci'" (title =? "ghci") smallCenter
    ]

smallCenter = customFloating $ W.RationalRect (1/3) (1/4) (1/3) (1/2)

-- Code for implementing the 'tripleBorder' function for making custom borders. Unfortunately, this turned out to be very buggy..
{-
data SideDecoration a = SideDecoration Direction2D deriving (Show, Read)

instance Eq a => DecorationStyle SideDecoration a where
    shrink b (Rectangle _ _ dw dh) (Rectangle x y w h)
        | SideDecoration U <- b = Rectangle x (y + fi dh) w (h - dh)
        | SideDecoration R <- b = Rectangle x y (w - dw) h
        | SideDecoration D <- b = Rectangle x y w (h - dh)
        | SideDecoration L <- b = Rectangle (x + fi dw) y (w - dw) h

    pureDecoration b dw dh _ st _ (win, Rectangle x y w h)
        | win `elem` W.integrate st && dw < w && dh < h = Just $ case b of
            SideDecoration U -> Rectangle x y w dh
            SideDecoration R -> Rectangle (x + fi (w - dw)) y dw h
            SideDecoration D -> Rectangle x (y + fi (h - dh)) w dh
            SideDecoration L -> Rectangle x y dw h
        | otherwise = Nothing

type BorderLayout l = ModifiedLayout (Decoration SideDecoration DefaultShrinker)
                        (ModifiedLayout (Decoration SideDecoration DefaultShrinker)
                        (ModifiedLayout (Decoration SideDecoration DefaultShrinker)
                        (ModifiedLayout (Decoration SideDecoration DefaultShrinker) l)))

singleBorder :: (Eq a, LayoutClass l a) => String -> String -> Dimension -> l a -> BorderLayout l a
singleBorder prim sec w = (decoration shrinkText theme (SideDecoration U))
                        . (decoration shrinkText theme (SideDecoration R))
                        . (decoration shrinkText theme (SideDecoration L))
                        . (decoration shrinkText theme (SideDecoration D))
  where
    theme = def {
            activeColor = prim,
            activeBorderColor = prim,
            activeTextColor = prim,
            inactiveColor = sec,
            inactiveBorderColor = sec,
            inactiveTextColor = sec,
            urgentColor = prim,
            urgentTextColor = prim,
            decoWidth = w,
            decoHeight = w
        }

tripleBorder = (singleBorder activeCol inactiveCol 2) 
             . (singleBorder activeMid inactiveMid 1)
	     . (singleBorder activeCol inactiveCol 5)
  where
    activeCol   = "#22CCFF"
    inactiveCol = "#BA4400"
    activeMid   = "#FFFFFF"
    inactiveMid = "#AAAAAA"
-}
