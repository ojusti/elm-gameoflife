module Tests where

import ElmTest exposing (..)
import GameOfLifeTest
import GridTest

all : Test
all =
  suite "all tests"
    [
      GridTest.all
      , GameOfLifeTest.all
    ]
