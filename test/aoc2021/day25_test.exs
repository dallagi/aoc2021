defmodule Aoc2021.Day25Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day25

  @example_input """
  v...>>.vv>
  .vv>>.vv..
  >>.>v>...v
  >>v>>.>.v.
  v>v.vv.v..
  >.>>..v...
  .vv..>.>v.
  v.v..>>v.v
  ....v..v.>
  """

  test "solves part1 for provided example" do
    assert 58 == Day25.part1(@example_input)
  end

  test "solves part2 for provided example" do
    # assert nil == Day25.part2(@example_input)
  end

  test "moves sea cucumbers correctly" do
    expected = """
    ....>.>v.>
    v.v>.>v.v.
    >v>>..>v..
    >>v>v>.>.v
    .>v.v...v.
    v>>.>vvv..
    ..v...>>..
    vv...>>vv.
    >.v.v..v.v
    """

    assert String.trim(expected) ==
             @example_input |> Day25.parse() |> Day25.move() |> Day25.render()
  end

  test "moves works for multiple turns" do
    expected = """
    vv>...>v>.
    v.v.v>.>v.
    >.v.>.>.>v
    >v>.>..v>>
    ..v>v.v...
    ..>.>>vvv.
    .>...v>v..
    ..v.v>>v.v
    v.v.>...v.
    """

    assert String.trim(expected) ==
             @example_input
             |> Day25.parse()
             |> Day25.move()
             |> Day25.move()
             |> Day25.move()
             |> Day25.move()
             |> Day25.move()
             |> Day25.render()
  end
end
