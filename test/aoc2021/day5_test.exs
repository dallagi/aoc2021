defmodule Aoc2021.Day5Test do
  use ExUnit.Case, async: true

  @example_input """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  test "solves part1 for provided example" do
    assert 5 == Aoc2021.Day5.part1(@example_input)
  end

  test "solves part2 for provided example" do
    assert 12 == Aoc2021.Day5.part2(@example_input)
  end
end
