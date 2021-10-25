module Types where

data PongGame =
  Game
    { ballLoc :: (Float, Float)
    , ballVel :: (Float, Float)
    , player1 :: Float
    , player2 :: Float
    , paused :: Bool
    , p1Moving :: Float
    , p2Moving :: Float
    }
  deriving (Show)

type Radius = Float

type Position = (Float, Float)
