module GameOfLifeTest where

import ElmTest exposing (..)
import GameOfLife

all : Test
all =
  suite "Game of Life should"
  [
    test "make oscilate 3 cells" (
      assertEqual
        [[0,0],[1,0],[2,0]]
        ([[0,0],[1,0],[2,0]] |> GameOfLife.tick |> GameOfLife.tick)
    ),
    test "order cells in universe by coordinates" (
      assertEqual
        [[0,0],[0,1],[1,-1],[1,0],[1,1],[2,0],[2,1]]
        (GameOfLife.tick [[0,0],[1,0],[2,0],[1,1]])
    ),
    test "allow 3d life" (
      assertEqual
       [[-1,-1,0],[-1,0,0],[-1,1,0],[0,-1,0],[0,0,0],[0,1,0],[1,-1,0],[1,0,0],[1,1,0]]
       (GameOfLife.tick [[0,0,-1],[0,0,0],[0,0,1]])
    )
  ]
