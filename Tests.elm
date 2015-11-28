module Tests where

import ElmTest exposing (..)
import GameOfLife

all : Test
all =
  suite "Game of Life should"
    [
      test "make oscilate 3 cells" (
        assertEqual
          ([[0,0],[1,0],[2,0]] |> GameOfLife.tick |> GameOfLife.tick)
          [[0,0],[1,0],[2,0]]
      )
    ]
