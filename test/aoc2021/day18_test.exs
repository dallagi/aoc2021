defmodule Aoc2021.Day18Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day18
  import Aoc2021.Day18, only: [get_in_list: 2]

  @example_input """
    [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
    [[[5,[2,8]],4],[5,[[9,9],0]]]
    [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
    [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
    [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
    [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
    [[[[5,4],[7,7]],8],[[8,3],8]]
    [[9,3],[[9,9],[6,[4,9]]]]
    [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
    [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
    """

  test "solves part1 for provided example" do
    assert 4140 == Day18.part1(@example_input)
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

  test "determines which number to split" do
    pairs = [[[[0, 7], 4], [15, [0, 13]]], [1, 1]]
    assert 15 == get_in_list(pairs, Day18.to_split(pairs))
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

  test "handles both explosions and splits" do
    assert [[[[0, 7], 4], [[7, 8], [6, 0]]], [8, 1]] ==
             Day18.reduce([[[[[4, 3], 4], 4], [7, [[8, 4], 9]]], [1, 1]])
  end

  test "sums two numbers" do
    assert [[[[4, 0], [5, 4]], [[7, 7], [6, 0]]], [[8, [7, 7]], [[7, 9], [5, 0]]]] ==
             Day18.sum(
               [[[0, [4, 5]], [0, 0]], [[[4, 5], [2, 6]], [9, 5]]],
               [7, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]]
             )
  end

  test "calculates magnitude" do
    assert 3488 == Day18.magnitude([[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]])
  end
end
