defmodule Aoc2021.Day7Test do
  use ExUnit.Case, async: true

  @example_input "16,1,2,0,4,2,7,1,2,14"

  test "solves part1 for provided example" do
    assert 37 == Aoc2021.Day7.part1(@example_input)
  end

  test "solves part2 for provided example" do
    assert 168 == Aoc2021.Day7.part2(@example_input)
  end
end
