defmodule Aoc2021.Day10Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day10

  @example_input """
  [({(<(())[]>[[{[]{<()<>>
  [(()[<>])]({[<{<<[]>>(
  {([(<{}[<>[]}>{[]{[(<()>
  (((({<>}<{<{<>}{[]{[]{}
  [[<[([]))<([[{}[[()]]]
  [{[{({}]{}}([{[{{{}}([]
  {<[[]]>}<{[{[{[]{()[[[]
  [<(<(<(<{}))><([]([]()
  <{([([[(<>()){}]>(<<{{
  <{([{{}}[<[[[<>{}]]]>[]]
  """

  test "solves part1 for provided example" do
    assert 26397 == Day10.part1(@example_input)
  end

  test "solves part2 for provided example" do
    # assert nil == Day10.part2(@example_input)
  end
end
