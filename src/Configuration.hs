module Configuration where

import Types (PongGame(..), Radius)

ballRadius :: Radius
ballRadius = 10

width, height, offset :: Int
width = 300

height = 300

offset = 100

initialState :: PongGame
initialState =
  Game
    { ballLoc = (-10, 30)
    , ballVel = (150, -150)
    , player1 = 40
    , player2 = -80
    , paused = False
    , p1Moving = 0
    , p2Moving = 0
    }

paddleHeight, paddleWidth :: Float
paddleHeight = 86

paddleWidth = 26
