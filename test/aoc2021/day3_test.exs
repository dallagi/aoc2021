defmodule Aoc2021.Day3Test do
  use ExUnit.Case, async: true

  @example_input """
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
  """

  test "solves part1 for provided example" do
    assert 198 == Aoc2021.Day3.part1(@example_input)
  end

  test "solves part2 for provided example" do
    assert 230 == Aoc2021.Day3.part2(@example_input)
  end
end
