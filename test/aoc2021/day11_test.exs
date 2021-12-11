defmodule Aoc2021.Day11Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day11

  @example_input """
  5483143223
  2745854711
  5264556173
  6141336146
  6357385478
  4167524645
  2176841721
  6882881134
  4846848554
  5283751526
  """

  test "solves part1 for provided example" do
    assert 1656 == Day11.part1(@example_input)
  end

  test "solves part2 for provided example" do
    assert 195 == Day11.part2(@example_input)
  end
end
