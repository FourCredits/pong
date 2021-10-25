module Main where

import Graphics.Gloss ( play )

import Rendering ( background, fps, render, window )
import UserInteraction ( handleKeys )
import Configuration ( initialState )
import Logic ( update )

main :: IO ()
main = play window background fps initialState render handleKeys update
