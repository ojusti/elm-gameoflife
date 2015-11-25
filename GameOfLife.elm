import Set
import Graphics.Element exposing (show)

type alias Cell =
  List Int

type alias Universe =
  List Cell

type alias Universe_Set =
  Set.Set Cell


tick : Universe -> Universe
tick universe =
  let
    universe_set =
      Set.fromList universe
    universe_and_void =
      List.map neighbours universe
        |> List.foldl Set.union Set.empty
    void_universe =
      Set.diff universe_and_void universe_set
        |> Set.toList
    live_universe_evolved =
      List.map (evolve_live universe_set) universe
    void_universe_evolved =
      List.map (evolve_dead universe_set) void_universe
  in
    List.append live_universe_evolved void_universe_evolved
      |> List.filter (\x -> x /= Nothing)
      |> List.map (\x -> Maybe.withDefault [] x)
      |> List.sort


neighbours : Cell -> Universe_Set
neighbours cell =
  Set.map (add cell) deltas

deltas : Universe_Set
deltas =
  Set.fromList [0..8]
    |> Set.map (\x -> [x//3-1, x%3-1])

add : Cell -> Cell -> Cell
add cell cell' =
  List.map2 (+) cell cell'

evolve_live : Universe_Set -> Cell -> Maybe Cell
evolve_live universe cell =
  case count_live_cells_in_neighbourhood universe cell - 1 of
    2 ->
      Just cell
    3 ->
      Just cell
    _ ->
      Nothing

count_live_cells_in_neighbourhood : Universe_Set -> Cell -> Int
count_live_cells_in_neighbourhood universe cell =
  neighbours cell
    |> Set.intersect universe
    |> Set.toList
    |> List.length

evolve_dead : Universe_Set -> Cell -> Maybe Cell
evolve_dead universe cell =
  case count_live_cells_in_neighbourhood universe cell of
    3 -> Just cell
    _ -> Nothing

main =
  tick [[0,0],[1,0],[2,0]]
    |> tick
    |> show
