defmodule Aoc2021.Day18Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day18
  import Aoc2021.Day18, only: [get_in_list: 2]

  @example_input ""

  test "solves part1 for provided example" do
    # assert nil == Day18.part1(@example_input)
  end

  test "solves part2 for provided example" do
    # assert nil == Day18.part2(@example_input)
  end

  test "determines which pair to explode" do
    pairs = [[[[[9, 8], 1], 2], 3], 4]
    assert [9, 8] == get_in_list(pairs, Day18.to_explode(pairs))

    pairs = [7, [6, [5, [4, [3, 2]]]]]
    assert [3, 2] == get_in_list(pairs, Day18.to_explode(pairs))

    pairs = [[6, [5, [4, [3, 2]]]], 1]
    assert [3, 2] == get_in_list(pairs, Day18.to_explode(pairs))
  end

  test "pairs nested inside four pairs are exploded" do
    # single explosion
    assert [[[[0, 9], 2], 3], 4] == Day18.reduce([[[[[9, 8], 1], 2], 3], 4])
    assert [7, [6, [5, [7, 0]]]] == Day18.reduce([7, [6, [5, [4, [3, 2]]]]])
    assert [[6, [5, [7, 0]]], 3] == Day18.reduce([[6, [5, [4, [3, 2]]]], 1])

    # multiple explosions
    assert [[3, [2, [8, 0]]], [9, [5, [4, [3, 2]]]]] ==
             Day18.reduce([[3, [2, [1, [7, 3]]]], [6, [5, [4, [3, 2]]]]])

    assert [[3, [2, [8, 0]]], [9, [5, [7, 0]]]] ==
             Day18.reduce([[3, [2, [8, 0]]], [9, [5, [4, [3, 2]]]]])
  end
end
