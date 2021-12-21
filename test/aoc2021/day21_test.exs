defmodule Aoc2021.Day21Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Day21

  @example_input """
    Player 1 starting position: 4
    Player 2 starting position: 8
    """

  test "solves part1 for provided example" do
    assert 739785 == Day21.part1(@example_input)
  end

  test "solves part2 for provided example" do
    assert 444356092776315 == Day21.part2(@example_input)
  end
end
