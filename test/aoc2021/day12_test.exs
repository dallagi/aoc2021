defmodule Aoc2021.Day12Test do
  use ExUnit.Case, async: true

  @example_input """
  start-A
  start-b
  A-c
  A-b
  b-d
  A-end
  b-end
  """

  test "solves part1 for provided example" do
    assert 10 == Aoc2021.Day12.part1(@example_input)
  end

  test "solves part1 for larger provided example" do
    input = """
    dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc
    """

    assert 19 == Aoc2021.Day12.part1(input)
  end

  test "solves part2 for provided example" do
    # assert nil == Aoc2021.Day12.part2(@example_input)
  end
end
