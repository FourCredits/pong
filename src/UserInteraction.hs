module UserInteraction where

import Graphics.Gloss.Interface.Pure.Game
  ( Event(EventKey)
  , Key(Char)
  , KeyState(Down, Up)
  )
import Types (PongGame(Game, ballLoc, p2Moving, paused))

handleKeys :: Event -> PongGame -> PongGame
handleKeys (EventKey (Char 's') Down _ _) game = game {ballLoc = (0, 0)}
handleKeys (EventKey (Char 'p') Down _ _) game@Game {paused = p} =
  game {paused = not p}
-- uncomment for 2 player game
-- handleKeys (EventKey (SpecialKey KeyUp) Down _ _) game = game {p1Moving = 1}
-- handleKeys (EventKey (SpecialKey KeyUp) Up _ _) game = game {p1Moving = 0}
-- handleKeys (EventKey (SpecialKey KeyDown) Down _ _) game = game {p1Moving = (-1)}
-- handleKeys (EventKey (SpecialKey KeyDown) Up _ _) game = game {p1Moving = 0}
handleKeys (EventKey (Char 'w') Down _ _) game = game {p2Moving = 1}
handleKeys (EventKey (Char 'w') Up _ _) game = game {p2Moving = 0}
handleKeys (EventKey (Char 'a') Down _ _) game = game {p2Moving = -1}
handleKeys (EventKey (Char 'a') Up _ _) game = game {p2Moving = 0}
handleKeys _ game = game
