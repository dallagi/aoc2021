defmodule Aoc2021.Day6Test do
  use ExUnit.Case, async: true

  @example_input "3,4,3,1,2"

  test "solves part1 for provided example" do
    assert 5934 == Aoc2021.Day6.part1(@example_input)
  end

  test "solves part2 for provided example" do
    # assert nil == Aoc2021.Day6.part2(@example_input)
  end
end
