defmodule Aoc2021.Day13Test do
  use ExUnit.Case, async: true

  @example_input """
  6,10
  0,14
  9,10
  0,3
  10,4
  4,11
  6,0
  6,12
  4,1
  0,13
  10,12
  3,4
  3,0
  8,4
  1,10
  2,14
  8,10
  9,0

  fold along y=7
  fold along x=5
  """

  test "solves part1 for provided example" do
    assert 17 == Aoc2021.Day13.part1(@example_input)
  end
end
