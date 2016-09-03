# Traditionally Sudoku is a 9×9 grid nine 3×3 subgrids that compose the grid:
#
#    7,8,4,  1,5,9,  3,2,6
#    5,3,9,  6,7,2,  8,4,1
#    6,1,2,  4,3,8,  7,5,9
#
#    9,2,8,  7,1,5,  4,6,3
#    3,5,7,  8,4,6,  1,9,2
#    4,6,1,  9,2,3,  5,8,7
#
#    8,7,6,  3,9,4,  2,1,5
#    2,4,3,  5,6,1,  9,7,8
#    1,9,5,  2,8,7,  6,3,4
#
# Let's broaden the game to include grids, such as, given that the grid is A×A,
# it contains A subgrids of B×B, and B is the square root of A.
# Example of valid grids: 4 by 4 with 4 subgrids each subgrid 2 by 2:
#
#    1,4,  2,3
#    3,2,  4,1
#
#    4,1,  3,2
#    2,3,  1,4
#
# Write a function which validates such a grid:
#
# * The grid has the right dimension to allow for the right number of subgrids
# * All items are positive integer numbers more than 0
# * Numbers in all rows do not repeat
# * Numbers in all columns do not repeat
# * Numbers in all subgrids do not repeat
# * Sums of numbers in each row are equal
# * Sums of numbers in each column are equal
# * Sums of numbers in each subgrid are equal


defmodule Sudoku do

  def valid?(sudoku) do
    dimension = length(sudoku)
    subgrid_dimension = :math.sqrt(dimension)
  end

end
