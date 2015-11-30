module GameOfLife where

import Set
import Grid
import Rules


type alias Cell =
  List Int

type alias Universe =
  List Cell

type alias Universe_Set =
  Set.Set Cell


tick : Universe -> Universe
tick universe =
  let
    grid : Universe_Set
    grid =
      Grid.dimensions universe
        |> Grid.grid
        |> Set.fromList
    universe_set =
      Set.fromList universe
    universe_and_void =
      List.map (neighbours grid) universe
        |> List.foldl Set.union Set.empty
    void_universe =
      Set.diff universe_and_void universe_set
        |> Set.toList
    live_universe_evolved =
      List.map (evolve_live universe_set grid) universe
    void_universe_evolved =
      List.map (evolve_dead universe_set grid) void_universe
  in
    List.append live_universe_evolved void_universe_evolved
      |> List.filter (\x -> x /= Nothing)
      |> List.map (\x -> Maybe.withDefault [] x)
      |> List.sort

neighbours : Universe_Set -> Cell -> Universe_Set
neighbours grid cell =
  Set.map (add cell) grid

add : Cell -> Cell -> Cell
add cell cell' =
  List.map2 (+) cell cell'

evolve_live : Universe_Set -> Universe_Set -> Cell -> Maybe Cell
evolve_live universe grid cell =
  let neighbors_count =
    count_live_cells_in_neighbourhood universe grid cell - 1
  in
    if Rules.cell_survives neighbors_count
      then Just cell
      else Nothing

count_live_cells_in_neighbourhood : Universe_Set -> Universe_Set -> Cell -> Int
count_live_cells_in_neighbourhood universe grid cell =
  neighbours grid cell
    |> Set.intersect universe
    |> Set.toList
    |> List.length

evolve_dead : Universe_Set -> Universe_Set -> Cell -> Maybe Cell
evolve_dead universe grid cell =
  let neighbors_count =
    count_live_cells_in_neighbourhood universe grid cell
  in
    if Rules.cell_appears neighbors_count
      then Just cell
      else Nothing
