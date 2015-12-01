module Rules where


cell_survives neighbors =
  neighbors == 2 || neighbors == 3

cell_appears neighbors =
  neighbors == 3
