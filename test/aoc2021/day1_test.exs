defmodule Aoc2021.Day1Test do
  use ExUnit.Case, async: true

  @example_input "199 200 208 210 200 207 240 269 260 263"

  test "solves part1 for provided example" do
    assert 7 == Aoc2021.Day1.part1(@example_input)
  end

  test "solves part2 for provided example" do
    assert 5 == Aoc2021.Day1.part2(@example_input)
  end
end
