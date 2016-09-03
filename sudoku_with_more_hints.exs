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

    x_equals_y?(sudoku, dimension) &&
      valid_subgrid_dimensions?(dimension, subgrid_dimension) &&
      all_positive_numbers?(sudoku)  &&
      valid_rows?(sudoku, dimension) &&
      valid_columns?(sudoku, dimension) &&
      valid_subgrid?(sudoku, round(subgrid_dimension), dimension)
  end

  defp valid_subgrid_dimensions?(dimension, subgrid_dimension) do
    round(subgrid_dimension * subgrid_dimension) == dimension
  end

  defp numbers_uniq?(integers, integer_count) do
    integers |> MapSet.new |> MapSet.size == integer_count
  end

  defp all_numbers_are_equal?(integers) do
    integers
    |> Enum.reduce_while(nil,
      fn
        (x, nil) -> {:cont, x} # first element
        (x, x)   -> {:cont, x} # current and previous ints are the same
        (_, _)   -> {:halt, false}
      end
    )
  end

  # [
  #   [1,2,  3,4],
  #   [5,6,  7,8],

  #   [9,1,  2,3],
  #   [4,5,  6,7]
  # ]
  #
  # ===>
  #
  # [[1,2,5,6], [3,4,7,8], [9,1,4,5], [2,3,6,7]]
  defp get_subgrids(sudoku, subgrid_dimension) do
    sudoku
    |> Enum.map(fn row ->
      row |> Enum.chunk(subgrid_dimension)
    end)
    |> rotate_list_of_lists([])
    |> Enum.flat_map(fn section_column ->

      section_column
      |> Enum.chunk(subgrid_dimension)
      |> Enum.map(fn chunk ->
        List.flatten(chunk)
      end)
    end)
  end


  # 1,2,3,4
  # 5,6,7,8
  # 9,0,3,2
  # 2,3,1,4
  #
  #  ===>
  #
  # 1,5,9,2
  # 2,6,0,3
  # 3,7,3,1
  # 4,8,2,4

  # instead of using  inefficient :lists.nth(3, [4,5,6,7,8] )
  # I use pattern matching on lists ;-)
  defp rotate_list_of_lists([[]|_], columns), do: Enum.reverse(columns)

  defp rotate_list_of_lists(rows, columns) do
    {column, remaining_rows} = rows
    |> Enum.map(fn [ head | tail] -> {head, tail} end)
    |> Enum.unzip

    rotate_list_of_lists(remaining_rows, [column | columns])
  end
end
