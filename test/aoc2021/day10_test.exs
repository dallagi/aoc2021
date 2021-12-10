defmodule Aoc2021.Day10Test do
  use ExUnit.Case, async: true

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

  test "calculates syntax score for line" do
    example1 = String.split("{([(<{}[<>[]}>{[]{[(<()>", "", trim: true)
    assert 1197 == Aoc2021.Day10.line_syntax_score(example1)

    example2 = String.split("[[<[([]))<([[{}[[()]]]", "", trim: true)
    assert 3 == Aoc2021.Day10.line_syntax_score(example2)
  end

  test "solves part1 for provided example" do
    assert 26397 == Aoc2021.Day10.part1(@example_input)
  end

  test "solves part2 for provided example" do
    # assert nil == Aoc2021.Day10.part2(@example_input)
  end
end
