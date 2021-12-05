defmodule Aoc2021.Day2Test do
  use ExUnit.Case, async: true

  @example_input """
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
  """

  test "solves part1 for provided example" do
    assert 150 == Aoc2021.Day2.part1(@example_input)
  end

  test "solves part2 for provided example" do
    assert 900 == Aoc2021.Day2.part2(@example_input)
  end
end
