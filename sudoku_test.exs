# run:
# elixir sudoku_test.exs

Code.load_file("sudoku.exs")
ExUnit.start

defmodule SudokuTest do
  use ExUnit.Case, async: true

  test "a small valid sudoku" do
    assert Sudoku.valid?([
      [1,4,  2,3],
      [3,2,  4,1],

      [4,1,  3,2],
      [2,3,  1,4]
    ])
  end

  test "floats are not accepted" do
    assert ! Sudoku.valid?([
      [1,4,  2,3.0],
      [3,2,  4,1],

      [4,1,  3,2],
      [2,3,  1,4]
    ])
  end

  test "negative numbers are not accepted" do
    assert ! Sudoku.valid?([
      [1,4,  2,3],
      [3,2,  -4,1],

      [4,1,  3,2],
      [2,3,  1,4]
    ])
  end


  test "only numbers are accepted" do
    assert ! Sudoku.valid?([
      [1,4,  2,3],
      [3,2,  :foo,1],

      [4,1,  "3",2],
      [2,3,  1,4]
      ])
  end

  test "all rows have the same length" do
    assert ! Sudoku.valid?([
      [1,4,  2,3],
      [3,2,  4,1,9],

      [4,1,  3,2],
      [2,3,  1,4]
    ])
  end

  test "N of columns == N of rows" do
    assert ! Sudoku.valid?([
      [1,4,  2,3],
      [3,2,  4,1],

      [4,1,  3,2],
      [2,3,  1,4],
      [5,6,  7,8]
      ] )
  end

  test "a bigger valid sudoku" do
    sudoku = [
      [7,8,4, 1,5,9, 3,2,6],
      [5,3,9, 6,7,2, 8,4,1],
      [6,1,2, 4,3,8, 7,5,9],

      [9,2,8, 7,1,5, 4,6,3],
      [3,5,7, 8,4,6, 1,9,2],
      [4,6,1, 9,2,3, 5,8,7],

      [8,7,6, 3,9,4, 2,1,5],
      [2,4,3, 5,6,1, 9,7,8],
      [1,9,5, 2,8,7, 6,3,4]
    ]
    assert Sudoku.valid?(sudoku)
  end

  test "uniqueness of numbers in rows, columns, and subsections" do
    assert ! Sudoku.valid?([
      [3,4,  2,1],
      [3,2,  4,1],

      [4,1,  3,2],
      [2,3,  1,4]
    ])
  end
end
