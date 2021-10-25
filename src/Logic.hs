module Logic where

import Configuration (ballRadius, height, paddleHeight, paddleWidth, width)
import Types (PongGame(..), Position, Radius)

moveBall :: Float -> PongGame -> PongGame
moveBall seconds game@Game {ballLoc = (x, y), ballVel = (vx, vy)} =
  game {ballLoc = (x', y')}
  where
    x' = x + vx * seconds
    y' = y + vy * seconds

wallColision :: Position -> Radius -> Bool
wallColision (_, y) radius = topCollision || bottomCollision
  where
    topCollision = y - radius <= -fromIntegral width / 2
    bottomCollision = y + radius >= fromIntegral width / 2

wallBounce :: PongGame -> PongGame
wallBounce game@Game {ballVel = (vx, vy)} = game {ballVel = (vx, vy')}
  where
    vy' =
      if wallColision (ballLoc game) ballRadius
        then -vy
        else vy

paddleCollision :: PongGame -> Radius -> Bool
paddleCollision game radius = p1Collision || p2Collision
  where
    p1x = 120
    p1y = player1 game
    p2x = -120
    p2y = player2 game
    (x, y) = ballLoc game
    p1Collision =
      abs (p1x - x) <= radius + paddleWidth / 2 &&
      abs (p1y - y) <= radius + paddleHeight / 2
    p2Collision =
      abs (p2x - x) <= radius + paddleWidth / 2 &&
      abs (p2y - y) <= radius + paddleHeight / 2

paddleBounce :: PongGame -> PongGame
paddleBounce game@Game {ballVel = (vx, vy)} = game {ballVel = (vx', vy)}
  where
    vx' =
      if paddleCollision game ballRadius
        then -vx
        else vx

movePaddles :: Float -> PongGame -> PongGame
movePaddles seconds game = game {player1 = p1', player2 = p2'}
  where
    p1 = player1 game
    p2 = player2 game
    p1M = p1Moving game
    p2M = p2Moving game
    p1' = clamp minHeight maxHeight (p1 + paddleSpeed * p1M)
    p2' = clamp minHeight maxHeight (p2 + paddleSpeed * p2M)
    paddleSpeed = 100 * seconds
    maxHeight = (fromIntegral height - paddleHeight) / 2
    minHeight = -maxHeight

clamp :: Ord a => a -> a -> a -> a
clamp lo hi n = max (min hi n) lo

checkOutOfBounds :: PongGame -> PongGame
checkOutOfBounds game@Game {ballLoc = (x, _)}
  | x >= p1Boundary = error "Player 2 wins!"
  | x <= p2Boundary = error "Player 1 wins!"
  | otherwise = game
  where
    p1Boundary = fromIntegral width / 2
    p2Boundary = -p1Boundary

update :: Float -> PongGame -> PongGame
update seconds game
  | paused game = game
  | otherwise =
    updateAI .
    checkOutOfBounds .
    paddleBounce . wallBounce . moveBall seconds . movePaddles seconds $
    game

updateAI :: PongGame -> PongGame
updateAI game@Game {player1 = myY, ballLoc = (_, ballY)} =
  game {p1Moving = direction}
  where
    direction
      | myY > ballY = -1
      | myY < ballY = 1
      | otherwise = 0
