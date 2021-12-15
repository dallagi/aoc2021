defmodule Aoc2021.Day15Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day15

  @example_input """
  1163751742
  1381373672
  2136511328
  3694931569
  7463417111
  1319128137
  1359912421
  3125421639
  1293138521
  2311944581
  """

  test "solves part1 for provided example" do
    assert 40 == Day15.part1(@example_input)
  end

  test "solves part2 for provided example" do
    assert 315 == Day15.part2(@example_input)
  end
end
