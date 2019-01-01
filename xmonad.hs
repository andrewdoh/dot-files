-- File: SideSpacing.hs
-- Based on Xmonad.Layout.Spacing created by Brent Yorgey
{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Grid
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import Graphics.X11 (Rectangle(..))
import Control.Arrow (second)
import XMonad.Util.Font (fi)

import XMonad.Layout.LayoutModifier
import System.IO


main = do
   xmproc <- spawnPipe "xmobar"

   xmonad $ defaultConfig
    { terminal    = "xterm"
    , modMask     = mod4Mask
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts $ myLayoutHook
    , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
    , logHook = dynamicLogWithPP xmobarPP
    {
      ppOutput = hPutStrLn xmproc
    , ppTitle = xmobarColor "green" "" . shorten 50
    }
    

    }

-- | Surround all windows by a certain number of pixels of blank space.
sideSpacing :: Int -> l a -> ModifiedLayout SideSpacing l a
sideSpacing p = ModifiedLayout (SideSpacing p)

data SideSpacing a = SideSpacing Int deriving (Show, Read)

instance LayoutModifier SideSpacing a where

    pureModifier (SideSpacing p) _ _ wrs = (map (second $ shrinkRect p) wrs, Nothing)

    modifierDescription (SideSpacing p) = "Side Spacing " ++ show p

shrinkRect :: Int -> Rectangle -> Rectangle
shrinkRect p (Rectangle x y w h) = Rectangle (x+fi p) (y) (w-2 * fi p) (h)


myLayoutHook = centered ||| tiled ||| full ||| Grid
               where
                 centered = sideSpacing 175 $ Full
                 tiled = spacing 2 $ Tall nmaster delta ratio
                 full = spacing 0 $ noBorders Full
                 -- The default number of windows in the master pane
                 nmaster = 1
                 -- Default proportion of screen occupied by master pane
                 ratio = 5/8
                 -- Percent of screen to increment by when resizing panes
                 delta = 1/20

