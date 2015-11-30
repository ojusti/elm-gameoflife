module Grid where

dimensions : List (List Int) -> Int
dimensions coordinates =
  List.head coordinates
    |> Maybe.withDefault []
    |> List.length

grid : Int -> List (List Int)
grid dimensions =
  let
    coordinates = digits 3
      >> List.reverse
      >> fixSize dimensions --add or remove 0s
      >> subtract 1
  in
    List.map coordinates [0..3^dimensions-1]
    |> List.sort

digits base number =
  let
    remainder = number%base
    quotient = number//base
  in
    if number == 0
      then [0]
      else remainder::digits base quotient

fixSize length list =
  let
    diff = length - List.length list
  in
    if diff == 0
      then list
      else if diff > 0
        then List.append (List.repeat diff 0) list
        else List.drop -diff list

subtract number list =
    List.map (\x -> x - 1) list
