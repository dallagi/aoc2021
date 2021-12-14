defmodule Aoc2021.Day14Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day14

  @example_input """
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    """

  test "solves part1 for provided example" do
    assert 1588 == Day14.part1(@example_input)
  end

  test "solves part2 for provided example" do
    assert 2188189693529 == Day14.part2(@example_input)
  end
end
