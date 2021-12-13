defmodule Aoc2021.Day9Test do
  use ExUnit.Case, async: true

  @example_input """
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
  """

  test "solves part1 for provided example" do
    assert 15 == Aoc2021.Day9.part1(@example_input)
  end

  test "solves part2 for provided example" do
    assert 1134 == Aoc2021.Day9.part2(@example_input)
  end
end
