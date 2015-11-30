module Rules where


cell_survives neighbors =
  case neighbors of
    2 ->
      True
    3 ->
      True
    _ ->
      False


cell_appears neighbors =
  case neighbors of
    3 ->
      True
    _ ->
      False
