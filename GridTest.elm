module GridTest where

import ElmTest exposing (..)
import Grid

all : Test
all =
  suite "Grid should"
  [
    test "correctly compute 2D grid around origin"
      (assertEqual [[-1,-1],[-1,0],[-1,1],
                    [ 0,-1],[ 0,0],[ 0,1],
                    [ 1,-1],[ 1,0],[ 1,1]]
                   (Grid.grid 2))
  ]
